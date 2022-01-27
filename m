Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D234B49E1CD
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 13:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiA0MBB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 07:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiA0MBA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 07:01:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE4C061714
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 04:01:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F43E61901
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 12:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB68C340E4;
        Thu, 27 Jan 2022 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643284859;
        bh=dd+xXm3UT0mpdcu8rlNM8L5WI43eb/TbiPVXFNI+sxE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=suK5/g4HApyuDvtSK2A5txMZ6yql5TmiuYZz29/CUetJz6LxsMNeRts5fqDoN9XCr
         a/wIRkuKf3TVni4/uzECtKysQZAXWX9IWE2o5fpfCWVIssJAkUZ63dfxUeINGrmbD+
         JaUnmL0ktM03CU/BxmodUzr/GhZfMPR6a5Louv+GGKAnwl7Odwjr5W8piXEMhSVLWi
         NTHcwEgrXfuh7vjtXvfoM6+1MxSIxOXSjAuEgYJIRbVB8UEaPqDhTGUGKZ1gXsPy5t
         G0RWnhK1c3Ts/oL6z5dvCAwXtF/lzZ1fZIKI/2I59+0qXG8U878ngov7Jx+KIJG2cM
         76wg7n43xRrEg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, loic.poulain@linaro.org
Subject: Re: [PATCH 3/4] MAINTAINERS: hand over ath9k maintainership to Toke
References: <20220127092709.5203-1-kvalo@kernel.org>
        <20220127092709.5203-3-kvalo@kernel.org> <87sft91mh9.fsf@toke.dk>
Date:   Thu, 27 Jan 2022 14:00:55 +0200
In-Reply-To: <87sft91mh9.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Thu, 27 Jan 2022 11:50:26 +0100")
Message-ID: <87v8y5jslk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> In practise I have been the only maintainer for ath9k for some time now =
but I
>> don't really have time for it. Luckily Toke is willing to look after so =
mark
>> him as maintainer. Thanks Toke!
>>
>> Signed-off-by: Kalle Valo <kvalo@kernel.org>
>> ---
>>  MAINTAINERS | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2bf3b1f7442e..b1251fc9a71d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15899,9 +15899,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel=
/git/kvalo/ath.git
>>  F:	drivers/net/wireless/ath/ath11k/
>>=20=20
>>  QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
>> -M:	ath9k-devel@qca.qualcomm.com
>> +M:	toke@toke.dk
>
> Could I get my full name in there, please? :)
>
> I know it has weird unicode characters, but you can copy-paste it from
> my other entry in MAINTAINERS

Oh, sorry about that! I'll submit v2.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
