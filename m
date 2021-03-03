Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8D32C142
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245654AbhCCVRp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:17:45 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:53267 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1838739AbhCCTBq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 14:01:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614798092; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=XCaJkg/07Qju0xDLW2/0tiQPWCjxTw8nP7t7Cm/n/9g=; b=XaFAIdiA+het27O1HROZIzIMI4JigyuIX5m17XpKg4NwEALTAmiDau+M9s+MSDub9JTRIFV1
 FMBo42dWRHyQfI/f2gNAHaaP2jymkxR4Kdj8hEqpgoXnvBsZ1feRMAFbvvC3gj7+4ei0UnVg
 FH/L3YiwECQGOesE/Yj9Z3sVi58=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 603fdcdff7ec0ea57cb09445 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 19:00:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4706AC43464; Wed,  3 Mar 2021 19:00:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6515FC433ED;
        Wed,  3 Mar 2021 19:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6515FC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     Srinivasan Raju <srini.raju@purelifi.com>,
        Linux Firmware <linux-firmware@kernel.org>,
        mostafa.afgani@purelifi.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] [v6] linux-firmware: New firmware files for pureLiFi USB devices
References: <20210226132057.120007-1-srini.raju@purelifi.com>
        <CA+5PVA7okASXRaiA8LoNp1gVHAd7iDPvzXsr1x2rBkh=4-VZXA@mail.gmail.com>
Date:   Wed, 03 Mar 2021 21:00:42 +0200
In-Reply-To: <CA+5PVA7okASXRaiA8LoNp1gVHAd7iDPvzXsr1x2rBkh=4-VZXA@mail.gmail.com>
        (Josh Boyer's message of "Wed, 3 Mar 2021 13:50:34 -0500")
Message-ID: <87ft1c6p0l.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Srinivasan, please cc linux-wireless on wireless firmware submissions)

Josh Boyer <jwboyer@kernel.org> writes:

> Is the driver reviewed and merged now?  If so, Kallle (or whomever)
> can you provide a Reviewed-by?

It's not merged yet, but we are getting closer.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
