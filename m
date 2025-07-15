Return-Path: <linux-wireless+bounces-25501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C8B069C0
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 01:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B1E4E5EAD
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 23:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7382C178E;
	Tue, 15 Jul 2025 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4KlHejU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA24A3C;
	Tue, 15 Jul 2025 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621173; cv=none; b=SEhLtiEshyi1IuSwwv+Ejh1IyhYWKPkAQ/f9aYp9Pc3kBupqF0YcYO4pBrjUivS3idvSw5JUbD8FJ/rNULNl9LI9K/h1CV5xPrM426GmOQEF5LGFtLvGZVKJEzwo738j/S3LNBZ1mw5x7OozCCFV8oa6rOWTWJvMkqzGJN+TArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621173; c=relaxed/simple;
	bh=cnSaEW1G2x+Vi12ZOlKThqIkkcwIaeVH5M8TjdoEHkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jl0CUM6bTC6zZUcSyiuFWr5zncqHXjqMBatYMxX5jOSdy1rpIP/BDAufGa+B5h8JX5v7NKst5pd6M8vDXeJdCI1MsKc8kCt35h6V7rgvonmMJQ+cf/Ow/MktMnJ+Q4607GGJ5RCkx+JGdZ71YtlC28EzZNmOiLNOBFghWoIGXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4KlHejU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23c8a505177so56048375ad.2;
        Tue, 15 Jul 2025 16:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752621171; x=1753225971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAPRSx32Yoh23SFp75OsDGsW9gXJ3MOIHEnOw0OZgZI=;
        b=G4KlHejUFZL4smMIC2i6wHh4dbmZRpIxq42rpDCPR9LDEcj35/3WuIUToPW/V1wJy4
         VSDa235vdqmjdT6ELQByih/3yB0BQUQ1Ez3OqYytaTxbxcL4nEjgnE1U7U/+QRALm49i
         keAW/KQezbpq5Cp4n9hsOdjwXgdzS38iUNZLN2y+/S42NIECqPZAGTqI6UGFiobaKOEQ
         XaTdhwkaji6UBd5I2ZCpbd+XIjyOK137+iVlnqNfX6bQls5XQqWIC29bW8xP31PYlF5Z
         NPcojUXc3UlAB2qz9NmGQfl4pfisjoCM+cDBLCKDUcvpEwfkIa2MP3AWd2u3o/2Zhx4j
         +PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752621171; x=1753225971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAPRSx32Yoh23SFp75OsDGsW9gXJ3MOIHEnOw0OZgZI=;
        b=HOdLfUBGnmksB22/ii5R9/Y0ZBfDaizVqux5aSXhOy6t9QKwwPVgO124kd68iSX7GH
         Jw7JC2D5pnoIcVLMRO6W1HkaDk9tHTEfHEILZQgSlpdf8bbU4UkzsQW3/GLlkM+1roiv
         NOJDj+Q5cwYhRTzZO6ksCrX86Z6DSErhglCO9jXkltNiUwax42N0a5mw394L8eu38Hx3
         Cdvv/EtWZ+eLqmsg3nEGgjYJalwfl6JRHRDWavMd1CbJu5wgyCcrNQaulm2chYIVE4gZ
         1rZ+owfSQRP17TS3GsPtCh/mTouIpiLr7hQdX5Du9ysu7A748atnGZoG7I48GwA5GCyE
         fuvA==
X-Forwarded-Encrypted: i=1; AJvYcCUPeOoj4/uTOvO/lZTzT5jUbX0v0LmSEMm4gaCpRy362IQo2929QqkuvGRTrfCcguvBczRnB6+V@vger.kernel.org, AJvYcCX7SG55GKPHvU0ya6RqEAYpnN9WbGUrlXVnEdK8HAvWd6poBhL0AdzV0n+PslRXyiGoszpa6Yg9XPnaIbT3CA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzotWltq6VneCjWWar0dnoA/m1kYtlNU3PJpTFi8qFgsrI2afgQ
	likA3zmGK5u4MdpbrKI5/44o1Ot3851wldimGsbTl4M4wLGf8tJDgo1F
X-Gm-Gg: ASbGncvpOKCZEqaKNmm8QVlGykZGcptWWjiqU2Kggo9HgUegkUCVueug0ihHapy5Yre
	cSCU/8FumqrsjLRXiBzE8WCPpa2FM8/atNfknLfyWug2nCBG0tcI+un5nGHAtoWoeLuNi91ZHVj
	3o3JpM/qLNyToevauW1ku+r+weRIiGMlFXdFHokQ4icRbrZM2xoNMySG3IM9sGRXCeFY6UKKimO
	lEOwmlLNQsQZ0DhvGHKfXXmTW8BDao3kThO4WhdnhxFw1gl17de1Zq7Tqn2G8hz86gvUwYhJVYH
	LoyGLnYKnTjdyHR6qrZ8D2wMwN9WQYlbfs0zz/FotoB1wTE2MY7kveJ/jtye/rvcreZxkHRsnrT
	+5TSdv8J87A+jPu6NocjJhzs4
X-Google-Smtp-Source: AGHT+IGshsBE0EpvzBXYF91wyMej1W2e+64pc4pC0n1OrITGe6q1Y4ZuOz24myUDG1ahFwsL3M85jQ==
X-Received: by 2002:a17:903:198c:b0:235:e1d6:4e45 with SMTP id d9443c01a7336-23e24f44b0amr9612455ad.25.1752621170746;
        Tue, 15 Jul 2025 16:12:50 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:5324:4bfb:25b5:ccf1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm119769045ad.14.2025.07.15.16.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:12:50 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH wireless-next] wifi: mac80211: reject TDLS operations when station is not associated
Date: Tue, 15 Jul 2025 16:09:05 -0700
Message-ID: <20250715230904.661092-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot triggered a WARN in ieee80211_tdls_oper() by sending
NL80211_TDLS_ENABLE_LINK immediately after NL80211_CMD_CONNECT,
before association completed and without prior TDLS setup.

This left internal state like sdata->u.mgd.tdls_peer uninitialized,
leading to a WARN_ON() in code paths that assumed it was valid.

Reject the operation early if not in station mode or not associated.

Reported-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f73f203f8c9b19037380
Fixes: 81dd2b882241 ("mac80211: move TDLS data to mgd private part")
Tested-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 net/mac80211/tdls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 94714f8ffd22..ba5fbacbeeda 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1422,7 +1422,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	if (!(wiphy->flags & WIPHY_FLAG_SUPPORTS_TDLS))
 		return -EOPNOTSUPP;
 
-	if (sdata->vif.type != NL80211_IFTYPE_STATION)
+	if (sdata->vif.type != NL80211_IFTYPE_STATION || !sdata->vif.cfg.assoc)
 		return -EINVAL;
 
 	switch (oper) {
-- 
2.43.0


