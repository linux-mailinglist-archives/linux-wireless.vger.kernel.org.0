Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2988E43E044
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 13:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhJ1Lzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 07:55:41 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14457 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhJ1Lzk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 07:55:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635421993; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=ld1f+aqBTT8aE5Ulu7PhU13nMnfkgomOhhW3itU1TBY=; b=VtuDLRDkquL/JVThFQtJoC1B69dOq0i9QBIRVm3qvYJho0MD55BVv5STqWJaTTZ17wyIn5/e
 mPJndt7jfz/dpjwxXKMD3/CKgpvpZmsEhBsdlPz6Frnao/aWRQagAkyVTRTgVBrqVmY4qk3a
 EaJyvQVzhis3rds0SdlCRxq0Ono=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 617a8f1cf6a3eeacf99ece70 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Oct 2021 11:53:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CEB24C4360D; Thu, 28 Oct 2021 11:52:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48775C4338F;
        Thu, 28 Oct 2021 11:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 48775C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Ansuel Smith <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2] ath10k: fetch (pre-)calibration data via nvmem subsystem
References: <20211016234609.1568317-1-chunkeey@gmail.com>
        <87ee855xwa.fsf@codeaurora.org>
        <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com>
Date:   Thu, 28 Oct 2021 14:52:56 +0300
In-Reply-To: <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com> (Christian
        Lamparter's message of "Thu, 28 Oct 2021 13:31:02 +0200")
Message-ID: <875yth5pt3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> On 28/10/2021 10:58, Kalle Valo wrote:
>> Christian Lamparter <chunkeey@gmail.com> writes:
>>
>>> ATH10K chips are used it wide range of routers,
>>> accesspoints, range extenders, network appliances.
>>> On these embedded devices, calibration data is often
>>> stored on the main system's flash and was out of reach
>>> for the driver.
>>>
>>> To bridge this gap, ath10k is getting extended to pull
>>> the (pre-)calibration data through nvmem subsystem.
>>> To do this, a nvmem-cell containing the information can
>>> either be specified in the platform data or via device-tree.
>>>
>>> Tested with:
>>>          Netgear EX6150v2 (IPQ4018 - pre-calibration method)
>>>          TP-Link Archer C7 v2 (QCA9880v2 - old calibration method)
>>>
>>> Cc: Robert Marko <robimarko@gmail.com>
>>> Cc: Thibaut VAR=C3=88NE <hacks@slashdirt.org>
>>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>>> ---
>>>
>>> v1 -> v2:
>>> 	- use %zu and %u in the format string for size_t
>>>            and u32 types (catched by the "kernel test robot").
>>> 	- reworded commit message + successfully tested on QCA9880v2
>>>
>>> I placed the nvmem code in front of the current "file" method
>>> (firmware_request). Reason is that this makes it easier for me
>>> to test it. If needed it can be moved to a different place.
>>
>> Looks good to me. Before I apply this, I want to mention to that I have
>> had a long in my deferred queue related two patchsets:
>
>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515=
.86-1-ansuelsmth@gmail.com/
>> https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515=
.86-2-ansuelsmth@gmail.com/
>
> Oh ok, serves me right for not looking thoroughly googling this first.
> Alban Bedel and Ansuel's work made this nvmem all possible. And indeed,
> the second patch here looks eerie similar.
>
> Do you want to go with his two patches instead?

I would prefer to take your patch.

> I'll change mine, so it just consists of the cal_mode for the older
> QCA9880v2,QCA9887 and add the -EPROBE_DEFER handling. This
> -EPROBE_DEFER only ever comes up with the Meraki gear. This is because
> Meraki likes putting the MACs-Values into SoC-connected AT24
> eeproms-chips. Everyone else just have them in a proper FLASH
> partition. Though, this's usually nothing more than adding the
> following line:
>
> if (ret =3D=3D -EPROBER_DEFER)
> 	return ret;

So I'll drop this version and wait for v3?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
