Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F026ACCB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Sep 2020 20:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgIOS7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Sep 2020 14:59:16 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53556 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbgIORLq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Sep 2020 13:11:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600189906; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=xNZ+Cr+foACkGUCgkY9KHTMbu/oaTGO7IAGEInqWGNc=; b=wM/flsJ1jyqTfMl3G5EogV8D37TyD+gFcdGpi5ReQY+aSsVpYA/JxI9lIoukIapuwxzM6Vzg
 GLxH5VSUHnjMBsMN4Yz4ehlKQSCoJHxrXOBpK3MbfmI/w9i1ycE/XEOzj8pATWSALsglkrGo
 jYFYEE83b9ilOwKborXcJ4A/128=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f60f320d7b4e269136db80a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 17:00:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63450C433FF; Tue, 15 Sep 2020 17:00:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D6D1EC433C8;
        Tue, 15 Sep 2020 17:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D6D1EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Miles Hu <milehu@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH V6 2/2] ath11k: add support for setting fixed HE rate/gi/ltf
References: <20200804081630.2013619-1-john@phrozen.org>
        <20200804081630.2013619-2-john@phrozen.org>
Date:   Tue, 15 Sep 2020 20:00:11 +0300
In-Reply-To: <20200804081630.2013619-2-john@phrozen.org> (John Crispin's
        message of "Tue, 4 Aug 2020 10:16:30 +0200")
Message-ID: <87zh5rkmas.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> From: Miles Hu <milehu@codeaurora.org>
>
> This patch adds ath11k support for setting fixed HE rate/gi/ltf values that
> we are now able to send to the kernel using nl80211. The added code is
> reusing parts of the existing code path already used for HT/VHT. The new
> helpers are symmetric to how we do it for HT/VHT.
>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: John Crispin <john@phrozen.org>

[...]

> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -119,6 +119,22 @@ enum {
>  	WMI_HOST_WLAN_2G_5G_CAP	= 0x3,
>  };
>  
> +/* Parameters used for WMI_VDEV_PARAM_AUTORATE_MISC_CFG command.
> + * Used only for HE auto rate mode.
> + */
> +enum {
> +/* HE LTF related configuration */
> +	WMI_HE_AUTORATE_LTF_1X = (1 << 0),
> +	WMI_HE_AUTORATE_LTF_2X = (1 << 1),
> +	WMI_HE_AUTORATE_LTF_4X = (1 << 2),
> +
> +/* HE GI related configuration */
> +	WMI_AUTORATE_400NS_GI = (1 << 8),
> +	WMI_AUTORATE_800NS_GI = (1 << 9),
> +	WMI_AUTORATE_1600NS_GI = (1 << 10),
> +	WMI_AUTORATE_3200NS_GI = (1 << 11),
> +};

BIT()?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
