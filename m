Return-Path: <linux-wireless+bounces-6469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50868A8FF1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70501282732
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A648376;
	Thu, 18 Apr 2024 00:20:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402CD10E6;
	Thu, 18 Apr 2024 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399611; cv=none; b=OSijuvUjn8yU6GBmJdnI7OWDNOwG2EA9+lIDPZ3HBIs+1n6Xr0JJQx/SxL3EOTfw6SRycHb4JaaMLqU+9OMWd+Mr3Suigl9IABCxbRUEXpak5xrlIXDfcWybkINrBNDE3WxlNcqjzetsH5C5nRf8GiDHMehaZVeQ8bEdTBzC+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399611; c=relaxed/simple;
	bh=MzbK/ytoNMbGF1byMK1n/Y8pUtBzGblXv0mWxLRo/vc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=akVKx/gZv8PqPv7pmwGTiDcazjZDrJD1qr4+N/u3w5OtneLqp/BxWtKcJcLeNePIFONwPNon8TZVfvWsMhQhgz251LbWle6neI2tR1xETYbjEhfUxbCh76/Wry+7xdYgb2ClyK3fCpg7hE/S96HkETFantujwXI0qWeYEcAPQfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I0JwSbA3878648, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I0JwSbA3878648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 08:19:58 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 08:19:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 08:19:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 18 Apr 2024 08:19:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtl8xxxu: enable MFP support
Thread-Topic: [PATCH 2/2] wifi: rtl8xxxu: enable MFP support
Thread-Index: AQHakKpmN+k3bxFC206ySgnAPq76G7FtKcXg
Date: Thu, 18 Apr 2024 00:19:58 +0000
Message-ID: <6a1571aadad1486eb83a19437e1d2437@realtek.com>
References: <20240417093352.1840632-1-martin.kaistra@linutronix.de>
 <20240417093352.1840632-3-martin.kaistra@linutronix.de>
In-Reply-To: <20240417093352.1840632-3-martin.kaistra@linutronix.de>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

>=20
> In order to connect to networks which require 802.11w, add the
> MFP_CAPABLE flag and let mac80211 do the actual crypto in software.
>=20
> When a robust management frame is received, rx_dec->swdec is not set,
> even though the HW did not decrypt it. Extend the check and don't set
> RX_FLAG_DECRYPTED for these frames in order to use SW decryption.
>=20
> Use the security flag in the RX descriptor for this purpose, like it is
> done in the rtw88 driver.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

I would like to change subject to
"wifi: rtl8xxxu: enable MFP support with security flag of RX descriptor",
because the same subject as former patch cause confusing. I can change that
during committing.=20

Others are good to me.


