Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC5027252A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 15:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgIUNPF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 09:15:05 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:59545 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgIUNPF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 09:15:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600694104; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=VjKTYWhWJ/rmGHfZ5d7EQdshOGCFQTn+ovP4sIriYg4=;
 b=Sms7Wv5rm7TNbo/EhnNjdnGr2PDG7D3yBD996+hlRdV3oeoUEXLT8uhotvSAwoE8PEGETc2G
 G7vTUrCipv3FFqR5w8GDFrQ5hGHoHmnLWH9NvFWEX8qvT+sEcMBa/NW7TY2Nkqr7wDWVTGFd
 Vj88giSu7spLz6Uo8/OzAmXvZDw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f68a7064398385e308c246d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 13:13:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4E1F3C433FF; Mon, 21 Sep 2020 13:13:41 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49219C433C8;
        Mon, 21 Sep 2020 13:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49219C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/2] wcn36xx: Add VHT fields to parameter data
 structures
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200910150450.2178784-2-bryan.odonoghue@linaro.org>
References: <20200910150450.2178784-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200921131341.4E1F3C433FF@smtp.codeaurora.org>
Date:   Mon, 21 Sep 2020 13:13:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> In order to pass VHT parameters to wcn3680 we need to use a super-set of
> the V1 data-structures with additional VHT parameters tacked on.
> 
> This patch adds the additional fields to the STA and BSS parameter
> structures.
> 
> Since neither wcn3620 nor wcn3660 support VHT the size of the passed
> message is fixed to the previous message length. Subsequent changes will
> differentiate between wcn3620/wcn3660 and wcn3680 which does use the larger
> message size.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

96d6617d64ee wcn36xx: Add VHT fields to parameter data structures
617e7cf80c92 wcn36xx: Use V1 data structure to store supported rates

-- 
https://patchwork.kernel.org/patch/11768987/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

