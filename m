Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE25273BAA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgIVHX0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:23:26 -0400
Received: from z5.mailgun.us ([104.130.96.5]:53182 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgIVHX0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:23:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600759405; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=MroGAQM7s400FU7KZKTGokW9szkqeLjFFyfBhc9LfLA=;
 b=eG962LVvmjyfenJjgMDEYSPksy9iqOuC/i4hdcAt5lMnNTNyVod3LbHKwNxPX5/BfWCWfRRm
 8oXREwUeKzErMdce9MGKK9JMvo5Lgj27LNV5YRbe5s2KROzNObZsicfoRdPwuMQv3//EtZWn
 7kJtnzuqooYrWXxlgjaX9GFgVEA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f69a66dfa736648e8c4c4c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 07:23:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8B91C433C8; Tue, 22 Sep 2020 07:23:24 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7A9BC433CA;
        Tue, 22 Sep 2020 07:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7A9BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/5] wcn36xx: Add accessor macro HW_VALUE_CHANNEL for
 hardware channels
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200910150708.2179043-2-bryan.odonoghue@linaro.org>
References: <20200910150708.2179043-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200922072324.C8B91C433C8@smtp.codeaurora.org>
Date:   Tue, 22 Sep 2020 07:23:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> Adds HW_VALUE_CHANNEL(hw_value) an access macro that will be used to
> extract the channel number from struct ieee80211_channel->hw_value in
> preparation for also storing PHY settings for 802.11ac in the upper bits of
> hw_value.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

5 patches applied to ath-next branch of ath.git, thanks.

59b5c8447c14 wcn36xx: Add accessor macro HW_VALUE_CHANNEL for hardware channels
f779a92f7b69 wcn36xx: Use HW_VALUE_CHANNEL macro to get channel number
235b9ae0265b wcn36xx: Add accessor macro HW_VALUE_PHY for PHY settings
fc4d4008f810 wcn36xx: Encode PHY mode for 80MHz channel in hw_value
e042bc19aace wcn36xx: Set PHY into correct mode for 80MHz channel width

-- 
https://patchwork.kernel.org/patch/11768915/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

