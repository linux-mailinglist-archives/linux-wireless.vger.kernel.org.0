Return-Path: <linux-wireless+bounces-23482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF100AC75BB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 04:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8394E1AEF
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 02:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07DE24466C;
	Thu, 29 May 2025 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Y5c6fJnI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C9242D9C;
	Thu, 29 May 2025 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484912; cv=none; b=WcRhTMUoksgQ2EEsouooe6b7IWsNhonzYFL/2Fb8xn5BBHR/iZszb+rN/847R+HI7Zxrf5w+oP/Hg0ysmnaw1xFj88SqwTC+M3VRllEEZA+Rdaeu9MaEVAEJPsM+hqHwpXEnbK4vcxYEVxG1Ce4v4w1bpqsQ1HLmKmPlMjeQ26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484912; c=relaxed/simple;
	bh=EoxXfjqQJa+uHDl+0+Ut+pp+gFvEpTPo9s3CoiFDFzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nA92BOszu09ZsepbDgG6S1pHW1byvIBnil4Tv0sMkrJzDJ/m6WMJO4g+FdG0thC9KdqbJh7AvXCGAzGJX4bZpw9n3yYo7I/BeI6K7hgl+CK1u9UCGduDmxpRPRyqUZghKVpoBFrJcLIQUOaJtXgjVWsVEvD8HWP7rGm9An/mgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Y5c6fJnI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54T2F4rtC641728, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748484904; bh=RZOIfzAkp8jg2F0xwhigrEjaJYkmXDcOlNoLliD4Q44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Y5c6fJnI215YLOiajTcZXpYCi34dwERe1Vz/RI2/TprWzYfznsYSJNe4j0JVBFAgp
	 IgWoogKTKtGNb46xKtWzarzaFv6S+2uaXrAx7iGx0/Z6hF87qLf8v7/0J/X/YLMocV
	 w4w+GBXUFqpx772ymVH5zKzkt0UubqDKDvHUNlLbizMQp3LxSdIdE8Wyo5LcBTPCIA
	 CozFTBy6R5OW/c5Ps+yAActBQVMly56pY57efp9PvEGGOBWajQNm5UIyHf4ngORRw9
	 kSYneRG8ST4YmMcprsQRreTKM/SThFtDqvaM9b9hNcBY/CPqYaocNZguj6LEuRTDjJ
	 pb/ABesh6oMzg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54T2F4rtC641728
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 10:15:04 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 May 2025 10:15:04 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 May 2025 10:15:03 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::dd06:104c:e04d:a488]) by
 RTEXMBS03.realtek.com.tw ([fe80::dd06:104c:e04d:a488%2]) with mapi id
 15.01.2507.035; Thu, 29 May 2025 10:15:03 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v2 next] wifi: rtw89: mcc: prevent shift wrapping in rtw89_core_mlsr_switch()
Thread-Topic: [PATCH v2 next] wifi: rtw89: mcc: prevent shift wrapping in
 rtw89_core_mlsr_switch()
Thread-Index: AQHbz6gTUgII+UrlxUO/ACeh6NJnC7Po3Hwg
Date: Thu, 29 May 2025 02:15:03 +0000
Message-ID: <a46c420109f0440a987d28c531dd39d6@realtek.com>
References: <aDbFFkX09K7FrL9h@stanley.mountain>
In-Reply-To: <aDbFFkX09K7FrL9h@stanley.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Dan Carpenter <dan.carpenter@linaro.org> wrote:
>=20
> The "link_id" value comes from the user via debugfs.  If it's larger than=
 BITS_PER_LONG then
> that would result in shift wrapping and potentially an out of bounds acce=
ss later.  In fact, we
> can limit it to IEEE80211_MLD_MAX_NUM_LINKS (15).
>=20
> Fortunately, only root can write to debugfs files so the security impact =
is minimal.
>=20
> Fixes: 9dd85e739ce0 ("wifi: rtw89: debug: add mlo_mode dbgfs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Use IEEE80211_MLD_MAX_NUM_LINKS as a limit instead of BITS_PER_LONG.
> It's stricter and also more informative.
>=20
>  drivers/net/wireless/realtek/rtw89/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c
> b/drivers/net/wireless/realtek/rtw89/core.c
> index 49447668cbf3..3604a8e15df0 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -5239,7 +5239,8 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev=
, struct
> rtw89_vif *rtwvif,
>         if (unlikely(!ieee80211_vif_is_mld(vif)))
>                 return -EOPNOTSUPP;
>=20
> -       if (unlikely(!(usable_links & BIT(link_id)))) {
> +       if (unlikely(link_id >=3D IEEE80211_MLD_MAX_NUM_LINKS ||
> +                    !(usable_links & BIT(link_id)))) {
>                 rtw89_warn(rtwdev, "%s: link id %u is not usable\n", __fu=
nc__,
>                            link_id);
>                 return -ENOLINK;
> --
> 2.47.2

It looks good to me.
Thank you.

