Return-Path: <linux-wireless+bounces-21197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086FA7DE54
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 14:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B393A82A8
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2FB253334;
	Mon,  7 Apr 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="Qndw7veF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6289D235C1B;
	Mon,  7 Apr 2025 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030640; cv=none; b=HUIorzr6YPh82MPFq/P+s8tESVLnVefUxMuVKgBUfyguEkzXvt/HtysJO7C734/LosbJX4XGEUfprFs8FqNyRw2WsQL8wAP9KdyDPJBdDtWVlYBzXpw5BkKByOaLBUi4R8OLjBy6RLLyeKMM2t22KPhUgf/KvhSN0B6sQvXRgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030640; c=relaxed/simple;
	bh=6wA9Rt0Of/ILVZyU2c5Yl6/N7fY2XvsIHEnfiWtCCTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0qfucbRSV869O9X2yZaqWFqY1qaHPDo6Gdn3Npyx5qcLWl3inkCaE12mQ+uh/2grcOHGGAhPGcP9TMbOD5uWh7/FuByFNmvmpX3S2hGp+iqHSsP02VQC7bsbPL5Xa+iQ56JZ+YHHxOU9yzuYvconryyjZDOjKp49n91YWibJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=Qndw7veF; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 7D96EC0032;
	Mon,  7 Apr 2025 15:57:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 7D96EC0032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1744030636; bh=3lJzVQLzillG9b6LxM0kaU64I+HdegU7uqbXYZPNvAg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Qndw7veFg0EW0mBbyeCWHLO/ZgyG2Q1PNkzHZaYgg5SOW0utXnD3jX44H7zErcRMF
	 /GuS3dFC9Z+dntIH/X5jua4GbMQ01+0pOmBmLBASmYHXR6DlA0ionqj60BPqP2xT2b
	 rXdrioDG3m5rI8r2lpDNn27Ap14Jj442L70CkV4teONgjh47r0663ONt16bXqrnU+G
	 GdxlYW2lon37hve+L8d6W9BE3QhxLbcmpCzOSLFmau+GF/mG7YjKxaKbk1/BHwLQtS
	 uIikua/vE/YCzj7CctN/0kgORIaRK4zNB9KDWZktvoLooiu7y1/iFX5zqpPgGsV5o5
	 7J1kTLjX6zNuQ==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon,  7 Apr 2025 15:57:16 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Apr 2025 15:57:15 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2 3/3] cfg80211: Remove WARN_ON() in cfg80211_pernet_exit()
Date: Mon, 7 Apr 2025 15:53:44 +0300
Message-ID: <20250407125345.1238818-4-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407125345.1238818-1-i.abramov@mt-integration.ru>
References: <20250407125345.1238818-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg01.maxima.ru:7.1.1;81.200.124.61:7.1.2;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192430 [Apr 07 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/07 08:57:00 #27861720
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

There's no need to call WARN_ON() in cfg80211_pernet_exit(), since
every point of failure in cfg80211_switch_netns() is covered with
WARN_ON(), so remove it.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 463d01832385 ("cfg80211: make aware of net namespaces")
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 net/wireless/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 6f95aad18d47..b77f4ed8f2c0 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1656,7 +1656,7 @@ static void __net_exit cfg80211_pernet_exit(struct net *net)
 	rtnl_lock();
 	for_each_rdev(rdev) {
 		if (net_eq(wiphy_net(&rdev->wiphy), net))
-			WARN_ON(cfg80211_switch_netns(rdev, &init_net));
+			cfg80211_switch_netns(rdev, &init_net);
 	}
 	rtnl_unlock();
 }
-- 
2.39.5


