Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31D27EB2A8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 15:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjKNOma (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 09:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKNOma (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 09:42:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140A710D
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 06:42:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD79C433C8;
        Tue, 14 Nov 2023 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699972946;
        bh=DO0fIrMI8bltePP6eFm4dhsUlHVl7Pv0Nlj15MYn/1Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KO14FpRQZD1DSWKdbiNeIGqB2VKa78l1Pa+/WphWykicxbc/RdR0DSVdnq5LpiSYC
         ZFv4FNsQyJyJsfVy3OKTJEv1xA8Pw/Xy8rgsdlm8tgLooNJNxhbQyPCCxn7wUYSe6B
         tfFGJFG6NP5o41A6STzSdQDWKmdenBzkKYRh8yYrGherM77wy/ci4djCFhGBmJYBmP
         8OL7Pd1Z9LO53t24yOlwJ3vM9JLa86f96DK5twBuzF0CYhyleLz0yvNn7Wf05sRs6w
         1Tp95zCCnQdB+W9tJfkhdCR8P0yaA55BIxfGoykGAkliBSZgyFJSieveLUOCaHMHEa
         oxdY6vP6fKgVQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     James Prestwood <prestwoj@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH] wifi: ath10k: add support to allow broadcast action
 from RX
References: <20231017165306.118779-1-prestwoj@gmail.com>
        <169989062657.3473659.188127753057713210.kvalo@kernel.org>
        <2033c16c-4d9a-4592-bb81-7a9ad7821576@gmail.com>
        <87wmuk926d.fsf@kernel.org>
        <c8e75ea8-39b9-4f70-a3e9-3c9c4372cf20@gmail.com>
Date:   Tue, 14 Nov 2023 16:42:24 +0200
In-Reply-To: <c8e75ea8-39b9-4f70-a3e9-3c9c4372cf20@gmail.com> (James
        Prestwood's message of "Tue, 14 Nov 2023 04:30:08 -0800")
Message-ID: <871qcstmzz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

James Prestwood <prestwoj@gmail.com> writes:

>>> Is there some firmware/driver value that can be queried which tells me
>>> if broadcast RX is supported?
>>
>> A good question for which I don't have an answer. Does anyone else
>> know? Do you have a simple test case for this? It would help if
>> people could test this feature on their ath10k devices and send us
>> results.
>
> I could try and come up with something. I've been testing with 2
> devices, running the full DPP protocol between... not exactly
> "simple".

Yeah, that doesn't sound simple.

>>> Or if not is checking ar->hw_rev == ATH10K_HW_QCA6174 good enough?
>>
>> BTW instead of checking ar->hw_rev our preference is to add a new
>> boolean to struct ath10k_hw_params. That way it's easier to enable
>> and disable the feature per hardware version.
>> 
>>> Or are there sub-variants that may or may not support this?
>>
>> There are several QCA6174 variants and you can check the variants
>> from ath10k_hw_params_list. For example, hw2.1 or SDIO firmware may
>> very well behave different from the PCI firmware. To be on the safe
>> side I think it's best to enable the feature only on the hardware
>> versions we have verified to work.
>
> Sounds good, I can make it specific to just my hardware and others
> could expand in the future if they need.

I think that's the best plan.

> Out of curiosity is ath9k much more limited on unique hardware? I
> based this patch off one from Jouni for ath9k [1] and it
> unconditionally enables it for the entire driver.

ath9k doesn't have firmware, or well ath9k PCI devices don't have one,
and that makes things so much simpler. Don't know how thin (or bloated)
ath9k USB firmware is.

Starting from ath10k a firmware was introduced for all 11ac devices, and
not just "the one and only firmware" but N+1 different branches of
firmware. So even if something works with one firmware branch there's no
guarantee how it works in the other N branches. Great fun supporting
that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
