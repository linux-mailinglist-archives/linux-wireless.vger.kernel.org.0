Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3723BECA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Aug 2020 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgHDRWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Aug 2020 13:22:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31539 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbgHDRWb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Aug 2020 13:22:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596561750; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=plz9O6sMktxbjyWmvCuOhJKeXhNSBZo6yJ5N1Nc0p7I=; b=A4WPVex8+eGnKejWynuiUXsIeySVei8cOlNLrTk53Pz5Vo1JrPmros5vKznp31mRVjM67TFw
 cBDno+McQok0RRRJxHsz+rj5l2OxoSbES9EKJO+00FmshA2bmAGqktcZJdXKAHjNCOoCexNZ
 IU+VCAm6O6OeQmlX9VJ9N3Geg7s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f29995514acd1952b393cb0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 17:22:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BD562C43391; Tue,  4 Aug 2020 17:22:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F3BDC433C6;
        Tue,  4 Aug 2020 17:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F3BDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
Subject: Re: [PATCH V2 3/6] brcmfmac: reserve 2 credits for host tx control path
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
        <20200610152106.175257-4-chi-hsien.lin@cypress.com>
        <f0910f96-1d23-daf1-b517-363e59bff105@gmail.com>
        <875z9yr7lg.fsf@codeaurora.org>
        <ffcf55cc-b27d-78ec-ff4f-e7efa3087712@gmail.com>
Date:   Tue, 04 Aug 2020 20:22:22 +0300
In-Reply-To: <ffcf55cc-b27d-78ec-ff4f-e7efa3087712@gmail.com> (Dmitry
        Osipenko's message of "Tue, 4 Aug 2020 18:53:20 +0300")
Message-ID: <87a6zapbqp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Osipenko <digetx@gmail.com> writes:

> 04.08.2020 14:08, Kalle Valo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Dmitry Osipenko <digetx@gmail.com> writes:
>>=20
>>> 10.06.2020 18:21, Chi-Hsien Lin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> From: Amar Shankar <amsr@cypress.com>
>>>>
>>>> It is observed that sometimes when sdiod is low in tx credits in low
>>>> rssi scenarios, the data path consumes all sdiod rx all credits and
>>>> there is no sdiod rx credit available for control path causing host
>>>> and card to go out of sync resulting in link loss between host and
>>>> card. So in order to prevent it some credits are reserved for control
>>>> path.
>>>>
>>>> Note that TXCTL_CREDITS can't be larger than the firmware default
>>>> credit update threshold 2; otherwise there will be a deadlock for both
>>>> side waiting for each other.
>>>>
>>>> Signed-off-by: Amar Shankar <amsr@cypress.com>
>>>> Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
>>>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
>>=20
>> [...]
>>=20
>>> This patch causes a severe WiFi performance regression on BCM4329.
>>> Please fix or revert this patch, thanks in advance.
>>>
>>> Before this patch:
>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>> [ ID] Interval           Transfer     Bitrate         Retr
>>> [  5]   0.00-10.00  sec  17.2 MBytes  14.4 Mbits/sec    0             s=
ender
>>> [  5]   0.00-10.04  sec  16.9 MBytes  14.1 Mbits/sec
>>> receiver
>>>
>>>
>>> After this patch:
>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>> [ ID] Interval           Transfer     Bitrate         Retr
>>> [  5]   0.00-10.00  sec  1.05 MBytes   881 Kbits/sec    3             s=
ender
>>> [  5]   0.00-14.01  sec   959 KBytes   561 Kbits/sec
>>> receiver
>>=20
>> Can someone please send a revert patch (with the explanation above) if a
>> fix is not quickly found? The commit id is:
>>=20
>> commit b41c232d33666191a1db11befc0f040fcbe664e9
>> Author:     Amar Shankar <amsr@cypress.com>
>> AuthorDate: Wed Jun 10 10:21:03 2020 -0500
>> Commit:     Kalle Valo <kvalo@codeaurora.org>
>> CommitDate: Tue Jul 14 12:46:43 2020 +0300
>>=20
>>     brcmfmac: reserve 2 credits for host tx control path
>>=20
>
> Hello Kalle,
>
> I'll send the revert if nobody will stand up to address the problem in a
> two weeks, thanks.

Thanks. Then I should be able to get the revert to v5.9 so that the
release won't be broken. (v5.8 is unaffected)

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
