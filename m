Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4144530DDF4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Feb 2021 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhBCPSz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Feb 2021 10:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhBCPRM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Feb 2021 10:17:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E578BC061573;
        Wed,  3 Feb 2021 07:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=SAajQ4klDZN/vt6NlpnQzoD/xUvX9qCtrFSgFE30h/Q=; b=gYP64mmy6qQeXfr2rOcZr7FrVl
        xB6AEZc5nEKi0NZo2rN5DkM42of/E7mJE3OzvkwnvtK2MdijGc8b9oRbglAGKLxUAh19SH/LEr2rC
        H0pvDlMkjEIkPxqsoU7G+pmWTvZ7AdNn4CRC4DMfNNWfU/Te3uO54y2Dna3/ud3hJ3ijgfHaI1gg/
        XGbqP1RgXnn2lLO1YksnpBX0cjyaAyhqijQNqERKrqXhCipMrQ9JsBKiYb7EW3d6JPvZyUYk0Fsys
        qKelSuJxRcIM1hJ0z/XjXbRufZ9oVWUGtuYz/8XRci1bqygMkwAvMzQ6xHz6++4fZrqExmi6b3W//
        JRER3oNQ==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7JtM-0002Rx-G1; Wed, 03 Feb 2021 15:16:28 +0000
Subject: Re: [PATCH] rt2x00: remove duplicate word in comment
To:     samirweng1979 <samirweng1979@163.com>, stf_xl@wp.pl,
        helmut.schaa@googlemail.com, kvalo@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20210203063850.15844-1-samirweng1979@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6bf90f62-f14e-9c4a-748b-4923fcae9bef@infradead.org>
Date:   Wed, 3 Feb 2021 07:16:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203063850.15844-1-samirweng1979@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/2/21 10:38 PM, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> remove duplicate word 'we' in comment
> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c b/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c
> index c861811..7158152 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c
> @@ -179,7 +179,7 @@ void rt2x00crypto_rx_insert_iv(struct sk_buff *skb,
>  	 * Make room for new data. There are 2 possibilities
>  	 * either the alignment is already present between
>  	 * the 802.11 header and payload. In that case we
> -	 * we have to move the header less then the iv_len
> +	 * have to move the header less then the iv_len

s/then/than/

>  	 * since we can use the already available l2pad bytes
>  	 * for the iv data.
>  	 * When the alignment must be added manually we must
> 


-- 
~Randy

