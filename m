Return-Path: <linux-wireless+bounces-32342-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE60GSg7pWmk6QUAu9opvQ
	(envelope-from <linux-wireless+bounces-32342-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 08:24:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A34F1D3DAC
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 08:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76FED3008C17
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 07:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3386A331222;
	Mon,  2 Mar 2026 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ROzZ2e5a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4810B325727;
	Mon,  2 Mar 2026 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436262; cv=none; b=TKC/77vfKpwWjWqWl4HUuuvDa0ULBmpFuKaI4BDofW1rkj5u/2XhtVYZuTt4KpWYO3PqdY+7qW+sP3nYt8/hkCgFStSObMPgYav9SnRh2gSAoS1owrASzTHS9+61OrBDIXFp+w2V2do8tLIVao2lBRNw2nAXPK274qlQrfEKKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436262; c=relaxed/simple;
	bh=QvV7u1kU3vgCvoJAEpTW3dtmOiQ5Ty2QZf1wgrkbjqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B7nYi7euoitBDhgr7GXJCjI0DP5gi970Ti+GVc+m+3kyKko82hfsXfZglBargtZ7gFVLkmyrY6uoNTDhbuloL6wJsIVkAeT3PG+N8dKlqCDQ9kh3Z5SW+mMD/5dEerYLlfhYcclUaq0SQbyGYcEsf+naNwFVxeqLzgeULJHtZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ROzZ2e5a; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6227NlmE62608399, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772436227; bh=OS+90uRenSgs6qHRbKAAFIpAApTNW3jar5s3/YyQdss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ROzZ2e5a1Ku01gxJCZx6nZPjLFEycHCxD1caRyS4gsJ6vTFX/QjbxSl56GVYjNY6G
	 nmGmeiCkw2iR6LhRSixsMIr0defhc1KuryMb3KXYjABiPL2oymPOlgdawCoEzuH4ij
	 HhWExUByKMBh2m7roC3ZC8KTIQbxAK6C7+3fjsLSOjyELXaKORoMRqzo2c3zEO2BIg
	 BQsQDyx96Fq9sOQNrRvjn4+a5CDTuiqLk1OZGon6JlQZAHbqj9yfNXiyWZahV9Szzl
	 9FrQETkUXVGB2Zvr1ysBF6YuQXjuzpqL6B73RwGHpPPuFUJnJTeI41hG+4dGYKPdlM
	 5xWxBfjJ//eJg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6227NlmE62608399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 15:23:47 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Mar 2026 15:23:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Mar 2026 15:23:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 2 Mar 2026 15:23:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yi Cong <cong.yi@linux.dev>,
        "Jes.Sorensen@gmail.com"
	<Jes.Sorensen@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Yi Cong
	<yicong@kylinos.cn>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtl8xxxu: fix potential use of uninitialized value
Thread-Topic: [PATCH] wifi: rtl8xxxu: fix potential use of uninitialized value
Thread-Index: AQHcp7wo19YFLWqbikuAFiZ5VGUVYrWa2Sag
Date: Mon, 2 Mar 2026 07:23:47 +0000
Message-ID: <96e31963da0c42dcb52ce44f818963d7@realtek.com>
References: <20260227073708.508772-1-cong.yi@linux.dev>
In-Reply-To: <20260227073708.508772-1-cong.yi@linux.dev>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32342-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email,realtek.com:mid,realtek.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A34F1D3DAC
X-Rspamd-Action: no action

Yi Cong <cong.yi@linux.dev> wrote:
> From: Yi Cong <yicong@kylinos.cn>
>=20
> The local variables 'mcs' and 'nss' in rtl8xxxu_update_ra_report() are
> passed to rtl8xxxu_desc_to_mcsrate() as output parameters. If the helper
> function encounters an unhandled rate index, it may return without settin=
g
> these values, leading to the use of uninitialized stack data.
>=20
> Initialize 'mcs' to 0 and 'nss' to 1 at declaration to ensure safe defaul=
ts
> (MCS 0, 1 spatial stream) are used even if parsing fails. Note that 'nss'
> must be at least 1 to be valid.
>=20
> Fixes: 7de16123d9e2 ("wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index 794187d28caa..d0035960f8d4 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -4820,7 +4820,7 @@ static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv =
*priv, u8 slot_time)
>  void rtl8xxxu_update_ra_report(struct rtl8xxxu_ra_report *rarpt,
>                                u8 rate, u8 sgi, u8 bw)
>  {
> -       u8 mcs, nss;
> +       u8 mcs =3D 0, nss =3D 1;
>=20
>         rarpt->txrate.flags =3D 0;

With ` rarpt->txrate.flags |=3D RATE_INFO_FLAGS_MCS;` in rtl8xxxu_update_ra=
_report(),=20
I believe rtl8xxxu can only support HT rate, so no need 'nss' which is for =
VHT rate.=20

I think the correct fix is something like=20

if (rate <=3D DESC_RATE_54M) {
		// does something as current
} else if (rate >=3D DESC_RATE_MCS0 && rate <=3D DESC_RATE_MCS15) {
		mcs =3D rate - DESC_RATE_MCS0;

		// and HT flags
} else {
		return; // do nothing for unexpected rate
}

// fill common flags for legacy and HT rate.=20



