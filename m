Return-Path: <linux-wireless+bounces-14758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDADC9B7269
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 03:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18727286537
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 02:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81245026;
	Thu, 31 Oct 2024 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZQRg8/AO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801082E401;
	Thu, 31 Oct 2024 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340985; cv=none; b=GfCZB3+OWQEGGfjq5WMgLJxhhkyrPAImjIEN5pFMlsvh+2Djnl7jpFpwVWthiMtA/EuQn3A55C+Ro0bqBW8TFwuxnEISoL0uJxgetRUQGQ+9CD3Wjo5D7IPPRFFRsnXSkDy3olki6UwdRKF+HInm5zru7TSXLehtm+NaDgaFqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340985; c=relaxed/simple;
	bh=vhdnE9JA5pT9fw4J2PrJS8MGAPAdj0Foe/ClAeCnIHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XyOmrOp+/oc/SB3tJLQpzl7waaZ3wYhTTnD5jVc9NL5Xx2NFufeUtr8E7PCGO5CgPR+SXlMB9jvMBF6xmdfjzsvG1McOsa6OCJs+4Tqc3LFNaM8Ocnb+HnL5BdojwsnmATO4HthRzUp2k7ZbGivNbCopzuDkYRz9FnQcOxrQb/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZQRg8/AO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49V2Fd382697773, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730340939; bh=vhdnE9JA5pT9fw4J2PrJS8MGAPAdj0Foe/ClAeCnIHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZQRg8/AO85UwWA3ecJ8u+bRapJZYuNJLVenU4VHcEL94itQGC8ceAqG/zQRQAoLSP
	 StVYQ/GNYRF4nOeDbTbu5g9Q++a8GG9XzDx+qziz4WdUJXVknjHcq9n2TNIQk0FrBp
	 t8mkfuBKktHaUSKJq8X3STyawXK4gmEv/hYAMBhQwAANnc2cPOsQbhfaCyG5P3TBgM
	 c63zA0DOTLv4OH0Df24tbQlrgdvQKpl/+pZQgA7/6Nrgeda4Sjp5RPQXOht8q83rG7
	 LxSzF4guIDltztjNfLIoVikuTU7DIBuVPwB4mliYWUrLNrUUsCe3/hDtwwi+iKmVRH
	 3k1843z4AFf/w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49V2Fd382697773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 10:15:39 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 10:15:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 31 Oct 2024 10:15:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 31 Oct 2024 10:15:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
	<syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
Subject: Re: [PATCH V2] wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures
Thread-Topic: [PATCH V2] wifi: rtlwifi: Drastically reduce the attempts to
 read efuse in case of failures
Thread-Index: AQHbKtYZmZEqsJWd+ECeMgNDFqDflLKgHpmT
Date: Thu, 31 Oct 2024 02:15:38 +0000
Message-ID: <4d9471f600224d23bb1f49a8ed4943c2@realtek.com>
References: <20241030141440.1153887-1-gpiccoli@igalia.com>
In-Reply-To: <20241030141440.1153887-1-gpiccoli@igalia.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


> diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c b/drivers/net/w=
ireless/realtek/rtlwifi/efuse.c
> index 82cf5fb5175f..f741066c06de 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
> @@ -164,7 +164,17 @@ void read_efuse_byte(struct ieee80211_hw *hw, u16 _o=
ffset, u8 *pbuf)
>         struct rtl_priv *rtlpriv =3D rtl_priv(hw);
>         u32 value32;
>         u8 readbyte;
> -       u16 retry;
> +       u16 retry, max_attempts;
> +

Declarations should be in reverse X'mas tree order.
Just add max_attempts to a new line at proper position.=20

