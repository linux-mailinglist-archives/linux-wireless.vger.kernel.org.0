Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A5196598
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfHTPxD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:53:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfHTPxC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:53:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7728460DB4; Tue, 20 Aug 2019 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316382;
        bh=0rDMZlz9T+xvVa034ALOwHytJXeK6p/eD40ZyVWkk90=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UKLImnQgS531UBwnNhcvgrDshd/1K7Dn/DbH1x10miFzj1v6kCaV6FOA337aXpi70
         F+mMiHgjsOlvpvXN07BydD3CflSb4THtKjO+NG1yaYdtyCLBkc2SgYAoRnRZPOjhAs
         XLYQhQLWdqoXSuSezOTMZ7FQK+3oBjBW0ZzLBnPU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6853F60FE9;
        Tue, 20 Aug 2019 15:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316381;
        bh=0rDMZlz9T+xvVa034ALOwHytJXeK6p/eD40ZyVWkk90=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hDf6mhPG5uY+JOCgX0qQnu5hRvi/uiqr9ZXmMrX/InHrsKngrj+fV59+alzcc90f8
         S+tszES0POthGVTiSreK6S9hzDt/GTL1md57sc0QO3bqRHCBeq2+fvoXB55Oe+wUpU
         ZqNazuUpzg2+VkePa/Y262wKqwjSHt6PlAkBTtEA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6853F60FE9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com
Subject: Re: [PATCH 5/5] rtlwifi: rtl8192cu: Fix value set in descriptor
References: <20190812192741.14479-1-Larry.Finger@lwfinger.net>
        <20190820140836.6727960E57@smtp.codeaurora.org>
        <8b4f8edf-fd73-2b88-b985-22658840f409@lwfinger.net>
Date:   Tue, 20 Aug 2019 18:52:57 +0300
In-Reply-To: <8b4f8edf-fd73-2b88-b985-22658840f409@lwfinger.net> (Larry
        Finger's message of "Tue, 20 Aug 2019 10:36:19 -0500")
Message-ID: <87d0gzal5y.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 8/20/19 9:08 AM, Kalle Valo wrote:
>> Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>>> In the process of converting the bit manipulation macros were converted
>>> to use GENMASK(), the compiler reported a value too big for the field.
>>> The offending statement was trying to write 0x100 into a 5-bit field.
>>> An accompaning comment says to set bit 3, thus the code is changed
>>> appropriately.
>>>
>>> This error has been in the driver since its initial submission.
>>>
>>> Fixes: 29d00a3e46bb ("rtlwifi: rtl8192cu: Add routine trx")
>>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>>
>> I only see patch 5 on patchwork, what happened to patches 1-4?
>
> I pulled them at the last minute, but forgot to rename the subject.
> Please apply that fix alone. The others will follow when I get time;
> however, they are code improvements. Only this one was a code fix.

Ok, I was just worried if patchwork had lost of them somehow.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
