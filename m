Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9DC25FE42
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgIGQLj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 12:11:39 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:51662
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730325AbgIGQKX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 12:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599495022;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=tmKlaoTHXAk+QasQrFJv6v7Tfa9NDk4PE0MTUqA22Ts=;
        b=J1vbJMbENH6Bs+sgVFa8EpoQ9cXJ8vsDymjVzW9/qqV6GhDKfX8DsEFKYaNXON+h
        qop0aTnVrt+TWIa8MKFxsZNxHbMPbsRn6VyLGAruK4UdnWRy6E54PFrkA5ph7kyJKUS
        voPlLT6ZpXqtR6UXx30PMs0ybprlNaaGp/4NjU9o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599495022;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=tmKlaoTHXAk+QasQrFJv6v7Tfa9NDk4PE0MTUqA22Ts=;
        b=VAeAUM/nm2zdP40yAwS9Zyv98nRBD9g1LS8XatLy9ilYu5Lk31ieVHr1H+YO/Bi5
        R898j+V/Jj/Yz8ao3ESXR1hscwJ2cBkwjsGtPDvZVfsftMnB4qXM4Be6zmVDFL/DkXE
        uH2VDDOYKmolhnZecK/npOB1YqLn7O1ZAbsrHj2w=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF339C3275D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rakesh Pillai <pillair@codeaurora.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [PATCH 0/2] ath10k: Add chain-1 voltage regulator voting
References: <1593194502-13164-1-git-send-email-pillair@codeaurora.org>
        <CAD=FV=WTnULQs5skJiXfp+srsx5e8DeqW3uu2SEDVGoEmP2O1g@mail.gmail.com>
Date:   Mon, 7 Sep 2020 16:10:22 +0000
In-Reply-To: <CAD=FV=WTnULQs5skJiXfp+srsx5e8DeqW3uu2SEDVGoEmP2O1g@mail.gmail.com>
        (Doug Anderson's message of "Mon, 24 Aug 2020 16:50:33 -0700")
Message-ID: <01010174695526dd-c9cd10ce-a33e-438b-810d-df486ba002fb-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:

> Hi,
>
> On Fri, Jun 26, 2020 at 11:02 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>>
>> Add the support to vote for the chain-1
>> voltage regulator for WCN3990. This is
>> added as an optional property.
>>
>> Rakesh Pillai (2):
>>   dt: bindings: Add new regulator as optional property for WCN3990
>>   ath10k: Add support for chain1 regulator supply voting
>>
>>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 4 +++-
>>  drivers/net/wireless/ath/ath10k/snoc.c                         | 1 +
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> This series is marked as "Awaiting Upstream" in patchwork.  I don't
> see anything blocking it landing now.

Thanks, moved it to New state now.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
