Return-Path: <linux-wireless+bounces-23567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597FACCB07
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 18:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58DA3A7629
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69B231833;
	Tue,  3 Jun 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="AemH8r5i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8F23D29C
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967111; cv=none; b=gyFxMjFEZctGF37BTi8IIQO/VKsPtbeFsByT362Hg1deeslLrfKe7j0oY/vq6fU0LN9A3RvKHMYGgf/RR1PhQaFY3/X8jI+yT6jku5euu1mChFgNE6muwdxulw+dSYDh6jF4rsWloZgsdJHMLfClqraOH0WNV5noKh8ObtOheLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967111; c=relaxed/simple;
	bh=7XqlJfRgRIX0pstX7WaOyPwSbl9XAeObAjT0ItKJ0zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gkb5B/RwJUSR7kFohq03kgkN4Qdc4sp5jAuvv/LfUvcVQrBmALXBq07L6MAcBg//rh9K9Yw1DjHXiQxarPt88I6gbomYcuN2XQenraoLYOJFO+zFLBojwkxooJUN2rO0zb/wC5T/trXmhAgjiGmI62+fbyQM+6h0aG4radLm5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=AemH8r5i; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748967110; x=1780503110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7XqlJfRgRIX0pstX7WaOyPwSbl9XAeObAjT0ItKJ0zg=;
  b=AemH8r5iRWxiWo6VDFmyu4F2pBjNslgcblN2x8tZQl9ctvllHTnu+dWp
   4Ilp/0/Kjj1tM0Zyv9lJV6Q4/ZPDp3Il3MBGnxL9AwJ9SY1AAN/zDBedv
   aznr8wgo8eyKus1c6YP5YQF6Uu3TrMChDOsxmbKiBPT9XVV10RjyZpfwf
   g=;
X-CSE-ConnectionGUID: DZcDCEJIT7u064jNGEPUFA==
X-CSE-MsgGUID: 7a1T5JUnRsS0VB7qGH/cvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="97700377"
X-IronPort-AV: E=Sophos;i="6.16,206,1744063200"; 
   d="scan'208";a="97700377"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:11:48 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 18:11:47 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 18:11:44 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v3 5/5] wifi: mac80211: reject SET_BSS if any changed AP BSS param is not supported
Date: Tue, 3 Jun 2025 21:40:57 +0530
Message-ID: <20250603161057.19101-6-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603161057.19101-1-gokulkumar.sivakumar@infineon.com>
References: <20250603161057.19101-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE827.infineon.com (172.23.29.20)

The userspace can change more than one AP BSS Parameter in the SET_BSS
operation. Incase if any BSS param other than the list of parameters
currently supported for explicit configuration are passed by userspace,
reject the entire SET_BSS operation.

Also add an individual check for the CFG80211_BSS_PARAM_CHANGED_* flag
before handling the corresponding AP BSS param value from the userspace.
This addresses the case where driver unnecessarily checks the value of all
the supported AP BSS params, even if the userspace did not pass some of
those params in the SET_BSS request.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 net/mac80211/cfg.c | 54 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9d88f2f2831..8bbf9730dd0e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2751,6 +2751,20 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	struct ieee80211_supported_band *sband;
 	u64 changed = 0;
 
+	/* Reject the operation if any of the AP BSS params that got changed are not
+	 * supported by the driver for explicit configuration.
+	 */
+	if (params->changed &
+	    ~(CFG80211_BSS_PARAM_CHANGED_CTS_PROT |
+	      CFG80211_BSS_PARAM_CHANGED_SHORT_PREAMBLE |
+	      CFG80211_BSS_PARAM_CHANGED_SHORT_SLOT_TIME |
+	      CFG80211_BSS_PARAM_CHANGED_BASIC_RATES |
+	      CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE |
+	      CFG80211_BSS_PARAM_CHANGED_HT_OPMODE |
+	      CFG80211_BSS_PARAM_CHANGED_P2P_CTWINDOW |
+	      CFG80211_BSS_PARAM_CHANGED_P2P_OPPPS))
+		return -EOPNOTSUPP;
+
 	link = ieee80211_link_or_deflink(sdata, params->link_id, true);
 	if (IS_ERR(link))
 		return PTR_ERR(link);
@@ -2762,7 +2776,8 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	if (!sband)
 		return -EINVAL;
 
-	if (params->basic_rates) {
+	if (params->changed &
+	    CFG80211_BSS_PARAM_CHANGED_BASIC_RATES) {
 		if (!ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
 					      wiphy->bands[sband->band],
 					      params->basic_rates,
@@ -2773,11 +2788,13 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		ieee80211_check_rate_mask(link);
 	}
 
-	if (params->use_cts_prot >= 0) {
+	if (params->changed &
+	    CFG80211_BSS_PARAM_CHANGED_CTS_PROT) {
 		link->conf->use_cts_prot = params->use_cts_prot;
 		changed |= BSS_CHANGED_ERP_CTS_PROT;
 	}
-	if (params->use_short_preamble >= 0) {
+	if (params->changed &
+	    CFG80211_BSS_PARAM_CHANGED_SHORT_PREAMBLE) {
 		link->conf->use_short_preamble = params->use_short_preamble;
 		changed |= BSS_CHANGED_ERP_PREAMBLE;
 	}
@@ -2789,12 +2806,14 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		changed |= BSS_CHANGED_ERP_SLOT;
 	}
 
-	if (params->use_short_slot_time >= 0) {
+	if (params->changed &
+	    CFG80211_BSS_PARAM_CHANGED_SHORT_SLOT_TIME) {
 		link->conf->use_short_slot = params->use_short_slot_time;
 		changed |= BSS_CHANGED_ERP_SLOT;
 	}
 
-	if (params->ap_isolate >= 0) {
+	if (params->changed &
+	    CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE) {
 		if (params->ap_isolate)
 			sdata->flags |= IEEE80211_SDATA_DONT_BRIDGE_PACKETS;
 		else
@@ -2802,12 +2821,14 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		ieee80211_check_fast_rx_iface(sdata);
 	}
 
-	if (params->ht_opmode >= 0) {
+	if (params->changed &
+	    CFG80211_BSS_PARAM_CHANGED_HT_OPMODE) {
 		link->conf->ht_operation_mode = (u16)params->ht_opmode;
 		changed |= BSS_CHANGED_HT;
 	}
 
-	if (params->p2p_ctwindow >= 0) {
+	if (params->changed &
+	    CFG80211_BSS_PARAM_CHANGED_P2P_CTWINDOW) {
 		link->conf->p2p_noa_attr.oppps_ctwindow &=
 					~IEEE80211_P2P_OPPPS_CTWINDOW_MASK;
 		link->conf->p2p_noa_attr.oppps_ctwindow |=
@@ -2815,14 +2836,17 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		changed |= BSS_CHANGED_P2P_PS;
 	}
 
-	if (params->p2p_opp_ps > 0) {
-		link->conf->p2p_noa_attr.oppps_ctwindow |=
-					IEEE80211_P2P_OPPPS_ENABLE_BIT;
-		changed |= BSS_CHANGED_P2P_PS;
-	} else if (params->p2p_opp_ps == 0) {
-		link->conf->p2p_noa_attr.oppps_ctwindow &=
-					~IEEE80211_P2P_OPPPS_ENABLE_BIT;
-		changed |= BSS_CHANGED_P2P_PS;
+	if (params->changed &
+	    CFG80211_BSS_PARAM_CHANGED_P2P_OPPPS) {
+		if (params->p2p_opp_ps > 0) {
+			link->conf->p2p_noa_attr.oppps_ctwindow |=
+						IEEE80211_P2P_OPPPS_ENABLE_BIT;
+			changed |= BSS_CHANGED_P2P_PS;
+		} else if (params->p2p_opp_ps == 0) {
+			link->conf->p2p_noa_attr.oppps_ctwindow &=
+						~IEEE80211_P2P_OPPPS_ENABLE_BIT;
+			changed |= BSS_CHANGED_P2P_PS;
+		}
 	}
 
 	ieee80211_link_info_change_notify(sdata, link, changed);
-- 
2.47.0


