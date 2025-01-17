Return-Path: <linux-wireless+bounces-17662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D04A15805
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 20:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D91F7A2D53
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8592E1A3AAD;
	Fri, 17 Jan 2025 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehan/1/m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F625A63C
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141300; cv=none; b=QJRX3fGojGab32uSoZEEBxk8dVvugiCTmB1WbVGRulj1a9Iaub47IlWGvd8nVvGKE3fD7n1uH47smnoaqYF1NLLqkVAOknY0H2ZaZPrU7xp/iex9lPdNGCmIq893hog7oGGt1g193e/E9sh3hK/nw7rA5SKOAZhZmIoEfnKTuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141300; c=relaxed/simple;
	bh=dLuiQl02VryiHl/SCAS2YYUXqhZL0h+wBcrD8FLK88E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlDUj5dsIzLsCqQia6r2Rf4qvMiosEOaityjWUZBuvSoveJM5Xaxm7buUBOaZeBxnx/XfPIZu67AYblocjZsimHrwClCf5CO+vxLkkaPbZa/PbMI3up+vnA9GiWwZXJtJpN1Xt74XViEFInxGMoNqLShjPYkT/5CTSu0HU4a6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehan/1/m; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so27009965e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 11:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737141297; x=1737746097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99e4J68cxEKBg616wDoMXtPaePxmFVcHw1zkfBxnlHM=;
        b=ehan/1/mzxbltFI5uL8f+pCfFFL1Va9SdVdtwrsav5dCDgSITSd7gHsIT6nZxYyFJF
         c5NOFgovC7OzO/m7xeIxSwOiv4qqVvBxPETbO/D+RZmNy2rlOjbHrTR5R757dIk9hm5F
         6UySJw1JaBVi2I89XjpIfWCMeYc67w5Vu1gwlHz534ualUq+wl1Pz6EDMXYDivDycGoZ
         2ba/2/J9GPJx10DRuWIOD0kXILD1lK7+zcNxEjoK/5LOj+JX707t2pCLVgAjPNkVwvFR
         PLVrGvROM2tdbx7jJ48mmqfMjZKBl7goqIcleBe7A+xOdB3NRzJDNDzu3o77NZGirWF0
         v2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737141297; x=1737746097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99e4J68cxEKBg616wDoMXtPaePxmFVcHw1zkfBxnlHM=;
        b=AcPb5GRDin82V5KQMTfq36ssqdntIXU17IrvmmW8pQpJBE1Bu+XSqBtpk/3NmcU5OD
         SXEbPSlIMY7coEiPn2AhGeWhTbbfcaBZy31ZU9htlsLu4BqJW1+4nqhxMWHAiq+rjm+Z
         e71GyP5CK28ZtVvauViQ+sRyzF2ewnZ4z8HnvDwpYfcwbirL58fTZE5bmZtnoIn9HuTk
         4EfCdNga7GLd8cNNEV03kqjMAtaBpVqCUyrBMbwxZeBONMB2t/GjVUhCL1vdeEVciIFy
         9lFgKD7f2ynlNX5+F89CJTP5AONH2Zmz7m/apM3H8lne9kBxQf6Cmw/3pjRTOmfOV1LN
         FMnQ==
X-Gm-Message-State: AOJu0YxnYL1lQ/N7BvopEu6RPDYMucVfE/RFRj8/ieuOBFNVt6sV3Dkw
	yov2K/hpfILYEqViwufOiWrL1TdOOVejeiiwcP/X2XM4nqNlTbR/
X-Gm-Gg: ASbGncupQs39lPOWSflKnRu9nSCn416GOCVxDnIn0M1fdFUI1Hld348eYNV7QAZOhYl
	bEO3lecJsadn7T6P+GEU0Ns3WPpgKhSpi4TIOaqIx6NAXkCy98fhM7HBVJh0fKuwud6r1Ij+okf
	AOZ8Z3XlPcTcMm6UVtHkBsK2S7rEnwR8Ea9J2PKqW0mDhihUkPwha8DSGQNIOFYSmTpl8WW84QY
	488L3r2HeKLRV6OmuROuRtYxmpw1bSqCGGvwHA86Bw6dlu9cSZz3VDeBzsFbAHqemghoEwbjhDQ
	LEm/y9aEs0aCDw==
X-Google-Smtp-Source: AGHT+IFURGPATZai3ribvgNfR+gInUwm8jy4Na74LIXUvtGwyak3lYx45vrT3YiJNGXh9TnMeQyWRA==
X-Received: by 2002:a05:600c:5486:b0:434:f586:753c with SMTP id 5b1f17b1804b1-438913ca694mr39450775e9.7.1737141296811;
        Fri, 17 Jan 2025 11:14:56 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322ace8sm3242709f8f.53.2025.01.17.11.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 11:14:56 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	Steffen Moser <lists@steffen-moser.de>
Subject: [PATCH] Revert "ath11k: clear the keys properly via DISABLE_KEY"
Date: Fri, 17 Jan 2025 20:14:55 +0100
Message-ID: <20250117191455.3395145-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 436a4e88659842a7cf634d7cc088c8f2cc94ebf5.

This as been reported by multiple people [0] that with this commit,
broadcast packets were not being delivered after GTK exchange.
Qualcomm seems to have a similar patch [1] confirming the issue.

[0] https://lore.kernel.org/linux-wireless/Z2Q9POuV-6MIdzRf@pilgrim/
[1] https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.3.0.r24/patches/ath11k/350-ath11k-Revert-clear-the-keys-properly-when-DISABLE_K.patch

Fixes: 436a4e886598 ("ath11k: clear the keys properly via DISABLE_KEY")
Reported-by: Steffen Moser <lists@steffen-moser.de>
Closes: https://lore.kernel.org/linux-wireless/c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 +++-
 drivers/net/wireless/ath/ath11k/wmi.c | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1556392f7ad4..70793f8b1081 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4220,7 +4220,9 @@ static int ath11k_install_key(struct ath11k_vif *arvif,
 		return 0;
 
 	if (cmd == DISABLE_KEY) {
-		arg.key_cipher = WMI_CIPHER_NONE;
+		/* TODO: Check if FW expects  value other than NONE for del */
+		/* arg.key_cipher = WMI_CIPHER_NONE; */
+		arg.key_len = 0;
 		arg.key_data = NULL;
 		goto install;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 87abfa547529..02ff0a58952d 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1854,8 +1854,7 @@ int ath11k_wmi_vdev_install_key(struct ath11k *ar,
 	tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
 	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
 		      FIELD_PREP(WMI_TLV_LEN, key_len_aligned);
-	if (arg->key_data)
-		memcpy(tlv->value, (u8 *)arg->key_data, key_len_aligned);
+	memcpy(tlv->value, (u8 *)arg->key_data, key_len_aligned);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_VDEV_INSTALL_KEY_CMDID);
 	if (ret) {
-- 
2.48.1


