Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B24288D19
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbgJIPpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 11:45:19 -0400
Received: from z5.mailgun.us ([104.130.96.5]:28067 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389355AbgJIPpP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 11:45:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602258314; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=Q2f38+nv4w/0orlGbJ8rfWKFOI1Z5V7YLrsAbG8VVVY=; b=vAjd5WgWzAVh+pCE9jam3R8sTbmLgQuZpwyCXNCff6kiTWoEKYbC7O4qGVaeNcbK3JdXim0I
 50298Y+JoMj7XyYhReIhXWHECG35UIkGLWYnUJXiIhcCBVvbg4+5mNR1RDeydSBtRAn2DVS2
 McAcN2HYZXHNvuJzsAy5Spp0qJo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f808589856d9308b53e8829 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Oct 2020 15:45:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD5B3C43395; Fri,  9 Oct 2020 15:45:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32430C433FF;
        Fri,  9 Oct 2020 15:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32430C433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     miaoqinglang <miaoqinglang@huawei.com>
Cc:     Jakub Kicinski <kubakici@wp.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mt7601u: Convert to DEFINE_SHOW_ATTRIBUTE
References: <20200716085749.11105-1-miaoqinglang@huawei.com>
        <20200716082036.76f47d2f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <d0817369-c884-981a-6dd7-2fef0f361e9e@huawei.com>
        <87eem7s8wi.fsf@tynnyri.adurom.net>
Date:   Fri, 09 Oct 2020 18:45:09 +0300
In-Reply-To: <87eem7s8wi.fsf@tynnyri.adurom.net> (Kalle Valo's message of
        "Fri, 09 Oct 2020 18:42:37 +0300")
Message-ID: <87a6wvs8sa.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> miaoqinglang <miaoqinglang@huawei.com> writes:
>
>> =E5=9C=A8 2020/7/16 23:20, Jakub Kicinski =E5=86=99=E9=81=93:
>>> On Thu, 16 Jul 2020 16:57:49 +0800 Qinglang Miao wrote:
>>>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>>>
>>>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>>>
>>> Acked-by: Jakub Kicinski <kubakici@wp.pl>
>>>
>> Hi Jakub,
>>
>> I noticed that this patch has been acked by you and not patched into
>> linux-next. There's little difference now so resent a new patch
>> against linux-next(20200917), and it can be applied to mainline
>> cleanly now.
>
> This patch didn't apply to wireless-drivers-next and my script sent you
> an email about it:
>
> https://patchwork.kernel.org/patch/11666949/
>
> Please rebase over latest wireless-drivers-next and resend as v2.

Nevermind, I see that you sent v2 already and that was applied. Sorry
for the noise.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
