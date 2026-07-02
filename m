Return-Path: <linux-wireless+bounces-38486-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nI0JFb4QRmqAIwsAu9opvQ
	(envelope-from <linux-wireless+bounces-38486-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 09:18:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A2D6F4171
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 09:18:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=eyBz2FSl;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38486-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38486-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A796F3002D3D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 07:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB613537FB;
	Thu,  2 Jul 2026 07:17:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158212E7623
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 07:17:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976625; cv=none; b=u/+wZWW0NL6F6hDf6UkBVCOfg1pO8edXasZvauUe/XvCE15opAQFxIkAfmB/3BkF9qLKQ0fFm92QPPd0SoF4p1IowIcJAFvLBrnjk6teHgBF0gwlXSCllohXVb8jbBAe+BQlQZith37Ea7YWZPxaXJRwEcWXHVRefjKNypOZPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976625; c=relaxed/simple;
	bh=HgQTgwJ4KTsAOiLtAlHxYuhEBLcm43SKnG3yER/uvSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jo9K4Na6iDuoweOEQ6rjmVfVwkyTyU7lkZ9s6/ZC80Kzh1uvI1oFjY9ZRp2ACOcMkfmjgqWX3iaNRbd0kP4pyI0LAwMInZnaW9ZasoF+vNjHJz7ZkfQ2GdoErn2cJy/N965mCmYX24t79fxWpKjyfURTM6k5mrnIeZ1tfevVuCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyBz2FSl; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782976623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0tRvugpzG8ln4LdA49b+XuWxI2Z8mAQ/pKg50n86/34=;
	b=eyBz2FSleuRLTaEmYq5D5oGOfS5FGOcTrY49h/lasHPmAqzXQVLNQPRR4rIUc1rJUig/Kw
	xWQuBh/kS/S7VOxol/KTWEYeXED+1uF+LWaXFsETnYdTsRTxbxVeXoCPN8R97X+dBUjXzd
	j+D0PxssKsbnSUSaUx1mdh1Su2jSp0c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-1tfRfNQKNwezE2p2y4ry_A-1; Thu,
 02 Jul 2026 03:16:59 -0400
X-MC-Unique: 1tfRfNQKNwezE2p2y4ry_A-1
X-Mimecast-MFC-AGG-ID: 1tfRfNQKNwezE2p2y4ry_A_1782976618
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 352FE18C0FF6;
	Thu,  2 Jul 2026 07:16:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 199FE3001449;
	Thu,  2 Jul 2026 07:16:55 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: nbd@nbd.name,
	lorenzo@kernel.org
Cc: ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	linux-wireless@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH] wifi: mt76: mt7996: remove beacon_int_min_gcd from ADHOC interface combinations
Date: Thu,  2 Jul 2026 09:16:47 +0200
Message-ID: <20260702071647.667539-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38486-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:linux-wireless@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50A2D6F4171

The driver fails to register with error -22 (EINVAL) due to a cfg80211
validation failure in wiphy_verify_iface_combinations().

Commit 5ef0e8e2653b ("wifi: mt76: mt7996: fix iface combination for
different chipsets") added beacon_int_min_gcd to if_comb_global and
if_comb_global_7992, but these combinations include ADHOC (IBSS)
interface type. This violates a cfg80211 rule from commit 56271da29c52
("cfg80211: simplify netlink socket owner interface deletion") that
explicitly forbids combining ADHOC with beacon_int_min_gcd.

The restriction exists because beacon_int_min_gcd requires static,
predictable beacon intervals to coordinate multiple beaconing interfaces,
but ADHOC interfaces have dynamic beacon intervals that change when
joining different networks, making the GCD constraint unenforceable.

Remove beacon_int_min_gcd from the interface combinations that include
ADHOC because they are not necessary for ADHOC operation. The if_comb
combination (AP/MESH/STA only, without ADHOC) correctly retains
beacon_int_min_gcd for multi-AP coordination.

Fixes: 5ef0e8e2653b ("wifi: mt76: mt7996: fix iface combination for different chipsets")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index d6f9aa1ab52d..06f764a54405 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -34,7 +34,6 @@ static const struct ieee80211_iface_combination if_comb_global = {
 			       BIT(NL80211_CHAN_WIDTH_40) |
 			       BIT(NL80211_CHAN_WIDTH_80) |
 			       BIT(NL80211_CHAN_WIDTH_160),
-	.beacon_int_min_gcd = 100,
 };
 
 static const struct ieee80211_iface_combination if_comb_global_7992 = {
@@ -47,7 +46,6 @@ static const struct ieee80211_iface_combination if_comb_global_7992 = {
 			       BIT(NL80211_CHAN_WIDTH_40) |
 			       BIT(NL80211_CHAN_WIDTH_80) |
 			       BIT(NL80211_CHAN_WIDTH_160),
-	.beacon_int_min_gcd = 100,
 };
 
 static const struct ieee80211_iface_limit if_limits[] = {
-- 
2.54.0


