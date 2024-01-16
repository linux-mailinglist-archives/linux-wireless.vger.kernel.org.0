Return-Path: <linux-wireless+bounces-1982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2F382F081
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EE31F23E63
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8091BF23;
	Tue, 16 Jan 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdxDb6SH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE51BF22
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd5b467209so96793561fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 06:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705415029; x=1706019829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pkEZBqewq9VevcH4Bvsfs1qRfkxaqgLqqwS4jZ98QL4=;
        b=kdxDb6SHWxWU4RbRKcCMZyqEkbcpj+qLRFVA//7XVzvZc9LrOAJK1mY6CwJKGYbasI
         D4q9O2VEOACT2vC1hBboHEsHWsdYxLFPWTpQ25O1soP6+InZe/Jyn4c0FObA0OkAp0tY
         rGFs6iFUGOE6RDl1eZxW9hu+7aF7by6z49CR545fcAKzD1hDbwBD79VhQT1PDeOOHBG9
         WOXaSN/LXrxepxPPryOImp9SE7Wfpvxcd23GC/rWCU/an/j5fMcxDoAj9lWII72OUtut
         yoR6wOypYB1YGksoAD5qBgSRlyYGE8tIICjalTmXPdO0lChIe+O8l1re6Tfu1mw1Wgjn
         gndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705415029; x=1706019829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkEZBqewq9VevcH4Bvsfs1qRfkxaqgLqqwS4jZ98QL4=;
        b=b9a/PZrmWTScrstKdctfcdJBwmloxhD3vAmj146W0zwEL6Kcj+bqOVwkAOwKI/BaN/
         qcG2vfM0q+j9iXLiNG78w5AIQem/S0bvkcTAdPEPEx7gzTrEBg+xnYnfRx7IAyyazCl/
         eEWhkp5Hk3X0E0NEmppnC0G68m74GF4/7uUq7pF23NJyWEzkzKVZ1+imCohc6VQRi+hW
         lgKJzroFQIUtcWbplf4ADevUu+Kg6u92G2VSRQ5WWzsr+xE58fFwTKzrZfr/xokhmN/Q
         +5zKRFKz0egoh4Ih2fH7TQiozwYaZEUTljsjq7TJvqEI4l6DRShWT1nWYGwArDQE6Dbg
         p9/Q==
X-Gm-Message-State: AOJu0YyR8fboiCr4eqjBqiH+zXLCyTcy4PoHvc0h2/C87dZdhlAxrAfV
	8XPXmSyZGWHTvfm+6L45A6HHJyFRJ9zGrg==
X-Google-Smtp-Source: AGHT+IGAeldapc/0O4AS1YwxCTNzUSjdWxKp0TZ9+sImDXV4AKQjVXESlzVSIRhwtg63e7hfksVUlQ==
X-Received: by 2002:a05:651c:1075:b0:2cc:7db2:acb6 with SMTP id y21-20020a05651c107500b002cc7db2acb6mr3218419ljm.7.1705415028965;
        Tue, 16 Jan 2024 06:23:48 -0800 (PST)
Received: from pl-pxe-build-1.pl.plumewifi.com ([2a03:4b00:0:4:305d:2ec7:b750:b37b])
        by smtp.gmail.com with ESMTPSA id f11-20020a2e918b000000b002cd5624c1f8sm1609402ljg.109.2024.01.16.06.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 06:23:48 -0800 (PST)
From: Michal Kazior <kazikcz@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Michal Kazior <michal@plume.com>
Subject: [PATCH] wifi: cfg80211: fix missing interfaces when dumping
Date: Tue, 16 Jan 2024 14:22:57 +0000
Message-ID: <20240116142340.89678-1-kazikcz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kazior <michal@plume.com>

The nl80211_dump_interface() supports resumption
in case nl80211_send_iface() doesn't have the
resources to complete its work.

The logic would store the progress as iteration
offsets for rdev and wdev loops.

However the logic did not properly handle
resumption for non-last rdev. Assuming a system
with 2 rdevs, with 2 wdevs each, this could
happen:

 dump(cb=[0, 0]):
  if_start=cb[1] (=0)
  send rdev0.wdev0 -> ok
  send rdev0.wdev1 -> yield
  cb[1] = 1

 dump(cb=[0, 1]):
  if_start=cb[1] (=1)
  send rdev0.wdev1 -> ok
  // since if_start=1 the rdev0.wdev0 got skipped
  // through if_idx < if_start
  send rdev1.wdev1 -> ok

The if_start needs to be reset back to 0 upon wdev
loop end.

The problem is actually hard to hit on a desktop,
and even on most routers. The prerequisites for
this manifesting was:
 - more than 1 wiphy
 - a few handful of interfaces
 - dump without rdev or wdev filter

I was seeing this with 4 wiphys 9 interfaces each.
It'd miss 6 interfaces from the last wiphy
reported to userspace.

Signed-off-by: Michal Kazior <michal@plume.com>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 60877b532993..b09700400d09 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4020,6 +4020,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 		}
 		wiphy_unlock(&rdev->wiphy);
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
-- 
2.42.0


