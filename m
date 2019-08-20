Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E86966D1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 18:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfHTQwv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 12:52:51 -0400
Received: from nbd.name ([46.4.11.11]:60572 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfHTQwv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 12:52:51 -0400
Received: from pd95fd754.dip0.t-ipconnect.de ([217.95.215.84] helo=[192.168.45.104])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1i07NJ-0006bl-RF; Tue, 20 Aug 2019 18:52:49 +0200
Subject: Re: [PATCH 02/49] ath11k: add Kconfig
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-3-git-send-email-kvalo@codeaurora.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <f5af5ff4-63d6-6b94-6c04-8436f955985a@phrozen.org>
Date:   Tue, 20 Aug 2019 18:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1566316095-27507-3-git-send-email-kvalo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 20/08/2019 17:47, Kalle Valo wrote:
> ---
>   drivers/net/wireless/ath/ath11k/Kconfig | 34 +++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
> new file mode 100644
> index 000000000000..26bf98fa648e
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath11k/Kconfig
> @@ -0,0 +1,34 @@
> +config ATH11K
> +        tristate "Qualcomm Technologies 802.11ax chipset support"
> +        depends on MAC80211 && HAS_DMA

    ^^ space vs tab here

     John

> +	depends on REMOTEPROC
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select ATH_COMMON
> +	select QCOM_QMI_HELPERS
> +        help
> +          This module adds support for Qualcomm Technologies 802.11ax family of
> +	  chipsets.
> +
> +          If you choose to build a module, it'll be called ath11k.
> +
