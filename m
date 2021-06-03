Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8886C399E01
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFCJr6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 05:47:58 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24926 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCJr5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 05:47:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622713573; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=RWtLvLidpPamb4dlK5e/Mfjt23fvsVFCcB3loo+yQwM=; b=V7gF/LD/UaYPewKNEWsae0RnP5ezokbA7m5f5QV1f3IENMS9WeR3R16QzY04a9NieYuYD7gW
 +5arhtTq+/w+SqTt2mMc2pXaO4nzrheDKWEYwjXtjKqqu505AdGj5JYU5/NGIaLDoRl+Yz71
 w+Hexq3Y4fH2HhBwnya348OAzxg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60b8a4dc81efe91cda8bd767 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 09:46:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DE112C43460; Thu,  3 Jun 2021 09:46:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD124C433F1;
        Thu,  3 Jun 2021 09:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD124C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] wireless: carl9170: fix LEDS build errors & warnings
References: <20210530031134.23274-1-rdunlap@infradead.org>
        <8043ff50-d592-7666-f001-7505efa0d4c2@gmail.com>
        <c49c07d5-1d6e-5b99-30b4-bc8f48b0fde3@infradead.org>
Date:   Thu, 03 Jun 2021 12:46:00 +0300
In-Reply-To: <c49c07d5-1d6e-5b99-30b4-bc8f48b0fde3@infradead.org> (Randy
        Dunlap's message of "Sun, 30 May 2021 07:32:07 -0700")
Message-ID: <87czt31dt3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 5/30/21 2:31 AM, Christian Lamparter wrote:
>> On 30/05/2021 05:11, Randy Dunlap wrote:
>>> kernel test robot reports over 200 build errors and warnings
>>> that are due to this Kconfig problem when CARL9170=3Dm,
>>> MAC80211=3Dy, and LEDS_CLASS=3Dm.
>>>
>>> WARNING: unmet direct dependencies detected for MAC80211_LEDS
>>> =C2=A0=C2=A0 Depends on [n]: NET [=3Dy] && WIRELESS [=3Dy] && MAC80211 =
[=3Dy] &&
>>> (LEDS_CLASS [=3Dm]=3Dy || LEDS_CLASS [=3Dm]=3DMAC80211 [=3Dy])
>>> =C2=A0=C2=A0 Selected by [m]:
>>> =C2=A0=C2=A0 - CARL9170_LEDS [=3Dy] && NETDEVICES [=3Dy] && WLAN [=3Dy]=
 &&
>>> WLAN_VENDOR_ATH [=3Dy] && CARL9170 [=3Dm]
>>>
>>> CARL9170_LEDS selects MAC80211_LEDS even though its kconfig
>>> dependencies are not met. This happens because 'select' does not follow
>>> any Kconfig dependency chains.
>>>
>>> Fix this by making CARL9170_LEDS depend on MAC80211_LEDS, where
>>> the latter supplies any needed dependencies on LEDS_CLASS.
>>=20
>> Ok, this is not what I was expecting... I though you would just
>> add a "depends on / imply MAC80211_LEDS" on your v2. (this was
>> based on the assumption of what mac80211,=C2=A0 ath9k/_htc and mt76
>> solutions of the same problem looked like).
>
> Do you want the user choice/prompt removed, like MT76 is?
>
>> But since (I assuming here) this patch passed the build-bots
>> testing with flying colors in the different config permutations.
>
> It hasn't passed any build-bots testing that I know of.
> I did 8 combinations of kconfigs (well, 2 of them were invalid),
> but they all passed my own build testing.

So is this ok to take now? Or will there be v4?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
