Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D202EFC663
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 13:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNMef (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 07:34:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfKNMef (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 07:34:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A53F260A74; Thu, 14 Nov 2019 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573734874;
        bh=dwYCGAKBSoFqxbMRFaDIWTlRC6an4vrFsFQjVt+pXWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qu5MRpMzrSKnIA3koJrLhR4VunthFjKQyLn3sbftv8cUIKO6R5EB1qs/yb2k8Lc2y
         EwfQKRFhMjuSHXTDLOv77etnG1sMYzUc88BAjB0iGQ4EEA/KyF25/fPKdKAqG2FQSx
         p4TUpeBMV5OxY7P15VzJa9GM4j6DbmHTWzvm/FG8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BF798601C4;
        Thu, 14 Nov 2019 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573734840;
        bh=dwYCGAKBSoFqxbMRFaDIWTlRC6an4vrFsFQjVt+pXWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PZEh8FFdOFcz8cQ1cIQiyf4EmwRGrHw+sYkGjPdtff/Di/7vVbO61OktpQYQX5tkI
         qYn4S3Ldlk+PBPgkQ3CBaq23noyUwFhFI0zbB8BeDa1R3ICWyIilACAlNuCv+1I++p
         zGJcpqImK1dTGqJS5iQIJghUW1A44QCghbRKP5Tc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Nov 2019 18:03:59 +0530
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [EXT] Re: [PATCH v2 0/2] add Wide Band Scan support
In-Reply-To: <aa0257b408dc7ad6d5f457ac611e76059549737b.camel@sipsolutions.net>
References: <1572869374-9635-1-git-send-email-murugana@codeaurora.org>
 <53d45563803b3f96be0d53731408cc3af028c510.camel@sipsolutions.net>
 <00d301d593c2$bd37d8f0$37a78ad0$@codeaurora.org>
 <867302d58d3183ce7e2c7afa846027a787579b87.camel@sipsolutions.net>
 <6ea305b2ac09c340181623a23cf4180b@codeaurora.org>
 <aa0257b408dc7ad6d5f457ac611e76059549737b.camel@sipsolutions.net>
Message-ID: <2354c9e9f86b2207d6828b45e4055191@codeaurora.org>
X-Sender: murugana@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-14 12:08, Johannes Berg wrote:
> On Mon, 2019-11-11 at 13:27 +0530, Sathishkumar Muruganandam wrote:
>> 
>> > How is this related to scanning? It sounds to me like you're just
>> > (ab)using scan as a somewhat convenient "do some channel hopping" API
>> > ...
>> >
>> 
>> Whether this can be used under "iw offchannel" with
>> NL80211_CMD_REMAIN_ON_CHANNEL?
> 
> Are you asking if I would accept wide
> channel extensions to R-O-C?

Yes, adding bandwidth config to existing command.

Something like this,

iw offchannel <freq> [HT40+|HT40-|80MHz] <duration>

> Still I guess I'd like to see an actual reason for it.

Wide band scan is actually moving to a off-channel for a
specified duration to capture 40, 80Mhz data frames.

So, I hope offchannel would accommodate this extension.

-- 
Thanks,
Sathishkumar
