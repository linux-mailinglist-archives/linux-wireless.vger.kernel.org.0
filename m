Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8941B37B7
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 08:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDVGoU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 02:44:20 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21978 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgDVGoU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 02:44:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587537859; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=70A7ZfKXIddcoL5KXuouHiyBWABsywMLh+AHXZRnMWQ=;
 b=anUCOX9QOKKalzop/lvLo4tT9m4y2rE7Qun5WESD/y1caFWQzMyBe3B/KyPVsHllARb2ykkq
 +qSsB7/+e8g1RySekHSDjGO77WTRIxBKYSkBiMSyJ8JyO6CS0Jt500GetRXW+3B4VDL9x3kf
 jLlMCSR1nrRraPb7ZQME/261JFc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9fe7b3.7fe885a20f10-smtp-out-n01;
 Wed, 22 Apr 2020 06:44:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC4D4C433BA; Wed, 22 Apr 2020 06:44:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FF83C433CB;
        Wed, 22 Apr 2020 06:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FF83C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 1/2] ath10k: add htt TX bundle for sdio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200410061400.14231-2-wgong@codeaurora.org>
References: <20200410061400.14231-2-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200422064402.EC4D4C433BA@smtp.codeaurora.org>
Date:   Wed, 22 Apr 2020 06:44:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> The transmission utilization ratio for sdio bus for small packet is
> slow, because the space and time cost for sdio bus is same for large
> length packet and small length packet. So the speed of data for large
> length packet is higher than small length.
> 
> Test result of different length of data:
> 
> data packet(byte)   cost time(us)   calculated rate(Mbps)
>       256               28                73
>       512               33               124
>      1024               35               234
>      1792               45               318
>     14336              168               682
>     28672              333               688
>     57344              660               695
> 
> This patch change the TX packet from single packet to a large length
> bundle packet, max size is 32, it results in significant performance
> improvement on TX path.
> 
> Also there's a fourth thread "ath10k_tx_complete_wq" added to ath10k as it
> improves TCP RX throughput (values in Mbps):
> 
>                                        TCP-RX    TCP-TX    UDP-RX      UDP-TX
> use workqueue_tx_complete              423       357       448         412
> change it to ar->workqueue             410       360       449         414
> change it to ar->workqueue_aux         405       339       446         401
> 
> This patch only effect sdio chip, it will not effect PCI, SNOC etc.
> It only enable bundle for sdio chip.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

c8334512f3dd ath10k: add htt TX bundle for sdio
2f918ea98606 ath10k: enable alt data of TX path for sdio

-- 
https://patchwork.kernel.org/patch/11482769/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
