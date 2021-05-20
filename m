Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B9C38B761
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbhETTWj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 15:22:39 -0400
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:43496 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236838AbhETTWi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 15:22:38 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1719A7A48;
        Thu, 20 May 2021 12:21:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1719A7A48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1621538476;
        bh=RFqdOk4DSTtGRGbSs3c5rcpwvzKFhaZflNSssSjb0UI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YKGlUr34zYFZA3mU6Jz57c6xjkzHSVZ39vyC0e/xT+rggTzyHTm6rGfBFVLjilW7+
         nBOkHK3wQCjpfF7iMSNpo196MPe1iDI/9F0yzOK0D5xtiC831r2pMiBCY6im1HLcVu
         +m3vqh83mlBVK+JLl4dJwyvpT3rBRdOP2w9HSw6k=
Received: from [10.230.41.88] (unknown [10.230.41.88])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 2D6B91874BE;
        Thu, 20 May 2021 12:21:15 -0700 (PDT)
Subject: Re: [PATCH] wireless: add check of field VHT Extended NSS BW Capable
 for 160/80+80 MHz setting
To:     Wen Gong <wgong@codeaurora.org>, johannes@sipsolutions.net,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20210520034021.14690-1-wgong@codeaurora.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <fe1b7675-23ba-a86e-90db-de5803231e21@broadcom.com>
Date:   Thu, 20 May 2021 21:21:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520034021.14690-1-wgong@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/20/2021 5:40 AM, Wen Gong wrote:
> Table 9-251—Supported VHT-MCS and NSS Set subfields, it has subfield VHT Extended
> NSS BW Capable, its definition is:
> Indicates whether the STA is capable of interpreting the Extended NSS BW
> Support subfield of the VHT Capabilities Information field.
> 
> This patch is to add check for the subfield.

Almost looks good to me, but...

> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>   net/wireless/chan.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/wireless/chan.c b/net/wireless/chan.c
> index 285b8076054b..f7f86bd75cc0 100644
> --- a/net/wireless/chan.c
> +++ b/net/wireless/chan.c

[...]

> @@ -1037,7 +1039,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
>   		cap = vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
>   		if (cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ &&
>   		    cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ &&
> -		    !(vht_cap->cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
> +		    !(ext_nss_cap && vht_cap->cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))

you should not mix logical and binary operators so add braces around the 
binary operation here.

Regards,
Arend

>   			return false;
>   		break;
>   	default:
> 
