Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF701951D8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 08:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgC0HWn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 03:22:43 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57330 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbgC0HWn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 03:22:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585293762; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=77im+yF0bOdlsUcpTdwIlphVg4dwdVlIVD1H1VgvG4U=; b=SZ2XnzmyXInseeeoLD6izrap/tDJtfXbF1Kqqc/spPagLehqWpvFGft9nj/3Aj/dOw3G0pZl
 0+CREDd5lflI7G3y/b/SXIcaEtFIlYRxSadaGwN1E2LQLHn7snHkuzF6+qDAUiwikhpxpduC
 P6YvIeRGAC1QfHW//sYewZkR39s=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7da9b8.7f6cd9f42d18-smtp-out-n05;
 Fri, 27 Mar 2020 07:22:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B55FDC43636; Fri, 27 Mar 2020 07:22:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 220ECC433D2;
        Fri, 27 Mar 2020 07:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 220ECC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Subject: Re: pull-request: iwlwifi-next 2020-03-27
References: <9c8b99b802532b58471eb2024de64b5dc2f5727d.camel@coelho.fi>
Date:   Fri, 27 Mar 2020 09:22:28 +0200
In-Reply-To: <9c8b99b802532b58471eb2024de64b5dc2f5727d.camel@coelho.fi> (Luca
        Coelho's message of "Fri, 27 Mar 2020 08:18:20 +0200")
Message-ID: <87ftdu2rez.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's the second batch of patches intended for v5.7.  This includes
> the last two patchsets I sent out.  Usual development work.  More
> details about the contents in the tag description.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit 3af4da165f487a3956fe5a7b4ee08b12c7a3a9af:
>
>   hostap: convert to struct proc_ops (2020-03-26 21:23:28 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2020-03-27
>
> for you to fetch changes up to 84acc85a62a171de98706b9b2cc73a660088314a:
>
>   iwlwifi: mvm: remove newline from rs_pretty_print_rate() (2020-03-27 08:12:53 +0200)
>
> ----------------------------------------------------------------
> Second set of iwlwifi patches intended for v5.7
>
> * Refactoring of the device selection algorithms continues;
> * Improvement in the initialization fo SoC-based devices;
> * Support for FW scan API;
> * Some additions to our FW debuggging capabilities;
> * More refactoring of the device selection algorithms;
> * Support new FW API version;
> * Support for EDCA measurements;
> * New scan API features;
> * Enable new debugging code;
> * Some other small fixes and clean-ups;
>
> ----------------------------------------------------------------

Pulled, thanks Luca.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
