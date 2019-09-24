Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A80BC04C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 04:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394478AbfIXCpl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 22:45:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35856 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfIXCpk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 22:45:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 119D36083C; Tue, 24 Sep 2019 02:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569293140;
        bh=iTfu/83qFIlqNFUe+RnkDzMhW8LE4h055QqEN0+Skbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OQjHsUf55iWzQv26OdqHCcQ3jMkUrMxrJesgnYgO3Zk845r+bxudi44lPcGRK+0x7
         gUBCloTe0ZzfI8lMm03XuLQWf19vcCd9bkjXFd8TWahMSkdzmBp9GvK1AxPTuN+JfJ
         cQizZaH/cGWwcwXYipBoqrVbTiO3e8wUSynYqVTA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5533D602B8;
        Tue, 24 Sep 2019 02:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569293139;
        bh=iTfu/83qFIlqNFUe+RnkDzMhW8LE4h055QqEN0+Skbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FR18QJsPlDJ1f5fpR5tRiTKc+RzV1EeD3Z3/ybJNLlFeeAfypUiNlCJvXTk+NWnpc
         McfYMkpMfYLaXreTm/PjXDO+Pjqpqp/vqHn+dM3e8c7r81LFTbhfly3AcyjT/Au1C6
         2maU7xqoa+9VrUBSKQNF5ln81FIxfymrjcQIDRtY=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 24 Sep 2019 10:45:39 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <87lfuf5ly2.fsf@toke.dk>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
 <1568639388-27291-2-git-send-email-yiboz@codeaurora.org>
 <87pnjyiq7o.fsf@toke.dk> <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org>
 <87sgothmpy.fsf@toke.dk> <8cdece5c030fd95817fb099021c38613@codeaurora.org>
 <87tv98fu6l.fsf@toke.dk> <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org>
 <8736gre3bm.fsf@toke.dk> <198124204167325252fcfcd65e3f2733@codeaurora.org>
 <87ftkp7uuz.fsf@toke.dk> <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org>
 <877e617qg2.fsf@toke.dk> <910d9bb5f9016b29fb2aaeb0b89bac38@codeaurora.org>
 <874l157nrt.fsf@toke.dk> <2935b00bf3e29ad8b2738fe98dc24a76@codeaurora.org>
 <87lfuf5ly2.fsf@toke.dk>
Message-ID: <1b3eab1f2481e0102b284f133605c6c4@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-23 18:47, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
>>> So, instead we need to keep next_txq() the way it is, and just add
>> 
>> Right, should keep next_txq() the way it is.
>> 
>>> 
>>> local->schedule_pos[ac] = rb_prev(node);
>>> 
>>> whenever we remove a node (both in return_txq() and resort_txq()).
>> 
>> Agree, and also we may need to consider case like A is removed and 
>> soon
>> be added back just the same as ii),
>>         B->C->A->D->E
>> then B is schedule, removed and soon added back,
>>         C->A->B->D->E
>> A and B will have a second chance to be scheduled and this may happen 
>> to
>> others as well leading to the infinite loop as you have mentioned
>> previously, so do we need to maintain a schedule_round like we do in
>> DRR? Like,
>>      - If the node is in the same round, by pass schedule, go to
>> rb_next(), either continue loop this round or end this round.
>>      - Increase the schedule_round at the schedule_start() only when 
>> the
>> schedule_pos is NULL.
> 
> Hmm, yeah, I guess we could end up with a loop like that as well.
> Keeping the schedule_round would be a way to fix it, but I'm not sure 
> we
> should just skip that station; maybe we should just end the round
> instead?
I am not sure. I believe, in some cases, the rest of the nodes which 
could be most of the nodes in the tree will not have the chance to be 
scheduled in this round.

> 
>>>>> We'd still need a check in resort_txq() then, but it would make it
>>>>> safe
>>>>> to unschedule in return_txq()...
>>>> Yes, agree with that.
>>>> 



-- 
Yibo
