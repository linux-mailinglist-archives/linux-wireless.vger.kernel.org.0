Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1719EA8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 16:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfEJOES (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 10:04:18 -0400
Received: from [208.74.158.174] ([208.74.158.174]:45378 "EHLO
        mail3.candelatech.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfEJOES (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 10:04:18 -0400
Received: from [192.168.1.47] (104-235-164-208.evrt.wa.frontiernet.net [104.235.164.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 475A513C283;
        Fri, 10 May 2019 07:04:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 475A513C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1557497057;
        bh=UT7XXwLjv+cm5Bmav1pIo62BEvkN/zYwL30xac0ShlA=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=nkWtPSrlPt6sNP/H4ZxnnzlbLA963kuEK05IWqfADSYK72x+VAMDGIJiZJiaqA2TV
         IvwpBjytGHqiVmYPW11uuGvG+BNY/JVfcXL3XNtBQGJk/SS2N/e3GionZPSVMK9eDa
         6cwf+lL9w64UmTztIbnVE3nFS7NCiUPwLGuiIi2s=
Subject: Re: [PATCH] mac80211: remove warning message
To:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org
References: <1557471662-1355-1-git-send-email-yiboz@codeaurora.org>
Cc:     ath10k@lists.infradead.org, Zhi Chen <zhichen@codeaurora.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <7119f24f-5b88-629a-d507-73776b841f65@candelatech.com>
Date:   Fri, 10 May 2019 07:04:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1557471662-1355-1-git-send-email-yiboz@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 05/10/2019 12:01 AM, Yibo Zhao wrote:
> In multiple SSID cases, it takes time to prepare every AP interface
> to be ready in initializing phase. If a sta already knows everything it
> needs to join one of the APs and sends authentication to the AP which
> is not fully prepared at this point of time, AP's channel context
> could be NULL. As a result, warning message occurs.
>
> Even worse, if the AP is under attack via tools such as MDK3 and massive
> authentication requests are received in a very short time, console will
> be hung due to kernel warning messages.

Since it is a WARN_ON_ONCE, how it the console hang due to warnings?  You should
get no more than once per boot?

I have no problem with removing it though.  Seems a harmless splat and I removed
it from my tree some time back as well.

Thanks,
Ben

>
> If this case can be hit during normal functionality, there should be no
> WARN_ON(). Those should be reserved to cases that are not supposed to be
> hit at all or some other more specific cases like indicating obsolete
> interface.
>
> Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
> ---
>  net/mac80211/ieee80211_i.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 2ae0364..f39c289 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -1435,7 +1435,7 @@ struct ieee80211_local {
>  	rcu_read_lock();
>  	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
>
> -	if (WARN_ON_ONCE(!chanctx_conf)) {
> +	if (!chanctx_conf) {
>  		rcu_read_unlock();
>  		return NULL;
>  	}
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
