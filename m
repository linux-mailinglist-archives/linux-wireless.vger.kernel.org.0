Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E1B2B5AE6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Nov 2020 09:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgKQIVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 03:21:54 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:54120 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgKQIVy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 03:21:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605601313; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=g9weXcI6E3CfpEmO9996TeFQpsnZE7Go1uOkqemh9Bk=; b=ACbggndhWZ6BBGXnL1tXu+CE+9eUfMlwkS80ep6lT6xh6Nz8j3ueGwWFoyqgyMLUnyiYS0xT
 8McXwLtaeTQQUfD0vvgaJU0xLsaMHTx5l+vuhlrYyR6Yb6O9uK0J1r249bo9AUG7G/0PiiWM
 a7+D3e6gPPGeYyn4jo4qbZwvlqI=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fb388168e090a888610cc6e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Nov 2020 08:21:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4813C433ED; Tue, 17 Nov 2020 08:21:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22EABC433C6;
        Tue, 17 Nov 2020 08:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22EABC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "xiakaixu1987\@gmail.com" <xiakaixu1987@gmail.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kaixuxia\@tencent.com" <kaixuxia@tencent.com>
Subject: Re: [PATCH] rtw88: coex: remove the unreached code in rtw_coex_set_tdma
References: <1605367343-11770-1-git-send-email-kaixuxia@tencent.com>
        <1605600696.20048.11.camel@realtek.com>
Date:   Tue, 17 Nov 2020 10:21:37 +0200
In-Reply-To: <1605600696.20048.11.camel@realtek.com> (pkshih@realtek.com's
        message of "Tue, 17 Nov 2020 08:12:40 +0000")
Message-ID: <87ft58z94e.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

> On Sat, 2020-11-14 at 15:22 +0000, xiakaixu1987@gmail.com wrote:
>> From: Kaixu Xia <kaixuxia@tencent.com>
>>=20
>> The value of the bool variable ap_enable is always false, so the first
>> if branch is unreached code. Remove it.
>>=20
>> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
>> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
>> ---
>> =C2=A0drivers/net/wireless/realtek/rtw88/coex.c | 12 +-----------
>> =C2=A01 file changed, 1 insertion(+), 11 deletions(-)
>>=20
>> diff --git a/drivers/net/wireless/realtek/rtw88/coex.c
>> b/drivers/net/wireless/realtek/rtw88/coex.c
>> index aa08fd7d9fcd..9c7963e45755 100644
>> --- a/drivers/net/wireless/realtek/rtw88/coex.c
>> +++ b/drivers/net/wireless/realtek/rtw88/coex.c
>> @@ -863,18 +863,8 @@ static void rtw_coex_set_tdma(struct rtw_dev *rtwde=
v, u8
>> byte1, u8 byte2,
>> =C2=A0	struct rtw_coex_dm *coex_dm =3D &coex->dm;
>> =C2=A0	struct rtw_chip_info *chip =3D rtwdev->chip;
>> =C2=A0	u8 ps_type =3D COEX_PS_WIFI_NATIVE;
>> -	bool ap_enable =3D false;
>
> The variable 'ap_enable' is used to indicate a vif is running in AP mode.
> At the first coex version, rtw88 doesn't support AP mode yet, so ap_enable
> is set to false. For now, AP mode is ready, and I can send a patch to set
> proper value depends on vif mode.
>
> Since I'm submitting coex patches to upgrade the code. In order to avoid
> conflicting, I'll send the patch to set proper ap_enable after all my pat=
ches
> are merged.

Ok, I'll then drop this.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
