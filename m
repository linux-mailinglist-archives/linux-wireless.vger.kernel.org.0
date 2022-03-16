Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B104DB359
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 15:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiCPOfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 10:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiCPOfj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 10:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72535874
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 07:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6646961560
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 14:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB08C340EC;
        Wed, 16 Mar 2022 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647441264;
        bh=C6Lt9584D2BMdQ1sVehnMgWojMQ5SjZCZ4NdyebLiF4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YEM9vFhKhtXshQrnM7ZeKg9DxMJc9lMJoAro7+8VXwTxKh1CsqXLzygtmnvQjHVg2
         7E6akZwNFhl16IHbfJYKg0sEvdnd6hKIVLHKHYPPbUaW43FGFwlVVitr9Nc++AAX0A
         +89sj+BIzLV33KqUT4O38CnBKnicQKfEgasHxnBYInRq+kjXvna++VO0bgMX2fnDqo
         xnDl+RoVONXz6RFWCH+BgP79mahYfZrB2YtI4592cVxy63AJgbnnZ0c1vLq9M+sZ+B
         vd7RtYozOBL9seevfR3nHxWzPAtxtTlUZrKUb8AX7AzR51FY6OHa/QHhUcgT6KEeoU
         xi0jTcv2rzLtQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH] ath11k: acquire ab->base_lock in unassign when finding the peer by addr
References: <20220314215253.92658-1-dossche.niels@gmail.com>
        <87o826pgqr.fsf@kernel.org>
        <c0874b06-116d-7471-3b50-21099c729c3d@gmail.com>
Date:   Wed, 16 Mar 2022 16:34:19 +0200
In-Reply-To: <c0874b06-116d-7471-3b50-21099c729c3d@gmail.com> (Niels Dossche's
        message of "Wed, 16 Mar 2022 11:43:30 +0100")
Message-ID: <87k0cuotjo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Niels Dossche <dossche.niels@gmail.com> writes:

> On 3/16/22 07:13, Kalle Valo wrote:
>> Niels Dossche <dossche.niels@gmail.com> writes:
>> 
>>> ath11k_peer_find_by_addr states via lockdep that ab->base_lock must be
>>> held when calling that function in order to protect the list. All
>>> callers except ath11k_mac_op_unassign_vif_chanctx have that lock
>>> acquired when calling ath11k_peer_find_by_addr. That lock is also not
>>> transitively held by a path towards ath11k_mac_op_unassign_vif_chanctx.
>>> The solution is to acquire the lock when calling
>>> ath11k_peer_find_by_addr inside ath11k_mac_op_unassign_vif_chanctx.
>>>
>>> Fixes: 701e48a43e15 ("ath11k: add packet log support for QCA6390")
>>> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
>> 
>> On what hardware and firmware version did you test this?
>> 
>
> Thanks for your reply.
> I am currently working on a static analyser to detect missing locks.
> This was a reported case. I manually verified the report by looking
> at the code, so that I do not send wrong information or patches.
> After concluding that this seems to be a true positive, I created this patch.
> However, as I do not in fact have this particular hardware, I was unable to test it.

Ah, I didn't realise this. If you are using a tool to find errors in the
code it's always a good idea to document that in the commit log. I'll
add an edited version of what wrote you above in the commit log, ok?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
