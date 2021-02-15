Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589C131B4E7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Feb 2021 06:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhBOFBD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Feb 2021 00:01:03 -0500
Received: from z11.mailgun.us ([104.130.96.11]:11327 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhBOFBC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Feb 2021 00:01:02 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2021 00:01:02 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613365241; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PfLH0BqKbqTK0XYx91M8hkmyFuSrAqrtwXzVLkcSfuk=; b=S8fK1tUdE2acycjvuQBOseyltDPtmZCwYUwnbLupNLKx8hdrIL4+DK/hY59V57eR1UenHkNq
 WuiaJw81cQMOG1r2VC/UAhbcytCQmudv0hYyILNR4V0uzCnXXasqFOYBqCsNRNzDxjLZ2AkG
 XhsXB3gCvMB3tpl3S0YWU/qyNBQ=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6029fe8634db06ef790e65c5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Feb 2021 04:54:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBC5CC43461; Mon, 15 Feb 2021 04:54:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B3EDC433C6;
        Mon, 15 Feb 2021 04:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B3EDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, hurricos@gmail.com
Subject: Re: [PATCH] ath9k: fix transmitting to stations in dynamic SMPS mode
References: <20210214184911.96702-1-nbd@nbd.name>
Date:   Mon, 15 Feb 2021 06:54:25 +0200
In-Reply-To: <20210214184911.96702-1-nbd@nbd.name> (Felix Fietkau's message of
        "Sun, 14 Feb 2021 19:49:11 +0100")
Message-ID: <8735xyrkvy.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> When transmitting to a receiver in dynamic SMPS mode, all transmissions that
> use multiple spatial streams need to be sent using CTS-to-self or RTS/CTS to
> give the receiver's extra chains some time to wake up.
> This fixes the tx rate getting stuck at <= MCS7 for some clients, especially
> Intel ones, which make aggressive use of SMPS.
>
> Cc: stable@vger.kernel.org
> Reported-by: Martin Kennedy <hurricos@gmail.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

No Fixes tag so I assume this is not a regression?

Should this go to v5.12 or -next? I guess that depends how much testing
this patch has got.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
