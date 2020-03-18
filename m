Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8401189BA2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 13:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCRMG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 08:06:57 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:62026 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbgCRMG5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 08:06:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584533217; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=slLmtbswgk6dT89rTFhcmPBFr7EqjQwUTpcuDJEcfJU=; b=Hi+CTxib/WPUsDdn/ytTgm0PcEN4IflI8syXxnuSuAKFTD+39YomKvziNeS5PkNdqe3UUewY
 O9uiHFJszjMzwGyznsZWDURo/HJuFWIWXdKv2TW7q4UotHYIftgc6XPHLEY7DA3X9T45wCSO
 4fOmt5TTDesgR6nOp/1K4hf7Auc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e720ed0.7f8b3efab1b8-smtp-out-n05;
 Wed, 18 Mar 2020 12:06:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84A25C433CB; Wed, 18 Mar 2020 12:06:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70FCBC433D2;
        Wed, 18 Mar 2020 12:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70FCBC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Subject: Re: pull-request: iwlwifi-next 2020-03-17
References: <9940614e4051cc054569033ca7c127f3339469e6.camel@coelho.fi>
Date:   Wed, 18 Mar 2020 14:06:35 +0200
In-Reply-To: <9940614e4051cc054569033ca7c127f3339469e6.camel@coelho.fi> (Luca
        Coelho's message of "Tue, 17 Mar 2020 21:26:16 +0200")
Message-ID: <87sgi5kgtw.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's the fist batch of patches intended for v5.7.  This includes
> the last patchset I sent out.  Usual development work.  More details
> about the contents in the tag description.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit 377c0a94ad1cf005c47d7a502d1f8e46fbcf747a:
>
>   Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2020-03-16 07:29:55 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2020-03-17
>
> for you to fetch changes up to 5e003982b07ae351cadef4c252b3279b3424bf0d:
>
>   iwlwifi: move AX200 devices to the new table (2020-03-17 21:10:47 +0200)
>
> ----------------------------------------------------------------
> First set of iwlwifi patches intended for v5.7
>
> * Refactoring of the device selection algorithms;
>
> ----------------------------------------------------------------

Pulled, thanks Luca.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
