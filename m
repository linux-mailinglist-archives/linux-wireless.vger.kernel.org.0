Return-Path: <linux-wireless+bounces-13535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6559910B2
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AAD6B21EAD
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F61D90B3;
	Fri,  4 Oct 2024 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="D7WNq8yz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A41D8A06
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073333; cv=none; b=M4z7qknMKQkyIyvBRB6VgDp7FMEhcqkbd7KD2mzUF/zZj08ympw9RnqtfvQG6dhAl0ykTRhAsEXrBt018uF60pcLrgrq+teI5ABd6cmYZTWkOC3qFv88yIgraIlQqCE2qmo/OcB+C1OKZkyxaTMg93PeMD5jHvBohv4GX5jg+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073333; c=relaxed/simple;
	bh=/UWeShPxKJg9mCvNie8xIuziy/LvDgBTyiIWWI3BpJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnNwP//xqPurI8g+aEvnJUob98vuJ/Ae01YguE2KZZjW8N43AsmyPGtS0DwhlWabWPNtsuKW/pakbUFKssFa/2c/a1IRWvaOgOorRGoeehhIkEgxtxaSUBVj55M8NzlqGeytWSIx9Ek9s5K4ZmJzGRfEWu0Vj0jGUPD6gVwn9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=D7WNq8yz; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kQeLPEcYIRu1eH/cWq7yoDL/PgiPQBHYYMrgL9uRlwM=; b=D7WNq8yzWsRD8V1+C/nzDpO0+0
	5MEhciH4eBcf9mh/HaHVUxvykkEPMwE5Ur/cvBf3WcnTLso0BPAnIf+EtSl+sGEqXBOrvm0vvNdr8
	mmhd/LsjM4C5qVMX+Jk9wBFb8tFFtf8CsK5ydpwO9bkmxncCkD3zl3oeGuoW1xkXzI1I=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1swooM-004jVl-36;
	Fri, 04 Oct 2024 22:22:03 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v3 04/11] wifi: cfg80211: report per wiphy radio antenna mask
Date: Fri,  4 Oct 2024 22:21:54 +0200
Message-ID: <be2cb63f97aa2c05fa358d2eeb8bc1a0f8a46596.1728063865.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
References: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With multi-radio devices, each radio typically gets a fixed set of antennas.
In order to be able to disable specific antennas for some radios, user space
needs to know which antenna mask bits are assigned to which radio.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h       | 4 ++++
 include/uapi/linux/nl80211.h | 3 +++
 net/wireless/nl80211.c       | 4 +++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 73df4a8e8cce..8bb5fb80cd7b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5436,6 +5436,8 @@ struct wiphy_radio_freq_range {
  * @iface_combinations: Valid interface combinations array, should not
  *	list single interface types.
  * @n_iface_combinations: number of entries in @iface_combinations array.
+ *
+ * @antenna_mask: bitmask of antennas connected to this radio.
  */
 struct wiphy_radio {
 	const struct wiphy_radio_freq_range *freq_range;
@@ -5443,6 +5445,8 @@ struct wiphy_radio {
 
 	const struct ieee80211_iface_combination *iface_combinations;
 	int n_iface_combinations;
+
+	u32 antenna_mask;
 };
 
 #define CFG80211_HW_TIMESTAMP_ALL_PEERS	0xffff
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d31ccee99cc7..1b8827f920ff 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8036,6 +8036,8 @@ enum nl80211_ap_settings_flags {
  * @NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION: Supported interface
  *	combination for this radio. Attribute may be present multiple times
  *	and contains attributes defined in &enum nl80211_if_combination_attrs.
+ * @NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK: bitmask (u32) of antennas
+ *	connected to this radio.
  *
  * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
  * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
@@ -8046,6 +8048,7 @@ enum nl80211_wiphy_radio_attrs {
 	NL80211_WIPHY_RADIO_ATTR_INDEX,
 	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE,
 	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
+	NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
 
 	/* keep last */
 	__NL80211_WIPHY_RADIO_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7f3bd35c8a3b..d2c1fd98dc03 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2428,7 +2428,9 @@ static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
 	if (!radio)
 		return -ENOBUFS;
 
-	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx))
+	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx) ||
+	    nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
+			r->antenna_mask))
 		goto nla_put_failure;
 
 	for (i = 0; i < r->n_freq_range; i++) {
-- 
git-series 0.9.1

