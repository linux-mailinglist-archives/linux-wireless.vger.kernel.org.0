Return-Path: <linux-wireless+bounces-38875-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mprlJz1eUmqXOwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38875-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 17:16:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30379741EEB
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 17:16:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=HpVqz+Ij;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38875-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38875-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C19D3006B72
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E29274670;
	Sat, 11 Jul 2026 15:16:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender-op-o14.zoho.eu (sender-op-o14.zoho.eu [136.143.169.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0413446C9;
	Sat, 11 Jul 2026 15:16:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782971; cv=pass; b=miCxP/PF8v6E1ob0azBK1y9t0QD/yv86F477sOiZ/0QNPIGsyWve0s+Pzuvb67xyXXFtkUrFFjt3Unzzbw+Ti4ooUR/YwUcq/DGFEpINHs8wtKbhsx/yROybhDGVBQVoocC20geLcqHeuvN9sHQT1MBowbftjsws/4Gmt8qQ+p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782971; c=relaxed/simple;
	bh=KuTg0uw4JYO9cO3bj0Ogcn+XrNWj2H4H3/QXdfqwpXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVuGdnD/Bxf/Pcqhs0QYS/gZDC5+RB37vGvji+W/A+1dutuVHQqjEMPpKB2Hsz5qCL00E1rN9eVK/Kbkjynb3qjdmQT3DAKtSgokHsexCLWBca2y8aw/Y1KUtpWqsXmfazjurBUdLZ3Ru/jZP7DtTwGj+f28Mlz0hd4L8OBDNLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=HpVqz+Ij; arc=pass smtp.client-ip=136.143.169.14
ARC-Seal: i=1; a=rsa-sha256; t=1783782957; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NAQHDBW+1izbeCJmQyi4v6iq9hg2Twu12PhHwAiRM/+kpe5MWwlXWHVal9Dn9ORkREHDdMF2P2JEC9pKORQ9tQAJysIk3tcO3NadIPIOyOvrmXPPC4UtveTVB95il5huiSTv85HlAHtTYwZe8WdcX/47LMqVVnlLAujJkdYH7Io=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783782957; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GE/TfTynBPIsykI1OT6CCoqS4/5/uJ4Sv7x1lPPqLAg=; 
	b=NfgQKGfgaL+QT8l75gMt19Crelr8nwQW8L6+xUqHtU4MBW4qL3pDMOo9rl1orL+lsX3BPHIo7SCCH+o2aCEWJSqrbC77tmXuYvFZWZEygZPJCRwNjJ47kv5HfKpLxm7mNCp5KXGj4viseqRLUiNlhousHmjS7KguD+OjnPz09m8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783782957;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GE/TfTynBPIsykI1OT6CCoqS4/5/uJ4Sv7x1lPPqLAg=;
	b=HpVqz+Ijq/O3kDq37PRTWkT3WfgvU1rGSzVSMhyIAtE4C04EDDlNJRozzt9teSOb
	uZsj+vBKrNguKVOI5+FBkeorKOPiAfPpjo6xAJfWBOteS91dP7JDI3HK4Pa8c62C91f
	3zSwAPnLjwWvxHktfASQUjJFGgeWHu+bUkccmhoE=
Received: by mx.zoho.eu with SMTPS id 1783782955198422.6624045875802;
	Sat, 11 Jul 2026 17:15:55 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] wifi: mac80211_hwsim: reject undersized HWSIM_ATTR_TX_INFO
Date: Sat, 11 Jul 2026 17:15:51 +0200
Message-ID: <20260711151551.65504-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38875-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[security@auditcode.ai,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@auditcode.ai,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30379741EEB

hwsim_tx_info_frame_received_nl() casts the HWSIM_ATTR_TX_INFO
attribute payload to a `struct hwsim_tx_rate *` and then
unconditionally walks IEEE80211_TX_MAX_RATES (4) entries of it:

	tx_attempts = (struct hwsim_tx_rate *)nla_data(
		       info->attrs[HWSIM_ATTR_TX_INFO]);
	...
	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
		txi->status.rates[i].idx = tx_attempts[i].idx;
		txi->status.rates[i].count = tx_attempts[i].count;
	}

struct hwsim_tx_rate is `{s8 idx; u8 count;} __packed`, i.e. 2 bytes,
so the loop reads a fixed 8 bytes out of the attribute regardless of
its actual length.

The attribute's policy entry only bounds the payload from above:

	[HWSIM_ATTR_TX_INFO] = { .type = NLA_BINARY,
				 .len = IEEE80211_TX_MAX_RATES *
					sizeof(struct hwsim_tx_rate)},

For NLA_BINARY, nla_policy.len is a maximum, not a minimum -
nla_validate() happily accepts a shorter attribute, including a
zero-length one. The HWSIM_CMD_TX_INFO_FRAME op also sets
GENL_DONT_VALIDATE_STRICT, so no implicit minimum-length enforcement
kicks in either. The handler itself never calls nla_len() on
HWSIM_ATTR_TX_INFO before dereferencing it.

The net effect: any process that has completed HWSIM_CMD_REGISTER as
the netgroup's wmediumd (CAP_NET_ADMIN at registration time, e.g. via
an unprivileged user+net namespace) can send a HWSIM_CMD_TX_INFO_FRAME
with a 0-length HWSIM_ATTR_TX_INFO and drive tx_attempts[0..3] to read
up to 8 bytes past the end of the attribute payload.

This driver already validates NLA_BINARY payload length before use in
two other handlers in this same file:

 - hwsim_cloned_frame_received_nl() bounds-checks HWSIM_ATTR_FRAME
   before touching it:

	frame_data_len = nla_len(info->attrs[HWSIM_ATTR_FRAME]);
	...
	if (frame_data_len < sizeof(struct ieee80211_hdr_3addr) ||
	    frame_data_len > IEEE80211_MAX_DATA_LEN)
		goto err;

 - hwsim_new_radio_nl() bounds-checks HWSIM_ATTR_CIPHER_SUPPORT before
   use, rejecting a length that doesn't cleanly divide into whole
   elements:

	u32 len = nla_len(info->attrs[HWSIM_ATTR_CIPHER_SUPPORT]);
	...
	if (len % sizeof(u32)) {
		NL_SET_ERR_MSG_ATTR(...);
		return -EINVAL;
	}

hwsim_tx_info_frame_received_nl() is missing the equivalent check for
HWSIM_ATTR_TX_INFO. Add a minimum-length check next to the existing
attrs-presence check at the top of the function (before any pending
skb is unlinked from data2->pending, to avoid holding/leaking that skb
on the new error path), requiring at least
IEEE80211_TX_MAX_RATES * sizeof(struct hwsim_tx_rate) bytes - matching
the exact quantity the loop below unconditionally reads. A too-short
attribute now takes the existing `goto out;` / -EINVAL path instead of
reading past the attribute payload.

On a v6.19 KASAN-enabled stand, the differential reproducer confirmed
the unpatched handler accepts a 0-length HWSIM_ATTR_TX_INFO and runs
the fixed-count read loop to completion (ack err = 0); KASAN did not
report anything here, since the resulting 8-byte over-read stays
inside the same skb's kmalloc/shinfo tailroom rather than crossing a
slab redzone. The check added above makes the same 0-length attribute
fail before that loop runs, taking the existing goto out / -EINVAL
path instead.

Fixes: 7882513bacb1 ("mac80211_hwsim driver support userspace frame tx/rx")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0dd8a6c85953..6ef7398ffaad 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -6340,6 +6340,17 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 	    !info->attrs[HWSIM_ATTR_TX_INFO])
 		goto out;
 
+	/*
+	 * HWSIM_ATTR_TX_INFO is NLA_BINARY with only a maximum length in
+	 * its policy entry, so nla_validate() accepts any shorter (incl.
+	 * zero-length) payload. The read loop below unconditionally walks
+	 * IEEE80211_TX_MAX_RATES entries, so reject undersized attributes
+	 * here before any data is touched.
+	 */
+	if (nla_len(info->attrs[HWSIM_ATTR_TX_INFO]) <
+	    IEEE80211_TX_MAX_RATES * sizeof(struct hwsim_tx_rate))
+		goto out;
+
 	src = (void *)nla_data(info->attrs[HWSIM_ATTR_ADDR_TRANSMITTER]);
 	hwsim_flags = nla_get_u32(info->attrs[HWSIM_ATTR_FLAGS]);
 	ret_skb_cookie = nla_get_u64(info->attrs[HWSIM_ATTR_COOKIE]);
-- 
2.50.1 (Apple Git-155)


