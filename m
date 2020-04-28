Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791FD1BB97F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 11:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgD1JIN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 05:08:13 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:11466 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbgD1JIN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 05:08:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588064892; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=jrToHVsOn3Ii2Jyt154DEm3hkF3Igoc/G2VF9yJ3ctw=;
 b=N4wjgnLQeJQ1Yq50RmbH5B0nF8YBw2/95Q5y8yhRALmVsok0VfnIRGeRH8KJc5RTu+4Ioyxn
 v2Lb/HBP57e5QzSuID/7WX2OEFnKfwCZVF0i9VMTWK81duSlEXY5hGO7j4LU+x8dXjcj/UWE
 cNFQzsbpBCLoPXG7JpNsD17a7No=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7f26f.7f97a63a4ca8-smtp-out-n03;
 Tue, 28 Apr 2020 09:07:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06F8AC44788; Tue, 28 Apr 2020 09:07:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A92ADC433CB;
        Tue, 28 Apr 2020 09:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A92ADC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] ath9k: fix AR9002 ADC and NF calibrations
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200424004923.17129-2-ryazanov.s.a@gmail.com>
References: <20200424004923.17129-2-ryazanov.s.a@gmail.com>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200428090759.06F8AC44788@smtp.codeaurora.org>
Date:   Tue, 28 Apr 2020 09:07:59 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:

> ADC calibration is only required for a 80 MHz sampling rate (i.e. for
> 40 MHz channels), when the chip utilizes the pair of ADCs in interleved
> mode. Calibration on a 20 MHz channel will never be completed.
> 
> Previous channel check is trying to exclude all channels where the
> calibration will get stuck. It effectively blocks the calibration run
> for HT20 channels, but fails to exclude 20 MHz channels without HT (e.g.
> legacy mode channels).
> 
> Fix this issue by reworking the channel check to explicitly allow ADCs
> gain & DC offset calibrations for HT40 channels only. Also update the
> complicated comment to make it clear that these calibrations are for
> multi-ADC mode only.
> 
> Stuck ADCs calibration blocks the NF calibration, what could make it
> impossible to work in a noisy evironment: too big Rx attentuation,
> invalid RSSI value, etc. So this change is actually more of a NF
> calibration fix rather then the ADC calibration fix.
> 
> Run tested with AR9220.
> 
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

6 patches applied to ath-next branch of ath.git, thanks.

d6cae2bc195b ath9k: fix AR9002 ADC and NF calibrations
93f8d4223163 ath9k: remove needless NFCAL_PENDING flag setting
41ba50fd6cac ath9k: do not miss longcal on AR9002
2bb7027b64b6 ath9k: interleaved NF calibration on AR9002
ded6ff15a191 ath9k: invalidate all calibrations at once
d8d20845c7f1 ath9k: add calibration timeout for AR9002

-- 
https://patchwork.kernel.org/patch/11506891/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
