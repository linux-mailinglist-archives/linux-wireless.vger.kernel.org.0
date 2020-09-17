Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF726DF90
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgIQPYm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 11:24:42 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:27818 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728145AbgIQPYj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 11:24:39 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:24:39 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600356261; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=F+SF08fyE7ToxyIPjbHFyQnwT8G/4ga57t/Io9iwz0c=; b=Mn1kOCCIivj3Z6F6pn8X5PwUkFLTgHrB/ObuQX4YQ/gXs5ILxDa658JoQX3goQRT3tF4iJrY
 qY0C0M+v26jCEpsfL+16VkuqQcc/ZEnd0cy6okM1ZjB1cFmmRgQYV9PIvQ7ftElHrY8ml49q
 /ITajXFscSzqNOJm78Ra25TCje0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f637e434ab73023a73dbc57 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Sep 2020 15:18:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E5BFC433FF; Thu, 17 Sep 2020 15:18:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82442C433F1;
        Thu, 17 Sep 2020 15:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82442C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>
Cc:     ath11k@lists.infradead.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCHv2] ath11k: add raw mode and software crypto support
References: <010101746c6a54fa-91406158-3f0a-4f10-8328-a7f560dd3feb-000000@us-west-2.amazonses.com>
Date:   Thu, 17 Sep 2020 18:18:22 +0300
In-Reply-To: <010101746c6a54fa-91406158-3f0a-4f10-8328-a7f560dd3feb-000000@us-west-2.amazonses.com>
        (Venkateswara Naralasetty's message of "Tue, 8 Sep 2020 06:32:22
        +0000")
Message-ID: <871rj0h1oh.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <vnaralas@codeaurora.org> writes:

> Adding raw mode tx/rx support. Also, adding support
> for software crypto which depends on raw mode.
>
> To enable raw mode tx/rx:
> insmod ath11k.ko frame_mode=0
>
> To enable software crypto:
> insmod ath11k.ko crypto_mode=1
>
> These modes could be helpful in debugging crypto related issues.
>
> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -3366,6 +3366,10 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
>  	config.rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
>  	config.rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
>  	config.rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
> +
> +	if (test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags))
> +		config.rx_decap_mode = TARGET_DECAP_MODE_RAW;

Did you test this at all? Because to me it looks like in
ath11k_init_wmi_config_ipq8074() this is overwritten with:

	config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;

So I can't see how this would even work. I noticed this while I was
cleaning up ath11k_wmi_cmd_init(). I'll send a patch soon, please test
that and let me know if it works.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
