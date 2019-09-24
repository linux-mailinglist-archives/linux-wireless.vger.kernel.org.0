Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10550BC456
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfIXI6X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 04:58:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfIXI6W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 04:58:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BE25E60128; Tue, 24 Sep 2019 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569315501;
        bh=+OjAu5LkmUVoBsrucFH48IscYXvzLUSlgsNMMFX+PpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SWj6swxanwA0PwluKXwYcXYKrfdATjgDZGEuC6i3QDdjFfk3a0BRb5xnQeDQezLvL
         ZIix9512E1iC5bfCu3nKiyQK5onB7Zlb4bnmd3rqvoDAhoWkAEzMGfQRVV4t6H9QCv
         3aUTt8nxvcGl6aOum4Atmc6OAuqd4igI1sgrh8/s=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5629660256;
        Tue, 24 Sep 2019 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569315501;
        bh=+OjAu5LkmUVoBsrucFH48IscYXvzLUSlgsNMMFX+PpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SWj6swxanwA0PwluKXwYcXYKrfdATjgDZGEuC6i3QDdjFfk3a0BRb5xnQeDQezLvL
         ZIix9512E1iC5bfCu3nKiyQK5onB7Zlb4bnmd3rqvoDAhoWkAEzMGfQRVV4t6H9QCv
         3aUTt8nxvcGl6aOum4Atmc6OAuqd4igI1sgrh8/s=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 24 Sep 2019 16:58:21 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 3/4] mac80211: fix low throughput in multi-clients
 situation
In-Reply-To: <87d0fq3wqy.fsf@toke.dk>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org>
 <1569223201-1490-4-git-send-email-yiboz@codeaurora.org>
 <87impj5lkm.fsf@toke.dk> <2aab0bd944ee34751304a5f92b885113@codeaurora.org>
 <87d0fq3wqy.fsf@toke.dk>
Message-ID: <0c58a6be437e5a21c63ad44cc86c317b@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-24 16:48, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
> 
>>> I can see why we need the second part (basically, this happens 
>>> because
>>> I
>>> forgot to add a check for "no eligible stations" in may_transmit(),
>>> like
>>> the one in next_txq()). And rounding up the division result doesn't
>>> hurt, I guess. But why does it help to change the grace period if 
>>> we're
>>> doing all the other stuff?
>> In multi-clients case, it is possible a TXQ sometimes gets drained due
>> to FW has deep queue and few packets in TXQ at that time. So the TXQ 
>> is
>> removed from the rbtree after dequeuing. When it is about to added 
>> back
>> very soon after the removal, the g_vt might have gone a little far 
>> away
>> from sta vt where sync is needed. With this sync, the station is 
>> forced
>> to catch up with the g_vt, however, its chance for transmission has 
>> been
>> reduced. I think 500us is quite a short period in multi-clients case.
> 
> That's a good point, actually: Having the grace period be too small 
> will
> allow stations that leave and re-enter the queue to "skip ahead" and 
> use
> more than its share. However, I think it's a separate issue from what
> this patch is about; so how about I just increase the grace period in
> the next version of the base patch?

Sure, no problem. :)
> 
> -Toke

-- 
Yibo
