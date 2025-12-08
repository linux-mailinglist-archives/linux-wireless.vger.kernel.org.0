Return-Path: <linux-wireless+bounces-29580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB32ACABF96
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 04:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5402300C28C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 03:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F139C2F7478;
	Mon,  8 Dec 2025 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="CvNwy+Fy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263572F745B
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 03:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165217; cv=none; b=lQyXNUP1RnTLWJL/VkUCkRkh/gtwwRt/2ccYyc6eJLcU9Bo2FpRww5tMuvikZuO+V/K5x5ivAO21COjbiWI7aLnCYnnnsolEoiZrazgGMechkCG0IapVnbyNv3Xh2IteEKnclHcvwNJK3hRD07lAj7JHPfJzPGdYvb7KPHzCF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165217; c=relaxed/simple;
	bh=qTrY06Qe96/Kse35O5stUkCLeaH15jIjn95vaTL2TBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pxc4tT21y1w6IYs4qjp+48M7YOKmTmbeTDdi+S71qodYBLxT1w2An4KG40dCW2Ly1kft7vDNAaqAyVw8flt0iHgps5FZkBjhLzOC0li07hbyzIuk1xgvDfMG54mxqMjCFzem4lk4rD7eDeUPJghxa+d3sg/ZeB8WGgzToO+6LAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=CvNwy+Fy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34372216275so3985427a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 19:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1765165215; x=1765770015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv85TTU3zfWz9GhLkqFHscOyeOMkd2e4w4evstbBjbc=;
        b=CvNwy+FyC8EcuK88OOgRFvgRsB2vwM6VAHzfGCApKaOgt98CsAhPf6GZy6G5CWGUqb
         hojgyuLuud7Aj0g9lLzb0K3NWJdGnMldyKnmSKy4y3TvMhJmiXHAN8GIzwLFw8M+FAHD
         BN2Y6su7XgPFtuzbEMhMVE/RGNvzn9jgRpzSNw5+mIBI2WfAK6H46ROgo3d9bJgHsGvu
         7UX9Gxgtpzb6NzHn+JikrPBGxtSLDyN8eh2SwZ7xZ195aZp/Gbfw/xnCeod+xLul+mDs
         HdJQYApiE0RZkg9gDKkKiaUB48FNihcY6NjuBADORAO8Rz8idDJj140qQ127Mrfur1/Z
         9UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765165215; x=1765770015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tv85TTU3zfWz9GhLkqFHscOyeOMkd2e4w4evstbBjbc=;
        b=nW3S/E8MgGeLS4GsaLE8C7fso0/QEvBoSI+25wkJ/GIpWLEIoQzEF0WS3Kd0nkRLd3
         TOGBNBaf7jQ+o1OURPWyFDYigp/Z9NPBfaY+Qx4E/Ty3Nr688mVdyXH20uMHoC+gPfVh
         H4BHZjGUHUYWgf/KEMnTRWDPUmcu4tTj2pSyDMFE+o0Bk1RCaMpc+6E99FmEDsNfLi95
         QH2+s18RmrwUeSbjc0nK0GHZLF1wilUS2eOjdg1SRp3xoMRUTusBuW0UTtD/FlgrxrAH
         T88B9x2R0pq/SPMnS1Me7aIzVYTQ6LDkzRJY+KDd6tBImYBboZREtkhnH/n8TW++sTkE
         rTpg==
X-Gm-Message-State: AOJu0YxwZzRa8tsZ1KJ90gH/4oG0GXGXLGMbFpWAQ2RFbXEfa6AoCJeY
	bFB+nBXcNFOIRZ0laL4ceaeU/rJiTrCpjYKJnEo7J7ul2zxoBZgaxSpTB1Gf9ulOng==
X-Gm-Gg: ASbGncvHT5Z5c/a5awSbV1/7b9ZLwdDkRJptWX7TNVzRQh9JEvNvmUp8RJ7SQNrfMKl
	DlaagtNOoXcD+0xEylke1scL9VXL7xi2aBcmyVy5a+etzXc5MWsHh8WuGwvM/8TEsHQGx1ruDup
	6w2z63r9iAfcAE7aoLWXk/qt7hTgFK5tEzyI23N5QbS3orWvFr9IIeK9sa7B/3UXaTBxzQYpRIb
	sgKyPYeiODjLv/ITKcqZC7ql9K+8JSCGcQE/Oh71wmR2jms9AN2l5gwW59bSckBYa1ItFZ0vjFD
	422HItfk9D3jXbffj7+LkJhkY46C60ML0gkBLiiiSs+1dyqD4slUUk+ob5tbaxemS8BKrmW2WzC
	MeZVWCyverw9slctDRWkBiLYapVEQOlELlRIt5JGx1O69IH3mvekMm1FQfWPE80k05Qt7Mmds4R
	azxlNVkJ9QLlksahiXeyaYyOFO
X-Google-Smtp-Source: AGHT+IFshtwWO+ZfNCG5a/Z85LsuilKcKBAcQcR4hv4Hnp7lkJYidsAenRYwHY69jyLulAq2/GD3nw==
X-Received: by 2002:a17:90b:1c03:b0:34a:e9b:26b1 with SMTP id 98e67ed59e1d1-34a0e9b2796mr1185574a91.26.1765165215234;
        Sun, 07 Dec 2025 19:40:15 -0800 (PST)
Received: from 1207.mumbai.mm.lcl ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea899desm10383209a91.17.2025.12.07.19.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 19:40:14 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	arien.judge@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH wireless-next 1/3] wifi: cfg80211: Add support for S1G Response Indication Configuration
Date: Mon,  8 Dec 2025 09:09:37 +0530
Message-Id: <20251208033939.3005700-2-ria.thomas@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251208033939.3005700-1-ria.thomas@morsemicro.com>
References: <20251208033939.3005700-1-ria.thomas@morsemicro.com>
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
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h | 14 ++++++++++++++
 net/wireless/nl80211.c       | 24 ++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 14 ++++++++++++++
 net/wireless/trace.h         | 18 ++++++++++++++++++
 5 files changed, 72 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 899f267b7cf9..cd82f1801b2c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5210,6 +5210,8 @@ struct cfg80211_ops {
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


