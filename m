Return-Path: <linux-wireless+bounces-36008-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLKtFa04+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36008-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 14:48:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C510C4DA7B4
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 14:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82864302D11A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABA8441030;
	Wed,  6 May 2026 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="CDo30N7J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD044D685
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071402; cv=none; b=iXhMGTBMvOu2e8STXImfqvWts9Yi7IPnDXE1xtzEV5A3hpMm+wRAqmuwJMwoJKKLO1mVfNdqTV8UoJodSZfylEMpad7cAtjXp6sjiugTob0v0/k7IfJDWiYcfjGI7qJcjn/dUkAssOP2VXxxF7Ej955tQfneERsMxTpCWuU1DW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071402; c=relaxed/simple;
	bh=Wsisc+FADmbyXR2rRyKbGZhoiu8ClW6ORIlWYzqSLQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dd4JBw8ZMjCG2l3NWxj1uBCcglOXQH/KS+SEH/7SR/6eZ8HK0BEBZMnpORIqcPdRHb3Gfq0uKqCwcNLsnjf9yIW/OvaCSYLdeh+ayRgY6TZqFX9uzfv67a6aNKQHMe7DGFmi0dLH4+EOYrDHy1IPwDWfgFUN24ZNi1nwokmviSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=CDo30N7J; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2adbfab4501so28003835ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1778071399; x=1778676199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgTPUfJicz/Z6Ptr8kdjQ93ct/lB/vlBjdqub7F0s6M=;
        b=CDo30N7JY2iIVA2E8+Zd3mz8iPAZv+9t+vhlrVibqEqqUVcOC0yucGhLa6EtHAfR/1
         WIgiEAtwZoqoJ1VQ9YMYHgf0UqYsHQ38rs37yNMmxpoQQc2h4yTeF/BcC7ZqrEz0mmhQ
         uxw0CLs6W1ysgTR8tsyyG8LPFb4zPyDLQQZmMgasugfXL51g/mkdXjUzzMh5ZSlh4YzD
         q1gT5zt/PiCX0FwSNuzD+NLQ6pCQDwDXaERQazwPEX6xKCNcTGlVGmxKJ66R7ggyGqTj
         znATpAGCdzzTKd+orUTnGJ7svCSdzpb/XZKMrhtswmGjnAsW5LrCLGZ9SwaKrKEjkxF9
         5cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071399; x=1778676199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgTPUfJicz/Z6Ptr8kdjQ93ct/lB/vlBjdqub7F0s6M=;
        b=VvBzX3DPvfpGAe98eQlk4re1+7Ge0r9uWNHj3ZqDeefps9cboGGmCxq0dkdk3mkElh
         vjXput0BTRkdPXuH04D/33crfNt+svxBYKPex0Nk/HrvN1Ix/xc82aLzrjjLdtaghfHX
         vcmZ7KyRBMtPdLdBSUt7W/MhkEWVFWz9h6498ijWqHyUmC2sjGtD0ej0t00rLKuOUuaZ
         NLUWlvA3q4EB0jkCMV2D9vuei5svv17c/0cy7Chxx+ErPr6b9RUTyCLvSyhZJqmgLYz8
         pdvcvrOUDb68zk9u8or7ngmA5Vy3aBON6ZXysJ5WusHQ7PU+iCVKTDFS/va/7hejDQdY
         VwRw==
X-Gm-Message-State: AOJu0YwJHGVfLwU+LBH0+nut4edEuXU+8MDKOaJoatiTZp1pPDm4ihtp
	NdFGkPorCxj7jIZNhCThQwhvvxh3N7Zk+eS6RRKCWPziyMPhrDkYWbK5xfVA/r0ebfs=
X-Gm-Gg: AeBDievNZVpTH9PIMEA72fvdIHiAyc/M9FnHpX+oXgQkqTw97MPbAO3Eu2O8slOPb4Z
	ZvX8DkMQB/k5o8cFwsQE6Z3MhEnoFIUF4rnnaua4S0NqgKhDQyvc2mpKeGhiz4vcHisTsYQfhRi
	cCFhOu79fsZEEDQDJMvjsV0Ogpu1nEwzNS/knBsepCpfE8Q1GXF4H8pC2Zfyo9m5UDmv3TSdSSI
	JqAX0FIpvhFUtCBPQTEubiiardNmdJWS8mUlON9/+tTDDxNlyKagLpGJhGDU1gVTJ7jpoU+DXp+
	Xo3Smf8gMDfP6FuRBAqDrocVkoGuHTqhKrgq7t0AB+8ewwf7tp5YtNtc/UyoxfeTT4Yi/Q6XVin
	VF7sB9ty33Uhp/5gujQ9yWTmCHITFry50EvBbTskoMiU3seanDZtH4pRFfgWt3MkyxMaxegI/Zf
	FvcVjPM79L0fYhUnT2j7ODN5PRMEGKL9qCS1YLAdzw/W+1wbKQsOJzbLdwucIvd5uvoUlc+yMc9
	140U9KEPiY=
X-Received: by 2002:a17:903:2c6:b0:2ba:7527:b31e with SMTP id d9443c01a7336-2ba794b71a8mr31325995ad.12.1778071399523;
        Wed, 06 May 2026 05:43:19 -0700 (PDT)
Received: from mma-H9MHD44.lan ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca244cfsm25172405ad.71.2026.05.06.05.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:43:19 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless 1/2] wifi: mac80211: skip NSS and BW init for S1G sta
Date: Wed,  6 May 2026 22:43:06 +1000
Message-ID: <20260506124307.2070157-2-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506124307.2070157-1-lachlan.hodges@morsemicro.com>
References: <20260506124307.2070157-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C510C4DA7B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36008-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim]

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


