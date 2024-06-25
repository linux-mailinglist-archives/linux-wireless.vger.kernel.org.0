Return-Path: <linux-wireless+bounces-9515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65940915D66
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 05:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195871F22556
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 03:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AC326ACD;
	Tue, 25 Jun 2024 03:41:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242062F56
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286870; cv=none; b=FyQUpZx/DSYBBDPujYxpKGvnyfvzAyojNsPkkoZxt63aSoVXJ55HXigSTlB4COV+G7yPTEHDry52zJYXc+jYviF9M9OqAZPXtqHJCUoaob1bkOav+Lio5anEp2nwb1UuuX28Ck0V485Z1MFRutRxmzGTuKI3zLVzgUcT3jKiqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286870; c=relaxed/simple;
	bh=fAQINd5DvxwahlYUtNxK2R8hREtr1NGH3dsRn42L2bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=te0wryQcGjVpi+gYPixUdyXosl/lhXuCn2WGeuodWyVVpWXvOZxS/6DzqgirKvj6A0+SkXUTop7/G1n27ZDByEQCw1K6YKie1Z6+Pcp4rY3+h5m4voa1Xr+8BYdlJ36YFfb+ngNkfIqIRY+XRqFPTm8edP93/NMA7nE/M3U3EQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45P3ekaJ73859193, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45P3ekaJ73859193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 11:40:46 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 11:40:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 25 Jun 2024 11:40:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 25 Jun 2024 11:40:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: 8188f: Limit TX power index
Thread-Topic: [PATCH] wifi: rtl8xxxu: 8188f: Limit TX power index
Thread-Index: AQHaxj7rxoQ2665D9kK8QxVQC05tzrHX1lRw
Date: Tue, 25 Jun 2024 03:40:46 +0000
Message-ID: <8c4f9a78f8a84bbb848af4bde99215ab@realtek.com>
References: <20240624140037.231657-1-martin.kaistra@linutronix.de>
In-Reply-To: <20240624140037.231657-1-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Martin Kaistra <martin.kaistra@linutronix.de> wrote:
> TX power index is read from the efuse on init, the values get written to
> the TX power registers when the channel gets switched.
>=20
> When the chip has not yet been calibrated, the efuse values are 0xFF,
> which on some boards leads to USB timeouts for reading/writing registers
> after the first frames have been sent.
>=20
> The vendor driver (v5.11.5-1) checks for these invalid values and sets
> default values instead. Implement something similar in
> rtl8188fu_parse_efuse().
>=20
> Fixes: c888183b21f3 ("wifi: rtl8xxxu: Support new chip RTL8188FU")
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>



