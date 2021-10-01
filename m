Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C569941E7C7
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352322AbhJAGxp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 02:53:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25955 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231165AbhJAGxo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 02:53:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633071121; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=A560NsXHW6B8ujWoHcz5zvVrbSQFM2oKjGFFxzubltU=; b=OmeZaNN+jdNXiqRcy0H+QsoT4XtU1xkDozoDX41smwk3xIfzOgt9MvztxQEZjOKiSQ3/ly5d
 M+OieiIohMD1mVaSprc6Yp/LfzNrETQmb4H3jH9OHIm1Bo9crqmUtOLHVAPx86RvrQliDIeD
 DhiSfOTND0Gx0AVxtxLwyp0qVco=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6156b00c63b1f18658364da1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 06:51:56
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7349C43460; Fri,  1 Oct 2021 06:51:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A707DC4338F;
        Fri,  1 Oct 2021 06:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A707DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Petr Pisar <petr.pisar@atlas.cz>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: ath9 stopped transmitting multicast frames in Linux 5.14.0
References: <YTO5CYiGa/OV8tLY@album.bayer.uni.cx>
        <YU7Kp2KvbDj/fWgY@album.bayer.uni.cx>
Date:   Fri, 01 Oct 2021 09:51:51 +0300
In-Reply-To: <YU7Kp2KvbDj/fWgY@album.bayer.uni.cx> (Petr Pisar's message of
        "Sat, 25 Sep 2021 09:07:19 +0200")
Message-ID: <87h7e15jaw.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Petr Pisar <petr.pisar@atlas.cz> writes:

> V=C2=A0Sat, Sep 04, 2021 at 08:20:57PM +0200,=C2=A0Petr Pisar napsal(a):
>> Hello,
>>=20
>> after upgrading Linux from 5.13.13 to 5.14.0 on my router with this wire=
less
>> device:
>>=20
>> 03:00.0 Network controller [0280]: Qualcomm Atheros AR93xx Wireless Netw=
ork Adapter [168c:0030] (rev 01)
>>         Subsystem: Qualcomm Atheros AR93xx Wireless Network Adapter [168=
c:3116]
>>         Flags: bus master, fast devsel, latency 0, IRQ 18
>>         Memory at 81200000 (64-bit, non-prefetchable) [size=3D128K]
>>         Expansion ROM at 81220000 [disabled] [size=3D64K]
>>         Capabilities: [40] Power Management version 3
>>         Capabilities: [50] MSI: Enable- Count=3D1/4 Maskable+ 64bit+
>>         Capabilities: [70] Express Endpoint, MSI 00
>>         Capabilities: [100] Advanced Error Reporting
>>         Capabilities: [140] Virtual Channel
>>         Capabilities: [300] Device Serial Number 00-00-00-00-00-00-00-00
>>         Kernel driver in use: ath9k
>>         Kernel modules: ath9k
>>=20
>> which works as a WiFi accesspoint, I noticed that WiFi clients cannot us=
e IPv6
>> anymore. The problem is that the router cannot translate an IPv6 address=
 of
>> the client to a MAC address. The reason is that IPv6 multicast packets u=
sed by
>> ICMPv6 neighbour discovery protocol do not reach the clients. In other w=
ords
>> the ath9k-driven device stopped transmitting multicast frames.
>
> The same observation was reported here by Felix Fietkau in "[PATCH] Revert
> "mac80211: do not use low data rates for data frames with no ack flag""
> <https://marc.info/?l=3Dlinux-wireless&m=3D163091738109000&w=3D2> with a =
proposal to
> revert the offending d333322361e7a099dc74df2498d3fa5fde5c4fa7 commit.

Very good, thanks for the followup.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
