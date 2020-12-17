Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7962DD67F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 18:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgLQRo7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 12:44:59 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:42325 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgLQRo7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 12:44:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608227078; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Upis/CDwn5H5i1DOIZd3RmzFhQICp512RPnRXos8eCE=; b=tbYSngOWZ7xxqOVLYBrhOblzY/JhvZxRik8+KKxWKh3fzng4YX9KgxE5NDYNOzj5poA2/6rr
 RsxrQeTrOKNuO2p7qW+u+5mAe6gVApBpOqTY1Y/xEvA7mevioA79/r636EK7Upx9xjEjp+Cj
 JUXIr8B9YVuxrHGN5eT/36l9Pno=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fdb98e77549779c5b900ea1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 17:44:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4AA7DC43461; Thu, 17 Dec 2020 17:44:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A261FC433C6;
        Thu, 17 Dec 2020 17:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A261FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] mt76: mt76s: fix NULL pointer dereference in mt76s_process_tx_queue
References: <b49c1b4edacd87b2241a9fd0431dd4864c8963f6.1607418933.git.lorenzo@kernel.org>
        <20201217163616.546AFC433CA@smtp.codeaurora.org>
        <20201217171105.GC16606@lore-desk>
        <58f03209-de19-0f35-fed3-d20366f933d2@nbd.name>
Date:   Thu, 17 Dec 2020 19:44:01 +0200
In-Reply-To: <58f03209-de19-0f35-fed3-d20366f933d2@nbd.name> (Felix Fietkau's
        message of "Thu, 17 Dec 2020 18:20:33 +0100")
Message-ID: <87r1nos4ym.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-12-17 18:11, Lorenzo Bianconi wrote:
>>> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>>> 
>>> > Fix a possible NULL pointer dereference in mt76s_process_tx_queue that
>>> > can occur if status thread runs before allocating tx queues
>>> > 
>>> > Fixes: 6a618acb7e62 ("mt76: sdio: convert {status/net}_work to mt76_worker")
>>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> 
>>> Failed to apply to wireless-drivers:
>> 
>> Hi Kalle,
>> 
>> sorry for the noise. I guess to apply this patch we need to apply even the
>> following series:
>> https://patchwork.kernel.org/project/linux-wireless/cover/cover.1607164041.git.lorenzo@kernel.org/
>> 
>> @Felix: do you think it is ok to apply "remove wake queue tx logic for
>> usb/sdio" series to wireless-drivers?
>
> Yes, that makes sense.

Ok, I assigned the series to me and changed this back to New state.

The commit logs in series don't really answer to "why?", though.
Lorenzo, can you reply to those patches and give more info how they
help? Or are they just cleanup?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
