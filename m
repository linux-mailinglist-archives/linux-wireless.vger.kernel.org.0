Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14EF37C093
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 13:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfGaL6P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 07:58:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGaL6O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 07:58:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 344A6605A5; Wed, 31 Jul 2019 11:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564574294;
        bh=LN7f5TRmVL1YKtnNe+He1RDrhJ3d6q0BxfGqvstSwck=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VEHKX67zgP8Ez2ZPdLaoDCPzQfZhvMk3gMwEGuVObl97bmP4Or84KSk3AwCHs7Ems
         WUaUky7w/2TbkFb5me8u+tWPb8p0lXVhgt97P1uM+sjMSS71Q9MYFrmuq3g+WkV7Lq
         TuQaDB1Ic9FJf9SO6NPn2yfZKAEDHqp8AbsblJic=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6BD976047C;
        Wed, 31 Jul 2019 11:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564574293;
        bh=LN7f5TRmVL1YKtnNe+He1RDrhJ3d6q0BxfGqvstSwck=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mzfU2l6IZNeLrFJaxsbQJqalUfESMepnIcNiyIr1zdoKGwTDPiJC/mZRNjpYSBq3S
         pETf/dFewYMcoALyYK77VzQInhrq8w+vrtZtbVLtM1VZQdpDaHLu9/eQ9LS+a1B3rg
         +UKYCCX/vNxOgkAaJ1GIJLJ614tKgyRdQNO7CI5g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BD976047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: pull-request: iwlwifi-fixes 2019-07-30
References: <20190730171210.16570-1-johannes@sipsolutions.net>
Date:   Wed, 31 Jul 2019 14:58:10 +0300
In-Reply-To: <20190730171210.16570-1-johannes@sipsolutions.net> (Johannes
        Berg's message of "Tue, 30 Jul 2019 19:12:09 +0200")
Message-ID: <87sgqmpga5.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Hi Kalle,
>
> Resending, with all sign-offs again ... sorry, that's because Luca
> handled the previous part and then I just added stuff.
>
> Please pull and let me know if there's any problem.
>
> Thanks,
> johannes
>
>
>
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
>
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-fixes.git tags/iwlwifi-fixes-for-kvalo-2019-07-30
>
> for you to fetch changes up to 71b256f8f7a5c09810d2c3ed6165629c2cc0a652:
>
>   iwlwifi: mvm: fix a use-after-free bug in iwl_mvm_tx_tso_segment (2019-07-30 18:34:32 +0200)
>
> ----------------------------------------------------------------
> We have a lot of fixes, most of them are also applicable to stable.
> Notably:
>  * fix use-after-free issues
>  * fix DMA mapping API usage errors
>  * fix frame drop occurring due to reorder buffer handling in
>    RSS in certain conditions
>  * fix rate scale locking issues
>  * disable TX A-MSDU on older NICs as it causes problems and was
>    never supposed to be supported
>  * new PCI IDs
>  * GEO_TX_POWER_LIMIT API issue that many people were hitting
>
> ----------------------------------------------------------------

Thanks, looks good now. Pulled.

-- 
Kalle Valo
