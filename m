Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2002038E4
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgFVOQV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:16:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51205 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbgFVOQU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:16:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592835380; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=f6kTGE+qZlvFQEy4s+N9cwPFbTCG0vmbcHOxUcyLzHE=; b=BE27j+Al90GOwMC06LRzAz81d2l9qJAi7lBlF26NnFjx/eyvhgBo1QnA+V54hvQkrX5rv6WR
 +lYa1Y+zyTmOU1ysd475GcqV1C5O8QuL5yAAT3bqnsaFkrbIuw5F5JH45rzJlm1V87odoy2z
 AL4gmkr8PBVd/0URywr7XoqRJj0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ef0bd2a567385e8e70b36bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 14:16:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F2E91C433CA; Mon, 22 Jun 2020 14:16:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34852C433C6;
        Mon, 22 Jun 2020 14:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34852C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/4] wlcore: Use spin_trylock in wlcore_irq() to see if we need to queue tx
References: <20200617212505.62519-1-tony@atomide.com>
        <20200617212505.62519-3-tony@atomide.com>
Date:   Mon, 22 Jun 2020 17:16:05 +0300
In-Reply-To: <20200617212505.62519-3-tony@atomide.com> (Tony Lindgren's
        message of "Wed, 17 Jun 2020 14:25:03 -0700")
Message-ID: <871rm7gp96.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> We need the spinlock to check if we need to queue tx in wlcore_irq().
> Let's use spin_trylock instead and always queue tx unless we know there's
> nothing to do.
>
> Let's also update the comment a bit while at it.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Same question as in patch 1, the background for this is not clear.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
