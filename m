Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8203831CE2C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Feb 2021 17:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhBPQht (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Feb 2021 11:37:49 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:54564 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhBPQhr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Feb 2021 11:37:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613493442; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=CdYvfmPYYINxLli89m+5gs/J3wf3B6ct7MojvVUEhVU=; b=LiQ8AdbdI1L0ZsseNRKJCKOVbaar0oyjwEkkg18Cds2HpvgZBvqWZ26GlgboAIirHVNF+gG4
 aghoq/tBX6rVg52wzTgLaNdRdk8yc966C4NJZ/2/yM2/YIH5ir/jsZeyJiCV9NNxfYBPguV0
 8ASf9Pa7HJTUG9S3YAFMCvptyQ4=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 602bf4a44129d8cb4a6aa351 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Feb 2021 16:36:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71AE0C43464; Tue, 16 Feb 2021 16:36:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87A4FC43462;
        Tue, 16 Feb 2021 16:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87A4FC43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 11/11] ath11k: add qcn9074 pci device support
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
        <1612946530-28504-12-git-send-email-akolli@codeaurora.org>
Date:   Tue, 16 Feb 2021 18:36:48 +0200
In-Reply-To: <1612946530-28504-12-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Wed, 10 Feb 2021 14:12:10 +0530")
Message-ID: <87mtw4q89r.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> QCN9074 is PCI based 11ax radio.
> 	- has 2G/5G/6G variants.
> 	- has NSS 2x2 and 4x4 variants.
>
> QCN9074 uses 45MB of HOST DDR memory, target requests host memory in
> segments, each segment is of 2MB size and is physcial contiguous and
> use static window configuration.
>
> Below QMI issues are seen with QCN9074,
> Issue 1:
>  ath11k_pci 0000:06:00.0: qmi failed memory request, err = -110
>  ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-110
> Issue 2:
>  ath11k_pci 0000:06:00.0: firmware crashed: MHI_CB_SYS_ERROR
>  ath11k_pci 0000:06:00.0: qmi failed set mode request, mode: 0, err = -110
>  ath11k_pci 0000:06:00.0: qmi failed to send wlan fw mode:-110

I clarified the commit log to mention that QCN9074 is not fully working
yet.

> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index 70dcb80475b1..259a39e59a91 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -34,10 +34,12 @@
>   */
>  #define ACCESS_ALWAYS_OFF 0xFE0
>  
> -#define QCA6390_DEVICE_ID		0x1101
> +#define QCA6390_DEVICE_ID              0x1101

Here you convert tabs to spaces, I fixed them back.

> +#define QCN9074_DEVICE_ID              0x1104

And modified this to use tabs as well.

>  static const struct pci_device_id ath11k_pci_id_table[] = {
>  	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
> +	{ PCI_VDEVICE(QCOM, QCN9074_DEVICE_ID) },

I removed this and added a comment instead. Let's add the pci id once
the device is fully working.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
