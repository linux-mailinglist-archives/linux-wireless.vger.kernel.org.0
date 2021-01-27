Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035AF3058EB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 11:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhA0K4Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 05:56:25 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:44840 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236247AbhA0KyW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 05:54:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611744837; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SheNhVtT9eDL5luFgog3R/47oD2k+j9pqHrgMva/o9Y=;
 b=t6lpPA2E8ttj++cYFa1iPUxTDp8sPfLeuW3bBsfOAUMb0uxFhr8Md0LJqnX7ScFFnA8VNRIj
 PyxNSgjzSX+HFRt85uzRk1nVF8FUK4FxPFxjd5WrwpuDkYbOUxK8DpVAJcwrA9U0JbKGmCnJ
 gLWRbjrtVawhaAtQITAZGuk6HrQ=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60114627a8db6424322afbed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Jan 2021 10:53:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D660C433C6; Wed, 27 Jan 2021 10:53:27 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69528C433CA;
        Wed, 27 Jan 2021 10:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69528C433CA
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
Message-Id: <20210127105327.5D660C433C6@smtp.codeaurora.org>
Date:   Wed, 27 Jan 2021 10:53:27 +0000 (UTC)
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

In the pending branch removed test for !sar->sub_specs based on Dan's report.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201203103728.3034-4-cjhuang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

