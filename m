Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0681C67DB
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEFGFH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 02:05:07 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:33333 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725771AbgEFGFG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 02:05:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588745105; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=NOSv6mgr6v6/OUPvQiZ2wq9ub1dKUvYs+RN2KDRiZBs=; b=pdz5qxRbh2FFRxIVhfAmoogeT3QVfnG7ze1fdXeFjtMq/XrJrCEqr0O15cwhNAMZgelVp/qP
 jJqH2DDVaOElkR/Ba/eFwyM+gRB1Mezc8nyhRunPfVYAA/pCgYXVVgtlAFhzh5betlKFWN9o
 phTDPtzs7bOISlS8+vhfUlZAUf4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb2538e.7fa238fbcd50-smtp-out-n03;
 Wed, 06 May 2020 06:05:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 48BC1C433CB; Wed,  6 May 2020 06:05:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE980C433D2;
        Wed,  6 May 2020 06:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE980C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Frank =?utf-8?Q?Sch=C3=A4fer?= <fschaefer.oss@googlemail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] carl9170: remove P2P_GO support
References: <20200425092811.9494-1-chunkeey@gmail.com>
        <5ebf8e6d-d34b-aa92-d166-d8a5ca0b2c18@googlemail.com>
        <87368ej1aj.fsf@tynnyri.adurom.net> <27876964.GhbJDmQBxd@debian64>
Date:   Wed, 06 May 2020 09:04:58 +0300
In-Reply-To: <27876964.GhbJDmQBxd@debian64> (Christian Lamparter's message of
        "Tue, 05 May 2020 20:31:01 +0200")
Message-ID: <87368dd2et.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> On Tuesday, 5 May 2020 09:20:20 CEST Kalle Valo wrote:
>> Frank Sch=C3=A4fer <fschaefer.oss@googlemail.com> writes:
>> >
>> > Am 25.04.20 um 11:28 schrieb Christian Lamparter:
>> >> This patch follows up on a bug-report by Frank Sch=C3=A4fer that
>> >> discovered P2P GO wasn't working with wpa_supplicant.
>> >> This patch removes part of the broken P2P GO support but
>> >> keeps the vif switchover code in place.
>> >
>> > Hmm... no way to fix it ?
>> > P2P-GO seems to work fine with p2p_no_group_iface=3D1, so do you really
>> > think it's a good idea / required to remove the whole thing ?
>> >
>> >> Cc: <stable@vger.kernel.org>
>> >
>> > Are you sure about that ?
>> > People might be using it...
>>=20
>> Christian, what should I do? Take the patch or drop it?
>
> Well, the way I see it: AR9170's silicon die has been cast before
> P2P was a thing. And while it was nice back in '10 then to had have
> something to test ath9k with, by todays standards the lack of features
> like separate TSF sync and the cacheless BA makes it so that it's holding
> back the performance and connection quality of all the clients which are
> connected to it.
>
> So, I think we'll just kicking down the can on that and I'm sorry that
> I gave the people  the wrong impression. There are much better chips now
> that came with P2P in mind.=20
>
> So: please take the patch.

Sounds good to me, thanks. I'll take the patch.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
