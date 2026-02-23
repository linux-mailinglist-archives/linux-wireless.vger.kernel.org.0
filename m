Return-Path: <linux-wireless+bounces-32111-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALAYBdxLnGnYDQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32111-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:45:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C81765F8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A6CD305DD75
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB236606C;
	Mon, 23 Feb 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NEc39a65"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E1B365A1B
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850452; cv=none; b=QJlCigEU9ANMRDzoknG51ILUI8xjhSOXuEhQrylLEdYoXlkAi+m66TC90+GDkP5ICeCImYk/zDdc0EaXFpLDqPSJX6U6Ifsf6gOX6YACmQQHAygpRqSP9aeCZuR37CUavLkg3jznS7miuHeOyzsahBDiWaaXMi78tw6lPTKvjkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850452; c=relaxed/simple;
	bh=Ui5zNpPuAX/YJqgAWrJRhivZKtMnZ+sZ40eude63OIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEd1kyNYKz/pUDLzZkeUHDiy7D6FuPgE3k/+Lr912lwLUZuUY9zDGXs//mCNAXtPkdR+VFEFbVqdwWRXGERe15psGHIQHv0VSEpd+tR3/kH2GlJt4z8u6pJ8dzY3fUVnDDwNEGdf2LHgOFbhVp5bNnK8bMdlmTWLZjB5mLrxrDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NEc39a65; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=f/sLHk4JJaweKzJT3vj8OESvOaTs3G7NZwA5DJeWQiM=;
	t=1771850451; x=1773060051; b=NEc39a65aH+G8rJ3lxidm0B1UpyQez8xOGqXY5gyrJpy7hx
	ffhl7SjUuUKLMkLdB8d/cyNSx7sQLiLa/OTlkON8r5VmoPMni/pyRU98v0J54NuF1iVHGezGztWe9
	atWdTjdXnuYL91NJcUu8+eRxfhWOOQFljeVlKZDQk4eoKeFne1eYr4BLh0zQ8/+4CsFGhkD53xeSK
	QtDtExYnpyqKDlqKjW9EO2+9rMBCLEJ66r0xdkfxIHDbNP+3EpkQJK1Myf/532pEmdUMPCBvRvQW/
	eI2E6Omn6i3xMMYwTW6DJ48epFrAqbta/Izma1kKHqXpqyG7LyUff5IgFWyJE88A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vuVF2-0000000H2xI-1ZrD;
	Mon, 23 Feb 2026 13:40:48 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH v2 5/8] wifi: cfg80211: add attribute for TX/RX denoting there is no station
Date: Mon, 23 Feb 2026 13:38:24 +0100
Message-ID: <20260223133818.a27e1f07231e.I4cfd3db83ba3dc0267575f919ba613ea5d10abd5@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223123818.384184-10-benjamin@sipsolutions.net>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32111-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: B07C81765F8
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

For MLD stations, userspace may need to explicitly transmit a frame to
a specific link address. In that case, it needs to ensure that no
address translation happens.

In the reverse case of an RX, userspace may need to know the link
address for a frame. By passing the information whether a STA is known
for the frame, userspace knows whether link translation happened and
can do the reverse lookup when needed.

This is important for flows where a STA is still registered but the
connection has been lost and it is returning again.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/net/cfg80211.h       | 4 ++++
 include/uapi/linux/nl80211.h | 7 +++++++
 net/wireless/nl80211.c       | 8 +++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc01de19c798..5063911cba56 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3919,6 +3919,7 @@ struct cfg80211_update_ft_ies_params {
  * @link_id: for MLO, the link ID to transmit on, -1 if not given; note
  *	that the link ID isn't validated (much), it's in range but the
  *	link might not exist (or be used by the receiver STA)
+ * @no_sta: set if the frame should not be transmitted using an existing STA
  */
 struct cfg80211_mgmt_tx_params {
 	struct ieee80211_channel *chan;
@@ -3931,6 +3932,7 @@ struct cfg80211_mgmt_tx_params {
 	int n_csa_offsets;
 	const u16 *csa_offsets;
 	int link_id;
+	bool no_sta;
 };
 
 /**
@@ -9025,6 +9027,7 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
  * @flags: flags, as defined in &enum nl80211_rxmgmt_flags
  * @rx_tstamp: Hardware timestamp of frame RX in nanoseconds
  * @ack_tstamp: Hardware timestamp of ack TX in nanoseconds
+ * @no_sta: set if no station is known for the frame (relevant for MLD)
  */
 struct cfg80211_rx_info {
 	int freq;
@@ -9036,6 +9039,7 @@ struct cfg80211_rx_info {
 	u32 flags;
 	u64 rx_tstamp;
 	u64 ack_tstamp;
+	bool no_sta;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b63f71850906..1466c043974c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2984,6 +2984,11 @@ enum nl80211_commands {
  *	this feature during association. This is a flag attribute.
  *	Currently only supported in mac80211 drivers.
  *
+ * @NL80211_ATTR_FRAME_CMD_NO_STA: Valid for NL80211_CMD_FRAME to denote that
+ *	the kernel had no station for a received frame or should not use a
+ *	known station to transmit a frame. This is relevant to know whether
+ *	MLD address translation happened or to disable it when sending a frame.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3557,6 +3562,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_UHR_CAPABILITY,
 	NL80211_ATTR_DISABLE_UHR,
 
+	NL80211_ATTR_FRAME_CMD_NO_STA,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6e58b238a1f8..56a9c63ddd76 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -946,6 +946,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_UHR_CAPABILITY] =
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_uhr_capa, 255),
 	[NL80211_ATTR_DISABLE_UHR] = { .type = NLA_FLAG },
+	[NL80211_ATTR_FRAME_CMD_NO_STA] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -14020,6 +14021,9 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	    !(wdev->valid_links & BIT(params.link_id)))
 		return -EINVAL;
 
+	params.no_sta =
+		nla_get_flag(info->attrs[NL80211_ATTR_FRAME_CMD_NO_STA]);
+
 	params.buf = nla_data(info->attrs[NL80211_ATTR_FRAME]);
 	params.len = nla_len(info->attrs[NL80211_ATTR_FRAME]);
 
@@ -20581,7 +20585,9 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 	    (info->ack_tstamp && nla_put_u64_64bit(msg,
 						   NL80211_ATTR_TX_HW_TIMESTAMP,
 						   info->ack_tstamp,
-						   NL80211_ATTR_PAD)))
+						   NL80211_ATTR_PAD)) ||
+	    (info->no_sta &&
+	     nla_put_flag(msg, NL80211_ATTR_FRAME_CMD_NO_STA)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
-- 
2.53.0


