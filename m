Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900EC20A9B6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgFZAK4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 20:10:56 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46966 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbgFZAK4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 20:10:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 8BF104F7791;
        Fri, 26 Jun 2020 00:10:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dAWo6bD_FtmL; Fri, 26 Jun 2020 00:10:52 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id CDDA34F9333;
        Fri, 26 Jun 2020 00:10:51 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 25 Jun 2020 17:10:51 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Nick Owens <mischief@offblast.org>
Cc:     linux-wireless@vger.kernel.org,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
Subject: Re: [PATCH] rtw88: fix skb_under_panic in tx path
In-Reply-To: <20200625201857.almm27xgzburyxxu@wololo.home.arpa>
References: <20200625201857.almm27xgzburyxxu@wololo.home.arpa>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <3d8546b66a4f2027a7fab1de291ec40f@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-25 13:18, Nick Owens wrote:
> hello :)

Hi Nick :)

> this change fixes a reliable crash on my thinkpad A485.
> 
> please note i have no prior experience doing kernel development or
> sending patches, and i'm not sure if this is a correct approach.

You probably want to submit patches with git-send-email. See 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

> From aa589182d30a0f99e1b3201ed4f3830e8af71dac Mon Sep 17 00:00:00 2001
> From: Nick Owens <mischief@offblast.org>
> Date: Thu, 25 Jun 2020 12:55:41 -0700
> Subject: [PATCH] rtw88: fix skb_under_panic in tx path
> 
> fixes the following panic on my thinkpad A485
> 
> Oops#1 Part3
> <0>[ 3743.881656] skbuff: skb_under_panic: text:000000005f69fd98
> len:208 put:48 head:000000009e2719e8 data:00000000bd3795e0 tail:0xc2
> end:0x2c0 dev:wlp2s0

skb->head and skb->data here are really far (0.5GB) apart. Maybe 
skb->data actually got corrupted earlier?

> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c
> b/drivers/net/wireless/realtek/rtw88/pci.c
> index d735f3127fe8..21b3b268cb25 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -741,6 +741,12 @@ static int rtw_pci_tx_write_data(struct rtw_dev 
> *rtwdev,
>  	else if (!avail_desc(ring->r.wp, ring->r.rp, ring->r.len))
>  		return -ENOSPC;
> 
> +	if (skb_headroom(skb) < chip->tx_pkt_desc_sz &&
> +	    pskb_expand_head(skb, chip->tx_pkt_desc_sz - skb_headroom(skb),
> 0, GFP_ATOMIC)) {
> +		dev_err(rtwdev->dev, "no headroom available");
> +		return -ENOMEM;
> +	}
> +

If it is a headroom issue, you can actually express the needed headroom 
needed by the driver in hw->extra_tx_headroom during init and avoid the 
pskb_expand_head() here.

-- 
thomas
