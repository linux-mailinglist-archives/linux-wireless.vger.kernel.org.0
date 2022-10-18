Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D95603361
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 21:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJRTdG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 15:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJRTdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 15:33:05 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 12:33:02 PDT
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1477971717
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 12:33:01 -0700 (PDT)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTP
        id kdeko4ldRh3t8ksJGoQKkg; Tue, 18 Oct 2022 19:31:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id ksJ5oFVOoAnjUksJ5opQ6m; Tue, 18 Oct 2022 19:31:20 +0000
X-Authority-Analysis: v=2.4 cv=LsWBd1Rc c=1 sm=1 tr=0 ts=634eff08
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VLn1U4HDsV/kFU42pi1uTw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10
 a=wYkD_t78qR0A:10 a=cak1eodxRRWiubympP0A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B8sItrIzPT1FhGdQ0ENveK914e997Na/QHZvsstLhtM=; b=EtFXKgE3/C7QhFoXgAIqcn+mHq
        n0jpJ1yc89SZFk3QRIYWQbQFlkZdKqHQVNmC25NtWS58DqjR9hP8X7VDgpmbZ5z9sPBo78pcP7MAk
        lTqwTU8S2sLegbh6wRASDikI9wq5d5HT/2cXKFlzchDXxggEfq6ayJ5Ilamr1vBho8EU0ef/ogJKM
        YBMxKWwKUop1rMOwjLtEFiD+UVGKYS2AwP+8ex28C0DBva22ITFJsYwS3LH59OxtuaMrUIgVfpCrx
        iWHsqSFZKD3WenFiqyFkTrKo3lMyMEXfdNeKKlDBWZrd9FWi4zDzBNtc+T6o3Kz1deV1SN+Xh7ImB
        mfQVRQ2Q==;
Received: from [187.184.159.238] (port=8860 helo=[192.168.0.24])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1oksJ4-0006S8-1O;
        Tue, 18 Oct 2022 14:31:18 -0500
Message-ID: <71935a08-e9d3-5f9e-5b9a-7847bd38b756@embeddedor.com>
Date:   Tue, 18 Oct 2022 14:31:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/6][next] cfg80211: Avoid clashing function prototypes
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1666038048.git.gustavoars@kernel.org>
 <291de76bc7cd5c21dc2f2471382ab0caaf625b22.1666038048.git.gustavoars@kernel.org>
 <202210171939.61FFBE79A7@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202210171939.61FFBE79A7@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.238
X-Source-L: No
X-Exim-ID: 1oksJ4-0006S8-1O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.24]) [187.184.159.238]:8860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI7uNThUirW+hTbTdcZo3N2rBKaYGlpWsaJJf2295NHMYDQ9rVHsoc0ClfOqzFBi1WEhtToMgqBQwzVZktYvwcwQ/4RAcXvfWqd8U40EyS5efhv7nz9F
 eua+/k7PbzrRDNzQ8yI/beU+r8TNA7tndI3zu/56NP8wzOTIyFpkI2gKCMB81gQBN3RUBgS6h7R4h5kY/4ejljpsbFFUswQe9bXGBiNBDAPMWUip3CYquy+l
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/17/22 21:41, Kees Cook wrote:

>>   
>>   static const iw_handler	orinoco_handler[] = {
>>   	IW_HANDLER(SIOCSIWCOMMIT,	orinoco_ioctl_commit),
>> -	IW_HANDLER(SIOCGIWNAME,		(iw_handler)cfg80211_wext_giwname),
>> +	IW_HANDLER(SIOCGIWNAME,		cfg80211_wext_giwname),
> 
> This hunk should be in the orinoco patch, I think?

I just didn't want to have this huge patch touching multiple
different files. That's why I decided to split it up into three
separate patches.

But yeah; now it seems like a good idea to merge patches 1 to 3
into just a single patch.

> 
> 
>> [...]
>> +	[IW_IOCTL_IDX(SIOCGIWRETRY)]    = cfg80211_wext_giwretry,
> 
> The common practice seems to be to use IW_HANDLER instead of open-coding
> it like this.
> 
> 	IW_HANDLER(SIOCGIWRETRY,	cfg80211_wext_giwretry),

Yeah; I forget this after reverting Sami's changes:

32fc4a9ad56f ("cfg80211: fix callback type mismatches in wext-compat")

I'll fix it up. :)

Thanks for the feedback!
--
Gustavo
