Return-Path: <linux-wireless+bounces-27731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A994BABE1C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 09:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C19816865E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 07:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3F33F6;
	Tue, 30 Sep 2025 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjLHHSwZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5021B918
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218338; cv=none; b=clEuh/HOTATe7ViLitIEmfcvPH1DjduvKk+mMnHHEDaLNpl904PDQzrOYr3CrpngQ4ndg4cpRkbQH7+BW5wtMjAx4Z/i3hgaXR29I9er5RMKeFdcyCCQtzW+cqMdNW4guu3qKpxqWDz5jxLQsCgMSGTdhbx2FKRz6ZFRNOnLQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218338; c=relaxed/simple;
	bh=VknSEzbFRyg2p5S7p3lhBFmyvSKPT0KFiZDA68l4arc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZwyK1ZbH2pa4hg8I02ahAWWvc6LsUU0GM5dXykLhpgMBAgWjtwWxTAA6kyBBhNVTm/oO9eMG28+HLpDrJC4WFEK8p2tnOpRF7QomJbyc2yDGKx+jMJkH3TZG15mwdJrf4nz7YIzTWZVuSwZRP2Cm/nL70Id4irAkhvlmkJOOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjLHHSwZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7835321bc98so2732621b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759218336; x=1759823136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uumGeXdxkz5gZ2F60Gfh4IUJzxzYu9Q+pP6Rv+RiNY=;
        b=HjLHHSwZLIkEAuYY8T8Q8wpgvFDzBUgn5Cd27Q8DoeIWT5uZIb0yXMWIN7Soy27Ln6
         AzaYTtc1lfK4MXoJzgFbi2WpSegOM6bGWFpjz1t74oLozvyLP99lMed+TzlncyoiYvs4
         mmM9Sl7Glv4m9ObWAXRoljGdcJOhOKL6tTXmSXQRriC2itmnDdo55Hi7yHksEYFY7/hD
         gyT/vltZl/AUiSK8PpufQWM6q/QR9/ay/sNxlnrbrbZyHpXlVDY2qjLKj4gkdt4YWxJu
         eLXFYp+XRjp5n3fEcndT2oAZ1kkjbJGtMcZFvTjaNkFp7FwpYfH7IvoxyCsOEui0BXE1
         KbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218336; x=1759823136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uumGeXdxkz5gZ2F60Gfh4IUJzxzYu9Q+pP6Rv+RiNY=;
        b=FN4rVqpK2k/IPug7qUJ9g8t2tfZiqrZy45sYz0mQIFzTCbeW7rxY8YSMGATtz0HkKf
         QA3G9eTSaz2cVNPQHrKgWV2MlNQi9q8flvqb+wz2CVQgZcY/DPONHBl256PHvggVICY/
         SU5sOYRlKQ9lVzisYRJia6J/6i1Gu8s5j1sn+H4AsZeDAxB/0QCtvkJjdmI9uzX9Jy2o
         uP5Aas8h1oKME4Kjl0PADiwEM2KG/i4/q75hxXWQnZGLvxS75s5SEjcHrAyOk2UZQwHz
         688Tb1+2lEi1SJGfE6LQ1h4jHvttcuyHb1cviJay7gOe78zBW5cBDW5L4zo6dcTYaM4c
         ydQQ==
X-Gm-Message-State: AOJu0YxXqALLQpxk+KvwbPDTR1HgKsiLu2DacCha2MXjTm7W3HWnaEf6
	tH1UoDt+VgfJCIyi4s5yISaKgLVkBZ+T3Wzqpquf/WlVJxN5eww6m974
X-Gm-Gg: ASbGnctISsJcvMoGL9SrrpS2q6nWoUnS3zuUOQqnH48yieq/CmbI8+DI3mYzhh2qFhH
	zU8J2sjEfrkVPmChlK1lqxA26WXOYPukxdqzh+/r0pbYGdp6eHhIOHjWZ/pXQXiQRs7GsbyHLpS
	y8aRFM7HF08jnNzXkbULk5LtVmkF6lUaKH16P2lXlA+jh5Mdl8XbD/7oTEubQyNoriEaG96MT9j
	HRSWtxEGEg65FwkJpall1EBuQHbBnBSbK2tNv5xxJjkL0LLijpp4X2Acvq8+1zcK9oiOEVVbAKd
	h3bfuHxCRGk1rbINL0YZ4jtnhaVO1cO2yswphiM0Y8wPhiacpKOPI+s5VI0pfZwxXhuWATsPgtY
	WoACOvyahPSEp6PNAN3OjvFzS1fl4uvsucG1ddRr0FLOSiUo=
X-Google-Smtp-Source: AGHT+IHBWQaxjNpvQkLTQV4wAuyXn8LXuHL8BSyY9zDckA2nLcbamYPZxcGJSX0XiLrCktXXBvwHcw==
X-Received: by 2002:a05:6a00:1883:b0:781:15b0:bea9 with SMTP id d2e1a72fcca58-78115b0c366mr16605719b3a.22.1759218335832;
        Tue, 30 Sep 2025 00:45:35 -0700 (PDT)
Received: from BM5220 ([49.215.217.94])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-781023c158fsm12977520b3a.24.2025.09.30.00.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:45:35 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	stable@vger.kernel.org,
	zenmchen@gmail.com
Subject: RE: [PATCH rtw-next] wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
Date: Tue, 30 Sep 2025 15:45:26 +0800
Message-ID: <20250930074530.4204-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <62f767e17eaf428393cf79d55666a011@realtek.com>
References: <62f767e17eaf428393cf79d55666a011@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ping-Ke Shih <pkshih@realtek.com> 於 2025年9月30日 週二 上午11:19寫道：
>
> Zenm Chen <zenmchen@gmail.com> wrote:
> > Add USB ID 2001:3328 for D-Link AN3U rev. A1 which is a RTL8192FU-based
> > Wi-Fi adapter.
> >
> > Compile tested only.
> >
> > Cc: stable@vger.kernel.org # 6.6.x
> > Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> > ---
> > Link to the Windows driver for D-Link AN3U rev. A1
> >
> > https://www.dlinktw.com.tw/techsupport/ProductInfo.aspx?m=AN3U
>
> Could you please enlighten me how you address this is RTL8192FU-based?
> I downloaded the setup.ext and decompressed the file, but I can't find
> 8192FU.

Hi Ping-Ke,

After installing that Windows driver, the driver will be placed at C:\Program Files\D-Link\AN3U\Driver.

According to the line 266 of the C:\Program Files\D-Link\AN3U\Driver\WIN10X64\netrtwlanu.inf file [1], we know that this dongle uses a 8192FU chip.
The specification [2] which says it supports both WPA2 and WPA3 is also a clue. As far as I know, among all Windows drivers for Realtek 802.11n 2T2R chips, only the driver for 8192FU supports both WPA2/WPA3, others support WPA2 only.
This is how I determine what chip this dongle uses, but unfortunately there is no related report at linux-hardware.org [3] so cannot confirm it does use the ID 2001:3328.

[1] line 265 ~ 266 of the netrtwlanu.inf file
;; For 8192F DLINK
%DLink_AN3U.DeviceDesc% 			= RTL8192fu.ndi, 	USB\VID_2001&PID_3328

[2] https://www.dlink.com/tw/zh/products/an3u#Specs

[3] Reports about the ID 2001:3328 and 2001:3329
https://linux-hardware.org/?id=usb:2001-3328
https://linux-hardware.org/?id=usb:2001-3329

>
> > ---
> >  drivers/net/wireless/realtek/rtl8xxxu/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> > b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> > index 3ded59527..be39463bd 100644
> > --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> > +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> > @@ -8136,6 +8136,9 @@ static const struct usb_device_id dev_table[] = {
> >  /* TP-Link TL-WN823N V2 */
> >  {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0135, 0xff, 0xff, 0xff),
> >         .driver_info = (unsigned long)&rtl8192fu_fops},
> > +/* D-Link AN3U rev. A1 */
> > +{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3328, 0xff, 0xff, 0xff),
> > +       .driver_info = (unsigned long)&rtl8192fu_fops},
> >  #ifdef CONFIG_RTL8XXXU_UNTESTED
> >  /* Still supported by rtlwifi */
> >  {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8176, 0xff, 0xff, 0xff),
> > --
> > 2.51.0
>


