Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA12C10D287
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 09:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfK2Ijl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 03:39:41 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:51654
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbfK2Ijl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 03:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575016779;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=cv6Zlax4vjaRvpqj7jwmwpJGIlLjYfuDPon/s1UN/h0=;
        b=boeli0ZDccbZxvc2454Tqs/i4/vHuLM6LCr2+YqRJIYxfz3jOCgBZRUYcMR7cVbL
        BesWDdCj0feaBsyEA7CJ8ZVMHcS70ivUYbqDJjGJA3oW5NwZUePSR35P7Af1rFrf+6N
        xCmgjvyfzE/muUCaumF+3azcDgWVZpWU2LbVwhn0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575016779;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=cv6Zlax4vjaRvpqj7jwmwpJGIlLjYfuDPon/s1UN/h0=;
        b=B3mOz5hTyYHTrps7Wr1y/eOQTh3IGfuSDVuQ7k95RAIdWSu5HB5nv9tuBBGmgbBp
        eUhvR05uIl0lGovKe5+Q3Rek6rgJjfQu+STwqDEiethxamzpTt6oZVeLDuvWjxYq4Ds
        TytPJ6mn0zujixHUA3DLmWAIH+QI3Z1plE0oKG+4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73215C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     qize wang <wangqize888888888@gmail.com>,
        linux-wireless@vger.kernel.org, amitkarwar <amitkarwar@gmail.com>,
        nishants <nishants@marvell.com>, gbhat <gbhat@marvell.com>,
        huxinming820 <huxinming820@gmail.com>,
        "dan.carpenter" <dan.carpenter@oracle.com>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH v2] mwifiex: Fix heap overflow in mmwifiex_process_tdls_action_frame()
References: <CAGftXBHnkYt2KR=kqJfDhEqEuW52ckbepCmTnQQcDyDcVG0WZg@mail.gmail.com>
        <20191129083425.GA3579842@kroah.com>
Date:   Fri, 29 Nov 2019 08:39:39 +0000
In-Reply-To: <20191129083425.GA3579842@kroah.com> (Greg KH's message of "Fri,
        29 Nov 2019 09:34:25 +0100")
Message-ID: <0101016eb650cf37-aba39f4f-c826-412c-8e73-974459f94711-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SES-Outgoing: 2019.11.29-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(dropping security lists)

Greg KH <gregkh@linuxfoundation.org> writes:

> Some minor problems with your patch:
>
> On Fri, Nov 29, 2019 at 04:18:21PM +0800, qize wang wrote:
>> mwifiex_process_tdls_action_frame() without checking
>> the incoming tdls infomation element's vality before use it,
>> this may cause multi heap buffer overflows.
>>=20
>> Fix them by putting vality check before use it.
>>=20
>> IE is TLV struct, but ht_cap and  ht_oper aren=E2=80=99t TLV struct.
>> the origin marvell driver code is wrong:
>>=20
>> memcpy(&sta_ptr->tdls_cap.ht_oper, pos,....
>> memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos,...
>>=20
>> Fix the bug by changing pos(the address of IE) to
>> pos+2 ( the address of IE=E2=80=99s value ).
>>=20
>> Signed-off-by: wangqize <540263207@qq.com>
>
> This has to match the name on the From: line.
>
>> ---
>> v2: change commit log
>>  drivers/net/wireless/marvell/mwifiex/tdls.c | 70
>> ++++++++++++++++++++++++++---
>>  1 file changed, 64 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c
>> b/drivers/net/wireless/marvell/mwifiex/tdls.c
>> index 09313047beed..7caf1d26124a 100644
>> --- a/drivers/net/wireless/marvell/mwifiex/tdls.c
>> +++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
>> @@ -953,59 +953,117 @@ void mwifiex_process_tdls_action_frame(struct
>> mwifiex_private *priv,
>>=20
>>   switch (*pos) {
>>   case WLAN_EID_SUPP_RATES:
>> + if (pos[1] > 32)
>> + return;
>
> All of your whitespace is totally damaged here, making this patch
> impossible to apply :(

And even worse, it was using HTML :)

> Please fix up your email client to not do that (you can just use 'git
> send-email' directly) and resend a v3.

Yes, please. And even better if you try sending the patch to yourself
and then applying with git-am. That way you should notice any problems
with the mail settings.

More info in the link below, read it very carefully.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
