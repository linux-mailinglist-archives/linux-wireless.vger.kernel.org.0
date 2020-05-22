Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76991DE42F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 12:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgEVKWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 06:22:21 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:28897 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728267AbgEVKWV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 06:22:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590142941; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=e1ZbnEKwHUpsPyURh3iWm8gi+aeUsuZwpf1KADo0DgM=; b=ddX9EhJMXXQIZPugBemxtohd5IliwqHkIDGgL550r64mcU9PVt4sxfIFePednJXtYny6NLF0
 FKJAB4t6V1J77FYQBPh7dmeyBHMNBH5fqHhTRoW/AL+ppiMnlqo7qwQ62T8gJVijr7Hm70lV
 Ftd+4veswjvCMPrCc6cSsQYwA68=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec7a7dbe79e24225d85c4a5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 10:22:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14772C433CA; Fri, 22 May 2020 10:22:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB2F4C433C8;
        Fri, 22 May 2020 10:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB2F4C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>
Subject: Re: [PATCH 0/4] brcmfmac: SoftAP creation and dcmd buffer size changes
References: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
        <87zha4do7h.fsf@kamboji.qca.qualcomm.com>
        <09bf3506-2d25-d8a8-43eb-59a2e3d9a9ae@broadcom.com>
Date:   Fri, 22 May 2020 13:22:12 +0300
In-Reply-To: <09bf3506-2d25-d8a8-43eb-59a2e3d9a9ae@broadcom.com> (Arend Van
        Spriel's message of "Tue, 19 May 2020 19:00:21 +0200")
Message-ID: <875zcob76z.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On 5/19/2020 3:54 PM, Kalle Valo wrote:
>> Chi-Hsien Lin <chi-hsien.lin@cypress.com> writes:
>>
>>> Allow SoftAP creation via ioctl from test tool; also update dcmd buffer size
>>> settings for new firmware. Also fix a sparse check error.
>>
>> What ioctl is this exactly? Wireless drivers should be using nl80211,
>> not any ioctl interface.
>
> Hi Kalle,
>
> The terminology is a bit off. This is vendor specific command
> interfacing directly with firmware and the content is opaque from
> driver perspective.

Ah, you mean nl80211 vendor command. That has nothing to do with ioctl :)

> However, a number of these commands have their nl80211 equivalent.
> Especially regarding creation of AP interface I would simply go with
> creation through nl80211.

And do note that we have new rules for nl80211 vendor commands:

https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
