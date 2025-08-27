Return-Path: <linux-wireless+bounces-26676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0F0B379D3
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 07:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80AD3A69D7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 05:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D576238179;
	Wed, 27 Aug 2025 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5WuXLn1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F631F4634
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272563; cv=none; b=duvxpk3/cAy4Ibnjtr+4ghhpFKuSfSzjew6qyznYhtp9aMRC7/Ums1btNt+y5fgrNHaIP1GaZvu4YlxZDBxncWD4P6jpy+Qo9jojUZ9nqTvgPdGdXk8n2xDIsNJCBR0aHFpTog9a2yxyiFfOpPK8xr4/FCVSvHuFHezYR4JC66Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272563; c=relaxed/simple;
	bh=skn/rGCxhOom1AnhO5nriQE2dzFf7/XLUF3gCY5aBb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQ9qK33AktGKVsoHEBEykwbYVFwoxRRmYwrCdvqJirKfHsY0ZGttn/1zkw7NJeOItxtohCaaFnxvWg5t9FTpZTfr86NCy4gYHLZ9WArXVOB9kxT49W8B6sOxzmmJ0fLPbONFGbkjmlf+qqzcWGCumz3t5XVlcPWFNzXq1PXmRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5WuXLn1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b476c67c5easo428865a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756272561; x=1756877361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygdN7EDPAdRfwgZp4Vm07Bifiw5gAQr2aR8tKQa5LX0=;
        b=b5WuXLn1PJPKBVLfV75qZLxtJH1sQN6VAKZpMqF7uI3jiEPu8fMc8DKswOPWpvWksL
         gGGRGmtRb+V2WeR8v9io1MSecZD+nPhB6tBqQIWdFYP4MHeA9s1RQYOXbxFAo3xlDEP3
         DGkhfApox5j4G2eDxqtEr+/MwZoF2q+pmUzOj+h+2IXXZUowW4GNlbjH961aAsIAYa81
         vB6uxVQV8PPVMEude3pS+FFZ8mW0nNrQSa+DRNt6spN3VC4WfxUXVDxipSKGpX3yHiYi
         m7n9tL8UrWk1jQhQ/JDpCi9pw8NBN83upzg6YJm0Wvgv5oIprFg2NIbJURpvh8UUvH3e
         yiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756272561; x=1756877361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygdN7EDPAdRfwgZp4Vm07Bifiw5gAQr2aR8tKQa5LX0=;
        b=tQbREPaiaQvzbnQ/DUHGZIHXwz3urZ0pst+f0c0/iFQUhxf4oHARLhr9BgxVy3ivBh
         QytsLd1Ke6+hwJBVkWpVO2ATJEzmM/bKr0p8M/Nh2W/B+mSkyynZx0WdGn4F0XSeCB1L
         HBieVFgT7rezJV6631bnaGJSHNu41IimrCPf1NxyTaiIDbDpJ8LIdqI7n61ru9h9iteq
         rFdrSHDqksqPbPUHQIJICVRLf5U3WLHF66uSFmfm79FC+kILvZgLC8Vv/wr0X8+C5PRu
         hPJN4mIGBq55mf2u8fPiHZXTRVfM0eDRkUFND33yRgYWfmsrP5+FeikJJKwueheLeZL4
         t7ig==
X-Gm-Message-State: AOJu0Yy2eMuBdwycu2+D7sEtEDsnUB5tUC79mYPCJghqEA7WUt6TM/iE
	n2j1Pt4lsjZMToWZ5qCZA/d43NNrc1p9TMvbPWIKwXL6IeDf2dX2aeNM
X-Gm-Gg: ASbGncuXNjaTPZEwr0xte/y17CkqMHohq2WqsP4/Do7a7FT5u4f/KvAQHeg82mwWbrB
	t5ikaK5pmuQvIFmmmkkXjNGxdjzgpdvKXX/5JoD9EGXzRhU+uT+QyhF8/+z5EKTv5WHeDM5ihOE
	JO68xjov+f3yz7A/GcHaJsaTVC7jWoy+icCUjtw1ITWFZx2le2ZocUKxAwTe/Cms03UMswTeEyL
	sFrsiT2iLkLibOCpSsgMqvT3mq/wG8NG+j3z/17bF7ck5RR5ySURJA5l+hPXGCGuSSx+Io88HZs
	XNAPDd0ZvQNbYVNseFV2+X/Bn2kO2E0gTXh8HGc7bxqrNIITyOMZCkzyUdr9/8w4ie7NIB9ArrS
	csWwoe+qQBsqmkODEwsdKe6Wu3dH26j2+Fllgq8NV9qdDIG1Va6R+i+eI6RJe+5U03qz5Hjw=
X-Google-Smtp-Source: AGHT+IF4jkE2fOfr3CL4Vcw8qq+LaUzk2BrkAruQHuVPQr42LRwUM8hqfhPJv+ZNPYnsLm7ic+2EYA==
X-Received: by 2002:a17:902:fc50:b0:246:c428:ca4 with SMTP id d9443c01a7336-248753a244cmr52463765ad.25.1756272560803;
        Tue, 26 Aug 2025 22:29:20 -0700 (PDT)
Received: from NT123328-PC02.ZyXEL.com (114-33-191-187.hinet-ip.hinet.net. [114.33.191.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm112052945ad.48.2025.08.26.22.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 22:29:20 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH] wifi: mt76: mt7915: fix mt7981 reading precal
Date: Wed, 27 Aug 2025 13:29:15 +0800
Message-ID: <20250827052916.9333-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vendor driver, size of group cal and dpd cal for mt7981 includes 6G
although the chip doesn't support it.

mt76 doesn't take this into account which results in reading from the
incorrect offset.

Fix this by aligning pre-cal size with vendor driver and adding an
offset when reading dpd cal for mt7981.

Fixes: 19a954edec63 ("wifi: mt76: mt7915: add mt7986, mt7916 and mt7981 pre-calibration")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 31aec0f40232..ae9caa10763d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -50,9 +50,10 @@ enum mt7915_eeprom_field {
 #define MT_EE_CAL_GROUP_SIZE_7975		(54 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_GROUP_SIZE_7976		(94 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_GROUP_SIZE_7916_6G		(94 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7981		(144 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_DPD_SIZE_V1			(54 * MT_EE_CAL_UNIT)
 #define MT_EE_CAL_DPD_SIZE_V2			(300 * MT_EE_CAL_UNIT)
-#define MT_EE_CAL_DPD_SIZE_V2_7981		(102 * MT_EE_CAL_UNIT)	/* no 6g dpd data */
+#define MT_EE_CAL_DPD_OFFSET_V2_5G		(198 * MT_EE_CAL_UNIT) /* skip 6g dpd data */
 
 #define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
 #define MT_EE_WIFI_CONF0_RX_PATH		GENMASK(5, 3)
@@ -180,6 +181,8 @@ mt7915_get_cal_group_size(struct mt7915_dev *dev)
 		val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
 		return (val == MT_EE_V2_BAND_SEL_6GHZ) ? MT_EE_CAL_GROUP_SIZE_7916_6G :
 							 MT_EE_CAL_GROUP_SIZE_7916;
+	} else if (is_mt7981(&dev->mt76)) {
+		return MT_EE_CAL_GROUP_SIZE_7981;
 	} else if (mt7915_check_adie(dev, false)) {
 		return MT_EE_CAL_GROUP_SIZE_7976;
 	} else {
@@ -192,8 +195,6 @@ mt7915_get_cal_dpd_size(struct mt7915_dev *dev)
 {
 	if (is_mt7915(&dev->mt76))
 		return MT_EE_CAL_DPD_SIZE_V1;
-	else if (is_mt7981(&dev->mt76))
-		return MT_EE_CAL_DPD_SIZE_V2_7981;
 	else
 		return MT_EE_CAL_DPD_SIZE_V2;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 2928e75b2397..6a13a65936dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3139,6 +3139,8 @@ int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy)
 	/* Items: Tx DPD, Tx Flatness */
 	idx = idx * cal_num;
 	cal += mt7915_get_cal_group_size(dev) + (idx * MT_EE_CAL_UNIT);
+	if (is_mt7981(&dev->mt76))
+		cal += MT_EE_CAL_DPD_OFFSET_V2_5G;
 
 	while (cal_num--) {
 		int ret;
-- 
2.50.1


