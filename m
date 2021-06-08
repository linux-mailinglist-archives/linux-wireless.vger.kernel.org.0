Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63083A0646
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 23:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhFHVnL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 17:43:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27170 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234277AbhFHVnL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 17:43:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623188477; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=mE8kJXf0bdE+m2YIN9i+OGatUzHgx1SFwmYDOvJ6rT4=;
 b=LZV/eMN9gx4WsYxbM34DyJnnFvlm7cbm6IHZl0RxrNxtjt+p431apcQB9MNq4GqoPmNzz4n/
 07oK8fD3XVcvgibb24E3YkrhWnccjKiEVG+KZlKe50Tt5T9T719GJmsZyKr53sdQOrB69Ahw
 ZHb2/kwgQhHmPIeaS9bJpgqVstE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60bfe3f2f726fa4188cc0045 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Jun 2021 21:41:06
 GMT
Sender: jjohnson=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E746DC4323A; Tue,  8 Jun 2021 21:41:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jjohnson)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 441F2C4338A;
        Tue,  8 Jun 2021 21:41:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Jun 2021 14:41:05 -0700
From:   Jeff Johnson <jjohnson@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        ath11k <ath11k-bounces@lists.infradead.org>
Subject: Re: [PATCH v4 0/3] Add support to configure beacon tx mode
In-Reply-To: <1623164855-15910-1-git-send-email-mkenna@codeaurora.org>
References: <1623164855-15910-1-git-send-email-mkenna@codeaurora.org>
Message-ID: <fb7af985fdc740c78e9615c518aa1616@codeaurora.org>
X-Sender: jjohnson@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-08 08:07, Maharaja Kennadyrajan wrote:
> Add support to configure the beacon tx mode as STAGGERED
> or BURST mode via hostapd configuration during the AP
> bring-up or via wpa_suppplicant configuration during MESH
> bring-up.
> 
> Beacons can be sent out in burst(continuously in a single shot
> one after another) or staggered (equally spread out over beacon
> interval) mode.
> 
> V4: Rebased on latest ath.git TOT.
> 
> V3: Addressed Johnson's comment on v2 patch.
> 
> V2: Addressed Johannes's comment on v1 patch.
> 
> Maharaja Kennadyrajan (3):
>   nl80211: Add support for beacon tx mode
>   mac80211: Add support for beacon tx mode
>   ath11k: Add support for beacon tx mode
> 
>  drivers/net/wireless/ath/ath11k/mac.c | 10 +++++++---
>  include/net/cfg80211.h                |  4 ++++
>  include/net/mac80211.h                |  2 ++
>  include/uapi/linux/nl80211.h          | 16 ++++++++++++++++
>  net/mac80211/cfg.c                    |  2 ++
>  net/wireless/nl80211.c                |  9 +++++++++
>  6 files changed, 40 insertions(+), 3 deletions(-)

For entire set:
Reviewed-by: Jeff Johnson <jjohnson@codeaurora.org>
