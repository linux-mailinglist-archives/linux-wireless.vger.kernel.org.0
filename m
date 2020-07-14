Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53C21F882
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 19:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgGNRtP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 13:49:15 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:19863 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgGNRtN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 13:49:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594748952; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=HvsG3hhsmb4gPVoc6UyHgNH5M3ItFOz74uIV5eiJe8Y=; b=bDXIRIo/ghe7A9VLsAFEBxQmC1vBuzr0SRoTLqcty9Te3c7bXUbgxlwo1vDemsLON/pFOtdf
 9iJUE3KB9lKcE7/vQ7EpDnObc9kTEDprZPi0FdkrojJZW8xHvDKoeNwJm2RFKwv8KB2LWjDp
 3lgx7pTAOPUps27tg/W3a4YbJV8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f0df01675eeb235f6006cc0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 17:49:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EE35BC433C8; Tue, 14 Jul 2020 17:49:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB94DC433CA;
        Tue, 14 Jul 2020 17:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB94DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Chuang <joseph.chuang@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: Re: linux-next: Fixes tag needs some work in the wireless-drivers-next tree
References: <20200714205942.26248f1c@canb.auug.org.au>
Date:   Tue, 14 Jul 2020 20:49:05 +0300
In-Reply-To: <20200714205942.26248f1c@canb.auug.org.au> (Stephen Rothwell's
        message of "Tue, 14 Jul 2020 20:59:42 +1000")
Message-ID: <87mu429ecu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> In commit
>
>   ad96bc27032c ("brcmfmac: initialize the requested dwell time")
>
> Fixes tag
>
>   Fixes: 4905432b28b7 ("brcmfmac: Fix P2P Group Formation failure via Go-neg method")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
>
> Maybe you meant
>
> Fixes: 9c29da3f4e7e ("brcmfmac: Fix P2P Group Formation failure via Go-neg method")

Heh, I noticed this and I even fixed it but maybe forgot to save my edit
or something. I'll need to be more careful next time.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
