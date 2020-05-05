Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5671C4EF8
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 09:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgEEHUp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 03:20:45 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:10095 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgEEHUp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 03:20:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588663244; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=4tVSyA7IB/nwrWeudUFNUuH8nGb3um2hmk4NZo88Bm4=; b=ErBzN/10isVr4BYqbkfmje7E5dO4XwRaX/jmRZEBr0nyjpLRMDAYfWj149+fQK/THQg+qIWs
 rUn9yCV8JjB3u6vSDvIWTI1ZCksvhglmunrSxWd4wIb24NHsNrsE7TOccINSeP+xxA3FY/Vu
 o3Tn6tOMNxRhkRxcYv4g9S9J43U=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb113ba.7f7372c4b0a0-smtp-out-n03;
 Tue, 05 May 2020 07:20:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4DF4AC433CB; Tue,  5 May 2020 07:20:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D3EEC433CB;
        Tue,  5 May 2020 07:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D3EEC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Frank =?utf-8?Q?Sch=C3=A4fer?= <fschaefer.oss@googlemail.com>
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] carl9170: remove P2P_GO support
References: <20200425092811.9494-1-chunkeey@gmail.com>
        <5ebf8e6d-d34b-aa92-d166-d8a5ca0b2c18@googlemail.com>
Date:   Tue, 05 May 2020 10:20:20 +0300
In-Reply-To: <5ebf8e6d-d34b-aa92-d166-d8a5ca0b2c18@googlemail.com> ("Frank
        \=\?utf-8\?Q\?Sch\=C3\=A4fer\=22's\?\= message of "Sun, 26 Apr 2020 12:33:13 +0200")
Message-ID: <87368ej1aj.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Frank Sch=C3=A4fer <fschaefer.oss@googlemail.com> writes:

> Hi Christian,
>
> Am 25.04.20 um 11:28 schrieb Christian Lamparter:
>> This patch follows up on a bug-report by Frank Sch=C3=A4fer that
>> discovered P2P GO wasn't working with wpa_supplicant.
>> This patch removes part of the broken P2P GO support but
>> keeps the vif switchover code in place.
>
> Hmm... no way to fix it ?
> P2P-GO seems to work fine with p2p_no_group_iface=3D1, so do you really
> think it's a good idea / required to remove the whole thing ?
>
>> Cc: <stable@vger.kernel.org>
>
> Are you sure about that ?
> People might be using it...

Christian, what should I do? Take the patch or drop it?

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
