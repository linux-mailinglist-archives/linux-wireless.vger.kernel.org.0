Return-Path: <linux-wireless+bounces-10923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B3E9475F6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599701C21056
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F10149C50;
	Mon,  5 Aug 2024 07:23:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D12149006
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842632; cv=none; b=BVet36nbLDJFCt4tWkdEiRwXmuxgjQeULRoV7JoWGTfC2mTjKemQ+0bxJ0Pc3JGrH+qwYoOxLNpvvPIEWfba4vcTMlZM8ODre5wXGfgkcOfHYo0IZa7UjkYYrNfKayH2YRvNXWo8gi3YqCPXMgChjCuS1qj5vMQTOLkGLucuMFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842632; c=relaxed/simple;
	bh=jGxNrQyxYkIg93fCVIgqPVaXGqNnR8YL7EzBArjezJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggbHmoQYTTzp1vB+6a76jv3+/aOh9hjEjQdGX9R+o9fpuKwgSbeip+q56tY2UeusiKktE6BIZJs+wx7BIIzX+DpHJi6v1LfSl2I4R5PPkh2n6lPEhHZiwzogv2AHMwzZmDl9VW7hwWbVQbp2t6fvfJ3nf+7l69wNdzT968n4jJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sas4J-0001Pz-VG; Mon, 05 Aug 2024 09:23:47 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sas4I-004ebw-QV; Mon, 05 Aug 2024 09:23:46 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sas4I-002wYS-2K;
	Mon, 05 Aug 2024 09:23:46 +0200
Date: Mon, 5 Aug 2024 09:23:46 +0200
From: Sascha Hauer <sha@pengutronix.de>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2 3/4] wifi: rtw88: usb: Support RX aggregation
Message-ID: <ZrB-AtNmj2NAv752@pengutronix.de>
References: <60856bbc-8701-4aee-804c-3d8c00d4f5c5@gmail.com>
 <ac43a1bb-d735-43df-b6bf-41c44148c9e2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac43a1bb-d735-43df-b6bf-41c44148c9e2@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Sat, Aug 03, 2024 at 12:34:20AM +0300, Bitterblue Smith wrote:
> The chips can be configured to aggregate several frames into a single
> USB transfer. Modify rtw_usb_rx_handler() to support this case.
> 
> RX aggregation improves the RX speed on certain ARM systems, like the
> NanoPi NEO Core2.
> 
> Currently none of the chips are configured to aggregate frames.
> 
> Tested with RTL8811CU and RTL8723DU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v2:
>  - Simplify the code and make it more readable.
>  - Rebase on top of latest rtw-next.
> ---
>  drivers/net/wireless/realtek/rtw88/usb.c | 61 ++++++++++++++++--------
>  1 file changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 10f1d724370e..4c7ba5c76a57 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -546,11 +546,12 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>  	struct rtw_usb *rtwusb = container_of(work, struct rtw_usb, rx_work);
>  	struct rtw_dev *rtwdev = rtwusb->rtwdev;
>  	const struct rtw_chip_info *chip = rtwdev->chip;
> -	struct rtw_rx_pkt_stat pkt_stat;
> +	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
>  	struct ieee80211_rx_status rx_status;
> +	u32 pkt_offset, next_pkt, urb_len;
> +	struct rtw_rx_pkt_stat pkt_stat;
> +	struct sk_buff *next_skb = NULL;

Nit: With the changes in this version initialization to NULL is no
longer necessary.

Otherwise:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

