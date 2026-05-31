Return-Path: <linux-wireless+bounces-37187-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOWMK+LXG2qnGgkAu9opvQ
	(envelope-from <linux-wireless+bounces-37187-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 08:40:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4494A614B5C
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 08:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7C7D3015338
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB1346769;
	Sun, 31 May 2026 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkwJipTZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02423264EF
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209631; cv=none; b=YrOOhwuinUPNbZ5JI/y5MLyb1mwM8Sf/P8HzPp9PQqz+Cym+X2M52yKi0qCd7KzUBe+jbyTMX6hRKohFS2JCO0x/e2uvdCJ6WG3yHUdponDIh6G3oNinNwis+WkSeJzfESziofHeZ4m1iemu6wr3K5e8yGhSzU+GppisSb18g/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209631; c=relaxed/simple;
	bh=LZmZfkQmuN3VNRFDjIwDh3tNUudILrdJSAtZCAhlAWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JloaEkCZ0cpXtIuv4iBCFLab50DdKMS0hZcKgMCeqL8RNYomQP8QGOkw9Bf202gfG477MDs6yXaxqIyn7FfeChRTDgeB5xTj246cjOizmeW7yBl1fSHT9k1wyO7ffvV5gZLgicLo9VZUybGHKXxLqtE727n1cJAeeg9al9A9arU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkwJipTZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so191459a91.2
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 23:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780209629; x=1780814429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpBWqlx616rQwX3V1Lhl7OVg5XW9+mDzkeXGhG0RAsI=;
        b=mkwJipTZYvUMrJ2FPsKrLlZfjxDOICl9gGOvQMIuZLxiXxe9GeED9rVgrpere46/Gd
         rXZ1PGFnbmznDN+dHVYfUnMmj40ExoGN4GAcezLLaZF1w9K63WvoF1e3Gidcb+zhThBB
         sW8w3HdGvBvJYggjVOiRybLdL+xAixuT73lKX7+um/+qrYanmp93vUw27JwZNpahJtiu
         fd1qLDfQw6ZTJmI6Pd7LVJGHEGWAQZTnR8h8ebb1SA9GPQfD+uKAvEIaDSQReh3Am5mw
         OZ2z0Rc3p4aAXsMlDxlTURUoTqHSyQm0noeZ07jCYy2tOJR1LcHZx/sqhnBIqvVTBezi
         uMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209629; x=1780814429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpBWqlx616rQwX3V1Lhl7OVg5XW9+mDzkeXGhG0RAsI=;
        b=nHqhcDiKw82I1zFeiMWN2xe/owP/D5j1hXDgKs0HS5gizM8h8E2xW6YuhzsUQCrU+T
         UKAKqMmYKjs1TTEgTAG+KaJVxngrhl4R6cXjEfWnUMplydSntCWzsxAMSoQjLXXGP4/P
         aoTjPtrGTd/ZUWKDYI+7PewJeqtlyF/E3fFio2g8r+bfAKU7nWgMNvuJOF46dKBn1RW4
         Cz95AkDzBkWKzzz6C2miP7SeG4xBKn3Wejuvfe4w2/2cpqVhYglwKCeah/YjkT5ww6r4
         1mC8Te6G7qz4chLRfL9SxaYi/tH/3Boef/8pUluwmx4P4LHM2VfmwZVwb95UksQGHGl1
         KFsg==
X-Forwarded-Encrypted: i=1; AFNElJ8+rbiGiUQ+FDznY0NiE5/3iX4Pyd0cRuDnMtqc9pxVzsvO726ZP04rKduRjTVcB6N2R6WXj5jwLCUVKzeBjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OfEABaAlvEIQ7hUL8mdklX3ca94OJjSPVoR7pF3xjKhd73nv
	EPQZpeKcwDjL9UTIzLhJzaYuswtkmqb6kUrIuP3KqlbYvYodCjDUdWDr
X-Gm-Gg: Acq92OE45SMWW5a/NMTKIvAJ7L7rZql7+9aS94oYKbaxaXmMDn1sUenj5VqyVZ8WfzP
	p5k99Mc/vR8tfGd1X0r1Nn0z1MjlcQFM7zJc3SDNdKkanWkBVrp1IkIjg3F4LhoRFDGE/96J4Ft
	j0gS+yqf3jcTPmko40YjoSo0rWrk4kl2SQ9l/Ln8ep4wyCMHambkIjNeGVb4D3+hqTXNO1Suzo9
	gZBmnfWlIMEQOCesz/O1SJUmFnGXJ86pWwg6TVEZFN0vPporXE69YGeX8gdeWBi3ip30pzOipZc
	grtQKc/gfwni2IQa0hzvlnlin6lXy7fdRd49BrCO7ZSVx6fCxteCHvGYJrjlFJzCaTaHPxE4aI7
	tcGcIIGec8+Uv87uehWBgohVsJUTnXRPtK0C2mfLUhSNtyyTtcxrJuEiRYrML/mnc4QnXI8an3t
	SKueP9z7RwIJo2uw7erpex00/JR4bLXQMk9FuCE2rtd1XGe3sLC6JsgXsOgSkkERCeXn5kcwJrw
	DaDwDCiWGS5OydRnjh36mM=
X-Received: by 2002:a17:90b:3d84:b0:369:7421:75cf with SMTP id 98e67ed59e1d1-36c501eb0a7mr6114475a91.16.1780209628871;
        Sat, 30 May 2026 23:40:28 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771a789bsm6936271a12.4.2026.05.30.23.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 23:40:28 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Mohan Kumar G <quic_mkumarg@quicinc.com>,
	Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Yang <weiming3@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH wifi] wifi: mac80211: fix NULL dereference of eht_oper in ieee80211_start_ap()
Date: Sun, 31 May 2026 14:39:40 +0800
Message-ID: <20260531063939.2505982-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[quicinc.com,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-37187-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4494A614B5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Weiming Yang <weiming3@asu.edu>

ieee80211_start_ap() enters the EHT block when params->eht_cap is set,
but its last statement unconditionally dereferences params->eht_oper.
The two pointers are parsed from separate beacon-tail elements in
nl80211_calculate_ap_params(), and an EHT Operation element is not
required to be present when an EHT Capability element is. A beacon tail
carrying an HE Capability and HE Operation element (so he_support is
set) plus an EHT Capability element, but no EHT Operation element, thus
dereferences a NULL params->eht_oper:

 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:ieee80211_start_ap (net/mac80211/cfg.c:1599)
 Call Trace:
  nl80211_start_ap (net/wireless/nl80211.c:7177)
  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
  genl_rcv_msg (net/netlink/genetlink.c:1209)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  genl_rcv (net/netlink/genetlink.c:1218)
  netlink_unicast (net/netlink/af_netlink.c:1344)
  netlink_sendmsg (net/netlink/af_netlink.c:1894)
  __sys_sendto (net/socket.c:2265)

NL80211_CMD_START_AP uses GENL_UNS_ADMIN_PERM, so this is reachable by
an unprivileged user in a user namespace.

Guard the dereference on params->eht_oper, as the HE block above already
does for params->he_oper.

Fixes: 22c64f37e1d4 ("wifi: mac80211: Update MCS15 support in link_conf")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/mac80211/cfg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7b77d57c9f96f..5e8d4ccaa6be4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1595,9 +1595,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				(IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
 				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
 				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ);
-		link_conf->eht_disable_mcs15 =
-			u8_get_bits(params->eht_oper->params,
-				    IEEE80211_EHT_OPER_MCS15_DISABLE);
+		if (params->eht_oper)
+			link_conf->eht_disable_mcs15 =
+				u8_get_bits(params->eht_oper->params,
+					    IEEE80211_EHT_OPER_MCS15_DISABLE);
 	} else {
 		link_conf->eht_su_beamformer = false;
 		link_conf->eht_su_beamformee = false;
-- 
2.43.0


