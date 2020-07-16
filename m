Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180F1221F73
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 11:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgGPJKW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 05:10:22 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:50099 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbgGPJKW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 05:10:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594890621; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=8mm25D3Dznm95A58js0kAyT9oF5FAEbDbiEDbEYuEwA=; b=itTL7L0vZnBbW1f46Gh2vqOaEe4Gq/R4kZzMxnWxzNf1d2Co3tUbw95bitqd0ul9L7JTOpSJ
 nU3NYkZS9e6ZWkmLnzNjrB9NtGMQPmPQteu2BVcUSCJtBWc42TyuQUaGRGrfkxgl723ocdYl
 5vfNURI1rRJB+IF2bJug40p6HB0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f10197275eeb235f69568d9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 09:10:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1545FC433CB; Thu, 16 Jul 2020 09:10:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70C97C433C9;
        Thu, 16 Jul 2020 09:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70C97C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Viktor =?utf-8?B?SsOkZ2Vyc2vDvHBwZXI=?= 
        <viktor_jaegerskuepper@freenet.de>
Cc:     Mark O'Donovan <shiftee@posteo.net>,
        linux-wireless@vger.kernel.org, hqjagain@gmail.com,
        ath9k-devel@qca.qualcomm.com, davem@davemloft.net, kuba@kernel.org,
        Roman Mamedov <rm@romanrm.net>
Subject: Re: [PATCH 1/1] ath9k: Fix regression with Atheros 9271
References: <20200711043324.8079-1-shiftee@posteo.net>
        <184f6897-40f8-949c-eca5-2bdb0d2aa8fb@freenet.de>
Date:   Thu, 16 Jul 2020 12:10:04 +0300
In-Reply-To: <184f6897-40f8-949c-eca5-2bdb0d2aa8fb@freenet.de> ("Viktor
        \=\?utf-8\?Q\?J\=C3\=A4gersk\=C3\=BCpper\=22's\?\= message of "Thu, 16 Jul 2020
 10:01:29 +0200")
Message-ID: <87y2nj7rmb.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Viktor J=C3=A4gersk=C3=BCpper <viktor_jaegerskuepper@freenet.de> writes:

> [I fixed my e-mail address and CC'ed Roman]
>
> Mark O'Donovan:
>> This fix allows ath9k_htc modules to connect to WLAN once again.
>>=20
>> Fixes: 2bbcaaee1fcb (ath9k: Fix general protection fault in
>> ath9k_hif_usb_rx_cb )
>>=20
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D208251
>>=20
>> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
>
> This fixes the issue for me. Please don't forget:
> Reported-by: Roman Mamedov <rm@romanrm.net>
>
> And if you want to add this:
> Tested-by: Viktor J=C3=A4gersk=C3=BCpper <viktor_jaegerskuepper@freenet.d=
e>
>
> These additional lines are mainly useful if the patch doesn't work for so=
meone
> else and they decide to report it, so hopefully Roman and I would receive=
 the
> report, too. And we already have three threads for this bug.

Thanks, I will. Or well, actually patchwork automatically does that :)

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
