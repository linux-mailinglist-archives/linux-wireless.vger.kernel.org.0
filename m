Return-Path: <linux-wireless+bounces-37118-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNI+CY9OGWr2uggAu9opvQ
	(envelope-from <linux-wireless+bounces-37118-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:30:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7D55FF2F3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD8F6319550C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA93AA1A9;
	Fri, 29 May 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TS4YjgBv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377933A0E8B
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043221; cv=none; b=DPtEba9JsmbuknaTy1fwVSoG1y6T1zWhwivzQl9Ip6I+pBWYcqww//HgMRg4yzgNuj+ry1W6qfrJlKEnA4N9GTTniKET/arnIHKhQsfi6fbYOFe+aUi14mE2P8ymUI3hetzjvmcx0plNTH8QIHg94CF2tfVUTzYcY9HeZvQIZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043221; c=relaxed/simple;
	bh=z8zekIrVRvrE2XRygUW3jTyYmix31u8upC4wkT3eEUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZGw74BgP4lSbMLxJIsZ0uCVPnyIImp1LjZji5Md+aLB72cXYhNBO3eIcx+mll0oygrtwtW8D2v5X5Ze9tyFGiJQKqKc9N3b0g0mqCPqsdpHpfsSqSyIxd2uj3ljGq2+iRRjDmfDti+wi8tPnd3qWSd4RGwAuomwq9iWZHi8Rds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TS4YjgBv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9tduRuL9ZDCdKFgAarIEqcY/lTRZpJKCv/nDOB6FH5E=;
	t=1780043220; x=1781252820; b=TS4YjgBveCZYLyhBU4nODDm0PsKE1Rysk2CqBplp8c3FBUW
	0R87NPJOieJo+/FqrWo7KiblaWFl2JGiLSrqKpMQF0z9P6XZ2/P3iiX+ZAyCLVuVoRN0zssV37Pk8
	Bs6yjBRuZKvVeMpRcr0SSFwbiNKxGdMR+Iqy/QH2iDoY1BFpv7fYNnxyxU27JoGg4T0poAym1Nf8l
	MenHMq/myCmUDmuVlzup9K8UDqpl20lWndTmDYj25WWAaOPOxsu+8HUvSOMvGOtrkh07PWQCtQTR7
	3U4yUkNDGsT2YVryJzhZhjOaPIobfekPc8osYslBcaBMmztazomH+sKkEsrmqocQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYT-00000009bVp-2lj4;
	Fri, 29 May 2026 10:26:58 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 12/16] wifi: Update UHR MAC capabilities to D1.4
Date: Fri, 29 May 2026 10:25:05 +0200
Message-ID: <20260529102644.6e27c54cfceb.Id395c07ffde286011494fc75190dc6060117436e@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529082644.106145-18-johannes@sipsolutions.net>
References: <20260529082644.106145-18-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-37118-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 8F7D55FF2F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

There are now 8 more reserved bits in D1.4, update the code
accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-uhr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index 120993897490..0c1715280fe7 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -398,7 +398,7 @@ enum ieee80211_uhr_dbe_max_supported_bw {
 };
 
 struct ieee80211_uhr_cap_mac {
-	u8 mac_cap[5];
+	u8 mac_cap[6];
 } __packed;
 
 #define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80	0x00000001
-- 
2.53.0


