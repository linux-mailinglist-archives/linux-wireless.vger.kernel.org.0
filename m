Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC2E41344E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhIUNgX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 09:36:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33387 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhIUNgW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 09:36:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632231294; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=rMsvCffFJ3+0N+6wyxdzibJjqJY2iTTL7lbHAhYm9rI=;
 b=EfLUJprFpIz/V9RxE4fJdMTLIkgz8Ytfp+EdVVhzZPo8JX1+ge/iHEP1g+eGJjMTM8PyWZlE
 38cLnv9JedTzCZT3MJzoVRaAbESSIVyGKbpBe3nhSEywKE7XPM5wJhLhcoFfOn2+i04Bp/73
 sSUIPJhosGEhoaJLV1BAwu0Gt80=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6149df748b04ef8589697cad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 13:34:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7D1EC43616; Tue, 21 Sep 2021 13:34:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97F55C4338F;
        Tue, 21 Sep 2021 13:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 97F55C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Implement Idle Mode Power Save
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210909153320.2624649-1-bryan.odonoghue@linaro.org>
References: <20210909153320.2624649-1-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210921133444.A7D1EC43616@smtp.codeaurora.org>
Date:   Tue, 21 Sep 2021 13:34:44 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> Idle Mode Power Save (IMPS) is a power saving mechanism which when called
> by wcn36xx will cause the radio hardware to enter power collapse.
> 
> This particular call maps nicely to a simple conjunction/disjunction around
> IEEE80211_CONF_CHANGE_IDLE and IEEE80211_CONF_IDLE.
> 
> Here we enter idle when we are not associated with an AP. The kernel will
> incrementally toggle idle on/off in the process of trying to establish a
> connection, thus saving power until we are connected to the AP again, at
> which point we give way to BMPS if power_save is on.
> 
> We've validated that with IMPS an apq8039 device which has the wcn36xx
> module loaded but, has not authenticated with an AP will get to VMIN on
> suspend and will not without IMPS.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Benjamin Li <benl@squareup.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

0e159d2c0834 wcn36xx: Implement Idle Mode Power Save

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210909153320.2624649-1-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

