Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEFAB60FD
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfIRKCm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 06:02:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42800 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfIRKCm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 06:02:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D8D36050D; Wed, 18 Sep 2019 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568800960;
        bh=1bGaOxZtc50/tDmmvlQLND5p4BJKZCG7nqc4sGoGBAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ny9e549NJGx6EwihVSpLqHvZbqsSXy0O9com6n054VUuGSnD4VxkD2+uK3ICng+TK
         3dFnNCadAYfN2Jj66/BWiTptxejd5o3rGjYSpJM0UtNaAwhjsiA6eZ/Lx40PEzRLhj
         TbmkKbzImCETzMhRGgtKVyYpg9E1RmJyYrW+3LNI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 32E7B60252;
        Wed, 18 Sep 2019 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568800960;
        bh=1bGaOxZtc50/tDmmvlQLND5p4BJKZCG7nqc4sGoGBAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ny9e549NJGx6EwihVSpLqHvZbqsSXy0O9com6n054VUuGSnD4VxkD2+uK3ICng+TK
         3dFnNCadAYfN2Jj66/BWiTptxejd5o3rGjYSpJM0UtNaAwhjsiA6eZ/Lx40PEzRLhj
         TbmkKbzImCETzMhRGgtKVyYpg9E1RmJyYrW+3LNI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 18 Sep 2019 18:02:40 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 3/4] mac80211: fix low throughput in push pull mode
In-Reply-To: <87lfumiq3w.fsf@toke.dk>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
 <1568639388-27291-3-git-send-email-yiboz@codeaurora.org>
 <6684ceecde399edeb31c594f889a403440c78142.camel@sipsolutions.net>
 <8e4cd872d082c6bce598c87411a2125f@codeaurora.org> <87lfumiq3w.fsf@toke.dk>
Message-ID: <595c99a36c4f3e3eb131894d85c09746@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-18 05:12, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
> 
>> On 2019-09-16 23:27, Johannes Berg wrote:
>>> Without really looking at the code -
>>> 
>>>> If station is ineligible for transmission in
>>>> ieee80211_txq_may_transmit(),
>>>> no packet will be delivered to FW. During the tests in push-pull 
>>>> mode
>>>> with
>>>> many clients, after several seconds, not a single station is an
>>>> eligible
>>>> candidate for transmission since global time is smaller than all the
>>>> station's virtual airtime. As a consequence, the Tx has been blocked
>>>> and
>>>> throughput is quite low.
>>> 
>>> You should rewrite this to be, erm, a bit more understandable in
>>> mac80211 context. I assume you're speaking (mostly?) about ath10k, 
>>> but
>>> I
>>> have very little context there. "push pull mode"? "firmware"? These
>>> things are not something mac80211 knows about.
>> Hi Johannes,
>> 
>> Thanks for your kindly reminder. Will rewrite the commit log.
>> 
>>> 
>>>> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
>>> 
>>> That also seems wrong, should be Toke I guess, unless you intended 
>>> for
>>> a
>>> From: Toke to be present?
>> Do you mean it should be something like:
>> 
>> Co-developed-by: Toke Høiland-Jørgensen <toke@toke.dk>
>> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
>> 
>> Am I understanding right?
> 
> I think the right thing here, as with the previous patch, is to just
> drop my sign-off; you're writing this patch, and I'll add ack/reviews 
> as
> appropriate. And in that case, well, no need to have co-developed-by
> yourself when your name is on the patch as author :)
> 
> -Toke
Sorry, I think I have missed checking your reply, please ignore the 
wrong signed-off in PATCH-V2.

-- 
Yibo
