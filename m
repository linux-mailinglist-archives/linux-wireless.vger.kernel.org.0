Return-Path: <linux-wireless+bounces-35479-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGgGE26H8GnuUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35479-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:09:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3CF482456
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6648C3288847
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41C7390222;
	Tue, 28 Apr 2026 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="M66l9P5Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815839BFEE
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368447; cv=none; b=YpKeOc+F/SK28M0Jxj8DowNo9vju1mlIfJVroisg0cOlcf+2NwWXg8H72J76329VaJ+v4lYcNyW0QDcnpWzOuP68u4L7jvtvqfRWHoO4QywnKocKa33USfHdHOwqI79/2/Gcb7+0t1quLTB8g+PDSIH55z0X6rVKqQgIjdI4LnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368447; c=relaxed/simple;
	bh=FzpdefMChzKrxAyys0rudWSRMVkpcIaKdmJYVulS3Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1hKRyqQmlAEi07SUe5KAkF5rcV/vqC9y2d2MErdF8z7tyVQ+L24iEGt/hjoEOaX4kwKF9M52YeOY/VgPcUTCb82ntjVFltS6AXyPd6iyWhX8Slr+i1lDeTgp6r0Gr0tbq0Tg0xLCkQLk/JukJmQSrMHQWaLlz1A7mxsh2KoPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=M66l9P5Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pnmzRitckKIAMEntcgv0lFhtwJ+e6bEVKyivXPq3DT4=;
	t=1777368446; x=1778578046; b=M66l9P5QK3EnUHxU9guo0LGtpR4KTa5MNkmOV8XEcsRPldF
	HW1eoyWVmsPyS83c5o8QL/B9doLV2ou47RDlh9JJiDhniFUWWs/DKbZYpX9sjjfjPgEzJ7F+Ner4M
	RWy7PxsxA9OMfm0RDNtQg0/mppQNWq41qcPvhM9byg7fxRNfDlz1PNTwgAo+Jt3AGRnXZsU7d0z5f
	tVysaL+5PLRBvDqGdwta02JkgeyHKAFvNFw9fWGqVr7SKGXHND+E4YuTChrHip4e4ihDoDwNZPJSd
	UGPWO6e71meP6SDDnJ+KZJ3l5u9c97DP4v7OsdmwP5lLJeQU397W3D6SYxjVRQmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeix-0000000HLwg-2orK;
	Tue, 28 Apr 2026 11:27:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 14/14] wifi: mac80211: check AP using NPCA has NPCA capability
Date: Tue, 28 Apr 2026 11:25:42 +0200
Message-ID: <20260428112708.5c354a838ba5.I8e957767cdbc1b224a22dde0a9c343c3a5851783@changeid>
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
X-Rspamd-Queue-Id: DC3CF482456
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-35479-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]

From: Johannes Berg <johannes.berg@intel.com>

If an AP advertises NPCA, it should also advertise NPCA
capability. Validate this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e23575745c38..f84bf50cb353 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -397,8 +397,19 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 		const struct ieee80211_sta_uhr_cap *uhr_cap;
 		const struct ieee80211_uhr_npca_info *npca;
 
+		/* frames other than beacons carry UHR capability too */
+		if (!elems->uhr_cap)
+			return IEEE80211_CONN_MODE_EHT;
+
 		npca = ieee80211_uhr_npca_info(uhr_oper);
 
+		if (npca && !(elems->uhr_cap->mac.mac_cap[0] &
+				IEEE80211_UHR_MAC_CAP0_NPCA_SUPP)) {
+			sdata_info(sdata,
+				   "AP without UHR NPCA capability uses it, disabling UHR\n");
+			return IEEE80211_CONN_MODE_EHT;
+		}
+
 		/* DBE is not considered yet, so this works */
 		if (!cfg80211_chandef_npca_valid(sdata->local->hw.wiphy,
 						 &npca_chandef, npca) ||
-- 
2.53.0


