Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E238104ADE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 07:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUG5B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 01:57:01 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:55960
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfKUG5A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 01:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574319420;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=bV8Zcx5mO7XxOKjQqHlaaX5qeBI2uWbz4K8TOji/BdQ=;
        b=aVVuU9QiH6/Toa9sgkRdoxIh9DvCeC1pkiRvGtBuzOvl23w5/SKGtVjm9800VPat
        49voy1rkHvza3i+RwgLeaUKN5m5js2M82+it46IF4BVfZT/1wqHHYCj/VdOvKJvZjj9
        j5TtWKJQ2qh1YUdck11Pz3PwVQXrXkGJ00LrCKIY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574319420;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=bV8Zcx5mO7XxOKjQqHlaaX5qeBI2uWbz4K8TOji/BdQ=;
        b=Oqcq9LEUuNQbPyyg7sSm/qEcTcyAa6spT42A08WLgFmc3VKX6L76gSp//RnpX4zw
        FGK7NW5ij4B1LpotQr4sagLHauf7H4EN/7J82AyP1uu3prjnFHUmPJr3MvDZzZpoU2n
        KMObqbFx6wWZIpcLfV8yuBudlGjL9qUIv9xi9Eu4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B813C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        royluo@google.com
Subject: Re: [PATCH v2 3/3] mt76: mt7615: add set_coverage class support
References: <cover.1574253996.git.lorenzo@kernel.org>
        <7c9088415ce08fd8b71eda9b53a4a213865886aa.1574253996.git.lorenzo@kernel.org>
Date:   Thu, 21 Nov 2019 06:57:00 +0000
In-Reply-To: <7c9088415ce08fd8b71eda9b53a4a213865886aa.1574253996.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Wed, 20 Nov 2019 15:01:45 +0200")
Message-ID: <0101016e8cbff2f0-f543727d-0d42-45d5-a536-64e5545d4946-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.21-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Add the capability to configure actimeout for mt7615 driver. Moreover

acktimeout?

> configure slottime according to the value provided by mac80211
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

[...]

> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -60,6 +60,47 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev)
>  	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
>  }
>  
> +/* XXX: DBDC support */
> +void mt7615_mac_set_timing(struct mt7615_dev *dev)

Should this be "FIXME:"? Thought don't remember what style is used in
mt76.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
