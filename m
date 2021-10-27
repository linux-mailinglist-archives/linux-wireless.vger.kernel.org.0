Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720DB43C447
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbhJ0Hsh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 03:48:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:41888 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbhJ0Hsh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 03:48:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635320772; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fu6puPwG7dyrmRjTVF9HfJ5EInKqVBmbDWY72U01gd4=;
 b=TlKTJbVb/OLD/URv6RU8vhrHibNtuzkA5wBZbaXL2uoiKYolB4vparP0fyRnT/RXo/z08Bcr
 6KFxnt0+K0sB5j/IzOO0hPot0FaGaJmVOlvOKHkocB1U4tljJtBP9AapB8b8di77jZ/MWZxD
 a1nND+NhtYe/rlJzKYyn1qq2DHM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 617903c4fd91319f0f8f5d8d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 07:46:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0C38C4360D; Wed, 27 Oct 2021 07:46:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EEA48C4338F;
        Wed, 27 Oct 2021 07:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org EEA48C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/1] Revert "wcn36xx: Enable firmware link monitoring"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211025093037.3966022-2-bryan.odonoghue@linaro.org>
References: <20211025093037.3966022-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163532076785.19793.546979079260828608.kvalo@codeaurora.org>
Date:   Wed, 27 Oct 2021 07:46:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> Firmware link offload monitoring can be made to work in 3/4 cases by
> switching on firmware feature bit WLANACTIVE_OFFLOAD
> 
> - Secure power-save on
> - Secure power-save off
> - Open power-save on
> 
> However, with an open AP if we switch off power-saving - thus never
> entering Beacon Mode Power Save - BMPS, firmware never forwards loss
> of beacon upwards.
> 
> We had hoped that WLANACTIVE_OFFLOAD and some fixes for sequence numbers
> would unblock this but, it hasn't and further investigation is required.
> 
> Its possible to have a complete set of Secure power-save on/off and Open
> power-save on/off provided we use Linux' link monitoring mechanism.
> 
> While we debug the Open AP failure we need to fix upstream.
> 
> This reverts commit c973fdad79f6eaf247d48b5fc77733e989eb01e1.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

43ea9bd84f27 Revert "wcn36xx: Enable firmware link monitoring"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211025093037.3966022-2-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

