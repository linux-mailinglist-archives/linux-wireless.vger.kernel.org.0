Return-Path: <linux-wireless+bounces-25776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C102B0CFE4
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 04:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503641C2014C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410AD2737F0;
	Tue, 22 Jul 2025 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dfvfksXh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8A272E6B
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 02:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152650; cv=none; b=ehSfLTNqbuyyH7S3bJaFPbdvZOrAJmjY8CJ4Ne1lAhQf9iWc1OrOdzDwowjZbwVkCLBC4KgsI9nwN1LsTG9ObHOY7+VFv8DuqyIfHiChlieXwUbC1n3ZgFj9+44FnkPfc6PU0BqCEo1Ndiit+U0bU7Gzl5GSnAlIymOlZAIxghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152650; c=relaxed/simple;
	bh=RShgkAEIQhcrGRqpmu8K05ffuWJ5ePpMFetbCDkAHf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W1hgrd9D4wGQ0ZvM0ICC4HZYouf15XE8XtcbUHI8d864/H6sPOetp814PyqEyGFdXHRTyLWI45ftQVLz2mk7vIRIr2mB8/L/MlnWRmj8r+fkljoM2r/z+NLGmKb9FGUlR2L536ktwmboagiMvVUzrzul9XgKztaSmTiELNeLLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dfvfksXh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56M2obQP3218062, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753152637; bh=YP7fsOqM8NabPsalHZIEM+I/MqsFQaK4epKgpcrJmqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dfvfksXhzfwvGBalY+f0rHhDn+42n0brBTf4Rhy36Vw9Wm1LErW4+rtB+rJ4Q/hJ0
	 pPDo6DZjBs5y+v2zUBBcZRMAaAdfBBcmOPnaW7CjdkUsPG0/5z5uUTI6Q0dm6ibZBm
	 ZWC3vQT3nhGFqdejOFpmaqVehl5M0ksxsnqxB0XaPg4lqXqzrFl3VU0nE2eeHVljzf
	 yA7zsQ6Via6dixggB0nDGsXLrrNblH0SyR9BQXSuQ3sJ7fKU20wyWle1QGtDcOPCoY
	 2jOd0ZP6jujasqs+8L1/gm3Nt4Kw8S6MxW1k3GURmWU0dIN0kTGqwyGGk/a61x1fUt
	 LVTOOiYY29qXA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56M2obQP3218062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:50:37 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 10:50:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 22 Jul 2025 10:50:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Tue, 22 Jul 2025 10:50:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
Subject: RE: [PATCH wireless-next v2 1/1] wifi: mac80211: don't require cipher and keylen in gtk rekey
Thread-Topic: [PATCH wireless-next v2 1/1] wifi: mac80211: don't require
 cipher and keylen in gtk rekey
Thread-Index: AQHb+nB2/BAQjh3uPkitHqmUw+fPrLQ9cV6w
Date: Tue, 22 Jul 2025 02:50:36 +0000
Message-ID: <5bb337eb86924d538939b4bb967289a2@realtek.com>
References: <20250721185049.634010-1-miriam.rachel.korenblit@intel.com>
 <20250721214922.3c5c023bfae9.Ie6594ae2b4b6d5b3d536e642b349046ebfce7a5d@changeid>
In-Reply-To: <20250721214922.3c5c023bfae9.Ie6594ae2b4b6d5b3d536e642b349046ebfce7a5d@changeid>
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


> diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wirel=
ess/realtek/rtw89/wow.c
> index 071c7577df52..5bb7c1a42f1d 100644
> --- a/drivers/net/wireless/realtek/rtw89/wow.c
> +++ b/drivers/net/wireless/realtek/rtw89/wow.c
> @@ -619,9 +619,12 @@ static struct ieee80211_key_conf *rtw89_wow_gtk_reke=
y(struct rtw89_dev *rtwdev,
>                flex_array_size(rekey_conf, key, cipher_info->len));
>=20
>         if (ieee80211_vif_is_mld(wow_vif))
> -               key =3D ieee80211_gtk_rekey_add(wow_vif, rekey_conf, rtwv=
if_link->link_id);
> +               key =3D ieee80211_gtk_rekey_add(wow_vif, keyidx, gtk,
> +                                             cipher_info->len,
> +                                             rtwvif_link->link_id);
>         else
> -               key =3D ieee80211_gtk_rekey_add(wow_vif, rekey_conf, -1);
> +               key =3D ieee80211_gtk_rekey_add(wow_vif, keyidx, gtk,
> +                                             cipher_info->len, -1);
>=20
>         kfree(rekey_conf);

For the rtw89 part, the local allocate/free instance of rekey_conf
isn't used anymore. Please remove it by the way.=20

>         if (IS_ERR(key)) {



