Return-Path: <linux-wireless+bounces-10055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720339291F4
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955661C21A1C
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C1B4D8BF;
	Sat,  6 Jul 2024 08:29:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9E81AC4
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254565; cv=none; b=CdQ8X9p36S7iPLEyut7fhWbfY4rxuD/yUJmZsMfn12i2gKU8qI8TCduEfnbD93yHCSZdYLhb3vojdTidQnWcARHKHbdPgnvY+R8qOe/FiBGQwps3fljggISAUmrm7ZDoudG1ikPkhNbhYtF6KcOSYuelapS3D55uEBBlyMXCTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254565; c=relaxed/simple;
	bh=DLhNfLLdFbFtLSfV6L4H8XfAnhBMrmO/k15rOGYJ0HE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ha3q340/PFFe3Wm6OLgfvYA9ftyhWMcMY5zNKXgkHjyJZCVum54Hzf1gz5Zm9ALxj8PgK1zC/6/LiBLCxgl8Wnp7FBvh08NQjJUYxEXojoUy+OP8OkZ+henUEQLjOFzvXX/Wn6yMHafVPy5smMsYI4Ls2wNTOr2mZs52JPPbtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d92693f63cso8480b6e.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254563; x=1720859363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPXD+qcLYIZlSplWWRhXiQpzkJn0MvNcUYDTnCW+WRA=;
        b=MCmOFeWRUXwpSWNQOj1ZCs3KzAu6eFWbtzW2JMF3/d0i36oEz5Y4CeDij1U+S269zH
         nQEBuYLztqPSVGa25/4UciLegXoA2yiTVQQapKSY516cg/0Rn2LIUy/3Xn8/RMrVNUoQ
         j38zHFCOfBJV7T+qECqym7RO9zbSsZX9TIdaWCGvNQi+IhnLvVg7BCfMP3h7RjLU3p9f
         y+zdufJ2/TwFF3QcU0zwINuCLLgJFwBaccLpBJGmqymkPdgjIy14LmFBH6PSLV5DY4fo
         l0N23MIvzlUqKCdqvY0YkJTvGirDCrseeyhJSsEgb5s0pAKla/ox8gjML4g2tRtQgYTQ
         L04w==
X-Forwarded-Encrypted: i=1; AJvYcCVA7/bPCO9yndfrxIIK/65D/qvApU63MSWSQnOjPlfsMZTqq5oNqqxPkrIunoMsnmqb2Wikh1wvWGHoMui5fIvhx9S3VDt3ej94tQEznks=
X-Gm-Message-State: AOJu0YxuCrNewJ2aGjVfe+59e5OL7nGHeVq7XhfcGTjTi6ph/ItyaTS+
	V+ck+14r5QU3CYzmTiz5js662FWHTm94gFQTrGW0twy1csRVG0sy0XP6ND6d
X-Google-Smtp-Source: AGHT+IGSumjq8WH2euzBlt3u6CQIhacQboPCctwrhsnbLP+bFEVWpWgi5grP+bQyszbsoNsnemKBbw==
X-Received: by 2002:a05:6871:24ca:b0:254:ecbd:1815 with SMTP id 586e51a60fabf-25e2bffce48mr6347097fac.5.1720254563614;
        Sat, 06 Jul 2024 01:29:23 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:22 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 36/37] wifi: mt76: mt7925: remove the unused mt7925_mcu_set_chan_info
Date: Sat,  6 Jul 2024 01:28:16 -0700
Message-Id: <0aa0abe7fc661380ae812c6bc879a7705de401b2.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

remove the unused function mt7925_mcu_set_chan_info

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 74 -------------------
 1 file changed, 74 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 5f2f866e3ce7..cb5c607b9260 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1274,80 +1274,6 @@ int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 				 &req, sizeof(req), false);
 }
 
-int mt7925_mcu_set_chan_info(struct mt792x_phy *phy, u16 tag)
-{
-	static const u8 ch_band[] = {
-		[NL80211_BAND_2GHZ] = 0,
-		[NL80211_BAND_5GHZ] = 1,
-		[NL80211_BAND_6GHZ] = 2,
-	};
-	struct mt792x_dev *dev = phy->dev;
-	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
-	int freq1 = chandef->center_freq1;
-	u8 band_idx = chandef->chan->band != NL80211_BAND_2GHZ;
-	struct {
-		/* fixed field */
-		u8 __rsv[4];
-
-		__le16 tag;
-		__le16 len;
-		u8 control_ch;
-		u8 center_ch;
-		u8 bw;
-		u8 tx_path_num;
-		u8 rx_path;	/* mask or num */
-		u8 switch_reason;
-		u8 band_idx;
-		u8 center_ch2;	/* for 80+80 only */
-		__le16 cac_case;
-		u8 channel_band;
-		u8 rsv0;
-		__le32 outband_freq;
-		u8 txpower_drop;
-		u8 ap_bw;
-		u8 ap_center_ch;
-		u8 rsv1[53];
-	} __packed req = {
-		.tag = cpu_to_le16(tag),
-		.len = cpu_to_le16(sizeof(req) - 4),
-		.control_ch = chandef->chan->hw_value,
-		.center_ch = ieee80211_frequency_to_channel(freq1),
-		.bw = mt76_connac_chan_bw(chandef),
-		.tx_path_num = hweight8(phy->mt76->antenna_mask),
-		.rx_path = phy->mt76->antenna_mask,
-		.band_idx = band_idx,
-		.channel_band = ch_band[chandef->chan->band],
-	};
-
-	if (chandef->chan->band == NL80211_BAND_6GHZ)
-		req.channel_band = 2;
-	else
-		req.channel_band = chandef->chan->band;
-
-	if (tag == UNI_CHANNEL_RX_PATH ||
-	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
-		req.switch_reason = CH_SWITCH_NORMAL;
-	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
-		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
-	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
-					  NL80211_IFTYPE_AP))
-		req.switch_reason = CH_SWITCH_DFS;
-	else
-		req.switch_reason = CH_SWITCH_NORMAL;
-
-	if (tag == UNI_CHANNEL_SWITCH)
-		req.rx_path = hweight8(req.rx_path);
-
-	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
-		int freq2 = chandef->center_freq2;
-
-		req.center_ch2 = ieee80211_frequency_to_channel(freq2);
-	}
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(CHANNEL_SWITCH),
-				 &req, sizeof(req), true);
-}
-
 int mt7925_mcu_set_eeprom(struct mt792x_dev *dev)
 {
 	struct {
-- 
2.25.1


