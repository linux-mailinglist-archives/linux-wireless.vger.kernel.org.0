Return-Path: <linux-wireless+bounces-10708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BCD942627
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88258B21F5B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 06:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E621607BA;
	Wed, 31 Jul 2024 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uiyEHfLR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA721607AF
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406163; cv=none; b=arxknKIOx36LN3AZf+Xm57NO3zNKHIGJqFAjcvzBZN3F85l2oj47KIblq57ypZ/UZWkTBl0NTy8978TgsDBA3Kde1ClyFo//L8vfGI8tNplVWdUgmpzBDeI9n+tRA4cEZl5xIhijCAfsTn+gwxJVoiMsi1lXA1sX+ffwZiBQem0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406163; c=relaxed/simple;
	bh=+AePV9mf/REK3hWzqNEPd1hmR0QW+8o4NEF2MUHEANk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=JSkgTyJD4EaGqaarI8fBLnN+7ci92rTx8ZnhdgaHOAsRSsxLKE6Lf0p1fYcNB7GmM3aXo21seN2HIBYvFLxf3xtio0HR1sJaSN93u5GnGrMquGpFoEeR+dgsa+tgEe67J4ndp4ZpdpwAwJJbLVqMmVrjmmRz0ttxFay3BtB5pWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uiyEHfLR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V69HupC2027540, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722406157; bh=+AePV9mf/REK3hWzqNEPd1hmR0QW+8o4NEF2MUHEANk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=uiyEHfLRnp1ptzb8QLOKEWXwb66NSFnqqzomv5a7x4Zb1PTp2Fu6vxJgXHuNEmc/2
	 K32qxliw8m0pIn8H8NfrFiXAE/wiDlrYEV3JevKZkPRsHZEMmBHqmfz5JimpSCiRbB
	 qKjy+3oFLsFwhBXP1qX/GtgVfzrGNhjGoGTvFzL+8CTqZDfRrZq2W2wtqg2gMTPssw
	 G1AnhsZowJCu0gGK6+96CkLp0FSR260UJ+oGcdTAiaYCiPt/LHjWYENyPDQAAn7I/N
	 IGe1LOu0v9tVAwU9taMuv6atj6fXOwu6mnRA5Qysc03bPZ/roOeuMHCKayh0p3mmgs
	 JQyefmmbb9TkA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V69HupC2027540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 14:09:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 14:09:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 31 Jul
 2024 14:09:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v3 1/2] wifi: rtw88: 8822c: Fix reported RX band width
In-Reply-To: <bca8949b-e2bd-4515-98fd-70d3049a0097@gmail.com>
References: <bca8949b-e2bd-4515-98fd-70d3049a0097@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <f4074ec4-9068-425f-8b11-4b49e1d2ede7@RTEXMBS04.realtek.com.tw>
Date: Wed, 31 Jul 2024 14:09:16 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> "iw dev wlp2s0 station dump" shows incorrect rx bitrate:
> 
> tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
> rx bitrate:     86.7 MBit/s VHT-MCS 9 VHT-NSS 1
> 
> This is because the RX band width is calculated incorrectly. Fix the
> calculation according to the phydm_rxsc_2_bw() function from the
> official drivers.
> 
> After:
> 
> tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
> rx bitrate:     390.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 1
> 
> It also works correctly with the AP configured for 20 MHz and 40 MHz.
> 
> Tested with RTL8822CE.
> 
> Cc: stable@vger.kernel.org
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

a71ed5898dfa wifi: rtw88: 8822c: Fix reported RX band width
0129e5ff2842 wifi: rtw88: 8703b: Fix reported RX band width

---
https://github.com/pkshih/rtw.git


