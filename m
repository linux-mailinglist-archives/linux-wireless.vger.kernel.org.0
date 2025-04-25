Return-Path: <linux-wireless+bounces-22034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80D6A9BE40
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E9F460A58
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 06:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034A81B0F19;
	Fri, 25 Apr 2025 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eZVvTQJH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B776C19C540;
	Fri, 25 Apr 2025 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560829; cv=none; b=VklU2ao8e9WMMVhq5b3Qfi+TwYIeuo2BUL6svpknWjZDgJrrMka1d9t6qWoMpj5ZXTD6O6sBDkSmvyipW54VJezFSkGbt9WkmDumVKJoFtucvsLhiC4RrPXckUf7xysGmqFehgSY5FKfpuivy5Rf9YmUoJ0gJLu0NSHH9CIUzh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560829; c=relaxed/simple;
	bh=KklZdxaMaK2t+GzkmjlvOLyn33H5lbCp9kBUG3gbsdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EyIyRzq4Baivw+K/t3ONX5elCn2opgFyy781u3u2XjYix2vm4HoX6Eeqg5RagWrVlDS/aO8X2Fijh8Bz58g8sLNgsfmjGvZR2QyTWEL8qUU8rqwLTWPQra/Y0SzcvXPGSDTGS+TjW1h/t+2DRXZijummccln3NLhMBaN/KyRa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eZVvTQJH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53P5xSXT12329904, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745560768; bh=KklZdxaMaK2t+GzkmjlvOLyn33H5lbCp9kBUG3gbsdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eZVvTQJH18XWIc9zJZV++hpfHPkkhKIXhyoQvgH2bw1hSPl+RU538nOgplb/o72QC
	 fYsbjKev5JncnLserer4z9FOoASMiLn+DTAYtaG4ByXa7FXdjAcNuucnmJPFLjkA0z
	 IISAze91FAPNvEtTHfUSNc+znEoCNl/S8IpgeR20GLbY5Jl0EuTW05/PRsWlfqJ+4U
	 kNQXZ+ZuH8bY3OQuoQl+QwfL4i1QJOUdA/TEGWihrjYJ3pfW96opDFA6ChqyoDd1GR
	 dHw0aFI1CGgEyIDzWVtmWaebgFyg3AXyrF0Mye4F7Y4oTnrgCynPqFsbaSyo6CMjp/
	 rsHShbTH/eHdQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53P5xSXT12329904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 13:59:28 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Apr 2025 13:59:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 25 Apr 2025 13:59:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 25 Apr 2025 13:59:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alexei Safin <a.safin@rosa.ru>, Stanislaw Gruszka <stf_xl@wp.pl>
CC: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH v2] iwlegacy: 4965: fix possible out-of-bounds access in il4965_tx_cmd_build_rate()
Thread-Topic: [PATCH v2] iwlegacy: 4965: fix possible out-of-bounds access in
 il4965_tx_cmd_build_rate()
Thread-Index: AQHbtUoyW+CeES1JwUC8udH5dJNFFbOz4pRg
Date: Fri, 25 Apr 2025 05:59:27 +0000
Message-ID: <ea0ce54e06104682b9a5d24b9bb75a91@realtek.com>
References: <20250424185244.3562-1-a.safin@rosa.ru>
In-Reply-To: <20250424185244.3562-1-a.safin@rosa.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Alexei Safin <a.safin@rosa.ru> wrote:
>=20
> Prevent out-of-bounds access in il4965_tx_cmd_build_rate() by rejecting
> rate_idx values greater than or equal to RATE_COUNT_LEGACY.
>=20
> Use a correct bounds check to avoid accessing il_rates[] with
> an invalid index. The previous comparison allowed rate_idx to become
> equal to RATE_COUNT_LEGACY, which exceeds the array limit.
>=20
> Replace the check 'rate_idx > RATE_COUNT_LEGACY' with
> 'rate_idx >=3D RATE_COUNT_LEGACY' to ensure memory safety.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 7ac9a364c172 ("iwlegacy: move under intel directory")

The Fixes is obviously wrong. It just moved the code.=20

> Signed-off-by: Alexei Safin <a.safin@rosa.ru>
> ---
> v2: change reciepent
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index 78dee8ccfebf..f60d9b9798c1 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -1572,7 +1572,7 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
>          */
>         rate_idx =3D info->control.rates[0].idx;
>         if ((info->control.rates[0].flags & IEEE80211_TX_RC_MCS) || rate_=
idx < 0
> -           || rate_idx > RATE_COUNT_LEGACY)
> +           || rate_idx >=3D RATE_COUNT_LEGACY)
>                 rate_idx =3D rate_lowest_index(&il->bands[info->band], st=
a);
>         /* For 5 GHZ band, remap mac80211 rate indices into driver indice=
s */
>         if (info->band =3D=3D NL80211_BAND_5GHZ)
> --
> 2.39.5 (Apple Git-154)
>=20


