Return-Path: <linux-wireless+bounces-37334-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5C4yLQr1H2rptAAAu9opvQ
	(envelope-from <linux-wireless+bounces-37334-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 11:34:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC6636318
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 11:34:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=huVLm6vC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37334-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37334-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AFB230BAB2A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C396258CD0;
	Wed,  3 Jun 2026 09:18:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66901B4F1F
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 09:18:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478302; cv=none; b=Ps4Fm2+euf2iixAOdPdmHPT2M/inPrENDTcP/DrEmXIu23wi8MdzfZhXL353/r+zE9HY/ddjHqGa/S6jlczzB2BQNz8CADzCbrETsIEwSlOH1ALTEevor80z5z1aPYG81qRZ8Swwqa185vSlVuL+XBWF3tD0p1mpT0jsUcHRVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478302; c=relaxed/simple;
	bh=v+duPCsuZ0z3VcgHEhMreshgOODwaneT4cWvA1PQUgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+gSdxC/mAtTAoSaf/f/fAwhGh0oD704eMm6BQ5iKuntXYixwenBVbu9OyVqcKqKwHibZEgusCVoK0P0fsJSy1RdvkLCRth3IXW7CuWfuZj0FXFHBFZB/R2tJmLnXRu+NA4Qf+vfoLmOZUKM9t6xeP7QUAKQhu+aBxDb+0L2Cc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=huVLm6vC; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+0ajxlammkhYH1LjGjfLvLWcAK5AAZ+xbjPuUUi7BL0=; t=1780478300; x=1781687900; 
	b=huVLm6vCfJYdlCA909wiI2776DriBurvDPI3pRiQJEK53Oq4LqCZ0TQ8bWUxPmSXmjXvgPfYEda
	GQD1u2CofSh79MxCMNS5nKiUpPaFddgf4GwfuKFLkJy7gei8F4eL9g+AXHIPWbKYHGf30waI5VKef
	ARnUUvnWYXuTX90uWXELeSMcivXIDGs+AqLF9U0JWYba7Sh4JVpW4DbZ6nqTttUYfya68hQOkCmMJ
	CemPMjm6ow75d3JOFjqe0jdom+MVYdXV70FdcYqc5MWtDiFaaRzWIE/jmQDJEWJo63TJKm5FeJVKO
	YlheCtBCwpKyplB/cTTvmux7lXjd2SLeskkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUhjt-0000000H12K-2vNv;
	Wed, 03 Jun 2026 11:18:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] wifi: cfg80211: enforce HE/EHT cap/oper consistency
Date: Wed,  3 Jun 2026 11:18:11 +0200
Message-ID: <20260603091812.101894-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37334-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes.berg@intel.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8CC6636318

From: Johannes Berg <johannes.berg@intel.com>

Xiang Mei reports that mac80211 could crash if eht_cap is set
but eht_oper isn't. Rather than fixing that for the individual
user(s), enforce that both HE/EHT have consistent elements.

Reported-by: Xiang Mei <xmei5@asu.edu>
Fixes: 22c64f37e1d4 ("wifi: mac80211: Update MCS15 support in link_conf")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index dac2e8643c49..76c537a6e8b5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6714,6 +6714,12 @@ static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 			return -EINVAL;
 	}
 
+	if (!!params->he_cap != !!params->he_oper)
+		return -EINVAL;
+
+	if (!!params->eht_cap != !!params->eht_oper)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.53.0


