Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED17469B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 07:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbfGYFzK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jul 2019 01:55:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfGYFzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jul 2019 01:55:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 12971601C3; Thu, 25 Jul 2019 05:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564034109;
        bh=dcWibguJX8D7tDXGfD1l0OlXEYMWmZ8Gxr3nT63OX1c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Jj8qzfKOs6M403BjwsVtczNEV4YcAvoED6hOiamQpQnsp4dLsRuU/ueDFWb71O+ss
         XO08OOTyUAVuynvSgNFE2c4bx35iFpHRH1dca1pfm8P7wnhRrj21Ub2Ba9ebkvSHNR
         emlMfDhW47osd0VNQ5EnoepcFFF9E/vr+LmLaDXc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5889D601C3;
        Thu, 25 Jul 2019 05:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564034108;
        bh=dcWibguJX8D7tDXGfD1l0OlXEYMWmZ8Gxr3nT63OX1c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Vnz4Zsl7WHGu1WDU9EgKHBH1cCNSjoU6iIKeGi5v5rvr1Rq+r4x6hqYJcBN2C7DTj
         75MghvN7NCG5obHoUpMA/CJGK41GFmwRSW2K2yMILKzo1F6uojlVOJOauAdNstncl3
         7+T53dHWxEzTFHUw/WC/fc3PKFh8UGQBrgdLfKmA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5889D601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Luca Coelho <luca@coelho.fi>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Grumbach\, Emmanuel" <emmanuel.grumbach@intel.com>,
        johannes.hirte@datenkhaos.de, steven@uplinklabs.net,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH for v5.2] iwlwifi: mvm: disable TX-AMSDU on older NICs
References: <20190703081049.28831-1-luca@coelho.fi>
        <1d7609a45e38725d57c2f78b5e437b83b7e49197.camel@coelho.fi>
        <87d0irqr2l.fsf@codeaurora.org>
        <CA+ASDXPjLW+Zrf-uruCLMFGGDaJd=xYWt4tb=T_0HKP=ZnHbTQ@mail.gmail.com>
Date:   Thu, 25 Jul 2019 08:55:03 +0300
In-Reply-To: <CA+ASDXPjLW+Zrf-uruCLMFGGDaJd=xYWt4tb=T_0HKP=ZnHbTQ@mail.gmail.com>
        (Brian Norris's message of "Wed, 24 Jul 2019 16:55:25 -0700")
Message-ID: <87muh2zmiw.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Wed, Jul 3, 2019 at 4:46 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>> Luca Coelho <luca@coelho.fi> writes:
>> > Hi Dave,
>> >
>> > This is an important fix for a bug that has been reported by several
>> > users in bugzilla (and elsewhere).  It fixes FW crashes that disrupt
>> > throughput and connectivity in general in very popular devices (Intel's
>> > WiFi 7000 and 8000 series).
>> >
>> > I know it's a bit late for v5.2, but if possible, it would be great to
>> > take this.  Kalle is on vacation, so we agreed that I would send it
>> > directly to you.
>>
>> Acked-by: Kalle Valo <kvalo@codeaurora.org>
>
> 5.2 has come and gone, and I believe Kalle has awoken from vacation.

Yeah, I have sort of crawled out of my cave ;)

> Can we get this for 5.3?

Ah, this slipped through the cracks. Thanks for pointing it out. I now
took this patch from Luca and assigned to myself in patchwork and I'll
queue this for v5.3.

https://patchwork.kernel.org/patch/11029027/

-- 
Kalle Valo
