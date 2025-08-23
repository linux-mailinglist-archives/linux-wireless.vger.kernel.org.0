Return-Path: <linux-wireless+bounces-26565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C86A0B32BEE
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Aug 2025 22:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CD21BA8169
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Aug 2025 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CD223339;
	Sat, 23 Aug 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdaHLV0m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC9193077;
	Sat, 23 Aug 2025 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755980536; cv=none; b=KE9eKeNzPKi+86ts0iuuSFp5ZvhAPmmsZSQOhR4KJT8xXTZbJ2bt+4ouNpDA2WZNHklPt1TUsKiFFb5M3l0mushZS9nXATeUuVsfweO0XajaQnaLngHkXjPuaQZG18YKuhXB7ufdQEvOLwXHLnBKMyLORja6KeudZcwVY9aH0zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755980536; c=relaxed/simple;
	bh=Qnh7y1w9mFZQs85MUbGVVhpfR1+vrDCmKmHC+wR3zjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q9suovxZmyjxpPNlBj8mytmXnvdsSaurKetTjtpeXZVGPoy7DJGWqMgnFMBqm3/LVRNDDZc5qEdOEv24tukAbMNH7RWlUqn7wUlVNAJFKVw84/TZ2bi02oRqm0AeUjPQ/7C78CLBHOAkuID3W54hduUhmQ1cVLDhZPSHXhYluw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdaHLV0m; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce4d3b746so3575294e87.1;
        Sat, 23 Aug 2025 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755980533; x=1756585333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uk6JBqLr1nBAcjMKhAnoLZr+fShwwUXueuyG4gyTX0M=;
        b=DdaHLV0mLk7tpUESJcjzFkvK23WonnCiRCvFVHWnXAvsSdMDDeZxKhxXbA0nuPz4Qw
         MKnWE2Lq/CGs8ko/NyxV7/c4WdMooaWLdd/TzQC+QMGlrg23vA7kaYKxbiO8VmD8rfD2
         MoJKhcreum2aVUcc8IAUfn6Vu710JuGLo+DEX2AUSJJO3k9eyf74Q/LBmklH9XrHTpid
         Hyg1WFUo7VUpRp9ltLmByrDhRB3PeFTZblHk+kuSGlDB144xXI1zsMv1M5azQVtHvC84
         50gBVRq1AzQNgYZyEpxmB5gzcxz9w3YIz8WKvJqdfPcAqn/EUp75/RWitB4pyM+1Otxc
         hfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755980533; x=1756585333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uk6JBqLr1nBAcjMKhAnoLZr+fShwwUXueuyG4gyTX0M=;
        b=KyBfS3/3/O8jX+j7SEwo8qBJO3eSf6JhZsZ4ZqiUXHlr6rWJa4wpicjJCWvWMfxJXM
         pM96tcamN8X9zdb4nL2DRrGWgAylYhuzisqJu5/09694Ttv6MZZ17UnczV0tb6heOhok
         O/MOIzVoIiFKgnOOj088BokkLVBhjni8C2+HWHhMJ607DacTRSDH3zDsLosCtT4dFp7l
         4165xbL3M7IOFRRA+CkzTmxKhJDw7eMXskr3aaQyUNbqh426S+F9FwuRdDXZ4IJ4Z48/
         ClWmmmMkTvXcCYPd4YJvGBhlL4/NJWpVMqCvKZdiU/pu/fhHztFxuS3Fpn3TNieN83Hx
         C6+A==
X-Forwarded-Encrypted: i=1; AJvYcCUWUCFFkONIqDx7ez3P9GWawJoMvdIqE4yZsXr1ajMq/+rjdD8SfdkACCfU9HBSDWwCLt/iT2yjPehRbzE=@vger.kernel.org, AJvYcCWlMaR4m/AONyPoBgsTPOhSwIdowqq4Pdvv76aXgVFkPREIx9eaAA+vGGDj19/qWH2PiDF9iB9BpP2QXgbrFTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeMFuVJEK7IcqMFYzdKleqJEEJC6j4K9E5CAM4/BKZIunb4YRo
	5ePjw+6QEWgOK0FnJaGju6NIocyXkeBYn5B7Y7lPuxggIBccP7kbQyqbbXqwVMxQIsg=
X-Gm-Gg: ASbGncshuAayUP+MfHlj/F2b+pZy5bqXad5BV10cubmZdyC/FN36lTnQlES9K9Z8kil
	5YERSKJcuXothjGmchVue+yoEWPQcOxAW8Xp0QYn5hOHiAaXsBxb8H7ZOA4bmqKD9KvTGWjd3dC
	myVh7iJUT2rZWk2hX/VgDrW/282fItlu8OXcV2/E1ZStbuhJ/q9HG7+Gtt2AZIyeXUca5VqnPyj
	y9/9zwj/EKfYup81emPp/7JNo2BcIUEzkHti7tG4wPF3cJP9yGLKRWh17g5vOQKb+8bCv/44yQH
	HHzJJGHtXgGYY3SrG7vkKcPHlTgka6ViGLOVlJEM5FMXS785OBDtYjY9cnI+5hsSwZpYYaEqc6T
	2tnT9VSuqmS1cz3XAa30EAWD/9sFQ7aSwoLrnvBJ6hQdp3Om/lc0fTaclbAmqdFzc2SCTFDGToO
	e7g0tQf5dKV+CSXy20JddU
X-Google-Smtp-Source: AGHT+IFAVwVWCHwpngEfXoBUmU1nMTU7i5v8D3RecjDEHrG1BGNk9ukVlMqichFmxVcZin/kLP3Dgg==
X-Received: by 2002:a05:6512:304c:b0:55c:d730:c86f with SMTP id 2adb3069b0e04-55f23d8fd5cmr2470714e87.21.1755980532888;
        Sat, 23 Aug 2025 13:22:12 -0700 (PDT)
Received: from uuba.fritz.box (2001-14ba-6e-3100-e1f1-3f10-2a0d-f34f.rev.dnainternet.fi. [2001:14ba:6e:3100:e1f1:3f10:2a0d:f34f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c99e65sm677901e87.109.2025.08.23.13.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 13:22:12 -0700 (PDT)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	shaul.triebitz@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Benjamin Berg <benjamin.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 6.1.y 1/2] wifi: mac80211: avoid lockdep checking when removing deflink
Date: Sat, 23 Aug 2025 23:22:07 +0300
Message-ID: <20250823202208.43086-1-hannelotta@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

struct sta_info may be removed without holding sta_mtx if it has not
yet been inserted. To support this, only assert that the lock is held
for links other than the deflink.

This fixes lockdep issues that may be triggered in error cases.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230619161906.cdd81377dea0.If5a6734b4b85608a2275a09b4f99b5564d82997f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
(cherry picked from commit b8b80770b26c4591f20f1cde3328e5f1489c4488)
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 net/mac80211/sta_info.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index dd1864f6549f..e9ae92094794 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -357,8 +357,9 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 	struct sta_link_alloc *alloc = NULL;
 	struct link_sta_info *link_sta;
 
-	link_sta = rcu_dereference_protected(sta->link[link_id],
-					     lockdep_is_held(&sta->local->sta_mtx));
+	link_sta = rcu_access_pointer(sta->link[link_id]);
+	if (link_sta != &sta->deflink)
+		lockdep_assert_held(&sta->local->sta_mtx);
 
 	if (WARN_ON(!link_sta))
 		return;
-- 
2.50.0


