Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE62FA378
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 15:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405034AbhAROpp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 09:45:45 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:13128 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405165AbhAROpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 09:45:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610981096; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=3s3dtJucqmYafxFaC5tc9//4H1bRSXsj8hTO4ympo68=; b=uNeQHSdIJ9PXX2RIntnnu8mlN6OD1l1dHlDLkERJdTbEsooiNkTH8YDRiGnDxUgWPcKUruU6
 9XFlBBgPBflmDYoGQEbJ042l9FVaWKiCvssCBwmVgEVgFBWdxyznAL4pVGuNnnX0NF9Nlkfn
 sT+wdKEQ2HM0eQTBfyMICRcisI0=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60059ecaba7f868506fae709 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 14:44:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D725C43464; Mon, 18 Jan 2021 14:44:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7660AC433CA;
        Mon, 18 Jan 2021 14:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7660AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma\@gmail.com" <tony0620emma@gmail.com>,
        Bernie Huang <phhuang@realtek.com>
Subject: Re: [PATCH RESEND v3 0/8] rtw88: improve TX performance in field
References: <20210114010950.3316-1-pkshih@realtek.com>
        <874kjkrnje.fsf@codeaurora.org> <1610673434.2741.20.camel@realtek.com>
        <87zh1ar60n.fsf@codeaurora.org> <1610698027.2741.26.camel@realtek.com>
Date:   Mon, 18 Jan 2021 16:44:21 +0200
In-Reply-To: <1610698027.2741.26.camel@realtek.com> (pkshih@realtek.com's
        message of "Fri, 15 Jan 2021 08:07:43 +0000")
Message-ID: <87a6t6gv96.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

> On Fri, 2021-01-15 at 09:52 +0200, Kalle Valo wrote:
>> Pkshih <pkshih@realtek.com> writes:
>>=20
>> > To avoid frequently submitting patches results from exceeding patch si=
ze
>> limit.
>> > I'd like to know the patch size limit accepted by patchwork.
>> > As I know, the limit is about 512k, so it is expected that below patch=
es
>> > don't appear in patchwork
>> > 1. patch 5/5 of v1 (978K)
>> > 2. patch 6/7 of v2 (532K)
>> >
>> > But, I don't know why the table file (patch 16/18) of rtw89 whose size=
 is
>> > 772k can appear in patchwork. Does patchwork have different limits of
>> > existing and new file? Moreover, if new file exceeds the limit someday,
>> > how can I deal with it? Can I split the new file into two or more patc=
hes?
>>=20
>> I suspect the mailing list limits the size, not patchwork. I did
>> directly get "[PATCH 5/5] rtw88: 8822c: update phy parameter tables to
>> v60" (Message-ID 20210113092312.13809-6-pkshih@realtek.com) as you added
>> me to CC. But I don't see it in lore, which points that linux-wireless
>> dropped it.
>>=20
>> Normally these huge patches would not be applied being to big, but
>> updating parameter tables is a good exception to the rule and I can
>> commit those manually directly from my INBOX. So for huge patches I
>> recommend:
>>=20
>> * move the patch as the last patch in the patchset
>>=20
>> * the huge patch should only have changes to parameter variables, ie.
>> =C2=A0 refactor changes to the actual code to a separate patch
>>=20
>> * add kvalo@codeaurora.org to CC
>>=20
>> * add a big warning to the cover letter (or reply afterwards) so that I
>> =C2=A0 notice the huge patch is missing from patchwork
>>=20
>> Would this work?
>>=20
>
> Yes, it works. Many thanks.
>
> I would like to know if it is accepted to split the big one into two or
> more patches, like my v3? Or, I should recall v1 style when I submit v4?

For me splitting the patch into smaller patches (which are visible in
patchwork) is easier as then I don't need to do any manual work. When
splitting patches just make sure that the requirement of every patch
compiling without warnings is fulfilled.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
