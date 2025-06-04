Return-Path: <linux-wireless+bounces-23662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F3BACD512
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1089D189F542
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BCB32C85;
	Wed,  4 Jun 2025 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FQgOfqo+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96D2C324C;
	Wed,  4 Jun 2025 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000555; cv=none; b=YZluqrCcBZ/apfVCnNhFQInZdGnNr2MPcbSH0bzEmE0d2Mi18t4+2Hzp/m8R60VEokjcVFOGmy2CB6R74a1xBlm7Z6UlOe7vM7a7oWmiyEBN3cFg4iaxzvjYFXgO3f8UN6kGAcA6KhMsMxkaug2j0zqM10RLu4yeYEmJYfHtFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000555; c=relaxed/simple;
	bh=j/NPCh5DQa2xcsNxzb/p1lRa6fF6E/9eXtCMwsq21EA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+592GygiUTeWOK/TbLbBjqObfgj7RVuLk2gBhyTdOPX7rXDE0fU6h42VmWBFIbVI8cxff1r809TgKDIuJ4lkO56nru0sVDAvmOS3Ly8KRaLxObxKEBQ1rhkQdKIOt6QahX+gqeP2WSpd2TAQ5wMfiDK4X9sWhTxOrI7q+RT3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FQgOfqo+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5541SokgE3213318, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749000530; bh=xhH17oG3AWktkKzbVttv4czOarpFP+rI4ohwnxgM7dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FQgOfqo+HcEvKeOqEOI6TWbjq5x3oI8zgKHYeNXvruUaqXS+yPkMLF3Rv5GKCEvZY
	 2SjzqQmh9+omsRelK5p4bvFkRM8c/DqohjkMvC7c+0NRNuuyJ+w7Csjv1sf/VizA5z
	 gmS6U/A0QSJjvjMtJBSVMwozEoYSnJCBRtV7XxrZ/Yr8TMp1Q2qvnbK8U3J55zjntH
	 BWa2dJg2Fryj/bjsi3IK8eVnOGh+w89Ik249LINkvm6Zi5RZg33jhj968yQqitfqgR
	 DsbmPo5fxUCTG+Y6D3Pb4tfL90fo2d6SXcFc2vYagZgRS8BwWt+731tKb68epdorKD
	 8I7jpM5iDzwuQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5541SokgE3213318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Jun 2025 09:28:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Jun 2025 09:28:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 4 Jun 2025 09:28:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 4 Jun 2025 09:28:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next] wifi: rtw89: sar: drop assertion from rtw89_sar_set_src()
Thread-Topic: [PATCH rtw-next] wifi: rtw89: sar: drop assertion from
 rtw89_sar_set_src()
Thread-Index: AQHb1Jv2hJXUsGxDxUiYdu3AFwIyO7PyNE+A
Date: Wed, 4 Jun 2025 01:28:49 +0000
Message-ID: <aa24adf30a1e4944acefa4effff46dfd@realtek.com>
References: <20250603152642.185672-1-pchelkin@ispras.ru>
In-Reply-To: <20250603152642.185672-1-pchelkin@ispras.ru>
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

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> Urgh, this one wasn't caught as my system doesn't have any SAR available
> from ACPI. But it would be falsely triggered, too. If I saw it earlier,
> I'd better prepared this as a followup patch in a series though..
>=20

Good catch.=20

There are two consumers. One is rtw89_apply_sar_acpi() which should not
assert wiphy_lock, but the other rtw89_apply_sar_common() can be. As I know=
,
the assertion is added for the latter one initially.

Another way is to assert the lock under condition of=20
   test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags)


>  drivers/net/wireless/realtek/rtw89/sar.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wirel=
ess/realtek/rtw89/sar.c
> index 33a4b5c23fe7..3f57881b74e6 100644
> --- a/drivers/net/wireless/realtek/rtw89/sar.c
> +++ b/drivers/net/wireless/realtek/rtw89/sar.c
> @@ -199,7 +199,6 @@ struct rtw89_sar_handler rtw89_sar_handlers[RTW89_SAR=
_SOURCE_NR] =3D {
>                 typeof(_dev) _d =3D (_dev);                              =
 \
>                 BUILD_BUG_ON(!rtw89_sar_handlers[_s].descr_sar_source); \
>                 BUILD_BUG_ON(!rtw89_sar_handlers[_s].query_sar_config); \
> -               lockdep_assert_wiphy(_d->hw->wiphy);                    \
>                 _d->sar._cfg_name =3D *(_cfg_data);                      =
 \
>                 _d->sar.src =3D _s;                                      =
 \
>         } while (0)
> --
> 2.49.0
>=20


