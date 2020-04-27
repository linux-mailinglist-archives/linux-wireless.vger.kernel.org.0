Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2290C1BABA0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgD0Rsg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 13:48:36 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:18633 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbgD0Rsg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 13:48:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588009716; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=aTV7c7VKbovpYgqPZMaS9DGukTLeKKa4QtBk937B9Jo=;
 b=ueiKAsIzdpt4ggBiBQiF2EmcsFzioNYEz1RNQYW9znGwhGCrItuvApBv2JPjzI1f6jXE5bwz
 Psr10+4QxqCZcg7Ymma+mM1VNsrD2cVfY82e1DKy0yCgG3NpxBVeKcc+0DOMzKkkVJKzR31l
 wOnFQRImlkJhOGtgWlVMYCrHsxM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea71ae3.7f3f96cd4148-smtp-out-n01;
 Mon, 27 Apr 2020 17:48:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EDDA7C433F2; Mon, 27 Apr 2020 17:48:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96BFEC433CB;
        Mon, 27 Apr 2020 17:48:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Apr 2020 23:18:17 +0530
From:   tamizhr@codeaurora.org
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC PATCH v2 0/5] cfg80211: updates and fixes for TID specific
 configuration
In-Reply-To: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
References: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
Message-ID: <b07ecb20a71ba74250a677cbf87b8e81@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-24 16:59, Sergey Matyukevich wrote:
> Hello Johannes, Tamizh, and all
> 
> This patch series contains several minor fixes and enhancements for TID
> specific configuration functionality. The first three patches include
> minor fixes and TID specific AMSDU configuration.
> 
> The 4th patch is somewhat controversial, so the series is marked as 
> RFC.
> This patch simplifies current override logic. It suggests to make no
> difference between 'specific peer' and 'all peers' cases and to apply
> new TID configuration immediately after resetting the previous one.
> 
> The 5th patch enables access to new kernel functionality from iw tool.
> Note that nl80211.h changes are not included into iw. So to make this
> change work in iw , header should be updated upfront, including new
> AMSDU attribute from this patch series.
> 
> Regards,
> Sergey
> 
> v1 -> v2
> 
> - add policy for new AMSDU attribute
> - add patch for iw with support for per-tid per-node configuration
> 
> 
> Sergey Matyukevich (5):
>   cfg80211: fix mask type in cfg80211_tid_cfg structure
>   mac80211: fix variable names in TID config methods
>   cfg80211: add support for TID specific AMSDU configuration
>   nl80211: simplify peer specific TID configuration
Patches looks good to me
Reviewed-by: Tamizh Chelvam <tamizhr@codeaurora.org>

>   iw: add TID specific configuration command
Looks neat to me :)
Reviewed-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> 
>  include/net/cfg80211.h       |  6 ++++--
>  include/uapi/linux/nl80211.h | 20 +++++++++++---------
>  net/mac80211/cfg.c           |  6 +++---
>  net/mac80211/driver-ops.h    |  4 ++--
>  net/wireless/nl80211.c       | 13 +++++++++----
>  5 files changed, 29 insertions(+), 20 deletions(-)
