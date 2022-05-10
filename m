Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF635224BC
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 21:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiEJT2Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 15:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243829AbiEJT1x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 15:27:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2875D39813
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 12:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0E20B81F70
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 19:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCE2C385C2;
        Tue, 10 May 2022 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652210848;
        bh=5joIHAuRNLNHToSfeuBBqX17xHMOEVop/AOqjxOtWEw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GEcQGy6dWjYB7Fa0gQmDktVJVtN2AcCcJJ92HHDg+73q+xNIHyymQaJlGuYyjHkH+
         O5VBCXjdSWHSAlISobpUThlUsOurAjakCSUInapAEeXczXCXYUSWPb7Hm797FJ6GwV
         ilymEiUKGjP67yA06PzC10qc+/TM7dhu3NS9fmqu2CTEXzcJlCCdHEa80BvuN7Joio
         IyVBvteZnb2VIaPHQKlSZPR53ljSbuk9Cri2MlqkbXspNuD28z1yVEqFquCZnkoeWV
         zUZ8QNIhC587W5dyOIFWWtwM5S2oSlOAAnEJZJoLQ+67s7cHKfvDyTDhKW/vPFccfr
         INGTqHLNv9F8g==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 45CF034E351; Tue, 10 May 2022 21:27:25 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        Alexander Wetzel <alexander@wetzel-home.de>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: Simplify queue selection
In-Reply-To: <b900d560d5dabaea1a9faf9d8ff8a019ed813e25.camel@sipsolutions.net>
References: <20220510155828.9406-1-alexander@wetzel-home.de>
 <54589d98-882c-cee4-dd6d-140d50f400d0@nbd.name>
 <b900d560d5dabaea1a9faf9d8ff8a019ed813e25.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 10 May 2022 21:27:25 +0200
Message-ID: <87tu9xw5lu.fsf@toke.dk>
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

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2022-05-10 at 18:10 +0200, Felix Fietkau wrote:
>> On 10.05.22 17:58, Alexander Wetzel wrote:
>> > Let iTXQ drivers also register four queues in netdev and move queue
>> > assignment to ndo_select_queue(), like it's done for other drivers.
>> > 
>> > This gets rid of a special case in mac80211 and also increases the
>> > chance that when we call skb_get_hash() the skb is still hot in the CPU
>> > buffers.
>> > 
>> > Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
>> 
>> This has the disadvantage of requiring a redundant sta lookup in the tx 
>> path for iTXQ drivers. I think the CPU cost of that one is probably 
>> higher than any potential gain from calling skb_get_hash a bit earlier.
>> 
>
> However, that's independent - we can still calculate the hash there, and
> then bail out, i.e. put it right before the "if (wake_tx_queue) return"
> part, no?
>
> OTOH we don't even need the hash in the other cases, do we?

Nope, that was my point on the "moving it to shared netdev core"
question :)

-Toke
