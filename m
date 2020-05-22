Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0381DE496
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgEVKhz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 06:37:55 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44236 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728592AbgEVKhy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 06:37:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590143874; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=olQX6mZGmZMen4ae9mTlLURnX92/Cdedk/TOlnQoFGE=; b=qN9t9nvITQf4TmTSAD2/d9kXwCOVU0E+GA3NlLAdds5u3e/GYaC6Oewg5VZP+nHITaGeJW+/
 JbDh++JxX248EkfQFmc+WO8LAfXB0TK7ZR+UlbL74/WTERxvugCHVXhTDXtUPdITvVZl2Bib
 ubu3+9HuJAnAxHFrTS0B5cLS0Ik=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec7ab817171b6d7e4add891 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 10:37:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E903FC43395; Fri, 22 May 2020 10:37:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BB7DC433C6;
        Fri, 22 May 2020 10:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BB7DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>
Subject: Re: [PATCH 0/5] brcmfmac: SDIO parameter change series
References: <20200521034838.57371-1-chi-hsien.lin@cypress.com>
Date:   Fri, 22 May 2020 13:37:45 +0300
In-Reply-To: <20200521034838.57371-1-chi-hsien.lin@cypress.com> (Chi-Hsien
        Lin's message of "Wed, 20 May 2020 22:48:33 -0500")
Message-ID: <87o8qg9rwm.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> writes:

> Set F2 blocksize and watermark for several chips to fix bus error during
> stress tests.
>
>
> Double Lo (2):
>   brcmfmac: fix 4339 CRC error under SDIO 3.0 SDR104 mode
>   brcmfmac: 43012 Update MES Watermark
>
> Frank Kao (1):
>   brcmfmac: set F2 blocksize and watermark for 4354/4356 SDIO
>
> Wright Feng (2):
>   brcmfmac: set F2 blocksize for 4373
>   brcmfmac: fix 43455 CRC error under SDIO 3.0 SDR104 mode
>
>  .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 22 ++++++-
>  .../broadcom/brcm80211/brcmfmac/sdio.c        | 58 ++++++++++++++++---
>  2 files changed, 70 insertions(+), 10 deletions(-)
>
> --
> 2.25.0
>
>
> This message and any attachments may contain confidential information
> from Cypress or its subsidiaries. If it has been received in error,
> please advise the sender and immediately delete this message.

If you want me to apply something don't include disclaimers like this.
These kind of emails go immeadiately to /dev/null.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
