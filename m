Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA37B7744
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 06:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbjJDEwj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 00:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjJDEwi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 00:52:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30344A6
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 21:52:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18B3C433C7;
        Wed,  4 Oct 2023 04:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696395153;
        bh=bmz9UQhUwxneKugEZjPBwy3A+0A9FRso7QR2GGJWT34=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=u+4VIXQHAjhDgrmsxDUZAC8NpIOSySZndTIVjHZxB+n8xlxuAX6H1b/Kd9EMMhO13
         9/W2KHBFAn3R84aARvh8lGR+UVtwwpUqwigkSeiBxT3Kp6ivtUlX0pHijSmV1VvBSq
         sIv5YeQPkYZ4UfbK5q/govht4htnLTlehaHroTHWJH5zHqrp5D9zvu29NggwISK/Rs
         Pa2BSe9UHHIOicinkEEtkp8qpXKDO2EUt3JnrF+9dVx4XjIj3Y1YH/lWxLnmiQ3N1E
         Y0mrx97VDB5OCNpDsua2NgmFU9MbXLHA9/UlkknYWzEdCB+mzozflM80dDJqmjtJqi
         alNkc4J2u6t8w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] wifi: ath11k: fix Tx power value during active CAC
References: <20230912051857.2284-4-quic_adisi@quicinc.com>
        <169634351476.120947.13624704208026863471.kvalo@kernel.org>
        <735c1318-2a6d-4247-8220-868f63f08578@quicinc.com>
Date:   Wed, 04 Oct 2023 07:54:49 +0300
In-Reply-To: <735c1318-2a6d-4247-8220-868f63f08578@quicinc.com> (Aditya Kumar
        Singh's message of "Wed, 4 Oct 2023 07:39:44 +0530")
Message-ID: <874jj7htra.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> On 10/3/23 20:01, Kalle Valo wrote:
>> Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:
>> 
>>> Tx power is fetched from firmware's pdev stats. However, during active
>>> CAC, firmware does not fill the current Tx power and sends the max
>>> initialised value filled during firmware init. If host sends this power
>>> to user space, this is wrong since in certain situations, the Tx power
>>> could be greater than the max allowed by the regulatory. Hence, host
>>> should not be fetching the Tx power during an active CAC.
>>>
>>> Fix this issue by returning Tx power as 0 during active CAC since it
>>> is known that during CAC, there will be no transmission happening.
>> The returning as 0 doesn't seem to match the code. Should I change
>> the sentence to:
>> "Fix this issue by returning -EAGAIN error so that the user space
>> knows there's
>> no value available right now."
> Oops. Looks like only in commit message its still zero. Its changed to
> return -EAGAIN in code.
>
> +	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
> +		mutex_unlock(&ar->conf_mutex);
> +		return -EAGAIN;
> +	}
>
> So could you just rectify while applying or should I resend?

No need to resend because of this. I changed the commit message now to
this in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6eacc3b5a70ab3f92f9410839870edbb21c9d051

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
