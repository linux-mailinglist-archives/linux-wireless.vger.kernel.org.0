Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59383244D63
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHNRQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 13:16:00 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:18734 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727894AbgHNRP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 13:15:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597425359; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=mPlMnRBo7ujhcOrq01sZdy7AHWBN3hp9Xm7yx0IG3Sg=; b=L3gQLmEkg/ZeKCVJ6bkN+H0iAJznLRH+YYK98prmyapBoNzln1PkbM+i39ko6L+W48tg9uD+
 xYxcj3LHd3ULcyJUeEI8UtjgIyBluuTvG7ivdJ56/ZbMSSiOgMmBfJIWehnDyHm3ofRPPtVg
 wLUF//6WwZggnQB6ULzJ9y8bbd4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f36c6cdcbcd42bdee8620a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 17:15:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1A280C43395; Fri, 14 Aug 2020 17:15:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3819AC433C9;
        Fri, 14 Aug 2020 17:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3819AC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>, sfr@canb.auug.org.au
Subject: Re: [PATCH mac80211-next] ath10k: fix unhandled switch value warning
References: <20200731055636.795173-1-thomas@adapt-ip.com>
Date:   Fri, 14 Aug 2020 20:15:53 +0300
In-Reply-To: <20200731055636.795173-1-thomas@adapt-ip.com> (Thomas Pedersen's
        message of "Thu, 30 Jul 2020 22:56:36 -0700")
Message-ID: <87lfih87xy.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thomas Pedersen <thomas@adapt-ip.com> writes:

> Cited commit introduced the following warnings:
>
> drivers/net/wireless/ath/ath10k/mac.c: In function 'chan_to_phymode':
> drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration
> value 'NL80211_CHAN_WIDTH_1' not handled in switch [-Wswitch]
>   558 |   switch (chandef->width) {
>       |   ^~~~~~
> drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration
> value 'NL80211_CHAN_WIDTH_2' not handled in switch [-Wswitch]
> drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration
> value 'NL80211_CHAN_WIDTH_4' not handled in switch [-Wswitch]
> drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration
> value 'NL80211_CHAN_WIDTH_8' not handled in switch [-Wswitch]
> drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration
> value 'NL80211_CHAN_WIDTH_16' not handled in switch [-Wswitch]
> drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration
> value 'NL80211_CHAN_WIDTH_1' not handled in switch [-Wswitch]
>   581 |   switch (chandef->width) {
>       |   ^~~~~~
> drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL80211_CHAN_WIDTH_2' not handled in switch [-Wswitch]
> drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL80211_CHAN_WIDTH_4' not handled in switch [-Wswitch]
> drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL80211_CHAN_WIDTH_8' not handled in switch [-Wswitch]
> drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL80211_CHAN_WIDTH_16' not handled in switch [-Wswitch]
>
> Fix them by making the existing invalid channel width
> cases the default, as the introduced channel widths
> currently don't make sense in 2 or 5GHz either.
>
> Fixes: e5cb3d34a66d ("nl80211: S1G band and channel definitions")
> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

I assume Johannes takes this so:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
