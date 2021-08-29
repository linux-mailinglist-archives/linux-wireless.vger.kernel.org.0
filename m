Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC83FAAFE
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 13:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhH2LNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 07:13:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43440 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235019AbhH2LNt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 07:13:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630235577; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=vQnInj1E47Wc+a1KXS8kxPYQc/bd7nNv1+wH8M5aqdw=; b=IgZTq2kk+cGxJTvnXBOoeBiL9IAI1LCLYKW9ezXYtgsjPYQM5cI8juf/BKiDbU3V6Dm6msPe
 CkMyviEkTQG4sRC0kyIGBz6CJA11SPwjoYgXObBw8MXu//XDyd9AENAs8NRvPtNsen/UsGsO
 lnlUz/X9Jyln36LO3N9+fx1kPjc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 612b6bb1cd680e8969a47a6c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 11:12:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D9AD9C4360C; Sun, 29 Aug 2021 11:12:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 983DCC4338F;
        Sun, 29 Aug 2021 11:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 983DCC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: pull-request: iwlwifi-next 2021-08-26
References: <c0d6e33d5f9e113e59ee34ca65a4fb45cd89f33b.camel@coelho.fi>
Date:   Sun, 29 Aug 2021 14:12:43 +0300
In-Reply-To: <c0d6e33d5f9e113e59ee34ca65a4fb45cd89f33b.camel@coelho.fi> (Luca
        Coelho's message of "Thu, 26 Aug 2021 23:47:03 +0300")
Message-ID: <87wno44i8k.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Hi Kalle,
>
> Here's my pull request for v5.15 with all the patchesets I sent
> earlier.  This is all normal development, new features, bugfixes and
> cleanups.  More details about the contents in the tag description.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit e3f30ab28ac866256169153157f466d90f44f122:
>
>   Merge branch 'pktgen-samples-next' (2021-08-25 13:44:30 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-08-26
>
> for you to fetch changes up to d9a406ac813dd6a4cfc92bc2576adf43219792ef:
>
>   iwlwifi: bump FW API to 66 for AX devices (2021-08-26 23:39:05 +0300)
>
> ----------------------------------------------------------------
> iwlwifi patches for v5.15
>
> * Support scanning hidden 6GHz networks;
> * Some improvements in the FW error dumps;
> * Add some HE capability flags
> * A bunch of janitorial clean-ups;
> * Clean-ups in the TX code;
> * Small fix for SMPS;
> * Support for a new hardware family (Bz);
> * Small fix in the scan code;
> * A bunch of changes in the D3 code, including new FW API;
> * Finalize the refactoring of 6GHz scan;
> * Initial changes in the SAR profile code;
> * Fix reading one of our ACPI tables (WTAS);
> * Support some new ACPI table revisions;
> * Support new API of the WoWlan status FW notification;
> * Fixes in SAR ACPI tables handling;
> * Some debugging improvements;
> * Fix in ROC;
> * Support for new FW API versions;
> * Support new FW command versions;
> * Ongoing work on support for Bz devices;
> * Add new DHC framework to help with debugging of FW flows;
> * Some other small fixes, clean-ups and improvements.
>
> ----------------------------------------------------------------

I'm not convinced about CONFIG_IWLWIFI_DHC option yet, that needs more
discussion.

As the merge window most likely starts today, and I didn't want to
unnecessarily delay rest of iwlwifi patches, I decided to pull from a
commit before that DHC stuff:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git e257d969f36503b8eb1240f32653a1afb3109f86

So pulled, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
