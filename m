Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A9A175BFC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 14:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgCBNoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 08:44:03 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:53925 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727823AbgCBNoD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 08:44:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583156643; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=WIPZV1UdAT8/hQ6NbzTfQFjsG0+yXK1MYUu9G7zxgzQ=; b=rkivxfYHndB7av3a1QQLyUD+SXbIfLz5vA30aTV/WPD+tUQ/XCh5iNleA/UGZLffokDfi2Kz
 UQ45WFMij5S5BND7BQgD1blry3lb7VXbjJFYUvuTleBuR7gQsqdu/8eTu1U7uEvvtPFYrV6F
 cU5N3U69n7/9XZRcLSKd/GzOof0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5d0d91.7f6364d26768-smtp-out-n03;
 Mon, 02 Mar 2020 13:43:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8FDBC4479C; Mon,  2 Mar 2020 13:43:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B096FC43383;
        Mon,  2 Mar 2020 13:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B096FC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Justin Capella <justincapella@gmail.com>,
        Chris Chiu <chiu@endlessm.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtw88: disable TX-AMSDU on 2.4G band
References: <20200204120614.28861-1-yhchuang@realtek.com>
        <CAB4CAwdFez_WbRQb2jZQtqspSkO5ujL31ZLt4XshNcWiSqHByA@mail.gmail.com>
        <CAMrEMU_KJbwAK-onH0sRUgUPxDuZtD5bPJN6XmF=a9NqpfeJ+g@mail.gmail.com>
        <CA+ASDXPHWNN+TvrJFi_6w+ep_TBtLJ0refKenNb0tc8Vs+YjgQ@mail.gmail.com>
        <CAMrEMU93LScySw4mpidAC5pVHV_NOShP1_GMMsvsAk1QBhdJjQ@mail.gmail.com>
        <CA+ASDXPHXFquF2iXvdxZXhkkLPndkACgenLJwMR_9ON7zZZM3w@mail.gmail.com>
        <87wo8xxueg.fsf@kamboji.qca.qualcomm.com>
        <CAMrEMU-nM1O_iJPVgGg2pL6JYWMdRKdPGe5N2rkfOihdmTeMaw@mail.gmail.com>
        <2c91e4e7b36d42a8abad6ae356c2869c@realtek.com>
        <CA+ASDXMjx8oQzK61rNHwpkKykgS2v_o+HTUyXujY9VXYNiNfxQ@mail.gmail.com>
Date:   Mon, 02 Mar 2020 15:43:40 +0200
In-Reply-To: <CA+ASDXMjx8oQzK61rNHwpkKykgS2v_o+HTUyXujY9VXYNiNfxQ@mail.gmail.com>
        (Brian Norris's message of "Thu, 20 Feb 2020 11:04:31 -0800")
Message-ID: <87d09u7tyr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Tue, Feb 11, 2020 at 6:56 PM Tony Chuang <yhchuang@realtek.com> wrote:
>> Module parameters are really good for me, too. But we've had discussion
>> before with Kalle and Brian, they both were trying hard to avoid module
>> parameters.
>
> My personal preference is to avoid module parameters when you can fix
> the defaults, and that module parameters should never be a workaround
> for fixing the default behavior.
>
> I don't think my above preference precludes module parameters: they
> can be useful as "extra debug knobs."
>
> But Kalle had a little more nuanced opinion here -- he didn't even
> want "debug knobs" for core 802.11 functionality, because (I may be
> paraphrasing) one person's "debug knob" easily becomes the next
> person's "required knob." Additionally, a mess of disorganized knobs
> can make maintenance difficult -- one can't really expect the average
> distribution to make a good selection on 100 different parameters; and
> for those that do tweak the parameters, it now creates a combinatoric
> mess to debug and triage user reports of "it's broken". I can respect
> all of those reasons too.

Exactly my thinking as well, thanks Brian for writing these out. We
should add this description "why module parameters are bad" to the wiki
to make it more visible :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
