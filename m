Return-Path: <linux-wireless+bounces-37285-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IdXDGB3HmpsjQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37285-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:25:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85863628EFA
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A09CC30136B0
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF68F2E2665;
	Tue,  2 Jun 2026 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="ntfqofEn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2813A1688
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381470; cv=none; b=aAFOQ1FoMV809hdlFJhKyrbRL33nDMmeQ3tI9kmwXTDJbSQ6ndZbsSVNG3+ll5YZWGqr5Zt9VgO48s+UMy+7/F+fFMbxrNUEStiawSjREd6mMHUncwzPVO8lNU+3lWh4Dj2cADU1Ql0xqeiW534Un3rYRx0txS1NABq06zGOvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381470; c=relaxed/simple;
	bh=2C9A3OM7Fw3I65WryEyDl66yxrmI51veB1D2s+oz7EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOzNs5kBQdi5LApQuAe4q1nAZFDCR/C95VyNxjF4bHnVeBEGKJMsZAGC6QsHRh1POl+ZI3ddOwxrkAN/hRzE+J9aEHtuA3nurUHLTXjCtlD6+n0kzXGo2eBYYdzzeVlKIw4OZpcFLrs5PJNF6tBOXjEGk5IoPGHo5cpc62qwdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=ntfqofEn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso2068649a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1780381469; x=1780986269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MuDXJigNG34mE8Lk+aa2Eu6FA2H7aR7R/4xSVZzj/Tw=;
        b=ntfqofEnwoprgizxo17oDMJc6fQpTKyc+Hv9bE613yoDal6jzbz8EHA8kDSVFPsFWT
         hsg47ZraAjftETNVjC4m2Hr6gDxFLedcZPTBhOneVmzKdI9tqN4UY4Ly0IGqv8m8DzvJ
         fj8h7oRgRBahv1vRnQbhmqo54ukEf4TJ+1vztl/w1DXVJDhw9LNqSEYSH2dNq/cuDYzR
         YbuJubdsB6HgCfEz0RGX91XcD0yQc9LbzqYXWcffeXX/0Q/r/zagLQadsdilRm4UpbHr
         IV8DuwdXhuoegAHx89V1AtFB0XyOR2ClNPTB+R8NEZRrewDsCF3v9nYyG/GO+QoXlVXX
         Is6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381469; x=1780986269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuDXJigNG34mE8Lk+aa2Eu6FA2H7aR7R/4xSVZzj/Tw=;
        b=nmwKefFGcywnQyuK34nvJ025GH77jszTNYCS9SdPb6QZDDpe2/K60LLTdqR545pmyG
         IYVtmSgTL0Gq5FNb2Lxk93tfJg169dBdam0ZQeYF/MYs4f9R55fPjQJYHipEdSgWbmQC
         cJSGsvJ0PzNw8TRIzBw1yj/WTpOJvkypOP5HMy9dYim+0Nvy1U6t6Buun8O4nO+OBeXm
         yhq5bV3SRbGLacaIeaKmQ/t+pACVs4PsvFaez7tGQHnrwh0UcLyT93wUIdb87JHmuooU
         zs8KP1BuFIPTwDyu3oBGqSTLbw0AaReDfM/Z3H1jhU8k+ae4RTD2ht0/iRgMzS3gXfgU
         6kfQ==
X-Gm-Message-State: AOJu0Yzv7hRcbTqAu6dZEDi89XHO2CY3kd8NkSRii9wol3A6siueBvOs
	+anPWRA/aVsUKvXrA9InRhhLtGqd3oM6KrR20mWIQgIT4tFYYIjpQNG8r3y81rJY8Jg=
X-Gm-Gg: Acq92OH/svlLCXRsGlIlVV5WZqUGARBkA95ytZFVc3dShDQ7ERwf7D3xQ/BlV9RJFlJ
	Cuky0+vIu6B+PdHlgePUk8E62XgG5gg6DsAsfBOqJ9kN7yhB1sSTGpyKPFJvkXpaowu+rtLM+Br
	1kqlMbuRDe48QFtQ4g2xxOzw4GErWVYlnbebukvaJ8wz5ibVn2SSqHnqyz5fNQ5Q0aRt5isIzph
	bprjcBgaf4NiCpooxLmEBqZ4B6+NF/9XFH3dptELW16cN5TDjFNhyMWiElWBiMEeU2PxkEv2f55
	0N2No72hyv9MHgRB/UmjMC7sFGpcQZ8NwB5EnoZ94naVdYBJ+2nkFO7hffQ3JmQnKw2XELKQs4/
	A0R3LMFMU8UeEzDwzpCSO3FQjNHnPypohnptyuffVIGt6+U5F65im8AmyvoCoUSbWZsTvz/YC+A
	x/M4NvLSd45N+vezz/IU0szGyTOOgDG56Bduzxq4DJNCONtitm45ORtDb2qw/YiqNjnLn8GgcPc
	cULpXjHbkjNYp3FkjPkqw==
X-Received: by 2002:a17:90b:1d84:b0:36b:7725:defd with SMTP id 98e67ed59e1d1-36c2ebaf38amr13585992a91.0.1780381468751;
        Mon, 01 Jun 2026 23:24:28 -0700 (PDT)
Received: from mma-H9MHD44.lan ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd92029d5sm1875779a91.13.2026.06.01.23.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:24:28 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH] iw: station: print S1G MCS/NSS values
Date: Tue,  2 Jun 2026 16:24:17 +1000
Message-ID: <20260602062417.1830662-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37285-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:mid,morsemicro.com:email]
X-Rspamd-Queue-Id: 85863628EFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 station.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/station.c b/station.c
index 0f992d5b9134..6a143ac22cfb 100644
--- a/station.c
+++ b/station.c
@@ -231,6 +231,9 @@ void parse_bitrate(struct nlattr *bitrate_attr, char *buf, int buflen)
 	if (rinfo[NL80211_RATE_INFO_VHT_MCS])
 		pos += snprintf(pos, buflen - (pos - buf),
 				" VHT-MCS %d", nla_get_u8(rinfo[NL80211_RATE_INFO_VHT_MCS]));
+	if (rinfo[NL80211_RATE_INFO_S1G_MCS])
+		pos += snprintf(pos, buflen - (pos - buf),
+				" S1G-MCS %d", nla_get_u8(rinfo[NL80211_RATE_INFO_S1G_MCS]));
 	if (rinfo[NL80211_RATE_INFO_40_MHZ_WIDTH])
 		pos += snprintf(pos, buflen - (pos - buf), " 40MHz");
 	if (rinfo[NL80211_RATE_INFO_80_MHZ_WIDTH])
@@ -256,6 +259,9 @@ void parse_bitrate(struct nlattr *bitrate_attr, char *buf, int buflen)
 	if (rinfo[NL80211_RATE_INFO_VHT_NSS])
 		pos += snprintf(pos, buflen - (pos - buf),
 				" VHT-NSS %d", nla_get_u8(rinfo[NL80211_RATE_INFO_VHT_NSS]));
+	if (rinfo[NL80211_RATE_INFO_S1G_NSS])
+		pos += snprintf(pos, buflen - (pos - buf),
+				" S1G-NSS %d", nla_get_u8(rinfo[NL80211_RATE_INFO_S1G_NSS]));
 	if (rinfo[NL80211_RATE_INFO_HE_MCS])
 		pos += snprintf(pos, buflen - (pos - buf),
 				" HE-MCS %d", nla_get_u8(rinfo[NL80211_RATE_INFO_HE_MCS]));
-- 
2.43.0


