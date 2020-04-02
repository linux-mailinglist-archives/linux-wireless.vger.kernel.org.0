Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF14019B9CA
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 03:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbgDBBSX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 21:18:23 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46490 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733237AbgDBBSX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 21:18:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 47AE24F7AEB;
        Thu,  2 Apr 2020 01:18:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zoMAyxFWnhxN; Thu,  2 Apr 2020 01:18:19 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 921084F7AF2;
        Thu,  2 Apr 2020 01:18:12 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 4/9] mac80211: add freq_offset to RX status
Date:   Wed,  1 Apr 2020 18:18:05 -0700
Message-Id: <20200402011810.22947-5-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402011810.22947-1-thomas@adapt-ip.com>
References: <20200402011810.22947-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RX status needs a KHz component, so add freq_offset. We
can make ampdu_reference u16 since it is probably
sufficient to be able to distinguish 64k different
A-MPDUs.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

---
v2:
use fewer bits in ieee80211_rx_status (Johannes)
---
 include/net/mac80211.h | 10 +++++++++-
 net/mac80211/mlme.c    |  6 ++++--
 net/mac80211/rx.c      |  1 +
 net/mac80211/scan.c    |  3 ++-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b6b4de0e4b5e..25d033c3e35b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1333,6 +1333,7 @@ enum mac80211_rx_encoding {
  * @freq: frequency the radio was tuned to when receiving this frame, in MHz
  *	This field must be set for management frames, but isn't strictly needed
  *	for data (other) frames - for those it only affects radiotap reporting.
+ * @freq_offset: @freq has a positive offset of 500Khz.
  * @signal: signal strength when receiving this frame, either in dBm, in dB or
  *	unspecified depending on the hardware capabilities flags
  *	@IEEE80211_HW_SIGNAL_*
@@ -1363,7 +1364,7 @@ struct ieee80211_rx_status {
 	u32 device_timestamp;
 	u32 ampdu_reference;
 	u32 flag;
-	u16 freq;
+	u16 freq: 13, freq_offset: 1;
 	u8 enc_flags;
 	u8 encoding:2, bw:3, he_ru:3;
 	u8 he_gi:2, he_dcm:1;
@@ -1379,6 +1380,13 @@ struct ieee80211_rx_status {
 	u8 zero_length_psdu_type;
 };
 
+static inline u32
+ieee80211_rx_status_to_khz(struct ieee80211_rx_status *rx_status)
+{
+	return MHZ_TO_KHZ(rx_status->freq) +
+	       (rx_status->freq_offset ? 500 : 0);
+}
+
 /**
  * struct ieee80211_vendor_radiotap - vendor radiotap data information
  * @present: presence bitmap for this vendor namespace
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4eebee49bb7d..5c1c99217723 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3669,7 +3669,8 @@ static void ieee80211_rx_bss_info(struct ieee80211_sub_if_data *sdata,
 
 	sdata_assert_lock(sdata);
 
-	channel = ieee80211_get_channel(local->hw.wiphy, rx_status->freq);
+	channel = ieee80211_get_channel_khz(local->hw.wiphy,
+					ieee80211_rx_status_to_khz(rx_status));
 	if (!channel)
 		return;
 
@@ -3885,7 +3886,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	if (rx_status->freq != chanctx_conf->def.chan->center_freq) {
+	if (ieee80211_rx_status_to_khz(rx_status) !=
+	    ieee80211_channel_to_khz(chanctx_conf->def.chan)) {
 		rcu_read_unlock();
 		return;
 	}
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 91a13aee4378..0b6dca4c0c7d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -412,6 +412,7 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 	pos++;
 
 	/* IEEE80211_RADIOTAP_CHANNEL */
+	/* TODO: frequency offset in KHz */
 	put_unaligned_le16(status->freq, pos);
 	pos += 2;
 	if (status->bw == RATE_INFO_BW_10)
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 4d14118dddca..5db15996524f 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -275,7 +275,8 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 			return;
 	}
 
-	channel = ieee80211_get_channel(local->hw.wiphy, rx_status->freq);
+	channel = ieee80211_get_channel_khz(local->hw.wiphy,
+					ieee80211_rx_status_to_khz(rx_status));
 
 	if (!channel || channel->flags & IEEE80211_CHAN_DISABLED)
 		return;
-- 
2.20.1

