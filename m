Return-Path: <linux-wireless+bounces-13003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D3697C5A1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278B1B22974
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD12198A34;
	Thu, 19 Sep 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cxwFlMCT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6098198E89
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733587; cv=none; b=HTw2evDdkZBX0JdAQSAOXQCrnDUNamYyI0io2bN1XPE5wkE74yNsW4aGFFe9nSiGrOFye9PmlFtAlxfyNIeVequunTtjkgN7IsrbcKFlPIBvBi2lGe1nh8W988LL2D5dT/q81etpxXz4AgdTq/2Y/7rzTANvDn3FETpOj877U0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733587; c=relaxed/simple;
	bh=cCWPj+hQDkVwFviV28jqK96uiWdkNezKoK5qDhAJL5I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neLoEB/FRAujb3Rwj+mLNqYSMabeiLwJ8YvaXZMKxh8e5UjdoW5othItjCqEA0wweLcmZg0ZqaWQgvL9CbFkohIkjHAAHzpoT+fL2EAt9f2X4xt9UdbN8iB2IcVSYBPID/JxKBwCAyyF+TLxG4b2dIjcYmLMg+SBj+L+/Y1zKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cxwFlMCT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48J8D2GY03453185, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726733582; bh=cCWPj+hQDkVwFviV28jqK96uiWdkNezKoK5qDhAJL5I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cxwFlMCTp25veF669W8tNQd6P7+qUgCEKurmnSuGEn5s4OG+qsaBDkgCTBpoxOEz7
	 5OZmzVMQMdcxbMaXrv5mkmYCBeCh1yj/16pRo3za2EOSJyaV0rTa8VP2p+hoiB5ghc
	 yMwFco8NZsNo7v/gLhU1s+Xu7JXpkMMPjYGAThgq6nUULeeMp5YRkDeBfiMt+zIBuh
	 e0ohCj2KdCWS1013GV61v5zGwgNFfNRoR+sQnpSx5tD9UeZ4Id3NAOPyaucH2r4Hwg
	 d4HDfJfApCeWrRBfXGisBNAi+9J7TC69XG2tf+aq/3keI35X0af8HS4ksB4eT+w3GP
	 znV5YYrGK/ULA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48J8D2GY03453185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 16:13:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 16:13:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 19 Sep
 2024 16:13:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: check return value of ieee80211_probereq_get() for RNR
Date: Thu, 19 Sep 2024 16:12:14 +0800
Message-ID: <20240919081216.28505-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919081216.28505-1-pkshih@realtek.com>
References: <20240919081216.28505-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The return value of ieee80211_probereq_get() might be NULL, so check it
before using to avoid NULL pointer access.

Addresses-Coverity-ID: 1529805 ("Dereference null return value")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 37f931e88791..02831514376f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6074,6 +6074,9 @@ static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
 
 		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif_link->mac_addr,
 					     NULL, 0, req->ie_len);
+		if (!skb)
+			return -ENOMEM;
+
 		skb_put_data(skb, ies->ies[NL80211_BAND_6GHZ], ies->len[NL80211_BAND_6GHZ]);
 		skb_put_data(skb, ies->common_ies, ies->common_ie_len);
 		hdr = (struct ieee80211_hdr *)skb->data;
-- 
2.25.1


