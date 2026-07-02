Return-Path: <linux-wireless+bounces-38503-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 38i7E1RIRmrbNgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38503-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 13:15:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6AE6F6870
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 13:15:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=X9TMoedf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38503-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38503-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CDA93173B2E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304162E736F;
	Thu,  2 Jul 2026 10:43:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9FE3939C2
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 10:43:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989031; cv=none; b=PPlmOgV9bYR8uaeWeF5KE42gL2q4WM4yEgCQxXHWIQwud30ORobYSEFMZkuXki7UXwPDRebuL1Ii0ZIQiwYEdajxEumwiJLroEgfsIJIpHHkXKSlPA2aV4rvtpZYNcQBP3EoCPnnqa8Uprx9XO+rYvFMQ2eR9GwcnAeOjw+W1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989031; c=relaxed/simple;
	bh=PvFE4BtNT1XeYSMqExBR6Lheoi9bs1olvm6rN/SPuEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiC1FxEkKbfoDoM73Y114z4nHCVuD2Bz9T5OY7iuu9xEsJqQtT2pCeM3/Z/1H0FsQtVd8oDzi9VxzNTzA/BX6sWC9QZnk66nyiGaw+L302OUUWhhqhD4ODTPyeNe5M+vVhP9C6CtdZMQYvzRQmuGPg7CAp8He+Jw35MNIaXDc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9TMoedf; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782989028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cX2tGi+5ORiax12obTPFoLZjfrqlCzVuVk6pP+gJ/5E=;
	b=X9TMoedfbc1sKG5oLaT5evXJRTbCaKgWC7IKMnLuQcDjTKg/FJMsQs7m7GNvh4GF0gVb+R
	WuF4arAMqxP1zzch7D2N0o7dD+dsnUzRdtzytTyXm6AGEJTt6+RhUbdaD0Q8vfClzzmREv
	uLxHlL5tHbpCYI/50LwnqtmB+HA9Q5U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-kVcuqldKP4qvly9haKIrlQ-1; Thu,
 02 Jul 2026 06:43:45 -0400
X-MC-Unique: kVcuqldKP4qvly9haKIrlQ-1
X-Mimecast-MFC-AGG-ID: kVcuqldKP4qvly9haKIrlQ_1782989024
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7B9B1944B1C;
	Thu,  2 Jul 2026 10:43:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58A88180056E;
	Thu,  2 Jul 2026 10:43:41 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: nbd@nbd.name,
	lorenzo@kernel.org
Cc: ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	linux-wireless@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v2] wifi: mt76: mt7996: remove beacon_int_min_gcd from ADHOC interface combinations
Date: Thu,  2 Jul 2026 12:43:37 +0200
Message-ID: <20260702104337.679536-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38503-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:linux-wireless@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF6AE6F6870

The driver fails to register with error -22 (EINVAL) due to a cfg80211
validation failure in wiphy_verify_iface_combinations().

Commit 5ef0e8e2653b ("wifi: mt76: mt7996: fix iface combination for
different chipsets") added beacon_int_min_gcd to if_comb_global and
if_comb_global_7992, but these combinations include ADHOC (IBSS)
interface type. This violates a cfg80211 rule from commit 56271da29c52
("cfg80211: disallow beacon_int_min_gcd with IBSS") that explicitly
forbids combining ADHOC with beacon_int_min_gcd.

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
v2: Fix commit 56271da29c52 title reference from "cfg80211: simplify
    netlink socket owner interface deletion" to "cfg80211: disallow
    beacon_int_min_gcd with IBSS"
v1: https://lore.kernel.org/all/20260702071647.667539-1-jtornosm@redhat.com/

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


