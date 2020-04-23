Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8A1B54DD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 08:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgDWGru (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 02:47:50 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:20111 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbgDWGrt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 02:47:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587624468; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=MGY8tVKGYBPo4BZRSoIKx6EgQCSwniFFw9vc2fEBYf0=; b=b6ye+mSpE85yxhX+oK8wi+m4v0MZnBg1944vtl5klZ6eh2YmNAexOoetvgB3fXd0tAFM1avC
 V4WiL1+eRXWBnvUQFdimV0PLuYIHxNzfiAdVpoqKiW4shKeawgUCFMGo8McLZwdAXqmYL3yt
 lRsSX9wspxx073oQl1qC6UkhrFU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea13a01.7f791a299030-smtp-out-n01;
 Thu, 23 Apr 2020 06:47:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13479C4478C; Thu, 23 Apr 2020 06:47:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 841B2C433CB;
        Thu, 23 Apr 2020 06:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 841B2C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     yhchuang@realtek.com, Dejin Zheng <zhengdejin5@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] iopoll: Introduce read_poll_timeout_atomic macro
References: <20200423063811.2636-1-kai.heng.feng@canonical.com>
Date:   Thu, 23 Apr 2020 09:47:23 +0300
In-Reply-To: <20200423063811.2636-1-kai.heng.feng@canonical.com> (Kai-Heng
        Feng's message of "Thu, 23 Apr 2020 14:38:09 +0800")
Message-ID: <87lfmmn1fo.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kai-Heng Feng <kai.heng.feng@canonical.com> writes:

> Like read_poll_timeout, an atomic variant for multiple parameter read
> function can be useful.
>
> Will be used by a later patch.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  include/linux/iopoll.h | 62 +++++++++++++++++++++++++++++-------------
>  1 file changed, 43 insertions(+), 19 deletions(-)

I don't know who maintains iopoll.h, at least MAINTAINERS file doesn't
have an entry, so not sure how to handle this patch.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
