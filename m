Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AABA7E087
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 18:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbfHAQt0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 12:49:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50824 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAQt0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 12:49:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5ACA56079C; Thu,  1 Aug 2019 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564678165;
        bh=rS3OzpGaBn7+b1AF+9xGZ3p0N9SkS1mmyn+Cp3JZrLs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WYZBSZwQFu144+FkTbqrtT2ZNcTC+fGYLTCf5dvuWikSAIJTYunuor3FxGdH1mEqL
         7PJng1z4nLaO78QHF4ggXGDKa/CAxBVY+Vxw8CiLBMtHGmUAchLiVRQaBT7ZiVBUjb
         mdIkO5dSMc1La55hChnRJQrU2X/62wTDPu8PzfNU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A70C6030B;
        Thu,  1 Aug 2019 16:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564678165;
        bh=rS3OzpGaBn7+b1AF+9xGZ3p0N9SkS1mmyn+Cp3JZrLs=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=fLp5oBt0rDDwrQCaXL9fD9lvM7mYNMkaWQRVGmAV1LjzprjdCuTlXQ8Rk/ZMNaHwQ
         h582Mi7rfcMk0BmZHm5KROvMWQO8YtjT0P9qKA9RNjdHV33JnD1W+ldTfB20Ws2Wfr
         Gz+lCCyAIVJ8Zy2sH8LFS/MByneFmnSY0z6/7ZvI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A70C6030B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlwifi: dbg_ini: fix compile time assert build errors
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190801070436.6588-1-johannes@sipsolutions.net>
References: <20190801070436.6588-1-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Mauro Rossi <issor.oruam@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190801164925.5ACA56079C@smtp.codeaurora.org>
Date:   Thu,  1 Aug 2019 16:49:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Mauro Rossi <issor.oruam@gmail.com>
> 
> This patch fixes and preserves existing code style, and readability,
> for IWL_ERR() and IWL_WARN() macros invocations recently added in dbg.c
> 
> Fixes the following build errors with Android build system:
> 
> /home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c: In function '_iwl_fw_dbg_apply_point':
> /home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2445:3:
> error: call to '__compiletime_assert_2446' declared with attribute error: BUILD_BUG_ON failed: err_str[sizeof(err_str) - 2] != '\n'
> /home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2451:3:
> error: call to '__compiletime_assert_2452' declared with attribute error: BUILD_BUG_ON failed: err_str[sizeof(err_str) - 2] != '\n'
> ...
> /home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2789:5:
> error: call to '__compiletime_assert_2790' declared with attribute error: BUILD_BUG_ON failed: invalid_ap_str[sizeof(invalid_ap_str) - 2] != '\n'
> /home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2800:5:
> error: call to '__compiletime_assert_2801' declared with attribute error: BUILD_BUG_ON failed: invalid_ap_str[sizeof(invalid_ap_str) - 2] != '\n'
> 
> Fixes: 427ab6385cf3 ("iwlwifi: dbg_ini: enforce apply point early on buffer allocation tlv")
> Fixes: 57d88b116175 ("iwlwifi: dbg_ini: support debug info TLV")
> Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Patch applied to wireless-drivers.git, thanks.

1f6607250331 iwlwifi: dbg_ini: fix compile time assert build errors

-- 
https://patchwork.kernel.org/patch/11070189/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

