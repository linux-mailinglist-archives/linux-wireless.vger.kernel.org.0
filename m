Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2645A4B5DA3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 23:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiBNWbQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 17:31:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiBNWbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 17:31:15 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D24F70DB
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 14:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644877867; x=1676413867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oZ4e+rxFSKbTGOS677+bymtqwSgK8yFYiuoUsTbZQVQ=;
  b=SaC3AyaqcuIYpkvgqpFmeqbASLk3yZf6aaQYyGCcsRKPWps3qRtDWgyO
   rvn58h7vGXD/ER1D0aXlKuK5EOO3zbilEZ8hVEoWr7vW9a7PDFAmw9Q86
   ZnnSCbjsh+/YSS/P5dSk7cPkJFviQen+0fClLyym6V96ZeGPH7cph62Tp
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Feb 2022 14:31:07 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 14:31:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 14:31:04 -0800
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 14:31:04 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 2/3] cfg80211: validate RU puncturing bitmap
Date:   Mon, 14 Feb 2022 14:30:50 -0800
Message-ID: <20220214223051.3610-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220214223051.3610-1-quic_alokad@quicinc.com>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RU puncturing bitmap consists of 16 bits, each bit corresponding to
a 20 MHz channel in the operating bandwidth. Lowest bit corresponds to
the lowest frequency. Bit set to 1 indicates that the channel is
punctured otherwise it is active.

Validate the bitmap against following rules:
- Primary 20 MHz channel cannot be punctured
- As per IEEE P802.11be/D1.3, December 2021, 36.3.12.11.3 Preamble
  puncturing for PPDUs in a non-OFDMA transmission
- As per IEEE P802.11be/D1.3, December 2021, 36.3.12.11.2 Preamble
  puncturing for PPDUs in an OFDMA transmission.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/cfg80211.h | 12 ++++-
 net/wireless/chan.c    | 99 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5605cf6d247b..c3246e989828 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -742,6 +742,11 @@ struct key_params {
  *	chan will define the primary channel and all other
  *	parameters are ignored.
  * @freq1_offset: offset from @center_freq1, in KHz
+ * @ru_punct_bitmap: RU puncturing bitmap. Each bit represents a 20 MHz channel
+ *	with lowest bit corresponding to the smallest frequency. Bit set to 1
+ *	indicates that the channel is punctured, otherwise the channel is active
+ * @ru_punct_bitmap_supp_he: Indicates whether RU puncturing bitmap validation
+ *	should include OFDMA bitmaps.
  */
 struct cfg80211_chan_def {
 	struct ieee80211_channel *chan;
@@ -750,6 +755,8 @@ struct cfg80211_chan_def {
 	u32 center_freq2;
 	struct ieee80211_edmg edmg;
 	u16 freq1_offset;
+	u16 ru_punct_bitmap;
+	bool ru_punct_bitmap_supp_he;
 };
 
 /*
@@ -878,7 +885,10 @@ cfg80211_chandef_identical(const struct cfg80211_chan_def *chandef1,
 		chandef1->width == chandef2->width &&
 		chandef1->center_freq1 == chandef2->center_freq1 &&
 		chandef1->freq1_offset == chandef2->freq1_offset &&
-		chandef1->center_freq2 == chandef2->center_freq2);
+		chandef1->center_freq2 == chandef2->center_freq2 &&
+		chandef1->ru_punct_bitmap == chandef2->ru_punct_bitmap &&
+		chandef1->ru_punct_bitmap_supp_he ==
+					chandef2->ru_punct_bitmap_supp_he);
 }
 
 /**
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 8b7fb4a9e07b..4390e9297222 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -32,6 +32,7 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 	chandef->center_freq2 = 0;
 	chandef->edmg.bw_config = 0;
 	chandef->edmg.channels = 0;
+	chandef->ru_punct_bitmap = 0;
 
 	switch (chan_type) {
 	case NL80211_CHAN_NO_HT:
@@ -196,6 +197,101 @@ static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
 	return nl80211_chan_width_to_mhz(c->width);
 }
 
+/* IEEE P802.11be/D1.31, December 2021, Table 36-30 5-bit punctured channel
+ * indication for the non-OFDMA case in an EHT MU PPDU
+ */
+static const u16 ru_punct_bitmap_80[] = {0xF, 0xE, 0xD, 0xB, 0x7};
+static const u16 ru_punct_bitmap_160[] = {0xFF, 0xFE, 0xFD, 0xFB, 0xF7, 0xEF,
+					  0xDF, 0xBF, 0x7F, 0xFC, 0xF3, 0xCF,
+					  0x3F};
+static const u16 ru_punct_bitmap_320[] = {0xFFFF, 0xFFFC, 0xFFF3, 0xFFCF,
+					  0xFF3F, 0xFCFF, 0xF3FF, 0xCFFF,
+					  0x3FFF, 0xFFF0, 0xFF0F, 0xF0FF,
+					  0x0FFF, 0xFFC0, 0xFF30, 0xFCF0,
+					  0xF3F0, 0xCFF0, 0x3FF0, 0x0FFC,
+					  0x0FF3, 0x0FCF, 0x0F3F, 0x0CFF,
+					  0x03FF};
+
+bool cfg80211_ru_punct_bitmap_valid(const struct cfg80211_chan_def *chandef)
+{
+	u8 i, non_ofdma_bitmap_count, ofdma_block_count = 1;
+	u16 bitmap, pri_ch_bit_pos;
+	const u16 *non_ofdma_bitmap;
+	u32 start_freq;
+
+	if (!chandef->ru_punct_bitmap) /* All channels active */
+		return true;
+
+	bitmap = ~chandef->ru_punct_bitmap;
+	WARN_ON_ONCE(sizeof(bitmap) != sizeof(chandef->ru_punct_bitmap));
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_80:
+		bitmap &= 0xF;
+		non_ofdma_bitmap = &ru_punct_bitmap_80[0];
+		non_ofdma_bitmap_count = ARRAY_SIZE(ru_punct_bitmap_80);
+		start_freq = chandef->center_freq1 - 40;
+		break;
+
+	case NL80211_CHAN_WIDTH_160:
+		bitmap &= 0xFF;
+		non_ofdma_bitmap = &ru_punct_bitmap_160[0];
+		non_ofdma_bitmap_count = ARRAY_SIZE(ru_punct_bitmap_160);
+		ofdma_block_count = 2;
+		start_freq = chandef->center_freq1 - 80;
+		break;
+
+	case NL80211_CHAN_WIDTH_320:
+		bitmap &= 0xFFFF;
+		non_ofdma_bitmap = &ru_punct_bitmap_320[0];
+		non_ofdma_bitmap_count = ARRAY_SIZE(ru_punct_bitmap_320);
+		ofdma_block_count = 4;
+		start_freq = chandef->center_freq1 - 160;
+		break;
+
+	default:
+		return false;
+	}
+
+	if (!bitmap) /* No channel active */
+		return false;
+
+	pri_ch_bit_pos = ((chandef->chan->center_freq - start_freq) / 20);
+	if (!(bitmap & BIT(pri_ch_bit_pos)))
+		return false;
+
+	/* Check for non-OFDMA puncturing patterns */
+	for (i = 0; i < non_ofdma_bitmap_count; i++)
+		if (non_ofdma_bitmap[i] == bitmap)
+			return true;
+
+	if (!chandef->ru_punct_bitmap_supp_he)
+		return false;
+
+	/* Check for OFDMA puncturing patterns */
+	for (i = 0; i < ofdma_block_count; i++) {
+		switch ((bitmap >> (i * 4)) & 0xF) {
+		/* IEEE P802.11be/D1.31, December 2021, 36.3.12.11.2 Preamble
+		 * puncturing for PPDUs in an OFDMA transmission
+		 */
+		case 0xF:
+		case 0x7:
+		case 0xB:
+		case 0xD:
+		case 0xE:
+		case 0x3:
+		case 0xC:
+		case 0x9:
+		case 0x0:
+			break;
+		default:
+			return false;
+		}
+	}
+
+	return true;
+}
+
 bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 {
 	u32 control_freq, oper_freq;
@@ -316,6 +412,9 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	    !cfg80211_edmg_chandef_valid(chandef))
 		return false;
 
+	if (!cfg80211_ru_punct_bitmap_valid(chandef))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL(cfg80211_chandef_valid);
-- 
2.31.1

