Return-Path: <linux-wireless+bounces-33041-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFrGCBVIsmlrLAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33041-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:59:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECF026D403
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7077430C453C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 04:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F94C39478F;
	Thu, 12 Mar 2026 04:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="PNdX4KCn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF939D6D2
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 04:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773291518; cv=none; b=MULfunOA5hU2AT8nAs/lJJGy3d9OZXR+4QJ2M+7ABlJwdSyfHsYKDG6Xzg31wuhSzmE6gJkT1Hucgvd0Ri3nwtgryxuJq5R/2Ks7k68EOqbF7N8+qmrfqlQK2E5dYSjKEh5ahWyOTYY+5uNFeei9rVgC8hmitOawEC4ZmJqXp9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773291518; c=relaxed/simple;
	bh=ETPsfVC0Lf6Q6Rv4b/WXqDCCrepxk+hun/0pGiTNlxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ax8h2HF1oVE5Q3laxGjLyQDlKka353SwadoOnC2fye/XKZQdD1Jok3QRKdyUoOkshXwJ+24DFXE3o5vF2svOMPgi++dBAUTFA0azrZkVAdXIr6rXLlCaAmZkUUAC3iV2e8TeLTnoYZEmhAjMIc//ihdERCeCpKiQWtl0bjVIdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=PNdX4KCn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82a07738118so298494b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773291516; x=1773896316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGglENPxRBeySj20kIHtk6snC1tdill30JpsCgsv0QM=;
        b=PNdX4KCnIzAZFDpRlJYSWPM6VSNCo/fURMzZiQ9aXMXLiJY1yPn+vC3OFo+Y+7XhD/
         4bsIFLVyiURHFkefDB3yVD99MLN/KjYmzNh8bvs+1H+23oz90mGt3yRs797bDGAgy1CD
         8SylZkWwSLcdrbR/BQLyDvmKe7NC3zCFqWfZYcv2TkHQxwt4uTCRVhlkloAy9tBY9MSn
         hCTr8Xv9U8T0iJ6eDf5dHefv2Jf4g2mDuCBovRd8uViD5RD2PksAkWX74MIQ9jXVxXQ/
         V+0nH+q+bj6p0Up1OrqLYTQjMlaFzG0j2XFOBwH62ZDZegiGhp7PP1I1+8hCOv2CWVr6
         HdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773291516; x=1773896316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGglENPxRBeySj20kIHtk6snC1tdill30JpsCgsv0QM=;
        b=PaWx3dqN+05PVVtCvAWe8qew2OXyrwiIV8+BDQ8BE763hjunrXFhGaynUrC5wXnCYD
         spB2LUzJl2F8xH31UBLtxGKiIrsmzeUqAYvuQRWswVZ06Kr5gIcdP6Oa3SsQ/wWdLVNE
         B00rjSAdPTaoTbJs22b9CtJnZDZU6uZUUvQclbkeKgYJMaquimbT7ojy/WlikrOf/dxX
         obYLwi/FrXHGAzZbZumnblQsMCyyliNRx048mxqGLD0QjvDzlP1Jhwsz9kuWyaEGQlc3
         aitVq9f+oSr0PB2YUh2iwdqxRpYns7+Q0cqX46DNmtYcabar0mUNWMPLNuAQIje9pfob
         T9gw==
X-Gm-Message-State: AOJu0YxkK74Di/iuAxqZ1OKUuKDVNwoKHFMmyeGsglrgkiEejTiPSVZK
	xpgqKR+/NYrA8DjbnRelWCa4L00NX2PmyC/9/FbhONVkcSfdT0idXdC73iRSm2tyaYM=
X-Gm-Gg: ATEYQzxzLtd8Ms7/xTc9axoxIHTJXSxaaovcpaGig/L7PPzS+neV5XYyMrEjQ2T3rXv
	e3d15SL5D/HxG4s6UvSVeEn4m0jiJAl/wDACXT448DsZHXVs6YtN8yTONX6N2kW6wxqWKJFxal5
	hdUHrpvbV50w3SuWMAdDOHgyR6ijeFcvBGJRfaC0OQwtkJq+a2sEwHiB9HWB2sPanRlAIeHqR16
	62XV2z2tNZDEyUcpvNo5axG4Qsjib6w3KQZHjG7f6RsDpQOokjFS+M27UoWLUuHMeozchS+8HbA
	H8BF+FTkrumDbQCPCu5bpDlHPeSsT3Wpeqxd1c0UWR366+9eQbWAPJkIa5jv2VBlp4nWLlqPy3J
	3vUdxLNQImShejNNwPEnaQUm+Jmj9JiwQGvT8p+ZXGXbd1orc3IA846i3VXWlFHVde/I0Gaz8J9
	M1lI1AaEGfJIvNLG6+e8i5FA1O+Hn1EqdlcU/cQIpZHpJr2RBo3YCk7So5i8YeYlbnLPvCeii2a
	BM1sImeDxLJkC67KcI55oTXS8nmq4U=
X-Received: by 2002:a05:6a00:1399:b0:827:28e5:63f3 with SMTP id d2e1a72fcca58-829f7101c58mr4657225b3a.29.1773291516324;
        Wed, 11 Mar 2026 21:58:36 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07365090sm1382480b3a.46.2026.03.11.21.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 21:58:36 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v3 3/3] wifi: cfg80211: check non-S1G width with S1G chandef
Date: Thu, 12 Mar 2026 15:58:04 +1100
Message-ID: <20260312045804.362974-4-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
References: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33041-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim,morsemicro.com:email,morsemicro.com:mid]
X-Rspamd-Queue-Id: 7ECF026D403
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It is not valid to have an S1G chandef with a non-S1G width. Enforce
this during chandef validation.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/wireless/chan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 4d2c2b9f1eed..f80bc5144037 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -353,6 +353,14 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 
 	control_freq = chandef->chan->center_freq;
 
+	if (cfg80211_chandef_is_s1g(chandef) &&
+	    chandef->width != NL80211_CHAN_WIDTH_1 &&
+	    chandef->width != NL80211_CHAN_WIDTH_2 &&
+	    chandef->width != NL80211_CHAN_WIDTH_4 &&
+	    chandef->width != NL80211_CHAN_WIDTH_8 &&
+	    chandef->width != NL80211_CHAN_WIDTH_16)
+		return false;
+
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_5:
 	case NL80211_CHAN_WIDTH_10:
-- 
2.43.0


