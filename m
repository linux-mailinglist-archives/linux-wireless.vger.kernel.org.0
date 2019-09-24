Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD5EBC079
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 04:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408170AbfIXCzo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 22:55:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfIXCzo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 22:55:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 340AF6032C; Tue, 24 Sep 2019 02:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569293743;
        bh=MfPnhSxtM0OnJVZW0H9aUW4BawgL6o8WwzQf1XZzdK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kivjp+SgDUkRBfZ0mAsgM7Vcw4RGX8GSE0doWbtsFtBwQlEaM/yhFm4JQmbZec8/N
         ikPxy7fTqoZHrDBNtMnvjKa02Dz8x43V9KIF1Zw7S/8egEaawj8pQ7SWEgXW3fhDTX
         ozYJNFt47jj6xQqxjCmBzVavG0mcebmoMqRAeGTM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C34F960240;
        Tue, 24 Sep 2019 02:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569293742;
        bh=MfPnhSxtM0OnJVZW0H9aUW4BawgL6o8WwzQf1XZzdK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kJvgB5MBU+jLViNDsBn+bJtaFj1ibhJUthOcMVHp8rE+5C2l3HiPY9lL7ohX3YItp
         iza2YeasrWyxwblqYcfYpE71CmlhXsmPNpGIRkeTFakWrQhKKs6dimJvqXmS0bal4O
         bxa9ebrP151wjpvU1vZ+TQrzAz+220jO8H7e3VeE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 24 Sep 2019 10:55:42 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH V3 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <87ef075lit.fsf@toke.dk>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org>
 <1569223201-1490-3-git-send-email-yiboz@codeaurora.org>
 <87ef075lit.fsf@toke.dk>
Message-ID: <5dadc4a130c2ba3d6548969f47c5f85c@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-23 18:56, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
> 
>> In a loop txqs dequeue scenario, if the first txq in the rbtree gets
>> removed from rbtree immediately in the ieee80211_return_txq(), the
>> loop will break soon in the ieee80211_next_txq() due to schedule_pos
>> not leading to the second txq in the rbtree. Thus, defering the
>> removal right before the end of this schedule round.
> 
> Didn't we agree that we could fix this by making __unschedule_txq()
> aware of schedule_pos instead of this deferred removal mechanism?

Yes, V3 is actually used to update the commit log of [PATCH V3 3/4] so 
that we can discuss in parallel with others, and [PATCH V3 4/4] for 
discussion. Please ignore [PATCH V3 2/4]. we can keep our discussion in 
V2 until we conclude the final one and then a new version will be sent 
out along with [mac80211: Switch to a virtual time-based airtime 
scheduler] which includes the reducing lock fix.

Sorry for the confusion, ;).

> 
> -Toke

-- 
Yibo
