Return-Path: <linux-wireless+bounces-34794-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKcmMnSK32l5VAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34794-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:54:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB964048C2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2596F3014C10
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858A7262FF8;
	Wed, 15 Apr 2026 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g5xoun2A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F020214812
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257634; cv=none; b=BsB57j9X0Ig29KZ0flQtoLLMgzSHNdrY8pDr1s4MnYhyalvsGRlsX5y/LT84vHLkuQmFdqh0Bk4VoCeksZRMt/4fq4IqIPEJDT8OPBEuRb3Eik4QxYKuWSixoX1VDzWCq3y97LhvR7c0JplENu8ZxoAN6gHyWlrN+w/jKCNhezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257634; c=relaxed/simple;
	bh=9A5x99FNJbborp2EX7DyIbuDc12b5f0y+w1moNE9I/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QW62lsfPRdJ0znY77hHYyvukPjRVlJ/kdqAQ2Pz+x++OE0lSUatJN2HZHNI/D8ZnExpkVP+Un7FqJ1HVDANjeX1WwLM6CLtW+LvpPDPcsBFyQwdnioD0odPYyPJwBQh6vMYb6YccoawT7gjJ+s4+8NgH0RBY4CYaWGcRjnOqIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g5xoun2A; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=972LhHv+u6iKH4IymIGXINMQP6A94A5MSTIhJ6jMnWI=; t=1776257633; x=1777467233; 
	b=g5xoun2AB2Q1tAatgZPpdD7JlsNiMuBs8YdRg5Txjh3aeE0CZh+zazA5LqA0o6jibqFWTrhN3wh
	qaLfmLuS8o7BF0sj32ldvyvY7w6gu3rk0/uMYCpyzq4SasUph+S/6bM1MJuTQFdCFZ1//2Jgfxf3r
	xEbpBi9YxsvfVpUyskqYbhO/Jw+oPKBQJvfJRCx5QjvCMULxbw4dPQTk+Xy38WBiqd7g5HQa9nF1E
	5SMHAeuObXQsosf4gdT4i9mJawK6DmE+ayH1X1X9DFtkdNEZY7zle5fHWiIks/5OOzDfMX7DmCkow
	tVDS+wRpt/uPdSHpijuhKdLmIUZPt7I8voaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzkc-00000006PF4-0KjR;
	Wed, 15 Apr 2026 14:53:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: nl80211: check link is beaconing for color change
Date: Wed, 15 Apr 2026 14:53:48 +0200
Message-ID: <20260415145348.beb59ea5fbf7.I128a956a3e610bb6a5c9cad941d7d5b59b735a5e@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34794-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 3AB964048C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When trying to do a color change, validate that the link is
beaconing first, to avoid calling the driver with an invalid
link.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8958..e2ba6dfb8c70 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18324,6 +18324,10 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 	params.count = nla_get_u8(info->attrs[NL80211_ATTR_COLOR_CHANGE_COUNT]);
 	params.color = nla_get_u8(info->attrs[NL80211_ATTR_COLOR_CHANGE_COLOR]);
 
+	params.link_id = nl80211_link_id(info->attrs);
+	if (!wdev->links[params.link_id].ap.beacon_interval)
+		return -EINVAL;
+
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_next,
 				   info->extack);
 	if (err)
@@ -18397,7 +18401,6 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
-	params.link_id = nl80211_link_id(info->attrs);
 	err = rdev_color_change(rdev, dev, &params);
 
 out:
-- 
2.53.0


