Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5980A273BA9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgIVHWL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:22:11 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:27307 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbgIVHWK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:22:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600759329; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2yC4x95NralxjfNA+QJtjVnLiVD1vKvkgky5RcN0aG8=;
 b=jThKaA8BAv3/8Tb2EwCm8FX41JO7FnJJ6kyH24fvY65Rfr8Z66qUAp2VyBERBwiU/0qHb2T9
 xEeOh1XAKTiGk/749HDY7/BEEs8apL7pyzN8VzX6XSr8FmxHwPBmULpurHtOllaq7i+0C5EK
 WtP92fYeUSRyFw/m3RTky+2Xcxg=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f69a60653220b80d73b1217 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 07:21:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D65AAC433C8; Tue, 22 Sep 2020 07:21:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A929C433CB;
        Tue, 22 Sep 2020 07:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A929C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: Use bdf calibration variant for snoc targets
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1600157948-2042-1-git-send-email-pillair@codeaurora.org>
References: <1600157948-2042-1-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200922072141.D65AAC433C8@smtp.codeaurora.org>
Date:   Tue, 22 Sep 2020 07:21:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> Board Data File (BDF) is loaded upon driver boot-up procedure.
> The right board data file is identified using bus and qmi-board-id.
> 
> The problem, however, can occur when the (default) board data
> file cannot fulfill with the vendor requirements and it is
> necessary to use a different board data file.
> 
> Also using the chip_id for identifying the board data helps
> in dealing with different variants of the board data file based
> on the RF card. If the chip_id is not programmed, a default value
> of 0xff will be used for parsing the board data file.
> 
> Add the support to get the variant field from DTSI and
> use this information along with the chip_id to load the vendor
> specific BDF.
> 
> The device tree requires addition strings to define the variant name
> 
>     wifi@a000000 {
>             status = "okay";
>             qcom,ath10k-calibration-variant = "xyz-v2";
>     };
> 
>     wifi@a800000 {
>             status = "okay";
>             qcom,ath10k-calibration-variant = "xyz-v1";
>     };
> 
> This would create the boarddata identifiers for the board-2.bin search
> 
>  *  bus=snoc,qmi-board-id=16,qmi-chip-id=0,variant=xyz-v1
>  *  bus=snoc,qmi-board-id=17,qmi-chip-id=0,variant=xyz-v2
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

4e9381056547 ath10k: Use bdf calibration variant for snoc targets

-- 
https://patchwork.kernel.org/patch/11775827/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

