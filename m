Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C84523BE
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfFYGvI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 02:51:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46700 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFYGvI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 02:51:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DE38860208; Tue, 25 Jun 2019 06:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561445467;
        bh=rPJrK85HDGp8IPuEX5EuE+VDBHdTpUSVCq5Cp27lFfU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LepiwZyDX0dxbuY+t+UjZLOcVW+bIPSMnlCvbz8WYM0B3aOZD3HJqVFhZFNcr479W
         c3QXh5yvrE3TFNYUMFolbckU06LwaUPOc0UDkGXVbYEUKGYyTqlQ9G0UkXHRijNn9j
         JTDoLJ7+h0N28xpE+MrIKMYnL0hDykGlpIsZGYxY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3A9960208;
        Tue, 25 Jun 2019 06:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561445466;
        bh=rPJrK85HDGp8IPuEX5EuE+VDBHdTpUSVCq5Cp27lFfU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FoMjpL8O7EWSvHo+zv3q3YGSNLfiTdnznC5FmAIOtJeRcMTehMKMfCmtj2/6y1Uru
         Wrg++GwLHgJlFVMwyQtyErDUK4jmI70HHQ0yCuU1JCSAAUhd0fbncjj3u/pBK9q0d+
         btKs1mFs9wlXa3AuBYN+sH/uPadjSZSk48dfbdO8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3A9960208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: linux-next: build failure after merge of the tip tree
References: <20190625160432.533aa140@canb.auug.org.au>
        <8736jyfaje.fsf@codeaurora.org>
        <20190625163608.1aa15ad3@canb.auug.org.au>
Date:   Tue, 25 Jun 2019 09:51:01 +0300
In-Reply-To: <20190625163608.1aa15ad3@canb.auug.org.au> (Stephen Rothwell's
        message of "Tue, 25 Jun 2019 16:36:08 +1000")
Message-ID: <87y31qdup6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> On Tue, 25 Jun 2019 09:23:33 +0300 Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Thanks for the report. Any suggestions how to handle this? Or do we let
>> Linus take care of this?
>
> Just let Linus take care of it ... mention it in the pull request ...

Thanks, I'll do that.

> I guess DaveM needs to know, right?

Yeah, this commit goes from wireless-drivers-next to net-next and from
there to Linus. I'll inform Dave in my pull request.

-- 
Kalle Valo
