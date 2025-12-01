Return-Path: <linux-wireless+bounces-29436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6010C957C3
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 02:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6798B341B5E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 01:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E861E5B94;
	Mon,  1 Dec 2025 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpwWlrgb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0507E110
	for <linux-wireless@vger.kernel.org>; Mon,  1 Dec 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764551763; cv=none; b=Qb+NfF3BIYj6EAiLe2HLkry/I/VUnB0AYiR3H97KhzVtHRGCesznlt3/Kua0cFVaYBpmXITrdB5/LiV3MwKjYtiFlQls73vqRKetaPn+FpYlfzfl9N2/XUJ0+LjrjQWOGpGCCniuIzeZVU3oGjINW5KbDIZpudLSNW8bk8ULe0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764551763; c=relaxed/simple;
	bh=kL8pNkspxY32oK4P0WLuxKf2uxEIHREei2L7z0gtL1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaINlZKgpOxB7S5XlEMseaqrNrDWKzqFdmvc3pXd0+x0VKXX2RXzlFuwYSkIoAEmJ/l49t314QjX1CL0AuCmEpcNyoeLDujWqiE9WjOl2bqIt91F56sZ1HAwkhdP1VagbipibfxAMRwKtmnhGZJzjaOyBZh45tSVdZYXPfT0Vns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpwWlrgb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477aa218f20so22748145e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Nov 2025 17:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764551760; x=1765156560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo4q7JKeuUk4aiyRFRdMebz2WrMLhSzb/XBqsXZtV5s=;
        b=FpwWlrgb1NK+V4xlebIacjrffG+K7cxx4Wl85nlpZiTHoQpTWSMb38ZvXvOXW0/8DM
         UMaOrD0M2njM4PBCbZetcxcL5b4Qcn0mdjz1WMjt5UkMpKbkFJKJCshTeM9HEADvYDug
         8Z8gWz2IWFutDXRNNrAPrquPkr2d/YCR27okvc21xeNH36yKWeoldF4sLZvkN6EKKMMI
         m6jVkq0+Xnbe0+FG9gG2lADinoCKAJn2TmerOavym67PrDYraipT/nZ9SFbrXu4U+Xz/
         YM305YvbmGOlyjrA8PIuowLeHtNls6o1lwg6I9rNoUPJAu4MDg3NqrE0/6VRBDGTkMNJ
         6HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764551760; x=1765156560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mo4q7JKeuUk4aiyRFRdMebz2WrMLhSzb/XBqsXZtV5s=;
        b=iP6tV+IYc2e1H6m49ciqu5GSNBSv3U+5EvgX3oiSOO+u9pooUVbn21dWX9aeDpU1OC
         up9ypaerMRkXwHLB1O2bXxlrww/ykS8yE9yuPzcFiiFJ3xfp8CtDp01ZSe8qbDWjxSjU
         t+M8Vn6tL1WlIv566McZFiKVLMzN6SUt9bF3RjXR1To2r+rtAYUs6ieL38yQojJl9qoU
         U8vEjTlHUmUvL64f7Qho3olsiagJNimweqUIrG4Lu32krhsGDbTtreiTEcjIFfJm6rHM
         H+5O1yMT7Gge4abiC6J/FeOwzWgCJCCN7D/g2dEm4ktM/RgkyqHSuWr8lmJ4fIwemUG0
         aIIw==
X-Forwarded-Encrypted: i=1; AJvYcCWaEvi+ICK8zjq/k9h1Vw3QiXWCEHSs9Q9Pof9y5CAG4DOqGIGVrriCg2eJg8mbrvoEpdw1K7dyj7T0H2jpKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26VF22tur0BR6u43YIGXjJxjswR0SKLJ/AyWhK/asF+q1sCF8
	HcJ2taMKGtq2EuAmOtCVamOQl9BAkq1YeI8dmibWoRIXEmb/BQf1Tiyh
X-Gm-Gg: ASbGnctvPBMkO6HPUHqQgKFZxNQaMScvzGWDKn0oYgljqcbZWG1TtMHPH76N9l2LsZ7
	U8wPPSF3hCj8ala+N5VSnZtyZGfbclnU2kgHz++GktKyN2h8O+Mj3xnvxTbboTz2D8cBf/BKWrK
	f2O4y59sJmQHGFQ9/fgBrgvt1T0PVp4Or+ewZ72hh2Wbx4GP60N2mKwUqQQjWUakWO+lK1Ew4TY
	YUL5BoNQTqEohEB1C+qYaYvUfNw+nlcBqNdoRqx/CTzEfmYV3dU9kCVWpe4kR+W4ePcSZP6jY0G
	YLv3ehoQo0JXu8V15xa8BYkfxzScdEQ6SMeMDFJXdro2gy7CUPXsVtvR6vOa7dpQXhHf1KFvO+u
	4iPlgQ+vle2zQ1CH6SLd+vEaoRaCSlrgMBiYj9fBM/gYyln+wbItVeY/HAbAkIv0MHBzRcSZndb
	NT+2zdKtC3EbnXlp40laLKpf067Mea5c1uxJFued+mF4fuyBHG24Rwzw==
X-Google-Smtp-Source: AGHT+IH5rUuYD4eqKwAK50niTL5lsEFRsaD9OQ4iOSbw+TFAzVIVsM+nWiZuPk0ZntcRHhpGuzcYRQ==
X-Received: by 2002:a05:600c:450f:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-477c01eb9bdmr404432425e9.31.1764551759501;
        Sun, 30 Nov 2025 17:15:59 -0800 (PST)
Received: from alarm (92.40.200.0.threembb.co.uk. [92.40.200.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479110b6da9sm216152305e9.0.2025.11.30.17.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 17:15:59 -0800 (PST)
From: Dale Whinham <daleyo@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= <jerome.debretagne@gmail.com>,
	Dale Whinham <daleyo@gmail.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] wifi: ath12k: Add support for disabling rfkill via devicetree
Date: Mon,  1 Dec 2025 01:14:48 +0000
Message-ID: <20251201011457.17422-8-daleyo@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201011457.17422-1-daleyo@gmail.com>
References: <20251201011457.17422-1-daleyo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some devices (e.g. Microsoft Surface Pro 11) indicate that the rfkill
feature should be disabled by means of an ACPI bitflag.

If ACPI is not being used (i.e. booting using a devicetree) then this
property will not be read and therefore rfkill may be enabled and
the ath12k will be hard-blocked with no way to disable it.

Add a devicetree property that allows us to disable the rfkill feature.

Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Dale Whinham <daleyo@gmail.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 5d494c5cdc0d..954028495ea6 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -78,6 +78,9 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
 	if (ath12k_acpi_get_disable_rfkill(ab))
 		return 0;
 
+	if (of_property_read_bool(ab->dev->of_node, "disable-rfkill"))
+		return 0;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
 
-- 
2.52.0


