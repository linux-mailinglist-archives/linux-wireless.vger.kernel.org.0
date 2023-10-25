Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B007D7379
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 20:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjJYSl1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYSl0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 14:41:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF36111
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 11:41:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BA1C433C7;
        Wed, 25 Oct 2023 18:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698259281;
        bh=4djJN0UchxV82gc5Kfbil3cSIlrr4hp620DysLpy6rQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A2kN1SE89MjV87IVuJRo4RL+6HJxFoYhUmBM00IPEwCZbxA5FcaEolL5FKL46F53T
         7035yJfsKpFUsKetBFu8OfQC6HqgfKwexdJGRMIirI2YKPw0XiXPuiHF1exGvwkD2f
         7WNHzUGJmk5bOzoKgF7fpxQuVHMSH4na5j0Q/Dx2qZ4O4Dz2CYHdJpuq/5DSnLF1+D
         KFNYdyfieUh406HxeWOA/bxt3bu9+Q3QK8vjTsJns1LXWIfqgn3Xycx+6eW/X3VbGO
         NKTUMeJAM0wlsn8F5JQC5SDAh1nDqCMv1SW5CbtxhFycU2EQqXGC7N1fQZB7C2XB/M
         u/v0tbBlmrh/w==
Message-ID: <0d48d284-3138-4ca7-b622-20400fab7579@kernel.org>
Date:   Wed, 25 Oct 2023 12:41:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netlink: make range pointers in policies const
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        j.vosburgh@gmail.com, andy@greyhouse.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us,
        vinicius.gomes@intel.com, johannes@sipsolutions.net,
        razor@blackwall.org, idosch@nvidia.com,
        linux-wireless@vger.kernel.org
References: <20231025162204.132528-1-kuba@kernel.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231025162204.132528-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/25/23 10:22 AM, Jakub Kicinski wrote:
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
>  drivers/net/bonding/bond_netlink.c | 2 +-
>  drivers/net/vxlan/vxlan_mdb.c      | 2 +-
>  include/net/netlink.h              | 4 ++--
>  net/ipv6/ioam6_iptunnel.c          | 2 +-
>  net/sched/sch_fq.c                 | 2 +-
>  net/sched/sch_fq_pie.c             | 2 +-
>  net/sched/sch_qfq.c                | 2 +-
>  net/sched/sch_taprio.c             | 2 +-
>  net/wireless/nl80211.c             | 2 +-
>  tools/net/ynl/ynl-gen-c.py         | 2 +-
>  10 files changed, 11 insertions(+), 11 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>

