Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543824311A1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhJRH5d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 03:57:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33480 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230484AbhJRH5d (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 03:57:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634543722; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=hMsWIwLb78ruXZ6mKyePl03WLURSzzzymTNkRnN93bc=; b=CJg5WAlc5a4ELBeI25KNA3XUhFQUSAppZpWTvvAfj+KBTzXb1ay26c+1kK5ApIe0A0aPCVzs
 Raxt2Wvd+J54mpYhNVKEo9IYvQS82MsVKXKlDVLI7rVrcRtP6YZ6WrVrnV7apN4U2Ejp4lD1
 JNxmADvD84kTqVOQPeU8epsw8DY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 616d285e835b7947c187ba2b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 07:55:10
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DE20CC4360C; Mon, 18 Oct 2021 07:55:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC901C4338F;
        Mon, 18 Oct 2021 07:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CC901C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH for v5.15 0/5] iwlwifi: fixes intended for v5.15 2021-10-16
References: <20211016084359.246930-1-luca@coelho.fi>
Date:   Mon, 18 Oct 2021 10:55:03 +0300
In-Reply-To: <20211016084359.246930-1-luca@coelho.fi> (Luca Coelho's message
        of "Sat, 16 Oct 2021 11:43:54 +0300")
Message-ID: <8735oywyw8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Luca Coelho <luciano.coelho@intel.com>
>
> Hi,
>
> This is the first patchset with fixes for v5.15.
>
> The changes are:
>
> * Some memory handling fixes;
> * Fix the device initialization configuration for So devices;
> * Fix resume flow when iwlwifi resume fails;
> * Fix device configuration for JnP edvices.
>
> As usual, I'm pushing this to a pending branch, for kbuild bot.  And
> since these are fixes for the rc series, please take them directly to
> wireless-drivers.git, as we agreed.  I'll assign them to you.

We are in -rc6 now and I'm not planning to send anymore fixes to v5.15,
unless something really critical pops up. Can I take these to
wireless-drivers-next?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
