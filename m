Return-Path: <linux-wireless+bounces-27794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A04BB59A3
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Oct 2025 01:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4094719E74EA
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E8287508;
	Thu,  2 Oct 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=govivid-ai.20230601.gappssmtp.com header.i=@govivid-ai.20230601.gappssmtp.com header.b="ykhny8kw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4428B407
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447223; cv=none; b=gX5y/AFrCNuGfFhv4VuheJsGe8kYmhCnDx+pISne6odxA3+pA+mMDALdlnooglLjdxCUd4/TkmLas5/1eOFmtv0WGT/enHZCZqVQnUkadx6Yiodp8l2HsXC7Gb/JsJSlYlmoSIxSEbzDg1GJ43jYKTGpED0Ht+kW09v9zqdXpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447223; c=relaxed/simple;
	bh=oauH4H5fAhE9YQilFd4Uh+kG+na5T1OTLmpjiT3+6CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SktbRqKojE8D9uecPaS1xSYEyZqw5RQdIOAmRHoY0wSeBCD4eAelyH8+Ca4yw8Zf+WQpdft9/uy78kYuXZrpItLRdBAw8zLWqgBm9xvOlYC+j2016Pr/OepwYSmRQvXTr31ITIehMgyskFIbHQ5J73MhgenWwVHMygCF38DPQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=govivid.ai; spf=pass smtp.mailfrom=govivid.ai; dkim=pass (2048-bit key) header.d=govivid-ai.20230601.gappssmtp.com header.i=@govivid-ai.20230601.gappssmtp.com header.b=ykhny8kw; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=govivid.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=govivid.ai
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d71bcab69so17817897b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 02 Oct 2025 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=govivid-ai.20230601.gappssmtp.com; s=20230601; t=1759447221; x=1760052021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vEeRe4D2iYgy2mgRonuW34c4fqpWoMFMo0z9bQP5aY=;
        b=ykhny8kwNSJm6c5MV9aX19JFaY5zp31NjaQPtcSqJyBDfAjSWhzcjquTYldo12S0MK
         I8rEkMmh1SxAIWMKSJgJQCr1gYHIz/xrYAZm9pbZqHZaN9bKMtBHc2R1ALBdtHe2rmME
         3l0eN3W0HMB+eQrdRab5j3hThk5E4VEPZxS65LATQ4QtaGNHcrPs+JgobpycNHsL2oHd
         ts3Bo9Pdaou4uvMNNjtg7FD5THmJ1vGj7WeZcEoNwvUA34KsoWZGZ39reSl/PxWIdvIY
         Ni5dUeFT8bvfHHByGaD36NQ/Loy14n9jo3z4xM2i6TIalAo64ZTJ84XksySpcCcQPoff
         pp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759447221; x=1760052021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vEeRe4D2iYgy2mgRonuW34c4fqpWoMFMo0z9bQP5aY=;
        b=jOM0pOO21DzUW2UKcf20prJI70GL04DhpT2ki3PziXogIcWzLNQjlXGTwB96uP4dT6
         qGeFs1V8lY3LEt/g0EZg9yJ71ZCb4FtINDkLh4hAkSuEA2ELRGsd0ZOcSkS475sjDjj3
         0d/sOwigX+XDbOYhV/ZXY+wmMvYqrGorUzOX6rmB78ZXwn/U64wsY/Rs+/gn2P5IArRa
         yJpmcTyvQtmklN2IDL0LeH3rm3UrQZQ0lS28Pz9yI+HdYdlK7sPLo++Jaz/24OJHFcmr
         vpEggU+BWNVP9IeplQRo4WleQCSCeoIcsRAcoU/Hop4HonRGBzFaEc+Coras878K9rhB
         HWug==
X-Forwarded-Encrypted: i=1; AJvYcCU21cbVbLb9thEWi+xhL4tHNjmdXgL1A8RV1QgwwAOtNSa7u8DK//IZfZrRON99MAXtsWiIckt4b6zjx3tEyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMAfHijQo92O4wZr/MHx6k13PuNETHEtpVrCIETz5iWBnDhWv
	smo+NsSqV6HZxr/2ezMV/CgDY1dqsMtbHLD0UayWiVSjpZelc5T8bTM6IeD4lD0IRjI=
X-Gm-Gg: ASbGncvKaIbhllb9c9Hlon8PFpgmdD3tHptx7a2lx4Kpu9ei9MdaRz610FfOpth5SbY
	eRMA3ybSvVQ5cW3GaYVYAbZmSiSKO+u3FezvaBaZRQRJV2OrxDFWaTZKDmBUoXEP3QReGTXp8BN
	15v01CLFWZeLNPescesyV6gf8Pas+NrGd2LR8vTny7F3K1Kmok70rV3VivtDvZ5GmwyMpj1r9jY
	BuhrvGQMbHnzc6yZpeQKKWL4MeXYZn77yDt6VBB+362fcERf1sIkRqr+v0UKsWMUJhV2Cn0kpkO
	9+yaMFTfIMfO5YP94ARdKbTWeTyJrXPO2bp2MQJvzsG9FOTBQceT0BW8MNtE3TfpKIQUnbdEQ19
	pXcJm4XdJse96b8rO4Ieud5XeCsZKvCP/YN9/Dw==
X-Google-Smtp-Source: AGHT+IHUT9ip7xSAFrwOkDS8HcSQ3yhtpEFu+6Rm5cFScpIZ6IFLNK6QOyaEwbV4IGE++pXYiQOi9g==
X-Received: by 2002:a05:690e:23c3:b0:635:4ed0:5730 with SMTP id 956f58d0204a3-63b9a11d957mr721196d50.52.1759447220908;
        Thu, 02 Oct 2025 16:20:20 -0700 (PDT)
Received: from pop-os.. ([12.41.86.113])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b845a71a6sm1156736d50.11.2025.10.02.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:20:20 -0700 (PDT)
From: Richard Reigh <richard@govivid.ai>
To: arend.vanspriel@broadcom.com
Cc: brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	chris@streetlogic.pro,
	linux-wireless@vger.kernel.org,
	s311332@gmail.com,
	wahrenst@gmx.net,
	Richard Reigh <richard@govivid.ai>
Subject: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action frame handling
Date: Thu,  2 Oct 2025 18:20:02 -0500
Message-Id: <20251002232002.124609-1-richard@govivid.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
References: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iPhones query network information via the WiFi settings "i" button,
the brcmfmac driver crashes with a NULL pointer dereference. This occurs
because the P2P device vif is not initialized when handling certain action
frames.

Add NULL check for vif before dereferencing in brcmf_p2p_tx_action_frame()
and return -ENODEV when vif is NULL. Also modify the retry loop in
brcmf_p2p_send_action_frame() to stop immediately on permanent failures
rather than retrying.

Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+

Signed-off-by: Richard Reigh <richard@govivid.ai>
---
 .../wireless/broadcom/brcm80211/brcmfmac/p2p.c   | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 10d9d9c63..2c73156fa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
 	else
 		vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
 
+	/* add NULL check */
+	if (!vif) {
+		brcmf_err("vif is NULL, cannot send action frame\n");
+		return -ENODEV;
+	}
+
 	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
 					sizeof(*af_params));
 	if (err) {
@@ -1857,7 +1863,15 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 		if (af_params->channel)
 			msleep(P2P_AF_RETRY_DELAY_TIME);
 
-		ack = !brcmf_p2p_tx_action_frame(p2p, af_params);
+		int result = brcmf_p2p_tx_action_frame(p2p, af_params);
+
+		/* if it's a permanent failure (like NULL vif), stop retrying */
+		if (result == -ENODEV) {
+			brcmf_err("Permanent failure, stop retries\n");
+			break;
+		}
+
+		ack = !result;
 		tx_retry++;
 		dwell_overflow = brcmf_p2p_check_dwell_overflow(requested_dwell,
 								dwell_jiffies);
-- 
2.34.1


