Return-Path: <linux-wireless+bounces-10199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEDE92F341
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 02:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F73B21E7B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 00:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED378646;
	Fri, 12 Jul 2024 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ndZGZn3f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF44683;
	Fri, 12 Jul 2024 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720745965; cv=none; b=uTrm1bny2oK5w3njJjbBdkfTczwSYUVm81Z8RjJQCiHNjlZl0GqD8X/GtXQGLkM+p9a8ZyQkpsuz3GWws8C0QwRh/u9zTGV3PBBGYvCU1tMSab/nBYh9WBeqYSf1Svj7dT1bkjy8c4B26aM/WGLvDVUOTsMc5ijAQSUbMu9ivys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720745965; c=relaxed/simple;
	bh=GAdSopk0MEBiOTh6kpH6hsoutSi6D7sgAjx7WCNFMAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eq6/xMlKu+rT5oLRmx8e2CMd7gRjrdTo9zNAnci5kfqi4+po98P6+9SNG5qoBGEBJvRn3im9cUpc5c5e6cc1w6+hBdYX63DN4+TdkJPP0eP8jZWqFj/WZm7bbPWIg2h9l7X3SHitE79+h68E+iy2r0+d6+K23bajuoh/PNOmfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ndZGZn3f; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46C0x38p94078907, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720745943; bh=GAdSopk0MEBiOTh6kpH6hsoutSi6D7sgAjx7WCNFMAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ndZGZn3fqJaiS3aJ6BGpjL3IABvGh1YXMSHD+3uIh7sBnQLCMYsMVslZX+PM+ENKa
	 evfmeivHgK32C0M7hEkYJ5SDkZYfiH7eOwUDnxvR4UZEKF8Ux6TLb81ag0vTaPBaTs
	 gTkJxt5iXnK8oFlVfQ2m8Y4mlOEA63tSmvL3OGiJQKAKPaVxBfBgcC7St52iVa3bQH
	 t9A02wv3L2l7twN6seU5JhaJZvPTiTE06ngVnWsLjjP6PfSiqnqNzbW1Aw26ez1O5o
	 vI/VeGAyv/1QS1M3pEgIT9BU5hFs1/qq1hySLzP3hh054C6GbcPvpfqagW83dXgzv5
	 orbR3eZgEeuzg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46C0x38p94078907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 08:59:03 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 08:59:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jul 2024 08:59:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 12 Jul 2024 08:59:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Forty Five <mathewegeorge@gmail.com>,
        "johannes.berg@intel.com"
	<johannes.berg@intel.com>,
        "quic_ramess@quicinc.com"
	<quic_ramess@quicinc.com>,
        "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bernie Huang
	<phhuang@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Topic: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Index: AQHa0VQl1ZM9p1UVPU2+rvQ8T/H4+rHtmRKwgAMNNwCAAaDZEA==
Date: Fri, 12 Jul 2024 00:59:02 +0000
Message-ID: <1e0b6bb3fc1e43069acea85e72fd04dc@realtek.com>
References: <draft-87msmrdgkb.fsf@gmail.com> <87h6czdexm.fsf@gmail.com>
 <6673a2dc01a941f5900da7393d160005@realtek.com> <87jzhs9xef.fsf@gmail.com>
In-Reply-To: <87jzhs9xef.fsf@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

+ Johannes, Rameshkumar and Aditya

Hi Johannes, Rameshkumar and Aditya,

Mathew helped to do bisection and found the cause is=20
commit 1c0d21c4b33a ("wifi: mac80211: remove only link keys during stopping=
 link AP").

The use case is as description [1] using RTL8852BE. The STA and AP mode vif=
s
operate on the same channels (SCC).=20

Please give us guide to dig this problem. Thanks.=20

[1] https://lore.kernel.org/linux-wireless/87le2bdgk0.fsf@gmail.com/

Forty Five <mathewegeorge@gmail.com> wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > Right. Only apply [1] in every bisection step.
> >
> > Thanks for the exp #1 and #2. The results are in expectation. Then the =
new
> > bisection will find out another problem.
>=20
> Here are the bisection results:
>=20
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [5bbd9b249880dba032bffa002dd9cd12cd5af09c] Merge tag 'v6.10-p4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect bad 5bbd9b249880dba032bffa002dd9cd12cd5af09c
> # good: [bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23] wifi: rtw89: add wait/=
completion for abort scan
> git bisect good bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23
> # bad: [480e035fc4c714fb5536e64ab9db04fedc89e910] Merge tag 'drm-next-202=
4-03-13' of
> https://gitlab.freedesktop.org/drm/kernel
> git bisect bad 480e035fc4c714fb5536e64ab9db04fedc89e910
> # good: [57f22c8dab6b266ae36b89b073a4a33dea71e762] Merge tag 'strlcpy-rem=
oval-v6.8-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
> git bisect good 57f22c8dab6b266ae36b89b073a4a33dea71e762
> # good: [43a7548e28a6df12a6170421d9d016c576010baa] Merge tag 'for-6.9-tag=
' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> git bisect good 43a7548e28a6df12a6170421d9d016c576010baa
> # bad: [8c9c2f851b5a58195ed7ebd67d7c59683d1a02bc] Merge tag 'iommu-update=
s-v6.9' of
> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> git bisect bad 8c9c2f851b5a58195ed7ebd67d7c59683d1a02bc
> # good: [b38061fe9cfa90a781e9e59fc761191fc8b469a1] net: phy: simplify gen=
phy_c45_ethtool_set_eee
> git bisect good b38061fe9cfa90a781e9e59fc761191fc8b469a1
> # bad: [75c2946db360e625f1447a37f47dbbb38b1dd478] Merge tag 'wireless-nex=
t-2024-03-08' of
> git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
> git bisect bad 75c2946db360e625f1447a37f47dbbb38b1dd478
> # good: [d35c9659e56edd9e629b54da8ceca062517d3d6c] Merge branch
> 'net-gro-cleanups-and-fast-path-refinement'
> git bisect good d35c9659e56edd9e629b54da8ceca062517d3d6c
> # good: [e8bb2ccff7216d520a7bc33c22484dafebe8147e] Merge branch 'net-grou=
p-together-hot-data'
> git bisect good e8bb2ccff7216d520a7bc33c22484dafebe8147e
> # bad: [85977fc0aa489420709779cbc859966db94be68f] wifi: mac80211: remove =
TDLS peers only on affected link
> git bisect bad 85977fc0aa489420709779cbc859966db94be68f
> # good: [c2b22e26755c77299e1dffa2e17374cd28f7f3a7] wifi: mt76: mt7921: fi=
x the unfinished command of
> regd_notifier before suspend
> git bisect good c2b22e26755c77299e1dffa2e17374cd28f7f3a7
> # good: [9ad7974856926129f190ffbe3beea78460b3b7cc] wifi: cfg80211: check =
A-MSDU format more carefully
> git bisect good 9ad7974856926129f190ffbe3beea78460b3b7cc
> # bad: [68f6c6afbcebdc3acdc6084abfe453f4cba6b9dc] wifi: mac80211: add iee=
e80211_vif_link_active() helper
> git bisect bad 68f6c6afbcebdc3acdc6084abfe453f4cba6b9dc
> # bad: [b2edc721716f44e2a7e46eb592321960a1227c7b] wifi: cfg80211: print f=
lags in tracing in hex
> git bisect bad b2edc721716f44e2a7e46eb592321960a1227c7b
> # bad: [5fcc7c51f9e72d1e62991f8b32be4a5adf44d556] wifi: mac80211: handle =
netif carrier up/down with link
> AP during MLO
> git bisect bad 5fcc7c51f9e72d1e62991f8b32be4a5adf44d556
> # bad: [1c0d21c4b33a41be9090e73f8225813d72ac88d9] wifi: mac80211: remove =
only link keys during stopping
> link AP
> git bisect bad 1c0d21c4b33a41be9090e73f8225813d72ac88d9
> # first bad commit: [1c0d21c4b33a41be9090e73f8225813d72ac88d9] wifi: mac8=
0211: remove only link keys during
> stopping link AP
>=20
>=20
> And here are crash logs for all the bad commits:


