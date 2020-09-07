Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC725F5F5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 11:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgIGJEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 05:04:33 -0400
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:55116
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgIGJEb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 05:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599469470;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=891jM/EV80bPFOKUpizphjfVBSGtHA1/R1BQtx/8XKs=;
        b=o9VedWIlAWuecekRFgQz5Km4RosltqJ9IRUBeCiQqIWVL3tKtsdckNA4X5hD/7f0
        6iXsNZJ3qyd5QZu725n74qHa36VEZy7qTtSkV1B7yXG2Nn5KmdVTULlOnzZ0MqB7K5X
        HQ1MswDR4MOMjTunHrFw6E4JH0vrB9fvxZGsyB9Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599469470;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=891jM/EV80bPFOKUpizphjfVBSGtHA1/R1BQtx/8XKs=;
        b=H8wMoBe3LMDv7TNc+/UvSeN1euh0uGkdY7P6UVInt7h1de2Udewjxs5kQVHj902T
        vxesPnk1CXunkt8WiSoEFBqZolGdLUZUBOaB1dVvceS5BTyh/6rTRIHzBISWVlSnwhi
        pNMluXCFPHGkH8wu4sz8BT9vOcvUGatM6yukEt6Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7D59C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: Re: [PATCH 1/4] brcmfmac: add change_bss to support AP isolation
References: <20200901063237.15549-1-wright.feng@cypress.com>
        <20200901063237.15549-2-wright.feng@cypress.com>
Date:   Mon, 7 Sep 2020 09:04:30 +0000
In-Reply-To: <20200901063237.15549-2-wright.feng@cypress.com> (Wright Feng's
        message of "Tue, 1 Sep 2020 01:32:34 -0500")
Message-ID: <0101017467cf4336-e8ed5107-762a-431d-9ef0-a2631dd090be-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> writes:

> Hostap has a parameter "ap_isolate" which is used to prevent low-level
> bridging of frames between associated stations in the BSS.
> Regarding driver side, we add cfg80211 ops method change_bss to support
> setting AP isolation if firmware has ap_isolate feature.
>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 23 +++++++++++++++++++
>  .../broadcom/brcm80211/brcmfmac/feature.c     |  1 +
>  .../broadcom/brcm80211/brcmfmac/feature.h     |  3 ++-
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 5d99771c3f64..7ef93cd66b2c 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -5425,6 +5425,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
>  	return brcmf_set_pmk(ifp, NULL, 0);
>  }
>  
> +static int
> +brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
> +			  struct bss_parameters *params)
> +{
> +	struct brcmf_if *ifp;
> +	int ret = 0;
> +	u32 ap_isolate;
> +
> +	brcmf_dbg(TRACE, "Enter\n");
> +	ifp = netdev_priv(dev);
> +	if (params->ap_isolate >= 0) {
> +		ap_isolate = (u32)params->ap_isolate;

Is the cast to u32 really necessary? Please avoid casts as much as
possible.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
