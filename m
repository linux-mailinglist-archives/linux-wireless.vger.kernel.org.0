Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 108D414991
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 14:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEFM32 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 08:29:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfEFM31 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 08:29:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C7CFC60AA8; Mon,  6 May 2019 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557145766;
        bh=VCvP/gZAtcdtOifWNcdeLJAMQjdxY3mj3YVbMsOAGFI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gKs7elg/jakUd1+If6pY68R2V2fGRDiDkVZnz7fRxK+hiBdNjaMGjyvIp9KnI/hKJ
         z9MXEHrPirmW10V6rW3x+jEr4zKke9MZjCvwZQElbkqUqA3xyppoSvil+P268o2Az+
         nEabs75gO9UfpmaqXTCWcB1NUqULdTYT4upQvfMM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-75-57-nat.elisa-mobile.fi [85.76.75.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B5676063F;
        Mon,  6 May 2019 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557145765;
        bh=VCvP/gZAtcdtOifWNcdeLJAMQjdxY3mj3YVbMsOAGFI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Zo1+MTb4vOE/Wr9aNHItSl0CLGLIok2gBzecwaLxeD8j8IWrtk6cFTxoD9gQAm3ba
         QnY+juX0Pt4luoptzPeLC1F7toNvNAyoxOvcZYuPu7QXLhFAgqD33zvdTCGViokt8z
         NB8LqrF5CcuTf+FE1mYYRY4nUWRVWnjzmgEVHsQk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B5676063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Victor Bravo <1905@spmblk.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
References: <20190504162633.ldrz2nqfocg55grb@localhost>
        <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
        <20190504194440.4zcxjrtj2aft3ka4@localhost>
        <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        <20190505150355.3fbng4ny34x255vk@localhost>
        <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com>
        <87o94gug81.fsf@codeaurora.org>
        <20190506091441.wqtccm4n6xxhxom2@localhost>
Date:   Mon, 06 May 2019 15:29:21 +0300
In-Reply-To: <20190506091441.wqtccm4n6xxhxom2@localhost> (Victor Bravo's
        message of "Mon, 6 May 2019 11:14:41 +0200")
Message-ID: <878svjvk9q.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Victor Bravo <1905@spmblk.com> writes:

> On Mon, May 06, 2019 at 11:42:06AM +0300, Kalle Valo wrote:
>> Hans de Goede <hdegoede@redhat.com> writes:
>> 
>> >> @@ -99,6 +107,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
>> >>   	{}
>> >>   };
>> >>   +void brcmf_dmi_sanitize(char *dst, const unsigned char *allowed,
>> >> char safe)
>> >> +{
>> >> +	while (*dst) {
>> >> +		if ((*dst < 0) || !(allowed[*dst / 8] & (1 << (*dst % 8))))
>> >
>> > At a first look I have no clue what this code is doing and I honestly do not feel
>> > like figuring it out, this is clever, but IMHO not readable.
>> >
>> > Please just write this as if (*dst < 0x21 || (*dst > foo && < bar) || etc,
>> > so that a human can actually see in one look what the code is doing.
>> 
>> Is there an existing function for sanitising filenames so that we don't
>> need to reinvent the wheel, maybe something like isalnum()?
>
> I would definitely prefer to use existing function, but I didn't find
> any suitable one. Suggestions are welcome.

I didn't find anything either, but hopefully someone knows.

> As for implementation details, the one I posted was optimized for both
> speed and size, and at least in my opinion this bit array driven
> parametric implementation is exactly what is needed here (using a string
> of allowed characters with strchr-style lookups would bring much worse
> complexity, and checking the characters using series of hardcoded if
> conditions could quickly grow to more than those 16 bytes used by the
> array).

But is this really something which should be optimised? This is driver
initialisation, not in some hot path, right? Can you even measure the
difference?

-- 
Kalle Valo
