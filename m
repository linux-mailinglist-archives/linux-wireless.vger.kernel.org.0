Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B312FA5FF
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 17:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406561AbhARQUc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 11:20:32 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:46777 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406534AbhARQTV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 11:19:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610986736; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=wm+mxGUuPXxSQ8+371qwzJL6xgBfSdYkvF8BizbmmV8=;
 b=stpBU99+NbUEhoHi5NWGtEm2kAiM37G1sqAprGy8nhEJ390uPYjKuoPhjOmlOu7gIEpLhWPv
 GShK0jet2rCbCJF6m7JDT3uZbd/YBlg9EEziYf+gph4IvYjZOhaBgxEf+j+r8WWog6xSuK0c
 hKUcT8w/QwKi1+vXL99d3WeizBY=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6005b4ede23dedcc3a76eb13 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 16:18:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E6222C433C6; Mon, 18 Jan 2021 16:18:52 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2104C433CA;
        Mon, 18 Jan 2021 16:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2104C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 3/3] ath10k: allow dynamic SAR power limits via common
 API
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201203103728.3034-4-cjhuang@codeaurora.org>
References: <20201203103728.3034-4-cjhuang@codeaurora.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        briannorris@chromium.org, dianders@chromium.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210118161852.E6222C433C6@smtp.codeaurora.org>
Date:   Mon, 18 Jan 2021 16:18:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> wrote:

> ath10k assigns ath10k_mac_set_sar_specs to ath10k_ops, and
> this function is called when user space application calls
> NL80211_CMD_SET_SAR_SPECS. ath10k also registers SAR type,
> and supported frequency ranges to wiphy so user space can
> query SAR capabilities.
> 
> This SAR power limitation is compared to regulatory txpower
> and selects the minimal one to set when station is connected.
> Otherwise, it delays until the station is connected. If the
> station is disconnected, it returns to regulatory txpower.
> 
> This feature is controlled by hw parameter: dynamic_sar_support.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Abhishek Kumar <kuabhs@chromium.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This added new warnings, I fixed them in the pending branch:

drivers/net/wireless/ath/ath10k/mac.c:84:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
drivers/net/wireless/ath/ath10k/mac.c:89:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201203103728.3034-4-cjhuang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

