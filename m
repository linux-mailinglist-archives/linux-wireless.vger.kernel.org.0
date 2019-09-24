Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9192BC420
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 10:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395038AbfIXIbO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 04:31:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39184 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394959AbfIXIbN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 04:31:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BC50E60A05; Tue, 24 Sep 2019 08:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569313872;
        bh=GqzelFHQnjIfdc+3zM21cWOQ47JyWKqJ7pJbqCO19yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AXJQlBHlhk43AwSeP4z2UkYVbv9pJzY+6VVLQ2Yu8nSz/w3fKlyXbRnEEUypC97Y0
         d5SGmWbiiJm3emo/T63QAuuabOt+r6fl2Xq2PCDRkhb6S7P65ipKO1xWH58Eo3nmqU
         Fx8jCX/e1bhvuJUNDPeGgh2YOC9gJgs+jzjfkKYI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3D02160397;
        Tue, 24 Sep 2019 08:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569313872;
        bh=GqzelFHQnjIfdc+3zM21cWOQ47JyWKqJ7pJbqCO19yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AXJQlBHlhk43AwSeP4z2UkYVbv9pJzY+6VVLQ2Yu8nSz/w3fKlyXbRnEEUypC97Y0
         d5SGmWbiiJm3emo/T63QAuuabOt+r6fl2Xq2PCDRkhb6S7P65ipKO1xWH58Eo3nmqU
         Fx8jCX/e1bhvuJUNDPeGgh2YOC9gJgs+jzjfkKYI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 24 Sep 2019 16:31:12 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <87r24640kb.fsf@toke.dk>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
 <1568639388-27291-2-git-send-email-yiboz@codeaurora.org>
 <87pnjyiq7o.fsf@toke.dk> <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org>
 <87sgothmpy.fsf@toke.dk> <8cdece5c030fd95817fb099021c38613@codeaurora.org>
 <87tv98fu6l.fsf@toke.dk> <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org>
 <8736gre3bm.fsf@toke.dk> <198124204167325252fcfcd65e3f2733@codeaurora.org>
 <87ftkp7uuz.fsf@toke.dk> <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org>
 <877e617qg2.fsf@toke.dk> <910d9bb5f9016b29fb2aaeb0b89bac38@codeaurora.org>
 <874l157nrt.fsf@toke.dk> <2935b00bf3e29ad8b2738fe98dc24a76@codeaurora.org>
 <87lfuf5ly2.fsf@toke.dk> <1b3eab1f2481e0102b284f133605c6c4@codeaurora.org>
 <87r24640kb.fsf@toke.dk>
Message-ID: <4cb086a2ec62b6bb127d933d2dcfb17c@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-24 15:26, Toke Høiland-Jørgensen wrote:
>>> Hmm, yeah, I guess we could end up with a loop like that as well.
>>> Keeping the schedule_round would be a way to fix it, but I'm not sure
>>> we
>>> should just skip that station; maybe we should just end the round
>>> instead?
>> I am not sure. I believe, in some cases, the rest of the nodes which
>> could be most of the nodes in the tree will not have the chance to be
>> scheduled in this round.
> 
> My guess would be that it doesn't really matter, because in most cases
> each schedule round will only actually end up queueing packets from one
> or two stations; as the driver will pull multiple packets from that one
> station which will often fill up the firmware queues (especially once 
> we
> start throttling that with the AQL stuff).
> 
> So I guess we can just skip TXQs that we've already seen this 
> scheduling
> round, and let the v_t compare determine transmit eligibility :)

I am a little confused. So do you mean it is fine for you to skip the 
TXQs we met in this round before and continue the loop until the end or 
vt comparison failure?

> 
> -Toke

-- 
Yibo
