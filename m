Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCC1C4F30
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgEEHec (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 03:34:32 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:10755 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgEEHec (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 03:34:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588664071; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6rdBhKuiYxEUD7yWkFxIXkHGzzyQyMwga0bzWDTLC2U=;
 b=PZArMREGcJAkUfk90lfZRX3kUB7DnjW04Dp8iDND2GMTNzcPgD+grhVlI6GOXKz8d3U6M8cT
 TNaGY4VR4muV1r22XEh6F0WRkhVCgzjGNmNbS3adlA5uWSwk2VhW/KEntrS9El7IGOI9FUNs
 gC7KAb29rn97MtHTVzzyxJ0ydrY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb116ff.7f63ecd08378-smtp-out-n03;
 Tue, 05 May 2020 07:34:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3DF5C43637; Tue,  5 May 2020 07:34:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62DAAC433F2;
        Tue,  5 May 2020 07:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62DAAC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Avoid override CE5 configuration for QCA99X0
 chipsets
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1587649759-14381-1-git-send-email-mkenna@codeaurora.org>
References: <1587649759-14381-1-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200505073422.C3DF5C43637@smtp.codeaurora.org>
Date:   Tue,  5 May 2020 07:34:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> As the exisiting CE configurations are defined in global, there
> are the chances of QCA99X0 family chipsets CE configurations
> are getting changed by the ath10k_pci_override_ce_config()
> function.
> 
> The override will be hit and CE5 configurations will be changed,
> when the user bring up the QCA99X0 chipsets along with QCA6174
> or QCA9377 chipset. (Bring up QCA99X0 family chipsets after
> QCA6174 or QCA9377).
> 
> Hence, fixing this issue by moving the global CE configuration
> to radio specific CE configuration.
> 
> Tested hardware: QCA9888 & QCA6174
> Tested firmware: 10.4-3.10-00047 & WLAN.RM.4.4.1.c3-00058
> 
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

521fc37be3d8 ath10k: Avoid override CE5 configuration for QCA99X0 chipsets

-- 
https://patchwork.kernel.org/patch/11505695/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
