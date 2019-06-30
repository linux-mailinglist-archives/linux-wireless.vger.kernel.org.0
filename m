Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C225AF90
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2019 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfF3J2O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jun 2019 05:28:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3J2O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jun 2019 05:28:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4648460909; Sun, 30 Jun 2019 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561886893;
        bh=i83WbKPbI6fYDCv6HOMDpfnHCHhTrF+4+58GEz9LnHM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ATpsHOEJiVJhuoYx77A5qFSSj61aJfhnnaM1gwZhU0JKjm1XZUgy8LIFKwUM9zCFp
         sNFjCw6Gn33NcePi++PuYoKkdYjnwxAHbtP4D2DjENR8n5m7ROve49zx0xk2DsGnpL
         2uwtdwQdnmjoy8VAkbN8Xlewav6ie0SB/B3nCGwA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8032860300;
        Sun, 30 Jun 2019 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561886892;
        bh=i83WbKPbI6fYDCv6HOMDpfnHCHhTrF+4+58GEz9LnHM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=loTRneZMuWXstGqSJrZCq+1JQA1igd0vUzqKbeCSuXNm8jLm82B/g/DrDfhcqXcYQ
         VwJul4pqJ+d6G332Wbq4rUiG1ErBHaKTyfE0mRbtRgpgnby5YPo0CT3iZtWIbR5hqu
         vunsmqgcTSD1sfYceXKjpfNsf843jPA5OoOdAQ4Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8032860300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        royluo@google.com, yf.luo@mediatek.com
Subject: Re: [PATCH 4/6] mt76: mt7615: unlock dfs bands
References: <cover.1561804422.git.lorenzo@kernel.org>
        <33184e0b78983fe7c79fa70c5fbb21042aafa4f5.1561804422.git.lorenzo@kernel.org>
Date:   Sun, 30 Jun 2019 12:28:08 +0300
In-Reply-To: <33184e0b78983fe7c79fa70c5fbb21042aafa4f5.1561804422.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Sat, 29 Jun 2019 12:36:09 +0200")
Message-ID: <87muhzs9qv.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Unlock dfs channels since now mt7615 driver supports radar detection
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> index 5dc4cced5789..6d336d82cafe 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -152,6 +152,12 @@ static const struct ieee80211_iface_combination if_comb[] = {
>  		.max_interfaces = 4,
>  		.num_different_channels = 1,
>  		.beacon_int_infra_match = true,
> +		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
> +				       BIT(NL80211_CHAN_WIDTH_20) |
> +				       BIT(NL80211_CHAN_WIDTH_40) |
> +				       BIT(NL80211_CHAN_WIDTH_80) |
> +				       BIT(NL80211_CHAN_WIDTH_160) |
> +				       BIT(NL80211_CHAN_WIDTH_80P80),

Isn't it questionable to enable these without any testing on real
hardware? Getting DFS to work correctly is hard so I'm very suspicious
about this.

-- 
Kalle Valo
