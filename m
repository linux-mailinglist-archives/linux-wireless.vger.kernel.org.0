Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215475ED808
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 10:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiI1Ij4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 04:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiI1Ijl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93E10058
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 01:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26AA8B81FB7
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 08:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA2EC433D6;
        Wed, 28 Sep 2022 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664354375;
        bh=UX9o8cTXGsuabPEvyNbJc5Efz2HLQGaOHXF5BvL8Vh0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qaYSeuPLaoriZCSCTMi+ZtaR/xmjxnggCQhBsEqf/98qC8HlgZGN7fLD3tFBSP2vL
         sXLlXy2Ls7oqts6q+uVfvjgQwfFFJEg8jPC8DispaKd2zSKew1suQbH+Gw6zy0+q7x
         xMYumOSJ2ituwe7vX2E8oD7Vn7fYC1PJfFb/l9IgbniYRGWENcHrHtNuz5phQqgesH
         Ut/emCgnmDS28ns0faY11ISNEFY8MUtZTuEsfngBlLstaHdf9sufZ2kXlzzx8dgExg
         j548UKqblZAcwymOz7DcdnYI67GM04pDeDmOpMluqgWmYPo0NDks5KLjExEPy+bCqq
         Af6UnsOAyI8fg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        linux-wireless@vger.kernel.org, chris.chiu@canonical.com,
        Barry Day <briselec@gmail.com>
Subject: Re: [PATCH 1/4] wifi: rtl8xxxu: gen2: Turn on the rate control
References: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
        <78cec57b-2678-acf3-99b3-271e0f9bdbad@gmail.com>
        <ac73924f-4c52-b8e6-1628-e34fc673a35d@gmail.com>
        <5ba1e0f4-6eda-43bb-d426-e2a9447cd06e@gmail.com>
Date:   Wed, 28 Sep 2022 11:39:31 +0300
In-Reply-To: <5ba1e0f4-6eda-43bb-d426-e2a9447cd06e@gmail.com> (Bitterblue
        Smith's message of "Tue, 27 Sep 2022 22:49:05 +0300")
Message-ID: <8735cb7v0c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> On 25/09/2022 19:53, Jes Sorensen wrote:
>> On 9/18/22 08:35, Bitterblue Smith wrote:
>>> Inform the firmware when connecting to a network. This makes the
>>> firmware enable the rate control, which makes the upload faster.
>>>
>>> Don't inform the firmware when disconnecting from a network, because
>>> that makes reconnecting impossible for some reason:
>> 
>> Have you dug through the vendor driver to see what it does here?
>> 
>> Thanks,
>> Jes
>> 
>
> I hadn't investigated, but since you asked :) I looked into it today.
>
> The vendor driver doesn't do anything weird. Our report_connect
> function *should* work.
>
> And it turns out it does work! I restored the original form of the
> function to test something and reconnecting worked. I couldn't
> reproduce the problem anymore. Not much has changed in rtl8xxxu since
> the last time I tried this, so it was easy to find the reason: fixing
> the queue selection [0] fixed the reconnecting problem. Before, it was
> sending the auth attempts using queue 0x7 (TXDESC_QUEUE_VO). With the
> queue selection fix it uses queue 0x12 (TXDESC_QUEUE_MGNT). Perhaps
> queue 0x7 is not functional when the firmware knows it's not connected
> to a network?
>
> I guess I have to send a different patch for this now.

So what should I do with this patchset? Can I take patches 2-4?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
