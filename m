Return-Path: <linux-wireless+bounces-29617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F46CAF04D
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 07:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73D14301A199
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E012879DA;
	Tue,  9 Dec 2025 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="ksEo6rsU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8332039E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765261519; cv=none; b=UTY4gyLyYmQu/QlVbnLH7qqnB+q5979TjkxE0ZawrY+1Snb2+YgbTIpHeQyF1za+UsCh4WE+eVhzrJMqVJI+sy3MrpRoG0mVC1SXYboabpHsp8j5A/Xrsh6LCfPzTVOXJ4RaL4Sqf7DximTipzyYl/FxmxOyvvMCbg1O+e0/974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765261519; c=relaxed/simple;
	bh=yvhBc64MNSsRehK5cUgTUjLi0ndGfjlHnZnA0vRsPts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqOCvidx7jUFZkoEKnzo85gtMFCa5CKVoYDYQ3OrZ03cnPzPrjD1/fY6zd/UI24lX5LcpFjLfavneuFX71VgxscalXYLrG2ib9xGiL92f4AmOJIT867FJDFHdhFoUKvRkd8OBbxztMMoO22P4/dwCgqWv0aUX6gcQ6nxePuwoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=ksEo6rsU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ba49f92362so2898808b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 22:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1765261517; x=1765866317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dsN7cShP1G4cgYLTShbXlzulIH8gi/q/DR7n+4pKEM=;
        b=ksEo6rsUSo0Ra0gx9YVj6QNbB0D4wr4I3T+48SRWsAVYP6muza5F5/sb4m/ImFGcrx
         sI9oBwTJrrhkcqT/v/gPVK6vjB5Ao1dKJAeY+fHT72DspQ4ROdBqx+6CkdGQLUV9/CnI
         RxMVyjv1jGlhKKsrNiQZnU+YZlP/mriY9doA7P3Kve+FAeL57aW3/OW7u4stnmzP825d
         iU2KDmmlJsdVoWiyS25y4p9+aXhpMLF7+DV2W5UwHWlMneOjtqlHx02pwbrzTTQU9jBe
         jYbuQ28HT+6n1JQ3W7VxID4/dQLE0YbvRyZhwbHwAR1y4jf2ZrEg7D6l1e6zz/elzWk4
         rfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765261517; x=1765866317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/dsN7cShP1G4cgYLTShbXlzulIH8gi/q/DR7n+4pKEM=;
        b=R1AjOjJ9kPmdch3xcykZHfc4/TsPioScWASYPkGD/CqRnycNnfYC2pcOtEvSpW525A
         UaVdoQZClyMPVGgyhg/p2j7YpJbQiYVJ5ccMK88x/pCtHhy59MaHK1dTBkPN6GqBEQ/d
         nxyoKVUsrUqUxqCPWnla+1U+IIn/TVwO8SR5QVxamqAPY04+9zq7Ctop5ednaxzkBYGU
         qttpARQWs0TPU18SCxiQSfZpsaf5S156GwM5tQzT1h1IwkNDreCep0IIF9MRpFoKjw0j
         7+UuMHx9iaguErfFeHprbSj/LUoZ13UNCKU/AFyaMcL53a9YUjhpS/Z2qj1Kvp1bifKs
         ApGQ==
X-Gm-Message-State: AOJu0Yx6DT517LPpApaZoJav5hM5gj2zmjvPvJYISNxqRv/fodtWXL4A
	h+skRfutr7nMUgaLQmTlcYvR6NRl4SmFRTxgtx7eMNLAt/+2hITNeTEdMMsVrg74zw==
X-Gm-Gg: ASbGncvluySfFgjdTW04MWe+oykNNwpmYW5tdWNpd2QL/ZZC5jUvrwMgCBAJGqG5FDD
	gQ3y92SG6qMpHcZQpIQMQIuK06wQHcvj6lpnzx6nf5NVnaWhSzCa0fc2HqORmemRe82Mv4eCFPx
	Pvg+uZjKX3E0ct2hHbm2tj7JVK1rWfdhxstMS+6gLrmoOL+4iP1asovhX8HQdOa3rXGEDHGQR5y
	lR0xOf6FXJxvmPUl1225pgCz0E0KDxi1RHknUCKTwMxKW59k55qlhTVQ8vTz6Dz7Fdm+yWk4WoB
	Gh9Qp+uomjA3e6KS8xFm+sTlXCgxo7U4LSYJDlAXgiPAu6capDz1UK20Rj1NXI3EXsu4dM1mvwU
	bOstQErmSSP5sCz37OjcBOGfiwxZOgXIsD3GaGQ7np5mRbuwGlKMsYIx6ZrPnDOWKvhvu83P/aZ
	DXer110g8l/L8m93UIemhpi8eu
X-Google-Smtp-Source: AGHT+IH2imNA2VsOg+kudI4gTvYXE41AR944hSKiEnnHT/brGJhhcshf8AWy3V69YUbaK3lFCZZ7TQ==
X-Received: by 2002:a05:6a00:2387:b0:7a9:d8a8:992a with SMTP id d2e1a72fcca58-7f13277cdb5mr483872b3a.13.1765261517260;
        Mon, 08 Dec 2025 22:25:17 -0800 (PST)
Received: from 1207.mumbai.mm.lcl ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2adc5c400sm14916187b3a.37.2025.12.08.22.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 22:25:16 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	arien.judge@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH wireless-next v2 1/3] wifi: cfg80211: Add support for S1G Response Indication Configuration
Date: Tue,  9 Dec 2025 11:54:22 +0530
Message-Id: <20251209062424.3926297-2-ria.thomas@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
References: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In S1G, a STA distributes a Response Indication (RI) to protect the
frame expected at SIFS after the eliciting frame. Introduce a
userspace configurable selector for the expected response frame
type (i.e., Block Ack, NDP, or no response) after transmitting
certain S1G frames.

Signed-off-by: Ria Thomas <ria.thomas@morsemicro.com>
---

v1 -> v2
- fixed kernel doc
---
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h | 14 ++++++++++++++
 net/wireless/nl80211.c       | 24 ++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 14 ++++++++++++++
 net/wireless/trace.h         | 18 ++++++++++++++++++
 5 files changed, 73 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 899f267b7cf9..8c538a9e3471 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4839,6 +4839,7 @@ struct mgmt_frame_regs {
  *	links by calling cfg80211_mlo_reconf_add_done(). When calling
  *	cfg80211_mlo_reconf_add_done() the bss pointer must be given for each
  *	link for which MLO reconfiguration 'add' operation was requested.
+ * @set_s1g_ri: Set response indication frame type.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -5210,6 +5211,8 @@ struct cfg80211_ops {
 				   struct cfg80211_ml_reconf_req *req);
 	int	(*set_epcs)(struct wiphy *wiphy, struct net_device *dev,
 			    bool val);
+	int	(*set_s1g_ri)(struct wiphy *wiphy, struct net_device *dev,
+			      u8 val);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8134f10e4e6c..4ca86c1fd361 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1361,6 +1361,10 @@
  *	user space that the NAN new cluster has been joined. The cluster ID is
  *	indicated by %NL80211_ATTR_MAC.
  *
+ * @NL80211_CMD_SET_S1G_RI: This command is used to enable and set the
+ *	response indication type for an S1G station. The frame type is
+ *	indicated by %NL80211_ATTR_S1G_RI_FRAME_TYPE.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1624,6 +1628,8 @@ enum nl80211_commands {
 	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
 	NL80211_CMD_NAN_CLUSTER_JOINED,
 
+	NL80211_CMD_SET_S1G_RI,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2973,6 +2979,12 @@ enum nl80211_commands {
  *	primary channel is 2 MHz wide, and the control channel designates
  *	the 1 MHz primary subchannel within that 2 MHz primary.
  *
+ * @NL80211_ATTR_S1G_RI_FRAME_TYPE: (u8) Integer attibute used with
+ *	%NL80211_CMD_SET_S1G_RI that represents the RID
+ *	(Response Indication Deferral) information distributed by
+ *	an S1G STA in order to protect the response frame, which is
+ *	expected a SIFS time after the frame that elicits that response.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3541,6 +3553,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_S1G_PRIMARY_2MHZ,
 
+	NL80211_ATTR_S1G_RI_FRAME_TYPE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c961cd42a832..315e17997cb6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -932,6 +932,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
+	[NL80211_ATTR_S1G_RI_FRAME_TYPE] = { .type = NLA_U8 },
 };
 
 /* policy for the key attributes */
@@ -17826,6 +17827,23 @@ nl80211_epcs_cfg(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_epcs(rdev, dev, val);
 }
 
+static int nl80211_set_s1g_ri(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	u8 val;
+
+	if (!rdev->ops->set_s1g_ri)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_S1G_RI_FRAME_TYPE])
+		return -EINVAL;
+
+	val = nla_get_u8(info->attrs[NL80211_ATTR_S1G_RI_FRAME_TYPE]);
+
+	return rdev_set_s1g_ri(rdev, dev, val);
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -19031,6 +19049,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_SET_S1G_RI,
+		.doit = nl80211_set_s1g_ri,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index ac6884bacf3f..d29a4d55f860 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1584,4 +1584,18 @@ rdev_set_epcs(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int
+rdev_set_s1g_ri(struct cfg80211_registered_device *rdev,
+		struct net_device *dev, u8 val)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+	int ret = -EOPNOTSUPP;
+
+	trace_rdev_set_s1g_ri(wiphy, dev, val);
+	ret = rdev->ops->set_s1g_ri(wiphy, dev, val);
+	trace_rdev_return_int(wiphy, ret);
+
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 2b71f1d867a0..ec200e94e9a6 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3122,6 +3122,24 @@ TRACE_EVENT(rdev_set_epcs,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->val)
 );
 
+TRACE_EVENT(rdev_set_s1g_ri,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 u8 val),
+	TP_ARGS(wiphy, netdev, val),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__field(u8, val)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		__entry->val = val;
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", ri=%u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->val)
+);
+
 /*************************************************************
  *	     cfg80211 exported functions traces		     *
  *************************************************************/
-- 
2.25.1


