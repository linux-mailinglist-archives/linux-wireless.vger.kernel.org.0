Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8094E29581D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 07:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503010AbgJVFxg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Oct 2020 01:53:36 -0400
Received: from z5.mailgun.us ([104.130.96.5]:18285 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502986AbgJVFxf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Oct 2020 01:53:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603346015; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=solP3a87WJu1JBg1mwFZN7icddaiE6Xmc+jZ8zmCETM=; b=m2B6UGl1yOfQ8w1VR3pD388aoxaXyjWt3gnI/LlIWdyJUNK0AVtsQNK3RH04tjU+Lmzs2O/I
 dCbdLaFGyBCFveojz2EYTxqFewxeiixOtcaUfTLjr/j3xSQOwKYsxnLkQrZJaNEoeSd4y6r/
 m7r6/u1Jx970cEqJwDaUSRniQVo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f911e5e4f8cc67c315b8b28 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Oct 2020 05:53:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 196D9C433F0; Thu, 22 Oct 2020 05:53:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58349C433CB;
        Thu, 22 Oct 2020 05:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58349C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     David Rubio <david.alejandro.rubio@gmail.com>,
        Andy Huang <tehuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
        <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
        <362f154dff1b4d6f88503af813eae406@realtek.com>
        <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
        <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com>
        <87h7qrq4p5.fsf@tynnyri.adurom.net>
        <87bc4553-7f17-0c23-50c8-2b413de9f7b8@lwfinger.net>
Date:   Thu, 22 Oct 2020 08:53:29 +0300
In-Reply-To: <87bc4553-7f17-0c23-50c8-2b413de9f7b8@lwfinger.net> (Larry
        Finger's message of "Mon, 19 Oct 2020 12:10:50 -0500")
Message-ID: <87a6we7qna.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 10/18/20 4:11 AM, Kalle Valo wrote:
>> David Rubio <david.alejandro.rubio@gmail.com> writes:
>>
>>>>
>>> https://lore.kernel.org/linux-wireless/c0c336d806584361992d4b52665fbb82@realtek.com/
>>>
>>> I tested that patch. Works fine for me for wifi, but I can't test BT
>>> to be sure it works 100%. Most people will be fine with just wifi
>>> though, I guess, considering the objections were mostly about BT (I
>>> understood -from the objection- that connecting to a AP when having a
>>> BT device paired breaks?)
>>
>> If the patch helps people to get wifi working we should take it, BT coex
>> issues can be fixed in followup patches. IIRC there has been multiple
>> reports about this so I'm leaning towards taking the patch to v5.11.
>>
>> I changed the patch to New state and my plan is to take it to
>> wireless-drivers-next once the tree opens:
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20200805084559.30092-1-kai.heng.feng@canonical.com/
>
> Kalle,
>
> I had generated and applied that trivial patch to my GitHub repo with
> the rtw88 drivers a couple of months ago. Yes, it does get the user
> past the initialization check; however, wifi performance is abysmal
> according the the users of the repo. It seems that the antenna
> selection of rfe 2 models affects wifi as well as BT. Applying this
> patch will get wifi running; however, the users will need to be within
> 1 m of the AP for it to work! I do not have an RTL8821CE chip, thus I
> have not tested myself.

Ok, I will drop the patch then. But it would be really nice to enable
even some level of support for rfe 2, can't we find some solution? Like
disabling 2.4 GHz band for that rfe or something?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
