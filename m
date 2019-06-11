Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2233CE10
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbfFKOIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 10:08:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51876 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbfFKOIe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 10:08:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E4C0605A5; Tue, 11 Jun 2019 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560262114;
        bh=fD3pzitmUeXv0XoRWkaWCHwjPgqdynfw/E17eJk74B0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LjCoH7nAX5KyR/iFzjKluJJUXhsvsVsYItWOYDdCNaL57lf4R7qCr2EG51bdFAdlQ
         Xl6SF3Vz112M4jLB7MKCPCNubsQNPiS9IJ0GOJaX3INfOfOgKWZBD6DQrymYqZEQI0
         x8q19dXenrk2mQ/fOB8z6enZD6VpFKlnIfsa6PdI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE60D6038E;
        Tue, 11 Jun 2019 14:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560262113;
        bh=fD3pzitmUeXv0XoRWkaWCHwjPgqdynfw/E17eJk74B0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XcqBuTRLU5ygxCPGkR8Eq5AO0YwoSx84Z+OBe+GQpvjsxJTWGVEoW7dRw+THYgcGN
         pUH3x23Tny4nPxCGShltdYa+vi595bwQQpv0tudrXjz9Un9I7Q1AyW8Unvn0n7C3OP
         jrUxH9z2iEnCgpedPELbmXGPrlIq4TKImIm1knvo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE60D6038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Zefir Kurtisi <zefir.kurtisi@neratec.com>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Re: [PATCH v2] ath9k: correctly handle short radar pulses (fixes 3c0efb745a)
References: <20190611131006.29715-1-zefir.kurtisi@neratec.com>
        <20190611133656.16964-1-zefir.kurtisi@neratec.com>
        <87h88wgrui.fsf@kamboji.qca.qualcomm.com>
        <f3ec61f2-2b63-4d20-b9f4-d85cc2d44073@neratec.com>
Date:   Tue, 11 Jun 2019 17:08:30 +0300
In-Reply-To: <f3ec61f2-2b63-4d20-b9f4-d85cc2d44073@neratec.com> (Zefir
        Kurtisi's message of "Tue, 11 Jun 2019 15:48:57 +0200")
Message-ID: <87a7eogqox.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zefir Kurtisi <zefir.kurtisi@neratec.com> writes:

> On 6/11/19 3:43 PM, Kalle Valo wrote:
>> Zefir Kurtisi <zefir.kurtisi@neratec.com> writes:
>> 
>>> Changes to v1:
>>> * typos fixed in commit-message
>>> --
>>>
>>> In commit '3c0efb745a17 ("ath9k: discard undersized packets")'
>>> the lower bound of RX packets was set to 10 (min ACK size) to
>>> filter those that would otherwise be treated as invalid at
>>> mac80211.
>>>
>>> Alas, short radar pulses are reported as PHY_ERROR frames
>>> with length set to 3. Therefore their detection stopped
>>> working after that commit.
>>>
>>> NOTE: ath9k drivers built thereafter will not pass DFS
>>> certification.
>>>
>>> This extends the criteria for short packets to explicitly
>>> handle PHY_ERROR frames.
>>>
>>> Signed-off-by: Zefir Kurtisi <zefir.kurtisi@neratec.com>
>> 
>> Forgot to mention that the Fixes line should be before s-o-b, not in the
>> title:
>> 
>> Fixes: 3c0efb745a17 ("ath9k: discard undersized packets")
>> 
>> I'll fix (no pun intended) that as well.
>> 
> Thanks. Was unsure about that, checkpatch warned about format (mandatory 12 digit
> hash), but not the proper location. Will keep in mind.

I have tried to document the most important parts to the wiki:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#fixes_line_is_incorrect

-- 
Kalle Valo
