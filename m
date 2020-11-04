Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5382A63D6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 13:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgKDMCK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 07:02:10 -0500
Received: from z5.mailgun.us ([104.130.96.5]:37374 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbgKDMCK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 07:02:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604491329; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=Ln70q8debLVL66KyI4hjJKNAnW4MQcgqWGyT+OG4TeY=; b=mHt9WVAIGYTtbEh0AALwE6uRhyzAcszrvNK6KVEdvW3Qun75gbJ0HhkNtkcnJuO/8Mw5S1Np
 ACrc0lBnh4wtA7TD8xliJjGUjYSewWvTbd4+B8AuFdwNcJcgaX/+DRWj3b9quWA5jkYkqfGY
 tbWJxnlP7attopi9ksZysMuInHA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fa29823978460d05b96a932 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 12:01:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EA9B2C433FE; Wed,  4 Nov 2020 12:01:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7859FC433C8;
        Wed,  4 Nov 2020 12:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7859FC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     linux-wireless@vger.kernel.org,
        Markov Mikhail <markov.mikhail@itmh.ru>
Subject: Re: [PATCH] rt2x00: remove unused variable in rt2800_get_survey
References: <20201104115148.GA84318@wp.pl>
Date:   Wed, 04 Nov 2020 14:01:34 +0200
In-Reply-To: <20201104115148.GA84318@wp.pl> (Stanislaw Gruszka's message of
        "Wed, 4 Nov 2020 12:51:48 +0100")
Message-ID: <87361ps541.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <stf_xl@wp.pl> writes:

> Patch fixes this compile warning:
>
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c: In function =E2=80=98rt28=
00_get_survey=E2=80=99:
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10533:25: warning: unused =
variable =E2=80=98conf=E2=80=99 [-Wunused-variable]
> 10533 |  struct ieee80211_conf *conf =3D &hw->conf;
>       |                         ^~~~
>
> added by recent patch "rt2x00: save survey for every channel visited"

You mean this one?

https://patchwork.kernel.org/project/linux-wireless/patch/1603222991841.296=
74@itmh.ru/

That patch is not applied yet, so please send v3 with this patch folded
into it.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
