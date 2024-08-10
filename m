Return-Path: <linux-wireless+bounces-11252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B451C94DC23
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2559DB217BA
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4336415278E;
	Sat, 10 Aug 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am08aGf8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6D1798C;
	Sat, 10 Aug 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723283734; cv=none; b=jAC4LS/ap58sTQ/a5BI88jJbWQyMXVef3WN1CUIxT2/S3GdRiT1QmIiYFfJYpChJuuL7kbK++KxdFY+vGSUXLwvfWuQxRJDcwOt2pvWKQe2wnIoA3wX6Zhxsj1SLD4nl7ZWklEE2X1MzxjBhSQ9dzd/De+vkvJoxcpzmbTKqjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723283734; c=relaxed/simple;
	bh=hRpxI5aWlAWLkEnnePj1K7YJsxCy/fCjF/Ajo2Tq60w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhDpPWdwxiiPjLbIhGbMH1R3qlSvro/00CP74lCC0sMiJ2jSucxRIeYjWgebICo5pRvCcKsMAjMHQBS4M0dpEt3rHOGuWtZ/ZdjiQEH5WeV/h/tVORs4kaZUn59VVx9k4IhUAJ3tmXx++PzxEMGIy1kpFo5y4Y9JRMU/1moZBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am08aGf8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so3369505a12.3;
        Sat, 10 Aug 2024 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723283731; x=1723888531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FJPxArVt2QCQnOFcPrUVyt9riSmvMq3yX/VBcIgITE=;
        b=am08aGf8VeQROz+u9M+a2ihbn4C8v4ms92NoIMbtl+xUEuPF6YnmRGwwsnlHfwl5pO
         A2//Efma0U2v/l6iQE3ZurxjT9WJ82n+VNW87p0r01ur1QTX6e0QW9hC45T70r0PLqAb
         HIt2aoF9DtxOI+aVN8fPjh/fL3UiaiGswps4sVRzcS5ffycnOhmGCzz4/a8LgFzIO2Np
         hmQdjuNUhV61uIavt9xd3FuI2wwXQOI961xiG43bLjTieDo9rbY6GR0KZt0A1Vibjtye
         fLXXULJANrPqHuVXDYpTpzJ1AFxPKRt4FAVJ5E0BBr76Uo6S6zA96MF3eaUtB/ZyGq3E
         /blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723283731; x=1723888531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FJPxArVt2QCQnOFcPrUVyt9riSmvMq3yX/VBcIgITE=;
        b=Id2CMiZGArAENtXA9AOzBsK5eJQC0X6moE3Y4wy3IbKql584M7SxBWhvm2Dy6b6Mrg
         2wRlRA5ZizQxucc35Lp4XbugV3qzfcdUHcnsX3kOnUSM/K6BoDLrjIZS1b52Ajn3D6Lr
         uyINbWrtnxhIaryV0BeAXSNGNx3Y4BiZjgP53cWK4aDEls8J4ZSBlZ9DZCBpR12CDS9a
         yzKiPZFn/mII09Qx7/89c57QA1KMx6ClkxEc4cc6Fb/d2TjUlBsSS+Q8bTUf0rqwO7n9
         Z8IBMe4RJm2gdqZp4atL7Lgr8FPaab5jhqVn/FCESLQG4rbWtygvqNMWVhnzN4RGPXHS
         GBKw==
X-Forwarded-Encrypted: i=1; AJvYcCU/W9RuZa41nEDvN22dCCBVuRUKjfwaW8PmmbNGOEwdsufGCNhRDjhNrEoDxv+hk3pNXcn8a9PNa5A0DTc17y80l7nmrq83kCsOCE+ebF/HMD0ljM/0ZJzSJX3/PRK1
X-Gm-Message-State: AOJu0YxZ/ni1nNNWAhCyVhInpHlH0WVXYscDwmVnCQG3j6wGWYTFnM27
	zc1k5s8+1UP+QJjD3Z+kommoP3DghrpexkWRRZRU5tQ0OO4N4+jg
X-Google-Smtp-Source: AGHT+IE1W/czQOB9ClkuLcLzYYTh1KZWVB8qiFT80780wV3w7KtOVpZFsp/F0DXlel7sPTRBCPkiEQ==
X-Received: by 2002:a17:906:6a02:b0:a7d:2a62:40e9 with SMTP id a640c23a62f3a-a80aa65a470mr311172866b.50.1723283730347;
        Sat, 10 Aug 2024 02:55:30 -0700 (PDT)
Received: from sacco.station (net-93-65-244-85.cust.vodafonedsl.it. [93.65.244.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb21375esm55994866b.174.2024.08.10.02.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 02:55:29 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: johannes@sipsolutions.net,
	sashal@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH v5.15 RESEND] wifi: mac80211: check basic rates validity
Date: Sat, 10 Aug 2024 11:54:31 +0200
Message-ID: <20240810095432.89063-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

commit ce04abc3fcc62cd5640af981ebfd7c4dc3bded28 upstream.

When userspace sets basic rates, it might send us some rates
list that's empty or consists of invalid values only. We're
currently ignoring invalid values and then may end up with a
rates bitmap that's empty, which later results in a warning.

Reject the call if there were no valid rates.

[ Conflict resolution involved adjusting the patch to accommodate
changes in the function signature of ieee80211_parse_bitrates,
specifically the updated first parameter ]

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reported-by: syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com
Tested-by: syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=19013115c9786bfd0c4e
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
Hi,
I'm resending the backport for v5.15 [1], following the one I previously
sent for v6.1 [2].

Best regards,
Vincenzo

- [1] https://lore.kernel.org/all/20240727125033.1774143-1-vincenzo.mezzela@gmail.com/
- [2] https://lore.kernel.org/all/20240729134318.291424-1-vincenzo.mezzela@gmail.com/

 net/mac80211/cfg.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f277ce839ddb..85abd3ff07b4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2339,6 +2339,17 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	if (!sband)
 		return -EINVAL;
 
+	if (params->basic_rates) {
+		if (!ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
+					      wiphy->bands[sband->band],
+					      params->basic_rates,
+					      params->basic_rates_len,
+					      &sdata->vif.bss_conf.basic_rates))
+			return -EINVAL;
+		changed |= BSS_CHANGED_BASIC_RATES;
+		ieee80211_check_rate_mask(sdata);
+	}
+
 	if (params->use_cts_prot >= 0) {
 		sdata->vif.bss_conf.use_cts_prot = params->use_cts_prot;
 		changed |= BSS_CHANGED_ERP_CTS_PROT;
@@ -2362,16 +2373,6 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		changed |= BSS_CHANGED_ERP_SLOT;
 	}
 
-	if (params->basic_rates) {
-		ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
-					 wiphy->bands[sband->band],
-					 params->basic_rates,
-					 params->basic_rates_len,
-					 &sdata->vif.bss_conf.basic_rates);
-		changed |= BSS_CHANGED_BASIC_RATES;
-		ieee80211_check_rate_mask(sdata);
-	}
-
 	if (params->ap_isolate >= 0) {
 		if (params->ap_isolate)
 			sdata->flags |= IEEE80211_SDATA_DONT_BRIDGE_PACKETS;
-- 
2.43.0


