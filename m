Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF6150F1F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 19:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgBCSJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 13:09:58 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:34331 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728319AbgBCSJ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 13:09:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580753397; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=NQHsZzUkKlLbPklE26U1tu8prxmtIig1Iajv73yBYP8=;
 b=CjYTitGZzRJ7sAnDdO2fRiimWwmLT/jchhtnAYZgm29ZfGk8BzwcNBSkMKm9E9dwYn0Va0EI
 bPYo8yrmLLZLyzx+FSrUDx8dMM6E4wow9hmRyA/SzflnY1Z3zhD7sZR1cHqMo3tujz870DPP
 Cf0QbFV+4lt/XNxHta8bIn11hy0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3861ee.7fbe256eaa08-smtp-out-n02;
 Mon, 03 Feb 2020 18:09:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79D2EC433CB; Mon,  3 Feb 2020 18:09:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7786AC43383;
        Mon,  3 Feb 2020 18:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7786AC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.6 1/7] iwlwifi: mvm: Fix thermal zone registration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200131134530.931641-2-luca@coelho.fi>
References: <20200131134530.931641-2-luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200203180949.79D2EC433CB@smtp.codeaurora.org>
Date:   Mon,  3 Feb 2020 18:09:49 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> 
> Use a unique name when registering a thermal zone. Otherwise, with
> multiple NICS, we hit the following warning during the unregistration.
> 
> WARNING: CPU: 2 PID: 3525 at fs/sysfs/group.c:255
>  RIP: 0010:sysfs_remove_group+0x80/0x90
>  Call Trace:
>   dpm_sysfs_remove+0x57/0x60
>   device_del+0x5a/0x350
>   ? sscanf+0x4e/0x70
>   device_unregister+0x1a/0x60
>   hwmon_device_unregister+0x4a/0xa0
>   thermal_remove_hwmon_sysfs+0x175/0x1d0
>   thermal_zone_device_unregister+0x188/0x1e0
>   iwl_mvm_thermal_exit+0xe7/0x100 [iwlmvm]
>   iwl_op_mode_mvm_stop+0x27/0x180 [iwlmvm]
>   _iwl_op_mode_stop.isra.3+0x2b/0x50 [iwlwifi]
>   iwl_opmode_deregister+0x90/0xa0 [iwlwifi]
>   __exit_compat+0x10/0x2c7 [iwlmvm]
>   __x64_sys_delete_module+0x13f/0x270
>   do_syscall_64+0x5a/0x110
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

7 patches applied to wireless-drivers.git, thanks.

baa6cf8450b7 iwlwifi: mvm: Fix thermal zone registration
197288d5ba8a iwlwifi: don't throw error when trying to remove IGTK
6bd5fa332a8c iwlwifi: mvm: update the DTS measurement type
cc4255eff523 iwlwifi: mvm: avoid use after free for pmsr request
12d47f0ea5e0 iwlwifi: mvm: Check the sta is not NULL in iwl_mvm_cfg_he_sta()
b5b878e36c18 iwlwifi: mvm: fix TDLS discovery with the new firmware API
577ddbee1f43 iwlwifi: d3: read all FW CPUs error info

-- 
https://patchwork.kernel.org/patch/11359937/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
