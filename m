Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9216FC527
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 12:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfKNLP5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 06:15:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60284 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNLP4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 06:15:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6DC4860DF7; Thu, 14 Nov 2019 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573730155;
        bh=tYH3R7IbgGOFYQ1R8GwzH+oR1u6+C6xqB1Cafs1b1nw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cRAvfZS8WalRKplnEaKXgQyDAvHGMPU3lM9cyW+7/VfTpA1cRZTR1ZN4vokTvuN2S
         PSK+tINHqgf76YYrr/M4H0N5txuA8AkFy60if1+O3BECuZ80iLaEFaJy9ng1dbiEAa
         3h8EJBUwysdwPvY1BUolYFhFWjBcsIX7ynkX3vnk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 881D5605FE;
        Thu, 14 Nov 2019 11:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573730153;
        bh=tYH3R7IbgGOFYQ1R8GwzH+oR1u6+C6xqB1Cafs1b1nw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dizCNYEW4sIiLvN++z5VuvSzn5nyoNauZttGkhdJhdfflB8IKeezfi2klTXWlvQ2B
         SbRTsgycFABPNPPdbPrUsTrkSPovv8jwQZ29yLYW/jrgqi8T9sO9c2Z7FGPMXjRpxV
         ylDyUlDzn7eUdLUGlzIOk2OoQtaBqBqi8RUPleb4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 881D5605FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2019-11-13-2
References: <f2bc269efbb712d36adf8feff274102d12b1629e.camel@coelho.fi>
        <87tv76ojvh.fsf@kamboji.qca.qualcomm.com>
Date:   Thu, 14 Nov 2019 13:15:48 +0200
In-Reply-To: <87tv76ojvh.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Thu, 14 Nov 2019 12:03:14 +0200")
Message-ID: <87pnhuogij.fsf@kamboji.qca.qualcomm.com>
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
>> Hi Kalle,
>>
>> Here's the updated pull request with the second batch of patches
>> intended for v5.4.  This includes the last patchset 2 patchsets I sent. 
>> Usual development work.  More details about the contents in the tag
>> description.
>>
>> In this update I have fixed a merge damage in one of the patches.  Since
>> I'm using a different machine at the moment, I had the wrong config when
>> I tested this tag.  Sorry about that.
>>
>> I pushed these patches to my pending branch when I sent them out and
>> kbuildbot reported success.
>>
>> Please let me know if there are any issues.
>
> Really sorry but I didn't have time yesterday to do detailed review and
> I just noticed that the commit below have Change-Id tags. Can you remove
> those and respin, please?

Actually there's more of them:

$ git log --oneline --grep=Change-Id master..pending
29157a88d13f iwlwifi: scan: support scan req cmd ver 12
cc5e99f8063f iwlwifi: scan: make new scan req versioning flow
f9b9ef748b37 iwlwifi: mvm: print rate_n_flags in a pretty format
52b5d3e6a01f iwlwifi: scan: adapt the code to use api ver 11
3947827de731 iwlwifi: scan: create function for scan scheduling params
71afc70e56bf iwlwifi: mvm: remove else-if in iwl_send_phy_cfg_cmd()
cd7240e8a606 iwlwifi: mvm: fix support for single antenna diversity

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
