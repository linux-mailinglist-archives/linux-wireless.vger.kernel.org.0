Return-Path: <linux-wireless+bounces-7443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263F8C20FD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872B9B20EBC
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B494F160880;
	Fri, 10 May 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UOM62K8f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497B29405
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333634; cv=none; b=rxKp2JGmbsOohyShpgEusgugk0cf3ihG7DxpNV+cjqsxE3THfylGGOh5y1XoVX6j+OarKrivnyVniFMqElqIRwFnEyIC767nQ6el3OXBDsxvDVAayd5wr4cDDe/CEZQHKjLBpge9IMTDiDk9t2qoes7C0bvgOqb6xQlnuvb9I34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333634; c=relaxed/simple;
	bh=MNBw0WKbv1NNoDtITNhu/Xd4zj1GuvEqcjQThRyStWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JxXx3MPbE2q4NXPTz/yg+p+QmDCWvVjDSIaaDljXVPOT9Dh/9nIknT4FRnYfCmSjBOuwQ+cOLFbipcDA0LIRTl0SCsikcy59nKWPTzGjcBw99r4PqVzgvxB7PdvekjUdxoQbmlM1h8iu84BWjTOWFX71lxvE3Zvoz4l7O8e1aJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UOM62K8f; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=9BLhWMM5LER/iCX4apcrzt/I000tBAT76VOv71Ou/dE=; t=1715333631; x=1716543231; 
	b=UOM62K8fcJbiZUmzVbXwBnU15Wib6GpWLvItwLWhPWaqqmO18cUdEn0Nv816IvoU2EVatugrTxL
	z5Tt97VjIAiGQAuOaG1v6l92aa4O1ZPNLgQNGfYW1X+sVxY0BPLu7AWztcxqpXUeXZBwEp7sRlZfo
	NTV2YnZJu4kCgNF+Xaak12NlXIj6VzwHK9gxG7v4r6zzKlBI5mwbTexRt9EWu8xEKGEqR8vFGGnGM
	OYVl04nM9YgDP171dbuMV/5duQnPS9gf+DsXIraZ5wwAI92yvEpfik1o1uUQcO78C9REMcIRRIgz/
	qwdDv/feZ+787XD/BPpPVhDoGsa6qXmVMihQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s5MdQ-0000000Ekjc-27fE;
	Fri, 10 May 2024 11:33:48 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: RX auth frames on P2P device
Date: Fri, 10 May 2024 11:33:47 +0200
Message-ID: <20240510113346.8c5b8d1f2f8d.Ib3074ffbe7b296e0f162b2543e84346b190dfbeb@changeid>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

This is needed for PASN based P2P pairing.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 9 +++++++--
 net/mac80211/rx.c   | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4eaea0a9975b..aa6c349175b8 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2017     Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -716,8 +716,13 @@ ieee80211_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 	},
 	[NL80211_IFTYPE_P2P_DEVICE] = {
 		.tx = 0xffff,
+		/*
+		 * To support P2P PASN pairing let user space register to rx
+		 * also AUTH frames on P2P device interface.
+		 */
 		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
-			BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4),
 	},
 };
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4914692750e5..13485f0f702c 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4552,7 +4552,9 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		return ieee80211_is_public_action(hdr, skb->len) ||
 		       ieee80211_is_probe_req(hdr->frame_control) ||
 		       ieee80211_is_probe_resp(hdr->frame_control) ||
-		       ieee80211_is_beacon(hdr->frame_control);
+		       ieee80211_is_beacon(hdr->frame_control) ||
+		       (ieee80211_is_auth(hdr->frame_control) &&
+			ether_addr_equal(sdata->vif.addr, hdr->addr1));
 	case NL80211_IFTYPE_NAN:
 		/* Currently no frames on NAN interface are allowed */
 		return false;
-- 
2.45.0


