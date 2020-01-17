Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E67140C46
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 15:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAQOTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jan 2020 09:19:36 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:49293 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgAQOTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jan 2020 09:19:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579270775; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=CqdqeF5dMyn5B4sFCvWiM0zol1C/JFlia0o0bQ662Os=; b=MGCJmUmN6+S5mb2WXTPeJX3MOS/fcnAD6j+Xm81oZHxL4/6Y2uIvFbTRscF3Vw4O9H9uAdtM
 VaqJd0rN3/P5I1mUsZRmSH/TkgWWyFmRv0lLB2CuwqhPXhygKDHUNgm9d9dj9mjD96QMhucb
 9GyOpHFUJ7z5LFDG5qEmtbtUhV4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e21c275.7f53cde4cf80-smtp-out-n02;
 Fri, 17 Jan 2020 14:19:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F216FC447A1; Fri, 17 Jan 2020 14:19:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20BF4C433A2;
        Fri, 17 Jan 2020 14:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20BF4C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-fixes for v5.5 2020-01-11
References: <e58709ad7fd4909fca3726e181f048b1862c962b.camel@coelho.fi>
Date:   Fri, 17 Jan 2020 16:19:27 +0200
In-Reply-To: <e58709ad7fd4909fca3726e181f048b1862c962b.camel@coelho.fi> (Luca
        Coelho's message of "Sat, 11 Jan 2020 11:40:54 +0200")
Message-ID: <87lfq6i2s0.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's the first batch of fixes intended for v5.5.  This includes the
> last 2 patchsets I sent plus Mehmet's revert that I sent separately. 
> More details about the contents in the tag description.
>
> I pushed this to my pending branch and I got results from kbuildbot for
> the first series, but not to
> the second one yet.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit 33328bfab892d676920abb440d41fbf4b16c2717:
>
>   MAINTAINERS: change Gruszka's email address (2019-12-19 14:54:51 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-fixes.git tags/iwlwifi-for-kalle-2020-01-11
>
> for you to fetch changes up to 205608749e1ef394f513888091e613c5bfccbcca:
>
>   Revert "iwlwifi: mvm: fix scan config command size" (2019-12-30 15:43:40 +0200)
>
> ----------------------------------------------------------------
> First batch of fixes intended for v5.5
>
> * Don't send the PPAG command when PPAG is disabled, since it can
>   cause problems;
> * A few fixes for a HW bug;
> * A fix for RS offload;
> * A fix for 3168 devices where the NVM tables where the wrong tables
>   were being read.
> * Fix a couple of potential memory leaks in TXQ code;
> * Disable L0S states in all hardware since our hardware doesn't
>   officially support them anymore (and older versions of the hardware
>   had instability in these states);
> * Remove lar_disable parameter since it has been causing issues for
>   some people who erroneously disable it;
> * Force the debug monitor HW to stop also when debug is disabled,
>   since it sometimes stays on and prevents low system power states;
>
> ----------------------------------------------------------------

This looks like a very questionable pull request for -rc release,
especially at this late stage of the cycle as risk of regressions
increases. I think quite of few these should have gone to -next. I
pulled it anyway as there's not much time left for v5.5, but please tune
down the number of patches going to -rc releases in the future just to
the most important, preferably user reported, issues.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
