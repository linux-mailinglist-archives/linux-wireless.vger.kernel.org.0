Return-Path: <linux-wireless+bounces-38292-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lNb7FnVhQmqR5wkAu9opvQ
	(envelope-from <linux-wireless+bounces-38292-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 14:13:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D898A6D9E98
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 14:13:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=F202xuFC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38292-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38292-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E8FF3038D2A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 12:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBA83BED01;
	Mon, 29 Jun 2026 12:12:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08B35F199
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 12:12:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735153; cv=none; b=bnKKvUvcXYpxlezkzFS4yz65TTwICvG/LvMo8JqP9h+51/qvxZfPo0yhf5BzEZqN6vsfmu/gxtNqD+4F07TrqoCU7qw4u+UhZ8Dr+zAdplDHN5+dClG4wAtMomiobwGDLcALGPbBQlaXsjHOLXk/0ttLDP5WDfww/imHsbkiqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735153; c=relaxed/simple;
	bh=qbT/WnDtrKvR6uoPdjldzw1rVd1vde1CVsPWBfRyhwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNMyzH/vsxYhWqKC6Lau2Vd3GElASFCUTBJEHXU4Z6ISWmGu4aTqLqGv+j/X/l8QY85Gg8DkLKbOPyoQqTcqLMjH/MhkZKxfZiagWsGhqL2ll8LZ4Z89JR35IrqvLC74mTJS+Ao6qgpEPUXAv8NBwzxoy09ZTBZlcdXjceXjiBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F202xuFC; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782735149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0gccm7fL28uquWe9AkxPotcBiWgSGNEV8Iyv79F4Q0=;
	b=F202xuFCpGpCpgTschcqt8fh4VTqVLkBzvTxIus13GWyv+IqxWdsWHgJacvagoUwQanLsj
	QRwGnjcOWqmVImNphHvlsAU0abNyBwhWoe+j7GqMBaRt/OXyj8bpmQ/cww9naoQcPI1VYH
	kZMojM81Y2qY6DJ2E4rwKun2ro3R9BQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-rXzCSbzYNQelMA1OG2u9Pg-1; Mon,
 29 Jun 2026 08:12:26 -0400
X-MC-Unique: rXzCSbzYNQelMA1OG2u9Pg-1
X-Mimecast-MFC-AGG-ID: rXzCSbzYNQelMA1OG2u9Pg_1782735144
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2EE418009DF;
	Mon, 29 Jun 2026 12:12:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB5421956096;
	Mon, 29 Jun 2026 12:12:22 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com,
	emmanuel.grumbach@intel.com,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH 1/2] wifi: iwlwifi: enable MFP_CAPABLE in FIPS mode
Date: Mon, 29 Jun 2026 14:12:12 +0200
Message-ID: <20260629121213.597038-2-jtornosm@redhat.com>
In-Reply-To: <20260629121213.597038-1-jtornosm@redhat.com>
References: <20260629121213.597038-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
	TAGGED_FROM(0.00)[bounces-38292-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:emmanuel.grumbach@intel.com,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: D898A6D9E98

Re-enable MFP_CAPABLE flag in FIPS mode for iwlwifi to allow Management
Frame Protection (802.11w) to work with mac80211 software crypto.

Commit 0636800c8ee1 ("wifi: iwlwifi: disable certain features for
fips_enabled") disabled MFP_CAPABLE when fips_enabled=1.
I think the original concern about "some frames need to be handled in
firmware" applies to firmware-offloaded features like WoWLAN and beacon
protection, which remain correctly disabled by the commented commit.
For normal STA mode operation, management frames are processed in software.
And MFP can function in FIPS mode for normal STA operation when mac80211
software crypto handles IGTK encryption/decryption using FIPS-approved
AES-CMAC/GMAC algorithms.

Other major WiFi drivers (ath11k, rtlwifi, mt76, ...) set MFP_CAPABLE
unconditionally, suggesting this approach is viable for FIPS mode operation
with software crypto.

After re-enabling, testing on Intel WiFi 6E AX210 with fips=1 shows:
- IGTK ciphers (CMAC, GMAC-128, GMAC-256) are properly advertised
- WPA3-SAE connections with MFP required succeed
- iw station dump confirms "MFP: yes"

Firmware logs "Unhandled alg: 0x707" (SEC_ENC_ERR) during operation,
confirming that firmware does not have the keys and frames are being
handled by software crypto as expected.

Fixes: 0636800c8ee1 ("wifi: iwlwifi: disable certain features for fips_enabled")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1ec9807e4827..b0aea73c5784 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -462,8 +462,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		IWL_ERR(mvm,
 			"iwlmvm doesn't allow to disable BT Coex, check bt_coex_active module parameter\n");
 
-	if (!fips_enabled)
-		ieee80211_hw_set(hw, MFP_CAPABLE);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
 
 	mvm->ciphers[hw->wiphy->n_cipher_suites] = WLAN_CIPHER_SUITE_AES_CMAC;
 	hw->wiphy->n_cipher_suites++;
-- 
2.54.0


