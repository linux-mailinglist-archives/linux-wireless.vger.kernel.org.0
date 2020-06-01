Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719441EB1D6
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2020 00:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgFAWmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 18:42:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:29329 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgFAWmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 18:42:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591051356; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AiD0/AsHqrbhLADE7omoVnTFthsdt1/Gwn1XMzVDk4Q=;
 b=ineI64MqJw7qgr26KZDOqTJ7j4VYuT0QdzDkWXzTflcBbaetizchumI9KXcycF6aMZEnBlWZ
 cJgZ41p9ypSPKW1cG+vHrZagjqWFFfjB6NtXEePAVORarSBBQuwQCkU99ABWzOS/qkzHzmdA
 Woo+bljhFKFwc3PF0NNrJekKH+g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5ed584568e09c0ae0925a6f4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Jun 2020 22:42:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E48ACC43391; Mon,  1 Jun 2020 22:42:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69740C433CB;
        Mon,  1 Jun 2020 22:42:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Jun 2020 15:42:29 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v3 11/11] ath11k: build HE 6 GHz capability
In-Reply-To: <1589399105-25472-11-git-send-email-rmanohar@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
 <1589399105-25472-11-git-send-email-rmanohar@codeaurora.org>
Message-ID: <21cc960760e4b3c3c4723fa6d03260c7@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-13 12:45, Rajkumar Manoharan wrote:
> Build 6 GHz band capability from HT and VHT capabilities reported
> by firmware.
> 
> Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/core.h |  1 +
>  drivers/net/wireless/ath/ath11k/mac.c  | 34 
> ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
Kalle,

Please drop this patch as it needs to be reworked on top of latest 
mac80211 series.
Will submit ath11k patch again as the rest of the series were handled by 
Johannes.

-Rajkumar
