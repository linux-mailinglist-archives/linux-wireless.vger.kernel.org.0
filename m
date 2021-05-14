Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A0A38039C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 May 2021 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhENGXi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 May 2021 02:23:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:21272 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232301AbhENGXh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 May 2021 02:23:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620973346; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=D3qOaq3w+lp/P83ZscLwR5pSp+K26+/ZdEw8eZKcRek=; b=e/o/Zfsds+PTcI+2EbiBpyupnOSp5JsZpFb/OutbL9fVeLYjuFTCGsbGzHbrtqG2m0VS6UI7
 k1MrBlDmgyPeRV61Td0uN2kEaANhpw+TOx/um3y7UBMMMfeqMeduB/qsK5zRlgVpecrh8GkI
 5ssHXeQEcKRhae30EEg/gURLm5E=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 609e1721e0211609c46f1b59 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 May 2021 06:22:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A4A9C43460; Fri, 14 May 2021 06:22:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E93FC4338A;
        Fri, 14 May 2021 06:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E93FC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Pkshih <pkshih@realtek.com>,
        "linux-firmware\@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Request to update 8852a firmware of rtw89 to v0.13.8.0
References: <57e9f582340545c79a9ab3433e2a4a7d@realtek.com>
        <87cztx87tr.fsf@tynnyri.adurom.net>
        <CA+ASDXM9YmhMWmttkrCxB0_tf6Kf6Sz=7Yc26CmjZmMUxyxAfw@mail.gmail.com>
        <87tun7i2rn.fsf@codeaurora.org>
        <876c29841fcf4d21ab2440cbb5879de2@realtek.com>
        <CA+ASDXMN__j0x5hN5t98C4k+upOcs+T1=MrivCbxRYa_-ENt_A@mail.gmail.com>
Date:   Fri, 14 May 2021 09:22:21 +0300
In-Reply-To: <CA+ASDXMN__j0x5hN5t98C4k+upOcs+T1=MrivCbxRYa_-ENt_A@mail.gmail.com>
        (Brian Norris's message of "Thu, 13 May 2021 14:08:53 -0700")
Message-ID: <87pmxtj0ma.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Thu, May 13, 2021 at 2:38 AM Pkshih <pkshih@realtek.com> wrote:
>> > -----Original Message-----
>> > From: kvalo=codeaurora.org@mg.codeaurora.org
>> > [mailto:kvalo=codeaurora.org@mg.codeaurora.org] On
>> > Behalf Of Kalle Valo
>
>> > It can create confusion to the users if during review we make changes
>> > how firmware files are handled. Some drivers have windows style .ini
>> > files which are not ok in an upstream driver, there could be changes in
>> > the file format etc.
>
> Sure, good point. I figured if there's no driver merged anywhere
> upstream, people (e.g., me) are taking their own life in their hands
> trying to utilize arbitrary versions from the mailing list. But I
> could see why you still don't want the potential mismatch.
>
>> > But I have no strong opinion here, my main motivation is just to try to
>> > keep things simple for maintaining the "interface" between
>> > linux-firmware and kernel wireless drivers. My preference is that the
>> > firmware files are ready for submission when a new driver is submitted
>> > for review, but the firmware files are submitted only after the driver
>> > is accepted.
>
> Ack, that's definitely important to me. The first versions had no
> publicly posted firmware, and at least one person (not me at the time)
> asked for it. My extension of that is that I don't want to
> _discourage_ vendors posting their firmware to public repos :)

Yeah, I don't want to discourage posting either. It's just that we don't
want to do it too early nor too late, which doesn't make it easy for
submitters :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
