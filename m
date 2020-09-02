Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABCD25A829
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBJAB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 05:00:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15553 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBJAB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 05:00:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599037200; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=PwgPG0w++u7gxVLJkDtVrQKM7Kz4Z8HEZW5bWK3xSFU=;
 b=hHynMGbYfUL6z4dwgiiAh3vBRGprqs3f3qWJURNVngKpNJDVCfjMW/pcZR5HCxot39ug94bv
 oa6UAftwb9pTicX9BDgVgvy4TPNpibtrsDoBIG88Zp3aU82TJe1C0BsASfAPSQCQl48uF0Ed
 WIYUZZs28oelyqcCMyNr/82WKvw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f4f5efe73afa3417eec076e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 08:59:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D94BC433CB; Wed,  2 Sep 2020 08:59:42 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61FD9C433C9;
        Wed,  2 Sep 2020 08:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61FD9C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/12] wcn36xx: Add VHT fields to parameter data
 structures
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200829033908.2167689-2-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200902085942.0D94BC433CB@smtp.codeaurora.org>
Date:   Wed,  2 Sep 2020 08:59:42 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> In order to pass VHT parameters to wcn3680 we need to use a super-set of
> the V1 data-structures with additional VHT parameters tacked on.
> 
> This patch adds the additional fields to the STA and BSS parameter
> structures with some utility macros to make calculation of the structure
> size easier.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

New warnings:

drivers/net/wireless/ath/wcn36xx/smd.c:1257:1: warning: 'wcn36xx_smd_set_sta_params_v1' defined but not used [-Wunused-function]
 1257 | wcn36xx_smd_set_sta_params_v1(struct wcn36xx *wcn,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/wcn36xx/smd.c:150:1: warning: 'wcn36xx_smd_set_bss_vht_params' defined but not used [-Wunused-function]
  150 | wcn36xx_smd_set_bss_vht_params(struct ieee80211_vif *vif,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

12 patches set to Changes Requested.

11743937 [v2,01/12] wcn36xx: Add VHT fields to parameter data structures
11743997 [v2,02/12] wcn36xx: Use V1 data structure to store supported rates
11743939 [v2,03/12] wcn36xx: Add wcn36xx_set_default_rates_v1
11743977 [v2,04/12] wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
11743963 [v2,05/12] wcn36xx: Add wcn36xx_smd_set_sta_default_vht_params()
11743943 [v2,06/12] wcn36xx: Add wcn36xx_smd_set_sta_default_ht_ldpc_params()
11743945 [v2,07/12] wcn36xx: Add wcn36xx_smd_set_sta_vht_params()
11743951 [v2,08/12] wcn36xx: Add wcn36xx_smd_set_sta_ht_ldpc_params()
11743949 [v2,09/12] wcn36xx: Add wcn36xx_smd_set_bss_vht_params()
11743947 [v2,10/12] wcn36xx: Add wrapper function wcn36xx_smd_set_sta_params_v1()
11743961 [v2,11/12] wcn36xx: Define INIT_HAL_MSG_V1()
11743953 [v2,12/12] wcn36xx: Convert to VHT parameter structure on wcn3680

-- 
https://patchwork.kernel.org/patch/11743937/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

