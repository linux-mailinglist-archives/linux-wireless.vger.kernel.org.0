Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1616B8CFE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 10:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437564AbfITIfy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 04:35:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59122 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437539AbfITIfy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 04:35:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 46CBD61418; Fri, 20 Sep 2019 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568968553;
        bh=RCIs686ZCd5SY5O9P5Obm5ejnNuCSq2iYbDI5mpFAro=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LVjTzk8FwvUoGLFtMzI0JMpNAFd/L+kmHdfE+KkWMkgagNT+hEtGYlPkgmVRlg5Yv
         hldBwI+P2nJ1wfeOT9nLgbHuPr6xtclsgqv0RtaRhgDazSmKOcUwJyjLc+4ei/0obY
         StVPJ/lrI8Ml6PxU0TKq2uh9k30Zh7to/RnRD8rw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A270960452;
        Fri, 20 Sep 2019 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568968552;
        bh=RCIs686ZCd5SY5O9P5Obm5ejnNuCSq2iYbDI5mpFAro=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=E+VhMKLoStQuTMcONfLx6bKI8BrZvmArCkiTFhg9zqR4+LLKZUwugKQ4Psct5xqke
         gpCtjM1l7jzT0xmpHSbF2p0rIYUB7IEn/akEdSY/TeBXnZ9lZs7GaFlcACAASu9+3R
         q99p5HW0OIouMVuuEyzNIF4EpQ0g0RzNKA07st68=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A270960452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 05/15] rtw88: pci: release tx skbs DMAed when stop
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
        <1568617425-28062-6-git-send-email-yhchuang@realtek.com>
        <CA+ASDXOMao9uucGxa6C0Q99pFvAtKTptreeshbfKqiELDKUH0Q@mail.gmail.com>
        <F7CD281DE3E379468C6D07993EA72F84D18DC62E@RTITMBSVM04.realtek.com.tw>
        <CA+ASDXP_7FVEaQrE1V=rX0Vieu8GGWj+it7p4F_8XeRNniEWkw@mail.gmail.com>
        <87tv97ctsp.fsf@codeaurora.org>
        <F7CD281DE3E379468C6D07993EA72F84D18DFE56@RTITMBSVM04.realtek.com.tw>
Date:   Fri, 20 Sep 2019 11:35:48 +0300
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D18DFE56@RTITMBSVM04.realtek.com.tw>
        (Tony Chuang's message of "Fri, 20 Sep 2019 08:29:15 +0000")
Message-ID: <87lfujcql7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> > I wonder if, given the problems I've seen (the driver can become
>> > totally ineroperable), this patch and the previous patch (its only
>> > real dependency) should be fast-tracked to the current release.
>> 
>> I agree, this sounds like a serious problem. So I'm planning to queue
>> patches 4 and 5 to v5.4, if it's ok for Tony.
>
> It's OK for me, didn't realize that this is a serious problem, so I missed it.
> Also if possible you should queue patch 2, that reordering will cause
> two H2C skbs not be released because HCI hasn't started, everytime
> enter/leave IDLE state (rtw_power_[on|off]).
>
> Should I resend and add a v5.4 prefix or something?

No need to resend, I'll try to apply patches 2, 4 and 5 as is and will
let you know if there are any problems.

-- 
Kalle Valo
