Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933B62E0CC9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Dec 2020 16:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgLVPcX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 10:32:23 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:15349 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbgLVPcX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 10:32:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608651122; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=fEWw24nI30LjEVmqX2PihyrbqlViK7eac/PwbPUEdAc=; b=CDgKAAZN9Yfm1ZtWajeXvfvjE709C0tcYm6r7VbCSIHgM4lF5S84YGBj5UKbkdjFBXJhZ/iY
 peJeBFmSfIitZ7u2BQ0xaMOCCrRPl6keOV2UURANXraNBCJI+8pAGBsv1e9Jd/CmD5l0YCt+
 aTLOqlqYLwIP6hh2Xjl0hxj+PQo=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fe211507036173f4f9c15f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Dec 2020 15:31:28
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 144EAC43463; Tue, 22 Dec 2020 15:31:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 910B7C433C6;
        Tue, 22 Dec 2020 15:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 910B7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        Pali =?utf-8?Q?Roh?= =?utf-8?Q?=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 18/24] wfx: add data_tx.c/data_tx.h
References: <20201104155207.128076-1-Jerome.Pouiller@silabs.com>
        <20201104155207.128076-19-Jerome.Pouiller@silabs.com>
Date:   Tue, 22 Dec 2020 17:31:22 +0200
In-Reply-To: <20201104155207.128076-19-Jerome.Pouiller@silabs.com> (Jerome
        Pouiller's message of "Wed, 4 Nov 2020 16:52:01 +0100")
Message-ID: <874kkd97sl.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jerome Pouiller <Jerome.Pouiller@silabs.com> writes:

> +void wfx_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
> +	    struct sk_buff *skb)
> +{
> +	struct wfx_dev *wdev = hw->priv;
> +	struct wfx_vif *wvif;
> +	struct ieee80211_sta *sta = control ? control->sta : NULL;
> +	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
> +	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
> +	size_t driver_data_room = sizeof_field(struct ieee80211_tx_info,
> +					       rate_driver_data);
> +
> +	compiletime_assert(sizeof(struct wfx_tx_priv) <= driver_data_room,
> +			   "struct tx_priv is too large");

Interesting, never seen compiletime_assert() before. But I suspect
BUILD_BUG_ON_MSG() is preferred, at least there are more users.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
