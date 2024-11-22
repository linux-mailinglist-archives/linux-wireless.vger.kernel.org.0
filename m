Return-Path: <linux-wireless+bounces-15614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC3D9D6511
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 22:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CAF2828EA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381C84A0C;
	Fri, 22 Nov 2024 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce9fHwUB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A57E111;
	Fri, 22 Nov 2024 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309471; cv=none; b=sRNU4b16GLdXwneJOBa5//6F84+jkSA/Z+6AY7c7I3F1aboZ4O8UjaCIaMBQ/9gyC/pSdAmU+vGp8lUS5Zv+xLDs+8Jso1atl6MvR793D171mG+iPpKZBIdnkLcTVOigqYKiUn/5DCq6z1C1Ho4SOmMkfIoW8SUCKHJu30niy1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309471; c=relaxed/simple;
	bh=F+v1Ru0uni2FPXIKtFvxarAFHqaEna9u93F4JIgKyaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fEgZE/myTNaib2yOmmH6yJrGl+m9MhCE3ZW10j465HPetNxKC4RpziEmZhzZ1N8xkwEhBhud+Jr0r8lhNmZ2dtvSsmcuEZdmQFrIL27kobnAMfXi74pmzDiqTN9wYo4xMxb3tyO76ykUEMGHIaeedZ7Gv+qnORwds8Qymefm6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce9fHwUB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffa8092e34so14589431fa.1;
        Fri, 22 Nov 2024 13:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732309467; x=1732914267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c9ZyOhR/EEzpu2AnEc2F9Koo0OBv6NsVpKPmnIREooA=;
        b=Ce9fHwUBXJRKrLuqcnugSfEJT0FmjzHjJ+DF8JwebgowCwpwY2NCkIpgOO1DV8CIIx
         MwRo3H60Gt5YpGoBeVIvm7e3GoC5KeklHDddvaWRZXJjBmzNjA+iy1Ucz1X3nv3IEiQ3
         NjvbRhAlopiGPxebB/D/BCW03dikG7G/EpqzB0uaua/ZyOLPjm4RxVPSRyfjnhtD90PA
         ar24HEgq3pWmIdHm1/sBZ8m1u0FkEDKwukd2p5PdMKb8T74lMj+f8v94FRztnuBW/aMz
         e+JKiglF/rSlOpCeldKt63+KuRAt2w7bHstzZcgNNbvtOndp/hwW1vpmdrsWsck5Xjng
         71Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732309467; x=1732914267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9ZyOhR/EEzpu2AnEc2F9Koo0OBv6NsVpKPmnIREooA=;
        b=fyaop8M8iHnfAPpkq7bh19TXw4SmsUgy3mdm6u14KYdRi+2T3+ZWNk906G/RTnyHuQ
         bipXONDIuTolfR6nM1aJHCK4wTGmB/1iD9iQmPjrWBFleTLVWn7HxPQHrOsh5DqmPfpU
         WY5obs+XiE9gvxBrZ8TEL5SAO00jq2zk8QZ1QTKigKDYNzv8ONzkRWFLzrXThsiyb0Z1
         eQZhCuh5v8M6coKCstj2pDgFZqx3vHQdYXDkaNMXKTjX4WEeUsHQs4p6JryhIRkkSDOt
         YwslM3GsKhV9pvKM4gHgg+c/pb/ypj24cv0lr5Icr8tlVYf+SxtNnSAOi61gKeNHGaYG
         VQnA==
X-Forwarded-Encrypted: i=1; AJvYcCU3KGbTakCgxMtNr96IIwxwEH5Q6WX3gectrDPc569r3W0h1QYDHpiMebq4utXClaSx24eWKrB1n6JKe/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZAdzuxtXRKwvwX3QMbZLj/Bp2edT78yECURbQMg4Bty753TG
	SAx61AOD2C8hOv/KGoKqO+htKrQJqMK+YpumcguR21hbPWhSSzWfUQ1+O6pVwmo=
X-Gm-Gg: ASbGnct/M5nMjGU0OrmgG35DavQmWFcL3/HkFH1Eki+gn34AgZjMcDpSCad6DTd6A/C
	Sjpy2pmQlyc6SHipdz/fDqISBtDgLq8jmuYDNa8WrmKEz8XrgQ4NlXJH4P2CT+URbBnDLrmHtvA
	h4mBTMeepSEE9AYMfLJeoL0aLiHsiz0uKMHMs2rKd5B4ZYFekNFvZkyMreXbE03rpJIygSgKCbX
	713wDpifaevOUzlxtxNmfJw5gukHZmokuR9Pk5kcnFrg9casue5/5GDNpo=
X-Google-Smtp-Source: AGHT+IFgi7IRzgMOCobKQO08D1Yo0MM15YLhVt2WwafSJCD+NT8rwDNMGy4Kzx1yLRSvIfJ9sNo3Xg==
X-Received: by 2002:ac2:5688:0:b0:53d:abc8:b6d3 with SMTP id 2adb3069b0e04-53dd35a53c8mr2834143e87.12.1732309467004;
        Fri, 22 Nov 2024 13:04:27 -0800 (PST)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2445850sm550072e87.41.2024.11.22.13.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:04:26 -0800 (PST)
From: Alex Shumsky <alexthreed@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Alex Shumsky <alexthreed@gmail.com>,
	Alexey Berezhok <a@bayrepo.ru>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Hector Martin <marcan@marcan.st>,
	Janne Grunau <j@jannau.net>,
	Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Neal Gompa <neal@gompa.dev>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] brcmfmac: fix RSSI report in AP mode
Date: Sat, 23 Nov 2024 00:03:46 +0300
Message-Id: <20241122210346.2848578-1-alexthreed@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 9a1590934d9a ("brcmfmac: correctly report average RSSI in
station info") it is required from firmware to provide rx_lastpkt_rssi.
If this field is not provided brcmfmac doesn't report any RSSI at all.
Unfortunately some firmwares doesn't provide it. One example is firmware
for BCM43455 found in Raspbberry Pi.
See https://github.com/raspberrypi/linux/issues/4574

Fix it by falling back to rssi field if rx_lastpkt_rssi is not provided
(like it was before 9a1590934d9a).

Fixes: 9a1590934d9a ("brcmfmac: correctly report average RSSI in station info")
Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
---

 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 349aa3439502..8fc10858e936 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3125,6 +3125,7 @@ brcmf_cfg80211_get_station(struct wiphy *wiphy, struct net_device *ndev,
 	s32 total_rssi = 0;
 	s32 count_rssi = 0;
 	int rssi;
+	int rx_lastpkt_rssi;
 	u32 i;
 
 	brcmf_dbg(TRACE, "Enter, MAC %pM\n", mac);
@@ -3190,15 +3191,16 @@ brcmf_cfg80211_get_station(struct wiphy *wiphy, struct net_device *ndev,
 			sinfo->rx_bytes = le64_to_cpu(sta_info_le.rx_tot_bytes);
 		}
 		for (i = 0; i < BRCMF_ANT_MAX; i++) {
-			if (sta_info_le.rssi[i] == 0 ||
-			    sta_info_le.rx_lastpkt_rssi[i] == 0)
+			if (sta_info_le.rssi[i] == 0)
 				continue;
+			rx_lastpkt_rssi = sta_info_le.rx_lastpkt_rssi[i] != 0 ?
+				sta_info_le.rx_lastpkt_rssi[i] :
+				sta_info_le.rssi[i];
 			sinfo->chains |= BIT(count_rssi);
-			sinfo->chain_signal[count_rssi] =
-				sta_info_le.rx_lastpkt_rssi[i];
+			sinfo->chain_signal[count_rssi] = rx_lastpkt_rssi;
 			sinfo->chain_signal_avg[count_rssi] =
 				sta_info_le.rssi[i];
-			total_rssi += sta_info_le.rx_lastpkt_rssi[i];
+			total_rssi += rx_lastpkt_rssi;
 			total_rssi_avg += sta_info_le.rssi[i];
 			count_rssi++;
 		}
-- 
2.34.1


