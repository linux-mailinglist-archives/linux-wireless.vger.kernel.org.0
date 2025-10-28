Return-Path: <linux-wireless+bounces-28344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD520C16493
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 18:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E91D5626E5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 17:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D834DB56;
	Tue, 28 Oct 2025 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="VF6Ns1kW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA734887B
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673439; cv=none; b=Z8m+eZobqj8qkP5R+gGbrjU5iHPStht/wYopcwb3R4tBXGe5ueW5sCNT2YkcLa9V5PkDnQJgAZhpCEB+u0OlEhZPemHsNhgmvTlN4ImISTCmr7er1wD4gaOU6AFUT+w6AIY0ieFeYJ3ThDB0E0S45IK+MTpp4AxSRfyKuB3bYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673439; c=relaxed/simple;
	bh=0bwjpb3oxZU8XGM4NxNdpBSzF6jrx93O+BlgTEXd45E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psMu8KfFeLvO6Az8n/Q7Vfr26i638nW99lIxFt/FiySEIglFm1tACLZSDmUXRJeGigbPYftOyvcT1VfAa7fGPccTq5QvEsNgxmzWjPzX26ZvvppJDc6JRCHyYUGC3EpOg/Px1voZhRle9+X1VqUxghnuTWBG2dCYkk0h0ZMB0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=VF6Ns1kW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so5533959a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761673434; x=1762278234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0qpkbmtmAPne10NIF9Jum+PYmUB8FRAdbJ18tTQPmQ=;
        b=VF6Ns1kWQErCawMzWz79FnujoEvchjAM/2WH60PcreDrAAC+NRmzRi380byQH5k0k2
         MRd3CLgdFURgLCdYQ20k9VsoqSFwUtrPonO847ArxgP95y61qhl62OHHAmwU/DFUnued
         P4J3T9cDFprxpS2OsGzPNw6sWz8KUAMfPIc1Z3krQkPjqZ74+p0CWYzo02E79ld0aFAl
         LAw48WyDLrKHYgAeHAfiaVYqVJvaw7IhoShEKBbTvVfup4TIFBgjQleqVOcU57nRfhnz
         /eThJnsKIq08feVDza98zsKw3UizxcV7p9VILEoCNKCkCzJ+LA2HFwX2GSxVlASuv/Ip
         cYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673434; x=1762278234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0qpkbmtmAPne10NIF9Jum+PYmUB8FRAdbJ18tTQPmQ=;
        b=cZetUxGCbILmGwXgEHp6WlBO5crlb86zXoHLsjzKq7BwGATRwS/jq6aX21IcmlcLX9
         XtQzDx1aX0yuLiy5x+aNANChrL598jrXCn9huk5cSDbC6LHmrGL69ZmDJbgwZQ4UbNpz
         p24axQCLlfSpNbyL1UEuPdkukmv1hDx9/d2q5GpjWNA/zUvVxEevUqRx9VJU6qboj5/L
         glH2dk0dIho+HCb987qq2CHcRN1B6ZAoUJwRKos82/jvtlu9E2AuJpa9kEnYbmmULtRY
         QWgHwtyP+NUA8ja9qqFwVK9fx7Zv8sExnPxaH7Fmgdvay48kp8WiBMfusSTsh9bZi6TD
         6Meg==
X-Gm-Message-State: AOJu0Yy8q3uKbZlAdgAVNy+OlX+7ye4woesrEv91C5RbgXXhBRVCa/Bl
	BcGFcMnsssemdeAumYtzmy4Rr8IMCaObCw+YyPv4j4eM5EeGbSQA4CE3Y9nl3wqRKIKF8kBgA1u
	3GIkOkg4=
X-Gm-Gg: ASbGnctF3/3X8qT8jumXOhMchsHoCUoGmVvmLWzsQhaPOt2PyM9G66RiCOKffcnsy+9
	53wFQqjj7/oUPU9Bs9D12YBXZwqXCjpS0uFZn2udGpNAEq/RIWwpoURaVR61LHF7kD7AVlIDNUx
	8HBjik6qe+LRLOKSs6giHfjPMeqMDmLcDddbsdXEggKPCVx2Mpnv841fmWKsQsRde+fOZzR38sf
	5yItwkDXLamV6GC9P1ojsvkPeApNJ5MlSZ8f/4gtQfvnZFsc3q4GJ9vpzWDc94natGY23NwNiEm
	nvthgJS1rYg8Ft2RiYErsse6Fx93nqNQv1pxOlOuF7PR4Y1P03iTZ0EXECBrbs9/syVepPHKlOY
	WEkanNDJqtcOh+2PP1fOo8kuCBTzeRtzlvDgYOBH1xrBk42U3wzVQmDXBApPx3OvsAb+MrlEx8B
	W3SDW1/YKvg9+pPl1Uwde2RCQ=
X-Google-Smtp-Source: AGHT+IHjSGUgQEqomu07pS1jduR1pgMItt8Lc6mHKJe9u9dK5Ny/DjdsS7jZxwcxklB8xXuRkgkFpQ==
X-Received: by 2002:a17:90b:58f0:b0:32e:2059:ee83 with SMTP id 98e67ed59e1d1-340279e5f8bmr5853372a91.7.1761673433797;
        Tue, 28 Oct 2025 10:43:53 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.46])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-340292c0d81sm1560989a91.3.2025.10.28.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:43:53 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: linux-wireless@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: zd1211rw: fix potential memory leak in __zd_usb_enable_rx()
Date: Tue, 28 Oct 2025 23:13:39 +0530
Message-ID: <20251028174341.139134-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for urbs with kcalloc() is not freed on any error
path. Fix that by freeing it in the error path.

Fixes: e85d0918b54f ("[PATCH] ZyDAS ZD1211 USB-WLAN driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index 2faa0de2a36e..8ee15a15f4ca 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -791,6 +791,7 @@ static int __zd_usb_enable_rx(struct zd_usb *usb)
 	if (urbs) {
 		for (i = 0; i < RX_URBS_COUNT; i++)
 			free_rx_urb(urbs[i]);
+		kfree(urbs);
 	}
 	return r;
 }
-- 
2.43.0


