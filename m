Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B044C230
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 14:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhKJNk6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 08:40:58 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:40712 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhKJNk6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 08:40:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636551490; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=7B862f6o0/eR9spFIWw0jZNTKRZeuG0U4+f110DkEyw=; b=SIXdo8qTWJjdUyq6VZzIHiORjV6E00uzapumFFpIUAzJH7z7d42XjAaqvksDqxd7TqFp0Vmg
 sRHVf7EkVw3CBHV5zCx8WowVKTkRuqbXB1jukJF1yShB9i+PoZ3ng0yeWIgwK02Z1MhdTW3x
 Tfq0iJNoXsx8eAPTSjWJ0KzySD8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 618bcb410f34c3436a2b85f2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Nov 2021 13:38:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2FC8C4338F; Wed, 10 Nov 2021 13:38:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C533EC43460;
        Wed, 10 Nov 2021 13:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C533EC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Francesco Magliocca <franciman12@gmail.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        enrico@fracta.dev
Subject: Re: [PATCH] ath10k: abstract htt_rx_desc structure
References: <CAH4F6us6kLs4WZVKVNQV69wZ=BA2AzOyacyKLB3RfVme=9uKvA@mail.gmail.com>
        <27297ff6-d970-7b9a-01f0-d5261d553e6b@leemhuis.info>
Date:   Wed, 10 Nov 2021 15:38:03 +0200
In-Reply-To: <27297ff6-d970-7b9a-01f0-d5261d553e6b@leemhuis.info> (Thorsten
        Leemhuis's message of "Tue, 9 Nov 2021 09:53:13 +0100")
Message-ID: <87wnlgm8qs.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> On 08.11.21 17:25, Francesco Magliocca wrote:
>> QCA6174 card often hangs with the current htt_rx_desc
>> memory layout in some circumstances, because its firmware
>> fails to handle length differences.
>> Therefore we must abstract the htt_rx_desc structure
>> and operations on it, to allow different wireless cards
>> to use different, unrelated rx descriptor structures.
>>=20
>> Define a base htt_rx_desc structure and htt_rx_desc_qca_old
>> for use with the QCA family of ath10k supported cards
>> and htt_rx_desc_new for use with the WCN3990 card.
>>=20
>> Define htt_rx_desc_ops which contains the abstract operations
>> to access the generic htt_rx_desc, give implementations
>> for each card and update htt_rx.c to use the defined
>> abstract interface to rx descriptors.
>>=20
>> Fixes: e3def6f7 ("ath10k: Update rx descriptor for WCN3990 target")

This should be:

Fixes: e3def6f7ddf8 ("ath10k: Update rx descriptor for WCN3990 target")

I can fix that during commit.

>> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
>>=20
>> Co-developed-by: Enrico Lumetti <enrico@fracta.dev>
>> Signed-off-by: Enrico Lumetti <enrico@fracta.dev>
>> Signed-off-by: Francesco Magliocca <franciman12@gmail.com>
>
> As a Linux kernel regression tracker let me use this opportunity and
> say: Thanks for working on a fix for this regression.
>
> There is one small detail that could be improved: the commit message
> would benefit from a link to the regression report. This is explained in
> Documentation/process/submitting-patches.rst, which recently was changed
> slightly to make this aspect clearer:
> https://git.kernel.org/linus/1f57bd42b77c
>
> E.g. add something like this, just *without* the leading caret(=C2=B9):
>
> ^Link:
> https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_ayp=
R74UvN1uQ@mail.gmail.com/
>
> Francesco, could you please do this in case you need to sent an improved
> version for other reasons? And if the patch is already good to go: could
> the subsystem maintainer please add it when applying?

I have not had a chance to review the patch yet, but I can add the link
during commit (if I'll apply this version).

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
