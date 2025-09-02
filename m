Return-Path: <linux-wireless+bounces-26918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6CB3F333
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 06:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7073B3637
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 04:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01AD1DE2A0;
	Tue,  2 Sep 2025 04:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPKOZ810"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4719F12A
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785717; cv=none; b=j4sQiQITZFXuWqVltsYkZUbAK+IOC63I1OvWcZUdHYVJlk9Qm0vZXVOPu/Fxt7hoVpBdfSjL/eVr2OM56DuZH8kuj2ido09kxY4JXkgDCV2Ds5xzt4TI8WuEtXBf2Y7b0sC4Ft58oV+bkBxY4t6OGSL24rVL14v4LZnJn8dtVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785717; c=relaxed/simple;
	bh=eEqRzl5XlhU9r4YCmqxOg9THtqXxKYKkfhTdRtd2VHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPET/SORWeTSovGxUwLkx56me2F7icIMWb7OeuqTjMzRdkafS3TT8wmrvIz+AzRfoJublhfcmKhMxozDY3mhyiSRjkn4+UyAqjJEcCgBKesWT/q7xj2nqlFe14k6xy3fJOQegVpl//n0Ndwmejd19lnSjFJyNKUI9sQHWoYb0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPKOZ810; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so1831234b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 01 Sep 2025 21:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756785715; x=1757390515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU5mSJkJ1IrLUxmS3Cfr7izqKpmNPsl8zw2WUwHBhD4=;
        b=hPKOZ810EMhXOLCCuhjHoNQkR2lfiX9El7GEvM/kJc6Gl0/GgtBTY0Z+PBwRDiaR91
         FsdY2CDz0Fyz0vezcPz3pnZqCzpQyU8Gu/3Nv8IK52TjsxZU9ZQrJYaE+LJR0HLTfWfA
         wqpvgQXzfkmKjAW6RQkRLxoaC8bExU354pSqyiL9bzovYXBah9CDnksiBTaZkrlLtvLU
         wd/VW9nj0QWyYuCXNxzjVGxvshMSzNMHeiclv+ebipurHhyigq8iLKr6zxa7J8yS4NAH
         NKZ9Xz83d+kGZZIcLLbd7xUH+kXKceyANgyfyN9qjOxTmctn11QcpDCSOFTT2sllAzu4
         C7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756785715; x=1757390515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU5mSJkJ1IrLUxmS3Cfr7izqKpmNPsl8zw2WUwHBhD4=;
        b=F9p2M1lO8qXZ67WNs9u8SVV6danxFRywrSSMkM73Z2XLId6YdA8d/BcrDGUv75m1cm
         ahiQhMG0CxHQjilCumNEyCnkOeENWGXfWjWjhbm2SC2xaNKzCVhWKq8ivcSZ66SUUrmH
         DHHDMeayGq25wBJSTKB1fM16bIU8ZEUQr24rLXjg4umuqLC0kYhGm6505NqN6bTCQl7j
         mAcDIlhbeTfwbInxlFXRBCVr8IMPKyCqu5OFIZYLWDIgOlBCMGdQE1uIxTd+6oJICr4R
         QfU/mx30Fhvz7+eS/Utd9xYRU1dJqllrmuuSyowHqNL5shsMrHJFcLx7RydUYlou9f2L
         4spQ==
X-Gm-Message-State: AOJu0Ywp7eQE5zqHHW7JyUV2Cp4mtzncTvTcre/q6gmfiZrRHr9VYhem
	J9zvoJp/9lBA6uQvKtZPvZ5ofKouuEdUnoOmtqIrzJcvkIumZ+merfLi
X-Gm-Gg: ASbGncsUSv83icG12fuHBVfioCp6E6OPrU7h08c2bth+b1tgTsNYjseHNuTw01Ohk/w
	NtYho69ymTkaZYpWan0pv0ekW6hkbxP+W4kTl3b/xqaAPJ4RbW6ZZlbw+S/ycuji1toIUODioqu
	fvrkUG3L4ENqXsc6/99bZUM9BnofPQ/mv4c9/KIaOTbUx7z1AC3r8RwvBpuWODJU56ElkTVWohT
	WXDS+bdS95u5MtxX26BkBB62y5RGT5fzF+/AfAB9+DedvtzO56lwoX4CxPSI2YF2frV5YRmIxZx
	yuFCCOkKOnQEF9uzFrb4jUQCuxuburR2fRUev6GUyA6emzPkuhgBRtcwVvqBw4SlrT7K5yH08Eg
	sVnWYebTIntPTmSNCK3DhdHu3D6XVUm/wFpzPiv22D1dJduQHrrQC3NIRdkZN5Jo=
X-Google-Smtp-Source: AGHT+IHE1uESZQrCiJsG5fwPP9/uhqI+dT2ZueyTNk8z2M91R8ZHumjYnbhqha8yzBPLTsdgHSDkBw==
X-Received: by 2002:a05:6a00:a0a:b0:770:374c:6c55 with SMTP id d2e1a72fcca58-7723e3d24f2mr12839153b3a.31.1756785715082;
        Mon, 01 Sep 2025 21:01:55 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a2da9c6sm12004301b3a.42.2025.09.01.21.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:01:54 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: RE: [PATCH rtw-next] wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U
Date: Tue,  2 Sep 2025 12:01:48 +0800
Message-ID: <20250902040151.1969575-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <26fa101f2f5240dfb3babbc7c2864e1c@realtek.com>
References: <26fa101f2f5240dfb3babbc7c2864e1c@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ping-Ke Shih <pkshih@realtek.com> 於 2025年9月2日 週二 上午11:30寫道：
>
> Zenm Chen <zenmchen@gmail.com> wrote:
> > Add USB ID 2001:332a for D-Link AX9U rev. A1 which is a RTL8851BU-based
> > Wi-Fi adapter.
> >
> > Only managed mode and AP mode are tested and it works in both.
> >
> > Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> > ---
> > Although it works, but it disconnects occasionally and Bitterblue is working on it.
> >
> > https://github.com/morrownr/rtw89/issues/11
>
> Thank you all for working on this.
>
> > ---
> >  drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> > b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> > index c3722547c..510d124a4 100644
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> > @@ -19,6 +19,9 @@ static const struct usb_device_id rtw_8851bu_id_table[] = {
> >         /* TP-Link Archer TX10UB Nano */
> >         { USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010b, 0xff, 0xff, 0xff),
> >           .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
> > +       /* D-Link AX9U rev. A1 */
> > +       { USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332a, 0xff, 0xff, 0xff),
>
> What is the rule you put this entry here? Can they be in increasing order
> of VID/PID?

Sorry about this, just fixed it in v2.

>
> > +         .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
> >         /* Edimax EW-7611UXB */
> >         { USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xe611, 0xff, 0xff, 0xff),
> >           .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
> > --
> > 2.51.0
>

