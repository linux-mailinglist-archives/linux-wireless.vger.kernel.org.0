Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6A1CE238
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgEKSEM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 14:04:12 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60414 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgEKSEM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 14:04:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589220251; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=tWVsinoe7YxP1KIzQ0oELCQrckm/L3wrXS0QPj4JO7I=; b=PzpDysb2QjeJgkUk8eF2TcRrHnVt8KSRZjybQFjj8TiU/HaL+GC/PYQtkAVK+9/X1eSMUJ7f
 evFjd8Z0yjQ0wAe5tf0uBNKIPCj6mzk8riGd7Eea1lrT0dk6V1sZnlmEqYgOueQonvqkox6b
 x7N8aSKti/ixTxjJOYf9QDTm0/E=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb99391.7f25782435e0-smtp-out-n01;
 Mon, 11 May 2020 18:04:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8EB50C433BA; Mon, 11 May 2020 18:04:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34324C433CB;
        Mon, 11 May 2020 18:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34324C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 4/4] ath11k: Register mhi controller device for qca6390
References: <20200508085850.23363-1-govinds@codeaurora.org>
        <20200508085850.23363-5-govinds@codeaurora.org>
Date:   Mon, 11 May 2020 21:03:56 +0300
In-Reply-To: <20200508085850.23363-5-govinds@codeaurora.org> (Govind Singh's
        message of "Fri, 8 May 2020 14:28:50 +0530")
Message-ID: <87d07a4acz.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ mani

Govind Singh <govinds@codeaurora.org> writes:

> MHI is a communication protocol to communicate with external
> Qualcomm modems and Wi-Fi chipsets over high speed peripheral buses. Even
> though MHI doesn=E2=80=99t dictate underlying physical layer, protocol an=
d mhi stack
> is structured for PCIe based devices.
>
> Register directly with mhi core layer as a mhi device driver for
> firmware download.
>
> Tested QCA6390 on X86 platform.
> Tested firmware WLAN.HST.1.0.1.c1-00440-QCAHSTSWPLZ_V2_TO_X86-1.
>
> Signed-off-by: Govind Singh <govinds@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath11k/Kconfig
> +++ b/drivers/net/wireless/ath/ath11k/Kconfig
> @@ -2,7 +2,6 @@
>  config ATH11K
>  	tristate "Qualcomm Technologies 802.11ax chipset support"
>  	depends on MAC80211 && HAS_DMA
> -	depends on REMOTEPROC
>  	depends on CRYPTO_MICHAEL_MIC
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	select ATH_COMMON
> @@ -15,13 +14,13 @@ config ATH11K
>=20=20
>  config ATH11K_AHB
>  	tristate "Qualcomm Technologies 802.11ax chipset AHB support"
> -	depends on ATH11K
> +	depends on ATH11K && REMOTEPROC
>  	---help---
>  	  This module adds support for AHB bus
>=20=20
>  config ATH11K_PCI
>  	tristate "Qualcomm Technologies 802.11ax chipset PCI support"
> -	depends on ATH11K && PCI
> +	depends on ATH11K && PCI && MHI_BUS
>  	---help---
>  	  This module adds support for PCIE bus

Currently ATH11K_PCI is not visible if MHI_BUS is disabled, which I'm
worried will confuse the users. I wonder if we should use 'select
MHI_BUS' instead? That way ATH11K_PCI would be visible even if MHI_BUS
is disabled.

And what about QRTR_MHI? Mani, any suggestions?

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
