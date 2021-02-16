Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE631CE54
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Feb 2021 17:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhBPQpf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Feb 2021 11:45:35 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:19773 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhBPQpe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Feb 2021 11:45:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613493915; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=dnkRE6+ay0NaWW4qr0xA/J6CMSk1MTmUzYcYeEc+h1c=; b=lUSgNv5Kd2nBvpbHHVQKJ8NnVEr0/c2q6HQpwIw/6LlzUqx7obhd406FfSF57uc9lAg8fS+s
 0HM6T7eKRqvn5Jhpd2xmk/b6TdHidLh8/Gbyu8ovkS3+V9E3CtpG8moIc9Y6fVwMuqCPuY7Z
 HzV7RG87ga7c3O+At0PnJT3jVkE=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 602bf6958848eb952abac77c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Feb 2021 16:45:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91B3BC43463; Tue, 16 Feb 2021 16:45:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF465C433CA;
        Tue, 16 Feb 2021 16:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF465C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 06/11] ath11k: add static window support for register access
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
        <1612946530-28504-7-git-send-email-akolli@codeaurora.org>
Date:   Tue, 16 Feb 2021 18:45:05 +0200
In-Reply-To: <1612946530-28504-7-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Wed, 10 Feb 2021 14:12:05 +0530")
Message-ID: <87czx0q7vy.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> From: Karthikeyan Periyasamy <periyasa@codeaurora.org>
>
> Three window slots can be configure. First window slot
> dedicate for dynamic selection and remaining two slots
> dedicate for static selection. To optimise the window
> selection, frequent registers (UMAC, CE) are configure
> in static window slot. so that we minimise the window
> selection. Other registers are configure in dynamic window
> slot. Get the window start address from the respective
> offset and access the read/write register.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Patches 6-10 are missing Anil's s-o-b. Anil, can I add them? If you
agree, please reply to this mail and include your s-o-b in the reply.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
