Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6CE76B69E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjHAOC3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjHAOCN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:02:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B761F1704
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC9A615B8
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 14:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FD7C433C8;
        Tue,  1 Aug 2023 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690898531;
        bh=xN9WItc/524GYuL6CKLrjp85TZ7y8WHMjHcz9E9K7Hg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hb6kDjaFUkJn3BRoVvETND5fOlsXOEE4Tn3u3+/97Oz0xQG3xNUB1Abq8wKZftwvX
         Mdyrnb70o4b7YqS54sVzOU68rnqiAtvH3yDxpT0eSgvQ27oscL0rhSySPjBatnt5en
         g7CL4//DhvNqjRAaS45761mAiDjkddmkIikNkIDs2F5uELcnP9J6P0wi0dxMob4XS7
         9Ljfc3qEfmOm/IlryRL/UdQeYTaYSj+v4n7Ww3ripZcA54Sv43LzE+UEFFIIXf62+8
         vE/o9/YrxUUftuIAbYzi88TcHejmxLd4iepDUi/WL2OCnfJcjP8YEGPAxABvQ+tDdB
         j1MNz/6FEtqRw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Doug Brown <doug@schmorgal.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/4] wifi: libertas: add missing calls to
 cancel_work_sync()
References: <20230724084457.64995-1-dmantipov@yandex.ru>
        <87cz0h3d1q.fsf@kernel.org>
        <ae49815a-c125-5a22-6757-b526d9712103@yandex.ru>
        <87r0onxdra.fsf@kernel.org>
        <0368ccdc-74f4-6ec1-1b7d-cfb5ebfd479d@yandex.ru>
        <87mszayj8x.fsf@kernel.org>
Date:   Tue, 01 Aug 2023 17:02:08 +0300
In-Reply-To: <87mszayj8x.fsf@kernel.org> (Kalle Valo's message of "Tue, 01 Aug
        2023 16:39:26 +0300")
Message-ID: <87bkfqyi73.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> Dmitry Antipov <dmantipov@yandex.ru> writes:
>
>> On 8/1/23 13:23, Kalle Valo wrote:
>>
>>> Another problem I see that you don't always reply to review comments and
>>> that gives an impression that the comments are ignored. Please always
>>> try to reply something to the review comments, even if just a simple
>>> "ok" or "I don't agree because...".
>>
>> Looking through my e-mails for the previous month, I was unable to find an
>> unanswered review. Could you please provide an example? I'll fix it
>> ASAP.
>
> You have sent so many patches and I don't have time to start go through
> them. Maybe I noticed that with some of mwifiex patches, not sure. But
> that doesn't matter, I just hope that in the future you reply to
> comments.

While going through patches in patchwork I noticed this dicussion:

https://patchwork.kernel.org/project/linux-wireless/patch/20230726072114.51964-2-dmantipov@yandex.ru/

As there's no reply to Brian it gives a feeling that you are ignoring
our comments.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
