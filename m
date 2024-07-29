Return-Path: <linux-wireless+bounces-10617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713EF93F6E5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 15:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23931281F2B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179314AD19;
	Mon, 29 Jul 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLXi+Rnj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56248005C;
	Mon, 29 Jul 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260619; cv=none; b=gsjmwPU+sRZ4yClhiV1HNoeGIJUNDobqDV6/niNusNwOOXXbAZ9+MYXuUBsd1UqsosOekAjGXoP9EhnjSvbljh5LuhGmwIwemrrCfAjGQJDo31jRajU6IFtgwTfRMjyBi+TZQ7t10ye1lfcFf60IDLQx3W8VeKM7H7nMydd5Uio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260619; c=relaxed/simple;
	bh=zzsCJ7whFPZHlCzi0K9wdzqqFDFkagpKKuyBi2JGQ4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CF5OV8hWiEyfqm+yoEr45t3bpBjx8UKrpUUDQvmxONd7RfDVIZS3bo19JsiXAOpG9CDDEIenr38YfifCD8GP3Cvpb5qosg/3NpT/N0xTndfWjC4T3tH1W8KvumV51BjkRIGoR+ttPe91BblZN/lLGziUEYcioKf0uF9T0xvx/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLXi+Rnj; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so46401451fa.3;
        Mon, 29 Jul 2024 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722260616; x=1722865416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hj4EojyPa3nkcWjxnXuz+mzsRSbP4+g7BeKvDtSYTtM=;
        b=MLXi+RnjxgJlVa0Vo9qHNeXZcOkgXu6OuO7hHpP5lqLuaprMT7WBj4wiJME/Q1xAUA
         VkGhDkLcAe9IasTetaxBDrVi7dHu6vqVZPLvHQYQJBYJvN1PUSLYqcbPjl2jAZ2v5KVM
         XwgZjVzchvkCyaR1ZmW+uIUdXhcd4aPfceM9VD8weCekrlBVVyWsljACE4KQASPLJa3Q
         0kvWxjlxhq9c/os5nKMosu4viGKuYzuklM5zGNe8Dh4Er3A83LznwS5lVIgL+yZiI3ZD
         kAu/sBbVPGpGDhyC/pVXQ+ArIEVlzwogShK0tp1nGK/Rxx3cuh++dl1auXZqXOH8G7G0
         5ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722260616; x=1722865416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hj4EojyPa3nkcWjxnXuz+mzsRSbP4+g7BeKvDtSYTtM=;
        b=Llp9P1oRfeZ7C2dRQXMHXJa+7C7uzThCiJuWUFBWZigmhcjmF3EflxzJNhwyVFeQpJ
         Wucz6qMyUqIzIIC8d2VbIjctYcBQ32qs6uAPoJ9roxizFKyvIltZE4rrC351cz+k0PpX
         GsN7872O3jL148EgPIjr//Khgy1tHTNN9XsUFJtyDlisGnkLp5VxrGUbsuwxdqXOnYUs
         jm88/qZB24I747Q0dMaQLxbj7dlkRIR0Jk8JN9kj+8k2cKW6B452fNacpsEONXtTsQ3a
         2dWutvx9vVtvT4r00Ztc+wxSag+EJfh+o5uLqrTTHHD0/uFM2QLE2pXz5kgQ+LCRNZMI
         Op2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAgEeVx1fhFfdXuZoI7+rdxeZDtzodce/WUMC3OWcB5WQl5HixtSd6lJjJdAuhlc8tMFP2yrFLhwKvP9Jb98YVJKDJye9UGYK5MnsixSYvflfAhJrjLHiKP+ypoqHq
X-Gm-Message-State: AOJu0Yw5xjaxJpx6qtllimjUvPKjHOUW5s8mS993y+pHsytxNrJneg7r
	dboSX/NHoTeb6ubCi1R+dFovHs/7XWdURjsaj5qHFqwBRcKCoDZd
X-Google-Smtp-Source: AGHT+IFWcvfSA6H/Fveto0C2nD7ipfoGEYAQa8wj7qhQzrtiL/syC20upw4OQKo9ISarEXIM/YwY/A==
X-Received: by 2002:a2e:8e95:0:b0:2ef:3258:4961 with SMTP id 38308e7fff4ca-2f12ecd295dmr63821791fa.15.1722260615456;
        Mon, 29 Jul 2024 06:43:35 -0700 (PDT)
Received: from sacco.station (net-2-44-141-41.cust.vodafonedsl.it. [2.44.141.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282113ddbcsm7278035e9.19.2024.07.29.06.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:43:35 -0700 (PDT)
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
	syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH] wifi: mac80211: check basic rates validity
Date: Mon, 29 Jul 2024 15:43:18 +0200
Message-ID: <20240729134318.291424-1-vincenzo.mezzela@gmail.com>
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
changes in the function signature of ieee80211_parse_bitrates and
ieee80211_check_rate_mask ]

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reported-by: syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
Tested-by: syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=07bee335584b04e7c2f8
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
Hi,
please note that a backport of the same patch for v5.15 is available at
[1].

Thanks,
Vincenzo

- [1] https://lore.kernel.org/all/20240727125033.1774143-1-vincenzo.mezzela@gmail.com/
 net/mac80211/cfg.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2c60fc165801..d121a3b460f4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2577,6 +2577,17 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	if (!sband)
 		return -EINVAL;
 
+	if (params->basic_rates) {
+		if (!ieee80211_parse_bitrates(sdata->vif.bss_conf.chandef.width,
+					      wiphy->bands[sband->band],
+					      params->basic_rates,
+					      params->basic_rates_len,
+					      &sdata->vif.bss_conf.basic_rates))
+			return -EINVAL;
+		changed |= BSS_CHANGED_BASIC_RATES;
+		ieee80211_check_rate_mask(&sdata->deflink);
+	}
+
 	if (params->use_cts_prot >= 0) {
 		sdata->vif.bss_conf.use_cts_prot = params->use_cts_prot;
 		changed |= BSS_CHANGED_ERP_CTS_PROT;
@@ -2600,16 +2611,6 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		changed |= BSS_CHANGED_ERP_SLOT;
 	}
 
-	if (params->basic_rates) {
-		ieee80211_parse_bitrates(sdata->vif.bss_conf.chandef.width,
-					 wiphy->bands[sband->band],
-					 params->basic_rates,
-					 params->basic_rates_len,
-					 &sdata->vif.bss_conf.basic_rates);
-		changed |= BSS_CHANGED_BASIC_RATES;
-		ieee80211_check_rate_mask(&sdata->deflink);
-	}
-
 	if (params->ap_isolate >= 0) {
 		if (params->ap_isolate)
 			sdata->flags |= IEEE80211_SDATA_DONT_BRIDGE_PACKETS;
-- 
2.43.0


