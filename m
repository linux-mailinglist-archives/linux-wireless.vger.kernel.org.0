Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC4DB6171
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfIRK3i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 06:29:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57948 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfIRK3i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 06:29:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C449560850; Wed, 18 Sep 2019 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568802577;
        bh=iMRzdh3MbPpyKUh+Jt7/auiQOQSehTSpTQe1gbsmn9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jOmTwKTbii3xLhSlvFFREFMD/t2/kE0wtn5qSYaGWkXip6qBkXDBkAQ+f4Mg5R9ct
         PiNzJsJQIedHhZqmbq4EcT2WryjZq9nNyJKEel4Di5WOUzzZ/iEgorkckc2N+Gqy7r
         EMRIN1T5saA9s9/iIZrZb4plH1CkGTVKCOYEzYDA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6F82B6050D;
        Wed, 18 Sep 2019 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568802577;
        bh=iMRzdh3MbPpyKUh+Jt7/auiQOQSehTSpTQe1gbsmn9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jOmTwKTbii3xLhSlvFFREFMD/t2/kE0wtn5qSYaGWkXip6qBkXDBkAQ+f4Mg5R9ct
         PiNzJsJQIedHhZqmbq4EcT2WryjZq9nNyJKEel4Di5WOUzzZ/iEgorkckc2N+Gqy7r
         EMRIN1T5saA9s9/iIZrZb4plH1CkGTVKCOYEzYDA=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 18 Sep 2019 18:29:37 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH V2 3/4] mac80211: fix low throughput in multi-clients
 situation
In-Reply-To: <874l19j56n.fsf@toke.dk>
References: <1568800033-17297-1-git-send-email-yiboz@codeaurora.org>
 <1568800033-17297-3-git-send-email-yiboz@codeaurora.org>
 <874l19j56n.fsf@toke.dk>
Message-ID: <38267df5b284bfd681ad69c7e816c5a4@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-18 17:59, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
> 
>> Not long after the start of multi-clients test, not a single station 
>> is
>> an eligible candidate for transmission since global virtual time(g_vt) 
>> is
>> smaller than the virtual airtime(s_vt) of all the stations. As a 
>> result,
>> the Tx has been blocked and throughput is quite low.
>> 
>> This may mainly due to sync mechanism and accumulative deviation from 
>> the
>> devision calculation of g_vt.
>> 
>> For example:
>> Suppose we have 50 clients in first round.
>> Round 1:
>> STA	weight	Tx_time_round  wt_sum	s_vt	g_vt  valid_for_next_Tx
>> .	.	.			.		.
>> .	.	.			.		.
>> .	.	.			.		.
>> 
>> After this round, all the stations are not valid for next transmission 
>> due
>> to accumulative deviation.
>> 
>> And if we add a new #51,
>> Round 2:
>> STA	weight	Tx_time_round	wt_sum  s_vt	g_vt  valid_for_next_Tx
>> .	.	.			.		.
>> .	.	.			.		.
>> .	.	.			.		.
>> 
>> Sync is done by:
>> max(g_vt of last round - grace period, s_vt)
>> and s_vt of #51 = max(2000 - 500, 0) + 1024 = 2524, and it is more 
>> than the
>> final g_vt of this round.
>> 
>> After this round, no more station is valid for transmission.
> 
> I'm not sure I understand this. Was there supposed to be numbers in
> those tables above?
Yes, it looks like there are some display issues. Will fix it in next 
version.
> 
> -Toke

-- 
Yibo
