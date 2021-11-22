Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4174594D4
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbhKVSmK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 13:42:10 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:14653 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240401AbhKVSmD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 13:42:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637606335; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WmvFEoR3xXCoQ31t9E4TU3UpnzywU8Na9KHjNW6pZig=;
 b=EYrkQphOUNq8VVUXNCGyA2W/xSNdjsS6c/PO7rAvuyqtC4UMmofWisQocufBwTx1nMdc1eHv
 jPfs7wE696yi17vLhgpSdd6zRu0iO6su3JvYOseTAgQKMhH/QFxe7OxN3dXEPRd2E+/UfCOf
 Vt1+bgJ4UHQUR8GIquP6jefzwtg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 619be3be86d0e4d888c19111 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 18:38:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C304C43618; Mon, 22 Nov 2021 18:38:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 875B8C4338F;
        Mon, 22 Nov 2021 18:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 875B8C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] iwlwifi: fix warnings produced by kernel debug options
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211110215744.5487-1-lukasz.bartosik@semihalf.com>
References: <20211110215744.5487-1-lukasz.bartosik@semihalf.com>
To:     Lukasz Bartosik <lb@semihalf.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>, upstream@semihalf.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163760633056.7371.9090879502801435579.kvalo@codeaurora.org>
Date:   Mon, 22 Nov 2021 18:38:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lukasz Bartosik <lb@semihalf.com> wrote:

> From: Łukasz Bartosik <lb@semihalf.com>
> 
> Fix warnings produced by:
> - lockdep_assert_wiphy() in function reg_process_self_managed_hint(),
> - wiphy_dereference() in function iwl_mvm_init_fw_regd().
> Both function are expected to be called in critical section.
> 
> The warnings were discovered when running v5.15 kernel
> with debug options enabled:
> 
> 1)
> Hardware name: Google Delbin/Delbin
> RIP: 0010:reg_process_self_managed_hint+0x254/0x347 [cfg80211]
> ...
> Call Trace:
> regulatory_set_wiphy_regd_sync+0x3d/0xb0
> iwl_mvm_init_mcc+0x49d/0x5a2
> iwl_op_mode_mvm_start+0x1b58/0x2507
> ? iwl_mvm_reprobe_wk+0x94/0x94
> _iwl_op_mode_start+0x146/0x1a3
> iwl_opmode_register+0xda/0x13d
> init_module+0x28/0x1000
> 
> 2)
> drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:263 suspicious rcu_dereference_protected() usage!
> ...
> Hardware name: Google Delbin/Delbin, BIOS Google_Delbin
> Call Trace:
> dump_stack_lvl+0xb1/0xe6
> iwl_mvm_init_fw_regd+0x2e7/0x379
> iwl_mvm_init_mcc+0x2c6/0x5a2
> iwl_op_mode_mvm_start+0x1b58/0x2507
> ? iwl_mvm_reprobe_wk+0x94/0x94
> _iwl_op_mode_start+0x146/0x1a3
> iwl_opmode_register+0xda/0x13d
> init_module+0x28/0x100
> 
> Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
> Signed-off-by: Łukasz Bartosik <lb@semihalf.com>

Patch applied to wireless-drivers.git, thanks.

f5cecf1d4c5f iwlwifi: fix warnings produced by kernel debug options

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211110215744.5487-1-lukasz.bartosik@semihalf.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

