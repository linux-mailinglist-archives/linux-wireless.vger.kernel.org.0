Return-Path: <linux-wireless+bounces-38710-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MSKWCloCTGp7egEAu9opvQ
	(envelope-from <linux-wireless+bounces-38710-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 21:30:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF1E714F77
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 21:30:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=luNptuHE;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38710-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38710-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AF85302CB44
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 19:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2C63ACA7C;
	Mon,  6 Jul 2026 19:29:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88E3806DD
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 19:29:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366196; cv=none; b=uycCQLaHf1wetlRPcO+onhSIHz8nJ94+f5LCrn4ZwhS5SN7/e6pTGrxVjO7vgWaMjYfVCQv3jtEgwZRKytbwk0t1WeR71Bu42blq8EQx2cK0P/umqw8T/S2kyROER96p7dqjbEL65l4pS3fMBDNWeLnblzYExmQWt2qz824vC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366196; c=relaxed/simple;
	bh=wdCtxiEwbhx7D7CDXHsMVTWea/Hncm4dtokCGw87IOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X3G6fFKpVrAaUsPpcEyVzN4dujnNwhLiJK4I1mCtVbC8YaPTO2TsVfOPK8u0gJ8QQlZBEZSmJWASqAfCfdAtN6yV+bSV9mpA/4Uw2sCLW1QJeh76RCcW14H+Am7LrvR2k6xgLsNo65oo4HYN7FwQPw5CWxAWm1E/qIlDY/ys5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luNptuHE; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783366194; x=1814902194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wdCtxiEwbhx7D7CDXHsMVTWea/Hncm4dtokCGw87IOU=;
  b=luNptuHECPalSAENmwKuNiToH/4ANWl8bP0QeDTKfjzLCsojMe76qorC
   KvgQGoF6zYorqfqgzMY+XSzsyDtF8XFQrw8kUgfW44G28B68ZCZMfzoZC
   XuPRsxdqy0v3/lGhNxJP52VL3XelPmUII8ZpE9UX44F52wH8o4uA1W6XW
   39tp51ob+WlZWBgRMxfgxe2nM3Eb7QJkMFpOHHPQR4H7esl0V/puscs9q
   WKX1TKbbwktMvS2fhv43pQLSMtMLweM4/BMmZkTjK6KkReoQBJIiW2uo3
   WGk5YZNvFXhxIQFX2DFKHL06IUWYNr1H9F1wnztA4O+UE3Kc4GYuD92MD
   w==;
X-CSE-ConnectionGUID: U3WKQL1uQ4eqbV+PtCMgsA==
X-CSE-MsgGUID: q3R3SA25SL+3BBr0Wfp9sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84130051"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="84130051"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 12:29:53 -0700
X-CSE-ConnectionGUID: MwrxuunuTIWPeIWdo+p6xw==
X-CSE-MsgGUID: YMM7fx3VT3+9PjRBpZykUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="278152611"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 12:29:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: Route (Re)association req/response to per-STA queue
Date: Mon,  6 Jul 2026 22:29:31 +0300
Message-Id: <20260706222925.febcc62f485c.Iff932880e4b98232cbf6ba405fbb90d650a85381@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38710-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ilan.peer@intel.com,m:johannes.berg@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,changeid:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FF1E714F77

From: Ilan Peer <ilan.peer@intel.com>

An association request or response frame is generally delivered to the
driver without a TX queue object. However, with drivers that do encryption
offload and couple the key with a transmit queue, this means that the
frames are not being encrypted.

Fix this by routing the association frames to the management TXQ.
This will allow the driver to set up the required resources before
transmitting the association frame, e.g., set up keys etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h  | 11 +++++++++++
 net/mac80211/ieee80211_i.h |  4 +---
 net/mac80211/tx.c          |  7 +++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 084ad45aa2d8..26e674038865 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -556,6 +556,17 @@ static inline bool ieee80211_is_reassoc_resp(__le16 fc)
 	       cpu_to_le16(IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_REASSOC_RESP);
 }
 
+/**
+ * ieee80211_is_assoc - check if (Re)association request/response frame
+ * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is an (re)association request or response
+ */
+static inline bool ieee80211_is_assoc(__le16 fc)
+{
+	return ieee80211_is_assoc_req(fc) || ieee80211_is_reassoc_req(fc) ||
+	       ieee80211_is_assoc_resp(fc) || ieee80211_is_reassoc_resp(fc);
+}
+
 /**
  * ieee80211_is_probe_req - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_PROBE_REQ
  * @fc: frame control bytes in little-endian byteorder
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 34a9ea8b6f85..d585820245dd 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2470,9 +2470,7 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 static inline bool ieee80211_require_encrypted_assoc(__le16 fc,
 						     struct sta_info *sta)
 {
-	return (sta && sta->sta.epp_peer &&
-		(ieee80211_is_assoc_req(fc) || ieee80211_is_reassoc_req(fc) ||
-		 ieee80211_is_assoc_resp(fc) || ieee80211_is_reassoc_resp(fc)));
+	return sta && sta->sta.epp_peer && ieee80211_is_assoc(fc);
 }
 
 /* sta_out needs to be checked for ERR_PTR() before using */
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index c13b209fad47..42cfd76850b8 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1309,10 +1309,17 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 	    (info->control.flags & IEEE80211_TX_CTRL_PS_RESPONSE))
 		return NULL;
 
+	/*
+	 * While (re)association request/response frames are not considered
+	 * bufferable MMPDUs, use the TXQ abstraction for the transmission of
+	 * these frames. This is specifically useful for drivers that might
+	 * associate other resources with the TXQ, e.g., encryption keys etc.
+	 */
 	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
 	    unlikely(!ieee80211_is_data_present(hdr->frame_control))) {
 		if ((!ieee80211_is_mgmt(hdr->frame_control) ||
 		     ieee80211_is_bufferable_mmpdu(skb) ||
+		     ieee80211_is_assoc(hdr->frame_control) ||
 		     vif->type == NL80211_IFTYPE_STATION ||
 		     vif->type == NL80211_IFTYPE_NAN ||
 		     vif->type == NL80211_IFTYPE_NAN_DATA) &&
-- 
2.34.1


