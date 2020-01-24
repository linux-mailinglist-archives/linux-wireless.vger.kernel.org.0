Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09173148A3D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2020 15:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbgAXOqG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jan 2020 09:46:06 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:34465 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbgAXOqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jan 2020 09:46:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579877166; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=N8Gh+swxBT+RVtbN4sXmtz6Lwk+PBognjs1towBF3mU=; b=IejtdnZNDHrh8t79N5IJusIVnTBUa0JlNVPWVlAA6fhbXwgnwqaRdlKoXQLbOGYoyxj7R0mA
 +a2/dyDrhlXmHM7hYCJkgvdOEM8ocJXGAakwnyxiPaCidAmoeHbA8duvnCXQYcUF3u+NE2TR
 YtcQWg0QtR3L1AoVYE4PmTnkIPo=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2b032a.7f0d80720650-smtp-out-n02;
 Fri, 24 Jan 2020 14:46:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA362C433A2; Fri, 24 Jan 2020 14:46:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6BD5C433CB;
        Fri, 24 Jan 2020 14:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6BD5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2020-01-11
References: <f548bee28a2ef4700a024e33c02b62893af498c7.camel@coelho.fi>
        <87eevoex5m.fsf@kamboji.qca.qualcomm.com>
Date:   Fri, 24 Jan 2020 16:45:56 +0200
In-Reply-To: <87eevoex5m.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Fri, 24 Jan 2020 16:39:33 +0200")
Message-ID: <875zh0ewuz.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Luca Coelho <luca@coelho.fi> writes:
>
>> Here's the fist batch of patches intended for v5.6.  This includes
>> the last two patchsets I sent out.  Usual development work.  More
>> details about the contents in the tag description.
>>
>> I pushed these patches to my pending branch, but it was just now, so I
>> didn't get the results from kbuildbot yet.
>>
>> Please let me know if there are any issues.
>>
>> Cheers,
>> Luca.
>>
>>
>> The following changes since commit ae0a723c4cfd89dad31ce238f47ccfbe81b35b84:
>>
>>   Merge ath-next from
>> git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
>> (2019-12-19 18:27:36 +0200)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
>> tags/iwlwifi-next-for-kalle-2020-01-11
>>
>> for you to fetch changes up to 0b295a1eb81f37dc7d4f4f2ee9ef375fb36ab5d8:
>>
>>   iwlwifi: add device name to device_info (2020-01-04 12:48:41 +0200)
>>
>> ----------------------------------------------------------------
>> First set of patches intended for v5.6
>>
>> * Support new versions of the FTM FW APIs;
>> * Fix an old bug in D3 (WoWLAN);
>> * A couple of fixes/improvements in the receive-buffers code;
>> * Fix in the debugging where we were skipping one TXQ;
>> * Support new version of the beacon template FW API;
>> * Print some extra information when the driver is loaded;
>> * Some debugging infrastructure (aka. yoyo) updates;
>> * Support for a new HW version;
>> * Second phase of device configuration work started;
>> * Some clean-ups;
>>
>> ----------------------------------------------------------------
>
> There was a conflict in pcie/drv.c due to this commit:
>
> db5cce1afc8d Revert "iwlwifi: assign directly to iwl_trans->cfg in QuZ detection"
>
> Please double check my resolution in the pending branch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=5e01e8338c9d741dbf473a56f753b9c12344432d
>
> I just took the hunk from commit db5cce1afc8d and didn't do any other
> changes.

Wrong link obviously, it should be this one:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=8dd96ed75b07e0134df24333c5766cf656af60af

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
