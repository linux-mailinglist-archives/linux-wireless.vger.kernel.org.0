Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46A6C58D2
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 22:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCVVdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 17:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVVdg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 17:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC960F74C
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 14:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F16D62199
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 21:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAB7C433D2;
        Wed, 22 Mar 2023 21:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679520813;
        bh=W2TL5AZ/tJj3lq4QOAlRrvTvmOF6SXeRnhJqCoz5wRw=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=ZaBCsZNQ6QthIqidYbXWOTYmzVuVbHh1tHF6QWYa98tjp9etjr7gBjOe47lcaW+Ly
         4cXceuGRafkN9/YHplYvgg1kiykQnJ9PxDxcIpp4WNIYVSpJCAH12qLQ0zsWRlQB/9
         FT8MO9RrzOU62XQB2XsvVBCzHjDvW2eXXdzzZ8bXZhU4hhBNyysElI9bPv7/kMIEOW
         mUZTbTgq++RePP9wIwrtO6ySY0GkSCIx9zkqpvgl0zquj0+5s6HDJk35H4a+F6GpSM
         gRizdN3Dhj1JTirJPohvlaL+VjexugPaF9UKGX+CC48pyd2Jl6zchgmMd65B0e7Nio
         Hn3CXvXvU5gqA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8D26D9E376E; Wed, 22 Mar 2023 22:33:30 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Gregg Wonderly <greggwonderly@seqtechllc.com>,
        linux-wireless@vger.kernel.org
Subject: Re: shift exponent 35 is too large @ ath/ath9k/ar9003_hw.c:1147
In-Reply-To: <E3A9C354-0CB7-420C-ADEF-F0177FB722F4@seqtechllc.com>
References: <E3A9C354-0CB7-420C-ADEF-F0177FB722F4@seqtechllc.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 22 Mar 2023 22:33:30 +0100
Message-ID: <87cz5079p1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Gregg Wonderly <greggwonderly@seqtechllc.com> writes:

> I am receiving a console error message from this driver that appears to be in the following function.  In this function, the chk_dbg variable is 32bits and there is logic that seems to attempt to select from 1 of 2 different 32bit values to get a 64bit wide mask value into chk_dbg from dma_dbg_4 or dmc_dbg_5.
>
> The problem is that the (5*i) shift count should be have i adjusted by the 6 limit used to make the check for which dma_dbg_[45] value selected.
>
>
> static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
> {
> 	u32 dma_dbg_4, dma_dbg_5, dma_dbg_6, chk_dbg;
> 	u8 dcu_chain_state, dcu_complete_state;
> 	bool dcu_wait_frdone = false;
> 	unsigned long chk_dcu = 0;
> 	unsigned int i = 0;
> 	dma_dbg_4 = REG_READ(ah, AR_DMADBG_4);
> 	dma_dbg_5 = REG_READ(ah, AR_DMADBG_5);
> 	dma_dbg_6 = REG_READ(ah, AR_DMADBG_6);
> 	dcu_complete_state = dma_dbg_6 & 0x3;
> 	if (dcu_complete_state != 0x1)
> 		goto exit;
> 	for (i = 0; i < ATH9K_NUM_TX_QUEUES; i++) {
> 		if (i < 6)
> 			chk_dbg = dma_dbg_4;
> 		else
> 			chk_dbg = dma_dbg_5;
> 		dcu_chain_state = (chk_dbg >> (5 * i)) & 0x1f;
> 		if (dcu_chain_state == 0x6) {
> 			dcu_wait_frdone = true;
> 			chk_dcu |= BIT(i);
> 		}
> 	}
> 	if ((dcu_complete_state == 0x1) && dcu_wait_frdone) {
> 		for_each_set_bit(i, &chk_dcu, ATH9K_NUM_TX_QUEUES) {
> 			if (ath9k_hw_verify_hang(ah, i))
> 				return true;
> 		}
> 	}
> exit:
> 	return false;
> }
>
> The for loop seems to need to look like the following:
>
> 	for (i = 0; i < ATH9K_NUM_TX_QUEUES; i++) {
>                int off=i;
> 		if (i < 6) {
> 			chk_dbg = dma_dbg_4;
> 		} else {
> 			chk_dbg = dma_dbg_5;
>                        off = i - 6;
>                }
> 		dcu_chain_state = (chk_dbg >> (5 * off)) & 0x1f;
> 		if (dcu_chain_state == 0x6) {
> 			dcu_wait_frdone = true;
> 			chk_dcu |= BIT(i);
> 		}
> 	}
>

Did you test this? Please send a proper patch :)

-Toke
