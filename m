Return-Path: <linux-wireless+bounces-32424-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA8KH4JQp2nKggAAu9opvQ
	(envelope-from <linux-wireless+bounces-32424-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 22:20:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE321F76A9
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 22:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1204430B32E1
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 21:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599232AAD1;
	Tue,  3 Mar 2026 21:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ILePEZeb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597793BED40
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572638; cv=none; b=bI4JPTmm1nLHBTqb2N1xlvXcs6LlZ3stN/77kU/fxt+EU3Jq0J+H9OIM5EJ3bh54yY3UoP+cgM+8c8g3Xv2r5yjWIRIWLIII6Ok6rVNdEwWxlxDoYTkdVHiA6h9zzGSxLjazB/U9f9hAFxSgEkA5IdwMvkAo5ujTyAJ2wSicJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572638; c=relaxed/simple;
	bh=wP4/dZ9i8D+LWKUXJjYKmOjqIeTjJFLRtlYmk1Th6/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M74QlVVw6y73jICBZ+klmJ+seomX0dPBmnA7mshCRs5kPyC2eE7RFvgk23kUqafhMglg8HHCFg/ekyBeJyOhC2S77JPXRv/4yj6gLxGSSJFTf7fXwYMnu9wz0Ni5WCoZvWv/KRZ39ZhH+ZCh6yuUJVEeMbu/QgOy+ViXJYkJ76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ILePEZeb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=4ef5LCTYWA9bEJt53//cHInidnhR5+bIF/+WvmJS/AA=; t=1772572637; x=1773782237; 
	b=ILePEZebx2eyJIX+bs+WzoNFotWLnSnTdFV6BXTzCM8Eq2ieEKYRmirtX25dORXVLJRWJTSQyN4
	xbEk4cOfgCDm5QN6Vi3VnCUA+wH0DcfAmA6DV2MN6jHrPoOtU768dwGeIkf/9+MrkXbnoaUEN07dr
	KhBfCILZAye1uNObVTN1vsUVqD7wXo6EYshbgwhDbFZp5pfsFfbU6nGkxwW8vWTLaasyhO5LMLm1z
	4vSIcQqPICeUYTqt1RkfMi4dO01NvY47SUTdXEqSNFIFn6ScNqXz2moVjbte/ggsrlo+80yj2xjvX
	olIFGopk38jLmwCelqdj9ysaY0dGzSdPWKpA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxX7B-00000007L1S-1ge3;
	Tue, 03 Mar 2026 22:17:13 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless-next] wifi: nl80211: split out UHR operation information
Date: Tue,  3 Mar 2026 22:17:09 +0100
Message-ID: <20260303221710.866bacf82639.Iafdf37fb0f4304bdcdb824977d61e17b38c47685@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CE321F76A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32424-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The beacon doesn't contain the full UHR operation, a number
of fields (such as NPCA) are only partially there. Add a new
attribute to contain the full information, so it's available
to the driver/mac80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: fix double opening bracket from backport removal
---
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       | 26 ++++++++++++++++----------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0b7a06c2b9f7..67d764023988 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3001,6 +3001,10 @@ enum nl80211_commands {
  *	interference detection is not performed on these sub-channels, their
  *	corresponding bits are consistently set to zero.
  *
+ * @NL80211_ATTR_UHR_OPERATION: Full UHR Operation element, as it appears in
+ *	association response etc., since it's abridged in the beacon. Used
+ *	for START_AP etc.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3576,6 +3580,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP,
 
+	NL80211_ATTR_UHR_OPERATION,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2225f5d0b124..6b402197f1dd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -342,6 +342,17 @@ static int validate_uhr_capa(const struct nlattr *attr,
 	return ieee80211_uhr_capa_size_ok(data, len, false);
 }
 
+static int validate_uhr_operation(const struct nlattr *attr,
+				  struct netlink_ext_ack *extack)
+{
+	const u8 *data = nla_data(attr);
+	unsigned int len = nla_len(attr);
+
+	if (!ieee80211_uhr_oper_size_ok(data, len, false))
+		return -EINVAL;
+	return 0;
+}
+
 /* policy for the attributes */
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR];
 
@@ -947,6 +958,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_UHR_CAPABILITY] =
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_uhr_capa, 255),
 	[NL80211_ATTR_DISABLE_UHR] = { .type = NLA_FLAG },
+	[NL80211_ATTR_UHR_OPERATION] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_uhr_operation),
 };
 
 /* policy for the key attributes */
@@ -6499,16 +6512,6 @@ static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 			return -EINVAL;
 	}
 
-	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_UHR_OPER, ies, ies_len);
-	if (cap) {
-		if (!cap->datalen)
-			return -EINVAL;
-		params->uhr_oper = (void *)(cap->data + 1);
-		if (!ieee80211_uhr_oper_size_ok((const u8 *)params->uhr_oper,
-						cap->datalen - 1, true))
-			return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -6950,6 +6953,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out;
 
+	if (info->attrs[NL80211_ATTR_UHR_OPERATION])
+		params->uhr_oper = nla_data(info->attrs[NL80211_ATTR_UHR_OPERATION]);
+
 	err = nl80211_validate_ap_phy_operation(params);
 	if (err)
 		goto out;
-- 
2.53.0


