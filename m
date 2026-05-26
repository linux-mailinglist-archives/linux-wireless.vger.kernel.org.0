Return-Path: <linux-wireless+bounces-36895-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKRQCQUKFWpPSQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36895-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 04:48:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3AC5D0158
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 04:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F4323058BA0
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 02:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107D30AAA6;
	Tue, 26 May 2026 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KiafQFu7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4FC54739
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763444; cv=none; b=ce9Ntt0CMVaYFQYs3iqFFbhBK0cqOcmobIb7J6Qxs4fSgUTZoR0vipbepbXX0BWEgH4+MS5WhHovwQLilka/QwH/FtXcG9/PwsgFGQCrzH7Ra78rjfsJEq3iW8ZWuAl+73N+ZivTXmdUc37gmFYn8a1iThxTuzw8VUVn/GPPpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763444; c=relaxed/simple;
	bh=e8Pkhe/baXo3eTcZM9TAtcCQMvaz0StLuIphh95Cedo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qbmAHzuWcxQB/JaYUSTGrlDYeOcWCdupMdNjIo4FpHNiplwhKAUxVJcATDrA97Ic7DEWXrYihc8LYlpQ2gGT1F3aoCfM8qmb0CiJTUf15/Vlzl0L+jYx4oHqasUi6oFLycE7ONz6MiyUn4hTZHDD4KTZ7aEpBrki/10ijOkQOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KiafQFu7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64Q2hTyxD1451350, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779763410; bh=VTChcgHDztyJQUCJM6/P9otx+U4R3aryo5+/vyvpXEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KiafQFu7RxGw3w2f4pr4d0w2TEdH+KVOj70fT0ev5jgIkS5UhcNVpyJl+zoA5iYAH
	 THfhitQIaYaSO3HNylkqSsmxj3jO8baCN9PbLJnUCN1dOalmIQlHKvDt6fRQll7J2t
	 gPuq9u97ZKZQ7qtz8C/uwEQG2ox1zL2UZrvDhhJsbkJyh5rdwPkH2XF7uKJXjItbFo
	 AphJrih1ZSJn24iM7DgSSzZhVd/h2cFlt2GJ6bLELQVvMnfuWN9YTKd2FIwjg+kqLQ
	 HcGoGMJG+t3iXD6eGpSJ7Np43ZgqM4tpqffzq/1Eceuo5DWRp9Z7uI0bLBz8jfnJff
	 8YWBecU4ldyYA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64Q2hTyxD1451350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 10:43:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 May 2026 10:43:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 May 2026 10:43:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 26 May 2026 10:43:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ren Wei <n05ec@lzu.edu.cn>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>, "nbd@openwrt.org"
	<nbd@openwrt.org>, "linville@tuxdriver.com" <linville@tuxdriver.com>,
	"yuantan098@gmail.com" <yuantan098@gmail.com>, "zcliangcn@gmail.com"
	<zcliangcn@gmail.com>, "bird@lzu.edu.cn" <bird@lzu.edu.cn>,
	"xuyuqiabc@gmail.com" <xuyuqiabc@gmail.com>
Subject: RE: [PATCH 1/1] wifi: mac80211: validate minstrel HT tx status rates
Thread-Topic: [PATCH 1/1] wifi: mac80211: validate minstrel HT tx status rates
Thread-Index: AQHc7DeV3sPtUhGHxkSnMfCWt+PfS7YfmbhQ
Date: Tue, 26 May 2026 02:43:28 +0000
Message-ID: <710745062b5f4323a233db0cd4288ced@realtek.com>
References: <cover.1779619788.git.xuyq21@lenovo.com>
 <0e3f97ca5cfbeb67a8e60ca5c266f4335950816b.1779619788.git.xuyq21@lenovo.com>
In-Reply-To: <0e3f97ca5cfbeb67a8e60ca5c266f4335950816b.1779619788.git.xuyq21@lenovo.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,openwrt.org,tuxdriver.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-36895-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:mid,realtek.com:dkim,lzu.edu.cn:email];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7B3AC5D0158
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ren Wei <n05ec@lzu.edu.cn> wrote:
> @@ -1205,8 +1242,9 @@ minstrel_ht_txstat_valid(struct minstrel_priv *mp, =
struct minstrel_ht_sta *mi,
>         if (!rate->count)
>                 return false;
>=20
> -       if (rate->flags & IEEE80211_TX_RC_MCS ||
> -           rate->flags & IEEE80211_TX_RC_VHT_MCS)

Miss a line?
- 		return true;


> +       if (rate->flags & IEEE80211_TX_RC_MCS ||
> +           rate->flags & IEEE80211_TX_RC_VHT_MCS)
> +               return minstrel_ht_txstat_valid_rate(rate);
>=20
>         for (i =3D 0; i < ARRAY_SIZE(mp->cck_rates); i++)
> @@ -1235,8 +1273,9 @@ minstrel_ht_ri_txstat_valid(struct minstrel_priv *m=
p,
>         if (!rate_status->try_count)
>                 return false;
>=20
> -       if (rate_status->rate_idx.flags & RATE_INFO_FLAGS_MCS ||
> -           rate_status->rate_idx.flags & RATE_INFO_FLAGS_VHT_MCS)

Miss a line?

-		return true;

> +       if (rate_status->rate_idx.flags & RATE_INFO_FLAGS_MCS ||
> +           rate_status->rate_idx.flags & RATE_INFO_FLAGS_VHT_MCS)
> +               return minstrel_ht_ri_txstat_valid_rate(&rate_status->rat=
e_idx);
>=20
>         for (i =3D 0; i < ARRAY_SIZE(mp->cck_rates); i++) {
> --
> 2.54.0
>=20


