Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B811C4FDB
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 10:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgEEIG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 04:06:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19126 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgEEIG3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 04:06:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588665988; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=9bJAGXIqwd+ZsqWSRoYWPD/+WNKuTBRIXcrYFGtGFqQ=; b=DkokNdL4KoTCiF9eqiIoajPJEu0ysTJ0Pa5y8IviREexT+LptnFZYlt4r8MLoqX3UQWQIvbF
 GEQFtp0Crt0RuQdtmK3Hy7varjfgqdReVd9tMXagzJE3dLUJ3Tgn4Um2H3Vocr/KZmubD/g8
 +fGBUbs1dLAVNQnvjd6rtINjH74=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 342C8C433BA; Tue,  5 May 2020 08:06:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FDB1C433CB;
        Tue,  5 May 2020 08:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FDB1C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Shashidhar Lakkavalli <slakkavalli@datto.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH V2] ath11k: add tx hw 802.11 encapusaltion offloading support
References: <20200430152814.18481-1-john@phrozen.org>
Date:   Tue, 05 May 2020 11:06:05 +0300
In-Reply-To: <20200430152814.18481-1-john@phrozen.org> (John Crispin's message
        of "Thu, 30 Apr 2020 17:28:14 +0200")
Message-ID: <87ftcedcwi.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> This patch adds support for ethernet rxtx mode to the driver. The feature
> is enabled via a new module parameter. If enabled to driver will enable
> the feature on a per vif basis if all other requirements were met.
>
> Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
> Signed-off-by: John Crispin <john@phrozen.org>

[...]

> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -33,6 +33,11 @@
>  	.max_power              = 30, \
>  }
>  
> +/* frame mode values are mapped as per enum ath11k_hw_txrx_mode */
> +static unsigned int ath11k_ath11k_frame_mode = ATH11K_HW_TXRX_NATIVE_WIFI;
> +module_param_named(ath11k_frame_mode, ath11k_ath11k_frame_mode, uint, 0644);
> +MODULE_PARM_DESC(ath11k_frame_mode, "Datapath frame mode");

I don't think we should add ath11k_ prefix to module names, right? So I
changed that and documented the values:

/* frame mode values are mapped as per enum ath11k_hw_txrx_mode */
static unsigned int ath11k_frame_mode = ATH11K_HW_TXRX_NATIVE_WIFI;
module_param_named(frame_mode, ath11k_frame_mode, uint, 0644);
MODULE_PARM_DESC(frame_mode,
		 "Datapath frame mode (0: raw, 1: native wifi (default), 2: ethernet)");

Also I added a comment to enum ath11k_hw_txrx_mode so that we don't
accidentally change the values. This is now in pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=f0717ed39d06a9f2fd32edbdf88f29939dc25516

Please check my changes.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
