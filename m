Return-Path: <linux-wireless+bounces-35457-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABg7NCZ98GlSUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35457-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:25:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9B34815A1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F48D30ADEC3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AFA3DBD74;
	Tue, 28 Apr 2026 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YbBrRQjm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68713D88E0
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367366; cv=none; b=LQkxyACSJm8BRaEj/OX5lbFIV14b1Zm27Lkm5g810F+BcwU8TGiAvauxTJJCM1yoNemMv0JyXWJE+RLHXtMopZG5gDcTwoHvakwEjuSGvABbnTKanbQ3Z20Mxi5aNvD0ibaXmM73yIXaT1BmdB7IBZWBgNOnJPYHdoHsJ29n5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367366; c=relaxed/simple;
	bh=Ezs7f+TkDNd7C9369mYFLyWSbvaYS/Fdm/I2jdQ6GMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2ofMu0nkRU2SeSc/DVPLKFsIHL+d/EdzFG/kWsD9Og6AYhvckTBiDulEbYnuL/AgGsUL3qGLu7F5mQO3h6cO+VOXiuZJw8O8c27auu4xN0ncqWdHcJ0rqfnTvSVh0yD4Kw69looG3AMYISHwfmPTgEeb1inOV0zdxTML4PvQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YbBrRQjm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=alPREHQgH9OgO7XBJtxrNX7R5HKf3hqXx/wwofcWT1A=;
	t=1777367364; x=1778576964; b=YbBrRQjm0Ww4Vac/am+4qzqc/+zvPdSxgOUpv9JfMXcA+tM
	PxIlq/bmB676YcCFy8nviYeWG8BkKD0tCABlwlyNJ8ze60oPaJQOetUx+tHx+kQsOgAoRIH/b5/Tn
	5926QOBNbGvzdrC4DARr9DaxaaK2uN5NVZuIfl4RFfY2XXq/jrA8iu6lHW7CBmvRwKcUyN7OVbYRR
	jsRHgypxGALLs+FmORSgqbSpWVCEFzv02bldb/RmR05CFxeWoCRZxBjCzsNSqvg1PubdJ+PnEYvqA
	0jaTAVXLQI2Wdvc3xd8yiKUAT0le/RxeqcE/wNE1KJnxHhvD4IwU2BDzNxyXtA9Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeRW-0000000HGH2-0T0Q;
	Tue, 28 Apr 2026 11:09:22 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 4/5] wifi: cfg80211: allow devices to advertise extended MLD capa/ops
Date: Tue, 28 Apr 2026 11:06:59 +0200
Message-ID: <20260428110915.e808e70feed6.I378a7c017bfc1ebb072fa8d5d1db2ac9b45596c9@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428090915.54717-7-johannes@sipsolutions.net>
References: <20260428090915.54717-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C9B34815A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35457-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]

From: Johannes Berg <johannes.berg@intel.com>

For UHR, multi-link power-management capability lives there, and
so it's needed that hostapd knows what to advertise, and clients
should have it shown to userspace for information.

Repurpose the existing NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS by
renaming it to NL80211_ATTR_EXT_MLD_CAPA_AND_OPS (with a define
for compatibility) and advertise the capabilities.

We can also later use the value, if needed, to set per-station
capabilities on STAs added to AP interfaces.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h | 15 +++++++++------
 net/wireless/nl80211.c       | 18 ++++++++++++------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a40ab36b8edb..7c2ddaf2bcd7 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5855,6 +5855,7 @@ struct wiphy_vendor_command {
  * @extended_capabilities_len: length of the extended capabilities
  * @eml_capabilities: EML capabilities (for MLO)
  * @mld_capa_and_ops: MLD capabilities and operations (for MLO)
+ * @ext_mld_capa_and_ops: Extended MLD capabilities and operations (for MLO)
  */
 struct wiphy_iftype_ext_capab {
 	enum nl80211_iftype iftype;
@@ -5863,6 +5864,7 @@ struct wiphy_iftype_ext_capab {
 	u8 extended_capabilities_len;
 	u16 eml_capabilities;
 	u16 mld_capa_and_ops;
+	u16 ext_mld_capa_and_ops;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 072b383d7d3c..e104943b7e3d 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2993,11 +2993,13 @@ enum nl80211_commands {
  * @NL80211_ATTR_EPCS: Flag attribute indicating that EPCS is enabled for a
  *	station interface.
  *
- * @NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS: Extended MLD capabilities and
- *	operations that userspace implements to use during association/ML
- *	link reconfig, currently only "BTM MLD Recommendation For Multiple
- *	APs Support". Drivers may set additional flags that they support
- *	in the kernel or device.
+ * @NL80211_ATTR_EXT_MLD_CAPA_AND_OPS: Extended MLD capabilities and operations.
+ *	For association and link reconfiguration, indicates extra capabilities
+ *	that userspace implements, currently only "BTM MLD Recommendation For
+ *	Multiple APs Support".
+ *	For wiphy information, additional flags that drivers will set, but
+ *	this is informational only for userspace (it's not expected to set
+ *	these.)
  *
  * @NL80211_ATTR_WIPHY_RADIO_INDEX: (int) Integer attribute denoting the index
  *	of the radio in interest. Internally a value of -1 is used to
@@ -3697,7 +3699,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_MLO_RECONF_REM_LINKS,
 	NL80211_ATTR_EPCS,
 
-	NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS,
+	NL80211_ATTR_EXT_MLD_CAPA_AND_OPS,
 
 	NL80211_ATTR_WIPHY_RADIO_INDEX,
 
@@ -3749,6 +3751,7 @@ enum nl80211_attrs {
 #define NL80211_ATTR_SAE_DATA NL80211_ATTR_AUTH_DATA
 #define NL80211_ATTR_CSA_C_OFF_BEACON NL80211_ATTR_CNTDWN_OFFS_BEACON
 #define NL80211_ATTR_CSA_C_OFF_PRESP NL80211_ATTR_CNTDWN_OFFS_PRESP
+#define NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS NL80211_ATTR_EXT_MLD_CAPA_AND_OPS
 
 /*
  * Allow user space programs to use #ifdef on new attributes by defining them
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cf236307cca9..6e76285c1045 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1047,7 +1047,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 				       NL80211_MAX_SUPP_SELECTORS),
 	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
 	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
-	[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
+	[NL80211_ATTR_EXT_MLD_CAPA_AND_OPS] = { .type = NLA_U16 },
 	[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_U8 },
 	[NL80211_ATTR_S1G_LONG_BEACON_PERIOD] = NLA_POLICY_MIN(NLA_U8, 2),
 	[NL80211_ATTR_S1G_SHORT_BEACON] =
@@ -3461,6 +3461,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 						 NL80211_ATTR_MLD_CAPA_AND_OPS,
 						 capab->mld_capa_and_ops)))
 					goto nla_put_failure;
+				if (rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_MLO &&
+				    capab->ext_mld_capa_and_ops &&
+				    nla_put_u16(msg,
+						NL80211_ATTR_EXT_MLD_CAPA_AND_OPS,
+						capab->ext_mld_capa_and_ops))
+					goto nla_put_failure;
 
 				nla_nest_end(msg, nested_ext_capab);
 				if (state->split)
@@ -12921,9 +12927,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			goto free;
 		}
 
-		if (info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS])
+		if (info->attrs[NL80211_ATTR_EXT_MLD_CAPA_AND_OPS])
 			req.ext_mld_capa_ops =
-				nla_get_u16(info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS]);
+				nla_get_u16(info->attrs[NL80211_ATTR_EXT_MLD_CAPA_AND_OPS]);
 	} else {
 		if (req.link_id >= 0)
 			return -EINVAL;
@@ -12934,7 +12940,7 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			return PTR_ERR(req.bss);
 		ap_addr = req.bss->bssid;
 
-		if (info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS])
+		if (info->attrs[NL80211_ATTR_EXT_MLD_CAPA_AND_OPS])
 			return -EINVAL;
 	}
 
@@ -18798,9 +18804,9 @@ static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	if (info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS])
+	if (info->attrs[NL80211_ATTR_EXT_MLD_CAPA_AND_OPS])
 		req.ext_mld_capa_ops =
-			nla_get_u16(info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS]);
+			nla_get_u16(info->attrs[NL80211_ATTR_EXT_MLD_CAPA_AND_OPS]);
 
 	err = cfg80211_assoc_ml_reconf(rdev, dev, &req);
 
-- 
2.53.0


