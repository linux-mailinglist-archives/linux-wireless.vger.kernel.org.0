Return-Path: <linux-wireless+bounces-10668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27014940881
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 08:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E621C2289A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 06:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6E10E3;
	Tue, 30 Jul 2024 06:40:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28A524C
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321601; cv=none; b=kuG+a7LVrK59GnSCSjUa2H+P/tg2DFgjyEogiPVV4Ij+oeMNCjcsAOfIv6Svr641WdipqTgAhnnheZVa3+zeUA8jZ+6T0ScqUckfi13dkhGIbb8Nl3CHyV0jKlvwQdcuRREsVxN2y/t8lvqx7RVQhi0lvmhXcaZCeDe3Bs0pAkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321601; c=relaxed/simple;
	bh=1+uEfNJ+Xzfk0mVZqR8mqbwIpkLDZauGP0/KFKMFQtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTjd/vl2HR9dUbz7IgFzF9Nj/s4qFHC32iZ6tP0ivjAahyfNwNiB5fnb0nggNV3h9UUFvd8zTr9XgQIiPWYTHHP1yXLWXhLCl/su+NAeDBwAn72SxUYx7V8ldQqbDqiOcNaUWQ1SzPGB1Xu0nyUY/5n65ae01ug9PJGR1xIiKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sYgWX-00047a-Vh; Tue, 30 Jul 2024 08:39:54 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sYgWX-003Ds1-BJ; Tue, 30 Jul 2024 08:39:53 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sYgWX-0092jf-0n;
	Tue, 30 Jul 2024 08:39:53 +0200
Date: Tue, 30 Jul 2024 08:39:53 +0200
From: Sascha Hauer <sha@pengutronix.de>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH 3/4] wifi: rtw88: usb: Support RX aggregation
Message-ID: <ZqiKuUI_9Pk4ktXk@pengutronix.de>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
 <a549707a-09f4-4787-8111-65cc266675d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a549707a-09f4-4787-8111-65cc266675d6@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Sun, Jul 28, 2024 at 10:42:32PM +0300, Bitterblue Smith wrote:
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
>  drivers/net/wireless/realtek/rtw88/usb.c | 57 +++++++++++++++---------
>  1 file changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 73948078068f..d61be1029a7b 100644
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
>  	struct sk_buff *skb;
> -	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
> -	u32 pkt_offset;
>  	u8 *rx_desc;
>  	int limit;
>  
> @@ -559,29 +560,44 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>  		if (!skb)
>  			break;
>  
> -		rx_desc = skb->data;
> -		chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
> -					 &rx_status);
> -		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
> -			     pkt_stat.shift;
> -
> -		if (pkt_stat.is_c2h) {
> -			skb_put(skb, pkt_stat.pkt_len + pkt_offset);
> -			rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
> -			continue;
> -		}
> -
>  		if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
>  			dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");
>  			dev_kfree_skb_any(skb);
>  			continue;
>  		}
>  
> -		skb_put(skb, pkt_stat.pkt_len);
> -		skb_reserve(skb, pkt_offset);
> -		rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
> -		memcpy(skb->cb, &rx_status, sizeof(rx_status));
> -		ieee80211_rx_irqsafe(rtwdev->hw, skb);
> +		urb_len = skb->len;
> +
> +		do {
> +			rx_desc = skb->data;
> +			chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
> +						 &rx_status);
> +			pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
> +				     pkt_stat.shift;
> +
> +			next_pkt = round_up(pkt_stat.pkt_len + pkt_offset, 8);
> +
> +			if (urb_len >= next_pkt + pkt_desc_sz)
> +				next_skb = skb_clone(skb, GFP_KERNEL);

You could add a:
			else
				next_skb = NULL;

here and drop the next_skb = NULL from the end of the loop. No
functional change, but easier to read.

> +
> +			if (pkt_stat.is_c2h) {
> +				skb_trim(skb, pkt_stat.pkt_len + pkt_offset);
> +				rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
> +			} else {
> +				skb_pull(skb, pkt_offset);
> +				skb_trim(skb, pkt_stat.pkt_len);
> +				rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
> +				memcpy(skb->cb, &rx_status, sizeof(rx_status));
> +				ieee80211_rx_irqsafe(rtwdev->hw, skb);
> +			}
> +
> +			skb = next_skb;
> +			if (skb)
> +				skb_pull(next_skb, next_pkt);

You could use skb instead of next_skb here. Both are the same, so no
functional change, just makes it a bit easier to read when you use the
same variable that you just tested for validity.

> +
> +			urb_len -= next_pkt;
> +			next_skb = NULL;
> +		} while (skb && urb_len >= pkt_desc_sz);

You can drop the urb_len >= pkt_desc_sz check. It will be exactly true
when skb is non NULL as well.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

