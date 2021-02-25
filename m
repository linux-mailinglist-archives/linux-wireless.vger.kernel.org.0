Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8072F32555C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 19:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhBYSVi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 13:21:38 -0500
Received: from z11.mailgun.us ([104.130.96.11]:63571 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhBYSVh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 13:21:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614277275; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=mHL2o5cdwInZ5auVjA1RzFMxGmXtPE8iZ7MSS/BW+Rk=; b=cLSEOqRqCYTPneQaEcijbGX/U1bL/yVGmk+tg2dcbNx46/fIHDPUCGtCaYjlqT4rk0wZJ937
 4ESA6NpkzOkwzKOuqdEvT3qZ4tmX+GgoIJFEabc7ObwyWhbeuzOP2YcKmw+X+UwxcfUDmJgM
 lW62adfjrCrWLJWm20WJbsUgEO8=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6037ea941d6d3a470f690784 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Feb 2021 18:21:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AEFEEC433C6; Thu, 25 Feb 2021 18:21:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71C15C433CA;
        Thu, 25 Feb 2021 18:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71C15C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ihab Zhaika <ihab.zhaika@intel.com>,
        Matti Gottlieb <matti.gottlieb@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: fix link error without CONFIG_IWLMVM
References: <20210225143236.3543360-1-arnd@kernel.org>
Date:   Thu, 25 Feb 2021 20:21:02 +0200
In-Reply-To: <20210225143236.3543360-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Thu, 25 Feb 2021 15:30:37 +0100")
Message-ID: <87wnuwdn5d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> A runtime check that was introduced recently failed to
> check for the matching Kconfig symbol:
>
> ld.lld: error: undefined symbol: iwl_so_trans_cfg
>>>> referenced by drv.c
>>>>               net/wireless/intel/iwlwifi/pcie/drv.o:(iwl_pci_probe)
>
> Fixes: 930be4e76f26 ("iwlwifi: add support for SnJ with Jf devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

A sent a similar patch this morning:

https://patchwork.kernel.org/project/linux-wireless/patch/1614236661-20274-1-git-send-email-kvalo@codeaurora.org/

But I forgot to include an Fixes tag, I'll add that to my patch during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
