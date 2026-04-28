Return-Path: <linux-wireless+bounces-35478-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOmiNaB/8GnFUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35478-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:36:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1109481903
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E3C7314EE29
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B233988E5;
	Tue, 28 Apr 2026 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bqSEUvy+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540F390CAB
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368446; cv=none; b=PnObnJpR+A6OB7S1icHkJQHq6BrXTmiSOf3zfVbMa252UJ7uPOB+vD1qIQyNeJp2Q1w7voU9Pp1OLe2dhswsrc1kjz3J0OCPUXOdyVmPmxyvI2+cT7vKn4OMysfrjECDLWQTrfwHJp+1Fg1IPer7Ms4rfwnWxEl/N4LNpRi3rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368446; c=relaxed/simple;
	bh=iYpXMiDlZQYNrms6toyy2752dsDuwlKf9KInH4XWE20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqqYBas8sTEURDUFN0ZY1GRvsnluLbiofDm94HsNXDRvtoxC++EfRDZauq5EY3uFcEgUq73uT5Ei/n6FvWFHxw4rcXREwo5FxBhMXz9qCVL16s8LlBnenP37aQkOfWyCF4vSS+/eyFDIf51KRwNo6Tcrr1gndl3LxrYwViH25VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bqSEUvy+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7eV5XsFoPsfonRpAU1N2dJ+S9NbxEnHpTf2noUMDrwU=;
	t=1777368445; x=1778578045; b=bqSEUvy+s8mTc/Qw3BGizDZsuhT/oox2bDjuz/fwLLvbltp
	bNwFgN2H7Fv2sNe+YKLZFaTNRjJ+MvXOBg6SAF+qHzeSvoevb0hQPiT5kp2M2FEFMs3hdtKMYz7g5
	Lc6pZFnO8N32uogZbp3xP9do8yAIpJRW4HeD8MzDbNIjEZvb7LdRpcAnZBY89LgD+8+5MftAjfDaD
	L41dS3pxdug5yuQd/AB2gLWRbktv2YxffmoVcJnB9qSDN0dbiueHqtdsLHjFwjXmCzxEg9TEIxxOY
	NEickFP4M4wX6woNzHmZJyxFo0JQU9WMBTGOkRFs5GoMqTOQb42phmumuR6zQzKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeiw-0000000HLwg-2Bzj;
	Tue, 28 Apr 2026 11:27:22 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 13/14] wifi: mac80211: don't parse full UHR operation from beacons
Date: Tue, 28 Apr 2026 11:25:41 +0200
Message-ID: <20260428112708.41a7aacdda0c.I0d83c8c9cbee41fd2599480cad815b94867aa1f8@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428092708.71740-16-johannes@sipsolutions.net>
References: <20260428092708.71740-16-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C1109481903
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35478-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]

From: Johannes Berg <johannes.berg@intel.com>

Currently, as noted in the comment, ieee80211_uhr_oper_size_ok()
will reject the element coming from the beacon, since it's too
short. However, this is incorrect in general, since the element
is extensible, and such extensions could be present in a beacon,
and then it might pass muster anyway.

Using the frame type we now have in the element parse result,
check that it's not coming from a beacon. The size was already
checked (according to frame type) during parsing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ccca5219b9e8..e23575745c38 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -392,14 +392,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	if (conn->mode < IEEE80211_CONN_MODE_UHR || !uhr_oper)
 		return IEEE80211_CONN_MODE_EHT;
 
-	/*
-	 * In beacons we don't have all the data - but we know the size was OK,
-	 * so if the size is valid as a non-beacon case, we have more data and
-	 * can validate the NPCA parameters.
-	 */
-	if (ieee80211_uhr_oper_size_ok((const void *)uhr_oper,
-				       elems->uhr_operation_len,
-				       false)) {
+	if (elems->frame_type != (IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_BEACON)) {
 		struct cfg80211_chan_def npca_chandef = *chandef;
 		const struct ieee80211_sta_uhr_cap *uhr_cap;
 		const struct ieee80211_uhr_npca_info *npca;
-- 
2.53.0


