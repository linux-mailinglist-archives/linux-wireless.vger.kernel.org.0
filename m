Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619B6339C2A
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Mar 2021 06:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhCMFbl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Mar 2021 00:31:41 -0500
Received: from z11.mailgun.us ([104.130.96.11]:11060 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhCMFbZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Mar 2021 00:31:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615613485; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=k9JxB+H+3CYGFE+sWWv4hE2XTv5Q5jaRYOuDcz/bFXk=; b=qPfBoK6oJLvvvevkSu1zAzRxeja0oOLC2qpBU80o9RjqEaSFn5OvcN6RKNO4Ac5z3/8cOkHl
 c1EMlVhiOeBKcBEWONsTnvrbLjyFLNpnvHryycuBGcF3q1byJ1uKtzTxTnguP/VK9u5sH7Br
 AA6DBiP+eZYhp1N9NsykeZojy+c=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 604c4e2b4db3bb68019ed886 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 13 Mar 2021 05:31:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34DDCC43461; Sat, 13 Mar 2021 05:31:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 269D1C433CA;
        Sat, 13 Mar 2021 05:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 269D1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()
References: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm>
        <nycvar.YFH.7.76.2103080925230.12405@cbobk.fhfr.pm>
        <nycvar.YFH.7.76.2103130242460.12405@cbobk.fhfr.pm>
Date:   Sat, 13 Mar 2021 07:31:16 +0200
In-Reply-To: <nycvar.YFH.7.76.2103130242460.12405@cbobk.fhfr.pm> (Jiri
        Kosina's message of "Sat, 13 Mar 2021 02:44:12 +0100 (CET)")
Message-ID: <87h7lfbowr.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiri Kosina <jikos@kernel.org> writes:

> On Mon, 8 Mar 2021, Jiri Kosina wrote:
>
>> > From: Jiri Kosina <jkosina@suse.cz>
>> > 
>> > It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs 
>> > disabled (e.g. from LED core). We can't enable BHs in such a situation.
>> > 
>> > Turn the unconditional BH-enable/BH-disable code into 
>> > hardirq-disable/conditional-enable.
>> > 
>> > This fixes the warning below.
>> 
>> Hi,
>> 
>> friendly ping on this one ... 
>
> Luca,
>
> Johannes is telling me that he merged this patch internally, but I have no 
> idea what is happening to it ... ?
>
> The reported splat is a clear bug, so it should be fixed one way or the 
> other.

Should I take this to wireless-drivers?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
