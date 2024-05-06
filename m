Return-Path: <linux-wireless+bounces-7252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DFE8BD5EA
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45D21F22AC8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6FB15B0F5;
	Mon,  6 May 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C1t7g44q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA719DDC7
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025351; cv=none; b=CSCA4kfIr9JyjHMkNnEqyMjUUPrctBY4trBmuG8S7Qj/XCeUCJgzmFBDI11RR6aZ1hbloKKDA+RvfYEm9Hq/TnsgoJtdqkGp1eyTZU9jthnKDc4aZpc48bhrKffIrU1l0G5h6ohlspPbexKa+2vvTVNUAz/1EgtHGqFzTTOD9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025351; c=relaxed/simple;
	bh=LtwyghYTYaUOTt3ERRmCbvcwaR8tc0RJXPOJQMy9Fc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLpYjdAAcH6ibFj6naDxeEd6w+22iy80BNvjqv2mrmyRYelCoDLSv/3vrZsrNo48ppDArQrA1f9Ca6fH+nS9f3evlR0krUIm9LxZ+qf8pjoVida0CEUjPPJ0iiw4Wz5IcPEWT81NRYenr39zxjJH4YZPuPFZ7qH9CdlQDcRKnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C1t7g44q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ma+thRVJgmmT8oigZ59Y9Fe79rPtgHagoTjBCRuvx6E=;
	t=1715025349; x=1716234949; b=C1t7g44qoYLHRTYId+ZZRasvbOHFHyEVhqin+ilXmqmbiL/
	16WYJ5QP3VoI9fmX30gPnQnU6j2zcR8eHO/wHJjgejW+r3yoOzv69ipGO2O9PXK00e8GPe2gLjr44
	P2ai9nQ4+dOEaJ/E+fl19KahNFTQ7qF1iUfX8UcicIP/7sRgus/htPgQXXqTvMGL1t5h/JAnVLGH1
	mrcRvA38ffrnbhZrXNgRrjbvhG5RwTES+X9TloBNEJlxchIs2eXnlWnXux6zL0M9aLe1/zIb6poeI
	KLCKaFRg2uTIjp5Iz6smIC1x1GfybtjsRXRLwDMpLSwoqGrSdGy7EE7XXKZNzldg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s44R9-00000008Cj6-00eS;
	Mon, 06 May 2024 21:55:47 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 3/4] wifi: mac80211: handle TPE element during CSA
Date: Mon,  6 May 2024 21:54:51 +0200
Message-ID: <20240506215543.486c33157d18.Idf971ad801b6961c177bdf42cc323fd1a4ca8165@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506195543.104411-6-johannes@sipsolutions.net>
References: <20240506195543.104411-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Handle the transmit power envelope (TPE) element during
channel switch, applying it when the channel switch is
done.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/mlme.c        | 18 ++++++++++++++++++
 net/mac80211/parse.c       |  8 ++++++++
 3 files changed, 29 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cba1c2c3d9f1..76965d64a0fa 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -977,6 +977,8 @@ struct ieee80211_link_data_managed {
 
 	struct {
 		struct wiphy_delayed_work switch_work;
+		struct cfg80211_chan_def ap_chandef;
+		struct ieee80211_parsed_tpe tpe;
 		unsigned long time;
 		bool waiting_bcn;
 		bool ignored_same_chan;
@@ -1754,6 +1756,7 @@ struct ieee802_11_elems {
 
 	/* not the order in the psd values is per element, not per chandef */
 	struct ieee80211_parsed_tpe tpe;
+	struct ieee80211_parsed_tpe csa_tpe;
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f81e4f82ed7b..77d690323006 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2129,6 +2129,20 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 
 	link->u.mgd.csa.waiting_bcn = true;
 
+	/* apply new TPE restrictions immediately on the new channel */
+	if (link->u.mgd.csa.ap_chandef.chan->band == NL80211_BAND_6GHZ &&
+	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HE) {
+		ieee80211_rearrange_tpe(&link->u.mgd.csa.tpe,
+					&link->u.mgd.csa.ap_chandef,
+					&link->conf->chanreq.oper);
+		if (memcmp(&link->conf->tpe, &link->u.mgd.csa.tpe,
+			   sizeof(link->u.mgd.csa.tpe))) {
+			link->conf->tpe = link->u.mgd.csa.tpe;
+			ieee80211_link_info_change_notify(sdata, link,
+							  BSS_CHANGED_TPE);
+		}
+	}
+
 	ieee80211_sta_reset_beacon_monitor(sdata);
 	ieee80211_sta_reset_conn_monitor(sdata);
 }
@@ -2379,6 +2393,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 			ch_switch.count = csa_ie.count;
 			ch_switch.delay = csa_ie.max_switch_time;
 		}
+
+		link->u.mgd.csa.tpe = csa_elems->csa_tpe;
 	} else {
 		/*
 		 * If there was no per-STA profile for this link, we
@@ -2517,6 +2533,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		goto drop_connection;
 	}
 
+	link->u.mgd.csa.ap_chandef = csa_ie.chanreq.ap;
+
 	link->csa.chanreq = csa_ie.chanreq;
 	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT ||
 	    sdata->vif.driver_flags & IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW)
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 6efeb977f8e5..5c5c21ecb2b7 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -607,6 +607,13 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 					elem_parse_failed =
 						IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			}
+
+			subelem = cfg80211_find_ext_elem(WLAN_EID_TX_POWER_ENVELOPE,
+							 pos, elen);
+			if (subelem)
+				ieee80211_parse_tpe(&elems->csa_tpe,
+						    subelem->data + 1,
+						    subelem->datalen - 1);
 			break;
 		case WLAN_EID_COUNTRY:
 			elems->country_elem = pos;
@@ -962,6 +969,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 
 	/* set all TPE entries to unlimited (but invalid) */
 	ieee80211_clear_tpe(&elems->tpe);
+	ieee80211_clear_tpe(&elems->csa_tpe);
 
 	nontransmitted_profile = elems_parse->scratch_pos;
 	nontransmitted_profile_len =
-- 
2.44.0


