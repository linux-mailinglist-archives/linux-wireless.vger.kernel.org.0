Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85956312D44
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 10:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhBHJ2u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 04:28:50 -0500
Received: from so15.mailgun.net ([198.61.254.15]:41160 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231475AbhBHJ0d (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 04:26:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612776370; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6UbTT/qpbzVpb6MGWF8ttHM+x5AnYelfiEB+nEai8GM=; b=uTaHyX0TiPo+IJeE96meTddJ/EAMwGxeSI8+W3ozIOEl9KPAwjB214XT0KWEKkwbV+RfUSQq
 9cxdGab168Ui26/7ihGOQPQbguyqBiU6g9gjTRc2OVGNRg67vj0YedmAkxMCWMqva76jPFeX
 0LgijKCsVpqyF7QTJ7ZDAxK4mHo=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6021038cf112b7872cf93f27 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 09:25:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6CF7EC433C6; Mon,  8 Feb 2021 09:25:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2426CC433ED;
        Mon,  8 Feb 2021 09:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2426CC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH for v5.11] iwlwifi: add new cards for So and Qu family
References: <iwlwifi.20210206130110.6f0c1849f7dc.I647b4d22f9468c2f34b777a4bfa445912c6f04f0@changeid>
        <20210208083006.4C609C43461@smtp.codeaurora.org>
        <c29802a2acda44fa6368e6703f7dc0c13178ae24.camel@coelho.fi>
Date:   Mon, 08 Feb 2021 11:25:28 +0200
In-Reply-To: <c29802a2acda44fa6368e6703f7dc0c13178ae24.camel@coelho.fi> (Luca
        Coelho's message of "Mon, 08 Feb 2021 10:40:30 +0200")
Message-ID: <87eehq6hdj.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Mon, 2021-02-08 at 08:30 +0000, Kalle Valo wrote:
>> Luca Coelho <luca@coelho.fi> wrote:
>> 
>> > From: Ihab Zhaika <ihab.zhaika@intel.com>
>> > 
>> > add few PCI ID'S for So with Hr and Qu with Hr in AX family.
>> > 
>> > Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
>> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> 
>> Why the urgency? Linus most likely releases v5.11 next Sunday so I would rather
>> apply this to -next. You could push it to v5.11 via the stable tree.
>
> The urgency was that there are some OEMs with these devices and they
> wanted the patch in v5.11 asap.  But I can certainly push back and we
> can send this via -next.  I only promised to *try* to get it in v5.11.
> ;)

If all goes well the merge window will start on Sunday and -next patches
should be in Linus' tree by end of next week. So I would imagine the
patch would be in the first stable release.

> I'll add a Cc: stable and apply to iwlwifi-next.

Thanks! BTW, could you also take this patch to your tree:

https://patchwork.kernel.org/project/linux-wireless/patch/20210112132449.22243-3-tiwai@suse.de/

Less conflicts that way. I assigned it to you on patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
