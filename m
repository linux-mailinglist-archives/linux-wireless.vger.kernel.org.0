Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A387B38931A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355022AbhESP6X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 11:58:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24230 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355020AbhESP6W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 11:58:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621439823; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Q96jpCTD8/QMSDNZK3F6bpyaFamomufPiUhLFO7Q7o8=;
 b=MeEv4Ug9NH8rI0h17d2ocdzwxHrlMgp2nrBedQS8TFyWL7b9DFzJ+z+NCzDbSLvkWra7MUvO
 9Gdal4q0FaLfrdDrYhQzkfE6XQx2vloK5UddLX4jTXDM5NHDPxj3X7yrRS982UvCUvJWzxzT
 IMc623+0NxbrnuciXC21pfG5kJU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60a5354eb15734c8f9717081 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 May 2021 15:57:02
 GMT
Sender: jjohnson=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B78CEC43144; Wed, 19 May 2021 15:57:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jjohnson)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD529C4338A;
        Wed, 19 May 2021 15:57:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 19 May 2021 08:57:00 -0700
From:   Jeff Johnson <jjohnson@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Chao Yu <chao@kernel.org>,
        Leon Romanovsky <leon@kernel.org>, b43-dev@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jjohnson=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v2] b43: don't save dentries for debugfs
In-Reply-To: <YKUyAoBq/cepglmk@kroah.com>
References: <20210518163304.3702015-1-gregkh@linuxfoundation.org>
 <891f28e4c1f3c24ed1b257de83cbb3a0@codeaurora.org>
 <f539277054c06e1719832b9e99cbf7f1@codeaurora.org>
 <YKScfFKhxtVqfRkt@kroah.com>
 <2eb3af43025436c0832c8f61fbf519ad@codeaurora.org>
 <YKUyAoBq/cepglmk@kroah.com>
Message-ID: <48aea7ae33faaafab388e24c3b8eb199@codeaurora.org>
X-Sender: jjohnson@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-05-19 08:42, Greg Kroah-Hartman wrote:
> On Wed, May 19, 2021 at 08:04:59AM -0700, Jeff Johnson wrote:
>> On 2021-05-18 22:05, Greg Kroah-Hartman wrote:
>> > On Tue, May 18, 2021 at 03:00:44PM -0700, Jeff Johnson wrote:
>> > > On 2021-05-18 12:29, Jeff Johnson wrote:
>> > > Would still like guidance on if there is a recommended way to get a
>> > > dentry not associated with debugfs.
>> >
>> > What do you exactly mean by "not associated with debugfs"?
>> >
>> > And why are you passing a debugfs dentry to relay_open()?  That feels
>> > really wrong and fragile.
>> 
>> I don't know the history but the relay documentation tells us:
>> "If you want a directory structure to contain your relay files,
>> you should create it using the host filesystem’s directory
>> creation function, e.g. debugfs_create_dir()..."
>> 
>> So my guess is that the original implementation followed that
>> advice.  I see 5 clients of this functionality, and all 5 pass a
>> dentry returned from debugfs_create_dir():
>> 
>> drivers/gpu/drm/i915/gt/uc/intel_guc_log.c, line 384
>> drivers/net/wireless/ath/ath10k/spectral.c, line 534
>> drivers/net/wireless/ath/ath11k/spectral.c, line 902
>> drivers/net/wireless/ath/ath9k/common-spectral.c, line 1077
>> kernel/trace/blktrace.c, line 549
> 
> Ah, that's just the "parent" dentry for the relayfs file.  That's fine,
> not a big deal, debugfs will always provide a way for you to get that 
> if
> needed.

Unless debugfs is disabled, like on Android, which is the real problem 
I'm
trying to solve.

Jeff
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
