Return-Path: <linux-wireless+bounces-25494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D351B06494
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 18:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C6456511E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0951D5CE8;
	Tue, 15 Jul 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S98//PFb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E919EF50F;
	Tue, 15 Jul 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597983; cv=none; b=P5icQn32p4B46yNUHnr2P6U6kbqAA0y9TmwE+2SysQH4DlPXLvl6rS/cJIcfNh/N9ohR4vRBHVzXqYuxgXV/iHOLS9wX+mO3gt3TD1fvNQpgUVBaVPYJOqzjveomxBZw23R9d8aBFZF/RijoHyaHdR5/dWTv77Vii59RedbMbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597983; c=relaxed/simple;
	bh=KN1+idDcRjZASg2NeO1548RJaEhNnhyLKvVpDfq2j7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osJl58BIHYRMhlIGJRkP8q0PatWe/MSCTcZCb0Eg8KueY7eqJs/rL6Uaq3OacoSbngB7Th+UnxaCYyB45uVI84JiiSu5rLhW5N+D5YJSbIzNar2Gx+CR28sBEPzH+0nd83jiz87KnJj7mqS/izrN4GrdhotIMTMKqgCz5lXZuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S98//PFb; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-40a55314d06so1737509b6e.1;
        Tue, 15 Jul 2025 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752597981; x=1753202781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q5Y2bWlmHWdWBfcyRjkJl9kYIl0K0uhdnxQMfAgVEy8=;
        b=S98//PFbRt+HaEZ9bsGh2a3TB3ssYO5gRsIolFQNfetk3f3l2ONWMs0+DVknTWp5Ns
         ZOXk3vbZR98m3Eh9JpeD+9MM5y0uU3P5hsDPBzffL0vu3I3kGs/gK0ROkwdNuZEyj13N
         8cM4AFzsnn5vKqyjoYuZm8r/m0dZvy7KB7kzzn0HmY/phFqimQwsdcD21tvMPGmHLqlZ
         An+o8QrsXkTu9bgrCtXZYJyPOC6c2ah0f1hHHfPcicJwJ0R6jnoq2rVH0klQPwxXvzMy
         Y5EWQgMzDYc/zFyRKXlY4+HlYhQe5EqJiDkmo5e8ado8AS9AVHuVJo4AHm2N47YqyS7m
         xKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597981; x=1753202781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5Y2bWlmHWdWBfcyRjkJl9kYIl0K0uhdnxQMfAgVEy8=;
        b=Tpr6bPAHLnsQXEbfV7IWBzwNtIKbEzGxb/QIKjsyCQzRJAlIMrZ6JMBC2KuJSSHrNP
         xdW2pr7wQtDBi/OoVdmw9b/DdKp0pHxo9Rt4/PgSF+VGadqKUQmPikLA3wCJF3pSTJAE
         LFRCRB+dtZmSeHnZDyt4+zpEhsiPanEF3kj5f+J/W8Ch2JEENCNizwMW2dSnUcuuwoKB
         +h0PRgpr43UHGBqWjimmmx4BW6adjIq4cVNRz3K6jW4i5w5E30wg9wVmdEozm1rDD+zK
         ar6xiURRMLllI+mKdmdl+rxrLfAqEfio7ZDWYtkZO/WYtaTQ0K0TuufpCuRal0/INYPI
         eX8g==
X-Forwarded-Encrypted: i=1; AJvYcCXBU2BFaEwvv2pT/yEgQrqZKUqoHDSJGEazt9oTvk4TY9IRWq6pyOzU8j7XCVYAeBTFCDRJMM1nhxoXv8U=@vger.kernel.org, AJvYcCXSVVQ1MM3Ud5e9MvJ4jsz7hCzJ5KkhDQngdeDrsAURXnhQi4ah94ORxX8piJCEafrka/PfD79CBnYc/cHWu54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1OF9UTOw8Cuwq/FanS5xcD4ayIWT8YhqrDScH25sue44XOr1
	IzomvStg1FpA2vnaKhDMMkzDBJBWg43phuYpqwIvrQKC0PWgkZ0rsrrW
X-Gm-Gg: ASbGncvvQ+mJPNi4IMjFNO/Pvl0prdBDVk+j51Y6it5h3Fm43129UAXtMgkrP1PmZJQ
	sC8N1+cJEAASgRaXJvf71rW1qqZ45j+mT/ur9YHUWFVesQBtPqitNvgzAaiOw4t5JTlKtxdLqvw
	dE2ntxL3rymuhKkwz2c/GVKzoJRrDHGYeO/F5o2Yx82sn8TCw1LWWr4mR6mTSZD3LRifzaKP/1s
	mZReO6Wx7uq2rsn2nHDbu3Pn3TZKbi8gaWtSbS+fYhejngqgeBNG42Je29l0i4tRFD8Cc2noPjU
	otcDhNu6l0Ai1k2+rTVBK9v3mNqVbKGal2PuJeF61pkoo/rVeJkZWzW6uzsyPebEDiIEcbQE7iK
	x2xScJkATmDd2uI3j6MqLa4E/Fpg+4+9qBQ==
X-Google-Smtp-Source: AGHT+IGflQWtE6YeKPB6bvAH1nvX3ElYWGJ5mDtmmTTq3F0In1+HLYwx3T9YAt7CShB7Vh+Zxdizig==
X-Received: by 2002:a05:6808:30a5:b0:41c:f95:d602 with SMTP id 5614622812f47-41c0f95da35mr1440181b6e.15.1752597980857;
        Tue, 15 Jul 2025 09:46:20 -0700 (PDT)
Received: from s-machine2.. ([2806:2f0:5501:d07c:635c:e02d:7b6:7330])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4141c58febcsm2115044b6e.41.2025.07.15.09.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:46:20 -0700 (PDT)
From: Sergio Perez Gonzalez <sperezglz@gmail.com>
To: johannes@sipsolutions.net
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: direct error paths to appropriate exit point in nl80211_dump_station()
Date: Tue, 15 Jul 2025 10:45:35 -0600
Message-ID: <20250715164539.14383-1-sperezglz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two safety checks which, on error, will go to
cfg80211_sinfo_release_content(), at a point where `sinfo` has not been
initialized to zero or populated with allocated pointers. Bypass
cfg80211_sinfo_release_content() from those two goto's, but also
explicitly clear `sinfo` on declaration to prevent any such issues
in the future.

Link: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1644656
Fixes: 49e47223ecc4 ("wifi: cfg80211: allocate memory for link_station info structure")

Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
---
 net/wireless/nl80211.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4e6c0a4e2a82..c516fa5f5e97 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7446,7 +7446,7 @@ static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 static int nl80211_dump_station(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
-	struct station_info sinfo;
+	struct station_info sinfo = {};
 	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
 	u8 mac_addr[ETH_ALEN];
@@ -7477,7 +7477,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				kzalloc(sizeof(*sinfo.links[0]), GFP_KERNEL);
 			if (!sinfo.links[i]) {
 				err = -ENOMEM;
-				goto out_err;
+				goto out_sinfo_release;
 			}
 		}
 
@@ -7486,7 +7486,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		if (err == -ENOENT)
 			break;
 		if (err)
-			goto out_err;
+			goto out_sinfo_release;
 
 		if (sinfo.valid_links)
 			cfg80211_sta_set_mld_sinfo(&sinfo);
@@ -7504,8 +7504,9 @@ static int nl80211_dump_station(struct sk_buff *skb,
  out:
 	cb->args[2] = sta_idx;
 	err = skb->len;
- out_err:
+ out_sinfo_release:
 	cfg80211_sinfo_release_content(&sinfo);
+ out_err:
 	wiphy_unlock(&rdev->wiphy);
 
 	return err;
-- 
2.43.0


