Return-Path: <linux-wireless+bounces-36026-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN7nGOVA+2lPYgMAu9opvQ
	(envelope-from <linux-wireless+bounces-36026-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:23:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7B14DAE82
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD5A13012EB9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C622472793;
	Wed,  6 May 2026 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="sjdl1iNs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF274477983
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073587; cv=none; b=hYqV7vmUyjHDyox1m+V3kCjQEwe/xbfP0l+pjM187MUgq49OTvkpaoqjpPshhVmqzdtiILcKQmNsaCLE+3BZ50lIbqCmMrHMj5w12yzSaYkD8sRv1w3hgBGNquKLbYu44XUqjUmJ0RvzCa3vawbL2vv9O0RlBV4DOrWLTU9WgFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073587; c=relaxed/simple;
	bh=Wsisc+FADmbyXR2rRyKbGZhoiu8ClW6ORIlWYzqSLQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIdwf9oVia1ztNnjt2bZtlbFWSwsT5CfXLo9UfNLKzsXgi2uQDVzoK2DCA5iVpVK7mMEWITt3c2rBEiqvpQIlUSk99nbDNk0YSR3EJSX9P1ZXx1D7SeNOLVDCK9dv1LYgDjYNsMq0GXtNPfmpmXVB+shBU7z4vugra9vxs5t794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=sjdl1iNs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso449530b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 06:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1778073584; x=1778678384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgTPUfJicz/Z6Ptr8kdjQ93ct/lB/vlBjdqub7F0s6M=;
        b=sjdl1iNsQiBefaVhHZWMpIp+MRyv/F6QuHkxne8HmQ9iXJpV9AzMArhA2Wkz5ehYnu
         aQWqkI6BkvLMsP1IIZdqUuisTNcuxJSLwh5UPS1rlFBVFdjvBFisMvFk3bVgVpt4qOVe
         Bte93m3bwjPYd30x8t9vEGh4WAF7iB+pQKFoS5z9kC8/oVFCutM21U9Sze07U/JhJu53
         vrbq99i9Hg43SmVNcmcsRFgTbi8wlL1Hx61TiufEGTafX2BxRU52poToKSLx7gE0mHdq
         rV01yXyawW5rxsL2dos2g0d6LPx/pbkFfeZE0tmZi+Vux2McaZDKJKxt1mzckqT8sFPF
         yrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073584; x=1778678384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgTPUfJicz/Z6Ptr8kdjQ93ct/lB/vlBjdqub7F0s6M=;
        b=bnByKFCQImxzmIjooLuHzVUhBf/mAfxQl30vi1tplvlNBqSATclPkgtqANy7h5t9c6
         OVgr202v0vkf+k4d7i69QZCOh0Fto9ZDU+PXIkZEPVIFUrVzdaFCDaSZGg7BPN0MnUJE
         tJD/yiHD7mA8l3nV4daHUzcGVEwzMLhb9RZ57tq9FU0reiaSKuUgzsZS8XxxxhsM2ohM
         UfTW9X7yihNs1Jbx/YNqMb6c+cGfJLticMjepaiF96wlr8byz5OOOlyWzX2rADKHTBOU
         jOWtC4Qr2WlgbG/JiNWmHsYdTW/YjGTZulnrV9INrLpAqXZGrra6NcvMdPkbnOc8Klvq
         qCkA==
X-Gm-Message-State: AOJu0YxFCAJZ8q9rDDWgi4huVPEpSZJHH9VJWqKEFlm2lidN1DuEKpb7
	Dzf0sYF2S+PpCi0MBSAt/LbHMBXsVy3P7NloWM0GN28h9lw5ympj92uh2XTr8VRDPgU=
X-Gm-Gg: AeBDieuuSO7MLZs6nCBGJCKhRFHMBfBxOF4O5xiqP8JwKfLW10ZBZuffPWQuK6urgTu
	VSl1lsfc86q5ZIobe4oMSS7ZCWdz6kKaWYMlgFIuWZDp5KT+CC8rkEv7MNIG9XUXhfhXO1Wm3RK
	I2h8M/kVY5a12DnVW6/2lPxeGZdL5xLozzbpEK370LHpLAFlHMbWsjRvrzmEOic3/Lthm1Ix8qd
	Pd0FJmSYte67/UHuRsMlz3pqrqYZ79MSB+ILJLO7h906z6bmGXjrABxHGkLxbbkCDSq7uHcWPUf
	Y5JkwL6vfB6SpN/uEmt3RzN2C8nNpge0QS4XcDcDF0k3Ru+RgEqfJgV8nG3jdSuTlEv7AMQkm+3
	1QYTuvsM+PjAhapAkHNqceD42sfr2C/L2dTabD/XsbHur906/RaSSI8Z4eflEvmRkJlh+suHcwF
	aq4rYVzozcMyWJiuEzuPUgKstwkHFmYK8mqcsqh3Jp7GEWpH1KwqAl1XnrKerQULiBCLjfcARJ5
	V4r36Z4Q6xIafm0
X-Received: by 2002:a05:6a00:9298:b0:82f:7762:3eb2 with SMTP id d2e1a72fcca58-838fdcb4346mr6868336b3a.17.1778073583705;
        Wed, 06 May 2026 06:19:43 -0700 (PDT)
Received: from mma-H9MHD44.mymodem ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a52cesm5336035b3a.57.2026.05.06.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:19:43 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v2 1/2] wifi: mac80211: skip NSS and BW init for S1G sta
Date: Wed,  6 May 2026 23:19:24 +1000
Message-ID: <20260506131925.2088353-2-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506131925.2088353-1-lachlan.hodges@morsemicro.com>
References: <20260506131925.2088353-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA7B14DAE82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36026-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Currently there is no S1G STA bandwidth support throughout mac80211
as existing support is all based on 20MHz widths. With the recent
STA NSS/BW handling rework, S1G associations now hit the new WARN within
ieee80211_chan_width_to_rx_bw() as the chandef is not a 20MHz based
width. For now, skip initialisating link_sta->pub->bandwidth for
S1G chandefs to avoid the WARN though this should at some point be
properly implemented since there are vendors that offer differing
maximum bandwidths.

Additionally, currently all S1G hardware out there is 1SS so rather
then introducing new parsing code which wouldn't be used anyway, just
initialise the NSS related fields to 1 and skip initialising the STA
bandwidth for S1G chandefs within ieee80211_sta_init_nss_bw_capa().

Fixes: d879d4da4579 ("wifi: mac80211: clean up initial STA NSS/bandwidth handling")
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/sta_info.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aba2fabfe0db..0ea37016cd4f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3516,6 +3516,23 @@ static u8 ieee80211_sta_nss_capability(struct link_sta_info *link_sta)
 void ieee80211_sta_init_nss_bw_capa(struct link_sta_info *link_sta,
 				    struct cfg80211_chan_def *chandef)
 {
+	/*
+	 * TODO: The entirety of the STA Tx/Rx bandwidth handling
+	 * assumes 20MHz based widths, so for now don't initialise
+	 * pubsta->bandwidth for S1G bands. Since enum
+	 * ieee80211_sta_rx_bandwidth is ordered, we will probably
+	 * need to introduce ieee80211_s1g_sta_rx_bandwidth with
+	 * S1G widths and associated S1G specific code. Additionally,
+	 * existing S1G hardware is all 1SS, in the future if hardware
+	 * starts supporting >1SS this should be implemented in
+	 * ieee80211_sta_nss_capability().
+	 */
+	if (cfg80211_chandef_is_s1g(chandef)) {
+		link_sta->capa_nss = 1;
+		link_sta->pub->rx_nss = 1;
+		return;
+	}
+
 	link_sta->capa_nss = ieee80211_sta_nss_capability(link_sta);
 	link_sta->pub->rx_nss = link_sta->capa_nss;
 
-- 
2.43.0


