Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5AC32783A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Mar 2021 08:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhCAHYp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Mar 2021 02:24:45 -0500
Received: from z11.mailgun.us ([104.130.96.11]:39354 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232286AbhCAHYk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Mar 2021 02:24:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614583456; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=0Tdki5YTFBWfPCqCABdVwedB+bTfQqu93GYTHRYGeEc=; b=wUIhfqmEo5S4qbLFbg5hKI92GyvPSwVzZlCKtVBMg8Pvz5s0kqTH2IPBVuhy9KaWel/DF1jk
 eO6/x/sfaT+KYqwc9lGFd4Bjli2wFoWAahCyGyA44rimHWI152IngcbiSactnNeEqEcgg+0x
 /3WBf0kc95gAvjShCis2dngNPnY=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 603c96807aa94c52e7bef06c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Mar 2021 07:23:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8F6C4C433C6; Mon,  1 Mar 2021 07:23:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E01FC433CA;
        Mon,  1 Mar 2021 07:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E01FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
Cc:     linux-wireless@vger.kernel.org, luciano.coelho@intel.com
Subject: Re: [PATCH iwlwifi-next] iwlwifi: de-const properly where needed
References: <alpine.BSF.2.00.2102261652510.72241@ai.fobar.qr>
Date:   Mon, 01 Mar 2021 09:23:38 +0200
In-Reply-To: <alpine.BSF.2.00.2102261652510.72241@ai.fobar.qr> (Bjoern A.
        Zeeb's message of "Fri, 26 Feb 2021 16:53:25 +0000 (UTC)")
Message-ID: <87tupvcp6t.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Bjoern A. Zeeb" <bz@FreeBSD.ORG> writes:

> In order to de-const variables simply casting through (void *) is
> not enough: "cast from 'const .. *' to 'void *' drops const qualifier".
> Cast through (uintptr_t) as well [1] to make this compile on systems
> with more strict requirements.
> In addition passing const void *data to dma_map_single() also
> drops the (const) qualifier.  De-constify on variable on assignment
> which may be overwritten later.  In either case the (void *) cast
> to dma_map_single() is not needed (anymore) either.
>
> [1] See __DECONST() in sys/sys/cdefs.h in FreeBSD
>
> Sponsored-by:  The FreeBSD Foundation
> Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>

Why are we using the const in the first place? That sounds like a bug to
me.

BTW, your patches are hard to read due to excessive context, I guess you
are using a very large context value with diff? Our recommendation is to
use git with default values, see the wiki below for more info.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
