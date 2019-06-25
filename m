Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CFE5500A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfFYNQb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 09:16:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52356 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfFYNQb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 09:16:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 537A960867; Tue, 25 Jun 2019 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561468590;
        bh=F56wmmoWnTrE3I0MDCeml3psln77qAjE6+nzM4OTrBU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fL7UO87N9k+MQqXkfv2hmdZAC2HIPSZwltTIZCvmeLBpNgtf5wt+1uROlPueea+il
         BwReJgqV3cTj0iupb5xyHvZnvaEoUdq3UwKGZJ5BUxlBycdgMih3fO3KeiWB+IeHy0
         7I+afz9Gp5DAxQTWHjZUkJwNJ9P266A2TpfTDYYQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7785060867;
        Tue, 25 Jun 2019 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561468589;
        bh=F56wmmoWnTrE3I0MDCeml3psln77qAjE6+nzM4OTrBU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=osQ4BiM0ezvBAgBtKa+c4opdk5LcrAHsILgAnAbxh9U+0VNf+Mf95rbbraCfqapzp
         6CWnyTFQHYR+X4yCHj5TA6K9i0FBVtzZmi4E/9rdiPYJ882WtqFgz6dRoEW46RDFcD
         dcTMGv7YJ2QubumAA3cchgPWMRhQwfPT6sPcNjcQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7785060867
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: add report MIC error for sdio chip
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1559010432-1005-1-git-send-email-wgong@codeaurora.org>
References: <1559010432-1005-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625131630.537A960867@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 13:16:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> Firmware will report flag with HTT_RX_IND_MPDU_STATUS_TKIP_MIC_ERR
> if MIC error, the flag will be used in mac80211.
> 
> ieee80211_rx_h_michael_mic_verify will check the flag and start TKIP
> countermeasures.
> 
> Now countermeasure tests pass both with WPA only and WPA2/WPA mixed
> mode.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

47ed1b4e5d62 ath10k: add report MIC error for sdio chip

-- 
https://patchwork.kernel.org/patch/10963647/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

