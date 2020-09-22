Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1F273C3D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgIVHoV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:44:21 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:59108 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbgIVHoV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:44:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600760660; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fr8rL/CN6AzLVNs9zF9SX++p67DXxmCHnztJg0+U+Kc=;
 b=cjo8St9jblJ/49JPT+Ow8gjkW1m58LIkVP5jY6dLA/W2gjXW8ulGQtxMnBiYGGvNIdyN/Ajk
 91Wc6c9ceG16QIS6oVxNwvv3P1THcRidd0llDj69kyZsBuCYespkCL+tFwYYC5RQ+FVQyNoC
 Y1k7ub3Ni3dlcPt+7zGx3hTS36g=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f69ab434a8a578ddc131613 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 07:44:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 17317C433C8; Tue, 22 Sep 2020 07:44:03 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 679A3C433CA;
        Tue, 22 Sep 2020 07:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 679A3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: wmi: remove redundant configuration values from
 init
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1600356507-29237-1-git-send-email-kvalo@codeaurora.org>
References: <1600356507-29237-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        vnaralas@codeaurora.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200922074403.17317C433C8@smtp.codeaurora.org>
Date:   Tue, 22 Sep 2020 07:44:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> In commit 2d4bcbed5b7d ("ath11k: initialize wmi config based on hw_params") the
> wmi config initialisation was moved to hw_ops->wmi_init_config() but the old
> initialisation values were accidentally left to ath11k_wmi_cmd_init(). This
> is very confusing, so remove the redundant values.
> 
> And this was actually so confusing that in commit aa2092a9bab3 ("ath11k: add
> raw mode and software crypto support") I actually it caused a bug: when
> ATH11K_FLAG_RAW_MODE was enabled rx_decap_mode was assigned back to
> TARGET_DECAP_MODE_NATIVE_WIFI in ath11k_init_wmi_config_ipq8074(). Fix this at
> the same time.
> 
> Compile tested only.
> 
> Fixes: 2d4bcbed5b7d ("ath11k: initialize wmi config based on hw_params")
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c695faf745f9 ath11k: wmi: remove redundant configuration values from init

-- 
https://patchwork.kernel.org/patch/11782889/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

