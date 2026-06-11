Return-Path: <linux-wireless+bounces-37677-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k9pxCEngKmqDygMAu9opvQ
	(envelope-from <linux-wireless+bounces-37677-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 18:20:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1567367F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 18:20:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xo5L0Roc;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37677-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37677-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FC9930F34AC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4622D7B9;
	Thu, 11 Jun 2026 16:19:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0E426D09
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 16:19:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194796; cv=none; b=EHfMPxwhr374qBakl7MkOI5D5hcQjN5ccYMaMJZWdl06yJAR+sqrIrfdjQ02VGsTFSscp4W+Ub+N95M6ObuimwYi8puQDyqdpbFsSpIUjwNsJtyE5yds5e1zu1ku7rSUOVebdMPVtTOtB64a8vdALUgaRQ0a7ZjaovfUQRK9i2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194796; c=relaxed/simple;
	bh=DzgCdxPYJOePYwK5vrSfRjaSRfCOu+Wqxn9lMnTZ3f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js9GanfsVlsxG21O0gGtdP2yp/TjF9CuBe9+QHn7CjNTbE7BOx8qs0D3lbjGX9gqru1AQO6l66cH6WX7EByq9SHd6O6PQVKzS1TT4XivcC6mun7iKRvUCA7FvDmzEP60V5DrwS7DtogsX9Y+zrqjmGuGTiDcuoUhlVmwwJL3wto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo5L0Roc; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so76462a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194794; x=1781799594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJGGrvtsDjeSpn6534BCemT2I+fldwyUkxnGoTosm9g=;
        b=Xo5L0Roc6M6vw7fhReDKl82hMQXbTf2/0nOBnCadyQWavqIfafuk5emW+MTmTySG5f
         70A7soOA/MGOpaMnAupp+TSIMDqT2Ol7aoXJVFNA8Rr+huwSB8emUZTjefuhnYPopHzb
         /r9IKpIbPnMHi6TCxqPrRXpm+bvzGj6dJwpfLHbQW7QhIXZVYOp3CTQ/LpaZ4wgmWMmF
         +tDZaDeif4Q525YSjFodN3ikNI+TMaCRWahOLrCLYCdTTMZDKjnr2ls73OjiC1JQ53D1
         gPHoIXJs9dCjIjyRVI1z7J9AgFLg/ps7ugvt/hu0cv/HaFkAYT+UufkjOR3SfRahNGpl
         d5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194794; x=1781799594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJGGrvtsDjeSpn6534BCemT2I+fldwyUkxnGoTosm9g=;
        b=IW3csZK7hqCddtzC696MARZuf90P4540qxbNEn/bw5eKlHq9mxs3qiqA0k9X466SxR
         1c1ieYg8w+JdhUtu2viQOU7ZcCJUAjGOVsrh7H5T3ER8orBLcDtxqPlBDnkFROsXugpp
         9Ni8Mbt8Gy847PgCpJoaJ83HQEggkBe6Ac0m2o1vTvG7l8qgERga99yq/MXSaQ4inraE
         hRQoFrYZ9XQbYxQt+zXrsKy9FKjX1bvYXw5t7DHyg/m+ATfrJ/HBNmPPERQPj8cXf9hd
         DjeeuqrHJ3vJcNR9Eg0f/cUlCSoVC7A+v9wVKeY4+JIjseewQzwKOdUlwM5gHq5Fej92
         DVwg==
X-Forwarded-Encrypted: i=1; AFNElJ8av9InJhmsSaYeNofIaFkWzRa5e6Jp0CNa6tlZwLlArYvQgfsjW7xY2w2ZUrpVjgQQB6BMfaewKhjwzjtkFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1WS+DuBtUZIK25ub7PK1gr0rXNqyX2XmUqtWAU8y27aqqsTP
	8eUiP688g/OAgibDejD8tDPGHBTJSchW7HDxKPDBqxO2oRy0Gz9Yg3wn
X-Gm-Gg: Acq92OEs2JRRV8VJr9A+ipBhRz2xytf8VLz7Fh+eUx5dQwGe9ilIU+pjWMAODCTymuq
	zSlenfl6nmqISHX9Av/HO2SWmXROg5CKgNSCrKVwCDNOMoHSud7GrKKrovXAWAFEedRdpCTBTuC
	rx7a+Ov2UIDphFFg2hdSR8wqoM82WMQVM1eUmiPm6HLD1RQVgaC49AprTLm4+IEksSmhWne0u21
	XQnBFhOYd9EAFNK0O4r4KWUmYQ6PMuS+Z9JxPh15cWAHd1Rad9Y5Dx0AgkGyX/9Fudu0hZSSfz1
	o2IGi4fRbOhmo7nIqfteyvuoxOSNrkkQb7tulwA0oTcoVZq0DrVmlVw53iEY3DkY+d7JgMl63Fw
	wJx8JatWmlvvAGmrlBXI8pVyw700nFUFjhWdX18WHyhpk5aAcT8GChgk0lUYIxngznqUCf5vXtE
	+4ltmYwf7zhCtomkloH6NxLZTwKddLOhEyuJ57y2cUhrqXpU+IJQw2CI2FjOARLqU=
X-Received: by 2002:a05:6a20:918b:b0:3b3:223f:d3f1 with SMTP id adf61e73a8af0-3b5e32009acmr3985763637.18.1781194794267;
        Thu, 11 Jun 2026 09:19:54 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865881640bsm2871231a12.26.2026.06.11.09.19.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 09:19:53 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Pedersen <thomas@adapt-ip.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: mac80211: validate extension-frame layout before RX
Date: Fri, 12 Jun 2026 00:19:45 +0800
Message-ID: <20260611161943.91069-5-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260611161943.91069-4-enderaoelyther@gmail.com>
References: <20260610162700.58722-1-enderaoelyther@gmail.com>
 <20260611161943.91069-4-enderaoelyther@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[adapt-ip.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37677-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AD1567367F

Extension frames only have the extension header at the regular 802.11
header offset. The generic RX path can still reach helpers and interface
dispatch code that read regular header address fields before unsupported
extension subtypes are dropped.

mac80211 currently only handles S1G beacon extension frames. Drop other
extension subtypes before they can reach regular-header RX processing.
For S1G beacons, linearize the SKB with the management-frame path and
require the fixed S1G beacon header, including optional fixed fields
indicated by frame control, before generic RX dispatch.

Route S1G beacons through the station/default-link RX path without
regular-header station lookup. Avoid regular-header address reads in the
mac80211 RX paths that process S1G extension beacons, including
accept-frame, duplicate-detection, address-copy, and MLO
address-translation paths.

Also make ieee80211_get_bssid() length-safe before returning the S1G
source-address pointer.

Fixes: 09a740ce352e ("mac80211: receive and process S1G beacons")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/mac80211/rx.c   | 34 ++++++++++++++++++++++++++++++++--
 net/mac80211/util.c |  3 +++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3fb40449c6c5c..3ddde3e808364 100644
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
@@ -4487,12 +4490,16 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	u8 *bssid = ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
-	bool multicast = is_multicast_ether_addr(hdr->addr1) ||
-			 ieee80211_is_s1g_beacon(hdr->frame_control);
+	bool multicast;
 	static const u8 nan_network_id[ETH_ALEN] __aligned(2) = {
 		0x51, 0x6F, 0x9A, 0x01, 0x00, 0x00
 	};
 
+	if (ieee80211_is_s1g_beacon(hdr->frame_control))
+		return sdata->vif.type == NL80211_IFTYPE_STATION && bssid;
+
+	multicast = is_multicast_ether_addr(hdr->addr1);
+
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
 		if (!bssid && !sdata->u.mgd.use_4addr)
@@ -5174,6 +5181,11 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 		hdr = (struct ieee80211_hdr *)rx->skb->data;
 	}
 
+	if (ieee80211_is_s1g_beacon(hdr->frame_control)) {
+		ieee80211_invoke_rx_handlers(rx);
+		return true;
+	}
+
 	/* Store a copy of the pre-translated link addresses for SW crypto */
 	if (unlikely(is_unicast_ether_addr(hdr->addr1) &&
 		     !ieee80211_is_data(hdr->frame_control)))
@@ -5263,6 +5275,13 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	struct sta_info *sta;
 	int link_id = -1;
 
+	if (ieee80211_is_s1g_beacon(hdr->frame_control)) {
+		if (!ieee80211_rx_data_set_sta(rx, NULL, -1))
+			return false;
+
+		return ieee80211_prepare_and_rx_handle(rx, skb, consume);
+	}
+
 	/*
 	 * Look up link station first, in case there's a
 	 * chance that they might have a link address that
@@ -5338,6 +5357,17 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			err = -ENOBUFS;
 		else
 			err = skb_linearize(skb);
+	} else if (ieee80211_is_s1g_beacon(fc)) {
+		size_t s1g_hdr_len = offsetof(struct ieee80211_ext,
+					      u.s1g_beacon.variable) +
+				     ieee80211_s1g_optional_len(fc);
+
+		if (skb->len < s1g_hdr_len)
+			err = -ENOBUFS;
+		else
+			err = skb_linearize(skb);
+	} else if (ieee80211_is_ext(fc)) {
+		err = -EINVAL;
 	} else {
 		err = !pskb_may_pull(skb, ieee80211_hdrlen(fc));
 	}
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

