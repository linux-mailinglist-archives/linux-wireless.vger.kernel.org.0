Return-Path: <linux-wireless+bounces-34786-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6APPHOGI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34786-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:47:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB74046C9
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88ACC3088BB8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3D7336881;
	Wed, 15 Apr 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qOA07x+y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6231332EC1
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257130; cv=none; b=F+08WpOjM0VPcMbh6KPGrT/uwTR8/uNUM7E1zQW2QMsIRRmlNnWmIlHw1p7D2VA1FdjLG0reo7NieKwZmeWdNN6rDW3Ow4ZvXE72Je88zxp2fkI+qnAFhwJfspbmQ+dQfEoRkNvuWOmHj0ajWLgJ/zoiSmag7OO4K4N9s9Xym8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257130; c=relaxed/simple;
	bh=ufWts/mkENhkjIuqk1tZ03RBOIzpbfHLjj1LPtP3P0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE+tYF5b6NokfYXWsiFPtMJOyInBoqysMLixIQx3XaWY+HzNVT8DW16HuMzi/6Kys/OuocgOto0M/d5ev6q3SASZV0e1G7jcjGIty6GWkinQiacuV4cY9wPYuprYDC9mEBOdF9iwwQ2Y/EfxmcrYcbk9bkDBxXZg3XMM6I9VSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qOA07x+y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YQW/kpyGR0Osy0DzhPaVcpxJj8/ZUf1eztYRrmKmdus=;
	t=1776257128; x=1777466728; b=qOA07x+yMxsDosFQ2nINlrhq9V2zwt/KbuyZymfkPTSbkYV
	NpfsAeUR0DypKxY/QxLv94uN+G8IsUBpMgqkZu18w8+5DY6Jp0VOPw9D8MWKFaUYpRT2DDuwEv9YH
	IU8d8W5+VnKax8ZuLSsNORvp5M5hMfbFOy1iKfx5KCwzF0L5JPxZG2qyXxgtrmSQcREBI+745dSiG
	PMZ0jypvzVT+bxndiuhiJXYeknhiHCrASo1fyGn/417biWc2MN2K8TQCfFvcTvhm+K/OTal8OPIKK
	exLCTlPZHxlw+/pHDNBlpK1BHV136HDlffsfrNNUGARQE6KsSz00Cz1AkImlf4SQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcU-00000006OgW-3Xtj;
	Wed, 15 Apr 2026 14:45:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 14/20] wifi: nl80211: reject beacons with bad HE operation
Date: Wed, 15 Apr 2026 14:42:12 +0200
Message-ID: <20260415144514.6217f5974fb5.Iff7ff6bcb159584e756d0f825c65860cdd53c6ea@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415124514.284345-22-johannes@sipsolutions.net>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34786-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 05EB74046C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

The HE operation element not only needs to be longer than
the fixed part, but also have an appropriate size for the
variable part inside of it. Check this.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8958..7a1c9faef443 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6641,10 +6641,6 @@ static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 			params->ht_required = true;
 		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
 			params->vht_required = true;
-		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HE_PHY)
-			params->he_required = true;
-		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_SAE_H2E)
-			params->sae_h2e_required = true;
 	}
 }
 
@@ -6677,8 +6673,12 @@ static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 	if (cap && cap->datalen >= sizeof(*params->he_cap) + 1)
 		params->he_cap = (void *)(cap->data + 1);
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
-	if (cap && cap->datalen >= sizeof(*params->he_oper) + 1)
+	if (cap && cap->datalen >= sizeof(*params->he_oper) + 1) {
 		params->he_oper = (void *)(cap->data + 1);
+		/* takes extension ID into account */
+		if (cap->datalen < ieee80211_he_oper_size((void *)params->he_oper))
+			return -EINVAL;
+	}
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_CAPABILITY, ies, ies_len);
 	if (cap) {
 		if (!cap->datalen)
-- 
2.53.0


