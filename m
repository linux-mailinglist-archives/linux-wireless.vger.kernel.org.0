Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B207340196A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Sep 2021 12:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbhIFKFG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Sep 2021 06:05:06 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:37028 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbhIFKFF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Sep 2021 06:05:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630922641; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vb4/JswAWmt98qU4Xk7ycoBR57/SEn/Y7gRs6lvuB+o=;
 b=hEd5q6WQydIkyA6/0MinUJsDvU34c54/G+W1LpurjrDx7CCr9PwWDOt8eAo/L6rXVtYrZu4U
 5RI13yzgHFj5wr404PWaomzqbRjsyn7oQ5rsOkaSjy/Dz+mkSZIGm5S1Et/9++D8p9tXyaBv
 btQ38T/T14/m6vO+/cYMeIdHn7c=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6135e76c6fc2cf7ad90dd5b9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 06 Sep 2021 10:03:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ACD4CC43460; Mon,  6 Sep 2021 10:03:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50B52C4338F;
        Mon,  6 Sep 2021 10:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 50B52C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: iwlwifi: fix printk format warnings in uefi.c
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210821020901.25901-1-rdunlap@infradead.org>
References: <20210821020901.25901-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210906100323.ACD4CC43460@smtp.codeaurora.org>
Date:   Mon,  6 Sep 2021 10:03:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> The kernel test robot reports printk format warnings in uefi.c, so
> correct them.
> 
> ../drivers/net/wireless/intel/iwlwifi/fw/uefi.c: In function 'iwl_uefi_get_pnvm':
> ../drivers/net/wireless/intel/iwlwifi/fw/uefi.c:52:30: warning: format '%zd' expects argument of type 'signed size_t', but argument 7 has type 'long unsigned int' [-Wformat=]
>    52 |                              "PNVM UEFI variable not found %d (len %zd)\n",
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    53 |                              err, package_size);
>       |                                   ~~~~~~~~~~~~
>       |                                   |
>       |                                   long unsigned int
> ../drivers/net/wireless/intel/iwlwifi/fw/uefi.c:59:29: warning: format '%zd' expects argument of type 'signed size_t', but argument 6 has type 'long unsigned int' [-Wformat=]
>    59 |         IWL_DEBUG_FW(trans, "Read PNVM from UEFI with size %zd\n", package_size);
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~~~~~~~~~
>       |                                                                    |
>       |                                                                    long unsigned int
> 
> Fixes: 84c3c9952afb ("iwlwifi: move UEFI code to a separate file")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Luca Coelho <luciano.coelho@intel.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>

Patch applied to wireless-drivers.git, thanks.

e4457a45b41c iwlwifi: fix printk format warnings in uefi.c

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210821020901.25901-1-rdunlap@infradead.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

