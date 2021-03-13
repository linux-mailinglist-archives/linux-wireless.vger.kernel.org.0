Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB85339F57
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Mar 2021 18:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhCMRGu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Mar 2021 12:06:50 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:12136 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233951AbhCMRGg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Mar 2021 12:06:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615655196; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=OFxon1S+AsfdLrBubt8ZlpabpvFG38RLZ9ix2wD5q+I=; b=Do6MIgpDBzLMoaFnCexjwFF5z5xr9vtft3txZ33LngkilbODBcote88ACL6lm7iR7qXEzKnA
 ocpzLEwvC5nfhL53R17T3jy/PUhCYBNeZODs5f0pgZP0Avp84Ej64LqjF+BTx2pypZX4rve7
 YwqniRMlcPLXWY7iKQw0AptBVy0=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 604cf10ee2200c0a0de00999 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 13 Mar 2021 17:06:22
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C28FC433CA; Sat, 13 Mar 2021 17:06:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F9E6C433C6;
        Sat, 13 Mar 2021 17:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F9E6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()
References: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm>
        <nycvar.YFH.7.76.2103080925230.12405@cbobk.fhfr.pm>
        <nycvar.YFH.7.76.2103130242460.12405@cbobk.fhfr.pm>
        <87h7lfbowr.fsf@tynnyri.adurom.net>
        <nycvar.YFH.7.76.2103131642290.12405@cbobk.fhfr.pm>
        <f103b4a29b7c1942f091bd7b90d7a927d72c20a2.camel@coelho.fi>
Date:   Sat, 13 Mar 2021 19:06:17 +0200
In-Reply-To: <f103b4a29b7c1942f091bd7b90d7a927d72c20a2.camel@coelho.fi> (Luca
        Coelho's message of "Sat, 13 Mar 2021 18:32:26 +0200")
Message-ID: <87zgz7t246.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Sat, 2021-03-13 at 16:43 +0100, Jiri Kosina wrote:
>> On Sat, 13 Mar 2021, Kalle Valo wrote:
>> 
>> > > > > From: Jiri Kosina <jkosina@suse.cz>
>> > > > > 
>> > > > > It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs 
>> > > > > disabled (e.g. from LED core). We can't enable BHs in such a situation.
>> > > > > 
>> > > > > Turn the unconditional BH-enable/BH-disable code into 
>> > > > > hardirq-disable/conditional-enable.
>> > > > > 
>> > > > > This fixes the warning below.
>> > > > 
>> > > > Hi,
>> > > > 
>> > > > friendly ping on this one ... 
>> > > 
>> > > Luca,
>> > > 
>> > > Johannes is telling me that he merged this patch internally, but I have no 
>> > > idea what is happening to it ... ?
>> > > 
>> > > The reported splat is a clear bug, so it should be fixed one way or the 
>> > > other.
>> > 
>> > Should I take this to wireless-drivers?
>> 
>> I can't speak for the maintainers, but as far as I am concerned, it 
>> definitely is a 5.12 material, as it fixes real scheduling bug.
>
> Yes, please take this to w-d.  We have a similar patch internally, but
> there's a backlog and it will take me some time to get to it.  I'll
> resolve eventual conflicts when time comes.

Ok, can I have your ack for patchwork?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
