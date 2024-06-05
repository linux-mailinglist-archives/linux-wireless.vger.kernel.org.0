Return-Path: <linux-wireless+bounces-8522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBDA8FC4DF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 09:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4061F25520
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385D918C33C;
	Wed,  5 Jun 2024 07:44:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38151581E2
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573469; cv=none; b=Iwzgmkx059J4h1h/O54jhUIdXKyA3iBlw2aTHglFFE1nFPVkMbQbmn2N0gO6Rh60xDjM2a56Knw+0KSLpGcgpdIPQ5P2/lJccSPmGeNK2eB+D0sb6Mu7cCwpvOPBxO4KMuLs3uUqRc6jR5zK7DrOdRtYWTMU2nSnwuWwX+ConVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573469; c=relaxed/simple;
	bh=4HChQgEExHfuatUtaRJP81d9LVinktxI4x9y1qqUBfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gUg6mjulUjWxGyZdJuLwBdnTOMut1L6pwGsTN/XhkSww2hY4CBDQ9wB2dU+sZ/YM7Wx1OMV8NlkpKzNeK/WSvv/pYiU8ojlNeMZ5UUtvfVi90a5Hpb/9WLLi10v7cfxCUWeZRolsROxgtoQgqgyRN116MuPXR1bhZH/Z3HqTk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4557iARC11238279, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4557iARC11238279
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Jun 2024 15:44:10 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:44:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 5 Jun 2024 15:44:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 5 Jun 2024 15:44:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "wens@kernel.org" <wens@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "wireless-regdb@lists.infradead.org" <wireless-regdb@lists.infradead.org>
Subject: RE: [PATCH v2 4/4] wireless-regdb: Update regulatory info for Mexico (MX) on 6GHz
Thread-Topic: [PATCH v2 4/4] wireless-regdb: Update regulatory info for Mexico
 (MX) on 6GHz
Thread-Index: AQHatxilWCZ8XDk54UurdwXblEIuRbG4yb7A
Date: Wed, 5 Jun 2024 07:44:09 +0000
Message-ID: <3306967337134439bb7d61e29277ac60@realtek.com>
References: <20240605071453.8091-1-pkshih@realtek.com>
 <20240605071453.8091-4-pkshih@realtek.com>
In-Reply-To: <20240605071453.8091-4-pkshih@realtek.com>
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

Ping-Ke Shih <pkshih@realtek.com> wrote:
> diff --git a/db.txt b/db.txt
> index d3b106526252..c4f5e995e422 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1293,12 +1293,16 @@ country MW: DFS-ETSI
>  	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
>  	(5490 - 5710 @ 160), (27), DFS
>=20
> +# Source:
> +#
> https://www.ift.org.mx/sites/default/files/comunicacion-y-medios/comunica=
dos-ift/comunicado13ift_1.pdf
> +#
> https://www.ift.org.mx/sites/default/files/industria/temasrelevantes/cons=
ultaspublicas/documentos/2021
> 0119-cpi6ghz2020-162.pdf
>=20

Please drop v2. I forgot to correct above links. Sorry for the mistakes.=20

Ping-Ke


