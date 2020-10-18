Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69351291692
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Oct 2020 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgJRJLo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Oct 2020 05:11:44 -0400
Received: from z5.mailgun.us ([104.130.96.5]:63272 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgJRJLn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Oct 2020 05:11:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603012303; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=cErscIcmivCugo6aigtvXZdzjNb6FtMtcaS3hqWDt0k=; b=S218mpSLzswHsLo97HmBFE8uPepeCiD7IVvpckPQD/mgRcj8GNabjMq+YJq48MTDZoEtaus4
 +bcjyIe8c7p30T8bz4z2GJrZMeGI1rkH6y/FLeePVstGplE9sQ83WvLdXzUO00oL+U7W45yl
 af5DFqnMlPSj69k4sS0b5aoWjAU=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f8c06bce9e942744cd5feb4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 18 Oct 2020 09:11:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C0B7C43387; Sun, 18 Oct 2020 09:11:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06CD2C433C9;
        Sun, 18 Oct 2020 09:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06CD2C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     David Rubio <david.alejandro.rubio@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
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
Date:   Sun, 18 Oct 2020 12:11:18 +0300
In-Reply-To: <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com>
        (David Rubio's message of "Fri, 16 Oct 2020 15:42:37 -0300")
Message-ID: <87h7qrq4p5.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Rubio <david.alejandro.rubio@gmail.com> writes:

>> https://lore.kernel.org/linux-wireless/c0c336d806584361992d4b52665fbb82@realtek.com/
>
> I tested that patch. Works fine for me for wifi, but I can't test BT
> to be sure it works 100%. Most people will be fine with just wifi
> though, I guess, considering the objections were mostly about BT (I
> understood -from the objection- that connecting to a AP when having a
> BT device paired breaks?)

If the patch helps people to get wifi working we should take it, BT coex
issues can be fixed in followup patches. IIRC there has been multiple
reports about this so I'm leaning towards taking the patch to v5.11.

I changed the patch to New state and my plan is to take it to
wireless-drivers-next once the tree opens:

https://patchwork.kernel.org/project/linux-wireless/patch/20200805084559.30092-1-kai.heng.feng@canonical.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
