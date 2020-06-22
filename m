Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC12038E2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgFVOOy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:14:54 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:29015 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728947AbgFVOOy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:14:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592835294; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=F9ZYPJqnwR7qLas1OFPPs1HFrhNZLi85hn9x30GxDr4=; b=K82BwQHqazhFd4jxgH8u/vHjgMoEl2EXvEsEw9vDEmiPE6lzBOCx+S8yNKZvFaeCCOjgXr6S
 xYj+bxZq/nRFvlaJrjPe4xGEeuj3gOIq3BBt0sA3hgfrZld4JbIKiJGNCTUCJ5llZl4XOd2c
 qrO3BzNdLNwfLDDvcyKVzb5fOjU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5ef0bcd4117610c7ff28d251 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 14:14:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42D91C433CB; Mon, 22 Jun 2020 14:14:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F49FC433C6;
        Mon, 22 Jun 2020 14:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F49FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] wlcore: Use spin_trylock in wlcore_irq_locked() for running the queue
References: <20200617212505.62519-1-tony@atomide.com>
        <20200617212505.62519-2-tony@atomide.com>
Date:   Mon, 22 Jun 2020 17:14:40 +0300
In-Reply-To: <20200617212505.62519-2-tony@atomide.com> (Tony Lindgren's
        message of "Wed, 17 Jun 2020 14:25:02 -0700")
Message-ID: <875zbjgpbj.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> We need the spinlock to check if we need to run the queue. Let's use
> spin_trylock instead and always run the queue unless we know there's
> nothing to do.

Why? What's the problem you are solving here?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
