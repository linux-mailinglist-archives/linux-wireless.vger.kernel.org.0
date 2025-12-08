Return-Path: <linux-wireless+bounces-29604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F92CAE213
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 21:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 806423026ACE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 20:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E333D76;
	Mon,  8 Dec 2025 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeEIS0G7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5A020298D
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765224294; cv=none; b=bR7UVJ3mGx+7FwP5eKqq2AvYzAWZUSFSS1H17OxkZ2VI6oxJZQWpmgJ8HcVT5RUNpNxccJ/lPXHGIyUWX8Wu5GMNKs2fKoYJlYod+acH1l7Arr1zY7kiqbM06g5LsGwsvmpQk9Pd/rRzz7m/t0fh7if6fTrfg1rMuf+qvfZwYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765224294; c=relaxed/simple;
	bh=skKjEfBaMU6Lqt5vjsIobNng9NkDUQtxDFU5ZUjwvRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SvwpyaI23Xl2k3Zlw/Hd1tRQM3n+AFsHG0GKS25pChvfZ0gXU+jaiVkBooZbAEOx1jbbGUruuqMC8tuwjSq7TvsBHcVhVtF/UptO4ibgMfzvFzr/S+TuQivG3rYvcqHy60K9piTe2vH9xGqGxz+fRllTxija6ik8gU1ZaNVQG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeEIS0G7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso24311405e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 12:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765224291; x=1765829091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9WaSQQ0PkGqeHp9LL2kJRaAe2H4lpRnuEoZ98r23rw=;
        b=MeEIS0G7PiMgjbTOTLGE6XhhpJGtxjfb37lIXHx8l1yWXKyfcRu7DTqlNUR6T225Vk
         vOjbrWKOfZPeUSIr+mbYGZbRAUlCJUoo1SWWZHm2CjpAYUMXy/HDI1wK+3m5pfKqSzLZ
         kYmPGgsTku7Q8Yf3Lr2YOT9yhIE2pbqVzrpX+zjLlkt8Xw08+30/muL3qx8adXiTcpxv
         f9NYz7iIFI0CYwicFBCarscDQyM4CZ/Vk+DkRdygPDIKorAym6JtXna46bgjEyyudtHY
         I/u9EVhO+Q7o6mb6v2+LWmfw72JI95MLKyBag2tD/nZOWYWEK4Hs6R8MBTIwpdKBrPQL
         nxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765224291; x=1765829091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9WaSQQ0PkGqeHp9LL2kJRaAe2H4lpRnuEoZ98r23rw=;
        b=c80idKMaqomoC/taJ88v5/n23YpVWW7X43qrA1OFBGVc6ZHgzvuisOHe4Ww5AuUWeh
         yc4geM0rbFJdNtc98pQ5DCyprSGvzO84XA6Y3yVfDRd++GsLIZ7DMBAD079Z1+SKKcHA
         /KuUeIPXR0C3bCaeI1NkAcFsixc7tqzu86GN4jNs0LfaiQCUhPDsmVT1N4leJBlAUztb
         GqdskCyFR4MnpXeAEqShYFajubwEz0a5WbygTs3Yd2z3bO2KZkiS6UPdv3cyPhg2/5d4
         rNvLANjam9LCPH78zTKsVUE4HuVg6bXx4RHV4oI+1VgnIIVD7NqvjXyyBaiL8TNmemr8
         2RAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHAxjgfA07SoDPI7BuSdOwiyRCkT09OvrX9DTAhvNrqXrC2QXLxA/NnYSGDgde06Uv25MHIEVnDJeTO5U+5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFoWl0K0KV2SZ+QI5UcQiBE8aB+eCg9z2RzmTlB++Uw/8JFaWJ
	A90KrLadBaMNwNn2R0Pk2uu5SGXXe14/qwgqfUZLv5xyuSa/oDjqQ4+O
X-Gm-Gg: ASbGnctkATfAOlypCMeVxhWvBt0A/+NkXWpYxfsaQSJVZNHXGxBzC5Vqe9xRvUK8TqI
	8CFPEjv13sYxP4upDUYOZtFmO+/0zFqivDpGezt5Ex6ZtvYZXCU1hB6/xfVpaC+q6zmaqYcPijf
	+vFaqeGVdYDam5MAoMP4C2Lr/lEpIiYD6iSE/6QDqXTrvRDIB+yxYzYnTny1iQwlB+ahk2ndrht
	uau5peZpnBmI86P+IzuOjEzmF/hRMU2G9ReEhBjdgZ+82HpucEM4w+EiD2RiQRgzjXHj0Aaeu1+
	CrirHptCJLIuUWQPRysyARRI6WKUD0puWIDlhIDOITuvFklGLNDiix1lRvPoqf9dAgXBoQMND0x
	BdCaydWay53y15Y0CxirOoyKD4ng2rYcFwYk+O1MRZXbFm/eiYvyKmKU72lWpzOqDIgkBFezLrv
	LjjwDPW4/sCmNXx0Jp0/f2BcakqY7oqjvbuGaHcsMGexxgkvX3fH4=
X-Google-Smtp-Source: AGHT+IELJ4QWyLI18G+CslWw8CT4fzH53HDJS5AGtq1akWXecKkPf5nz0AOnRqyw1ggDtLTR6UltQg==
X-Received: by 2002:a05:600c:3b8b:b0:477:af07:dd17 with SMTP id 5b1f17b1804b1-47939e3897cmr134757755e9.24.1765224290994;
        Mon, 08 Dec 2025 12:04:50 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a7d6eb1f1sm1906885e9.2.2025.12.08.12.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 12:04:50 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [net PATCH] wifi: ath11k: fix wrong usage of resource_size() causing firmware panic
Date: Mon,  8 Dec 2025 21:04:32 +0100
Message-ID: <20251208200437.14199-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On converting to the of_reserved_mem_region_to_resource() helper with
commit 900730dc4705 ("wifi: ath: Use
of_reserved_mem_region_to_resource() for "memory-region"") a logic error
was introduced in the ath11k_core_coldboot_cal_support() if condition.

The original code checked for hremote_node presence and skipped
ath11k_core_coldboot_cal_support() in the other switch case but now
everything is driven entirely on the values of the resource struct.

resource_size() (in this case) is wrongly assumed to return a size of
zero if the passed resource struct is init to zero. This is not the case
as a resource struct should be always init with correct values (or at
best set the end value to -1 to signal it's not configured)
(the return value of resource_size() for a resource struct with start
and end set to zero is 1)

On top of this, using resource_size() to check if a resource struct is
initialized or not is generally wrong and other measure should be used
instead.

To better handle this, use the DEFINE_RES macro to initialize the
resource struct and set the IORESOURCE_UNSET flag by default.

Replace the resource_size() check with checking for the resource struct
flags and check if it's IORESOURCE_UNSET.

This change effectively restore the original logic and restore correct
loading of the ath11k firmware (restoring correct functionality of
Wi-Fi)

Cc: stable@vger.kernel.org
Fixes: 900730dc4705 ("wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"")
Link: https://lore.kernel.org/all/20251207215359.28895-1-ansuelsmth@gmail.com/T/#m990492684913c5a158ff0e5fc90697d8ad95351b
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index ff6a97e328b8..afa663c00620 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2039,8 +2039,8 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 
 static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 {
+	struct resource res = DEFINE_RES(0, 0, IORESOURCE_UNSET);
 	struct device *dev = ab->dev;
-	struct resource res = {};
 	u32 host_ddr_sz;
 	int i, idx, ret;
 
@@ -2086,7 +2086,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			}
 
 			if (ath11k_core_coldboot_cal_support(ab)) {
-				if (resource_size(&res)) {
+				if (res.flags != IORESOURCE_UNSET) {
 					ab->qmi.target_mem[idx].paddr =
 							res.start + host_ddr_sz;
 					ab->qmi.target_mem[idx].iaddr =
-- 
2.51.0


