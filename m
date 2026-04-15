Return-Path: <linux-wireless+bounces-34789-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG2WI++I32kHVAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34789-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:47:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 056B64046D7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27ED9308DF8D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35BC2EC09B;
	Wed, 15 Apr 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cNzTE7Ki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA6330B0E
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257135; cv=none; b=GTORCu1+YjCchucTpOOY4FUJqT9cplk8fnrk42taIR1ThD2/EhGlXifdilLh9bjVKpbEn6N+xV/5I66eugheCch9N1d7ro+A5r1/rY9w5caZJSHllYXMwgCAS+sHF4FzhMD+Lu3vur+gqGcIbhrwz5HqGI4uCqWp6ISPAYornww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257135; c=relaxed/simple;
	bh=NdfyBXNzjN7UyZtYl+EWEHMyk+il/OxgOgl+rPIR9e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ojuqpe8tcyTZIT9SdtCva0+mCQWv88d247MJtcT7ij9Ur3nWAhMMrnD3lpYdMfUVWUMy+FC9yQYAbbyGyQvB7jrM4y14mhxI7UZc3/Su1r1z5he7kZhNocxjgtwub/0EecdUPE6wbHoGQLDcMhTBMNkvyrIwCEzBbeOBZt+ok3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cNzTE7Ki; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZC8Zx4bknPSn4/5hvaa0M3wtdiqqExpqGyqqUAgC1YU=;
	t=1776257131; x=1777466731; b=cNzTE7Ki8pvJpv74ULrwgI9+2/ADXA8eZPQd53SbVo53Cgv
	dM70IHNIUbrfFEbw0lyUQmMSw6WNdajbS+mmVsdwLV0R+kHavGVtYMcz+3+sgNQIui45AtitqdmgT
	UM0cG213q5vZGAesnQEtamSEg2HtmYPpxeseODlehVGa8UUTOxGsbRVbsGZrOaeT902WjgQ3ZFQ7R
	r3MzNyLVoK1F/M5+v1tfWJVBRZ/c+vgQf2qWehoeaM+qCFrakNpv4vVTILcy1xT2uUr1TPbahjnTA
	IKcHh3ZbMRwzGuXA8S8lhjXVef90qcwPqEF8cq/hDhL9Pjwoo2a7FFdK6lCUORxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcW-00000006OgW-47Cm;
	Wed, 15 Apr 2026 14:45:29 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 17/20] wifi: cfg80211: provide HT/VHT operation for AP beacon
Date: Wed, 15 Apr 2026 14:42:15 +0200
Message-ID: <20260415144514.32ad98454543.Ia9692671b699164edcc0bdaf4fdbdbefc50b18f8@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34789-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 056B64046D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

In addition to providing HE/EHT/UHR operation, also check
and provide HT/VHT operation, so that drivers have it and
can use it, e.g. to correctly calculate station bandwidth.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  4 ++++
 net/wireless/nl80211.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7070e577342b..a40ab36b8edb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1398,6 +1398,8 @@ struct cfg80211_rnr_elems {
  *	attribute is present in beacon data or not.
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
+ * @ht_oper: HT operation element (or %NULL if HT isn't enabled)
+ * @vht_oper: VHT operation element (or %NULL if VHT isn't enabled)
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
  * @uhr_oper: UHR operation (or %NULL if UHR isn't enabled)
@@ -1427,6 +1429,8 @@ struct cfg80211_beacon_data {
 	bool he_bss_color_valid;
 
 	bool ht_required, vht_required;
+	const struct ieee80211_ht_operation *ht_oper;
+	const struct ieee80211_vht_operation *vht_oper;
 	const struct ieee80211_he_operation *he_oper;
 	const struct ieee80211_eht_operation *eht_oper;
 	const struct ieee80211_uhr_operation *uhr_oper;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 263d04a1366e..f65f3887ea62 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6730,6 +6730,24 @@ static int nl80211_calculate_ap_operation(struct genl_info *info,
 		}
 	}
 
+	op = cfg80211_find_elem(WLAN_EID_HT_OPERATION, ies, ies_len);
+	if (op) {
+		if (op->datalen < sizeof(*bcn->ht_oper)) {
+			GENL_SET_ERR_MSG(info, "bad HT operation in beacon");
+			return -EINVAL;
+		}
+		bcn->ht_oper = (void *)op->data;
+	}
+
+	op = cfg80211_find_elem(WLAN_EID_VHT_OPERATION, ies, ies_len);
+	if (op) {
+		if (op->datalen < sizeof(*bcn->vht_oper)) {
+			GENL_SET_ERR_MSG(info, "bad VHT operation in beacon");
+			return -EINVAL;
+		}
+		bcn->vht_oper = (void *)op->data;
+	}
+
 	op = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION, ies, ies_len);
 	if (op) {
 		if (!ieee80211_eht_oper_size_ok(op->data + 1,
-- 
2.53.0


