Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB6D3B2B63
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhFXJaL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 05:30:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58485 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230438AbhFXJaJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 05:30:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624526871; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6AChACXG9kVfjVi1z1G3VPN4iIKkyo+QGSS0dqdqW1I=; b=jkPpSx/uSlLZ145vc9CnSRR9fcdOClZvqv8Nw5s9Xn5TQR3WUKomp7OyBkGp0klmVo6anDEK
 yOPnwEkXshOBZRZvZG0gNC1w308o6qtK0ZSG2drNasHUq42heyZUSCEKoW06eoPLVzinIaLC
 sIINik7x62U90qcyC2V8Gs1HLr0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60d44ff7638039e997f6d1b5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 09:27:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C065C43460; Thu, 24 Jun 2021 09:27:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 462A7C433F1;
        Thu, 24 Jun 2021 09:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 462A7C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 04/12] wilc1000: setup registers to support chip wakeup sequence
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
        <20210423182925.5865-5-ajay.kathat@microchip.com>
Date:   Thu, 24 Jun 2021 12:27:16 +0300
In-Reply-To: <20210423182925.5865-5-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Fri, 23 Apr 2021 18:29:44 +0000")
Message-ID: <87im23ipe3.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Configure required register for WILC1000 wakeup sequence out of sleep
> for SPI and SDIO module.

Why?

>  .../wireless/microchip/wilc1000/cfg80211.c    |  1 -
>  .../net/wireless/microchip/wilc1000/netdev.h  |  1 -
>  .../net/wireless/microchip/wilc1000/wlan.c    | 98 ++++++++++---------
>  .../net/wireless/microchip/wilc1000/wlan.h    |  2 +
>  .../net/wireless/microchip/wilc1000/wlan_if.h |  6 --
>  5 files changed, 53 insertions(+), 55 deletions(-)

Single sentence commit logs for non-trivial patches are usually a bad
idea. Please don't do that, that saves both yours and my time.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
