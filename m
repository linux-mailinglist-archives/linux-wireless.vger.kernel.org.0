Return-Path: <linux-wireless+bounces-15063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D737E9C0617
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432D01F24050
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8720FA9D;
	Thu,  7 Nov 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tFsknOkg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023820EA3A;
	Thu,  7 Nov 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983426; cv=none; b=T8QTZqRuBcdtDYoDVSpJ+2xmmMJfVZu3ZJGrMPbZrtJLdxc/cfVcL2kD5pzHVBpw6cynTLcEpftflJu56fXneUnfglHZ+YxlcJ7lApqzuX48JsCx1FWjZ03yf4iznNQdnT9X/Cb76e5AFev4k4KWYCGuD8/X3czDKabbdBFE90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983426; c=relaxed/simple;
	bh=Tas0pLM94gDwImBTUZQRIE0hTGjUwzPwzK+cQaTYQ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VorYame8IF8QxFIZIDmecjPeh8V/KaZzcETR72Qvr+MxCE+o5JfqwzDpCm8jA+r0DCORxqr8HNjqpkOXt1QNxuqRmmKLKn0IS/8qBz6dFVBoYkx+lURPxU5BveIbHpR68kYKimR33PjYBqB04lcGFdeRCv2NsTztSg1GiRPZtXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tFsknOkg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+MGBTIiXResrT/B/BxdYYPAzilEWtK7HMyqgPhbm5kg=;
	t=1730983424; x=1732193024; b=tFsknOkgqtFLd/wtaW+jqhk/2FV+B95P2/bZT9atSe2U1oM
	HWTbyjzmyXx1Te4ePjr72XzcU/WYYrR0o9wv4PVit31kCryzGiZLzuI12PiNHdXSRzXbwrphMerC2
	Ha271XulM3u3DBP3HlljDWDjN4V8Y1D7GGGQdPtIf0D0s+sTj/KfxzrpvsEjq1u7YqOik/ZfutWTq
	x3gRqMBiWaCzAPxFPNahaI2AYVmK8rK8rgeRAGW48grCxKBQlwq5y8RN3aSAQtDJfdAPuj9o2N4/l
	l2AxVPGOZQ5ptrhQDr6eTAr9LDiryMD3nXDwEKduWBzIfkrxQn95GAdaPm37QF0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t91rK-0000000GPSP-3Wnb;
	Thu, 07 Nov 2024 13:43:35 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 2/2] net: convert to nla_get_*_default()
Date: Thu,  7 Nov 2024 13:43:31 +0100
Message-ID: <20241107134331.861afd88e719.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107134331.cbacbd7d40e0.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
References: <20241107134331.cbacbd7d40e0.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Most of the original conversion is from the spatch below,
but I edited some and left out other instances that were
either buggy after conversion (where default values don't
fit into the type) or just looked strange.

    @@
    expression attr, def;
    expression val;
    identifier fn =~ "^nla_get_.*";
    fresh identifier dfn = fn ## "_default";
    @@
    (
    -if (attr)
    -  val = fn(attr);
    -else
    -  val = def;
    +val = dfn(attr, def);
    |
    -if (!attr)
    -  val = def;
    -else
    -  val = fn(attr);
    +val = dfn(attr, def);
    |
    -if (!attr)
    -  return def;
    -return fn(attr);
    +return dfn(attr, def);
    |
    -attr ? fn(attr) : def
    +dfn(attr, def)
    |
    -!attr ? def : fn(attr)
    +dfn(attr, def)
    )

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/amt.c              | 12 +++-----
 drivers/net/gtp.c              | 16 +++--------
 drivers/net/macsec.c           |  6 ++--
 drivers/net/vxlan/vxlan_core.c |  5 +---
 net/8021q/vlan_netlink.c       |  6 ++--
 net/core/fib_rules.c           |  3 +-
 net/core/rtnetlink.c           |  5 +---
 net/devlink/dev.c              |  6 ++--
 net/hsr/hsr_netlink.c          |  5 +---
 net/ieee802154/nl-mac.c        | 15 ++--------
 net/ieee802154/nl802154.c      | 24 ++++++----------
 net/ipv4/devinet.c             |  3 +-
 net/ipv4/ipmr.c                |  6 ++--
 net/ipv4/nexthop.c             | 13 ++-------
 net/ipv4/route.c               | 10 +++----
 net/ipv6/addrconf.c            |  7 ++---
 net/ipv6/ila/ila_xlat.c        | 13 +++------
 net/ipv6/ioam6.c               | 12 +++-----
 net/ipv6/ioam6_iptunnel.c      |  6 ++--
 net/ipv6/ip6mr.c               |  2 +-
 net/netfilter/ipvs/ip_vs_ctl.c |  5 +---
 net/netfilter/nf_nat_core.c    |  6 ++--
 net/netfilter/nft_tunnel.c     |  5 +---
 net/netlabel/netlabel_mgmt.c   | 12 ++------
 net/openvswitch/datapath.c     | 10 +++----
 net/openvswitch/flow_netlink.c |  2 +-
 net/sched/act_ct.c             | 10 +++----
 net/sched/act_ctinfo.c         |  7 ++---
 net/sched/act_gate.c           | 11 ++------
 net/sched/act_mpls.c           | 18 ++++++------
 net/sched/act_police.c         |  6 ++--
 net/sched/cls_api.c            |  8 +++---
 net/sched/sch_choke.c          |  2 +-
 net/sched/sch_gred.c           |  2 +-
 net/sched/sch_htb.c            |  4 +--
 net/sched/sch_qfq.c            |  5 +---
 net/sched/sch_red.c            |  2 +-
 net/sched/sch_taprio.c         |  2 +-
 net/wireless/nl80211.c         | 50 ++++++++++------------------------
 net/xfrm/xfrm_user.c           |  8 ++----
 40 files changed, 116 insertions(+), 234 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 0433a0f36d1b..98c6205ed19f 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3206,15 +3206,11 @@ static int amt_newlink(struct net *net, struct net_device *dev,
 		goto err;
 	}
 
-	if (data[IFLA_AMT_RELAY_PORT])
-		amt->relay_port = nla_get_be16(data[IFLA_AMT_RELAY_PORT]);
-	else
-		amt->relay_port = htons(IANA_AMT_UDP_PORT);
+	amt->relay_port = nla_get_be16_default(data[IFLA_AMT_RELAY_PORT],
+					       htons(IANA_AMT_UDP_PORT));
 
-	if (data[IFLA_AMT_GATEWAY_PORT])
-		amt->gw_port = nla_get_be16(data[IFLA_AMT_GATEWAY_PORT]);
-	else
-		amt->gw_port = htons(IANA_AMT_UDP_PORT);
+	amt->gw_port = nla_get_be16_default(data[IFLA_AMT_GATEWAY_PORT],
+					    htons(IANA_AMT_UDP_PORT));
 
 	if (!amt->relay_port) {
 		NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_AMT_DISCOVERY_IP],
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 70f981887518..89a996ad8cd0 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1491,10 +1491,8 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 	}
 	gtp->role = role;
 
-	if (!data[IFLA_GTP_RESTART_COUNT])
-		gtp->restart_count = 0;
-	else
-		gtp->restart_count = nla_get_u8(data[IFLA_GTP_RESTART_COUNT]);
+	gtp->restart_count = nla_get_u8_default(data[IFLA_GTP_RESTART_COUNT],
+						0);
 
 	gtp->net = src_net;
 
@@ -1829,10 +1827,7 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 
 	version = nla_get_u32(info->attrs[GTPA_VERSION]);
 
-	if (info->attrs[GTPA_FAMILY])
-		family = nla_get_u8(info->attrs[GTPA_FAMILY]);
-	else
-		family = AF_INET;
+	family = nla_get_u8_default(info->attrs[GTPA_FAMILY], AF_INET);
 
 #if !IS_ENABLED(CONFIG_IPV6)
 	if (family == AF_INET6)
@@ -2069,10 +2064,7 @@ static struct pdp_ctx *gtp_find_pdp_by_link(struct net *net,
 	struct gtp_dev *gtp;
 	int family;
 
-	if (nla[GTPA_FAMILY])
-		family = nla_get_u8(nla[GTPA_FAMILY]);
-	else
-		family = AF_INET;
+	family = nla_get_u8_default(nla[GTPA_FAMILY], AF_INET);
 
 	gtp = gtp_find_dev(net, nla);
 	if (!gtp)
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ee2159282573..53dc89a6ae67 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4299,9 +4299,9 @@ static int macsec_validate_attr(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
-	es  = data[IFLA_MACSEC_ES] ? nla_get_u8(data[IFLA_MACSEC_ES]) : false;
-	sci = data[IFLA_MACSEC_INC_SCI] ? nla_get_u8(data[IFLA_MACSEC_INC_SCI]) : false;
-	scb = data[IFLA_MACSEC_SCB] ? nla_get_u8(data[IFLA_MACSEC_SCB]) : false;
+	es  = nla_get_u8_default(data[IFLA_MACSEC_ES], false);
+	sci = nla_get_u8_default(data[IFLA_MACSEC_INC_SCI], false);
+	scb = nla_get_u8_default(data[IFLA_MACSEC_SCB], false);
 
 	if ((sci && (scb || es)) || (scb && es))
 		return -EINVAL;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 841b59d1c1c2..42b07bc2b107 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1232,10 +1232,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 		*ifindex = 0;
 	}
 
-	if (tb[NDA_NH_ID])
-		*nhid = nla_get_u32(tb[NDA_NH_ID]);
-	else
-		*nhid = 0;
+	*nhid = nla_get_u32_default(tb[NDA_NH_ID], 0);
 
 	return 0;
 }
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index cf5219df7903..134419667d59 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -161,10 +161,8 @@ static int vlan_newlink(struct net *src_net, struct net_device *dev,
 		return -ENODEV;
 	}
 
-	if (data[IFLA_VLAN_PROTOCOL])
-		proto = nla_get_be16(data[IFLA_VLAN_PROTOCOL]);
-	else
-		proto = htons(ETH_P_8021Q);
+	proto = nla_get_be16_default(data[IFLA_VLAN_PROTOCOL],
+				     htons(ETH_P_8021Q));
 
 	vlan->vlan_proto = proto;
 	vlan->vlan_id	 = nla_get_u16(data[IFLA_VLAN_ID]);
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index d0de9677f450..34185d138c95 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -558,8 +558,7 @@ static int fib_nl2rule(struct sk_buff *skb, struct nlmsghdr *nlh,
 		nlrule->pref = fib_default_rule_pref(ops);
 	}
 
-	nlrule->proto = tb[FRA_PROTOCOL] ?
-		nla_get_u8(tb[FRA_PROTOCOL]) : RTPROT_UNSPEC;
+	nlrule->proto = nla_get_u8_default(tb[FRA_PROTOCOL], RTPROT_UNSPEC);
 
 	if (tb[FRA_IIFNAME]) {
 		struct net_device *dev;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3b33810d92a8..a5c386a45501 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2940,10 +2940,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		const char *pat = ifname[0] ? ifname : NULL;
 		int new_ifindex;
 
-		if (tb[IFLA_NEW_IFINDEX])
-			new_ifindex = nla_get_s32(tb[IFLA_NEW_IFINDEX]);
-		else
-			new_ifindex = 0;
+		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
 
 		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex);
 		if (err)
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 9264bbc90d0c..d6e3db300acb 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -531,10 +531,8 @@ int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
-	if (info->attrs[DEVLINK_ATTR_RELOAD_ACTION])
-		action = nla_get_u8(info->attrs[DEVLINK_ATTR_RELOAD_ACTION]);
-	else
-		action = DEVLINK_RELOAD_ACTION_DRIVER_REINIT;
+	action = nla_get_u8_default(info->attrs[DEVLINK_ATTR_RELOAD_ACTION],
+				    DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
 
 	if (!devlink_reload_action_is_supported(devlink, action)) {
 		NL_SET_ERR_MSG(info->extack, "Requested reload action is not supported by the driver");
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 6f09b9512484..b68f2f71d0e1 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -82,10 +82,7 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 		return -EINVAL;
 	}
 
-	if (!data[IFLA_HSR_MULTICAST_SPEC])
-		multicast_spec = 0;
-	else
-		multicast_spec = nla_get_u8(data[IFLA_HSR_MULTICAST_SPEC]);
+	multicast_spec = nla_get_u8_default(data[IFLA_HSR_MULTICAST_SPEC], 0);
 
 	if (data[IFLA_HSR_PROTOCOL])
 		proto = nla_get_u8(data[IFLA_HSR_PROTOCOL]);
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 29bf97640166..74ef0a310afb 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -202,10 +202,7 @@ int ieee802154_associate_req(struct sk_buff *skb, struct genl_info *info)
 	addr.pan_id = nla_get_shortaddr(
 			info->attrs[IEEE802154_ATTR_COORD_PAN_ID]);
 
-	if (info->attrs[IEEE802154_ATTR_PAGE])
-		page = nla_get_u8(info->attrs[IEEE802154_ATTR_PAGE]);
-	else
-		page = 0;
+	page = nla_get_u8_default(info->attrs[IEEE802154_ATTR_PAGE], 0);
 
 	ret = ieee802154_mlme_ops(dev)->assoc_req(dev, &addr,
 			nla_get_u8(info->attrs[IEEE802154_ATTR_CHANNEL]),
@@ -338,10 +335,7 @@ int ieee802154_start_req(struct sk_buff *skb, struct genl_info *info)
 	blx = nla_get_u8(info->attrs[IEEE802154_ATTR_BAT_EXT]);
 	coord_realign = nla_get_u8(info->attrs[IEEE802154_ATTR_COORD_REALIGN]);
 
-	if (info->attrs[IEEE802154_ATTR_PAGE])
-		page = nla_get_u8(info->attrs[IEEE802154_ATTR_PAGE]);
-	else
-		page = 0;
+	page = nla_get_u8_default(info->attrs[IEEE802154_ATTR_PAGE], 0);
 
 	if (addr.short_addr == cpu_to_le16(IEEE802154_ADDR_BROADCAST)) {
 		ieee802154_nl_start_confirm(dev, IEEE802154_NO_SHORT_ADDRESS);
@@ -388,10 +382,7 @@ int ieee802154_scan_req(struct sk_buff *skb, struct genl_info *info)
 	channels = nla_get_u32(info->attrs[IEEE802154_ATTR_CHANNELS]);
 	duration = nla_get_u8(info->attrs[IEEE802154_ATTR_DURATION]);
 
-	if (info->attrs[IEEE802154_ATTR_PAGE])
-		page = nla_get_u8(info->attrs[IEEE802154_ATTR_PAGE]);
-	else
-		page = 0;
+	page = nla_get_u8_default(info->attrs[IEEE802154_ATTR_PAGE], 0);
 
 	ret = ieee802154_mlme_ops(dev)->scan_req(dev, type, channels,
 						 page, duration);
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 7eb37de3add2..694356a1fc91 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1438,22 +1438,16 @@ static int nl802154_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* Use current page by default */
-	if (info->attrs[NL802154_ATTR_PAGE])
-		request->page = nla_get_u8(info->attrs[NL802154_ATTR_PAGE]);
-	else
-		request->page = wpan_phy->current_page;
+	request->page = nla_get_u8_default(info->attrs[NL802154_ATTR_PAGE],
+					   wpan_phy->current_page);
 
 	/* Scan all supported channels by default */
-	if (info->attrs[NL802154_ATTR_SCAN_CHANNELS])
-		request->channels = nla_get_u32(info->attrs[NL802154_ATTR_SCAN_CHANNELS]);
-	else
-		request->channels = wpan_phy->supported.channels[request->page];
+	request->channels = nla_get_u32_default(info->attrs[NL802154_ATTR_SCAN_CHANNELS],
+						wpan_phy->supported.channels[request->page]);
 
 	/* Use maximum duration order by default */
-	if (info->attrs[NL802154_ATTR_SCAN_DURATION])
-		request->duration = nla_get_u8(info->attrs[NL802154_ATTR_SCAN_DURATION]);
-	else
-		request->duration = IEEE802154_MAX_SCAN_DURATION;
+	request->duration = nla_get_u8_default(info->attrs[NL802154_ATTR_SCAN_DURATION],
+					       IEEE802154_MAX_SCAN_DURATION);
 
 	err = rdev_trigger_scan(rdev, request);
 	if (err) {
@@ -1598,10 +1592,8 @@ nl802154_send_beacons(struct sk_buff *skb, struct genl_info *info)
 	request->wpan_phy = wpan_phy;
 
 	/* Use maximum duration order by default */
-	if (info->attrs[NL802154_ATTR_BEACON_INTERVAL])
-		request->interval = nla_get_u8(info->attrs[NL802154_ATTR_BEACON_INTERVAL]);
-	else
-		request->interval = IEEE802154_MAX_SCAN_DURATION;
+	request->interval = nla_get_u8_default(info->attrs[NL802154_ATTR_BEACON_INTERVAL],
+					       IEEE802154_MAX_SCAN_DURATION);
 
 	err = rdev_send_beacons(rdev, request);
 	if (err) {
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index f58f39a9ee87..c8b3cf5fba4c 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -926,8 +926,7 @@ static struct in_ifaddr *inet_rtm_to_ifa(struct net *net, struct nlmsghdr *nlh,
 
 	ifa->ifa_prefixlen = ifm->ifa_prefixlen;
 	ifa->ifa_mask = inet_make_mask(ifm->ifa_prefixlen);
-	ifa->ifa_flags = tb[IFA_FLAGS] ? nla_get_u32(tb[IFA_FLAGS]) :
-					 ifm->ifa_flags;
+	ifa->ifa_flags = nla_get_u32_default(tb[IFA_FLAGS], ifm->ifa_flags);
 	ifa->ifa_scope = ifm->ifa_scope;
 	ifa->ifa_local = nla_get_in_addr(tb[IFA_LOCAL]);
 	ifa->ifa_address = nla_get_in_addr(tb[IFA_ADDRESS]);
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 99e7cd0531d9..c58dd78509a2 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2546,9 +2546,9 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
-	src = tb[RTA_SRC] ? nla_get_in_addr(tb[RTA_SRC]) : 0;
-	grp = tb[RTA_DST] ? nla_get_in_addr(tb[RTA_DST]) : 0;
-	tableid = tb[RTA_TABLE] ? nla_get_u32(tb[RTA_TABLE]) : 0;
+	src = nla_get_in_addr_default(tb[RTA_SRC], 0);
+	grp = nla_get_in_addr_default(tb[RTA_DST], 0);
+	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
 	mrt = ipmr_get_table(net, tableid ? tableid : RT_TABLE_DEFAULT);
 	if (!mrt) {
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 570e450e008c..09a3d73b45ba 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3247,12 +3247,8 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	if (op_flags) {
-		if (tb[NHA_OP_FLAGS])
-			*op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
-		else
-			*op_flags = 0;
-	}
+	if (op_flags)
+		*op_flags = nla_get_u32_default(tb[NHA_OP_FLAGS], 0);
 
 	return 0;
 }
@@ -3433,10 +3429,7 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	if (tb[NHA_OP_FLAGS])
-		filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
-	else
-		filter->op_flags = 0;
+	filter->op_flags = nla_get_u32_default(tb[NHA_OP_FLAGS], 0);
 
 	return __nh_valid_dump_req(nlh, tb, filter, cb->extack);
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 763398e08b7d..4c5e773002fe 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3231,10 +3231,10 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		return err;
 
 	rtm = nlmsg_data(nlh);
-	src = tb[RTA_SRC] ? nla_get_in_addr(tb[RTA_SRC]) : 0;
-	dst = tb[RTA_DST] ? nla_get_in_addr(tb[RTA_DST]) : 0;
-	iif = tb[RTA_IIF] ? nla_get_u32(tb[RTA_IIF]) : 0;
-	mark = tb[RTA_MARK] ? nla_get_u32(tb[RTA_MARK]) : 0;
+	src = nla_get_in_addr_default(tb[RTA_SRC], 0);
+	dst = nla_get_in_addr_default(tb[RTA_DST], 0);
+	iif = nla_get_u32_default(tb[RTA_IIF], 0);
+	mark = nla_get_u32_default(tb[RTA_MARK], 0);
 	if (tb[RTA_UID])
 		uid = make_kuid(current_user_ns(), nla_get_u32(tb[RTA_UID]));
 	else
@@ -3260,7 +3260,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	fl4.daddr = dst;
 	fl4.saddr = src;
 	fl4.flowi4_tos = rtm->rtm_tos & INET_DSCP_MASK;
-	fl4.flowi4_oif = tb[RTA_OIF] ? nla_get_u32(tb[RTA_OIF]) : 0;
+	fl4.flowi4_oif = nla_get_u32_default(tb[RTA_OIF], 0);
 	fl4.flowi4_mark = mark;
 	fl4.flowi4_uid = uid;
 	if (sport)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d0a99710d65d..96b5b2b0d507 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4793,7 +4793,7 @@ inet6_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!pfx)
 		return -EINVAL;
 
-	ifa_flags = tb[IFA_FLAGS] ? nla_get_u32(tb[IFA_FLAGS]) : ifm->ifa_flags;
+	ifa_flags = nla_get_u32_default(tb[IFA_FLAGS], ifm->ifa_flags);
 
 	/* We ignore other flags so far. */
 	ifa_flags &= IFA_F_MANAGETEMPADDR;
@@ -5018,10 +5018,7 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -ENODEV;
 	}
 
-	if (tb[IFA_FLAGS])
-		cfg.ifa_flags = nla_get_u32(tb[IFA_FLAGS]);
-	else
-		cfg.ifa_flags = ifm->ifa_flags;
+	cfg.ifa_flags = nla_get_u32_default(tb[IFA_FLAGS], ifm->ifa_flags);
 
 	/* We ignore other flags so far. */
 	cfg.ifa_flags &= IFA_F_NODAD | IFA_F_HOMEADDRESS |
diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 534a4498e280..7646e401c630 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -105,16 +105,11 @@ static int parse_nl_config(struct genl_info *info,
 		xp->ip.locator_match.v64 = (__force __be64)nla_get_u64(
 			info->attrs[ILA_ATTR_LOCATOR_MATCH]);
 
-	if (info->attrs[ILA_ATTR_CSUM_MODE])
-		xp->ip.csum_mode = nla_get_u8(info->attrs[ILA_ATTR_CSUM_MODE]);
-	else
-		xp->ip.csum_mode = ILA_CSUM_NO_ACTION;
+	xp->ip.csum_mode = nla_get_u8_default(info->attrs[ILA_ATTR_CSUM_MODE],
+					      ILA_CSUM_NO_ACTION);
 
-	if (info->attrs[ILA_ATTR_IDENT_TYPE])
-		xp->ip.ident_type = nla_get_u8(
-				info->attrs[ILA_ATTR_IDENT_TYPE]);
-	else
-		xp->ip.ident_type = ILA_ATYPE_USE_FORMAT;
+	xp->ip.ident_type = nla_get_u8_default(info->attrs[ILA_ATTR_IDENT_TYPE],
+					       ILA_ATYPE_USE_FORMAT);
 
 	if (info->attrs[ILA_ATTR_IFINDEX])
 		xp->ifindex = nla_get_s32(info->attrs[ILA_ATTR_IFINDEX]);
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 08c929513065..a84d332f952f 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -135,15 +135,11 @@ static int ioam6_genl_addns(struct sk_buff *skb, struct genl_info *info)
 
 	ns->id = id;
 
-	if (!info->attrs[IOAM6_ATTR_NS_DATA])
-		data32 = IOAM6_U32_UNAVAILABLE;
-	else
-		data32 = nla_get_u32(info->attrs[IOAM6_ATTR_NS_DATA]);
+	data32 = nla_get_u32_default(info->attrs[IOAM6_ATTR_NS_DATA],
+				     IOAM6_U32_UNAVAILABLE);
 
-	if (!info->attrs[IOAM6_ATTR_NS_DATA_WIDE])
-		data64 = IOAM6_U64_UNAVAILABLE;
-	else
-		data64 = nla_get_u64(info->attrs[IOAM6_ATTR_NS_DATA_WIDE]);
+	data64 = nla_get_u64_default(info->attrs[IOAM6_ATTR_NS_DATA_WIDE],
+				     IOAM6_U64_UNAVAILABLE);
 
 	ns->data = cpu_to_be32(data32);
 	ns->data_wide = cpu_to_be64(data64);
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index beb6b4cfc551..9d8422e350f8 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -142,10 +142,8 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 		}
 	}
 
-	if (!tb[IOAM6_IPTUNNEL_MODE])
-		mode = IOAM6_IPTUNNEL_MODE_INLINE;
-	else
-		mode = nla_get_u8(tb[IOAM6_IPTUNNEL_MODE]);
+	mode = nla_get_u8_default(tb[IOAM6_IPTUNNEL_MODE],
+				  IOAM6_IPTUNNEL_MODE_INLINE);
 
 	if (tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_INLINE) {
 		NL_SET_ERR_MSG(extack, "no tunnel src expected with this mode");
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 8add0f45aa52..d66f58932a79 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2560,7 +2560,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		src = nla_get_in6_addr(tb[RTA_SRC]);
 	if (tb[RTA_DST])
 		grp = nla_get_in6_addr(tb[RTA_DST]);
-	tableid = tb[RTA_TABLE] ? nla_get_u32(tb[RTA_TABLE]) : 0;
+	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
 	mrt = ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index dc6ddc4abbe2..7d13110ce188 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -3662,10 +3662,7 @@ static int ip_vs_genl_parse_dest(struct ip_vs_dest_user_kern *udest,
 	nla_memcpy(&udest->addr, nla_addr, sizeof(udest->addr));
 	udest->port = nla_get_be16(nla_port);
 
-	if (nla_addr_family)
-		udest->af = nla_get_u16(nla_addr_family);
-	else
-		udest->af = 0;
+	udest->af = nla_get_u16_default(nla_addr_family, 0);
 
 	/* If a full entry was requested, check for the additional fields */
 	if (full_entry) {
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 4085c436e306..aad84aabd7f1 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -1090,10 +1090,8 @@ static int nf_nat_ipv4_nlattr_to_range(struct nlattr *tb[],
 		range->flags |= NF_NAT_RANGE_MAP_IPS;
 	}
 
-	if (tb[CTA_NAT_V4_MAXIP])
-		range->max_addr.ip = nla_get_be32(tb[CTA_NAT_V4_MAXIP]);
-	else
-		range->max_addr.ip = range->min_addr.ip;
+	range->max_addr.ip = nla_get_be32_default(tb[CTA_NAT_V4_MAXIP],
+						  range->min_addr.ip);
 
 	return 0;
 }
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 5c6ed68cc6e0..681301b46aa4 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -497,10 +497,7 @@ static int nft_tunnel_obj_init(const struct nft_ctx *ctx,
 	}
 	if (tb[NFTA_TUNNEL_KEY_TOS])
 		info.key.tos = nla_get_u8(tb[NFTA_TUNNEL_KEY_TOS]);
-	if (tb[NFTA_TUNNEL_KEY_TTL])
-		info.key.ttl = nla_get_u8(tb[NFTA_TUNNEL_KEY_TTL]);
-	else
-		info.key.ttl = U8_MAX;
+	info.key.ttl = nla_get_u8_default(tb[NFTA_TUNNEL_KEY_TTL], U8_MAX);
 
 	if (tb[NFTA_TUNNEL_KEY_OPTS]) {
 		err = nft_tunnel_obj_opts_init(ctx, tb[NFTA_TUNNEL_KEY_OPTS],
diff --git a/net/netlabel/netlabel_mgmt.c b/net/netlabel/netlabel_mgmt.c
index 689eaa2afbec..ce7fb797c3e0 100644
--- a/net/netlabel/netlabel_mgmt.c
+++ b/net/netlabel/netlabel_mgmt.c
@@ -107,11 +107,8 @@ static int netlbl_mgmt_add_common(struct genl_info *info,
 
 	switch (entry->def.type) {
 	case NETLBL_NLTYPE_UNLABELED:
-		if (info->attrs[NLBL_MGMT_A_FAMILY])
-			entry->family =
-				nla_get_u16(info->attrs[NLBL_MGMT_A_FAMILY]);
-		else
-			entry->family = AF_UNSPEC;
+		entry->family = nla_get_u16_default(info->attrs[NLBL_MGMT_A_FAMILY],
+						    AF_UNSPEC);
 		break;
 	case NETLBL_NLTYPE_CIPSOV4:
 		if (!info->attrs[NLBL_MGMT_A_CV4DOI])
@@ -601,10 +598,7 @@ static int netlbl_mgmt_listdef(struct sk_buff *skb, struct genl_info *info)
 	struct netlbl_dom_map *entry;
 	u16 family;
 
-	if (info->attrs[NLBL_MGMT_A_FAMILY])
-		family = nla_get_u16(info->attrs[NLBL_MGMT_A_FAMILY]);
-	else
-		family = AF_INET;
+	family = nla_get_u16_default(info->attrs[NLBL_MGMT_A_FAMILY], AF_INET);
 
 	ans_skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (ans_skb == NULL)
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 78d9961fcd44..225f6048867f 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1828,8 +1828,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	parms.dp = dp;
 	parms.port_no = OVSP_LOCAL;
 	parms.upcall_portids = a[OVS_DP_ATTR_UPCALL_PID];
-	parms.desired_ifindex = a[OVS_DP_ATTR_IFINDEX]
-		? nla_get_s32(a[OVS_DP_ATTR_IFINDEX]) : 0;
+	parms.desired_ifindex = nla_get_s32_default(a[OVS_DP_ATTR_IFINDEX], 0);
 
 	/* So far only local changes have been made, now need the lock. */
 	ovs_lock();
@@ -2266,8 +2265,7 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	if (a[OVS_VPORT_ATTR_IFINDEX] && parms.type != OVS_VPORT_TYPE_INTERNAL)
 		return -EOPNOTSUPP;
 
-	port_no = a[OVS_VPORT_ATTR_PORT_NO]
-		? nla_get_u32(a[OVS_VPORT_ATTR_PORT_NO]) : 0;
+	port_no = nla_get_u32_default(a[OVS_VPORT_ATTR_PORT_NO], 0);
 	if (port_no >= DP_MAX_PORTS)
 		return -EFBIG;
 
@@ -2304,8 +2302,8 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	parms.dp = dp;
 	parms.port_no = port_no;
 	parms.upcall_portids = a[OVS_VPORT_ATTR_UPCALL_PID];
-	parms.desired_ifindex = a[OVS_VPORT_ATTR_IFINDEX]
-		? nla_get_s32(a[OVS_VPORT_ATTR_IFINDEX]) : 0;
+	parms.desired_ifindex = nla_get_s32_default(a[OVS_VPORT_ATTR_IFINDEX],
+						    0);
 
 	vport = new_vport(&parms);
 	err = PTR_ERR(vport);
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 729ef582a3a8..881ddd3696d5 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -1938,7 +1938,7 @@ int ovs_nla_get_identifier(struct sw_flow_id *sfid, const struct nlattr *ufid,
 
 u32 ovs_nla_get_ufid_flags(const struct nlattr *attr)
 {
-	return attr ? nla_get_u32(attr) : 0;
+	return nla_get_u32_default(attr, 0);
 }
 
 /**
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 2197eb625658..0e4e76372601 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1183,9 +1183,8 @@ static int tcf_ct_fill_params_nat(struct tcf_ct_params *p,
 		range->min_addr.ip =
 			nla_get_in_addr(tb[TCA_CT_NAT_IPV4_MIN]);
 
-		range->max_addr.ip = max_attr ?
-				     nla_get_in_addr(max_attr) :
-				     range->min_addr.ip;
+		range->max_addr.ip = nla_get_in_addr_default(max_attr,
+							     range->min_addr.ip);
 	} else if (tb[TCA_CT_NAT_IPV6_MIN]) {
 		struct nlattr *max_attr = tb[TCA_CT_NAT_IPV6_MAX];
 
@@ -1314,8 +1313,9 @@ static int tcf_ct_fill_params(struct net *net,
 			err = -EINVAL;
 			goto err;
 		}
-		family = tb[TCA_CT_HELPER_FAMILY] ? nla_get_u8(tb[TCA_CT_HELPER_FAMILY]) : AF_INET;
-		proto = tb[TCA_CT_HELPER_PROTO] ? nla_get_u8(tb[TCA_CT_HELPER_PROTO]) : IPPROTO_TCP;
+		family = nla_get_u8_default(tb[TCA_CT_HELPER_FAMILY], AF_INET);
+		proto = nla_get_u8_default(tb[TCA_CT_HELPER_PROTO],
+					   IPPROTO_TCP);
 		err = nf_ct_add_helper(tmpl, name, family, proto,
 				       p->ct_action & TCA_CT_ACT_NAT, &p->helper);
 		if (err) {
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 5dd41a012110..aa4493641204 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -197,8 +197,8 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 					    "dscp mask must be 6 contiguous bits");
 			return -EINVAL;
 		}
-		dscpstatemask = tb[TCA_CTINFO_PARMS_DSCP_STATEMASK] ?
-			nla_get_u32(tb[TCA_CTINFO_PARMS_DSCP_STATEMASK]) : 0;
+		dscpstatemask = nla_get_u32_default(tb[TCA_CTINFO_PARMS_DSCP_STATEMASK],
+						    0);
 		/* mask & statemask must not overlap */
 		if (dscpmask & dscpstatemask) {
 			NL_SET_ERR_MSG_ATTR(extack,
@@ -243,8 +243,7 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 	}
 
 	cp_new->net = net;
-	cp_new->zone = tb[TCA_CTINFO_ZONE] ?
-			nla_get_u16(tb[TCA_CTINFO_ZONE]) : 0;
+	cp_new->zone = nla_get_u16_default(tb[TCA_CTINFO_ZONE], 0);
 	if (dscpmask) {
 		cp_new->dscpmask = dscpmask;
 		cp_new->dscpmaskshift = dscpmaskshift;
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 1dd74125398a..91c0ec729823 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -190,15 +190,10 @@ static int fill_gate_entry(struct nlattr **tb, struct tcfg_gate_entry *entry,
 
 	entry->interval = interval;
 
-	if (tb[TCA_GATE_ENTRY_IPV])
-		entry->ipv = nla_get_s32(tb[TCA_GATE_ENTRY_IPV]);
-	else
-		entry->ipv = -1;
+	entry->ipv = nla_get_s32_default(tb[TCA_GATE_ENTRY_IPV], -1);
 
-	if (tb[TCA_GATE_ENTRY_MAX_OCTETS])
-		entry->maxoctets = nla_get_s32(tb[TCA_GATE_ENTRY_MAX_OCTETS]);
-	else
-		entry->maxoctets = -1;
+	entry->maxoctets = nla_get_s32_default(tb[TCA_GATE_ENTRY_MAX_OCTETS],
+					       -1);
 
 	return 0;
 }
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 44a37a71ae92..9f86f4e666d3 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -288,16 +288,14 @@ static int tcf_mpls_init(struct net *net, struct nlattr *nla,
 	}
 
 	p->tcfm_action = parm->m_action;
-	p->tcfm_label = tb[TCA_MPLS_LABEL] ? nla_get_u32(tb[TCA_MPLS_LABEL]) :
-					     ACT_MPLS_LABEL_NOT_SET;
-	p->tcfm_tc = tb[TCA_MPLS_TC] ? nla_get_u8(tb[TCA_MPLS_TC]) :
-				       ACT_MPLS_TC_NOT_SET;
-	p->tcfm_ttl = tb[TCA_MPLS_TTL] ? nla_get_u8(tb[TCA_MPLS_TTL]) :
-					 mpls_ttl;
-	p->tcfm_bos = tb[TCA_MPLS_BOS] ? nla_get_u8(tb[TCA_MPLS_BOS]) :
-					 ACT_MPLS_BOS_NOT_SET;
-	p->tcfm_proto = tb[TCA_MPLS_PROTO] ? nla_get_be16(tb[TCA_MPLS_PROTO]) :
-					     htons(ETH_P_MPLS_UC);
+	p->tcfm_label = nla_get_u32_default(tb[TCA_MPLS_LABEL],
+					    ACT_MPLS_LABEL_NOT_SET);
+	p->tcfm_tc = nla_get_u8_default(tb[TCA_MPLS_TC], ACT_MPLS_TC_NOT_SET);
+	p->tcfm_ttl = nla_get_u8_default(tb[TCA_MPLS_TTL], mpls_ttl);
+	p->tcfm_bos = nla_get_u8_default(tb[TCA_MPLS_BOS],
+					 ACT_MPLS_BOS_NOT_SET);
+	p->tcfm_proto = nla_get_be16_default(tb[TCA_MPLS_PROTO],
+					     htons(ETH_P_MPLS_UC));
 
 	spin_lock_bh(&m->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 8555125ed34d..a214ed681142 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -167,8 +167,7 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 	}
 	if (R_tab) {
 		new->rate_present = true;
-		rate64 = tb[TCA_POLICE_RATE64] ?
-			 nla_get_u64(tb[TCA_POLICE_RATE64]) : 0;
+		rate64 = nla_get_u64_default(tb[TCA_POLICE_RATE64], 0);
 		psched_ratecfg_precompute(&new->rate, &R_tab->rate, rate64);
 		qdisc_put_rtab(R_tab);
 	} else {
@@ -176,8 +175,7 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 	}
 	if (P_tab) {
 		new->peak_present = true;
-		prate64 = tb[TCA_POLICE_PEAKRATE64] ?
-			  nla_get_u64(tb[TCA_POLICE_PEAKRATE64]) : 0;
+		prate64 = nla_get_u64_default(tb[TCA_POLICE_PEAKRATE64], 0);
 		psched_ratecfg_precompute(&new->peak, &P_tab->rate, prate64);
 		qdisc_put_rtab(P_tab);
 	} else {
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 2a7d856cc334..04942f8c62e0 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2297,7 +2297,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 	block->classid = parent;
 
-	chain_index = tca[TCA_CHAIN] ? nla_get_u32(tca[TCA_CHAIN]) : 0;
+	chain_index = nla_get_u32_default(tca[TCA_CHAIN], 0);
 	if (chain_index > TC_ACT_EXT_VAL_MASK) {
 		NL_SET_ERR_MSG(extack, "Specified chain index exceeds upper limit");
 		err = -EINVAL;
@@ -2509,7 +2509,7 @@ static int tc_del_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		goto errout;
 	}
 
-	chain_index = tca[TCA_CHAIN] ? nla_get_u32(tca[TCA_CHAIN]) : 0;
+	chain_index = nla_get_u32_default(tca[TCA_CHAIN], 0);
 	if (chain_index > TC_ACT_EXT_VAL_MASK) {
 		NL_SET_ERR_MSG(extack, "Specified chain index exceeds upper limit");
 		err = -EINVAL;
@@ -2664,7 +2664,7 @@ static int tc_get_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		goto errout;
 	}
 
-	chain_index = tca[TCA_CHAIN] ? nla_get_u32(tca[TCA_CHAIN]) : 0;
+	chain_index = nla_get_u32_default(tca[TCA_CHAIN], 0);
 	if (chain_index > TC_ACT_EXT_VAL_MASK) {
 		NL_SET_ERR_MSG(extack, "Specified chain index exceeds upper limit");
 		err = -EINVAL;
@@ -3104,7 +3104,7 @@ static int tc_ctl_chain(struct sk_buff *skb, struct nlmsghdr *n,
 	if (IS_ERR(block))
 		return PTR_ERR(block);
 
-	chain_index = tca[TCA_CHAIN] ? nla_get_u32(tca[TCA_CHAIN]) : 0;
+	chain_index = nla_get_u32_default(tca[TCA_CHAIN], 0);
 	if (chain_index > TC_ACT_EXT_VAL_MASK) {
 		NL_SET_ERR_MSG(extack, "Specified chain index exceeds upper limit");
 		err = -EINVAL;
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 91072010923d..1e940ad0d2fa 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -356,7 +356,7 @@ static int choke_change(struct Qdisc *sch, struct nlattr *opt,
 	    tb[TCA_CHOKE_STAB] == NULL)
 		return -EINVAL;
 
-	max_P = tb[TCA_CHOKE_MAX_P] ? nla_get_u32(tb[TCA_CHOKE_MAX_P]) : 0;
+	max_P = nla_get_u32_default(tb[TCA_CHOKE_MAX_P], 0);
 
 	ctl = nla_data(tb[TCA_CHOKE_PARMS]);
 	stab = nla_data(tb[TCA_CHOKE_STAB]);
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 79ba9dc70254..7d2151c62c4a 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -668,7 +668,7 @@ static int gred_change(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 	}
 
-	max_P = tb[TCA_GRED_MAX_P] ? nla_get_u32(tb[TCA_GRED_MAX_P]) : 0;
+	max_P = nla_get_u32_default(tb[TCA_GRED_MAX_P], 0);
 
 	ctl = nla_data(tb[TCA_GRED_PARMS]);
 	stab = nla_data(tb[TCA_GRED_STAB]);
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index ff3de37874e4..c31bc5489bdd 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1810,8 +1810,8 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 		qdisc_put_rtab(qdisc_get_rtab(&hopt->ceil, tb[TCA_HTB_CTAB],
 					      NULL));
 
-	rate64 = tb[TCA_HTB_RATE64] ? nla_get_u64(tb[TCA_HTB_RATE64]) : 0;
-	ceil64 = tb[TCA_HTB_CEIL64] ? nla_get_u64(tb[TCA_HTB_CEIL64]) : 0;
+	rate64 = nla_get_u64_default(tb[TCA_HTB_RATE64], 0);
+	ceil64 = nla_get_u64_default(tb[TCA_HTB_CEIL64], 0);
 
 	if (!cl) {		/* new class */
 		struct net_device *dev = qdisc_dev(sch);
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index d584c0c25899..6a07cdbdb9e1 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -421,10 +421,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_QFQ_WEIGHT])
-		weight = nla_get_u32(tb[TCA_QFQ_WEIGHT]);
-	else
-		weight = 1;
+	weight = nla_get_u32_default(tb[TCA_QFQ_WEIGHT], 1);
 
 	if (tb[TCA_QFQ_LMAX]) {
 		lmax = nla_get_u32(tb[TCA_QFQ_LMAX]);
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index b5f096588fae..6029bc29b51e 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -248,7 +248,7 @@ static int __red_change(struct Qdisc *sch, struct nlattr **tb,
 	    tb[TCA_RED_STAB] == NULL)
 		return -EINVAL;
 
-	max_P = tb[TCA_RED_MAX_P] ? nla_get_u32(tb[TCA_RED_MAX_P]) : 0;
+	max_P = nla_get_u32_default(tb[TCA_RED_MAX_P], 0);
 
 	ctl = nla_data(tb[TCA_RED_PARMS]);
 	stab = nla_data(tb[TCA_RED_STAB]);
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8623dc0bafc0..a68e17891b0b 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1828,7 +1828,7 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	 * zero; (2) the 'flags' of a "running" taprio instance cannot be
 	 * changed.
 	 */
-	taprio_flags = tb[TCA_TAPRIO_ATTR_FLAGS] ? nla_get_u32(tb[TCA_TAPRIO_ATTR_FLAGS]) : 0;
+	taprio_flags = nla_get_u32_default(tb[TCA_TAPRIO_ATTR_FLAGS], 0);
 
 	/* txtime-assist and full offload are mutually exclusive */
 	if ((taprio_flags & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST) &&
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1ac8a196f376..c1f7f6a65505 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1286,10 +1286,7 @@ static unsigned int nl80211_link_id(struct nlattr **attrs)
 {
 	struct nlattr *linkid = attrs[NL80211_ATTR_MLO_LINK_ID];
 
-	if (!linkid)
-		return 0;
-
-	return nla_get_u8(linkid);
+	return nla_get_u8_default(linkid, 0);
 }
 
 static int nl80211_link_id_or_invalid(struct nlattr **attrs)
@@ -3414,11 +3411,8 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		if (attrs[NL80211_ATTR_CENTER_FREQ1]) {
 			chandef->center_freq1 =
 				nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ1]);
-			if (attrs[NL80211_ATTR_CENTER_FREQ1_OFFSET])
-				chandef->freq1_offset = nla_get_u32(
-				      attrs[NL80211_ATTR_CENTER_FREQ1_OFFSET]);
-			else
-				chandef->freq1_offset = 0;
+			chandef->freq1_offset = nla_get_u32_default(attrs[NL80211_ATTR_CENTER_FREQ1_OFFSET],
+								    0);
 		}
 		if (attrs[NL80211_ATTR_CENTER_FREQ2])
 			chandef->center_freq2 =
@@ -8265,11 +8259,8 @@ static int nl80211_req_set_reg(struct sk_buff *skb, struct genl_info *info)
 	if (unlikely(!rcu_access_pointer(cfg80211_regdomain)))
 		return -EINPROGRESS;
 
-	if (info->attrs[NL80211_ATTR_USER_REG_HINT_TYPE])
-		user_reg_hint_type =
-		  nla_get_u32(info->attrs[NL80211_ATTR_USER_REG_HINT_TYPE]);
-	else
-		user_reg_hint_type = NL80211_USER_REG_HINT_USER;
+	user_reg_hint_type = nla_get_u32_default(info->attrs[NL80211_ATTR_USER_REG_HINT_TYPE],
+						 NL80211_USER_REG_HINT_USER);
 
 	switch (user_reg_hint_type) {
 	case NL80211_USER_REG_HINT_USER:
@@ -11087,11 +11078,8 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 			nla_len(info->attrs[NL80211_ATTR_SAE_PASSWORD]);
 	}
 
-	if (info->attrs[NL80211_ATTR_SAE_PWE])
-		settings->sae_pwe =
-			nla_get_u8(info->attrs[NL80211_ATTR_SAE_PWE]);
-	else
-		settings->sae_pwe = NL80211_SAE_PWE_UNSPECIFIED;
+	settings->sae_pwe = nla_get_u8_default(info->attrs[NL80211_ATTR_SAE_PWE],
+					       NL80211_SAE_PWE_UNSPECIFIED);
 
 	return 0;
 }
@@ -12347,10 +12335,8 @@ static int nl80211_disconnect(struct sk_buff *skb, struct genl_info *info)
 	    dev->ieee80211_ptr->conn_owner_nlportid != info->snd_portid)
 		return -EPERM;
 
-	if (!info->attrs[NL80211_ATTR_REASON_CODE])
-		reason = WLAN_REASON_DEAUTH_LEAVING;
-	else
-		reason = nla_get_u16(info->attrs[NL80211_ATTR_REASON_CODE]);
+	reason = nla_get_u16_default(info->attrs[NL80211_ATTR_REASON_CODE],
+				     WLAN_REASON_DEAUTH_LEAVING);
 
 	if (reason == 0)
 		return -EINVAL;
@@ -13696,10 +13682,7 @@ static int nl80211_parse_wowlan_tcp(struct cfg80211_registered_device *rdev,
 	cfg->dst = nla_get_in_addr(tb[NL80211_WOWLAN_TCP_DST_IPV4]);
 	memcpy(cfg->dst_mac, nla_data(tb[NL80211_WOWLAN_TCP_DST_MAC]),
 	       ETH_ALEN);
-	if (tb[NL80211_WOWLAN_TCP_SRC_PORT])
-		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
-	else
-		port = 0;
+	port = nla_get_u16_default(tb[NL80211_WOWLAN_TCP_SRC_PORT], 0);
 #ifdef CONFIG_INET
 	/* allocate a socket and port for it and use it */
 	err = __sock_create(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
@@ -13910,11 +13893,8 @@ static int nl80211_set_wowlan(struct sk_buff *skb, struct genl_info *info)
 			    pat_len < wowlan->pattern_min_len)
 				goto error;
 
-			if (!pat_tb[NL80211_PKTPAT_OFFSET])
-				pkt_offset = 0;
-			else
-				pkt_offset = nla_get_u32(
-					pat_tb[NL80211_PKTPAT_OFFSET]);
+			pkt_offset = nla_get_u32_default(pat_tb[NL80211_PKTPAT_OFFSET],
+							 0);
 			if (pkt_offset > wowlan->max_pkt_offset)
 				goto error;
 			new_triggers.patterns[i].pkt_offset = pkt_offset;
@@ -14158,10 +14138,8 @@ static int nl80211_parse_coalesce_rule(struct cfg80211_registered_device *rdev,
 		    pat_len < coalesce->pattern_min_len)
 			return -EINVAL;
 
-		if (!pat_tb[NL80211_PKTPAT_OFFSET])
-			pkt_offset = 0;
-		else
-			pkt_offset = nla_get_u32(pat_tb[NL80211_PKTPAT_OFFSET]);
+		pkt_offset = nla_get_u32_default(pat_tb[NL80211_PKTPAT_OFFSET],
+						 0);
 		if (pkt_offset > coalesce->max_pkt_offset)
 			return -EINVAL;
 		new_rule->patterns[i].pkt_offset = pkt_offset;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index e3b8ce89831a..e0dd9dfd71c2 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -200,7 +200,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			     struct netlink_ext_ack *extack)
 {
 	int err;
-	u8 sa_dir = attrs[XFRMA_SA_DIR] ? nla_get_u8(attrs[XFRMA_SA_DIR]) : 0;
+	u8 sa_dir = nla_get_u8_default(attrs[XFRMA_SA_DIR], 0);
 	u16 family = p->sel.family;
 
 	err = -EINVAL;
@@ -767,10 +767,8 @@ static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark *m)
 {
 	if (attrs[XFRMA_SET_MARK]) {
 		m->v = nla_get_u32(attrs[XFRMA_SET_MARK]);
-		if (attrs[XFRMA_SET_MARK_MASK])
-			m->m = nla_get_u32(attrs[XFRMA_SET_MARK_MASK]);
-		else
-			m->m = 0xffffffff;
+		m->m = nla_get_u32_default(attrs[XFRMA_SET_MARK_MASK],
+					   0xffffffff);
 	} else {
 		m->v = m->m = 0;
 	}
-- 
2.47.0


