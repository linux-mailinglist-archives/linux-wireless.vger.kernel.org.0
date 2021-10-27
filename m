Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9BA43C431
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbhJ0HpA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 03:45:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41839 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240594AbhJ0Ho7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 03:44:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635320554; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=dhmUQ5RYL6vwGrqgkC25J7l0ag8Rlq+nCEbH0JRc1Hw=;
 b=pkjM9UocZ0FRaPLU9AvEPSBtmxwKgwbN/v33JOGVlYbYriTIFXBxZvc5Hc7qhDQKMS81rBNe
 r7QOabzu8VV5t0yGohCnZflWV3ur1sneShXWjsg6h0ZFqF4nHNS4T96uQZ9+5+8Xiep1sJFI
 GCQ2lJBkijNeQl0BMCVHczsnad0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 617902ea9ef7bd81bd6f6901 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 07:42:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 294A8C43616; Wed, 27 Oct 2021 07:42:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C814C43617;
        Wed, 27 Oct 2021 07:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2C814C43617
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
Message-ID: <163532054779.19793.8224705508351732392.kvalo@codeaurora.org>
Date:   Wed, 27 Oct 2021 07:42:34 +0000 (UTC)
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

Patch applied to ath-next branch of ath.git, thanks.

a224b47ab36d wcn36xx: Add chained transfer support for AMSDU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1634557705-11120-1-git-send-email-loic.poulain@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

