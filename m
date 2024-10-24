Return-Path: <linux-wireless+bounces-14458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D72699AE3A4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 13:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09EDAB22F00
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 11:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A51CC8B9;
	Thu, 24 Oct 2024 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hm+tP16e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE71B21A5;
	Thu, 24 Oct 2024 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768700; cv=none; b=D5iRx8elJ3FzV87F0EK3HOH8AtnInVxN4xbaleAyYsX8GlhQFqtGYZg85WcHu3YTSXckzCXcdJQHJ9A1goJonUveFhRCjAtM7ahxIv/J5I9ZloQYmhWau3pbmrqZYxbp/6L9MC66QwHK8KQ01bhKLuVp4qDC2+MxC8ffXuGyuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768700; c=relaxed/simple;
	bh=BfQew6EZAD6lJOB8HCuc7XDhDHAvOxaTXYkeO9yXnnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHL26u3UwCJ8r1TaxG6rvT8EJfVhzqDg20fWkzwaKsMKq5MBTMg39kk4cIqpZcfgLiDdPOijQ1028GGx/RsNEwibMoZcgo1m5RIiVqUxyhLcbhTMjbqMf12UfsNu0y+qXWuZBhG+kWm3ly2m0TzARaMyhxey2CPVpKGGrEEz1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hm+tP16e; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Gq1IkDzokmgSKH88RQeuuw5ao1/WmAamDB2gNm+Oj4s=;
	t=1729768696; x=1730978296; b=hm+tP16e8puXp0CoQpYhEika1t/8GNHP3vCwnjtW1hEShlm
	o7/Gpj344qQkY6GrlxonL/Tpvdt89WgdKqxm/gEAWcYhB50qOBQGg1Hs27gRr2eWxbHC5kLlIF00B
	6VOVURWiwvXsaOtHrFQH5yfcvpv/EqxlbfbCM4eveTJIwkLydQZK31zm8h3Z/kD7HLU0NfWoZb+VI
	tYb1zG0UsNaWZyUuwweQxgimA+Uw6CEffY/ARBLdicApMujgzbgGbz0iBMkwTeuEfRfjIqxN7jZe0
	zn3DGDv01fAX+JIttGJRhGfh+z116vWhZxDK53RGQdwqkqQzj2w6/FNi+dybFdrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3vr1-00000003bsi-0KYA;
	Thu, 24 Oct 2024 13:18:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 2/2] net: convert to nla_get_*_default()
Date: Thu, 24 Oct 2024 13:18:07 +0200
Message-ID: <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
References: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is mostly to illustrate, done with the following spatch:

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
    )

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/8021q/vlan_netlink.c       |  6 ++--
 net/core/fib_rules.c           | 12 +++----
 net/core/rtnetlink.c           |  5 +--
 net/devlink/dev.c              |  6 ++--
 net/hsr/hsr_netlink.c          |  5 +--
 net/ieee802154/nl-mac.c        | 15 ++------
 net/ieee802154/nl802154.c      | 24 +++++--------
 net/ipv4/nexthop.c             | 10 ++----
 net/ipv6/addrconf.c            |  5 +--
 net/ipv6/ila/ila_xlat.c        | 13 +++----
 net/ipv6/ioam6.c               | 12 +++----
 net/ipv6/ioam6_iptunnel.c      |  6 ++--
 net/netfilter/ipvs/ip_vs_ctl.c |  5 +--
 net/netfilter/nf_nat_core.c    |  6 ++--
 net/netfilter/nft_tunnel.c     |  5 +--
 net/netlabel/netlabel_mgmt.c   | 12 ++-----
 net/nfc/netlink.c              |  6 ++--
 net/sched/act_gate.c           | 11 ++----
 net/sched/sch_gred.c           |  7 ++--
 net/sched/sch_htb.c            |  6 ++--
 net/sched/sch_netem.c          |  6 ++--
 net/sched/sch_qfq.c            |  5 +--
 net/wireless/nl80211.c         | 65 ++++++++++------------------------
 net/xfrm/xfrm_user.c           |  6 ++--
 24 files changed, 74 insertions(+), 185 deletions(-)

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
index 154a2681f55c..9831ccc02d5a 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -601,15 +601,11 @@ static int fib_nl2rule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	nlrule->action = frh->action;
 	nlrule->flags = frh->flags;
 	nlrule->table = frh_get_table(frh, tb);
-	if (tb[FRA_SUPPRESS_PREFIXLEN])
-		nlrule->suppress_prefixlen = nla_get_u32(tb[FRA_SUPPRESS_PREFIXLEN]);
-	else
-		nlrule->suppress_prefixlen = -1;
+	nlrule->suppress_prefixlen = nla_get_u32_default(tb[FRA_SUPPRESS_PREFIXLEN],
+							 -1);
 
-	if (tb[FRA_SUPPRESS_IFGROUP])
-		nlrule->suppress_ifgroup = nla_get_u32(tb[FRA_SUPPRESS_IFGROUP]);
-	else
-		nlrule->suppress_ifgroup = -1;
+	nlrule->suppress_ifgroup = nla_get_u32_default(tb[FRA_SUPPRESS_IFGROUP],
+						       -1);
 
 	if (tb[FRA_GOTO]) {
 		if (nlrule->action != FR_ACT_GOTO) {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6d68247aea70..ddba16e1c849 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2871,10 +2871,7 @@ static int do_setlink(const struct sk_buff *skb,
 			goto errout;
 		}
 
-		if (tb[IFLA_NEW_IFINDEX])
-			new_ifindex = nla_get_s32(tb[IFLA_NEW_IFINDEX]);
-		else
-			new_ifindex = 0;
+		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
 
 		err = __dev_change_net_namespace(dev, net, pat, new_ifindex);
 		put_net(net);
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 13c73f50da3d..23cfa163b9a9 100644
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
index f6ff0b61e08a..3d4630e876e1 100644
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
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 93aaea0006ba..3a520e158c47 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3248,10 +3248,7 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
 	}
 
 	if (op_flags) {
-		if (tb[NHA_OP_FLAGS])
-			*op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
-		else
-			*op_flags = 0;
+		*op_flags = nla_get_u32_default(tb[NHA_OP_FLAGS], 0);
 	}
 
 	return 0;
@@ -3433,10 +3430,7 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	if (tb[NHA_OP_FLAGS])
-		filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
-	else
-		filter->op_flags = 0;
+	filter->op_flags = nla_get_u32_default(tb[NHA_OP_FLAGS], 0);
 
 	return __nh_valid_dump_req(nlh, tb, filter, cb->extack);
 }
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 94dceac52884..bb921602d06c 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
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
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index dd2ce73a24fb..b5c7c67361f9 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -942,10 +942,8 @@ static int nfc_genl_dep_link_up(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	idx = nla_get_u32(info->attrs[NFC_ATTR_DEVICE_INDEX]);
-	if (!info->attrs[NFC_ATTR_TARGET_INDEX])
-		tgt_idx = NFC_TARGET_IDX_ANY;
-	else
-		tgt_idx = nla_get_u32(info->attrs[NFC_ATTR_TARGET_INDEX]);
+	tgt_idx = nla_get_u32_default(info->attrs[NFC_ATTR_TARGET_INDEX],
+				      NFC_TARGET_IDX_ANY);
 
 	comm = nla_get_u8(info->attrs[NFC_ATTR_COMM_MODE]);
 
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
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 79ba9dc70254..7a10bb159113 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -750,11 +750,8 @@ static int gred_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 	}
 
-	if (tb[TCA_GRED_LIMIT])
-		sch->limit = nla_get_u32(tb[TCA_GRED_LIMIT]);
-	else
-		sch->limit = qdisc_dev(sch)->tx_queue_len
-		             * psched_mtu(qdisc_dev(sch));
+	sch->limit = nla_get_u32_default(tb[TCA_GRED_LIMIT],
+					 qdisc_dev(sch)->tx_queue_len * psched_mtu(qdisc_dev(sch)));
 
 	if (qdisc_dev(sch)->netdev_ops->ndo_setup_tc) {
 		table->opt = kzalloc(sizeof(*table->opt), GFP_KERNEL);
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index ff3de37874e4..c3fa365cdd0a 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1103,10 +1103,8 @@ static int htb_init(struct Qdisc *sch, struct nlattr *opt,
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_HTB_DIRECT_QLEN])
-		q->direct_qlen = nla_get_u32(tb[TCA_HTB_DIRECT_QLEN]);
-	else
-		q->direct_qlen = qdisc_dev(sch)->tx_queue_len;
+	q->direct_qlen = nla_get_u32_default(tb[TCA_HTB_DIRECT_QLEN],
+					     qdisc_dev(sch)->tx_queue_len);
 
 	if ((q->rate2quantum = gopt->rate2quantum) < 1)
 		q->rate2quantum = 1;
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 39382ee1e331..05418a8af5ff 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1059,10 +1059,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
-	if (tb[TCA_NETEM_PRNG_SEED])
-		q->prng.seed = nla_get_u64(tb[TCA_NETEM_PRNG_SEED]);
-	else
-		q->prng.seed = get_random_u64();
+	q->prng.seed = nla_get_u64_default(tb[TCA_NETEM_PRNG_SEED],
+					   get_random_u64());
 	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
 
 unlock:
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
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4a8c3b6d49d1..14c8d6764f9e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3414,11 +3414,8 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
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
@@ -7378,17 +7375,11 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_VLAN_ID])
 		params.vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
 
-	if (info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL])
-		params.listen_interval =
-		     nla_get_u16(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL]);
-	else
-		params.listen_interval = -1;
+	params.listen_interval = nla_get_u16_default(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL],
+						     -1);
 
-	if (info->attrs[NL80211_ATTR_STA_SUPPORT_P2P_PS])
-		params.support_p2p_ps =
-			nla_get_u8(info->attrs[NL80211_ATTR_STA_SUPPORT_P2P_PS]);
-	else
-		params.support_p2p_ps = -1;
+	params.support_p2p_ps = nla_get_u8_default(info->attrs[NL80211_ATTR_STA_SUPPORT_P2P_PS],
+						   -1);
 
 	if (!info->attrs[NL80211_ATTR_MAC])
 		return -EINVAL;
@@ -7578,10 +7569,8 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			dev->ieee80211_ptr->iftype == NL80211_IFTYPE_P2P_GO;
 	}
 
-	if (info->attrs[NL80211_ATTR_PEER_AID])
-		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_PEER_AID]);
-	else
-		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_STA_AID]);
+	params.aid = nla_get_u16_default(info->attrs[NL80211_ATTR_PEER_AID],
+					 nla_get_u16(info->attrs[NL80211_ATTR_STA_AID]));
 
 	if (info->attrs[NL80211_ATTR_STA_CAPABILITY]) {
 		params.capability =
@@ -8265,11 +8254,8 @@ static int nl80211_req_set_reg(struct sk_buff *skb, struct genl_info *info)
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
@@ -11087,11 +11073,8 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
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
@@ -12347,10 +12330,8 @@ static int nl80211_disconnect(struct sk_buff *skb, struct genl_info *info)
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
@@ -13696,10 +13677,7 @@ static int nl80211_parse_wowlan_tcp(struct cfg80211_registered_device *rdev,
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
@@ -13910,11 +13888,8 @@ static int nl80211_set_wowlan(struct sk_buff *skb, struct genl_info *info)
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
@@ -14158,10 +14133,8 @@ static int nl80211_parse_coalesce_rule(struct cfg80211_registered_device *rdev,
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
index 2b10a45ff124..2fa354cdd89f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -763,10 +763,8 @@ static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark *m)
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


