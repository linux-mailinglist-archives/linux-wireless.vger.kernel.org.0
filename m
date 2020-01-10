Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C559E136817
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2020 08:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAJHQU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jan 2020 02:16:20 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:63053 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbgAJHQU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jan 2020 02:16:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578640579; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=+T5bfhKwhIRutpNEoM3STa+mJOWH/4Y71kETTJnBQZM=; b=rtHzM9iRDD/CzdNm2LfG7hDQb1QDLU9xhORUdDKF9MtpbKQhkN6rH8JidpiimmRNfgmyybiI
 RCyAumEbpbVkDDRQBtrnDFPAYAcEGt4IKJbFM7sxRAsW7G8ok4NIb7h6ZUUcY66c0w8WB3Yy
 4yWiZ7BKDTMtcofv4j/JwAJr1kY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1824c0.7fccb40d2228-smtp-out-n01;
 Fri, 10 Jan 2020 07:16:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9326C4479F; Fri, 10 Jan 2020 07:16:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F5E8C433CB;
        Fri, 10 Jan 2020 07:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F5E8C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 0/2] ath10k: Enable QDSS clock on sm8150
References: <20191223054855.3020665-1-bjorn.andersson@linaro.org>
Date:   Fri, 10 Jan 2020 09:16:11 +0200
In-Reply-To: <20191223054855.3020665-1-bjorn.andersson@linaro.org> (Bjorn
        Andersson's message of "Sun, 22 Dec 2019 21:48:53 -0800")
Message-ID: <87zhevsrwk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bjorn Andersson <bjorn.andersson@linaro.org> writes:

> On SM8150 the WiFi firmware depends on the QDSS clock ticking, or the system
> will reset due to an NoC error. So this adds an optional clock to the ath10k
> binding and makes sure it's enabled while the WiFi firmware needs it.
>
> Bjorn Andersson (2):
>   ath10k: Add optional qdss clk
>   arm64: dts: qcom: sm8150: Specify qdss clock for wifi
>
>  .../devicetree/bindings/net/wireless/qcom,ath10k.txt          | 2 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi                          | 4 ++--
>  drivers/net/wireless/ath/ath10k/snoc.c                        | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Via which tree are these supposed to go? I'll take patch 1 and arm
mantainers take patch 2, or what?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
