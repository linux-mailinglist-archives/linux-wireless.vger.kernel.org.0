Return-Path: <linux-wireless+bounces-15216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5089C6219
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 21:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8470D1F21767
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAA71A76D2;
	Tue, 12 Nov 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="LMZPSrvN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AAA219E32
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441852; cv=none; b=qrQGF/lHO8NxECgic0B89Xwx/bxJ5lYmPt9alI+UPa+vt+n7swjRWr5pUG+NoLucOO+Do/sCMmZ9d9xOgXvCmvaRXVwL7Ax3QGTPL0cSarksUiwA0EpjbuxUMGh64Wi5KYgIJYVYU5HlLm6j0hZdHmLylHhEbJJJ3RLo8S5xhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441852; c=relaxed/simple;
	bh=I7igYxuipBJF+xrT3yb57gujmeiRP+aKcgJzf2AQ4C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGsjU0XA5hKmQoxQpbduyKXpC6Z9NX5GjiUeYe4iESdC8nu4d346koU46ct0hyFnKgGd33uk6j7b+3d26CrvP0zt+MeU57Q34NI/nfkb4Rpuq6n89MXK9vTiuopB+CWtal+iKvlomKFbCTMQE7GQoXUVZN4yFGASqF8nKQNfn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=LMZPSrvN; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731441847; bh=I7igYxuipBJF+xrT3yb57gujmeiRP+aKcgJzf2AQ4C8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LMZPSrvNR70pVc2LHXx2jETIScdFTVAatkCauDEiYhSWzHMRbVGbNY81AT/T/j/rb
	 aCKumqFaIkFj4EwN2jf5uqY4qt2EnEfnQduXOeri0+CbM6/9YaJBIYTkRt5V1XIZDZ
	 CHNbEyzWqaiBJSiHLkNrOCInDsMui93CwFpYiCacWLHZH202/BlIcwuSJ/Q9GpCrwI
	 6lgR0/2VcMq5LAPseE/bPLCqLpRsldZHZsfB9dOi0RV+/WXpLrPQxQ/7bw0LTc876E
	 CtZQNuJYBxgZdl/3hjJ7KDkxxYSDiozFFOmUD2bdxQ7hp0t0QBbXbU+NYjkngE6Ir5
	 EE67yGzhbyslW5fv2oc9lQU8R3TeNB9rPLsoHxUxw1vwobTGyOf/razM9GUjTK5d6R
	 TbBIUcVhlDDgn6YxQgO5qly9g5FT/1mBkTdBW2FPvuL1MpTq0uuX2YwD6DavultwfU
	 H9RzCWAL6P95Dp8nYK6ljd5TfyCdzYTLdKqHeD4r6Hqi2jzYPIqrB/yq/FhgSDRj8d
	 S4X5HhwZ/483dGdlP1G3HCQ+tVoC/15QwqEs60Ms3UPs6V/ab1hRDA+nx0kPxOCPAg
	 NoibgDXrGW8u9afp2goaiopNxWQLskWCbiJtQtBxn87bEU99dEo4T9fdc60uieipXY
	 T4Gj7JxPMda5ZZvui+KhYKUc=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 79317167DBB;
	Tue, 12 Nov 2024 21:04:07 +0100 (CET)
Message-ID: <9f95ac78-ed69-4554-825e-3ad294f49057@ijzerbout.nl>
Date: Tue, 12 Nov 2024 21:04:05 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] wifi: rtw88: Add rtw88xxa.{c,h}
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com>
 <b8590382-a954-412d-a96b-63e360b97acc@gmail.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <b8590382-a954-412d-a96b-63e360b97acc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 30-10-2024 om 19:27 schreef Bitterblue Smith:
> These contain code shared by both RTL8821AU and RTL8812AU chips.
>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v2:
>   - Rename rtw8821a.{c,h} to rtw88xxa.{c,h}.
>   - Rename functions to use the "rtw88xxa" prefix.
>   - Rename struct rtw8821a_efuse to rtw88xxa_efuse.
>   - Keep only the common code in this patch. The rest is in the next
>     two patches now.
>   - Fix copyright year.
>   - Print hw_cap in rtw88xxa_read_usb_type.
>   - Use pointer to rtwdev->efuse in rtw88xxa_get_bb_swing instead of
>     making a copy of the struct.
>   - Make rtw88xxa_get_swing_index return 24 instead of 0 by default.
>   - Use new register definitions.
>   - Delete rtw8821a_query_rx_desc. Use the new rtw_rx_query_rx_desc
>     function instead.
>   - Use u32_get_bits instead of FIELD_GET in
>     rtw88xxa_false_alarm_statistics.
>   - Use existing bit definitions for REG_CR bits instead of creating new
>     ones.
>   - Use existing name of REG_CCK0_FAREPORT instead of adding a new name.
>   - Delete unnecessary braces and semicolons in switch statements.
>   - Initialise arrays with {} instead of {0}.
>   - Empty functions should have the braces on separate lines.
>   - Include reg.h in rtw88xxa.h.
>   - Make struct rtw8821au_efuse and rtw8812au_efuse __packed.
>   - Delete most macros from rtw88xxa.h. Some were moved to reg.h, some
>     were unused (inherited from rtw8821c.h).
>   - Fix some indentation.
>   - Use the correct IQK function for 8812au in the tx power tracking.
>     v1 was accidentally using the IQK function meant for 8821au.
>   - Rename struct rtw8821a_phy_status_rpt to rtw_jaguar_phy_status_rpt.
>     It's shared by RTL8821AU and RTL8812AU, and maybe RTL8814AU in the
>     future. These are all "Jaguar" chips.
>   - Make struct rtw_jaguar_phy_status_rpt __packed.
>   - Access struct rtw_jaguar_phy_status_rpt with le32_get_bits instead
>     of bit fields.
>
> v3:
>   - No change.
>
> v4:
>   - No change.
> ---
>   drivers/net/wireless/realtek/rtw88/rtw88xxa.c | 1989 +++++++++++++++++
>   drivers/net/wireless/realtek/rtw88/rtw88xxa.h |  175 ++
>   2 files changed, 2164 insertions(+)
>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.c
>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.h
> [...]

> +static void rtw88xxau_init_queue_reserved_page(struct rtw_dev *rtwdev)
> +{
> +	const struct rtw_chip_info *chip = rtwdev->chip;
> +	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
> +	const struct rtw_page_table *pg_tbl = NULL;
> +	u16 pubq_num;
> +	u32 val32;
> +
> +	switch (rtw_hci_type(rtwdev)) {
> +	case RTW_HCI_TYPE_PCIE:
> +		pg_tbl = &chip->page_table[1];
> +		break;
> +	case RTW_HCI_TYPE_USB:
> +		if (rtwdev->hci.bulkout_num == 2)
> +			pg_tbl = &chip->page_table[2];
> +		else if (rtwdev->hci.bulkout_num == 3)
> +			pg_tbl = &chip->page_table[3];
> +		else if (rtwdev->hci.bulkout_num == 4)
> +			pg_tbl = &chip->page_table[4];
> +		break;
> +	case RTW_HCI_TYPE_SDIO:
> +		pg_tbl = &chip->page_table[0];
> +		break;
> +	default:
All other switch (rtw_hci_type(rtwdev)) in this module handle
the default with an error. Shouldn't you be doing that here too?
In the default case the code continues with pg_tbl == NULL
and thus it will crash.
> +		break;
> +	}
> +
> +	pubq_num = fifo->acq_pg_num - pg_tbl->hq_num - pg_tbl->lq_num -
> +		   pg_tbl->nq_num - pg_tbl->exq_num - pg_tbl->gapq_num;
> +
> +	val32 = BIT_RQPN_NE(pg_tbl->nq_num, pg_tbl->exq_num);
> +	rtw_write32(rtwdev, REG_RQPN_NPQ, val32);
> +
> +	val32 = BIT_RQPN_HLP(pg_tbl->hq_num, pg_tbl->lq_num, pubq_num);
> +	rtw_write32(rtwdev, REG_RQPN, val32);
> +}
> [...]
-- 
Kees Bakker

