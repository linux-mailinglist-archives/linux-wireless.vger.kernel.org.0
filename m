Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878681124C1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 09:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLDI0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 03:26:40 -0500
Received: from mxex1.tik.uni-stuttgart.de ([129.69.192.20]:35590 "EHLO
        mxex1.tik.uni-stuttgart.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbfLDI0k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 03:26:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id CC9966011E;
        Wed,  4 Dec 2019 09:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:references:from:from:subject:subject:received
        :received; s=dkim; i=@tik.uni-stuttgart.de; t=1575447995; x=
        1577186796; bh=4KWM1XBZ9rwDoGScGVoXtYAPEj/RElX/niG/7fRClto=; b=S
        zFjpj3vOTwKr2z905+awhZL+6Ldkdzb2ejvVJdF2y8Itpu5W7HrEHBpUws3UHOb5
        oa94nJQA+HvKnH/Upazv8d3SmR9uRjCxHjUEasi/4fx8Q9RxtQGJdFPI/2Qm63Id
        9huOnxj7a3mkPe7EAmQr7rxqcXhrhkMDYqzKhWNupFXRXWhQ9QjVPMuzLNdbUn1C
        TFtXKt2Z1VVOCSTBVS/9flYKyeEGiQB8WbhRrvW34g4Qd/7Jt6mwZzewRFuuo1W5
        lp5pVnlSVXy17gDXmHBr49hQbK9hO/uBYLyKW/6rNrV0mzM39rTIyDKywDpSNOpW
        SaVK5bZCbGmYJy8A0X5iA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
        by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10031)
        with ESMTP id 1DSdc1-XL1Mu; Wed,  4 Dec 2019 09:26:35 +0100 (CET)
Received: from [IPv6:2001:7c0:7c0:111:940f:c889:bf4a:6f4a] (unknown [IPv6:2001:7c0:7c0:111:940f:c889:bf4a:6f4a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA;
        Wed,  4 Dec 2019 09:26:35 +0100 (CET)
Subject: Re: [PATCH] cfg80211: fix double-free after changing network
 namespace
From:   "=?UTF-8?Q?Stefan_B=c3=bchler?=" 
        <stefan.buehler@tik.uni-stuttgart.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
References: <20191126100543.782023-1-stefan.buehler@tik.uni-stuttgart.de>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.buehler@tik.uni-stuttgart.de; prefer-encrypt=mutual;
 keydata=
 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
 rwHRmQ==
Message-ID: <22d78eff-9975-e2eb-5093-b19f93831bce@tik.uni-stuttgart.de>
Date:   Wed, 4 Dec 2019 09:26:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126100543.782023-1-stefan.buehler@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 11/26/19 11:05 AM, Stefan Bühler wrote:
> From: Stefan Bühler <source@stbuehler.de>
> 
> If wdev->wext.keys was initialized it didn't get reset to NULL on
> unregister (and it doesn't get set in cfg80211_init_wdev either), but
> wdev is reused if unregister was triggered through
> cfg80211_switch_netns.
> 
> The next unregister (for whatever reason) will try to free
> wdev->wext.keys again.
> 
> Signed-off-by: Stefan Bühler <source@stbuehler.de>
> ---
>  net/wireless/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/wireless/core.c b/net/wireless/core.c
> index 350513744575..3e25229a059d 100644
> --- a/net/wireless/core.c
> +++ b/net/wireless/core.c
> @@ -1102,6 +1102,7 @@ static void __cfg80211_unregister_wdev(struct wireless_dev *wdev, bool sync)
>  
>  #ifdef CONFIG_CFG80211_WEXT
>  	kzfree(wdev->wext.keys);
> +	wdev->wext.keys = NULL;
>  #endif
>  	/* only initialized if we have a netdev */
>  	if (wdev->netdev)
> 

Any status update for this?  Anything I can do?  Should I resubmit this
with "Cc: stable@vger.kernel.org"?

cheers,
Stefan

-- 
Stefan Bühler    Mail/xmpp: stefan.buehler@tik.uni-stuttgart.de
Netze und Kommunikationssysteme der Universität Stuttgart (NKS)
https://www.tik.uni-stuttgart.de/    Telefon: +49 711 685 60854
