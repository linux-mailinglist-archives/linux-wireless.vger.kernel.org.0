Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7477FFCB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 23:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355316AbjHQVXw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355310AbjHQVXX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 17:23:23 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E6610C7
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 14:23:15 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTP
        id WjYtq2EAlQFHRWkSZqnkSF; Thu, 17 Aug 2023 21:23:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WkSYqkCtSh9i0WkSYqKgON; Thu, 17 Aug 2023 21:23:14 +0000
X-Authority-Analysis: v=2.4 cv=ZMPEJF3b c=1 sm=1 tr=0 ts=64de8fc2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=stkexhm8AAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=6UV5UrL1aO4bJEFlmkAA:9 a=QEXdDO2ut3YA:10
 a=pIW3pCRaVxJDc-hWtpF8:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=67XmJhrJZPK7WnW7Dqnj65qFJ7gTmNMnn76qKwY3QWk=; b=JzMrfIt16qqhA7uzLnsR8pH9F3
        Gi/zexaVQyk7KbPV2LudUzW0nGp1Uizd8bKYT3TDsB/xnNHTT+3H+0/k6bbryzmf9eRoTmhu4+WBb
        nl6aALgd8SdxJrQaFHOSVe8O0kZV1krmCHmWfTblcQWDnjKVLLg2jFYS3yIBUaWO40hfQRFYktMVM
        VotA2oyE9NFHOY9CLRd2agm2dFtvbz3LYipjpipVTrYFdytOMCRwd0kXOCaAmgqVpyZ4AKQR9VE+a
        z4fmEe/1eEkQHl8uoXAiz/hyB7rayNIPLOYZP9tuQevOP3Cw5Ith3FGR5pp4ceqPXFcf7lkErGHnp
        r0eGPypA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:37514 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWkSX-001l52-1M;
        Thu, 17 Aug 2023 16:23:13 -0500
Message-ID: <2be0a7d9-c671-e014-0814-842d52d9f1e4@embeddedor.com>
Date:   Thu, 17 Aug 2023 15:24:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/7] wifi: cfg80211: Annotate struct cfg80211_pmsr_request
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
 <20230817211531.4193219-4-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817211531.4193219-4-keescook@chromium.org>
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
X-Exim-ID: 1qWkSX-001l52-1M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:37514
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 97
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNPIlTdFrY+yQrZir2t+tlIQqMzatlI+4GDC1JCAsL7OKjmg1NRdsl8d0EOy/vittpLwu500oTjmDjpo7tSplfNV8jZ1FmYsYj4lL7++Zzrn6LBcfbO0
 XOhK04NpfDuj3bFtIXGwORCzy1poDF2EtsfkOvZ7jRU2RWfCwsd2j1dp3+aWnD/IWsNxaX5pWWakb/Db/hsBh5vNGKuq5uOJsncf1+tMzKIWIfpxud6bpgTP
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct cfg80211_pmsr_request.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
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
>   include/net/cfg80211.h | 2 +-
>   net/wireless/pmsr.c    | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 5c7d091b3925..e9ca4726a732 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -3948,7 +3948,7 @@ struct cfg80211_pmsr_request {
>   
>   	struct list_head list;
>   
> -	struct cfg80211_pmsr_request_peer peers[];
> +	struct cfg80211_pmsr_request_peer peers[] __counted_by(n_peers);
>   };
>   
>   /**
> diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
> index 77000a264855..9611aa0bd051 100644
> --- a/net/wireless/pmsr.c
> +++ b/net/wireless/pmsr.c
> @@ -291,6 +291,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
>   	req = kzalloc(struct_size(req, peers, count), GFP_KERNEL);
>   	if (!req)
>   		return -ENOMEM;
> +	req->n_peers = count;
>   
>   	if (info->attrs[NL80211_ATTR_TIMEOUT])
>   		req->timeout = nla_get_u32(info->attrs[NL80211_ATTR_TIMEOUT]);
> @@ -321,8 +322,6 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
>   			goto out_err;
>   		idx++;
>   	}
> -
> -	req->n_peers = count;
>   	req->cookie = cfg80211_assign_cookie(rdev);
>   	req->nl_portid = info->snd_portid;
>   
