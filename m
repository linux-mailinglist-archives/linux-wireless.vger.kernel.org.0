Return-Path: <linux-wireless+bounces-34746-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEw0NoDd3mkEKQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34746-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 02:36:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A5E3FF525
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 02:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45A5303FFEF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 00:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B11A9F90;
	Wed, 15 Apr 2026 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZuRBlGvJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91FE7083C
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776213373; cv=none; b=QXzrRcEEmBN81SKoBnd/QICSRQmZaEDGKROxId9J3+Pt0Bn4biTzepHa1kYEAycg38p9/c2eK+VrnUz2bdYecvt/tr/ulL8iFtuMi6cTGlMIgeGm9olwL3c3vqh91Epx64ExKjsRAOtHTppSEbKAA2BqDRnduF3A3qJJrUoSEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776213373; c=relaxed/simple;
	bh=Um44k5/jNc0ScUxXZt7fkbWARH0ZkVnX6I6WysSkWaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ulVKTJqixvW+j8+xKYefoYTTrXNRBtn662+DM+yBVO9abM6EHQMbL52NvY3EZgIiv3bipKtxDJnXGQWvEmuG12TYR7vEsJNIS+o6F9gqomZaS4HsrEWZXzsW2Ar6l8gcaZgMBXE8zeYHYml2dDjdQxntra1FnaprEcCo9wVcFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZuRBlGvJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63F0a6Ui93004204, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776213366; bh=3ExoplBJGJcx1xBzDIfwi90iDlfq0eFheIZmSaE8sG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZuRBlGvJ1wMIW/Kwf2iGEEJNK8wy9ttO8DAIIP/st4TtcMvDfJ04H4r87uorXLzMb
	 66BslwDTl6zekD4dNpw6R43NNBqHkOpmpP33yO9pPFry1+FUlHAQaQPemwtzM5ZzMS
	 LpwrNS4bS9hJLftBmvn9W9MAaERBVhWxAjR3NVT1des7YdXv/ivPtWrwqs61cml3qS
	 5uyw18ys0VVk7i1UhiXAv6xquQDVxLKLNs9qDT+ER1sR9rG0L/4IANviIG9yVJJQ3U
	 KQkBC5xwScEJVK4r4SCj42fl9TFta3ph3DszvaYrXaZU2rOh0fPTyVDHjyUZ57C/Rh
	 +a032ZGVeYQVg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63F0a6Ui93004204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 08:36:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 15 Apr 2026 08:36:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Wed, 15 Apr 2026 08:36:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Oleksandr Havrylov <goainwo@gmail.com>
Subject: RE: [PATCH v2] wifi: rtw88: Add NULL check for chip->edcca_th
Thread-Topic: [PATCH v2] wifi: rtw88: Add NULL check for chip->edcca_th
Thread-Index: AQHczEehEZqg3uvos0CfGwprUhUSrbXfRWlA
Date: Wed, 15 Apr 2026 00:36:06 +0000
Message-ID: <efc1c1c91b81447a8ca8f9b1d087b371@realtek.com>
References: <20260413100249.28618-1-npetrakopoulos2003@gmail.com>
 <20260414194757.163339-1-npetrakopoulos2003@gmail.com>
In-Reply-To: <20260414194757.163339-1-npetrakopoulos2003@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34746-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ail.com:url]
X-Rspamd-Queue-Id: 30A5E3FF525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com> wrote:
>=20
> It was recently reported that rtw_fw_adaptivity_result()
> in fw.c dereferences rtwdev->chip->edcca_th without
> a NULL check. The issue is that devices with the
> 8821CE chip don't define edcca_th in their chip
> info. As a result, when rtw_fw_adaptivity_result()
> tries to dereference it, the kernel triggers an oops.
>=20
> Add a NULL check for edcca_th before dereferencing
> it in rtw_fw_adaptivity_result() in fw.c.=20

I'd point out function name in subject as=20
"wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result=
()"

> Placing
> the check at the function entry avoids logging any
> garbage values.
>=20
> This change does not address the root cause for
> this behavior, but it prevents the NULL dereference
> and the resulting oops while a more permanent solution
> is developed.
>=20
> Tested on a 8822CE chip which defines edcca_th, so
> this issue is not present on it, but it still uses
> this driver and I can verify there are no regressions.
>=20
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221286

I'd change Link tag to Closes.

> Link:
> https://lore.kernel.org/linux-wireless/CALdGYqQriS7mP0vj_rm_xvisfzFVh0hbp=
y+---48r6bodZO7tg@mail.gm
> ail.com/

I can preserve this Link, but actually the thread contains more than one
things.

> Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> v2:
>   - Move NULL check to the entry of rtw_fw_adaptivity_result() (Ping-Ke S=
hih)
>   - Drop rtw_phy_set_edcca_th() hunk; all callers define edcca_th (Ping-K=
e Shih)
>   - Change bugzilla reference from Closes: to Link: since this does not
>     address the root cause

Even this is a workaround, I think we can still use Closes and mark the
bugzilla resolved.=20

>=20
>  drivers/net/wireless/realtek/rtw88/fw.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wirele=
ss/realtek/rtw88/fw.c
> index 48207052e3f8..945fedcd375b 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> @@ -279,6 +279,9 @@ static void rtw_fw_adaptivity_result(struct rtw_dev *=
rtwdev, u8 *payload,
>         const struct rtw_hw_reg_offset *edcca_th =3D rtwdev->chip->edcca_=
th;
>         struct rtw_c2h_adaptivity *result =3D (struct rtw_c2h_adaptivity =
*)payload;
>=20
> +       if (!edcca_th)
> +               return;
> +
>         rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY,
>                 "Adaptivity: density %x igi %x l2h_th_init %x l2h %x h2l =
%x option %x\n",
>                 result->density, result->igi, result->l2h_th_init, result=
->l2h,
> --
> 2.53.0


