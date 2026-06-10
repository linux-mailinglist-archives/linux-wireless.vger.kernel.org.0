Return-Path: <linux-wireless+bounces-37637-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xZYrMJ6UKWosaAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37637-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 18:45:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF97866BA13
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 18:45:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="qH0U4B9/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37637-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37637-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8DD8305E763
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29100331200;
	Wed, 10 Jun 2026 16:27:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DDE32B10A
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 16:27:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108830; cv=none; b=kA9nv0Tyq5AKahygYHMl7waKick00BrD+nmUK6Q+x1Xc+U/PV/Y42BZ03D3DaomGltOSAsmkvC0ZDzUV4bBFWkrp5YYhoFk72+fPBsCYUNr/K7b22+9qIPVq323aOp8kvQ3JTW9cNGgJZbZ1+3/2ZjYtW8j4FtBIhwVxmRPohp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108830; c=relaxed/simple;
	bh=B78wIJqXokp8mpXgkSEPkPvItVTtbIMo5Q1GjtZt0EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=buIloHgxtm44sRC4btAUbzTGlwuF+Bon7IBFG2aVOyuoHmBpCaeqtiwQupREZ0R/AV04gbFcXG21YsL9cE9pn1s4pCChms0Djf7xGE5adX8UtTk2Xmj+v/ItERpVpxD80SRIAKfbsWCspfKIFSpmXd0QI/HwE0S3jUbPNAu3LXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qH0U4B9/; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so4216559a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781108828; x=1781713628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+erzCBLFlOAKM2dQsuv+OuH5Up4E4JpQcVQ6GV+20g=;
        b=qH0U4B9/vyOcYcbdFlnTjLMWt0jeVacI6FfXwRqZSe06n6pWqemhkrI6w2IMdpkWh3
         g4PH0oqU5tEjD75p0jSdGwX+fqsl4BEJ0X0a5e9ZWCLrchTlrBD9vrR6Q1514e1TAwe8
         PRsTq49lyzPLyb/6J1yFQGD2qxfWBL2uItOkJOnl8KBjokp+uNolDJgqp+qgLAA1f50B
         3/df3onk4FRPbhdLu42Op6fLFJEXv3CXqB5ElfWplVnbcMRFm0OljEXKtCtFCLFGIKAp
         xIsaVskr/2R2kjWcbyP61BT64QKnz+OKhCrvUK2+xtnd/FKbxp0yJ0VbBZFtWXwBZDFt
         PQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108828; x=1781713628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+erzCBLFlOAKM2dQsuv+OuH5Up4E4JpQcVQ6GV+20g=;
        b=eL4HCbnogAUfCMn3f3F3R1G7b1qKbCv7oo1kONjjrgd2/LJL5LPjHM948qPkJdR6hY
         wo5HrZR6kezoZUg3KEP+QFQ1hqh+5lRWY9AMNnUE5mYSuXgND8V8dr3m+x5cesG2n/P0
         Zpuc9zd0i/hsvSTXOu8e2ueG/xrck8YVOJYoAEfRRcP+43mXnIjHZ1HdZxjvzc5VAfYj
         xT6R+X6yVE1Dpe3UbYKS6SgTmo3r1tY6N6aMZZldi0tuNTTZ4lKUM7MWu1cDk1+OhrVY
         pYVEk+Ccosgid8xjmNFwk1e6Huh3B6BmS3fwq50pNMVLMHThtVv12/b0uA9OPkiyq3Zb
         iz0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+4iyjlSxSHPCmrqOcTLxvzuK9xEphHcuzmINCvW+jdzKf3oGButU8KR9189C6taEMzuwHPl1KALb9jBt2ogw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvYDoOivtt6uLLoaBU82sEZozFV3lWL2TQgPwo/TeLcgWUNks/
	yqcqU8uVSpM52tIDz0lSkoBgOl9XIIMlQDu3BJ+3r2YN3mJp2dL71EZZ
X-Gm-Gg: Acq92OHN5mlwc5qGuSXudstfQGVZNoheAu4l8xGuxt/jjWUhDTLvdMvWWiPyTTk4TID
	3fHBX2UC2PWz0OWN7dAMRUA5NJboZZl4R0+YcslxhCCZ6KyFJtSl91TOdRNXsQSxdB7gFiVjkVg
	jX+KHNLDqBpXE+7rQtayR4wN3iwL2DXHxL95oh/1j3I5X+UE343pC0q29CcvsyC8atvskPE8B57
	0bP6+naivCCBwMZhikDZAw50Q/ul8lNUkB2Pxp1o1+OWOuj5cD7iMELeuYp6dtXKWnBKMaiDKr/
	92nlW9/BwdgJUJxP78EOr1MnE7PhN294oX/jvN7ehhJEPd+8dHZvlDiDmipqi0qBhNeLE5o7Gbr
	kVtHyEC2TSDjp42xf46T4yqsMYLMPHVYi6za4MQir/wq40OomMrHDypdv0Qiv72OYHqvr3tbouH
	yuySCLvMuYL6wphuDBKmmrnOE9+Rhz19/Qg+zewFktu18Wiqu76OKbKnEBwMof2MiOux+Szt4eP
	w==
X-Received: by 2002:a17:90b:5787:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-370f0d52f5cmr28362494a91.23.1781108828061;
        Wed, 10 Jun 2026 09:27:08 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772ca3047fsm234011a91.9.2026.06.10.09.27.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 09:27:07 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Pedersen <thomas@adapt-ip.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: validate S1G beacon length before RX
Date: Thu, 11 Jun 2026 00:27:00 +0800
Message-ID: <20260610162700.58722-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[adapt-ip.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37637-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:thomas@adapt-ip.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:enderaoelyther@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,s1g_beacon.sa:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF97866BA13

S1G beacons are extension frames, so ieee80211_hdrlen() only guarantees
the extension header before the generic RX path starts dispatching the
frame.

The RX path can then reach helpers and interface handling code that read
regular 802.11 header address fields, which are not present at those
offsets in an S1G beacon.

Pull the complete S1G beacon fixed header, including optional fixed
fields indicated by frame control, before generic RX dispatch.

Also make ieee80211_get_bssid() length-safe for S1G beacons and avoid
regular-header address reads for S1G frames in accept/interface/MLO
address handling. Skip extension frames in duplicate detection for the
same reason, since that path consumes the regular sequence-control field.

Fixes: 09a740ce352e ("mac80211: receive and process S1G beacons")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 include/linux/ieee80211.h | 13 +++++++++++++
 net/mac80211/rx.c         | 33 ++++++++++++++++++++++++++++-----
 net/mac80211/util.c       |  3 +++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 23f9df9be8372..baee81fbb4a79 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2855,6 +2855,19 @@ struct ieee80211_tbtt_info_ge_11 {
 #include "ieee80211-p2p.h"
 #include "ieee80211-nan.h"
 
+/**
+ * ieee80211_s1g_beacon_min_len - minimum length of an S1G beacon frame
+ * @fc: frame control bytes in little-endian byteorder
+ *
+ * Return: the minimum frame length containing the fixed S1G beacon fields and
+ * optional fixed fields indicated in the S1G beacon frame control.
+ */
+static inline size_t ieee80211_s1g_beacon_min_len(__le16 fc)
+{
+	return offsetof(struct ieee80211_ext, u.s1g_beacon.variable) +
+	       ieee80211_s1g_optional_len(fc);
+}
+
 /**
  * ieee80211_check_tim - check if AID bit is set in TIM
  * @tim: the TIM IE
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3fb40449c6c5c..2e6d0ce8509e4 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1526,6 +1526,9 @@ ieee80211_rx_h_check_dup(struct ieee80211_rx_data *rx)
 	if (status->flag & RX_FLAG_DUP_VALIDATED)
 		return RX_CONTINUE;
 
+	if (ieee80211_is_ext(hdr->frame_control))
+		return RX_CONTINUE;
+
 	/*
 	 * Drop duplicate 802.11 retransmissions
 	 * (IEEE 802.11-2012: 9.3.2.10 "Duplicate detection and recovery")
@@ -4487,12 +4490,17 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	u8 *bssid = ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
-	bool multicast = is_multicast_ether_addr(hdr->addr1) ||
-			 ieee80211_is_s1g_beacon(hdr->frame_control);
+	bool s1g = ieee80211_is_s1g_beacon(hdr->frame_control);
+	bool multicast;
 	static const u8 nan_network_id[ETH_ALEN] __aligned(2) = {
 		0x51, 0x6F, 0x9A, 0x01, 0x00, 0x00
 	};
 
+	if (s1g)
+		return sdata->vif.type == NL80211_IFTYPE_STATION && bssid;
+
+	multicast = is_multicast_ether_addr(hdr->addr1);
+
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
 		if (!bssid && !sdata->u.mgd.use_4addr)
@@ -5175,11 +5183,13 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 	}
 
 	/* Store a copy of the pre-translated link addresses for SW crypto */
-	if (unlikely(is_unicast_ether_addr(hdr->addr1) &&
+	if (unlikely(!ieee80211_is_s1g_beacon(hdr->frame_control) &&
+		     is_unicast_ether_addr(hdr->addr1) &&
 		     !ieee80211_is_data(hdr->frame_control)))
 		memcpy(rx->link_addrs, &hdr->addrs, 3 * ETH_ALEN);
 
 	if (unlikely(rx->sta && rx->sta->sta.mlo) &&
+	    !ieee80211_is_s1g_beacon(hdr->frame_control) &&
 	    is_unicast_ether_addr(hdr->addr1) &&
 	    !ieee80211_is_probe_resp(hdr->frame_control) &&
 	    !ieee80211_is_beacon(hdr->frame_control)) {
@@ -5260,23 +5270,30 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 {
 	struct link_sta_info *link_sta;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
+	u8 *sta_addr = hdr->addr2;
 	struct sta_info *sta;
 	int link_id = -1;
 
+	if (ieee80211_is_s1g_beacon(hdr->frame_control)) {
+		sta_addr = ieee80211_get_bssid(hdr, skb->len, rx->sdata->vif.type);
+		if (!sta_addr)
+			return false;
+	}
+
 	/*
 	 * Look up link station first, in case there's a
 	 * chance that they might have a link address that
 	 * is identical to the MLD address, that way we'll
 	 * have the link information if needed.
 	 */
-	link_sta = link_sta_info_get_bss(rx->sdata, hdr->addr2);
+	link_sta = link_sta_info_get_bss(rx->sdata, sta_addr);
 	if (link_sta) {
 		sta = link_sta->sta;
 		link_id = link_sta->link_id;
 	} else {
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
-		sta = sta_info_get_bss(rx->sdata, hdr->addr2);
+		sta = sta_info_get_bss(rx->sdata, sta_addr);
 		if (status->link_valid) {
 			link_id = status->link_id;
 		} else if (ieee80211_vif_is_mld(&rx->sdata->vif) &&
@@ -5347,6 +5364,12 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		return;
 	}
 
+	if (ieee80211_is_s1g_beacon(fc) &&
+	    !pskb_may_pull(skb, ieee80211_s1g_beacon_min_len(fc))) {
+		dev_kfree_skb(skb);
+		return;
+	}
+
 	hdr = (struct ieee80211_hdr *)skb->data;
 	ieee80211_parse_qos(&rx);
 	ieee80211_verify_alignment(&rx);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2529b01e2cd55..5bc719222a87d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -73,6 +73,9 @@ u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
 	if (ieee80211_is_s1g_beacon(fc)) {
 		struct ieee80211_ext *ext = (void *) hdr;
 
+		if (len < offsetofend(struct ieee80211_ext, u.s1g_beacon.sa))
+			return NULL;
+
 		return ext->u.s1g_beacon.sa;
 	}
 
-- 
2.50.1 (Apple Git-155)

