Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701DC1B5ED1
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgDWPNe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 11:13:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:43192 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729006AbgDWPNd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 11:13:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587654812; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=wBji2J4U6xhObVyl1ejnOu3TX6KZ93BKfkZnOfUByWo=; b=bnOOkAnQfGrUwobwxvnp+w1pL+Ycr7qOR/8V3fL2sza/1I0D4Ap2TnqJ/+bhgZZ9tdY4cHdb
 V6VSmhwmnqgIUTAUvCzzcFmugfQ6l3LeN/enyZmn899NOU502kqbLqEcAxuneqAy0a73Ap0q
 Yk19ImSy0mJqni9KYvoYELGHl2k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea1b09c.7f8827fb5500-smtp-out-n03;
 Thu, 23 Apr 2020 15:13:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AE227C44788; Thu, 23 Apr 2020 15:13:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC9DFC433BA;
        Thu, 23 Apr 2020 15:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC9DFC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, yhchuang@realtek.com,
        Dejin Zheng <zhengdejin5@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] iopoll: Introduce read_poll_timeout_atomic macro
References: <20200423063811.2636-1-kai.heng.feng@canonical.com>
        <87lfmmn1fo.fsf@kamboji.qca.qualcomm.com>
        <20200423102347.GC4808@sirena.org.uk>
        <87eeseigs9.fsf@kamboji.qca.qualcomm.com>
        <20200423144736.GN4808@sirena.org.uk>
Date:   Thu, 23 Apr 2020 18:13:24 +0300
In-Reply-To: <20200423144736.GN4808@sirena.org.uk> (Mark Brown's message of
        "Thu, 23 Apr 2020 15:47:36 +0100")
Message-ID: <875zdqi6az.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Thu, Apr 23, 2020 at 02:27:02PM +0300, Kalle Valo wrote:
>
>> Oh, ok. As patch 2 goes to my wireless-drivers-next tree would it be ok
>> for everyone if I take this patch as well?
>
> I'd give it a bit longer than usual for people to review but yeah, if
> nobody complains it's probably reasonable.

Yeah, I'll wait for comments. Thanks!

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
