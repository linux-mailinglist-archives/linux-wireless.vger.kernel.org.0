Return-Path: <linux-wireless+bounces-33018-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I41Jen1sWkeHgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33018-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF226B296
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E72A4301615A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C03A1698;
	Wed, 11 Mar 2026 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="AsdmaA72"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C33A16B4
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270470; cv=none; b=jU7DhyxylUOUBMN03IM2ZvY7ZeLyMAx6Y7Hgv/NYE50pbfeYZTEka+uFujV7TQLcOZxzwg9GS/oQeAFv5ktaKGtq0va6JlrFbaHHSbmquYLxWv0F6H0zjLUy1gzWV1SIA90S7OeidRsZ+39rKalbmnCywM9FFsY53OtlcBzydII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270470; c=relaxed/simple;
	bh=K+GwCuxKtjcSmwOUXvnQjepT2zhFcF8qL6zmH4yzcAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/frJum4sB6abZHlubii4F2LgEfsmuoKph9Ccom4LAmZMmrpc+NkyrBOzed9QgNXP9fcQmlZtFG2cenxWo1CnqP/4PqgDlQ1zj3bab+wxfvwL8aOLTH9pn9AOLjFyh2i9qtt1kxJaeoBsF/7wp6muLea2CfF3UEqp+xFGYjV3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=AsdmaA72; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A40379C005A
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:41 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id E3E7513C2BD;
	Wed, 11 Mar 2026 16:07:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E3E7513C2BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270459;
	bh=K+GwCuxKtjcSmwOUXvnQjepT2zhFcF8qL6zmH4yzcAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsdmaA72iwn1SCVYMrQBwPEHddnEPvo1/NJb7NgbFqgMeF6SXW7CBY5rNs1uFMx/x
	 or8XTTHfdjrPMWS8lATg2uFK6YwvMTRPEi1I3HBGQlKELFkmHY2jR98zJmPJyi31Rn
	 fKgyry3INNUrfvh1UiN8S9AOwe53M5znCNMk9iOs=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 12/28] wifi: iwlwifi: mld:  Improve logging in error cases.
Date: Wed, 11 Mar 2026 16:07:14 -0700
Message-ID: <20260311230730.163348-13-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260311230730.163348-1-greearb@candelatech.com>
References: <20260311230730.163348-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773270462-6TilpiCWpr_r
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773270462;6TilpiCWpr_r;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33018-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEEF226B296
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

To give better understanding of how and when failures
happen.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/sta.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index c478cee570a2..6338ca46f68e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -574,7 +574,8 @@ static int iwl_mld_rm_sta_from_fw(struct iwl_mld *mld, u8 fw_sta_id)
 				   WIDE_ID(MAC_CONF_GROUP, STA_REMOVE_CMD),
 				   &cmd);
 	if (ret)
-		IWL_ERR(mld, "Failed to remove station. Id=%d\n", fw_sta_id);
+		IWL_ERR(mld, "Failed to remove station. Id=%d ret: %d\n",
+			fw_sta_id, ret);
 
 	return ret;
 }
@@ -735,8 +736,10 @@ int iwl_mld_add_sta(struct iwl_mld *mld, struct ieee80211_sta *sta,
 	int ret;
 
 	ret = iwl_mld_init_sta(mld, sta, vif, type);
-	if (ret)
+	if (ret) {
+		IWL_ERR(mld, "iwl-mld-add-sta, mld-init-sta failed. ret=%d\n", ret);
 		return ret;
+	}
 
 	/* We could have add only the deflink link_sta, but it will not work
 	 * in the restart case if the single link that is active during
@@ -744,8 +747,10 @@ int iwl_mld_add_sta(struct iwl_mld *mld, struct ieee80211_sta *sta,
 	 */
 	for_each_sta_active_link(mld_sta->vif, sta, link_sta, link_id) {
 		ret = iwl_mld_add_link_sta(mld, link_sta);
-		if (ret)
+		if (ret) {
+			IWL_ERR(mld, "iwl-mld-add-sta, mld-add-link-sta failed. ret=%d\n", ret);
 			goto destroy_sta;
+		}
 	}
 
 	return 0;
-- 
2.42.0


