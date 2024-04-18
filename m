Return-Path: <linux-wireless+bounces-6472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BE8A900C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655ABB21FDA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 00:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB0817;
	Thu, 18 Apr 2024 00:31:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67487811
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713400294; cv=none; b=GbNy+tEu7Ink9VJnyl7+1eA/DTVzuXa+qNN/WmILYwr1vIzFqtH3ziBJWnkNTsxvCGNYFjIMXYBKZ3o94M/5F13ZdokUUXCpf5nlSobzmYZ3B36MD00VcFT39xSN3cMyJLdGnd/XgwkIzJnu4Kp+hptz0Nfizb5Bvq0ou0okbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713400294; c=relaxed/simple;
	bh=yqnpbjDYuzuCewsCKp6K+kvB+OfCN6NvNDqK/mbHuB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qzMnwV9KVUHnIPHdYccZHD9nQg3g8Sk/VuOeIF1/Oi36+AQ9WrPLODQBKTtN9fyYvj34IdcN9ltEim+tmS4DKkz35yQmX6ZawZLUSkj3nCA1afFcFpfaLR2J5RXc7Vh+yy3ddCHhKyAdl3yEtkeszSjNLOUCwYW353gSVVuTu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I0VRLt83884637, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I0VRLt83884637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 08:31:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 08:31:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 08:31:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 18 Apr 2024 08:31:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lewis Robbins <lewis.robbins2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: suppress messages of failed to flush queue
Thread-Topic: [PATCH] wifi: rtw88: suppress messages of failed to flush queue
Thread-Index: AQHakGhMPXSMmu1HQU6i74qytbmsgrFsgmkAgACrxzA=
Date: Thu, 18 Apr 2024 00:31:27 +0000
Message-ID: <fc6072f3deda43eeb138356f973631b6@realtek.com>
References: <20240417014036.11234-1-pkshih@realtek.com>
 <20240417221451.43964-2-lewis.robbins2@gmail.com>
In-Reply-To: <20240417221451.43964-2-lewis.robbins2@gmail.com>
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

Lewis Robbins <lewis.robbins2@gmail.com> wrote:

> Thanks, I tested it for 30 minutes and didn't receive any superfluous war=
ning message. Only thing I could
> find was the comment above not reflecting the (new) debug print (but very=
 nit-picky from me).
>=20
> Acked-by: Lewis Robbins <lewis.robbins2@gmail.com>

Acked-by is used by maintainers, so I used your Tested-by by v2. [1]

>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wirel=
ess/realtek/rtw88/mac.c
> index 9038e2311596..3d1a886262d8 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac.c
> @@ -1026,7 +1026,7 @@ static void __rtw_mac_flush_prio_queue(struct rtw_d=
ev *rtwdev,
>                 msleep(20);
>         }
>=20
> -       /* priority queue is still not empty, throw a warning,
> +       /* priority queue is still not empty, throw a debug message

Thanks for pointing this.=20

>          *
>          * Note that if we want to flush the tx queue when having a lot o=
f
>          * traffic (ex, 100Mbps up), some of the packets could be dropped=
.

[1] https://lore.kernel.org/linux-wireless/20240418002916.5965-1-pkshih@rea=
ltek.com/T/#u


