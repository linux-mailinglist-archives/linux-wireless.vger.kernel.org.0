Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B79D60C562
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiJYHgX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Oct 2022 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiJYHgJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Oct 2022 03:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5175437E2;
        Tue, 25 Oct 2022 00:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F957617B5;
        Tue, 25 Oct 2022 07:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1850DC433D6;
        Tue, 25 Oct 2022 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666683364;
        bh=csTN+if518gFOuGYlWzyn01/ZqMgQMJaa5htwhFMhvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1P49JiLnbXMLkKWKAQwcLZSo8ZsuUxg5HcnhKUedNDsS3qKT+ioTwHCavQnQKDUPm
         6sVKW3qpzs37cHjAbypmHHF7m55VNF9UbtUMtdSBlLZmHONqN/YM5+QUuIdBoppNe6
         zreakjbjrhh+S+9VCh+jN2DZ5RubOBlCBwspCH8w=
Date:   Tue, 25 Oct 2022 09:36:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     scott.d.constable@intel.com, daniel.sneddon@linux.intel.com,
        Jakub Kicinski <kuba@kernel.org>, dave.hansen@intel.com,
        Johannes Berg <johannes@sipsolutions.net>,
        Paolo Abeni <pabeni@redhat.com>,
        antonio.gomez.iglesias@linux.intel.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] minstrel_ht: Mitigate BTI gadget
 minstrel_ht_get_expected_throughput()
Message-ID: <Y1eSGK5vylNmBbVp@kroah.com>
References: <cover.1666651511.git.pawan.kumar.gupta@linux.intel.com>
 <ceb2bcdc79f1494151e85734fa7bdc639df275bb.1666651511.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb2bcdc79f1494151e85734fa7bdc639df275bb.1666651511.git.pawan.kumar.gupta@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 24, 2022 at 03:57:47PM -0700, Pawan Gupta wrote:
> Static analysis indicate that indirect target
> minstrel_ht_get_expected_throughput() could be used as a disclosure
> gadget for Intra-mode Branch Target Injection (IMBTI) and Branch History
> Injection (BHI).

You define these new TLAs here, but the code comment below does not,
making this code now impossible to understand :(

> ASM generated by compilers indicate a construct of a typical disclosure
> gadget, where an adversary-controlled register contents can be used to
> transiently access an arbitrary memory location.

If you have an "adveraray-controlled register contents", why would you
waste that on a mere speculation attack and not do something better,
like get root instead?

> Although there are no known ways to exploit this, but to be on safer
> side mitigate it by adding a speculation barrier.
> 
> Reported-by: Scott D. Constable <scott.d.constable@intel.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  net/mac80211/rc80211_minstrel_ht.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
> index 3d91b98db099..7cf90666a865 100644
> --- a/net/mac80211/rc80211_minstrel_ht.c
> +++ b/net/mac80211/rc80211_minstrel_ht.c
> @@ -11,6 +11,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/ieee80211.h>
>  #include <linux/minmax.h>
> +#include <linux/nospec.h>
>  #include <net/mac80211.h>
>  #include "rate.h"
>  #include "sta_info.h"
> @@ -1999,6 +2000,14 @@ static u32 minstrel_ht_get_expected_throughput(void *priv_sta)
>  	struct minstrel_ht_sta *mi = priv_sta;
>  	int i, j, prob, tp_avg;
>  
> +	/*
> +	 * Protect against IMBTI/BHI.

This makes no sense here, right?

And you are NOT following the proper networking comment style, didn't
checkpatch complain about this?

> +	 *
> +	 * Transiently executing this function with an adversary controlled
> +	 * argument may disclose secrets. Speculation barrier prevents that.
> +	 */
> +	barrier_nospec();

So how much did you just slow down the normal use of the system?

> +
>  	i = MI_RATE_GROUP(mi->max_tp_rate[0]);
>  	j = MI_RATE_IDX(mi->max_tp_rate[0]);

These are all internal structures, can't you just bounds-prevent the
speculation instead of the hard barrier?

thanks,

greg k-h
