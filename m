Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64981563C3
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2020 11:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgBHKJl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Feb 2020 05:09:41 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:17001 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbgBHKJl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Feb 2020 05:09:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581156580; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=FmWIhXK/i5oWUfibiT3287XAujUPHjyKqNabDiY1e98=; b=qX/o6OIQl/f9+oIgvn108CninpxkID7xFoxk8QDlUkI+O3/bXShQ9aHDPVA3S0teYgsvqNoA
 WhXz6M2170NCydJI5t1+bqZoN7lCvaoQjoROltLTPLztJr7i8Ckw1bcoWiKVE67BNFZFTdpJ
 5ylPXxF0OaUSsLZxrAISE0EBr+E=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3e88dc.7f390ce2d848-smtp-out-n01;
 Sat, 08 Feb 2020 10:09:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C61CC4479F; Sat,  8 Feb 2020 10:09:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3A7AC43383;
        Sat,  8 Feb 2020 10:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3A7AC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Justin Capella <justincapella@gmail.com>,
        Chris Chiu <chiu@endlessm.com>,
        Tony Chuang <yhchuang@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtw88: disable TX-AMSDU on 2.4G band
References: <20200204120614.28861-1-yhchuang@realtek.com>
        <CAB4CAwdFez_WbRQb2jZQtqspSkO5ujL31ZLt4XshNcWiSqHByA@mail.gmail.com>
        <CAMrEMU_KJbwAK-onH0sRUgUPxDuZtD5bPJN6XmF=a9NqpfeJ+g@mail.gmail.com>
        <CA+ASDXPHWNN+TvrJFi_6w+ep_TBtLJ0refKenNb0tc8Vs+YjgQ@mail.gmail.com>
        <CAMrEMU93LScySw4mpidAC5pVHV_NOShP1_GMMsvsAk1QBhdJjQ@mail.gmail.com>
        <CA+ASDXPHXFquF2iXvdxZXhkkLPndkACgenLJwMR_9ON7zZZM3w@mail.gmail.com>
Date:   Sat, 08 Feb 2020 12:09:27 +0200
In-Reply-To: <CA+ASDXPHXFquF2iXvdxZXhkkLPndkACgenLJwMR_9ON7zZZM3w@mail.gmail.com>
        (Brian Norris's message of "Fri, 7 Feb 2020 12:53:26 -0800")
Message-ID: <87wo8xxueg.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Fri, Feb 7, 2020 at 12:48 PM Justin Capella <justincapella@gmail.com> wrote:
>> I understand, I'm suggesting disable by default but option to re-enable
>
> Ah, OK. Seems reasonable, I suppose, although I don't recall Kalle
> having a particularly-high opinion of module parameters for tweaking
> core 802.11 protocol behaviors.

Yeah, exactly. And the number of module parameters a driver has should
be minimised. I know out-of-tree vendor drivers have ini files with 100
different knobs, but I don't think module parameters should be
equivalent to ini files.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
