Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE6E77FFC3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355294AbjHQVXT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 17:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355322AbjHQVW5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 17:22:57 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E76E56
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 14:22:54 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id We1nqXag1WU1cWkSDqMXfU; Thu, 17 Aug 2023 21:22:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WkSDqT96Q234eWkSDqFfoX; Thu, 17 Aug 2023 21:22:53 +0000
X-Authority-Analysis: v=2.4 cv=cPzzD3SN c=1 sm=1 tr=0 ts=64de8fad
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=stkexhm8AAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=pIW3pCRaVxJDc-hWtpF8:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WMTEtoZYgunGGNiDKyCUfv/YwFOmWcnbP9DZsuaFRbU=; b=eJpXyuRPPP1dJu6Z/jtCpkeXCX
        38KqT2/3wwGNmhNCF7muzcl8j5ehDY40SlFAWIjAwTxDeuki/uqa71bppUI+XHPKGaiqWfYlW9ufY
        5uDANIJeGRR2/s7iiUE/xKddAaloO/+u2ovEcr8d2u/ZDgb4wHIvs60G0+PwIlX32VsF2yiixmo0H
        hEUq7L083A64B6dS8z9/yBhkUMU3FLLakPfYMcW28ChoZQV9HffLUOcUUj6ALBGeaGg5FtWkiYXPZ
        sIn8gMc3Yc8YjauM2wtw+HFYSJyS3ShkfsoRQgdJqm8KIEwHujLSni/vMRlJksoAyzSNBAXMQcJN1
        sDpu/Apw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:42350 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWkSB-001kdk-30;
        Thu, 17 Aug 2023 16:22:51 -0500
Message-ID: <bc0cb25d-fab4-e9d7-5917-34a36a68468f@embeddedor.com>
Date:   Thu, 17 Aug 2023 15:23:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/7] wifi: cfg80211: Annotate struct cfg80211_cqm_config
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230817211114.never.208-kees@kernel.org>
 <20230817211531.4193219-2-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817211531.4193219-2-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qWkSB-001kdk-30
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:42350
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 69
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI/rwuDsdqRjE0dRf3AY1gB0VAkbyl5gZgZJSVNDhdSKG+nXei0qI3K2A94SQpoLzwaDTT0TdYY5Px8YdRiwxR3h9lDDdFPctK6PFgF2hGYbgy4/KXVe
 7whtvxMFD5ZPwAUyX7YpWMFf2Y2XlC6FTdOuFXxd+0KSJ/fYguLI23nPI9a+NVvCEm3GD5PfFs6IQSvpjNOoCRyiaXvZwow/swF6X0qt7OSJCvcXsgn9w2Pt
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/17/23 15:15, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cfg80211_cqm_config.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   net/wireless/core.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/wireless/core.h b/net/wireless/core.h
> index 8a807b609ef7..507d184b8b40 100644
> --- a/net/wireless/core.h
> +++ b/net/wireless/core.h
> @@ -298,7 +298,7 @@ struct cfg80211_cqm_config {
>   	u32 rssi_hyst;
>   	s32 last_rssi_event_value;
>   	int n_rssi_thresholds;
> -	s32 rssi_thresholds[];
> +	s32 rssi_thresholds[] __counted_by(n_rssi_thresholds);
>   };
>   
>   void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev);
