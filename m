Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24C133AB31
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 06:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhCOFkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 01:40:17 -0400
Received: from m42-2.mailgun.net ([69.72.42.2]:12412 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhCOFkD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 01:40:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615786803; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=FwJGjdysIo+zgRkoKbaKpsDYLmg5awOg5tV4j6Mxv6M=; b=jgWJ8PwfDMk14Kc3K4Tyyc4jrxiz9acGR1+3sZ8Tre2eaUNM3jvYfNOBJso3BygkiYdm4BRu
 nEO1hJ88oAE0yo0h9OslB2Tu4BWrTpmvUYyrIMsvDroskRvHy5KHy2xDLypJqjR0sTlU01Kn
 H6sgxjnZ4VxDSuhMvcXEGy6iV0U=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 604ef3265d70193f88fa2e0f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Mar 2021 05:39:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6461EC43461; Mon, 15 Mar 2021 05:39:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42DA4C433CA;
        Mon, 15 Mar 2021 05:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42DA4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] iwlwifi: series with smaller improvements
References: <22e63925-1469-2839-e4d3-c10d8658ba82@gmail.com>
Date:   Mon, 15 Mar 2021 07:39:46 +0200
In-Reply-To: <22e63925-1469-2839-e4d3-c10d8658ba82@gmail.com> (Heiner
        Kallweit's message of "Sun, 14 Mar 2021 20:38:29 +0100")
Message-ID: <87k0q9t1p9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Series includes smaller improvements.
>
> Heiner Kallweit (3):
>   iwlwifi: use DECLARE_BITMAP macro
>   iwlwifi: switch "index larger than supported by driver" warning to
>     debug level
>   iwlwifi: use dma_set_mask_and_coherent

iwlwifi patches go to iwlwifi-next, not net-next. But no need to resend
just because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
