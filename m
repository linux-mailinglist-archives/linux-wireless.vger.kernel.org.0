Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1662E1ABA1F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439483AbgDPHjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 03:39:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:29575 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439282AbgDPHjQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 03:39:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587022756; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kTUwTMGt5cqrYWR5ITK2FgMxJGdYB47P8TO4nINIG3w=;
 b=cx5nZoPTisj/TA9T+8v5spZIoOQKJqcvv6yEU2rp5MpT1ofhrz36Az0gqEKSTMKFZPMwPJ5K
 AyCmz5r8Bqgm0HyPYsJRZgLWv0RG1hfBAxoDSxrD2SWH8l1TbiODc0ur5hF/jKU5uUrF2Vqc
 G/avsbb4UrvWWz+BzDjA/oYZ/vI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e980b86.7f833658f538-smtp-out-n01;
 Thu, 16 Apr 2020 07:38:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9F768C432C2; Thu, 16 Apr 2020 07:38:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A8F6C433F2;
        Thu, 16 Apr 2020 07:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A8F6C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath10k: allow dynamic SAR power limits to be
 configured
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1576684108-30177-3-git-send-email-kvalo@codeaurora.org>
References: <1576684108-30177-3-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200416073845.9F768C432C2@smtp.codeaurora.org>
Date:   Thu, 16 Apr 2020 07:38:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> From: Wen Gong <wgong@codeaurora.org>
> 
> Add support for a vendor command for STATION, the command
> QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS which is already defined in
> git://w1.fi/hostap.git (src/command/qca-vendor.h). This allows user
> space to configure power limits for 2.4 GHz and 5 GHz bands.
> 
> ath10k set pdev parameter WMI_PDEV_PARAM_TXPOWER_LIMIT2G and
> WMI_PDEV_PARAM_TXPOWER_LIMIT5G to firmware, the 2 value will
> be used as one input source to affect the tx power.
> 
> When QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS set to ath10k, it will
> be saved the 2.4G and 5G limit value, If STATION is connected meanwhile,
> then the 2.4G and 5G WMI command will be set to firmware, otherwise
> it will not set to firmware at this moment. When STATION connect
> next time, it will set to firmware.
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

I'll drop this from my queue now and will resend once there's a
concensus on what interface to use.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11301107/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
