Return-Path: <linux-wireless+bounces-34719-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOV/D5Gg3WkkhAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34719-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 04:04:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D193F4E28
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 04:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4C563010B76
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78CEF9E8;
	Tue, 14 Apr 2026 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z/b5JGLQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831E2777F3
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776132236; cv=none; b=TJVM8Y9fgQKn3+d7jTV/UUI+OZSHsffObjeVYkDZYlALW47sMT1qMZVqJK3vEseibl7Z9ZbL6ZspOuyK2mVRO8aIkP8dh/OjMDeegdNVMMk/RQYCmXkxEeWEFUWmEP9f+KGu3OZsU1/Xirm2pQX1s7J7lXWdyeSeTHzIRqZHrCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776132236; c=relaxed/simple;
	bh=VW+aCAzwIkfJoifkbt3tzD1vtoCjvW9idfIi+cNaT6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rj9vLPNCf7DnafY01rQ7UZGYPhhnoLtAa8PSkNbowp/twxYtnReQSQVZHZhQU7KtufSdg0a4gDQdHtg0YNWOiqiUe0CmZLkzfJqaOAkMWZLXSd3lXfqqY6vaPqZVsfRqgUMcNtmkOaHxx0aqpRuetdFWB9gnesKLEen5+1zvEH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z/b5JGLQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63E23psF61137498, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776132231; bh=Ks14jCKyc94k+kEyLz8l6XYnTjCSzlTnwyL2y/XS6oU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Z/b5JGLQ38WAJQxCfrm2ZrKLzVYNt4HqUH1sMYSLyN80R9H1d9T15PfYmyZxB9y+a
	 fhTYSRtZ70XK3iMD7hQHqTGTSJBjxhHRl3ZQC/gTr4CXb8dLx9damlb18ML7nxfu41
	 TegmeSiu1XUGEaflxR/n+diMnHjdD+MSSarj3V6PBQj3w4eBK5dhClEGcD+9Q4N3F7
	 1/4yH3ai768TRwMD8SGMnaUggnOq5gPCPib4j6q3BmdguWt1SS+J1lCZVNcSAFXR2s
	 J0UySkKTyojiw1nUHjuiZLKnd8YSnKJzV5NFJfaMVzzi37Fh5uHLfuitQbzkNK4rXq
	 zKGHAKjAssdLQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63E23psF61137498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 10:03:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 14 Apr 2026 10:03:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 14 Apr 2026 10:03:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "goainwo@gmail.com" <goainwo@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] wifi: rtw88: Add NULL check for chip->edcca_th
Thread-Topic: [PATCH] wifi: rtw88: Add NULL check for chip->edcca_th
Thread-Index: AQHcyyzTY+6cVUzujkaEJSe4anaYQrXdzaPA
Date: Tue, 14 Apr 2026 02:03:49 +0000
Message-ID: <aa92a81841ec4d1da48916153e07f31d@realtek.com>
References: <20260413100249.28618-1-npetrakopoulos2003@gmail.com>
In-Reply-To: <20260413100249.28618-1-npetrakopoulos2003@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34719-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ail.com:url,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: D7D193F4E28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ Bitterblue

Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com> wrote:
> It was recently reported that rtw_fw_adaptivity_result
> in fw.c dereferences rtwdev->chip->edcca_th without
> a null check. The issue appears to be that devices
> with the 8821CE chip don't define edcca_th in their
> chip info. As a result, when rtw_fw_adaptivity_result
> tries to dereference it, the kernel triggers an oops.
>=20
> Add a NULL check for edcca_th before dereferencing
> it in rtw_fw_adaptivity_result() in fw.c and
> rtw_phy_set_edcca_th() in phy.c.
>=20
> Tested on a 8822CE chip which defines edcca_th, so
> this issue is not present on it, but it still uses
> this driver and I can verify there are no regressions.
>=20
> Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221286
> Link:
> https://lore.kernel.org/linux-wireless/CALdGYqQriS7mP0vj_rm_xvisfzFVh0hbp=
y+---48r6bodZO7tg@mail.gm
> ail.com/
> Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/fw.c  | 3 +++
>  drivers/net/wireless/realtek/rtw88/phy.c | 3 +++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wirele=
ss/realtek/rtw88/fw.c
> index 48207052e3f8..c4819ef6d54d 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> @@ -284,6 +284,9 @@ static void rtw_fw_adaptivity_result(struct rtw_dev *=
rtwdev, u8 *payload,
>                 result->density, result->igi, result->l2h_th_init, result=
->l2h,
>                 result->h2l, result->option);
>=20
> +       if (!edcca_th)
> +               return;
> +

As Bitterblue analysis, this might be a garbage, so I'd return at the entry
of this function.

>         rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY, "Reg Setting: L2H %x H2L %x\n=
",
>                 rtw_read32_mask(rtwdev, edcca_th[EDCCA_TH_L2H_IDX].hw_reg=
.addr,
>                                 edcca_th[EDCCA_TH_L2H_IDX].hw_reg.mask),
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wirel=
ess/realtek/rtw88/phy.c
> index e2ac5c6fd500..c10eb28e54ad 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.c
> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> @@ -161,6 +161,9 @@ void rtw_phy_set_edcca_th(struct rtw_dev *rtwdev, u8 =
l2h, u8 h2l)
>  {
>         const struct rtw_hw_reg_offset *edcca_th =3D rtwdev->chip->edcca_=
th;
>=20
> +       if (!edcca_th)
> +               return;
> +

The callers of rtw_phy_set_edcca_th() are RTL8822B and RTL8822C, which both
define rtwdev->chip->edcca_th. How can edcca_th be NULL?

>         rtw_write32_mask(rtwdev,
>                          edcca_th[EDCCA_TH_L2H_IDX].hw_reg.addr,
>                          edcca_th[EDCCA_TH_L2H_IDX].hw_reg.mask,
> --
> 2.53.0


