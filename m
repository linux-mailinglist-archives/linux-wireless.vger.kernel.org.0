Return-Path: <linux-wireless+bounces-36007-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFypJKQ4+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36007-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 14:48:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F514DA7A6
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 14:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B573D3028ED1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 12:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6683844CF39;
	Wed,  6 May 2026 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="jo4PIM9m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35A40DFAB
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071399; cv=none; b=d6pMtMN1tFEk000bNQd8JTusQZ6fJaVD87UaGI6Zvlj/W4y6CwahgKzIq6d59I4ePJSu4vPK9i4RZBr/TPnrg069nFpeTMUp2/W/XP9OrWhii26ypdx83EKMYPmG44VMyPUcijdSMUkoKsVG+qNjTZcO3/0MR0rEoz63m197DlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071399; c=relaxed/simple;
	bh=vNU59s3KKFN6QRIpMBvmuJdhNWix50GG0KD3tMB0S1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTsalb3JLWgJ1lIuRkjTDLpt2mx2kSxP017fFumq+Ql5UH8noUu/LL1YMjmkQvzsPlY5q4fcURdbJfnvFFade2OSKr66aX6UkNFhV5ErPL+OImay8FQperbzW+ZQeNJTZEvc2FEIiY0Jwr/sOmDhsoyE5PHxxkvB/Rzu7JlrS0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=jo4PIM9m; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b45cb89f7eso43463615ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1778071397; x=1778676197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIlofl6ONjr7h9G0IMtyFOiGBIiWPUn5I+DErvuNGrk=;
        b=jo4PIM9mbxghyJ6b3JzD5+EoebmFKLzObFLzdPYgzFQzjz6qZmTsoM3w2BCXa3pCOB
         VfYI55Rl/Mawyl3tXdh1SMJfi+vcCeKIciOFh/u6h7LIx+hLN3enLT4ir/l3WeYcu68k
         EtYNX1OXv73M1qxWKww6oVKqL0MrouxLqPMnVFxwW4ibehijQqiWh6uycnJB1S7avR8Q
         d0PwQklvxEDTsxGuayHwOKA76V8ZSbqfQ0vcSHoPObj8QII62NlaZ7WRrPV59c0JbRUs
         6V9SAkEmUgyDMagx795L+ZS21P1DYawwOoOt1moyrNpB7vDE2BFmVAQ/wnq0WIQMuk1n
         RiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071397; x=1778676197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIlofl6ONjr7h9G0IMtyFOiGBIiWPUn5I+DErvuNGrk=;
        b=hfUINFkafoHUJ/YyXTiffJHYT16UU0B1mLOczj6kwXZXdT1lKZS3WHTiTLokBgvaxF
         E3RGOe9N4FNXRqC/MEPqtxFFd/+MSOR5k1aUytiCXHO3nYtT92s+qJhDtES9DamfmsFJ
         BcvKMY+AzRy4l70frr5as3Mzozc+P/8rPdb31wBA7thJijg1QRTIqDRt8SGWVH41HW4V
         w9+rToaUNsknwUjMJWwMdfqalTPpGXL1llarCUMsDUp693OXszoN3jgQTmscSXQ28fAj
         rq8Zk6jqYNiiRzUNBSM6qFOy2mvkLPz4/g+psiq98MBGx7RFXqcyNJ0n0te5GKfRx+wW
         1dAQ==
X-Gm-Message-State: AOJu0Yym6cY1awUuF+cop5nXBS12OTZt6S8JcW5nofnbTr28Me0XooJx
	icLQqbKkGELikZsUiRFQN5OB1sf0JlXEx7CqK02x+HlnHbFYlErNn8NOhZfIz5SSq+A=
X-Gm-Gg: AeBDieu2F2HxS2y0kff20dp8D8r4iQ+IFOT0Ze6urw87HeoSduwd/jgnPz7FSXDNyNX
	+aegt6XQZory3EainL++yaISE6xm56x06nnlTNkuZgqy+oJAG7GAPeUKs1LUNANuyCoQRdZNWLp
	lMXzMhv49FZQJvr7Dj14u/c30VyN+gqwp3zPt7RMaWUtOHjMTxt5+r6beImqfjIs+KN60xaCH0M
	MCEruOJhGV25SlxmyDb/SAAvZX27P88H+3YmvkGawo80lKE2H38SIoZRbTLCdxd4VtjLPek2XOY
	twr5XkS4+VBYem5kOK1GA7xyq9hUiBRYwnwSTjHZ5ofKZkmcx+zp43K9k7m5TsUMQL5kJmIKFLD
	/4R8ENsbqw3ggM2kCUVThUh8M6WZkerrOvj2r7Gy0Mm+1gEElGH8ytLCJvv7Kp3n+sEMrlEEu2c
	ROHdVNG/iLb8394MAbsjHm3KFYyZfRpMxmGG6Y4PGQDLzvThtUFwpXzjX8M8BX3jCd//GIERtB0
	mBwVCZc5sg=
X-Received: by 2002:a17:903:4b04:b0:2b9:41ac:d07 with SMTP id d9443c01a7336-2ba78e40756mr29828365ad.14.1778071397072;
        Wed, 06 May 2026 05:43:17 -0700 (PDT)
Received: from mma-H9MHD44.lan ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca244cfsm25172405ad.71.2026.05.06.05.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:43:16 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless 0/2] S1G channel fixes
Date: Wed,  6 May 2026 22:43:05 +1000
Message-ID: <20260506124307.2070157-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E6F514DA7A6
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
	TAGGED_FROM(0.00)[bounces-36007-lists,linux-wireless=lfdr.de];
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

Some recent changes to the STA BW handling now lead to WARNs during
S1G association. These are more or less bandaids that will need to
be fixed in the future hence the TODO.

This will definitely need to be sorted out in the future, even if it's
just a rudimentary implementation especially if we ever want channel
switching and "proper" interop with other vendors such as Newracomm
who have different maximum bandwidths. I've sent these two atleast
while the driver is under review, though I know TODOs can very easily
remain as TODOs 10 years from now...

[1] https://lore.kernel.org/linux-wireless/20251008014006.219605-1-lachlan.hodges@morsemicro.com/

Lachlan Hodges (2):
  wifi: mac80211: skip NSS and BW init for S1G sta
  wifi: mac80211: don't recalc min def for S1G chan ctx

 net/mac80211/chan.c     | 10 ++++++++--
 net/mac80211/sta_info.c | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.43.0


