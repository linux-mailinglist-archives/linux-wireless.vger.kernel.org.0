Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4475268717
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 10:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgINIVV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Sep 2020 04:21:21 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53131 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbgINIVU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Sep 2020 04:21:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600071679; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=1u/lB6XfQUokeO1bUG5zYal6b+t7ZQovD8SvBYfgEEk=; b=J5njcou5cgTAEm9K9HlmVNprkpTxVarcmLw8/wZZ0w2bqrGgHu/hxkCzK3YbUConl5MMQLmr
 wnCZMWjw3ioipFa8vUHvaOUUqOCUr6hWFgvk6klgk2ETJFDf9R09O98OzAgNJvXn5UjBJAdC
 bhEctYJzlEyf4jfV9sojFaexcXU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f5f27e34ba82a82fdbc84c9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 08:20:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 617ECC433F0; Mon, 14 Sep 2020 08:20:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76251C433C6;
        Mon, 14 Sep 2020 08:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76251C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com, Kurt Lee <kurt.lee@cypress.com>
Subject: Re: [PATCH v2 2/3] brcmfmac: set net carrier on via test tool for AP mode
References: <20200914031634.190721-1-wright.feng@cypress.com>
        <20200914031634.190721-3-wright.feng@cypress.com>
Date:   Mon, 14 Sep 2020 11:20:46 +0300
In-Reply-To: <20200914031634.190721-3-wright.feng@cypress.com> (Wright Feng's
        message of "Sun, 13 Sep 2020 22:16:33 -0500")
Message-ID: <87v9ggojkx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> writes:

> From: Kurt Lee <kurt.lee@cypress.com>
>
> In manufacturing line, test tool may be used to enable SoftAP. Such
> SoftAP can't pass traffic because netif carrier is off by default. To
> allow such use case, let brcmfmac parse ioctl cmd, and then set iftype
> to ap mode and report netif_carrier_on to upper layer.

nl80211 does not use ioctl(), so the commit log is misleading.

> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
> @@ -64,6 +64,15 @@ static int brcmf_cfg80211_vndr_cmds_dcmd_handler(struct wiphy *wiphy,
>  		*(char *)(dcmd_buf + len)  = '\0';
>  	}
>  
> +	if (cmdhdr->cmd == BRCMF_C_SET_AP) {
> +		if (*(int *)(dcmd_buf) == 1) {
> +			ifp->vif->wdev.iftype = NL80211_IFTYPE_AP;
> +			brcmf_net_setcarrier(ifp, true);
> +		} else {
> +			ifp->vif->wdev.iftype = NL80211_IFTYPE_STATION;
> +		}
> +	}

We now have rules for the vendor API:

https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api

As the BRCMF_VNDR_CMDS_DCMD just seems to be a simple pipe between the
user space and the firmware I'm leaning towards that we should just
remove support for that command from brcmfmac.

And besides, for factory tests you should be using NL80211_CMD_TESTMODE.
The vendor API is meant for normal mode usage.


-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
