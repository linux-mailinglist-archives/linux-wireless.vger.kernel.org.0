Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD10FD753
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 08:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfKOHtq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 02:49:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOHtq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 02:49:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3EBCB60CA5; Fri, 15 Nov 2019 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573804185;
        bh=9r8FAUwtXSC6yB4MaZI3zm6dHNnRjpMwjKcAmb+VdJE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dia+IlQWbxKc1NAfGUNym9wo3LRjjlScRbvtAiITu/U9IcaRM1uGq88+r6PEn8bq1
         T7A7/PfWF3gmdP3bfB7sKwnN+7B1ibxmJJInsKs+DHaQm7ETI2WyRG2fWVjriTvtjC
         paMwyby531zgcZ+VSYZmUwGJlIiFf+I8bLsnmPds=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32B44602DE;
        Fri, 15 Nov 2019 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573804184;
        bh=9r8FAUwtXSC6yB4MaZI3zm6dHNnRjpMwjKcAmb+VdJE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dibSpP+G7Pi8tH1HMHpIJTd1kMsTAHHHcH8CF66PV5tLfmzBQQbIoaKaiY24lh0Jj
         7Je9CTbqN/LaYL0qc+8ybjUAXBCRCX8qOnDMRyty9qB2bj7GJoumtqODaWOtNd8yS4
         GPLaCGSmgRNFYW6+ktACEPVifU7OsYAIQ+bP4c7c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32B44602DE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2019-11-13-3
References: <12f1628d715bd9915b291aebe8512cfb3c44dec8.camel@coelho.fi>
Date:   Fri, 15 Nov 2019 09:49:41 +0200
In-Reply-To: <12f1628d715bd9915b291aebe8512cfb3c44dec8.camel@coelho.fi> (Luca
        Coelho's message of "Fri, 15 Nov 2019 09:43:55 +0200")
Message-ID: <871ru9o9yi.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Hi Kalle,
>
> Here's another updated pull request with the second batch of patches
> intended for v5.4.  This includes the last patchset 2 patchsets I sent. 
> Usual development work.  More details about the contents in the tag
> description.
>
> In this update I have fixed the Change-Id tags that slipped in.  Sorry
> about that.
>
> I pushed these patches to my pending branch when I sent them out and
> kbuildbot reported success.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit 21c60a28af58d7c376502c26fbb0064b39c32917:
>
>   rtw88: signal completion even on firmware-request failure (2019-11-08 10:27:03 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2019-11-13-3
>
> for you to fetch changes up to 37a8f748bb679ed614878dae9bbdb1cfcf9eb99e:
>
>   iwlwifi: mvm: fix non-ACPI function (2019-11-15 09:37:36 +0200)
>
> ----------------------------------------------------------------
> Second batch of patches intended for v5.5
>
> * Update scan FW API;
> * Fix single antenna diversity support;
> * Bump the supported FW API version;
> * Add debug dump collection on assert in WoWLAN;
> * Fix VHT capabilities settings;
> * Move ACPI handling code fully into acpi.c;
> * Increase the CTDP budget to improve signal strength;
> * A fix for compilation with no ACPI enabled;
> * Enable adaptive dwell on P2P interfaces;
>
> ----------------------------------------------------------------

Our emails crossed, and I had already manually fixed (and applied) this
based on v2. So dropping v3.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
