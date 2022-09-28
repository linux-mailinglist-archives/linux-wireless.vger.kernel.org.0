Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069345EDB60
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiI1LJ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 07:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiI1LI3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 07:08:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89155A881
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 04:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93428B82026
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 11:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2387BC433C1;
        Wed, 28 Sep 2022 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664363241;
        bh=MZRYVN8n01mISKXQS/OmAHWF2ffxXIgwTwxGYHLniGU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RPvigx2j92b1z8YRREWqOgCyO9woAnuhAhSA+QJMUr5CzZJJ63ndP8UxcxOyP/aDq
         zfP5pEg0pCjiWnCi6fUMJ05r3Q32j54lxGjlIn2NrzF9RCVPpa2zttzCGI274TlRFO
         7Ika+w6uznAnVzVZc8u50EFadfvTDczgWf6QyZefl5xIvUtHRjAqt0WFTOEC8bg4hW
         Xx6bXQJE4Ky3lOhtQLKXb7WxJ5cy0/r0Mc+H5HzBnB+OAJ9SEpB4c3hiyMzMeSE+/D
         /KJBj07i8zm3f4YY8bgI+EQY19sxn7A99I3tr99ar6JeGKyBSgdt1yNoc5y5cqeGYv
         FOpfTajOwlU/g==
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
        <8735cb7v0c.fsf@kernel.org>
        <25f998e2-20e9-fcb5-2518-8aef1033ecc0@gmail.com>
Date:   Wed, 28 Sep 2022 14:07:18 +0300
In-Reply-To: <25f998e2-20e9-fcb5-2518-8aef1033ecc0@gmail.com> (Bitterblue
        Smith's message of "Wed, 28 Sep 2022 12:52:27 +0300")
Message-ID: <87zgejrc49.fsf@kernel.org>
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

> On 28/09/2022 11:39, Kalle Valo wrote:
>
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>> 
>>> I guess I have to send a different patch for this now.
>> 
>> So what should I do with this patchset? Can I take patches 2-4?
>
> Yes, please. They're all independent.

Very good, so I'll then take patches 2-4. I'll drop patch 1 and wait for
the next version.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
