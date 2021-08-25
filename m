Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9C83F6D63
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 04:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhHYCTW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 22:19:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52706 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbhHYCTV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 22:19:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629857916; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=zkMf6TvHMYWGClNY/J3MKCa7YlhEPpJW5voKdcIkmC8=;
 b=jaJ1BS+3t8gnwfb+BTuEpj33f745QoGTnryiabZhd+lyL8CoqoBaWDXabtaXyt1uRw3gyxea
 Zc3raMfYlz8jwM6MNlimIJMPwkyGVm8SeDt+u6LO6iBXAYokUoHSigBnMIlYFKxS4LwLBbh9
 BDXAP0mmTuv68g23rUbKze0CJxw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6125a86acd680e89699973b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 02:18:18
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C082EC43618; Wed, 25 Aug 2021 02:18:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40443C4338F;
        Wed, 25 Aug 2021 02:18:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Aug 2021 10:18:17 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 0/8] cfg80211/mac80211: Add support for 6GHZ STA for
 various modes : LPI, SP and VLP
In-Reply-To: <20210820122041.12157-1-wgong@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
Message-ID: <6589258be9fd32d2ac5b364c69c4c25a@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi johannes,

Could I get your comments on this v2 patches?

On 2021-08-20 20:20, Wen Gong wrote:
> v2: change per comments of johannes.
>     including code style, code logic, patch merge, commit log...
> 
> It introduced some new concept:
> power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
> power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
> power spectral density(psd)
> 
> This patchset for cfg80211/mac80211 is to add the definition of new
> concept of 6G and add basic parse of IE(transmit power envelope
> element) in beacon and save power spectral density(psd) reported
> by lower-driver for 6G channel, the info will be passed to lower
> driver when connecting to 6G AP.
> 
> Wen Gong (8):
>   cfg80211: add power type definition for 6 GHz
>   mac80211: add definition of regulatory info in 6 GHz operation
>     information
>   mac80211: add parse regulatory info in 6 GHz operation information
>   cfg80211: add definition for 6 GHz power spectral density(psd)
>   cfg80211: save power spectral density(psd) of regulatory rule
>   mac80211: add definition for transmit power envelope element
>   mac80211: add parse transmit power envelope element
>   mac80211: save transmit power envelope element and power constraint
> 
>  include/linux/ieee80211.h    | 43 +++++++++++++++++++++++++++++++++++-
>  include/net/cfg80211.h       |  7 ++++++
>  include/net/mac80211.h       |  6 +++++
>  include/net/regulatory.h     |  1 +
>  include/uapi/linux/nl80211.h | 36 ++++++++++++++++++++++++++++++
>  net/mac80211/chan.c          |  9 ++++++++
>  net/mac80211/ieee80211_i.h   |  3 +++
>  net/mac80211/mlme.c          | 26 ++++++++++++++++++++++
>  net/mac80211/util.c          | 19 ++++++++++++++++
>  net/wireless/reg.c           | 14 ++++++++++++
>  10 files changed, 163 insertions(+), 1 deletion(-)
