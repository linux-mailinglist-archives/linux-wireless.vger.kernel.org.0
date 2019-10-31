Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C6EB0AD
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 14:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfJaNAm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 09:00:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59680 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaNAm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 09:00:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 454D860B7E; Thu, 31 Oct 2019 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572526841;
        bh=BdmMFegUaeVqhBeESl6FD3w0RcYSCnPTzbs/2msgAWQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cTAINhGm3V+QTF6pg3xHYAJ6Q0ZRBpqQ5S1Zg9epXifMSkqwIn8yvacjXzS42EywF
         Y1IBnSPEgPbfj/mMm4ilDxuOsx9RozW+mK1Lsgd0KvxIOaPnDWbGKcIoi8dWr1iAam
         BSBmGaPeteM8ruOEfb9XyE9oD4bVYEiRIzbHNqMU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99D7D609DD;
        Thu, 31 Oct 2019 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572526840;
        bh=BdmMFegUaeVqhBeESl6FD3w0RcYSCnPTzbs/2msgAWQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=pFbeZ5Eved8Mq6jDZkn1LBgLGoQ1lpvduI5rs8C1Mnsa3wpdWk0zJxKq32LKt/XF+
         z67lTK+GA7xT0U82+zoS07LnKxcwXE20wPkfiKxor+RFKLp7gbpRtHc5yfK1x9zUMq
         6j3GUnABOe/b44VE2DPmF5subuDIPnBqLsPCb0ac=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99D7D609DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Klaus Kusche <klaus.kusche@computerix.info>
Cc:     linuxwifi@intel.com, johannes.berg@intel.com,
        emmanuel.grumbach@intel.com, linux-wireless@vger.kernel.org
Subject: Re: PATCH: Change log level of "iwlwifi 0000:6f:00.0: BIOS contains WGDS but no WRDS" to "info"
References: <dcd58b9b-43d0-a05c-68fe-2f787457f2a4@computerix.info>
        <30e95fb1-96df-b96a-c79e-e35a945ec889@computerix.info>
Date:   Thu, 31 Oct 2019 15:00:35 +0200
In-Reply-To: <30e95fb1-96df-b96a-c79e-e35a945ec889@computerix.info> (Klaus
        Kusche's message of "Thu, 31 Oct 2019 11:30:04 +0100")
Message-ID: <87r22tcbnw.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Klaus Kusche <klaus.kusche@computerix.info> writes:

> Hello again,
>
> On 22/10/2019 20:39, Klaus Kusche wrote:
>> Hello,
>> 
>> every time I boot my dell notebook (with Wi-Fi 6 AX200), I get the error message 
>> "iwlwifi 0000:6f:00.0: BIOS contains WGDS but no WRDS".
>> 
>> This is the only message which such a high log level I get while booting,
>> it is the only message which is displayed on all text consoles on boot,
>> and it is the only message which makes my automated logchecker nervous each time.
>> 
>> However, iwlwifi works perfectly fine for wifi in spite of the message
>> (and bluetooth has deliberately been disabled in the bios settings
>> for security reasons),
>> and there is absolutely nothing I could do about the message
>> (I have no influence what dell does in their bios and what they don't).
>> Internet wisdom also says that the message is just annoying and
>> can be safely ignored.
>> 
>> Hence, the message is not an error at all ("error" being defined as
>> "something definitely failed, manual intervention required for correct operation").
>> It does not even qualify as a warning ("warning" being defined as
>> "something is likely to fail, manual checking recommended").
>> 
>> So please set the log level of that message down to "info"
>> (besides, the message text is completely cryptic and uninformative,
>> I still don't know what this message wants to tell me,
>> although I searched the internet).
>
> Discussed this with Mario.Limonciello@dell.com.
> He also wants this to be patched:
>
> On 29/10/2019 22:43, Mario.Limonciello@dell.com wrote:
>> Dell Customer Communication - Confidential
>> 
>>> -----Original Message-----
>>> From: Klaus Kusche <klaus.kusche@computerix.info>
>>>...
>>> When booting, there is a single kernel message of loglevel error
>>> which stands out in red in journalctl
>>> and which gets displayed on all text consoles (very annoying):
>>>
>>> kernel: iwlwifi 0000:6f:00.0: BIOS contains WGDS but no WRDS
>> 
>> If possible, you should probably submit a patch to iwlwifi driver to downgrade this message to
>> debug.  It really isn't useful to many people typically.
>
> So here comes a patch:
>
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c       2019-10-19 09:21:14.541422680 +0200
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c       2019-10-27 14:43:43.990623338 +0100
> @@ -1345,7 +1345,7 @@
>                  * available, issue an error, because we can't use SAR
>                  * Geo without basic SAR.
>                  */
> -               IWL_ERR(mvm, "BIOS contains WGDS but no WRDS\n");
> +               IWL_INFO(mvm, "BIOS contains WGDS but no WRDS\n");

There are so many things missing here. Please read the instructions how
to submit a patch from the link in my signature below and resend.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
