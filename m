Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2D7D7402
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjJYTMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjJYTMU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:12:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F092191
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:12:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso70210f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698261135; x=1698865935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJE1oxlQfYqBKYgdY9os4N8F8vLdx7K54CDVTJraf3w=;
        b=eUc2/3FF7yx0VmmvhHMsoEFoS6ulqUbTwRr270/lx+Xsq5jjQJlnaHoquaafSt0WOO
         CenzJGVXHX/sSX6D5u27SJeC2k6a9zS9IUup9ZpY0Lb29pOyqjNiXn2ZfV7GhNr99Zvt
         ZBk6timVsYHtuTmRdID4yWHJItubs/B1ViVlhM4h0lZL4SmUV5LnWR61Ujhw5/3jsf5j
         NZzCUY93bx3YOP6dX+nQOcbOhIyr3c2wq89KcvSLPc++ZRI1QfxeeVhxihH7v5yaE/U1
         3CU0ITLH72xwA+JRAlrTRKnvSZAxOZvCETVOm44uoMN9/EcL4tshP/lsAL5x47fY0fQU
         xFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698261135; x=1698865935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJE1oxlQfYqBKYgdY9os4N8F8vLdx7K54CDVTJraf3w=;
        b=uCPFFJ3F02Xa7BpG7TajxeDqxa0DaxjEhxnaTdTVVsCcSgWwawg6q/JbWIXgB9qDnW
         D/BAt07EvtuFHvWV12mvi1KT/q8d/OiktItx1eT+Y7aokPifniPriau8KnJxzUonIaW+
         CDCNekKCPk2nraImV85ikW//7odbwqPL2/RJjxQV/KWDbMGDrTGOsK2yfTmpU9wfVEjP
         gms7Ae+S2WlC23iIGuFrctOcqyUum/iPu953yiJMnHghUEfF6XocgNOgnfqNEPfcn4gu
         8JObUc+lPaVhlJAQPHN9umHDfZVPC7Fljfv0uEu57P5sxZeP5jUPkBLrfl1Oq/QQ/XpH
         +bHw==
X-Gm-Message-State: AOJu0YwsUAjQw2dzXcnp6jLkCZpFs7WD710vxM5ozxKZ4yYdCPBJP09U
        c1Qt9zfR4s6ivqHsfG6M72W2Iw==
X-Google-Smtp-Source: AGHT+IFmQB+pB5vXHCUGxPLndR4N+esrM3X5ULS8AWxa265+wqOl+oIbPQk/vjEZoQVGxg1VO5gHxQ==
X-Received: by 2002:a5d:4e06:0:b0:32d:a3a0:e927 with SMTP id p6-20020a5d4e06000000b0032da3a0e927mr10823356wrt.58.1698261135536;
        Wed, 25 Oct 2023 12:12:15 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b003258934a4bcsm12673992wrt.42.2023.10.25.12.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 12:12:14 -0700 (PDT)
Message-ID: <1d484f6a-669b-e222-391b-43e3b4904097@blackwall.org>
Date:   Wed, 25 Oct 2023 22:12:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next] netlink: make range pointers in policies const
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        j.vosburgh@gmail.com, andy@greyhouse.net, dsahern@kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        vinicius.gomes@intel.com, johannes@sipsolutions.net,
        idosch@nvidia.com, linux-wireless@vger.kernel.org
References: <20231025162204.132528-1-kuba@kernel.org>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231025162204.132528-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/25/23 19:22, Jakub Kicinski wrote:
> struct nla_policy is usually constant itself, but unless
> we make the ranges inside constant we won't be able to
> make range structs const. The ranges are not modified
> by the core.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: j.vosburgh@gmail.com
> CC: andy@greyhouse.net
> CC: dsahern@kernel.org
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: jiri@resnulli.us
> CC: vinicius.gomes@intel.com
> CC: johannes@sipsolutions.net
> CC: razor@blackwall.org
> CC: idosch@nvidia.com
> CC: linux-wireless@vger.kernel.org
> ---
>   drivers/net/bonding/bond_netlink.c | 2 +-
>   drivers/net/vxlan/vxlan_mdb.c      | 2 +-
>   include/net/netlink.h              | 4 ++--
>   net/ipv6/ioam6_iptunnel.c          | 2 +-
>   net/sched/sch_fq.c                 | 2 +-
>   net/sched/sch_fq_pie.c             | 2 +-
>   net/sched/sch_qfq.c                | 2 +-
>   net/sched/sch_taprio.c             | 2 +-
>   net/wireless/nl80211.c             | 2 +-
>   tools/net/ynl/ynl-gen-c.py         | 2 +-
>   10 files changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


