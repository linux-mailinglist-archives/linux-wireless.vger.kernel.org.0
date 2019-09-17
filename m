Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9FB4793
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 08:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404278AbfIQGgW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 02:36:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbfIQGgV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 02:36:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C909F60271; Tue, 17 Sep 2019 06:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568702180;
        bh=j+K5h9V7T3l/wUoaSAsdMed329Ydn4hIdD2z0M3JVhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H1pkD3qTb0EM9fatCQwsm40YVuEw4i7RK7h8ahmo/uZx1CpMduVearL6N4yIbEmxo
         fTzXSTKwkq6sAH5brNffFN92JCEfmve9hDUS8HNv5ycWVnT+pRwt+4N9eLloAOFqXb
         1zIWvAbTwjMs0ckLn38vsoCgaHbxpOmTtKXux8xQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1C53260271;
        Tue, 17 Sep 2019 06:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568702180;
        bh=j+K5h9V7T3l/wUoaSAsdMed329Ydn4hIdD2z0M3JVhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H1pkD3qTb0EM9fatCQwsm40YVuEw4i7RK7h8ahmo/uZx1CpMduVearL6N4yIbEmxo
         fTzXSTKwkq6sAH5brNffFN92JCEfmve9hDUS8HNv5ycWVnT+pRwt+4N9eLloAOFqXb
         1zIWvAbTwjMs0ckLn38vsoCgaHbxpOmTtKXux8xQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 17 Sep 2019 14:36:20 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 3/4] mac80211: fix low throughput in push pull mode
In-Reply-To: <6684ceecde399edeb31c594f889a403440c78142.camel@sipsolutions.net>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
 <1568639388-27291-3-git-send-email-yiboz@codeaurora.org>
 (sfid-20190916_151039_049848_BE125514)
 <6684ceecde399edeb31c594f889a403440c78142.camel@sipsolutions.net>
Message-ID: <8e4cd872d082c6bce598c87411a2125f@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-16 23:27, Johannes Berg wrote:
> Without really looking at the code -
> 
>> If station is ineligible for transmission in 
>> ieee80211_txq_may_transmit(),
>> no packet will be delivered to FW. During the tests in push-pull mode 
>> with
>> many clients, after several seconds, not a single station is an 
>> eligible
>> candidate for transmission since global time is smaller than all the
>> station's virtual airtime. As a consequence, the Tx has been blocked 
>> and
>> throughput is quite low.
> 
> You should rewrite this to be, erm, a bit more understandable in
> mac80211 context. I assume you're speaking (mostly?) about ath10k, but 
> I
> have very little context there. "push pull mode"? "firmware"? These
> things are not something mac80211 knows about.
Hi Johannes,

Thanks for your kindly reminder. Will rewrite the commit log.

> 
>> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
> 
> That also seems wrong, should be Toke I guess, unless you intended for 
> a
> From: Toke to be present?
Do you mean it should be something like:

Co-developed-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>

Am I understanding right?
> 
> johannes

-- 
Yibo
