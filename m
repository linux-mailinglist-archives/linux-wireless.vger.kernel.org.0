Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163113A690F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jun 2021 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhFNOgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Jun 2021 10:36:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31808 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232815AbhFNOgE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Jun 2021 10:36:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623681241; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=JjeuJNf5EtjKxKIZCEFmri0qAfcdNBH+gaeNtZ3y2rU=; b=VTuNVnPDQWf++uEZsgYjKuYadeHzHEYMKSVSrir0xl4ubEWkqb5aE8qlcRUi1kkb28nwAMhR
 rf0rynX5HqmCDwaHmKNv0y+3ikpnaDVzRn0mRMz1/SZvb7rjg56uDOLzWDTSLyueWLz7We/y
 5dzwQn/fheewaHIkZedd12pPS8w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60c768b7e27c0cc77fea5bb9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Jun 2021 14:33:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 279F7C4323A; Mon, 14 Jun 2021 14:33:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 793EFC4338A;
        Mon, 14 Jun 2021 14:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 793EFC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl\@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list\@infineon.com" 
        <SHA-cyfmac-dev-list@infineon.com>
Subject: Re: [PATCH 1/2] brcmfmac: fix setting of station info chains bitmask
References: <20210506132010.3964484-1-alsi@bang-olufsen.dk>
        <ea5a0ce5-1bc9-774c-06be-6ecc284531c5@pqrs.dk>
Date:   Mon, 14 Jun 2021 17:33:16 +0300
In-Reply-To: <ea5a0ce5-1bc9-774c-06be-6ecc284531c5@pqrs.dk> ("Alvin
 \=\?utf-8\?Q\?\=C5\=A0ipraga\=22's\?\=
        message of "Mon, 14 Jun 2021 15:21:57 +0200")
Message-ID: <87wnqwy0r7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alvin =C5=A0ipraga <alvin@pqrs.dk> writes:

> Hello,
>
> On 5/6/21 3:20 PM, Alvin =C5=A0ipraga wrote:
>> The sinfo->chains field is a bitmask for filled values in chain_signal
>> and chain_signal_avg, not a count. Treat it as such so that the driver
>> can properly report per-chain RSSI information.
>>
>
> <snip>
>
> This is a gentle ping to see if these two patches got lost. I was told
> on another mailing list recently that mail sent from my work address
> is finding its way into peoples' junk folders.
>
> I will resend the patches in the near future if I don't see any
> response here.

I just have been busy and heavily backlogged. The patches are in
patchwork, so no need to resend:

https://patchwork.kernel.org/project/linux-wireless/list/?series=3D477877&s=
tate=3D*

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
