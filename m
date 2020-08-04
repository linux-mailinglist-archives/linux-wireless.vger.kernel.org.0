Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D07523B973
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Aug 2020 13:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgHDLUS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Aug 2020 07:20:18 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:27563 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730146AbgHDLUS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Aug 2020 07:20:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596540017; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=sOSy7S2Xoh60VSsSjtdd7bDzPGKVLRNDNAsA1OJDPgk=; b=Y9BGWbz/qVmPKvDUV+FpTLed6RZYQGPMTggsjoIeTYsekbbgA+JAaF6KRUzqzC7DXcjMZJZy
 F29e7nJ1D+ESrAxOfcs2VgaWxxLnWf0tG4OkozMIWtJ2kRYFtxnlhHCMeQX1i0f+YQI2S+ew
 5K4RCWb9yqLeH2PxuZY+prJa1+s=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f2941d18ecb2754f9f51df4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 11:09:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB3E7C43391; Tue,  4 Aug 2020 11:09:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE364C433C9;
        Tue,  4 Aug 2020 11:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE364C433C9
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
Date:   Tue, 04 Aug 2020 14:08:59 +0300
In-Reply-To: <f0910f96-1d23-daf1-b517-363e59bff105@gmail.com> (Dmitry
        Osipenko's message of "Mon, 3 Aug 2020 19:27:41 +0300")
Message-ID: <875z9yr7lg.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Osipenko <digetx@gmail.com> writes:

> 10.06.2020 18:21, Chi-Hsien Lin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> From: Amar Shankar <amsr@cypress.com>
>>=20
>> It is observed that sometimes when sdiod is low in tx credits in low
>> rssi scenarios, the data path consumes all sdiod rx all credits and
>> there is no sdiod rx credit available for control path causing host
>> and card to go out of sync resulting in link loss between host and
>> card. So in order to prevent it some credits are reserved for control
>> path.
>>=20
>> Note that TXCTL_CREDITS can't be larger than the firmware default
>> credit update threshold 2; otherwise there will be a deadlock for both
>> side waiting for each other.
>>=20
>> Signed-off-by: Amar Shankar <amsr@cypress.com>
>> Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>

[...]

> This patch causes a severe WiFi performance regression on BCM4329.
> Please fix or revert this patch, thanks in advance.
>
> Before this patch:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  17.2 MBytes  14.4 Mbits/sec    0             sen=
der
> [  5]   0.00-10.04  sec  16.9 MBytes  14.1 Mbits/sec
> receiver
>
>
> After this patch:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  1.05 MBytes   881 Kbits/sec    3             sen=
der
> [  5]   0.00-14.01  sec   959 KBytes   561 Kbits/sec
> receiver

Can someone please send a revert patch (with the explanation above) if a
fix is not quickly found? The commit id is:

commit b41c232d33666191a1db11befc0f040fcbe664e9
Author:     Amar Shankar <amsr@cypress.com>
AuthorDate: Wed Jun 10 10:21:03 2020 -0500
Commit:     Kalle Valo <kvalo@codeaurora.org>
CommitDate: Tue Jul 14 12:46:43 2020 +0300

    brcmfmac: reserve 2 credits for host tx control path

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
