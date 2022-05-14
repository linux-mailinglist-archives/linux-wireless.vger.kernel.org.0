Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ACF526F3E
	for <lists+linux-wireless@lfdr.de>; Sat, 14 May 2022 09:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiENEZM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 May 2022 00:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiENEZK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 May 2022 00:25:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CD52D3F58
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 21:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AE6260B03
        for <linux-wireless@vger.kernel.org>; Sat, 14 May 2022 04:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D61C340EE;
        Sat, 14 May 2022 04:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652502307;
        bh=GpwfvokPbAX7dabaFpWTDJOOyuLpy0kuKAxPhaY6AA4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hQxvF8qnUVshBVs5QA+7Eq/emzEDdtb+ah08qGZXaSyPbpPfhnEJVA9z2xLdATH0l
         EmFzBFO42QwaB+5xe82GckDBM7X84CBv5SCtZDMm1ces7HkAmwH3LXGDF3X4cqDwvY
         rUlavSPy4XTmzbtK3JEzdwiGME0+ItcWVZjboTX1sGdQxwBfNp8HS0JnSb4AL76i7G
         29EuHMezaapDpufLi6jDuU+n8jqi9gf09s554hM+9sU0CF5goZPDG/hFVLtC2NXMYK
         OOCBXinLOX6Gm1hgofKgmjGTrodwW7QOWIPHsY4jCAuux+1TiWzrVbpSYByAi6R6kj
         IZWRANlpYQJ5A==
From:   Kalle Valo <kvalo@kernel.org>
To:     viktor.barna@celeno.com
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, kuba@kernel.org,
        linux-wireless@vger.kernel.org, oleksandr.savchenko@celeno.com,
        shay.bar@celeno.com
Subject: Re: [RFC v1 000/256] wireless: cl8k driver for Celeno IEEE 802.11ax devices
References: <87mtrmicj8.fsf@codeaurora.org>
        <20220513211140.2596547-1-viktor.barna@celeno.com>
Date:   Sat, 14 May 2022 07:25:02 +0300
In-Reply-To: <20220513211140.2596547-1-viktor.barna@celeno.com> (viktor
        barna's message of "Sat, 14 May 2022 00:11:40 +0300")
Message-ID: <87a6bkyc4h.fsf@kernel.org>
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

viktor.barna@celeno.com writes:

> Kalle Valo <kvalo@codeaurora.org> wrote:
>> I'm not going to review a driver with a disclaimer like this.
>     
> Hi Kalle,
>
> first of all, thanks for the comment, we are very sorry for the
> prolonged delay in the response - comments from Johannes were taken into
> account and the new RFC is almost ready and on the way. Regarding the
> disclaimer mistake - our mail gateway automatically appends such text by
> modifying original message and it was not detected earlier because of the
> advanced filters which skipped such appending in internal tests. Many
> apologizes for that. Now the filter has several new exceptions for kernel.org
> and friends.
>
> Can you, please, respond to this email with info whether the disclaimer is
> still present in your inbox? That will help to continue with RFCv2. 

I don't see any disclaimers now, thanks for fixing it. Also lore looks
good:

https://lore.kernel.org/all/20220513211140.2596547-1-viktor.barna@celeno.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
