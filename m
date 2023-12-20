Return-Path: <linux-wireless+bounces-1122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463581AACC
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 00:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF86A1C22B4E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 23:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324A04BAAE;
	Wed, 20 Dec 2023 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WuXu8mYX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9C4BAA2;
	Wed, 20 Dec 2023 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 837767F5;
	Wed, 20 Dec 2023 22:57:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 837767F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1703113076; bh=FTflJJ/gBAnv1Hyfi9/f2DHUCIjnfK4oGhMjJoB3b58=;
	h=From:To:Cc:Subject:Date:From;
	b=WuXu8mYXLhT8PHeJGxfwgC7ecnTEFlSmZB3lBN8EMyth8JUL3JfypObV/vrXdm3aU
	 e0swOYVgPThkUNclWy7JDWLycmdLSKFwWPEAVBbhlTLfI7J7feVY2i92M9RD04HVG+
	 hFn8MtyeG4jz8GHJFavLGvGT6lPqZqkv0zbCXuoeU/ekc2Q8EBq9V4AqI2L5FR2F5E
	 KwfWNOPH7D0lw1ltDxBEEBhG49fZ73D9pRmvgYXcuKn4k+tnK1AKCNyeH4TiLM2xGb
	 4XA543u+u1tLZUqZjCCPqW7SBXBvgqLFKpUEykJvUh9zRrH0kcEcKGRt2+JufJDN/x
	 hvmnSw4KTp79A==
From: Jonathan Corbet <corbet@lwn.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
Subject: [PATCH net] wifi: mac80211: address some kerneldoc warnings
Date: Wed, 20 Dec 2023 15:57:55 -0700
Message-ID: <87zfy4bhxo.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

include/net/mac80111.h contains a number of either excess or incorrect
kerneldoc entries for structure members, leading to these warnings:

  ./include/net/mac80211.h:491: warning: Excess struct member 'rssi' description in 'ieee80211_event'
  ./include/net/mac80211.h:491: warning: Excess struct member 'mlme' description in 'ieee80211_event'
  ./include/net/mac80211.h:491: warning: Excess struct member 'ba' description in 'ieee80211_event'
  ./include/net/mac80211.h:777: warning: Excess struct member 'ack_enabled' description in 'ieee80211_bss_conf'
  ./include/net/mac80211.h:1222: warning: Excess struct member 'ampdu_ack_len' description in 'ieee80211_tx_info'
  ./include/net/mac80211.h:1222: warning: Excess struct member 'ampdu_len' description in 'ieee80211_tx_info'
  ./include/net/mac80211.h:1222: warning: Excess struct member 'ack_signal' description in 'ieee80211_tx_info'
  ./include/net/mac80211.h:2920: warning: Excess struct member 'radiotap_he' description in 'ieee80211_hw'

Fix or remove the entries as needed.  This change removes 208 warnings from
a "make htmldocs" build.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/net/mac80211.h | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 77a71b1396b1..6d2e94bc841c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -476,9 +476,9 @@ struct ieee80211_ba_event {
 /**
  * struct ieee80211_event - event to be sent to the driver
  * @type: The event itself. See &enum ieee80211_event_type.
- * @rssi: relevant if &type is %RSSI_EVENT
- * @mlme: relevant if &type is %AUTH_EVENT
- * @ba: relevant if &type is %BAR_RX_EVENT or %BA_FRAME_TIMEOUT
+ * @u.rssi: relevant if &type is %RSSI_EVENT
+ * @u.mlme: relevant if &type is %AUTH_EVENT
+ * @u.ba: relevant if &type is %BAR_RX_EVENT or %BA_FRAME_TIMEOUT
  * @u:union holding the fields above
  */
 struct ieee80211_event {
@@ -541,8 +541,6 @@ struct ieee80211_fils_discovery {
  * @link_id: link ID, or 0 for non-MLO
  * @htc_trig_based_pkt_ext: default PE in 4us units, if BSS supports HE
  * @uora_exists: is the UORA element advertised by AP
- * @ack_enabled: indicates support to receive a multi-TID that solicits either
- *	ACK, BACK or both
  * @uora_ocw_range: UORA element's OCW Range field
  * @frame_time_rts_th: HE duration RTS threshold, in units of 32us
  * @he_support: does this BSS support HE
@@ -1150,11 +1148,6 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
  * @ack: union part for pure ACK data
  * @ack.cookie: cookie for the ACK
  * @driver_data: array of driver_data pointers
- * @ampdu_ack_len: number of acked aggregated frames.
- * 	relevant only if IEEE80211_TX_STAT_AMPDU was set.
- * @ampdu_len: number of aggregated frames.
- * 	relevant only if IEEE80211_TX_STAT_AMPDU was set.
- * @ack_signal: signal strength of the ACK frame
  */
 struct ieee80211_tx_info {
 	/* common information */
@@ -2835,8 +2828,6 @@ enum ieee80211_hw_flags {
  *	the default is _GI | _BANDWIDTH.
  *	Use the %IEEE80211_RADIOTAP_VHT_KNOWN_\* values.
  *
- * @radiotap_he: HE radiotap validity flags
- *
  * @radiotap_timestamp: Information for the radiotap timestamp field; if the
  *	@units_pos member is set to a non-negative value then the timestamp
  *	field will be added and populated from the &struct ieee80211_rx_status
-- 
2.43.0


