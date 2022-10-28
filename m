Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93007610EE5
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 12:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJ1KoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 06:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJ1KoP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 06:44:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5CB66840
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 03:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6970A6278C
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 10:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B6AC433C1;
        Fri, 28 Oct 2022 10:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666953853;
        bh=LJCkbzRzJmPUdZS/GDD0YyCyaxK7rKIIYQdaVBpaOqc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=T9gyet1NUd1GrRtG7/msbRq0LdOanY+tMp/ds9BTOvICFHP9YgjjcfJP1sO1GWg1G
         QD9Yk28kct+sUJCw0ihrUALK3W3JBdY33IZb/BUlMZn0+fdCYIGKDHDomRELb6Sfbk
         Lyo8r2FVZR+TsDExZ147gKmV5zU4AFmlpLLTDoIdI/3Ess7mmOaxz41cRMi2OG7lL3
         QQSPFZjeZ0SF+LiX5ZPmlejjUFi0c+cnoDY5jz2WzUJz9BfG/NzelotAH/16ZytuhI
         zxFlpyagGs4t/Crh1gdKMJ4Q4rGCTMa8hvBrvNOoLmQ6zq3U9EBGw1LHrnu5a4qX9X
         zcMncQxVGKQFw==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     Rahul Bhattacharjee <quic_rbhattac@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: Fix qmi_msg_handler data structure initialization
References: <20221021090126.28626-1-quic_rbhattac@quicinc.com>
        <11e005c2-2363-d63f-9f3f-3ca811737231@chromium.org>
Date:   Fri, 28 Oct 2022 13:44:09 +0300
In-Reply-To: <11e005c2-2363-d63f-9f3f-3ca811737231@chromium.org> (Joseph S.
        Barrera, III's message of "Wed, 26 Oct 2022 12:46:56 -0700")
Message-ID: <87pmecgrd2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Joseph S. Barrera III" <joebar@chromium.org> writes:

> On 10/21/22 2:01 AM, Rahul Bhattacharjee wrote:
>
>>   	},
>> +	{/* end of list */}
>>   };
>
> Do you want to add a comma after that last list element?

I can add that in the pending branch.

>
> Actually, I normally see the last list element simply being
>
>> +	{},
>
> ... with no comment necessary.

I would prefer to have a comment to make it more visible that an empty
element is needed at the end, but I would add that outside of braces?

/* end of list */
{},

Thoughts? I can change this in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
