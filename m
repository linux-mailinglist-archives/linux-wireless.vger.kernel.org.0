Return-Path: <linux-wireless+bounces-36025-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP2nGt9A+2lPYgMAu9opvQ
	(envelope-from <linux-wireless+bounces-36025-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:23:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C27264DAE7B
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 508D630075C1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591C44D688;
	Wed,  6 May 2026 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="pHcc7Wdd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6C472766
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073581; cv=none; b=LtfIPV+ZXagwCTKKS30CThE85aqVzxWoKFzTt23tbrPoDDtMGqPrWcQxGR5h2wq4gqOQkLq7OXaI0fCR1SYEycRIULh3C24vpHXVxTcsE2Banc+9sO7p9Zl0UfxLYFLI488y9dQctNctPkXQcui1G6ya+lThfkwhx7jI4gRqDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073581; c=relaxed/simple;
	bh=82KEd4IBACudO4evUZQTqdy+J7hqhGdV1eRLSi1BQJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ha5OPM0HSkP0tJ5zUYbmAPqE5voB6o+d590cmQ7PX17I4SzaBBAgMvYEurKzh6qVJs1RcAhQBvOug2sfyDH/tHT9/KAwMfyUluJo6hgWydm7w8RNYerSvNxCkAaedzAKNijB53jAbmQm594Qlx/77felUd1TBj+KeiDdp4q0U/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=pHcc7Wdd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-837c09d2268so1526972b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1778073577; x=1778678377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5M/ulRZmIEeH9TY1Fov/240OIOLtN6O3LFjtLZjDGs=;
        b=pHcc7WddiZQsbPSIRQ4Y6Ci38L5zOfBCEonadK63saw1BbrjOk0txypd4MriQmFYQw
         YPdoEjsrmQlZUkK7tKuwQq71LLm7Qo3gzboPMYWBL7UVXlfhSmsXSrg9WGdCki6nrYhe
         ixdILiyIXaiKz3MvEofUe2fzM8qL5tL5PlwttekH/gUpXhJVWrmqGBopGdjHnstZFl6A
         WwECkX4AJ+7d6zHhTQV+LUf2oq/Ql+GQFJTQk526v8xSFqggafDzmq5cZYbq2kihdWST
         EvYfachs0Oweb3gPfqsi985R43vdr4LD9XeQsp84ffvhoWFw3PihJ3p8VBbW+fPMTKCC
         zw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073577; x=1778678377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5M/ulRZmIEeH9TY1Fov/240OIOLtN6O3LFjtLZjDGs=;
        b=npPJs95k7Ces4MBXyW+NLKChdk5fkloZj9edDzvrCGmdsLfGwnW/PNLxqW+huZar0Y
         5MvMArGGtUBrMjJpGv6EGmwLkhSHtMO+a4J6N3xrFq9kKs+jFxT5s6/y5GloshOs90hq
         fC2WnIlEewgcu/6pzi7V6TpFfGUY6sa3pGfvG9fKHURA4KVSQZePulOwvHhI7pvKooiF
         mMOwRzdHdAPUI9uYZuHPYA4v+g7PcioNY2bhk3EjxHiwDVd6qeFs7JsEJKFsL8wvW5Ty
         ajFo90/3LsRRQW/N/eWgsp/UdR9lKOjh9YNtSD5q4xAuHfSlIi3lSA9AiDNc0cPPsiO/
         RQng==
X-Gm-Message-State: AOJu0Yz3bK5mmPxKac9etVTtmtR9vlzMW2E4h535Elj2iKo8f0vHxPbJ
	u6R9YqF3vmicSebtSSwhD1qVuMSloj9TD9lP8sJZSSLmu5bguXuKFlI+HDWT8bSg82I=
X-Gm-Gg: AeBDieteLEmSDo/mKLMG9e00Eh3KFDLnexPoj42xNn9XOUarl3RJ1x2j2mCq0X2UHpg
	ZedV02sx8oj1g3zNICgROoMFZCw5SLUaw6vDthsIS/YWR1m5nejhveC8oXfFOdYq8Xw23ZzZl3Z
	cW806zUN/a6QLID6wICwR7KRHi7tAecmoXEFPj2wlSmHObihEnZzYvrE1gKYuHY0+w3AeqmNLrL
	LlSlKPPsinJ947bZSZrF8rZ7ZDppvYVrwpvMUDgMW2c8hHlB/uUGM7faRUsRAQYfgwHqB6MNNsR
	h2vpE/8RXDZsba2XyktcsmZ8Sj4n67lXe+IGqzKyzLaftqYPRP5CjvrRxdoxsTfICBmpTNFn81u
	1Wp9CdggAWMMNo8GxMapBYkecd8kRBZdFjzX5sW9Gw7/TkgBTRteDAqbKiuB3c4ecuuXP/cQnhH
	AORRItL2AqeZ2sGgZsYN0zSZuHX65Nt+jx/esoF4VodE+oJPa9DWKWY6C+VTLHB/5EQA+04qe+2
	r9XidmsM+dzMJNQ
X-Received: by 2002:aa7:930d:0:b0:82c:d7c4:4c6b with SMTP id d2e1a72fcca58-83a5b8d8c8dmr2774155b3a.11.1778073577499;
        Wed, 06 May 2026 06:19:37 -0700 (PDT)
Received: from mma-H9MHD44.mymodem ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a52cesm5336035b3a.57.2026.05.06.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:19:37 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v2 0/2] S1G channel fixes
Date: Wed,  6 May 2026 23:19:23 +1000
Message-ID: <20260506131925.2088353-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C27264DAE7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36025-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid]

Some recent changes to the STA BW handling now lead to WARNs during
S1G association. These are more or less bandaids that will need to
be fixed in the future hence the TODO.

This will definitely need to be sorted out in the future, even if it's
just a rudimentary implementation especially if we ever want channel
switching and "proper" interop with other vendors such as Newracomm
who have different maximum bandwidths. I've sent these two atleast
while the driver is under review, though I know TODOs can very easily
remain as TODOs 10 years from now...

v1->v2: retarget to wireless-next since the changes aren't even in
        wireless :)

[1] https://lore.kernel.org/linux-wireless/20251008014006.219605-1-lachlan.hodges@morsemicro.com/

Lachlan Hodges (2):
  wifi: mac80211: skip NSS and BW init for S1G sta
  wifi: mac80211: don't recalc min def for S1G chan ctx

 net/mac80211/chan.c     | 10 ++++++++--
 net/mac80211/sta_info.c | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.43.0


