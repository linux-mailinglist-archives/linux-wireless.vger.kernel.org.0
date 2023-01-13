Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C92669D2A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 17:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjAMQFq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 11:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjAMQFP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 11:05:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08798FD28
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 07:57:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 996F862230
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 15:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3436C433EF;
        Fri, 13 Jan 2023 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673625440;
        bh=5Xi3jJguTbfN6z9+ujVfjfTlpKMjauoUdyDcaQ9FkGE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gp1uYNiAvFINOEHcRLkS5XOFZcVYheztXteNuAV7j8wqo5Pntd/LUq/4yyD5EA9OH
         40Nt4cYOp9sXV8lbk58D0xQAkkKwruhQ/3M0SH9toGwme8b0GCMN3ajN1YPpNW8QQf
         hcyCQRsV2cBYMphae5GD3Mgo5mxXrhXdFcHPlgW5jNXGOYVCQJ3+GOyRq8M+z5gWBi
         YVMR95lKMimxd8BM+4MTiYvbhvq8fzgiZw1D4aFWLlW4PFzqUC2asGYoSq7A6Hehqj
         UwjHbs1L6fM+7xFu9tbPHRnlCMebmOpG5Xe5r3kxAGD5Aq5JIAO8maTAXyMRuYdJze
         lvJfDaDWMOPag==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Linux kernel regression tracking \(Thorsten Leemhuis\)" 
        <regressions@leemhuis.info>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH wireless 3/3] wifi: mt76: dma: fix a regression in adding rx buffers
References: <20230113105848.34642-1-nbd@nbd.name>
        <20230113105848.34642-3-nbd@nbd.name>
        <ce9a1141-810a-491a-1293-67beb46efb1f@leemhuis.info>
Date:   Fri, 13 Jan 2023 17:57:17 +0200
In-Reply-To: <ce9a1141-810a-491a-1293-67beb46efb1f@leemhuis.info> (Linux
        kernel regression tracking's message of "Fri, 13 Jan 2023 13:07:54
        +0100")
Message-ID: <87sfgebf6q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Linux kernel regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> On 13.01.23 11:58, Felix Fietkau wrote:
>> When adding WED support, mt76_dma_add_buf was accidentally changed to set
>> the skip_buf0 flag for tx buffers on the wrong queue descriptor entry.
>> Additionally, there is a rxwi leak when rx buffer allocation fails.
>
> thx for working on this
>
>> Fix this and make the code more readable by adding a separate function for
>> adding rx buffers.
>> 
>> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>
> Many thx for taking care of this. There is one small thing to improve,
> please add the following tags here to make things easier for future code
> archaeologists and give proper credit:

I can add those.

> Link:
> https://lore.kernel.org/r/CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre%2BXJS_s5FgVteYA@mail.gmail.com/
> Reported-by: Mike Lothian <mike@fireburn.co.uk>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216829
> Reported-by: AngeloGioacchino Del Regno

But the email is missing for AngeloGioacchino.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
