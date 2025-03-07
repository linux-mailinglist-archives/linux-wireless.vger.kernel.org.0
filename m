Return-Path: <linux-wireless+bounces-19974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D1A55D79
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 03:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C36D7A5222
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 02:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD3963CF;
	Fri,  7 Mar 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Dx7VkF05"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2055897
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313249; cv=none; b=aFq5oFXcY6nik32pKBUOlN15d3x/dzx1pUCP2uFML3WxBALVfdbL3+qH3CvLyXzHzg9nXkF44TQq8BAklwKLuKQbxC2+VkVEzhkGbohZPLJgZYF22o5Uj/VEhPQrUazllo408OgFRwaxiP+QpzM6Q0p3HcnfI3hvzVnhW8Gwdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313249; c=relaxed/simple;
	bh=G1UzyC1VxIoVG8gSbBIIf+7L0W+iBJ3Lf0jf67T6GdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=APotaevr9Ft75Q40q5vRs3oAmBWKsqnN/4hI3zX5eOM8mE9RSckeoue4cxBHxS1LBC6pUqQd+dpL95S83rUk6jYTaE1A5H+VrB0wAzC3opzUfHWBHZ/Eo0/ofqJ0zL0rFNeI7w1hmXoh7tzYuI5jJlvVYdKtxhRwx8ehx1xErm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Dx7VkF05; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52727BHo8189541, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741313231; bh=G1UzyC1VxIoVG8gSbBIIf+7L0W+iBJ3Lf0jf67T6GdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Dx7VkF059qqX4Ktdx41kGhU+Cl152jjL+cGh2ktEj/y3KNb5X0ZxUC2+Zq4qcONck
	 YTRBas+OA6oiijAN5cJqwvHq4bWAp5T1s9zFDklol6ppf+bReUy7XPEfpYAOnSb9kg
	 GqRDKPQSlg58+WB9zXpUrpXaZro5+hUNi8HjFJiOgfJsRaIYvh+GkGlt/PQOEOlhXx
	 oGgp98gzh4M2tdphXSSac9pxLmT7O6MQr+bwoIrYtiocTut3locc8zczh7TYv0rDpj
	 h/I5obj9UgZOwVA397SjLIWFD8eDsl6Zrbqr1bi0IfxW9UI7RQTs7mLJpC64ShAxR0
	 8w2HWVRppf8Mw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52727BHo8189541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 10:07:11 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Mar 2025 10:07:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 7 Mar 2025 10:07:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 7 Mar 2025 10:07:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ilan
 Peer" <ilan.peer@intel.com>
Subject: RE: [PATCH wireless-next 11/15] wifi: cfg80211: Update the link address when a link is added
Thread-Topic: [PATCH wireless-next 11/15] wifi: cfg80211: Update the link
 address when a link is added
Thread-Index: AQHbjoTKbmHtT4miCEyW1AHCshD3RrNm69Kw
Date: Fri, 7 Mar 2025 02:07:10 +0000
Message-ID: <756726fac4484a1e862f0f4186691795@realtek.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
 <20250306124057.6ae37b21922b.I79b010ea9aab47893e4f22c266362fde30b7f9ac@changeid>
In-Reply-To: <20250306124057.6ae37b21922b.I79b010ea9aab47893e4f22c266362fde30b7f9ac@changeid>
Accept-Language: en-US, zh-TW
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

Miri Korenblit <miriam.rachel.korenblit@intel.com> wrote:
> From: Ilan Peer <ilan.peer@intel.com>
>=20
> When links are added, update the wireless device link addresses based
> on the information provided by the driver.
>=20
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>  include/net/cfg80211.h | 1 +
>  net/wireless/mlme.c    | 4 ++++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 6f76059c0aa5..558dc88b9f07 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -9771,6 +9771,7 @@ struct cfg80211_mlo_reconf_done_data {
>         u16 added_links;
>         struct {
>                 struct cfg80211_bss *bss;
> +               u8 *addr;

Should swap order of patch 12/15, which does assign addr?

At first glance, this patch doesn't set addr and callee does memcpy(), whic=
h
kernel will raise NULL pointer dereference exception.

And there are two callers, but patch 12/15 only set one of them.

mac80211/mlme.c:3896:           cfg80211_mlo_reconf_add_done(sdata->dev, &d=
one_data);
mac80211/mlme.c:10125:  cfg80211_mlo_reconf_add_done(sdata->dev, &done_data=
);

>         } links[IEEE80211_MLD_MAX_NUM_LINKS];
>  };
>=20
> diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> index 956d33b219df..05d44a443518 100644
> --- a/net/wireless/mlme.c
> +++ b/net/wireless/mlme.c
> @@ -1360,6 +1360,10 @@ void cfg80211_mlo_reconf_add_done(struct net_devic=
e *dev,
>                 if (data->added_links & BIT(link_id)) {
>                         wdev->links[link_id].client.current_bss =3D
>                                 bss_from_pub(bss);
> +
> +                       memcpy(wdev->links[link_id].addr,
> +                              data->links[link_id].addr,
> +                              ETH_ALEN);
>                 } else {
>                         cfg80211_unhold_bss(bss_from_pub(bss));
>                         cfg80211_put_bss(wiphy, bss);
> --
> 2.34.1
>=20


