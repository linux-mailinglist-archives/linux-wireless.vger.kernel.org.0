Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635D03F1BFF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbhHSO4H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 10:56:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52850 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbhHSO4G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 10:56:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629384930; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ZMZ+tVnn1OQrA/xR1tLIkzplXGqtKswmNF8xcHLd+LQ=; b=XdKkjbSTGpMWrjiKx/WnUsAqhTYzKLgY4shSbxOfuQAKhi14hnF2Sz6rnrP+rcOTgd3u2vC7
 /U1Mv8Cx7yUnUAdE9dXUa7pLnVFUcmDJGNiunFlPf+cAflANJzJ8fvNWjmBEVYuB3gD7f5Sz
 4Am9ZNdV6wSxdBFENnNr0Ufkvvw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 611e70dd1a9008a23e70deb3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Aug 2021 14:55:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B54D6C43616; Thu, 19 Aug 2021 14:55:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5780C4338F;
        Thu, 19 Aug 2021 14:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C5780C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        Deren.Wu@mediatek.com
Subject: Re: [PATCH 3/5] mt76: mt7921: report tx rate directly from tx status
References: <cover.1629277624.git.lorenzo@kernel.org>
        <1aa7b946cac8bb1c3d3ad3eaa41a7c610d122d92.1629277624.git.lorenzo@kernel.org>
Date:   Thu, 19 Aug 2021 17:55:19 +0300
In-Reply-To: <1aa7b946cac8bb1c3d3ad3eaa41a7c610d122d92.1629277624.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Wed, 18 Aug 2021 11:09:58 +0200")
Message-ID: <87a6ldbi20.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Report tx rate from tx status packets instead of receiving periodic mcu
> event. This improves flexibility, accuracy and AQL performance, and
> simplifies code flow for better readability.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

[...]

> +		/* We don't support reading GI info from txs packets.
> +		 * For accurate tx status reporting and AQL improvement,
> +		 * we need to make sure that flags match so polling GI
> +		 * from per-sta counters directly.
> +		 */
> +		rate = &msta->wcid.rate;
> +		addr = MT_WTBL_LMAC_OFFS(idx, 0) + 7 * 4;

Magic values.

> +		val = mt76_rr(dev, addr);
> +
> +		switch (rate->bw) {
> +		case RATE_INFO_BW_160:
> +			bw = IEEE80211_STA_RX_BW_160;
> +			break;
> +		case RATE_INFO_BW_80:
> +			bw = IEEE80211_STA_RX_BW_80;
> +			break;
> +		case RATE_INFO_BW_40:
> +			bw = IEEE80211_STA_RX_BW_40;
> +			break;
> +		default:
> +			bw = IEEE80211_STA_RX_BW_20;
> +			break;
> +		}
> +
> +		if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
> +			u8 offs = 24 + 2 * bw;
> +
> +			rate->he_gi = (val & (0x3 << offs)) >> offs;

Ditto.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
