Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA4619A540
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 08:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbgDAGWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 02:22:01 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:36644 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731683AbgDAGWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 02:22:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id C11364F7A57;
        Wed,  1 Apr 2020 06:21:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N6_2XF-AKdWC; Wed,  1 Apr 2020 06:21:56 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 7CA7C4F7A27;
        Wed,  1 Apr 2020 06:21:52 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [RFC 3/7] mac80211: handle channel frequency offset
Date:   Tue, 31 Mar 2020 23:21:46 -0700
Message-Id: <20200401062150.3324-4-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401062150.3324-1-thomas@adapt-ip.com>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cfg80211_chan_def and ieee80211_channel recently gained a
frequency offset component. Handle this where it makes
sense (potentially required by S1G channels), ie. ignore
for mesh, ibss, HT/VHT specific stuff, TDLS, etc.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/chan.c  |  1 +
 net/mac80211/main.c  |  8 +++++---
 net/mac80211/mlme.c  | 16 ++++++++++++----
 net/mac80211/scan.c  |  1 +
 net/mac80211/trace.h | 41 +++++++++++++++++++++++++++++++++--------
 5 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 9c94baaf693c..e6e192f53e4e 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -533,6 +533,7 @@ static void ieee80211_del_chanctx(struct ieee80211_local *local,
 		struct cfg80211_chan_def *chandef = &local->_oper_chandef;
 		chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
 		chandef->center_freq1 = chandef->chan->center_freq;
+		chandef->freq1_offset = chandef->chan->freq_offset;
 		chandef->center_freq2 = 0;
 
 		/* NOTE: Disabling radar is only valid here for
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 8345926193de..3ee47dc2584b 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -104,13 +104,15 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 		chandef.chan = local->tmp_channel;
 		chandef.width = NL80211_CHAN_WIDTH_20_NOHT;
 		chandef.center_freq1 = chandef.chan->center_freq;
+		chandef.freq1_offset = chandef.chan->freq_offset;
 	} else
 		chandef = local->_oper_chandef;
 
 	WARN(!cfg80211_chandef_valid(&chandef),
-	     "control:%d MHz width:%d center: %d/%d MHz",
-	     chandef.chan->center_freq, chandef.width,
-	     chandef.center_freq1, chandef.center_freq2);
+	     "control:%d.%03d MHz width:%d center: %d.%03d/%d MHz",
+	     chandef.chan->center_freq, chandef.chan->freq_offset,
+	     chandef.width, chandef.center_freq1, chandef.freq1_offset,
+	     chandef.center_freq2);
 
 	if (!cfg80211_chandef_identical(&chandef, &local->_oper_chandef))
 		local->hw.conf.flags |= IEEE80211_CONF_OFFCHANNEL;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 16d75da0996a..4eebee49bb7d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -162,6 +162,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	chandef->chan = channel;
 	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
 	chandef->center_freq1 = channel->center_freq;
+	chandef->freq1_offset = channel->freq_offset;
 
 	if (!ht_oper || !sta_ht_cap.ht_supported) {
 		ret = IEEE80211_STA_DISABLE_HT |
@@ -396,9 +397,12 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 		return 0;
 
 	sdata_info(sdata,
-		   "AP %pM changed bandwidth, new config is %d MHz, width %d (%d/%d MHz)\n",
-		   ifmgd->bssid, chandef.chan->center_freq, chandef.width,
-		   chandef.center_freq1, chandef.center_freq2);
+		   "AP %pM changed bandwidth, new config is %d.%03d MHz, "
+		   "width %d (%d.%03d/%d MHz)\n",
+		   ifmgd->bssid, chandef.chan->center_freq,
+		   chandef.chan->freq_offset, chandef.width,
+		   chandef.center_freq1, chandef.freq1_offset,
+		   chandef.center_freq2);
 
 	if (flags != (ifmgd->flags & (IEEE80211_STA_DISABLE_HT |
 				      IEEE80211_STA_DISABLE_VHT |
@@ -1364,10 +1368,14 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	if (!cfg80211_chandef_usable(local->hw.wiphy, &csa_ie.chandef,
 				     IEEE80211_CHAN_DISABLED)) {
 		sdata_info(sdata,
-			   "AP %pM switches to unsupported channel (%d MHz, width:%d, CF1/2: %d/%d MHz), disconnecting\n",
+			   "AP %pM switches to unsupported channel "
+			   "(%d.%03d MHz, width:%d, CF1/2: %d.%03d/%d MHz), "
+			   "disconnecting\n",
 			   ifmgd->associated->bssid,
 			   csa_ie.chandef.chan->center_freq,
+			   csa_ie.chandef.chan->freq_offset,
 			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
+			   csa_ie.chandef.freq1_offset,
 			   csa_ie.chandef.center_freq2);
 		ieee80211_queue_work(&local->hw,
 				     &ifmgd->csa_connection_drop_work);
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index fdac8192a519..4d14118dddca 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -896,6 +896,7 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 
 	local->scan_chandef.chan = chan;
 	local->scan_chandef.center_freq1 = chan->center_freq;
+	local->scan_chandef.freq1_offset = chan->freq_offset;
 	local->scan_chandef.center_freq2 = 0;
 	switch (scan_req->scan_width) {
 	case NL80211_BSS_CHAN_WIDTH_5:
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 427f51a0a994..1b4709694d2a 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -37,32 +37,42 @@
 #define VIF_PR_ARG	__get_str(vif_name), __entry->vif_type, __entry->p2p ? "/p2p" : ""
 
 #define CHANDEF_ENTRY	__field(u32, control_freq)					\
+			__field(u32, freq_offset)					\
 			__field(u32, chan_width)					\
 			__field(u32, center_freq1)					\
+			__field(u32, freq1_offset)					\
 			__field(u32, center_freq2)
 #define CHANDEF_ASSIGN(c)							\
 			__entry->control_freq = (c) ? ((c)->chan ? (c)->chan->center_freq : 0) : 0;	\
+			__entry->freq_offset = (c) ? ((c)->chan ? (c)->chan->freq_offset : 0) : 0;	\
 			__entry->chan_width = (c) ? (c)->width : 0;			\
 			__entry->center_freq1 = (c) ? (c)->center_freq1 : 0;		\
+			__entry->freq1_offset = (c) ? (c)->freq1_offset : 0;		\
 			__entry->center_freq2 = (c) ? (c)->center_freq2 : 0;
-#define CHANDEF_PR_FMT	" control:%d MHz width:%d center: %d/%d MHz"
-#define CHANDEF_PR_ARG	__entry->control_freq, __entry->chan_width,			\
-			__entry->center_freq1, __entry->center_freq2
+#define CHANDEF_PR_FMT	" control:%d.%03d MHz width:%d center: %d.%03d/%d MHz"
+#define CHANDEF_PR_ARG	__entry->control_freq, __entry->freq_offset, __entry->chan_width, \
+			__entry->center_freq1, __entry->freq1_offset, __entry->center_freq2
 
 #define MIN_CHANDEF_ENTRY								\
 			__field(u32, min_control_freq)					\
+			__field(u32, min_freq_offset)					\
 			__field(u32, min_chan_width)					\
 			__field(u32, min_center_freq1)					\
+			__field(u32, min_freq1_offset)					\
 			__field(u32, min_center_freq2)
 
 #define MIN_CHANDEF_ASSIGN(c)								\
 			__entry->min_control_freq = (c)->chan ? (c)->chan->center_freq : 0;	\
+			__entry->min_freq_offset = (c)->chan ? (c)->chan->freq_offset : 0;	\
 			__entry->min_chan_width = (c)->width;				\
 			__entry->min_center_freq1 = (c)->center_freq1;			\
+			__entry->freq1_offset = (c)->freq1_offset;			\
 			__entry->min_center_freq2 = (c)->center_freq2;
-#define MIN_CHANDEF_PR_FMT	" min_control:%d MHz min_width:%d min_center: %d/%d MHz"
-#define MIN_CHANDEF_PR_ARG	__entry->min_control_freq, __entry->min_chan_width,	\
-			__entry->min_center_freq1, __entry->min_center_freq2
+#define MIN_CHANDEF_PR_FMT	" min_control:%d.%03d MHz min_width:%d min_center: %d.%03d/%d MHz"
+#define MIN_CHANDEF_PR_ARG	__entry->min_control_freq, __entry->min_freq_offset,	\
+			__entry->min_chan_width,					\
+			__entry->min_center_freq1, __entry->min_freq1_offset,		\
+			__entry->min_center_freq2
 
 #define CHANCTX_ENTRY	CHANDEF_ENTRY							\
 			MIN_CHANDEF_ENTRY						\
@@ -412,6 +422,7 @@ TRACE_EVENT(drv_bss_info_changed,
 		__field(s32, cqm_rssi_hyst)
 		__field(u32, channel_width)
 		__field(u32, channel_cfreq1)
+		__field(u32, channel_cfreq1_offset)
 		__dynamic_array(u32, arp_addr_list,
 				info->arp_addr_cnt > IEEE80211_BSS_ARP_ADDR_LIST_LEN ?
 					IEEE80211_BSS_ARP_ADDR_LIST_LEN :
@@ -452,6 +463,7 @@ TRACE_EVENT(drv_bss_info_changed,
 		__entry->cqm_rssi_hyst = info->cqm_rssi_hyst;
 		__entry->channel_width = info->chandef.width;
 		__entry->channel_cfreq1 = info->chandef.center_freq1;
+		__entry->channel_cfreq1_offset = info->chandef.freq1_offset;
 		__entry->arp_addr_cnt = info->arp_addr_cnt;
 		memcpy(__get_dynamic_array(arp_addr_list), info->arp_addr_list,
 		       sizeof(u32) * (info->arp_addr_cnt > IEEE80211_BSS_ARP_ADDR_LIST_LEN ?
@@ -1223,6 +1235,7 @@ TRACE_EVENT(drv_remain_on_channel,
 		LOCAL_ENTRY
 		VIF_ENTRY
 		__field(int, center_freq)
+		__field(int, freq_offset)
 		__field(unsigned int, duration)
 		__field(u32, type)
 	),
@@ -1231,14 +1244,16 @@ TRACE_EVENT(drv_remain_on_channel,
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		__entry->center_freq = chan->center_freq;
+		__entry->freq_offset = chan->freq_offset;
 		__entry->duration = duration;
 		__entry->type = type;
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT  VIF_PR_FMT " freq:%dMHz duration:%dms type=%d",
+		LOCAL_PR_FMT  VIF_PR_FMT " freq:%d.%03dMHz duration:%dms type=%d",
 		LOCAL_PR_ARG, VIF_PR_ARG,
-		__entry->center_freq, __entry->duration, __entry->type
+		__entry->center_freq, __entry->freq_offset,
+		__entry->duration, __entry->type
 	)
 );
 
@@ -1546,8 +1561,10 @@ struct trace_vif_entry {
 
 struct trace_chandef_entry {
 	u32 control_freq;
+	u32 freq_offset;
 	u32 chan_width;
 	u32 center_freq1;
+	u32 freq1_offset;
 	u32 center_freq2;
 } __packed;
 
@@ -1597,18 +1614,26 @@ TRACE_EVENT(drv_switch_vif_chanctx,
 					sizeof(local_vifs[i].vif.vif_name));
 				SWITCH_ENTRY_ASSIGN(old_chandef.control_freq,
 						old_ctx->def.chan->center_freq);
+				SWITCH_ENTRY_ASSIGN(old_chandef.freq_offset,
+						old_ctx->def.chan->freq_offset);
 				SWITCH_ENTRY_ASSIGN(old_chandef.chan_width,
 						    old_ctx->def.width);
 				SWITCH_ENTRY_ASSIGN(old_chandef.center_freq1,
 						    old_ctx->def.center_freq1);
+				SWITCH_ENTRY_ASSIGN(old_chandef.freq1_offset,
+						    old_ctx->def.freq1_offset);
 				SWITCH_ENTRY_ASSIGN(old_chandef.center_freq2,
 						    old_ctx->def.center_freq2);
 				SWITCH_ENTRY_ASSIGN(new_chandef.control_freq,
 						new_ctx->def.chan->center_freq);
+				SWITCH_ENTRY_ASSIGN(new_chandef.freq_offset,
+						new_ctx->def.chan->freq_offset);
 				SWITCH_ENTRY_ASSIGN(new_chandef.chan_width,
 						    new_ctx->def.width);
 				SWITCH_ENTRY_ASSIGN(new_chandef.center_freq1,
 						    new_ctx->def.center_freq1);
+				SWITCH_ENTRY_ASSIGN(new_chandef.freq1_offset,
+						    new_ctx->def.freq1_offset);
 				SWITCH_ENTRY_ASSIGN(new_chandef.center_freq2,
 						    new_ctx->def.center_freq2);
 			}
-- 
2.20.1

