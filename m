Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1266419EA21
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2020 11:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgDEJOp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Apr 2020 05:14:45 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45650 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgDEJOp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Apr 2020 05:14:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586078084; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6/9MibweBRdexKNq6gs4nfntQ4hl08uFrMqjxWvBPlM=; b=GbrH2OrBe5qxu9dN3zBhvArSYuvWWlYOr3YqMeypOFbwVtY91BDQH+56n+45TH//6ASAhy+Z
 e3EnaGq5zYtlrgQcbdoz7ehbBtvNnhBOea1jgVnM8idLeFlj3liR9a4qexrrueZCmDHcA8F8
 qQKOvQNsW6n9NLyzEr7VaLuNnK4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e89a179.7f1fa20ed2d0-smtp-out-n05;
 Sun, 05 Apr 2020 09:14:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1A7E1C433D2; Sun,  5 Apr 2020 09:14:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79925C433D2;
        Sun,  5 Apr 2020 09:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79925C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     Chris Rorvick <chris@rorvick.com>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] iwlwifi: actually check allocated conf_tlv pointer
References: <20200402050219.4842-1-chris@rorvick.com>
        <87mu7qfhiy.fsf@codeaurora.org>
        <e43fb61905bcc31f93d6e72e5c470ad5585b6dfd.camel@coelho.fi>
Date:   Sun, 05 Apr 2020 12:13:55 +0300
In-Reply-To: <e43fb61905bcc31f93d6e72e5c470ad5585b6dfd.camel@coelho.fi> (Luca
        Coelho's message of "Sun, 05 Apr 2020 11:51:53 +0300")
Message-ID: <87zhbqz44s.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Sun, 2020-04-05 at 11:44 +0300, Kalle Valo wrote:
>> Chris Rorvick <chris@rorvick.com> writes:
>> 
>> > Commit 71bc0334a637 ("iwlwifi: check allocated pointer when allocating
>> > conf_tlvs") attempted to fix a typoe introduced by commit 17b809c9b22e
>> > ("iwlwifi: dbg: move debug data to a struct") but does not implement the
>> > check correctly.
>> > 
>> > Tweeted-by: @grsecurity
>> > Signed-off-by: Chris Rorvick <chris@rorvick.com>
>> 
>> I'll add:
>> 
>> Fixes: 71bc0334a637 ("iwlwifi: check allocated pointer when allocating conf_tlvs")
>> 
>> > ---
>> > In this wasn't picked up?
>> 
>> Luca, can I take this directly?
>
> Yes, please take it directly.

Ok, assigned it to me in patchwork.

> This can happen in OOM situations and, when it does, we will
> potentially try to dereference a NULL pointer.

I'll add this to the commit log.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
