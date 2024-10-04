Return-Path: <linux-wireless+bounces-13488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5C098FCC6
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 06:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DC31C22351
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 04:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7245957;
	Fri,  4 Oct 2024 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XmdwPeRc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355CF43ADE;
	Fri,  4 Oct 2024 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728017141; cv=none; b=P6RAJ7H4Qio6oIpg0hIrso1/165e6hYKg5OKpQmogbdnTFzlJP4JBLx9LZpLVI31s9nknuP5peGynwcfMkefJPc7Qtk1IRGoI222E0bwZni9mblmHtBS7luLSMU37syGVuyT3W0008sf7AWr7e4gnsq3NnHbSAIlJG5Q9Uzlgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728017141; c=relaxed/simple;
	bh=hLxLxxqcH20B8NE8c4LJhTZCLM7EwOlW3EAyKKY2aYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=muaYgTyquVKYYW9A571g3W5mJn2AmZPyo2uoeeeWRZ8tomJob8ct6zn9gSsfwsqFIrccgbDZ1ekEZcgQ0Y9kDNzPadz0yhnjHiAgMAmdhPcBAWOt49blCMdHCgIi1JUjQuCfLFMKgSYIVzwb6DAVQXAkVe61ufPOPjE/8+I4Nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XmdwPeRc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4944jLkT5899102, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728017121; bh=hLxLxxqcH20B8NE8c4LJhTZCLM7EwOlW3EAyKKY2aYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XmdwPeRccvSSI0RVPFfQ5FRciKos5hhsxdnbopYUjl3zYaS2QRCTheDmpVdd93dzS
	 kJ0rhJFxA5xHYNtd3gIJgnTsb7hJs4cDNKKoZAArC/m0R0cRnAZvRLxJ+vHSGZrJXz
	 44iXL4wg8HHU0sAoqtF330WufcRyl+aLzaG0T/sPyFDVt+BEnt+mZ3bHrbn346LQcC
	 Nxaaw4JWhaTkpr27iLu1qbGAXTHU3bPpgdEUTb39fV/Qq1dKsSzVNlKCXHe2D69sju
	 n3J/hCvAzyuH1s0dxG9PJuY/JBlh30X/nKkyUjRusvsK4rG4KE+VMISaVDorjS32tj
	 GjLEp869hTrLA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 4944jLkT5899102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 12:45:21 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 12:13:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Oct 2024 12:13:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 4 Oct 2024 12:13:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "anupnewsmail@gmail.com" <anupnewsmail@gmail.com>
Subject: RE: [PATCH] wifi: rtw89: wow: Add unlock mutex before to return
Thread-Topic: [PATCH] wifi: rtw89: wow: Add unlock mutex before to return
Thread-Index: AQHbE+I9QVaDgaDOqkyKjaFSL02uQLJ1/uyA
Date: Fri, 4 Oct 2024 04:13:42 +0000
Message-ID: <61b75a0d3b7047bb93c4abfa7de8c046@realtek.com>
References: <20241001091320.38687-1-alessandro.zanni87@gmail.com>
In-Reply-To: <20241001091320.38687-1-alessandro.zanni87@gmail.com>
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

Alessandro Zanni <alessandro.zanni87@gmail.com> wrote:
> In error handling code for "ieee80211_gtk_rekey_add failed", release
> the mutex before to return.
>=20
> Found with Coccinelle static analisys tool,
> script: https://coccinelle.gitlabpages.inria.fr/website/rules/mut.cocci
>=20
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw89/wow.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wirel=
ess/realtek/rtw89/wow.c
> index 86e24e07780d..8045acb27cf9 100644
> --- a/drivers/net/wireless/realtek/rtw89/wow.c
> +++ b/drivers/net/wireless/realtek/rtw89/wow.c
> @@ -624,6 +624,7 @@ static struct ieee80211_key_conf *rtw89_wow_gtk_rekey=
(struct rtw89_dev *rtwdev,
>         kfree(rekey_conf);
>         if (IS_ERR(key)) {
>                 rtw89_err(rtwdev, "ieee80211_gtk_rekey_add failed\n");
> +               mutex_unlock(&rtwdev->mutex);
>                 return NULL;
>         }

The driver mutex is held across this function. Only unlock before calling=20
ieee80211_gtk_rekey_add() and lock after that, because the function enters
driver again and lock mutex again causing deadlock.=20

Thus this Coccinelle finding is false alarm. NACK this patch.=20



