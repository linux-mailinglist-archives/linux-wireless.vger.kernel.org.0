Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C591B53DC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 06:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDWE4p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 00:56:45 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34003 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbgDWE4p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 00:56:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587617805; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pNXd/CZycuKyE4JgrEEzHAalSPq5TvadN26o6kp52P8=;
 b=GKlLG2CssbqQunorLnOLhBHxgNHNlH+tc372ng9xLzeMvgFuB2B1IIad0iTLvbepjlkkzhVv
 HVVIsB9/eqRNDabjMQprskCD4qWbx89X+RO8Mon2L1VfySaozgS9Tia+eUF1oZqDS23TyCuO
 /rU2UeFihbxhsO1I0mxjAMSqxvg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea11ffd.7f43bb24cab0-smtp-out-n01;
 Thu, 23 Apr 2020 04:56:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD93BC433BA; Thu, 23 Apr 2020 04:56:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DAD7C433D2;
        Thu, 23 Apr 2020 04:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DAD7C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: drop the TX packet which size exceed credit size
 for sdio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200422084719.3479-1-wgong@codeaurora.org>
References: <20200422084719.3479-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200423045628.DD93BC433BA@smtp.codeaurora.org>
Date:   Thu, 23 Apr 2020 04:56:28 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> sdio chip use DMA buffer to receive TX packet from ath10k, and it has
> limitation of each buffer, if the packet size exceed the credit size,
> it will trigger error in firmware.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

8347784d6f5f ath10k: drop the TX packet which size exceed credit size for sdio

-- 
https://patchwork.kernel.org/patch/11503309/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
