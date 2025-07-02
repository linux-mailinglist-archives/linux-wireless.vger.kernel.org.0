Return-Path: <linux-wireless+bounces-24756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDF2AF0C18
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 08:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB8D4E0324
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 06:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758C8224244;
	Wed,  2 Jul 2025 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jre4CyUg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B23221F37;
	Wed,  2 Jul 2025 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751439558; cv=none; b=OG6hWrRR1gbEz8GD1j10kFfsft+aVl5IKWy2+AI9/LQFxkOTG0Wa+rLy/HsBT7Gb4+JlC1B5zJ549ABpEytcuhWFNfk6SZ5TzkkxAIaCSZFQ2XhHDUoRccdo70DSoCb5v5lqvVFMKNJ/rcOP2BVtWOMg8LWrzemQ7+UCej7kFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751439558; c=relaxed/simple;
	bh=GkzTvSyEniyC3ZEHAImbsnkJbzyzm9ojEZbTBEvqDrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiusVM0i3ncHy8j039Tv+qEZlUE1tbgZMrPD0h+S7b1IyVIvoB8KJ47dykb0raWDQeKR3m3uPEKpLBkpq8OjQnBTawDR/x9uRPcdzdD0xet8U/ci8YAB9lLCf29EoT7iTa9X++FxehU5sWZDiiVGXg2Lb+lq4wQesq28zgf7RbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jre4CyUg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234c5b57557so40118365ad.3;
        Tue, 01 Jul 2025 23:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751439556; x=1752044356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iy+tjuaM2hP8c5rI51dRyXck9sDVRImbqSPT2GjU9Yk=;
        b=Jre4CyUgf1JFl2zNcvkKj+GO1BSHetNEiBmNuxK3KjInHygGOw0+kOsEL7le1/svzr
         tij1dryGqmsYX+5K54bDinG6apkagD5kNgnSJC5AGhZgSSMN8XK3/Sk1jIpHjKe9/4eK
         rQmeJgi5dRusfY5qVTcAD8gQLRrWMM3CUJmDaHyidFhrB4n2efpNWglFtTWSjEIG5r7I
         IjtfOlDYkh0FCwPD+n424ATH7xb057naulF5RVQVSr2z/E79yer0kejDRUaP7GZor8AK
         u+/nPrho3L5BU+20qmLz+N0ZvNGnAk0Zo1K4KTCTpULSmShgvAYIKjsVz8RWuSm/wMcR
         p01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751439556; x=1752044356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iy+tjuaM2hP8c5rI51dRyXck9sDVRImbqSPT2GjU9Yk=;
        b=bLZrvGa59Ekx84BVKfOizhHiJQbTEy5FkRSCGhatvY4GVAIA86loOU6Hpwn1WS3D8h
         auSlNCYkwwkG1XtMK9P12tTYnF/eZVeHuoP9tdBa7QOiycqP0DJQmkaGpq6yEiCNu0+w
         VA1sHp/0glcbFuA6XaPkv8ImScrkyHcYrS4+VZhljjyplIti0r4TvSp7iqsf1ZCNMF5q
         yIr0ai54ziXpfwjaeRwKk5v5WdgGBlsV2JbJStbSkreZIYaPFys/Inipdkq+uQw9DKes
         KRy2mgGB2FjeMcYa1Wo4bbN1Y7s3N6Ti2jZt8i+/Nv1ExfC9yHxTVsDKlslQ5y8nIXIM
         KXuw==
X-Forwarded-Encrypted: i=1; AJvYcCUNxZ9pvWvhO5AtqUSO4Y3G7nUgoAX2Zdubu9Hgc50WYYl9xe12zspCKhiFjuIisCwk084d5lnjjI2AiBVNAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHguQCEFnVmNEjwdktyxTmV/jhdW+VbsKbW6xDzh3krgcFATz
	42iVL5QRB3tHSX+nFsAMgm7x1A4cCGbJ40rWYno2ClIIjjh+aiv0OfxF
X-Gm-Gg: ASbGncvywcANncEHvQBJpTLw91iXo+lzEs9iNkDUSh7+f+URQCs3JdyOuYe0BsqvSio
	18pCC5vym+eCLgg1FhFelfidDeR2BgKALCApMH+kj6lvcHgq0OdBifr67y0G/1DdwV1fdCPdHEX
	UinREm02J+Q9OaEdZlHHM5Z91uZQEqotYgYK9a5G/2CsdKL/lsnThexv4BZZJ4d8MvraBdulVta
	vZf3GeZIe7+UY3EFnZlMhV0OOo+IlMltrsDTcIZxmiD7Ty5hKpdYXR0+diR946FyS7cOF3z1nrf
	gIN+uxbnGuHDB51Zx2NJRbroX3Z3AGt2ob26nvZJ+JQxXUMp5DsgEDymVPOHUBs=
X-Google-Smtp-Source: AGHT+IGwaZohNZujkd2GfQ4X8XAA8WyTk8Y4eQT6fuSighGLC02aVvwOW4e0WEfImTLx6kD/s93YuQ==
X-Received: by 2002:a17:903:120c:b0:237:de7e:5bbc with SMTP id d9443c01a7336-23c6e585996mr27347175ad.49.1751439556181;
        Tue, 01 Jul 2025 23:59:16 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:7bdc:b579:12a3:62f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bb7dsm122377035ad.90.2025.07.01.23.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 23:59:15 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>,
	syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Subject: [PATCH wireless-next] wifi: mac80211: reject VHT opmode for unsupported channel widths
Date: Tue,  1 Jul 2025 23:59:09 -0700
Message-ID: <20250702065908.430229-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHT operating mode notifications must not be processed when the channel
width is 5 MHz or 10 MHz, as the VHT specification does not support these
narrow widths.

Without validation, a malformed notification using 10 MHz can reach
ieee80211_chan_width_to_rx_bw(), triggering a WARN_ON due to the invalid
width. This issue was reported by syzbot.

Reject these widths early in sta_link_apply_parameters() when
opmode_notif is used.

Reported-by: syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ededba317ddeca8b3f08
Fixes: 751e7489c1d7 ("wifi: mac80211: expose ieee80211_chan_width_to_rx_bw() to drivers")
Tested-by: syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 net/mac80211/cfg.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 56540c3701ed..5a6ae093a8bd 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1981,6 +1981,21 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	ieee80211_sta_init_nss(link_sta);
 
 	if (params->opmode_notif_used) {
+		enum nl80211_chan_width width = link->conf->chanreq.oper.width;
+
+		switch (width) {
+		case NL80211_CHAN_WIDTH_20_NOHT:
+		case NL80211_CHAN_WIDTH_20:
+		case NL80211_CHAN_WIDTH_40:
+		case NL80211_CHAN_WIDTH_80:
+		case NL80211_CHAN_WIDTH_160:
+		case NL80211_CHAN_WIDTH_80P80:
+		case NL80211_CHAN_WIDTH_320:
+			break;
+		default:
+			return -EINVAL;
+		}
+
 		/* returned value is only needed for rc update, but the
 		 * rc isn't initialized here yet, so ignore it
 		 */
-- 
2.43.0


