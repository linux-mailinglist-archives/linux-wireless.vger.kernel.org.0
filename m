Return-Path: <linux-wireless+bounces-24235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40489ADE320
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 07:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17F5189A806
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 05:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4849B1DC9B5;
	Wed, 18 Jun 2025 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Wm3GtEC8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4422155382;
	Wed, 18 Jun 2025 05:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225394; cv=none; b=uSwLFLsAFZcGmOa3h5JMyvOJFxq8YDcfRUEJ1pOYAGuEbfStlOvD5pyy1DJ8xXkldxm2APg6JvY2qslTemfGDR3ZxwPKNOUFz+0Y4j0UuZMTiRPLXkJKNJSsNIey4s21OtLh0Dg1NuwlK4wlGK8C7iUJKcVVt9r+hh9P+1r6XlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225394; c=relaxed/simple;
	bh=0JQBsfmNYdQa/0IV4/qsPNFTRadbSDZ3GVaBCtE0Z3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sfwjc9O2V1rYinbxhH4f91IUWviTc06cUuB+GPpiyhUwxEqxXaG6YyhCPgoScK5P8cA6wmNa3YMHYo1BhTb++/jdFb5vWpDeqwjpDGu2mK5ct6rVYlbZiIh3fp7l/TabOMhUqmIDQEr27BqE4EicPvB2q2oWmqWfSBg6ja1YpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Wm3GtEC8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55I5h68Z13672511, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750225386; bh=24qWcAQa2eW2xtwkeq0PwRXckxE/cms8HYXVdLi4u1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Wm3GtEC8ePyPtE0awr1yJ7MdPWh7d8+GZbVEQK7k4+r2nl9ChJTpz3zYJ5wHVrXST
	 UYAE86a+kGWxGo0XcO44fRCq4VOXWpNStqg3Rh+yhKskYAhYfABNsChkRQWL2dJmA4
	 XqXl/34fMP2ZqQ2GqyC/K4w8Exe6RvwLezQsnhZ971KEnYm2GFJviiYdyAXTeRoZfo
	 0sh29GdotETp9Pai3D9iH2kDL6ejowrVknIlVLe//KDDin1CwfzgpVqFXAcnTBLYdQ
	 EmuBDMFdujYWxLOXtNyWf08PWwn/uNjjZRlBKayPT1HXx2Qv9MGXkiMIKJGkT+xE+S
	 Tv4mg/Xo++hDg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55I5h68Z13672511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 13:43:06 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Jun 2025 13:43:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 18 Jun 2025 13:43:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 18 Jun 2025 13:43:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.
Thread-Topic: [PATCH rtw-next] wifi: rtlwifi: fix possible skb memory leak in
 `_rtl_pci_rx_interrupt()`.
Thread-Index: AQHb3q3lAKJwiCeNiES7NMfEqP2rpbQIalBQ
Date: Wed, 18 Jun 2025 05:43:11 +0000
Message-ID: <1b7f0d569bd74b5ca606c1eb9d57e4b1@realtek.com>
References: <20250616105631.444309-4-fourier.thomas@gmail.com>
In-Reply-To: <20250616105631.444309-4-fourier.thomas@gmail.com>
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

Thomas Fourier <fourier.thomas@gmail.com> wrote:
> The function `_rtl_pci_init_one_rxdesc()` can fail even when the new
> `skb` is passed because of a DMA mapping error.  If it fails, the `skb`
> is not saved in the rx ringbuffer and thus lost.
>=20
> Compile tested only
>=20
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


