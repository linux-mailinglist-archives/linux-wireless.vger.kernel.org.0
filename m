Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1351464C4
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2020 10:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAWJpb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jan 2020 04:45:31 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:47483 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgAWJpb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jan 2020 04:45:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579772730; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=J1piZ9mf20dVma6ZdwiUEfUmokqKUki0Go93/0Hhu60=;
 b=aC/BB1KPEGXm8Z3MZjswXAg4sH4GeBmgur4QsLZJ7RBrNreTFmSTCAq1+pU3QS7kWzD80iGv
 xRMWy20kASOulYcEBAU6+k3hXHbfT5SXfffsi3TeS6M9x0afNgoUmqjtZ5kZtRgPDThmlylX
 loOzsgKdc3rbQ5bAwlieuLCV60g=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e296b38.7efe966e8110-smtp-out-n02;
 Thu, 23 Jan 2020 09:45:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0A569C447A1; Thu, 23 Jan 2020 09:45:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DDE7C43383;
        Thu, 23 Jan 2020 09:45:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 23 Jan 2020 15:15:26 +0530
From:   periyasa@codeaurora.org
To:     John Crispin <john@phrozen.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [RESEND] ath11k: add tx hw 802.11 encapusaltion offloading
 support
In-Reply-To: <20200122142930.19239-1-john@phrozen.org>
References: <20200122142930.19239-1-john@phrozen.org>
Message-ID: <d4c4c85868ad02bb4b65b7de0f31f264@codeaurora.org>
X-Sender: periyasa@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> This patch adds support for ethernet rxtx mode to the driver. The 
> feature
> is enabled via a new module parameter. If enabled to driver will enable
> the feature on a per vif basis if all other requirements were met.
> 
> Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  drivers/net/wireless/ath/ath11k/core.h  |  5 +++
>  drivers/net/wireless/ath/ath11k/dp_tx.c | 16 ++++++++--
>  drivers/net/wireless/ath/ath11k/mac.c   | 41 ++++++++++++++++++++-----
>  3 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c
> b/drivers/net/wireless/ath/ath11k/mac.c
> index 556eef9881a7..f56adba5f838 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -33,6 +33,10 @@
>  	.max_power              = 30, \
>  }
> 
> +static unsigned int ath11k_ethernet_mode;
> +module_param_named(ethernet_mode, ath11k_ethernet_mode, uint, 0644);
> +MODULE_PARM_DESC(ethernet_mode, "Use ethernet frame datapath");
> +

Shall we have a generic module parameter instead of a dedicated module 
parameter for ethernet mode?
so that we can extend this module parameter for raw mode also like below

/* 0 - Nativi wifi
  * 1 - Ethernet mode
  */
static unsigned int ath11k_mode;
module_param_named(mode, ath11k_mode, uint, 0644);
MODULE_PARM_DESC(mode, "Use for rxtx frame datapath");

- Karthikeyan
