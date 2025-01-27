Return-Path: <linux-wireless+bounces-17997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D70A1D140
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 08:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CDF7A1261
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446B3158D8B;
	Mon, 27 Jan 2025 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7gGnjsX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C901FBEAE
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737961993; cv=none; b=kjyppGuTffIpbdgqjPDVuNobYVLRoxxtamG1DLd6d8bih69BtcW2M4ZnxaBoljbV1YZ4v0uvLSvG0/4+3JqbUI6uE9bH6eURzxfVDB9X6KqA2JDZGNdo+Hf+2ORmn0pF3tASCLoVFUp1hEDSjUQ/cOilhcByvSiBG8IfXAjIVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737961993; c=relaxed/simple;
	bh=1sz26Jba5QVNLwZ2UByLD2RenpV+SH4BCEEaVn17gQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6o9n4SdDLOD8tWTFD0jsGlPf3hSGTP+XdqGGy0bcD2RAInU8z/0keyn22txMx7EVBy0ELXqYnWlYVbTgNsUCRawfdAMmjXHDxeoEkFLuoXVY/QJnOicfGUPCMtNQRTn1NxlwT+X/ss9l2FPGMWXpKPu4/avDR2R6BSghOsrZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7gGnjsX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436341f575fso43886485e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 23:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737961990; x=1738566790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ua/h6hEez4GZgaU0SVJ73Nz7Hd21dohTKQaVqyocjsg=;
        b=b7gGnjsXty8iwxeuYnhMHrzy/spl0T0hOH3QrpOvfVzMVJEDxEcKqZPKwIESaUBlDa
         BsvQodcecFN97qBB+h6Bld/B+XN1B5Msb0LI9DnEbdOmFUA0Rt3OX/MQ9M2DXi6q7bwe
         59stgE4zPyT2f7nHHpJPY7QI7CtrVw0koGLcR2YVsz6nqSY/GPh9h3995hUTdfJGSszn
         H46+yuvi4Yx3um2wvHJ2G0eQ6g2HsT97uObRT5anv01Wzs5RqRLMjjwDKaMy/TJ918Nq
         PZ0t9Mj2kfFMRShgMINUr/F8WvcBV0kMWllXXSXiu2P8w2iq+LczK5p59TTmmGQCjiMa
         4/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737961990; x=1738566790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ua/h6hEez4GZgaU0SVJ73Nz7Hd21dohTKQaVqyocjsg=;
        b=H5kFt8ki4wlLedIdU4sp/dhLB29ACmFPnF5wTwg8WBBCtC3wQLWCIsUgo0tJHF9ySI
         zoipD0BHYo6KlVaU7M0Lnna5Ta1E3MRW79th69PLkq61xt98bCB1O9PL6mOW8liqvy+A
         p8QPHwLVMF1kiAdGSGb7BM+Y+PJ7/n3SuUKotoLP8UYQ6ZO/cqZH0rFKVTjsATh2ISPB
         c57d4rbmosWn9f+kl6WxDKTReruZBHOmMIMoDRft9ykjrlNXh2GFzxNfMv7WZ4L4386X
         uecD/8MVzcJDOaGS6fz8OhjEykcfynyo9PGZ0IV6FE6nl4qYoNJEdMxqiQrfgLmOI1Le
         ugFA==
X-Gm-Message-State: AOJu0Yz1rDY3l+4lPowXTjxwOe70Xquem5wRgMSvoMqVLIbMuBG2eILD
	bf/0UPPd0E+omvAl15dO1NNnyKdqGwxZWrsSwo45cBtI2GLf4vXjaAjSKg==
X-Gm-Gg: ASbGnctqVLKR57BlXZULUVk4Wsrwd/TnBzieIZaUi5LExHcF9kDlWz6ckQvnNvaKBMj
	kJoplRmNESYPRwBiReMioWUVXQTHuW12mBk5mliypKcX2Bl5PtFyismABMhNqnrwBsZwwYonoib
	h4TWcbuh0DAVreul2orVppPo0UbU196OBwSGzb1WVg+LPY2Jla57LatTjv089MHyiOKugivFY5O
	e1Rpn9Cv8rKY6Uf/Pv8gYPruJT6E+GNZPWc5JILMklMDwjMd1Sxl/gR1Rp4tqeiFpcxvXHxd4d+
	9bNpiDWM5aCZkiymUJFt94ksrOHpD3dSpXOxBg==
X-Google-Smtp-Source: AGHT+IGV0eWgepDgho9rEgaECBmeKbpNetD71sbz1RcssXocncPJ2uObmd7Z7vwhAhIYAhqso1y+mA==
X-Received: by 2002:a05:600c:468d:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-4389143b715mr342511305e9.22.1737961989511;
        Sun, 26 Jan 2025 23:13:09 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd5732edsm119225965e9.36.2025.01.26.23.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 23:13:07 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: ath12k: fix ath12k_hal_tx_cmd_ext_desc_setup() info1 override
Date: Mon, 27 Jan 2025 08:13:06 +0100
Message-ID: <20250127071306.1454699-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since inception there is an obvious typo laying around in
ath12k_hal_tx_cmd_ext_desc_setup(). Instead of intitializing + adding
flags to tcl_ext_cmd->info1, we initialize + override. This will be needed
in the future to make broadcast frames work with ethernet encapsulation.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
v2:
  - removed spurious 'fbx' from title
  - removed fixes tag as the problem it fixes is not yet enabled mainstream
    see https://lore.kernel.org/linux-wireless/23d62bef-2393-4232-93ff-82ca4dbc4524@oss.qualcomm.com/ 
v1: 
  - initial version
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index e0b85f959cd4a..00437736e0322 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -117,7 +117,7 @@ static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
 			       le32_encode_bits(ti->data_len,
 						HAL_TX_MSDU_EXT_INFO1_BUF_LEN);
 
-	tcl_ext_cmd->info1 = le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
+	tcl_ext_cmd->info1 |= le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
 				le32_encode_bits(ti->encap_type,
 						 HAL_TX_MSDU_EXT_INFO1_ENCAP_TYPE) |
 				le32_encode_bits(ti->encrypt_type,
-- 
2.48.1


