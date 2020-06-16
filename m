Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026181FAE1F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFPKjX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 06:39:23 -0400
Received: from mail.aperture-lab.de ([138.201.29.205]:43808 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgFPKjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 06:39:21 -0400
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1592303959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gel7BjFKnhibDSBwAtXS9lDNy0OHZ7c5Iy85ixq8zBc=;
        b=ewyJOnq84savi/Z5acfUpM79egKM69KqvWdyMLHGM6Nx+fTPZnCvOQ3uDGyY8bcxnHYbxW
        ATYAR7eKlf7cD9jvBTlDe3dIziPPxFruWE2nO9Z5OW1ec+gxQpDDFCOkeVA0P+21l1uJmY
        pJJIOe//hjTSuMpm2Mg1lI5Mll1SQmpwzDJn9vUlbuoxcEsX//OBwj8dqw6KQdcZtoIiUg
        Qpd0qP+ORUiP0V4gVwzluhlEVFfRVTEx4VSZDabK0HO9B+/dgmkl+R6PTuAxs26gncE0pQ
        quDBCRwgfLC2O0/nZCL0VUZB+/3mgnlLsxGJ2c+c7aD6o4N9TVJsESW4qTQZCw==
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <ll@simonwunderlich.de>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH v2] iw: mesh: add mesh_param "mesh_nolearn" to skip path discovery
Date:   Tue, 16 Jun 2020 12:39:11 +0200
Message-Id: <20200616103911.20501-2-linus.luessing@c0d3.blue>
In-Reply-To: <20200616103911.20501-1-linus.luessing@c0d3.blue>
References: <20200616103911.20501-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Linus Lüssing <ll@simonwunderlich.de>

Currently, before being able to forward a packet between two 802.11s
nodes, both a PLINK handshake is performed upon receiving a beacon and
then later a PREQ/PREP exchange for path discovery is performed on
demand upon receiving a data frame to forward.

When running a mesh protocol on top of an 802.11s interface, like
batman-adv, we do not need the multi-hop mesh routing capabilities of
802.11s and usually set mesh_fwding=0. However, even with mesh_fwding=0
the PREQ/PREP path discovery is still performed on demand. Even though
in this scenario the next hop PREQ/PREP will determine is always the
direct 11s neighbor node.

The new mesh_nolearn parameter allows to skip the PREQ/PREP exchange in
this scenario, leading to a reduced delay, reduced packet buffering and
simplifies HWMP in general.

mesh_nolearn is still rather conservative in that if the packet destination
is not a direct 11s neighbor, it will fall back to PREQ/PREP path
discovery.

For normal, multi-hop 802.11s mesh routing it is usually not advisable
to enable mesh_nolearn as a transmission to a direct but distant neighbor
might be worse than reaching that same node via a more robust /
higher throughput etc. multi-hop path.

Cc: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Linus Lüssing <ll@simonwunderlich.de>
---

Changelog v2:
* unchanged

 mesh.c    | 2 ++
 nl80211.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/mesh.c b/mesh.c
index 0650d0c..48bbc3f 100644
--- a/mesh.c
+++ b/mesh.c
@@ -264,6 +264,8 @@ static const struct mesh_param_descr _mesh_param_descrs[] =
 	_my_nla_put_u16, _parse_u16, _print_u16_in_TUs},
 	{"mesh_plink_timeout", NL80211_MESHCONF_PLINK_TIMEOUT,
 	_my_nla_put_u32, _parse_u32, _print_u32_in_seconds},
+	{"mesh_nolearn", NL80211_MESHCONF_NOLEARN,
+	_my_nla_put_u8, _parse_u8_as_bool, _print_u8},
 };
 
 static void print_all_mesh_param_descr(void)
diff --git a/nl80211.h b/nl80211.h
index c14666b..4c55e89 100644
--- a/nl80211.h
+++ b/nl80211.h
@@ -4228,6 +4228,12 @@ enum nl80211_mesh_power_mode {
  *	field.  If left unset then the mesh formation field will only
  *	advertise such if there is an active root mesh path.
  *
+ * @NL80211_MESHCONF_NOLEARN: Try to avoid multi-hop path discovery (e.g.
+ *	PREQ/PREP for HWMP) if the destination is a direct neighbor. Note that
+ *	this might not be the optimal decision as a multi-hop route might be
+ *	better. So if using this setting you will likely also want to disable
+ *	dot11MeshForwarding and use another mesh routing protocol on top.
+ *
  * @__NL80211_MESHCONF_ATTR_AFTER_LAST: internal use
  */
 enum nl80211_meshconf_params {
@@ -4261,6 +4267,7 @@ enum nl80211_meshconf_params {
 	NL80211_MESHCONF_AWAKE_WINDOW,
 	NL80211_MESHCONF_PLINK_TIMEOUT,
 	NL80211_MESHCONF_CONNECTED_TO_GATE,
+	NL80211_MESHCONF_NOLEARN,
 
 	/* keep last */
 	__NL80211_MESHCONF_ATTR_AFTER_LAST,
-- 
2.27.0

