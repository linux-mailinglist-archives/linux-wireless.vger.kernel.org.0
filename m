Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A01148A26
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2020 15:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389472AbgAXOjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jan 2020 09:39:46 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:63861 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387910AbgAXOjp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jan 2020 09:39:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579876784; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=q3fU8N9SoAUyGtvSleUTmZmK00aSXdDlqy8V7OzuVp8=; b=H7Q9hSN8G40LjyBdiYkXsACVedXb6RI0xSAfK+3I979LXJ5dGKfJCfegk3zWPUZSVq4nSI0m
 hGNJf/Foa5R6+TOXWuj9SwgyxQKOCRqDyxlgtuaOZbCYtAQRZyvIeFIxDjmvdmJTLxblnUOS
 GJbLiRhbFwFdLkR1RZotUnOvcFM=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2b01ac.7f018919e0a0-smtp-out-n02;
 Fri, 24 Jan 2020 14:39:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5E109C447A4; Fri, 24 Jan 2020 14:39:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FC52C447B0;
        Fri, 24 Jan 2020 14:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FC52C447B0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2020-01-11
References: <f548bee28a2ef4700a024e33c02b62893af498c7.camel@coelho.fi>
Date:   Fri, 24 Jan 2020 16:39:33 +0200
In-Reply-To: <f548bee28a2ef4700a024e33c02b62893af498c7.camel@coelho.fi> (Luca
        Coelho's message of "Sat, 11 Jan 2020 11:51:28 +0200")
Message-ID: <87eevoex5m.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's the fist batch of patches intended for v5.6.  This includes
> the last two patchsets I sent out.  Usual development work.  More
> details about the contents in the tag description.
>
> I pushed these patches to my pending branch, but it was just now, so I
> didn't get the results from kbuildbot yet.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit ae0a723c4cfd89dad31ce238f47ccfbe81b35b84:
>
>   Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2019-12-19 18:27:36 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2020-01-11
>
> for you to fetch changes up to 0b295a1eb81f37dc7d4f4f2ee9ef375fb36ab5d8:
>
>   iwlwifi: add device name to device_info (2020-01-04 12:48:41 +0200)
>
> ----------------------------------------------------------------
> First set of patches intended for v5.6
>
> * Support new versions of the FTM FW APIs;
> * Fix an old bug in D3 (WoWLAN);
> * A couple of fixes/improvements in the receive-buffers code;
> * Fix in the debugging where we were skipping one TXQ;
> * Support new version of the beacon template FW API;
> * Print some extra information when the driver is loaded;
> * Some debugging infrastructure (aka. yoyo) updates;
> * Support for a new HW version;
> * Second phase of device configuration work started;
> * Some clean-ups;
>
> ----------------------------------------------------------------

There was a conflict in pcie/drv.c due to this commit:

db5cce1afc8d Revert "iwlwifi: assign directly to iwl_trans->cfg in QuZ detection"

Please double check my resolution in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=5e01e8338c9d741dbf473a56f753b9c12344432d

I just took the hunk from commit db5cce1afc8d and didn't do any other
changes.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
