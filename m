Return-Path: <linux-wireless+bounces-27143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F09B4A29B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 08:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D240D188F9DB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 06:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C621A83F8;
	Tue,  9 Sep 2025 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOCeyQF6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F307263E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400514; cv=none; b=qVDE55EFmB0TmCgrbmiFHB5A+dGGrdOePnCgrnRPTraVV8tAkBFmSzeGgcsN/YlRIEDKCe6YxhJts8xASr8NCTwBwPuuFRSTFCxWVo12eAdDLSeNrReV7YpNNTM3K34GkCD+F8GgkiflmK05WnT7U/MOnp1ROOWw7PSyEkKjD44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400514; c=relaxed/simple;
	bh=rtlTMZC7g2rsew+11SvO0UaDW+5JK8T8oQscLBSyq9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mopq4+NXxQsCqnXQsfTYMIhYzt60rdD9iJgj+Dj3SVa/ffbUUZkTtvaIgUPDXYfj5MZA0RPd5RggDoncQ6FmCv0M3rQV57IGZLhVQ08TbT3NqWIYvzUoSvEfLvMo1Y9P9NifA6YNdl+G2ZddqfK0gnPh5UKRetOb15s3nIHRNWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOCeyQF6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772679eb358so4830496b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Sep 2025 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757400511; x=1758005311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yau1y0MdDuPzs89TtMwlXdIWtqiW1xkaw2fGUY4rbgM=;
        b=nOCeyQF6a0CRXH+KcFyR6pzg4dlK6cXiR6VwCYmmToRTK4Fkep+oGV5JpUetwPGpwB
         Bh5uZoCMx0H1VDcqK+Y5EZbEgBif69gblwZLw21Dyg6MbANhiYFK5zxixvcfAsrGTtsh
         69PeAkiyNtUFdXo294vnSiZtID8lMt5SBPGvL4VhGbD7sQL8PQRQeEfhsKcMbhr+oXL3
         z9F6tzZ29pR0POhnkvROp634ahxOhxRHREABSltj+wxEOkcl9XbJX7oANe8MPEGvkX4c
         hqe8xDlLRMvstbUzsEyWCAhtUeG9Etfdzk1Q0xLtYJJETFMl5DhQ8G5L+Wz4rOAlq0xp
         NzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757400511; x=1758005311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yau1y0MdDuPzs89TtMwlXdIWtqiW1xkaw2fGUY4rbgM=;
        b=uL3aFstZwbvvT8CDlopJFHcFuM+50yNV5lAXLvEsgG0kYivElA4N2V2ZNvdbpv3FkW
         3s6yr9TVGk4A3I6G7HBhBttt8JdDMYGTX5y6R75wUCmCW6gj6YgOezLPPRVlkh8JqPKw
         jbS02V7VVyBvJ1bIvV8BimYFT2TlKygalHa0d9D1Um/Gv+h0JN9mMsotHaJBtCZok974
         M+KVCr1ujiRjUZzK87VldmHb98IM0dpvrcWsyJ526IPH+8ldMgQmgHoVtUdncMY6LZ+m
         q44MNp+yJAUCsS3oOGyAgNsvhBlr27ROZiu4uoeNMtayLJQK7UbIlTxpqR+vGMJvo4/k
         AD8Q==
X-Gm-Message-State: AOJu0YyI6Z/yJApUKu4qjsWW0ipe8kb0xrsU7c503LBwPI4i6/OweHYG
	UkgCDc9XFeFzpNp1NDChDbJOXRHvsrpFV4FuTigm924rvSwypF0t8HAs
X-Gm-Gg: ASbGnctCDCEko2CuYTdhrilHGistqkEnjTkWGyBh2fDASw/Ft2arQUKiFijVDfS+9x9
	3hV/Nor0+14LxJF6wfPfP3oZvtTYRvBxMQOw2KC2P6QdsFs84ogFhGvRBDN3EGB4WPXqNkbaaKw
	5g4II7GfSNbzlK+g74BVZEm4Q2OgQooLV7RXKufZPneal1xvSq9JUYgLPwcTJLqzW7aGkzhR/2k
	CVmoVPBl+gBRcK41EjqCKyRNATKsZavoXuycgG0LDWfg929EkxxY7ZLaeMgBwN1CkG3+cEBvWY7
	MTUrO+a7DUF1Je3RR+iUDMZkA9TYHsoThmsv1syPmHeetO17sEXU8Xd/+aWTVJLcYsIXay9JLz9
	hghCCp9bKum7mPAyi5x2KEb8ApWPsvldDQujq0NnxvKCo/ZIlGyWRN26dt9Heyyz6Z9eRchk=
X-Google-Smtp-Source: AGHT+IGBDN203Gma71lTgp8v2B/LKOSU5soZLdWZpX8IfKq7S4JtiR7EzzwQ+71f+wyWTnoP3TTo4w==
X-Received: by 2002:a05:6a20:12cb:b0:243:6f4e:fba2 with SMTP id adf61e73a8af0-2533e18c6f0mr14496693637.2.1757400511043;
        Mon, 08 Sep 2025 23:48:31 -0700 (PDT)
Received: from NT123328-PC02.ZyXEL.com (114-33-191-187.hinet-ip.hinet.net. [114.33.191.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628fb5bsm993603b3a.48.2025.09.08.23.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:48:30 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH mt76 v2] wifi: mt76: mt7915: fix mt7981 pre-calibration
Date: Tue,  9 Sep 2025 14:48:24 +0800
Message-ID: <20250909064824.16847-1-hujy652@gmail.com>
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

For devices with precal, this would lead to lower bitrate.

Fix this by aligning groupcal size with vendor driver and switch to
freq_list_v2 in mt7915_dpd_freq_idx in order to get the correct offset.

Below are iwinfo of the test device with two clients connected
(iPhone 16, Intel AX210).
Before :
	Mode: Master  Channel: 36 (5.180 GHz)  HT Mode: HE80
	Center Channel 1: 42 2: unknown
	Tx-Power: 23 dBm  Link Quality: 43/70
	Signal: -67 dBm  Noise: -92 dBm
	Bit Rate: 612.4 MBit/s
	Encryption: WPA3 SAE (CCMP)
	Type: nl80211  HW Mode(s): 802.11ac/ax/n
	Hardware: embedded [MediaTek MT7981]

After:
	Mode: Master  Channel: 36 (5.180 GHz)  HT Mode: HE80
	Center Channel 1: 42 2: unknown
	Tx-Power: 23 dBm  Link Quality: 43/70
	Signal: -67 dBm  Noise: -92 dBm
	Bit Rate: 900.6 MBit/s
	Encryption: WPA3 SAE (CCMP)
	Type: nl80211  HW Mode(s): 802.11ac/ax/n
	Hardware: embedded [MediaTek MT7981]

Tested-on: mt7981 20240823

Fixes: 19a954edec63 ("wifi: mt76: mt7915: add mt7986, mt7916 and mt7981 pre-calibration")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
Changes in v2
- Reword commit subject and message.
- Use freq_list_v2 for mt7981.
- Add iwinfo output.
- Add Tested-on tag.
- Link to v1: https://lore.kernel.org/all/20250827052916.9333-1-hujy652@gmail.com
---
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |  6 ++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 29 +++++--------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 31aec0f40232..73611c9d26e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -50,9 +50,9 @@ enum mt7915_eeprom_field {
 #define MT_EE_CAL_GROUP_SIZE_7975		(54 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_GROUP_SIZE_7976		(94 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_GROUP_SIZE_7916_6G		(94 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7981		(144 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_DPD_SIZE_V1			(54 * MT_EE_CAL_UNIT)
 #define MT_EE_CAL_DPD_SIZE_V2			(300 * MT_EE_CAL_UNIT)
-#define MT_EE_CAL_DPD_SIZE_V2_7981		(102 * MT_EE_CAL_UNIT)	/* no 6g dpd data */
 
 #define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
 #define MT_EE_WIFI_CONF0_RX_PATH		GENMASK(5, 3)
@@ -180,6 +180,8 @@ mt7915_get_cal_group_size(struct mt7915_dev *dev)
 		val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
 		return (val == MT_EE_V2_BAND_SEL_6GHZ) ? MT_EE_CAL_GROUP_SIZE_7916_6G :
 							 MT_EE_CAL_GROUP_SIZE_7916;
+	} else if (is_mt7981(&dev->mt76)) {
+		return MT_EE_CAL_GROUP_SIZE_7981;
 	} else if (mt7915_check_adie(dev, false)) {
 		return MT_EE_CAL_GROUP_SIZE_7976;
 	} else {
@@ -192,8 +194,6 @@ mt7915_get_cal_dpd_size(struct mt7915_dev *dev)
 {
 	if (is_mt7915(&dev->mt76))
 		return MT_EE_CAL_DPD_SIZE_V1;
-	else if (is_mt7981(&dev->mt76))
-		return MT_EE_CAL_DPD_SIZE_V2_7981;
 	else
 		return MT_EE_CAL_DPD_SIZE_V2;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 2928e75b2397..c1fdd3c4f1ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3052,30 +3052,15 @@ static int mt7915_dpd_freq_idx(struct mt7915_dev *dev, u16 freq, u8 bw)
 		/* 5G BW160 */
 		5250, 5570, 5815
 	};
-	static const u16 freq_list_v2_7981[] = {
-		/* 5G BW20 */
-		5180, 5200, 5220, 5240,
-		5260, 5280, 5300, 5320,
-		5500, 5520, 5540, 5560,
-		5580, 5600, 5620, 5640,
-		5660, 5680, 5700, 5720,
-		5745, 5765, 5785, 5805,
-		5825, 5845, 5865, 5885,
-		/* 5G BW160 */
-		5250, 5570, 5815
-	};
-	const u16 *freq_list = freq_list_v1;
-	int n_freqs = ARRAY_SIZE(freq_list_v1);
-	int idx;
+	const u16 *freq_list;
+	int idx, n_freqs;
 
 	if (!is_mt7915(&dev->mt76)) {
-		if (is_mt7981(&dev->mt76)) {
-			freq_list = freq_list_v2_7981;
-			n_freqs = ARRAY_SIZE(freq_list_v2_7981);
-		} else {
-			freq_list = freq_list_v2;
-			n_freqs = ARRAY_SIZE(freq_list_v2);
-		}
+		freq_list = freq_list_v2;
+		n_freqs = ARRAY_SIZE(freq_list_v2);
+	} else {
+		freq_list = freq_list_v1;
+		n_freqs = ARRAY_SIZE(freq_list_v1);
 	}
 
 	if (freq < 4000) {
-- 
2.50.1


