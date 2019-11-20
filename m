Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BDC104307
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 19:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfKTSKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 13:10:55 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:59288
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726999AbfKTSKz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 13:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574273454;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=pnYVlPnFDXF0h5rThdR9f70VxXWvaZoJIvvgRT5NcC4=;
        b=iae+5+swiqbKZVXsTJtmfrOHNFB+kyfPPf2QRjReYI9vHRxJOmedX6RvmtgztspM
        56K1OxMglnqE2x413qZYmo6cb6IYeJw9pDfHDslse0hJrMUiXG8afkFn3pPSD9/0hgI
        T8qOoN1TVLRO1VTq+nPcnhVeAcSfgra2YshWqYco=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574273454;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=pnYVlPnFDXF0h5rThdR9f70VxXWvaZoJIvvgRT5NcC4=;
        b=EHWxxw4NwnHToqjadxi5Aji71FE9NWF+cL+cPPVoI8iLZkGwFIQ7zV2kw4nVzlVw
        +5QwhPFevp5VLyl3M3/V19fDSkbk/lAWJxjTa6PAQ6oGq/JaYF6mqZLtb4tRIWOtHtm
        2u3psRHOZTV3ooxX71hS2Sroci5ZmHgeDnlwkJ/o=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD5ADC447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2019-11-13
References: <a9bd353c2e5f84e9144d3d843adeb03491053478.camel@coelho.fi>
Date:   Wed, 20 Nov 2019 18:10:54 +0000
In-Reply-To: <a9bd353c2e5f84e9144d3d843adeb03491053478.camel@coelho.fi> (Luca
        Coelho's message of "Wed, 20 Nov 2019 12:40:59 +0200")
Message-ID: <0101016e8a0291d2-0067e906-40d2-48d1-a310-4c9f88ddb199-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.20-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's the third batch of patches intended for v5.5.  This includes
> the patchset I just sent out .  Usual development work.  More details
> about the contents in the tag description.
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
> The following changes since commit eac08515d7bd665d306cefa2ae9f3de56e875d6d:
>
>   rtl8xxxu: Remove set but not used variable 'vif','dev','len' (2019-11-20 09:47:19 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2019-11-20
>
> for you to fetch changes up to 54fae6e31bed393a17512c1c8d2559bc737943c9:
>
>   iwlwifi: bump FW API to 52 for 22000 series (2019-11-20 12:28:56 +0200)
>
> ----------------------------------------------------------------
> Patches intended for v5.5
>
> * Fix a merge damage that causes issues with high-throuput on AX200+;
> * Support TX/RX antennas reporting;
> * Small fix in DVM's BT link-quality code;
> * Bump supported FW API version to 52;
> * Yet another scan FW API update;
> * Some clean-ups;
>
> ----------------------------------------------------------------

Pulled, thanks Luca.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
