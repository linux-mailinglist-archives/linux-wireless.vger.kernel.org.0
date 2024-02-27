Return-Path: <linux-wireless+bounces-4086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8686910C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40E3280FDB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7E13329D;
	Tue, 27 Feb 2024 12:56:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02113A258
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038586; cv=none; b=ZugzIQor0rehduUiHEL9vHdJLsU4OIACu761IVqzX2DEbDI6b0luqkon4FlXgihQn8wtP2XP1qbW3ZM2leAbXHg0p9NEbIxXn6xUFCeD6IS/rWZE1361iE8AmSKJcfYvfN+NxgyGdQcwQvQ7sDY/Qn9ageTE/p1c5d8ruPkBoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038586; c=relaxed/simple;
	bh=CH9Po/cNE+cMP6nSyf74R9G3LeL8ufrdBzxJaLS4168=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXk9Pw0ageT6zOnPPsI7kyXbifiSUsCrctimF21gtCprHPXU0a15Tbhv37xU0lVLpXBhiquERquaxlSLqSNreujaLh35gauUt7rPWhgO6Q4y4dpuggMGSIjPjK9ji1LG8HLHPnfcKxepexQTvQ+iDzc/CZ6HyYoFstg94vqC9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rex0P-0005kx-13; Tue, 27 Feb 2024 13:56:21 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rex0N-003CaN-Ps; Tue, 27 Feb 2024 13:56:19 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1rex0N-00Ab3e-2K;
	Tue, 27 Feb 2024 13:56:19 +0100
Date: Tue, 27 Feb 2024 13:56:19 +0100
From: Sascha Hauer <sha@pengutronix.de>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
Message-ID: <Zd3b81m3_Hh47lww@pengutronix.de>
References: <731ea688-04ef-4f02-9d01-3e9026981057@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731ea688-04ef-4f02-9d01-3e9026981057@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Feb 27, 2024 at 02:18:20PM +0200, Bitterblue Smith wrote:
> RTL8822CU, RTL8822BU, and RTL8821CU need an extra register write after
> reading and writing certain addresses.
> 
> Without this, the firmware upload fails approximately more than 50% of
> the time.

Great stuff. I have seen these firmware upload failures as well and
couldn't make any sense of it.

> 
> Tested with RTL8811CU (Tenda U9 V2.0) which is the same as RTL8821CU
> but without Bluetooth.
> 
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/usb.c | 46 ++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 3c4f28c306a9..ff01f7056ca9 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -33,6 +33,42 @@ static void rtw_usb_fill_tx_checksum(struct rtw_usb *rtwusb,
>  	rtw_tx_fill_txdesc_checksum(rtwdev, &pkt_info, skb->data);
>  }
>  
> +#define REG_ON_SEC 0x00
> +#define REG_OFF_SEC 0x01
> +#define REG_LOCAL_SEC 0x02
> +
> +static void rtw_usb_reg_sec(struct rtw_dev *rtwdev, u32 addr, __le32 *data)
> +{
> +	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
> +	struct usb_device *udev = rtwusb->udev;
> +	u8 current_reg_sec;
> +	u16 t_reg = 0x4e0;
> +	u8 t_len = 1;
> +	int status;
> +
> +	if (addr < 0xFE00) {
> +		if (addr <= 0xff)
> +			current_reg_sec = REG_ON_SEC;
> +		else if (0x1000 <= addr && addr <= 0x10ff)
> +			current_reg_sec = REG_ON_SEC;
> +		else
> +			current_reg_sec = REG_OFF_SEC;
> +	} else {
> +		current_reg_sec = REG_LOCAL_SEC;
> +	}
> +
> +	if (current_reg_sec != REG_ON_SEC)
> +		return;

Is there something we want to do with current_reg_sec == REG_LOCAL_SEC
or current_reg_sec == REG_OFF_SEC later? If not the above could be
rewritten as:

	if (addr > 0xff && addr < 0x1000)
		return;
	if (addr > 0x10ff)
		return;

	...

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

