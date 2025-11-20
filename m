Return-Path: <linux-wireless+bounces-29153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7158C72E47
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 09:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73F67357290
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C152FFDE8;
	Thu, 20 Nov 2025 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qC5x85uN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BCF2F7444;
	Thu, 20 Nov 2025 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627149; cv=none; b=Q3tuSaYSjuJo3Pg5l4RNUOVfVALKXWD4Fz1zs3xYWNgY+FLa2m2cQREwMD5jaKg4evq4bjpIcaT8bo1hyt7+peC2IxBoeQYEqc61NtiXy2oi4Eb8tGD0YyvldzVj2ZoELKWRq3NFbOYnejaLO6NC2PMPQl9X4cFewTbOibDvgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627149; c=relaxed/simple;
	bh=vTZn5quikOo6Zz0fos7YxdsIP/l0nYwGiQhnloFUTcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zk/lIHuD6hJiCz5XGsKYBxaeJVjmn6nlZ9UOfryd65snYltU3WLHngK0cG+FRUABFlkJ+/zwjAM2J/jJqcsFu+YCgMiUoFrXKNIJcwN9E+TsBXxUvMRShFDLBktIet06Ax6ewdJAHfWjS+LYeaPj0IhuoLkK7YyBy3hBQnAj+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qC5x85uN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AK8PX0Y01147783, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763627133; bh=fQ3YbzFrICsU7Gj87FQNi8OEAsRyGIYyyzVSGYHWRgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qC5x85uN3b8VK/2sUucgKc60FZvoA5SWxTofPBKaK70KiEkO0Nntm0pCkPHeTwIHa
	 D2i9q+YiQDCW0PRBuyi9zQCoppwANQDkpyvvEU3/SpAaFbpkq1gccYluOXs6dYtE0o
	 obNGPqhvGjtmXmaxyz69YAJm2mMHENQ5po5E499hwmWqIQj2hQXuyg3SgRhRx5bmrZ
	 dWVPNqrjoizCIWeQeh0usOmXhY1pBNtPto6pT4Lj3o/cv68g2c7mgH1eAaapxt+dqZ
	 0+GM/8nrCGiXgbmoExDSKx3OBO6lU1YTpyaYlax+KTggkY0+4noNwfsmZw4QaC/Vfc
	 j9N+8rTJq18jA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AK8PX0Y01147783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 16:25:33 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 16:25:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 16:25:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Thu, 20 Nov 2025 16:25:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Gongwei Li <13875017792@163.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gongwei Li
	<ligongwei@kylinos.cn>
Subject: RE: [PATCH 1/1] wifi: rtw89: Add missing NULL check before
 __skb_unlink
Thread-Topic: [PATCH 1/1] wifi: rtw89: Add missing NULL check before
 __skb_unlink
Thread-Index: AQHcWfX9uFUIFmm9pkmYJdrxZbiBf7T7ONog
Date: Thu, 20 Nov 2025 08:25:33 +0000
Message-ID: <1a3cf60e3d52472894bd98369699ee03@realtek.com>
References: <20251120081623.1273490-1-13875017792@163.com>
In-Reply-To: <20251120081623.1273490-1-13875017792@163.com>
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

Gongwei Li <13875017792@163.com> wrote:
> From: Gongwei Li <ligongwei@kylinos.cn>
>=20
> __skb_unlink(skb, list)) attempt to access skb->next,
> triggering a NULL pointer dereference (Kernel Panic).
>=20
> [  541.001831][ 7] [  T273] Unable to handle kernel NULL pointer derefere=
nce at
> virtual address 0000000000000000
> [  541.011776][ 7] [  T273] Mem abort info:
> [  541.015697][ 7] [  T273]   ESR =3D 0x96000046
> [  541.019873][ 7] [  T273]   EC =3D 0x25: DABT (current EL), IL =3D 32 b=
its
> [  541.026302][ 7] [  T273]   SET =3D 0, FnV =3D 0
> [  541.030476][ 7] [  T273]   EA =3D 0, S1PTW =3D 0
> [  541.034733][ 7] [  T273] Data abort info:
> [  541.038734][ 7] [  T273]   ISV =3D 0, ISS =3D 0x00000046
> [  541.043689][ 7] [  T273]   CM =3D 0, WnR =3D 1
> [  541.047779][ 7] [  T273] user pgtable: 4k pages, 39-bit VAs, pgdp=3D00=
00002610943000
> [  541.055341][ 7] [  T273] [0000000000000000] pgd=3D0000002610948003,
> pud=3D0000002610948003, pmd=3D0000000000000000
> [  541.065173][ 7] [  T273] Internal error: Oops: 96000046 [#1] SMP
>=20
> [  541.220794][ 7] [  T273] Workqueue: phy0 rtw89_fw_c2h_work [rtw89_core=
]
> [  541.227407][ 7] [  T273] pstate: 20001089 (nzCv daIf -PAN -UAO)
> [  541.233339][ 7] [  T273] pc : skb_unlink+0x68/0xa0
> [  541.238164][ 7] [  T273] lr : rtw89_fw_c2h_work+0x3c/0x88 [rtw89_core]
> [  541.244686][ 7] [  T273] sp : ffffffa6c998bd40
> [  541.249124][ 7] [  T273] x29: ffffffa6c998bd40 x28: ffffffa6db4ad200
> [  541.255558][ 7] [  T273] x27: ffffffa6dc810000 x26: 0000000000000000
> [  541.261996][ 7] [  T273] x25: ffffffa6dc810090 x24: 0000000000000000
> [  541.268432][ 7] [  T273] x23: ffffffa6da902be0 x22: ffffffa6da903140
> [  541.274877][ 7] [  T273] x21: 0000000000000000 x20: ffffffa6ca2a2900
> [  541.281313][ 7] [  T273] x19: ffffffa6da903970 x18: 0000000000000000
> [  541.287749][ 7] [  T273] x17: 0000007fb74284b8 x16: 0000000000415090
> [  541.294184][ 7] [  T273] x15: 000000007fffffde x14: ffffffa59082bc1b
> [  541.300620][ 7] [  T273] x13: ffffffa59082bb16 x12: ffffffa59082bbfa
> [  541.307058][ 7] [  T273] x11: 0000000000000000 x10: ffffffff9b08a8a0
> [  541.313494][ 7] [  T273] x9 : 0000000000000000 x8 : 0000000000000000
> [  541.319928][ 7] [  T273] x7 : 0000000000000000 x6 : ffffffa6ca2a2600
> [  541.326363][ 7] [  T273] x5 : 0000000000000060 x4 : 0000000000000000
> [  541.332796][ 7] [  T273] x3 : 0000000000000001 x2 : 0000000000000000
> [  541.339229][ 7] [  T273] x1 : ffffffa6ca2a3600 x0 : 0000000000000000
> [  541.345666][ 7] [  T273] Call trace:
> [  541.349254][ 7] [  T273]  skb_unlink+0x68/0xa0
> [  541.353720][ 7] [  T273]  rtw89_fw_c2h_work+0x3c/0x88 [rtw89_core]
> [  541.359907][ 7] [  T273]  process_one_work+0x1c0/0x340
> [  541.365050][ 7] [  T273]  worker_thread+0x4c/0x488
> [  541.369845][ 7] [  T273]  kthread+0xf8/0x128
> [  541.374117][ 7] [  T273]  ret_from_fork+0x10/0x18
> [  541.378817][ 7] [  T273] Code: b9001260 a9400281 a9007e9f f9000420 (f9=
000001)
> [  541.386039][ 7] [  T273] ---[ end trace 1c8ff29ce038612f ]---

Should not add timestamp in commit message.

>=20
> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
> ---
>  drivers/net/wireless/realtek/rtw89/fw.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wirele=
ss/realtek/rtw89/fw.c
> index ab904a7de..d00e97eb4 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -6895,6 +6895,8 @@ void rtw89_fw_c2h_work(struct wiphy *wiphy, struct =
wiphy_work *work)
>         lockdep_assert_wiphy(rtwdev->hw->wiphy);
>=20
>         skb_queue_walk_safe(&rtwdev->c2h_queue, skb, tmp) {
> +               if (unlikely(!skb->next || !skb->prev))
> +                       return;
>                 skb_unlink(skb, &rtwdev->c2h_queue);
>                 rtw89_fw_c2h_cmd_handle(rtwdev, skb);
>                 dev_kfree_skb_any(skb);

We sent patch [1] to fix this problem, but it is not upstream yet.
Please try if [2] can work to your site.=20

[1] https://lore.kernel.org/linux-wireless/20251021133402.15467-2-pkshih@re=
altek.com/
[2] https://github.com/pkshih/rtw.git rtw-next


