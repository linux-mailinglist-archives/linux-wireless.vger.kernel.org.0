Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A66B46CA10
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 02:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbhLHBiL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 20:38:11 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:37525 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239621AbhLHBiK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 20:38:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638927279; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=E1xMeWN7axQWVodiwYidbZo5oGTp0MZISH2KuPx2d3Y=;
 b=psUYFNZ4Z1Dgq9anbmDJStGJ8oUqmidRlcXbact96x2vQTeafgn4kXwNNDHr6UW/z8AlF7iu
 6+XwgkpbIFTRfBHKNfG5W+gawYkhgAoig88Gy6Pu2EeEVsfehuCIJGbYcLDrA04U1HX1PMk4
 XDG+hUUKZ7sXtLwKwRy1jXbHez8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 61b00baee7d68470af682eee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 08 Dec 2021 01:34:38
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 028A5C4361A; Wed,  8 Dec 2021 01:34:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31C55C4360D;
        Wed,  8 Dec 2021 01:34:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Dec 2021 09:34:37 +0800
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/3] ath11k: Move pdev debugfs creation ahead
In-Reply-To: <87pmq8joi1.fsf@codeaurora.org>
References: <20210913180902.193874-1-jouni@codeaurora.org>
 <20210913180902.193874-3-jouni@codeaurora.org>
 <87pmq8joi1.fsf@codeaurora.org>
Message-ID: <ea9d43d501eac8b9f7268899992e9d41@codeaurora.org>
X-Sender: bqiang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-12-08 01:47, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Baochen Qiang <bqiang@codeaurora.org>
>> 
>> The sram dump debugfs interface has to be put under pdev directory
>> located under /sys/kernel/debug/ath11k/<pdev name>. Currently pdev 
>> directory
>> is created after firmware is ready, this is too late for sram dump.
>> Suppose that if errors happen and ath11k fails to reach firmware
>> ready, we have no way to dump sram content to debug cause the
>> interface has not been created yet. So move it ahead.
> 
> I'm not sure about this. What will happen with other debugfs files now
> that they are created before the firmware is ready, doesn't that create
> race conditions?
> 
> Also we need to do some refactoring in debugfs, for example see Anil's
> patch:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/1614160542-27882-1-git-send-email-akolli@codeaurora.org/
> 
> So I recommend dropping patch 2 for now and get the basic sram dump
> functionality ready first. After that we can discuss how to handle
> firmware crashes during driver initialisation, maybe coredump would be 
> a
> better approach?

Sure, Kalle, let's get basic functionality ready first.
