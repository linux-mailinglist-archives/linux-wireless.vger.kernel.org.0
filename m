Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60D45707B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 15:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhKSOWs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 09:22:48 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:24421 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbhKSOWs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 09:22:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637331586; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=Rbzo4r3SRTGCcI5IqrLcAO4VSfc6twRgwENQLwCuv5w=; b=ppSTvhmEn3M076/TFa9/1RHv2Tm56djWgK8XhpIxof+xFslq05J059k4KPHpk2X2OqG2HA4G
 S06hCF8cM5h0ipkQSULcsTTSXn0xvAl3ZD5BJ/P7yaol+b9UiT3vQrFgLAKui737/GDWr260
 4ds6fitPweGXO5XNcXcA7AoerKA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6197b281f5c956d49e990d0f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 14:19:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9F6C7C43618; Fri, 19 Nov 2021 14:19:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7D9BC4338F;
        Fri, 19 Nov 2021 14:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D7D9BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Exuvo <exuvo@exuvo.se>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "regressions\@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH] rt2x00: do not mark device gone on EPROTO errors during start
References: <87czop5j33.fsf@tynnyri.adurom.net>
        <6366d9bd-9752-dbc2-8970-442bdc6e8eea@leemhuis.info>
        <7d353dd2-2ffb-6d5e-9983-f983c8b4f6da@leemhuis.info>
        <20211109073127.ga109212@wp.pl> <20211109120737.ga120005@wp.pl>
        <c81f829d-fd87-7580-fb9a-1a84958f890f@exuvo.se>
        <cc85b4e8a038417b865069c6578acf50@grupawp.pl>
        <87wnlgo5rp.fsf@codeaurora.org> <20211110080141.GA123566@wp.pl>
        <b3b9c143-485f-5fe1-312c-c64a8ce33f8a@exuvo.se>
        <20211111141003.GA134627@wp.pl>
        <cfac5f5c-83d7-e0d9-5368-07ca041ebaed@leemhuis.info>
Date:   Fri, 19 Nov 2021 16:19:39 +0200
In-Reply-To: <cfac5f5c-83d7-e0d9-5368-07ca041ebaed@leemhuis.info> (Thorsten
        Leemhuis's message of "Thu, 18 Nov 2021 07:16:45 +0100")
Message-ID: <87zgq0b538.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> Hi, this is your Linux kernel regression tracker speaking. Thx for this f=
ix.
>
> On 11.11.21 15:10, Stanislaw Gruszka wrote:
>> As reported by Exuvo is possible that we have lot's of EPROTO errors
>> during device start i.e. firmware load. But after that device works
>> correctly. Hence marking device gone by few EPROTO errors done by
>> commit e383c70474db ("rt2x00: check number of EPROTO errors") caused
>> regression - Exuvo device stop working after kernel update. To fix
>> disable the check during device start.
>>=20
>> Reported-and-tested-by: Exuvo <exuvo@exuvo.se>
>
> FWIW: In case you need to send an improved patch, could you
> please add this before the 'Reported-by:' (see at (=C2=B9) below for the
> reasoning):
>
> Link:
> https://lore.kernel.org/linux-wireless/bff7d309-a816-6a75-51b6-5928ef4f7a=
8c@exuvo.se/
>
> And if the patch is already good to go: could the subsystem maintainer
> please add it when applying?

Sure, I'll add it during commit.

>> Fixes: e383c70474db ("rt2x00: check number of EPROTO errors")
>
> What's the plan to getting this merged?

My plan is to commit this to wireless-drivers tree, the tree was just
closed due to the merge window.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
