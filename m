Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE801F3A18
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 13:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgFILv1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 07:51:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51581 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgFILv0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 07:51:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591703486; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=eBNhDOmCX9mDr0iY7jz60lDnz5Pe7bMOdlcxefoJO7Q=; b=HZiaPZw2TOaXfnDhi/uTjtc9OQjrrf1uyNTeB9wwY/SHuUXmGN3ZhN2O1/I4v/OWEQcUB23I
 jZkD38cYkF62JqQGRpkrrOeko9eIIBVC8hcXXA1IlrL+0H0DHYea2sI5VUvA2h18Xbth/Cpk
 ZlsNgb7J9p190v1RPbKHcqfeLgA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5edf77bdf1889e857a1c5a82 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 11:51:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0210C433CB; Tue,  9 Jun 2020 11:51:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC799C433C6;
        Tue,  9 Jun 2020 11:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC799C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <saint.chuang@cypress.com>
Subject: Re: [PATCH 3/6] brcmfmac: reserve 2 credits for host tx control path
References: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
        <20200609105913.163239-4-chi-hsien.lin@cypress.com>
Date:   Tue, 09 Jun 2020 14:51:20 +0300
In-Reply-To: <20200609105913.163239-4-chi-hsien.lin@cypress.com> (Chi-Hsien
        Lin's message of "Tue, 9 Jun 2020 05:59:10 -0500")
Message-ID: <873674o3t3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> writes:

> From: Amar Shankar <amsr@cypress.com>
>
> It is observed that sometimes when sdiod is low in tx credits in low
> rssi scenarios, the data path consumes all sdiod rx all credits and
> there is no sdiod rx credit available for control path causing host
> and card to go out of sync resulting in link loss between host and
> card. So in order to prevent it some credits are reserved for control
> path.
>
> Note that TXCTL_CREDITS can't be larger than the firmware default
> credit update threshold 2; otherwise there will be a deadlock for both
> side waiting for each other.
>
> Signed-off-by: Amar Shankar <amsr@cypress.com>
> Signed-off-by: Jia-Shyr Chuang <saint.chuang@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index ce6f15284277..163bb7f41e44 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -635,6 +635,8 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
>  	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012)
>  };
>  
> +#define TXCTL_CREDITS	2
> +
>  static void pkt_align(struct sk_buff *p, int len, int align)
>  {
>  	uint datalign;
> @@ -647,6 +649,14 @@ static void pkt_align(struct sk_buff *p, int len, int align)
>  
>  /* To check if there's window offered */
>  static bool data_ok(struct brcmf_sdio *bus)
> +{
> +	/* Reserve TXCTL_CREDITS credits for txctl */
> +	return (u8)(bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
> +	       ((u8)(bus->tx_max - bus->tx_seq) & 0x80) == 0;
> +}

Why casting to u8? Is it really necessary?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
