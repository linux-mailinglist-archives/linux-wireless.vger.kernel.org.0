Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5237325E5A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 08:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBZHgg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 02:36:36 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:61007 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhBZHfk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 02:35:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614324915; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Z/vo5LH1reLtjc44fEAk5ZqleLDz9rM8UF/7j8o+yks=;
 b=ECqcBA5NasE3gLA/b8bD/Qn6ECJnKMcYVuz2nLSm2+WjctXemIVU8smSUlxI8eBWtAMV4Dtv
 VpG/ZSC6b/HR6FMFJrmv0ulwOZ5FwBA1udsfJnHXM/zwC28z62u9jYh2BsXfWa30yI7imfxM
 y6/fyBOY9dr3Jwr9YWCJUvJzXIs=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6038a4adcc1f7d7e954928a1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Feb 2021 07:35:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DBD7FC433C6; Fri, 26 Feb 2021 07:35:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2681DC433CA;
        Fri, 26 Feb 2021 07:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2681DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [5.12] iwlwifi: pcie: fix iwl_so_trans_cfg link error when
 CONFIG_IWLMVM is disabled
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1614236661-20274-1-git-send-email-kvalo@codeaurora.org>
References: <1614236661-20274-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, rdunlap@infradead.org,
        luciano.coelho@intel.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210226073508.DBD7FC433C6@smtp.codeaurora.org>
Date:   Fri, 26 Feb 2021 07:35:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Randy reported an error on his randconfig builds:
> 
> ERROR: modpost: "iwl_so_trans_cfg" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
> 
> The problem was that when CONFIG_IWLMVM was disabled we were still accessing
> iwl_so_trans_cfg. Fix it by moving IS_ENABLED() check before the access.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 930be4e76f26 ("iwlwifi: add support for SnJ with Jf devices")
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Acked-by: Luca Coelho <luciano.coelho@intel.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Patch applied to wireless-drivers.git, thanks.

62541e266703 iwlwifi: pcie: fix iwl_so_trans_cfg link error when CONFIG_IWLMVM is disabled

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1614236661-20274-1-git-send-email-kvalo@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

