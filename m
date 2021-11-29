Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA4B461086
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 09:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbhK2IyT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 03:54:19 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:54684 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349934AbhK2IwP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 03:52:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638175737; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=CHtLn3D5Nfhez5w+qi5cbij5MsftsW4J59u2TOs15Pc=; b=BOx5qhOaZeWzGikc1jLeaDp+KUVOkc6/jmvvU7nslQrR9wbfmMLspNe4MsYG61NKBsovwKj0
 EZ+zA+2Sx7ZlGrjcRFi740N6xS+wW0ApR9L+DBmzKAYmt/M61hqoJoySGM6X6UX56jV9ykRM
 7/UE460OOA5cAL8hQNEQ/+B29eo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 61a493f3df12ba53c4bdc4ab (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 08:48:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81595C43618; Mon, 29 Nov 2021 08:48:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95338C4338F;
        Mon, 29 Nov 2021 08:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 95338C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd\@nbd.name" <nbd@nbd.name>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: Re: [PATCH] ath9k: switch to rate table based lookup
References: <20211125121652.6073-1-jelonek.jonas@gmail.com>
        <878rxcb4q2.fsf@toke.dk> <87a6hrwg1f.fsf@tynnyri.adurom.net>
        <CAChE-vTktHRW1JR8s1NNnLOqfBihd=5T2qXDsQDyBeecw95U0g@mail.gmail.com>
        <878rxb3qus.fsf@codeaurora.org> <87lf1aahrw.fsf@toke.dk>
Date:   Mon, 29 Nov 2021 10:48:46 +0200
In-Reply-To: <87lf1aahrw.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Fri, 26 Nov 2021 19:33:39 +0100")
Message-ID: <878rx7gxe9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> Jonas Jelonek <jelonek.jonas@gmail.com> writes:
>>
>>>> And how did you test this? Are both PCI and USB devices affected?
>>>
>>> I tested this on a 8devices Rambutan with QCA9558 SoC, but didn=E2=80=
=98t
>>> explicitly test this with a USB device. I am not sure whether the
>>> ath9k_htc is affected. First I tested this without the patch to get a
>>> reference for comparison. I connected three devices via WiFi 2.4GHz
>>> and 5GHz, generated traffic multiple times with iperf3 and captured
>>> the rc_stats for each station. Then I applied the patch and did the
>>> same again. The throughput was overall the same like without the
>>> patch, compared to the first run of each station. Rate selection
>>> worked fine, the stats were nearly identical, same rates selected in
>>> both runs.
>>
>> Thanks. Can someone review this from ath9k_htc point of view?
>
> Pretty sure ath9k_htc devices do rate control in the firmware. Certainly
> ath9k_htc sets the HAS_RATE_CONTROL flag in mac80211, and the only calls
> to ath_set_rates are from within xmit.c, which is not used by ath9k_htc.
> So I think we're fine as far as that is concerned...

Very good, thanks for checking.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
