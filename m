Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D45840E32A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244905AbhIPQph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:45:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53153 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244455AbhIPQng (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:43:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631810536; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=GdMX3W4kB6jE1Dh1q7N+9phTK4EXeOSDz7/sYzwb3Mc=; b=cq0MAQwB006y8Q7j0t531m0DjK9jLUh+Vvkv4SwIRadwYMyceDgAk3HFwTZWTZE9s5XS9woF
 3ejiOLz8QCdGy8+In2FpzKvlKM2qM7IK3gFippYuyylhtaeWXvwm+DI45rdiNV/M2txWnpkF
 NMqVau7T56d9LY3hA4xeWXTmZdU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 614373e18b04ef85894085e3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 16:42:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 451FFC43164; Thu, 16 Sep 2021 16:42:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14883C43164;
        Thu, 16 Sep 2021 16:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 14883C43164
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>, ath11k@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [regression] mhi: ath11k resume fails on some devices
References: <871r5p0x2u.fsf@codeaurora.org>
        <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
        <20210916111218.GA12918@thinkpad>
        <CAMZdPi94607mZorp+Zmkw3seWXak6p9Jr05CQ5hhfgKQoG8n7Q@mail.gmail.com>
        <20210916163529.GA9027@thinkpad>
Date:   Thu, 16 Sep 2021 19:42:02 +0300
In-Reply-To: <20210916163529.GA9027@thinkpad> (Manivannan Sadhasivam's message
        of "Thu, 16 Sep 2021 22:05:29 +0530")
Message-ID: <87k0jgxyjp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> On Thu, Sep 16, 2021 at 01:18:22PM +0200, Loic Poulain wrote:
>> Le jeu. 16 sept. 2021 =C3=A0 13:12, Manivannan Sadhasivam <
>> manivannan.sadhasivam@linaro.org> a =C3=A9crit :
>>=20
>
> [...]
>
>> > If things seems to work fine without that patch, then it implies that
>> > setting M0
>> > state works during resume. I think we should just revert that patch.
>> >
>> > Loic, did that patch fix any issue for you or it was a cosmetic fix on=
ly?
>>=20
>>=20
>> It fixes sdx modem resuming issue, without that we don=E2=80=99t know mo=
dem needs
>> to be reinitialized.
>>=20
>
> Okay. Then in that case, the recovery mechanism has to be added to the at=
h11k
> MHI controller.

What does that mean in practise, do you have any pointers or examples? I
have no clue what you are proposing :)

> If that's too much of work for Kalle, then I'll look into it. But I might=
 get
> time only after Plumbers.

I'm busy, as always, so not sure when I'm able to do it either. I think
we should seriously consider reverting 020d3b26c07a and adding it back
after ath11k is able to handle this new situation.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
