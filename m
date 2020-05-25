Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43DA1E0DDB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 13:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390338AbgEYLx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 07:53:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:22924 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390337AbgEYLx1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 07:53:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590407606; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=iZXdIaBh5TLhJdwzVECG/eXlN+wXGrPum4hi8Npf0e4=; b=DLB7RD9cXrYXaDV1mQ0Vr1GpIaLtqKSTMvsmrtW983GGPkpUBjOPNj97unUJFjcKAiUrLUbi
 p1qaWEicQPAtFEg/6LTT3HEdCgo9+OGXtJDZIZnZq1w1y0ocS5qgkYKGuH0WNwbY2cPBlnD0
 cVbQsHMkgrGycb3Y7eKh8qHFPX4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ecbb1ac2a41f3ed0014f544 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 May 2020 11:53:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1BAB2C433CA; Mon, 25 May 2020 11:53:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D8BCC433C6;
        Mon, 25 May 2020 11:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D8BCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Josh Boyer <jwboyer@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org,
        Linux Firmware <linux-firmware@kernel.org>
Subject: Re: [PATCH] ath10k: add SDIO firmware for QCA9377 WiFi
References: <20200524135933.1623-1-christianshewitt@gmail.com>
        <CA+5PVA5K0naJRhBvmDmArkBWQBCuA6p2yP+pYPMr3dZ47q53aQ@mail.gmail.com>
        <37BB0344-C9EB-41F5-87E7-D66DA45A488E@gmail.com>
Date:   Mon, 25 May 2020 14:53:10 +0300
In-Reply-To: <37BB0344-C9EB-41F5-87E7-D66DA45A488E@gmail.com> (Christian
        Hewitt's message of "Mon, 25 May 2020 09:09:35 +0400")
Message-ID: <871rn89qop.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

>> On 24 May 2020, at 8:34 pm, Josh Boyer <jwboyer@kernel.org> wrote:
>>=20
>> On Sun, May 24, 2020 at 9:59 AM Christian Hewitt
>> <christianshewitt@gmail.com> wrote:
>>>=20
>>> This commit adds the SDIO firmware for ath10k/QCA9377 cards. The file
>>> is from the Boundary Devices repo [1] and has the same license as the
>>> existing firmware-5.bin file. Support for QCA9377 WiFi was merged for
>>> Linux 5.7 [2].
>>>=20
>>> [1] https://github.com/boundarydevices/qca-firmware/tree/bd-sdmac-ath10k
>>> [2]
>>> https://github.com/torvalds/linux/commit/6e51b0e4913ca2c93059f73ca477ca=
30ea95b6a0
>>=20
>> That repo got it from Kalle's untested repo, and didn't carry over the
>> Signed-off-by.  You didn't carry over the Signed-off-by from the repo
>> you got it from.  3 levels of indirection to include a file with a
>> giant notice from an untested sources is a bit too much for me to feel
>> comfortable with.
>
> Apologies Josh, I have been using my own repack of the Boundary Devices
> repo and had completely forgotten Kalle=E2=80=99s repo existed and was the
> original source of the file.
>
>> Kalle, is there a reason you didn't send this upstream 3 years ago?
>
> SDIO support is a relatively recent addition to the ath10k driver and
> the commit message in this RFT [1] probably explains why his repo has
> it described as untested.
>
> I=E2=80=99m happy to submit v2 with corrected references or let Kalle han=
dle
> the submission, whichever is best or easiest is fine with me.

I'll include the QCA9377 SDIO image in my next pull request to Josh.
I'll also have QCA6174 SDIO images pending.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
