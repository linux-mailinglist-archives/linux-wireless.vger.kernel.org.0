Return-Path: <linux-wireless+bounces-30113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F8CDE35A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 02:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4204D300797C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 01:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2018F1DD0D4;
	Fri, 26 Dec 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EUSSsvP9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576E3B28D;
	Fri, 26 Dec 2025 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766714144; cv=none; b=D9XfGaGslxWcW9CmvAq9bV0AT/fw5Wx4BHRaHqTR0UEnfSezsR6thyp5LVAZyGlhGIN+vlcy90AXqAJcQSKpK0nF3JrqCq8K/37AUx1d3PF/ikTPugtY/nOvcBK4HreUOQTK8o/VaQVALaZD/g17Xi+sJMa3tH+Kk6/10zpE5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766714144; c=relaxed/simple;
	bh=lKUDsZEB6P4Jr599npIY4/DwlX0b3o4KcVduo8EtJ4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CAL3s52GHtXztld4ruB9YkIjZPym/W5tVQVRCPLNzXBqslriIhvo5Y0CqNpbnPZ+x3JFFHUFXinccSba3Rw+DCJXt0unFRiIa9P/Gz1iOS7+JEgRfYQs0VejFn4yJbeW6ZCftPcJPjZ+u8RSg56Rl/PS0EgXUIMYeq0E0G3V2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EUSSsvP9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ1tc6jB2697011, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766714138; bh=Xcr311D0Fwlm6t0GpVBPTHLELg3jWFeIwOlZbazR/NY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EUSSsvP9noJXxIDb/MjkWoMP8ocA+h4JeO6djgNjGiRWinI90qsLiFscKD3ZYhFgZ
	 pKhBfHFLw3o98z0iDvcyBfSY3DAqs3MymVZK/qlBGhfqzQOFlwhowZ/VWwIA9UOINd
	 HpktyZ2TDUMrFlu2DnMb2BtX4xfcR6uJY0espah+G8SWLuYl24ordP6u9dx2MV+z59
	 OiKifw5eczG1E3a1lrCa/T6MMvRaX81pWM9JDQbxS3oWzaXuaiR338wtmi6MKWLE+Y
	 44gK1i0t0lJYdQSXIYuP04Roh0cC4LWiXt9GnvwH5opmQpkExQqy+LFGMEpoNjOBTO
	 KZG+YWI5LwWQQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ1tc6jB2697011
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 09:55:38 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 09:55:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 09:55:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 26 Dec 2025 09:55:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ali Tariq <alitariq45892@gmail.com>,
        "Jes.Sorensen@gmail.com"
	<Jes.Sorensen@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add
Thread-Topic: [PATCH] rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add
Thread-Index: AQHcdZVkivwbOu3+UEmR84fOAq6vqbUzKaSA
Date: Fri, 26 Dec 2025 01:55:38 +0000
Message-ID: <678a9c63a185486d89efe46e66d71315@realtek.com>
References: <20251225115430.13011-1-alitariq45892@gmail.com>
In-Reply-To: <20251225115430.13011-1-alitariq45892@gmail.com>
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

Ali Tariq <alitariq45892@gmail.com> wrote:
> The driver does not set hw->sta_data_size, which causes mac80211 to
> allocate insufficient space for driver private station data in
> __sta_info_alloc(). When rtl8xxxu_sta_add() accesses members of
> struct rtl8xxxu_sta_info through sta->drv_priv, this results in a
> slab-out-of-bounds write.
>=20
> KASAN report on RISC-V (VisionFive 2) with RTL8192EU adapter:
>=20
>   BUG: KASAN: slab-out-of-bounds in rtl8xxxu_sta_add+0x31c/0x346
>   Write of size 8 at addr ffffffd6d3e9ae88 by task kworker/u16:0/12
>=20
> Set hw->sta_data_size to sizeof(struct rtl8xxxu_sta_info) during
> probe, similar to how hw->vif_data_size is configured. This ensures
> mac80211 allocates sufficient space for the driver's per-station
> private data.
>=20
> Tested on StarFive VisionFive 2 v1.2A board.
>=20
> Fixes: eef55f1545c9 ("wifi: rtl8xxxu: support multiple interfaces in {add=
,remove}_interface()")
>=20
> Cc: stable@vger.kernel.org
>=20

No need empty lines after Fixes and Cc tags. I will remove them while getti=
ng
merged into rtw tree.

> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>



