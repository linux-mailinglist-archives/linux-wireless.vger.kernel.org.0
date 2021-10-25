Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4D439723
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 15:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhJYNIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 09:08:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:40003 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbhJYNIG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 09:08:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635167144; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=cFrFbEafI5CQo4iomubSKXzrac2Ie+M1Onq1o7cTjkw=;
 b=YyPEspDLJsrAyxPGm7y5u3vIbRDgq/I/9nzEu6QCpDfhS2I1M9OpUqewmdD2wxXPBWIMVt7i
 n2Ib7enbRag6Zcg2GJUG7YDcnZ6HQIi4m0XXN7WzSST2DSuF90aQ4lKKZ4VKN/brAfT3ua+U
 4vPJYA5fBme4UngImcQ20BYQQqE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6176ab9159612e0100216e6f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 13:05:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9F223C4360C; Mon, 25 Oct 2021 13:05:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E2E7C4338F;
        Mon, 25 Oct 2021 13:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5E2E7C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: fix module load regression with iram-recovery
 feature
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211020075054.23061-1-kvalo@codeaurora.org>
References: <20211020075054.23061-1-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163516711712.3976.13862181936420068312.kvalo@codeaurora.org>
Date:   Mon, 25 Oct 2021 13:05:20 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Commit 9af7c32ceca8 ("ath10k: add target IRAM recovery feature support")
> introduced a new firmware feature flag ATH10K_FW_FEATURE_IRAM_RECOVERY. But
> this caused ath10k_pci module load to fail if ATH10K_FW_CRASH_DUMP_RAM_DATA bit
> was not enabled in the ath10k coredump_mask module parameter:
> 
> [ 2209.328190] ath10k_pci 0000:02:00.0: qca9984/qca9994 hw1.0 target 0x01000000 chip_id 0x00000000 sub 168c:cafe
> [ 2209.434414] ath10k_pci 0000:02:00.0: kconfig debug 1 debugfs 1 tracing 1 dfs 1 testmode 1
> [ 2209.547191] ath10k_pci 0000:02:00.0: firmware ver 10.4-3.9.0.2-00099 api 5 features no-p2p,mfp,peer-flow-ctrl,btcoex-param,allows-mesh-bcast,no-ps,peer-fixed-rate,iram-recovery crc32 cbade90a
> [ 2210.896485] ath10k_pci 0000:02:00.0: board_file api 1 bmi_id 0:1 crc32 a040efc2
> [ 2213.603339] ath10k_pci 0000:02:00.0: failed to copy target iram contents: -12
> [ 2213.839027] ath10k_pci 0000:02:00.0: could not init core (-12)
> [ 2213.933910] ath10k_pci 0000:02:00.0: could not probe fw (-12)
> 
> And by default coredump_mask does not have ATH10K_FW_CRASH_DUMP_RAM_DATA
> enabled so anyone using a firmware with iram-recovery feature would fail. To my
> knowledge only QCA9984 firmwares starting from release 10.4-3.9.0.2-00099
> enabled the feature.
> 
> The reason for regression was that ath10k_core_copy_target_iram() used
> ath10k_coredump_get_mem_layout() to get the memory layout, but when
> ATH10K_FW_CRASH_DUMP_RAM_DATA was disabled it would get just NULL and bail out
> with an error.
> 
> While looking at all this I noticed another bug: if CONFIG_DEV_COREDUMP is
> disabled but the firmware has iram-recovery enabled the module load fails with
> similar error messages. I fixed that by returning 0 from
> ath10k_core_copy_target_iram() when _ath10k_coredump_get_mem_layout() returns
> NULL.
> 
> Tested-on: QCA9984 hw2.0 PCI 10.4-3.9.0.2-00139
> 
> Fixes: 9af7c32ceca8 ("ath10k: add target IRAM recovery feature support")
> Signed-off-by: Abinaya Kalaiselvan <akalaise@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

6f8c8bf4c7c9 ath10k: fix module load regression with iram-recovery feature

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211020075054.23061-1-kvalo@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

