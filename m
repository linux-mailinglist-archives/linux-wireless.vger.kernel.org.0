Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6AE1B54BF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgDWGeF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 02:34:05 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:40256 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbgDWGeF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 02:34:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587623645; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=d6DeLgdxZxGHqKCavQ16Pn/ermyK+T7kgS/aq6u/nXg=;
 b=t7DrLzlpMItaJ3/3QtCmcm+qc1sSUqAajgD882SFpp7klqSUN+AeaHxOhwPOHWjAeHfZm4zq
 vmGV41/lGJAEI05NkYRUEDO8eTbvgpFcuszD1jT6UTVLlo1IFPY31lLpRzBaEsuA8VvWw0fX
 KkHgBKtDXXTjic0WejP9P6Clnro=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea136d1.7f54f7518ae8-smtp-out-n02;
 Thu, 23 Apr 2020 06:33:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3FFD0C433BA; Thu, 23 Apr 2020 06:33:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC5BCC433D2;
        Thu, 23 Apr 2020 06:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC5BCC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: Remove ATH10K_STATE_RESTARTED in simulate fw crash
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1555059170-11988-1-git-send-email-wgong@codeaurora.org>
References: <1555059170-11988-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200423063353.3FFD0C433BA@smtp.codeaurora.org>
Date:   Thu, 23 Apr 2020 06:33:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> When test simulate firmware crash, it is easy to trigger error.
> command:
> echo soft > /sys/kernel/debug/ieee80211/phyxx/ath10k/simulate_fw_crash.
> 
> If input more than two times continuously, then it will have error.
> Error message:
> ath10k_pci 0000:02:00.0: failed to set vdev 1 RX wake policy: -108
> ath10k_pci 0000:02:00.0: device is wedged, will not restart
> 
> It is because the state has not changed to ATH10K_STATE_ON immediately,
> then it will have more than two simulate crash process running meanwhile,
> and complete/wakeup some field twice, it destroy the normal recovery
> process.
> 
> add flag wait-ready for this command:
> echo soft wait-ready > /sys/kernel/debug/ieee80211/phyxx/ath10k/simulate_fw_crash
> 
> Tested with QCA6174 PCI with firmware
> WLAN.RM.4.4.1-00109-QCARMSWPZ-1, but this will also affect QCA9377 PCI.
> It's not a regression with new firmware releases.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

I'm dropping this as I suspect the real bug is somewhere else and this
is just a workaround.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/10897587/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
