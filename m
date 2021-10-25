Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB87B43976E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhJYNYq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 09:24:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45701 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhJYNYp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 09:24:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635168143; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vMZ72Qd0bvdXH0tX7glWZ8rL56bkUFrFgOigkD/KQ08=;
 b=o/en0FdPrPEJKaoFssZU4ldElarW8kr+5tZxHwUwlpK4xO7F4wzyrLXm8VQjuumuhQpAzfR9
 gQxJBhXqL4JK9omA4ZgKteyyWGLS9INLHMNWhjcIhH0dwemAgPVA5URiJRIcG6wTD2ImCTQx
 U7nQOqp5BIdVmcKyuqxiQI4bBiQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6176af8159612e0100364d4d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 13:22:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D05E7C4360D; Mon, 25 Oct 2021 13:22:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2F51C4338F;
        Mon, 25 Oct 2021 13:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D2F51C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Add chained transfer support for AMSDU
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1634557705-11120-1-git-send-email-loic.poulain@linaro.org>
References: <1634557705-11120-1-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163516812328.10163.3396652728924346112.kvalo@codeaurora.org>
Date:   Mon, 25 Oct 2021 13:22:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> WCNSS RX DMA transfer support is limited to 3872 bytes, which is
> enough for simple MPDUs (single MSDU), but not enough for cases
> with A-MSDU (depending on max AMSDU size or max MPDU size).
> 
> In that case the MPDU is spread over multiple transfers, with the
> first transfer containing the MPDU header and (at least) the first
> A-MSDU subframe and additional transfer(s) containing the following
> A-MSDUs. This can be handled with a series of flags to tagging the
> first and last A-MSDU transfers.
> 
> In that case we have to bufferize and re-linearize the A-MSDU buffers
> into a proper MPDU skb before forwarding to mac80211 (in the same way
> as it is done in ath10k).
> 
> This change also includes sanity check of the buffer descriptor to
> prevent skb overflow.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Loic, what should I do with this patch? Bryan is hesitant but I
would be fine to take this. You have to decide :)

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1634557705-11120-1-git-send-email-loic.poulain@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

