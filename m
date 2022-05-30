Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E615385FB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 18:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbiE3QRj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiE3QRi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 12:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6EF532E5;
        Mon, 30 May 2022 09:17:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 648E06117C;
        Mon, 30 May 2022 16:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303EFC385B8;
        Mon, 30 May 2022 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653927456;
        bh=qHHh0cjImlR4BLowWXz8QANf5zqTuTKqGuIFNYJaDQk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EkRjYI4wx3Xwo1F4EnuMiAy57LbGC/ZW71t6byocramqJRn7QK0edBSh/Of0yPh6q
         X3rvwY/n/s0XfK6vfRQi9bdReq0il8JNiD29vkk9kPffzVy5dUxS3Wi1Q0vQfBzT+e
         grEWXh60c1egVeCRjUPHVqLNuisxGGferLGuNmyjn250hijZzp0FbtPzjqRkbw2wWF
         xSu8FbdP/fjkrjsxxFHHiwphisa0C4vBNb30PM+t3jkuxIPv1PXTBNxtu3zh+w5IHn
         EBMrtG3DD2mIttVDh7IYvIrpLp7sd30hZ5hw2UQxywjb0/i9qNoO+JJn3HYqGyMp6L
         gNmPOEkV1q8+Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, mka@chromium.org
Subject: Re: [PATCH v7 4/9] ath11k: Add register access logic for WCN6750
References: <20220429170502.20080-1-quic_mpubbise@quicinc.com>
        <20220429170502.20080-5-quic_mpubbise@quicinc.com>
        <bd6d97a4cc6665d0ee632444f75e3480160387ec.camel@freebox.fr>
        <c57e8791-b6ce-0752-52ca-a1cb938187d7@quicinc.com>
        <c1c3472427080716c69ad99ebe5d1954db44f03f.camel@freebox.fr>
Date:   Mon, 30 May 2022 19:17:29 +0300
In-Reply-To: <c1c3472427080716c69ad99ebe5d1954db44f03f.camel@freebox.fr>
        (Maxime Bizon's message of "Mon, 30 May 2022 16:19:06 +0200")
Message-ID: <871qwbouzq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maxime Bizon <mbizon@freebox.fr> writes:

> On Thu, 2022-05-26 at 09:12 +0530, Manikanta Pubbisetty wrote:
>
>> 
>> Thanks for letting me know about this, IIRC I don't remember 
>> encountering this problem in my testing. Just for my understanding,
>> have you reverted this change and confirmed that these errors go away
>> ?
>
> I first confirmed the register location was indeed incorrect, then I
> fixed it like this:

Looks good to me. Can you submit that as a proper patch?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
