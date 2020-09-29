Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88AD27BE3B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 09:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgI2Hku (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 03:40:50 -0400
Received: from z5.mailgun.us ([104.130.96.5]:15470 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI2Hkt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 03:40:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601365249; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=xnb87Cfve1xF0bCoXPYTCokfdr8oqsQE0Dv24ZOgSVo=; b=Y7JieTaVpFpgvAwn2NL8uLPDJGzG22xqe+bxpeTfU79/dIY43wFGung5KU6FqiwuNU1cxiNp
 2d/EkXo2StXzwmPUyAz6hNwvOa1qv5GmQLpd4JJVNH9pf4t/VsPdGq+8BN+cUpwt8pGtuIpu
 j8pROzY/x2fLb5dWfZoxRoIXWOU=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f72e4ff0f8c6dd7d2825739 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 07:40:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6ED86C433CB; Tue, 29 Sep 2020 07:40:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCB7AC433CA;
        Tue, 29 Sep 2020 07:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCB7AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap power save
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
        <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
Date:   Tue, 29 Sep 2020 10:40:42 +0300
In-Reply-To: <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
        (Johannes Berg's message of "Mon, 28 Sep 2020 13:24:22 +0200")
Message-ID: <871rilf2th.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2020-08-24 at 13:56 +0530, Venkateswara Naralasetty wrote:
>> AP power save feature is to save power in AP mode, where AP goes
>> to power save mode when no stations associate to it and comes out
>> of power save when any station associate to AP.
>
> Why do you think this requires a vendor command? I mean, that seems like
> fairly reasonable - even by default - behaviour?

I have not studied the details, but doesn't AP power save break normal
functionality? For example, I would guess probe requests from clients
would be lost. So there's a major drawback when enabling this, right?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
