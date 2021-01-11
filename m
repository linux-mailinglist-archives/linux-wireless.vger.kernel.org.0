Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029F82F0D92
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 09:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbhAKIC6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 03:02:58 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:37788 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKIC6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 03:02:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610352173; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=1iw03Ns/mj/ZSsS4CWXIUmJ/IN+zDD57ZvgUH08bFuw=; b=fusjQMNmvEPz/MarKl6ToUURZZZmlKu66DMaNzmrMajmimuWQ9oMVmmiR4bO1v4xxaXxZ2Yy
 SrHaYExtd5wdA7qYZUbZwNOKjmnLggNfP46uA7wOHDHsIc7yUugmUFvcvB2iSdQ2q3GviWfT
 0C0go6SEVAJR0KqRFHcSWKSZ+Ww=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5ffc05f08fb3cda82fcdc284 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 08:01:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AFF4BC433CA; Mon, 11 Jan 2021 08:01:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA594C433ED;
        Mon, 11 Jan 2021 08:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA594C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/5] ath: Use safer key clearing with key cache entries
References: <20201214172118.18100-2-jouni@codeaurora.org>
        <20201217065148.188F7C433ED@smtp.codeaurora.org>
        <20201217094059.zxyaiskfdypc7q47@pali> <871rfoto1o.fsf@codeaurora.org>
        <20201228213553.rsc5ahiiqrb5lel2@pali>
Date:   Mon, 11 Jan 2021 10:01:47 +0200
In-Reply-To: <20201228213553.rsc5ahiiqrb5lel2@pali> ("Pali \=\?utf-8\?Q\?Roh\?\=
 \=\?utf-8\?Q\?\=C3\=A1r\=22's\?\= message of
        "Mon, 28 Dec 2020 22:35:53 +0100")
Message-ID: <87o8hvlx5g.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Thursday 17 December 2020 18:06:27 Kalle Valo wrote:
>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>>=20
>> > On Thursday 17 December 2020 06:51:48 Kalle Valo wrote:
>> >> Jouni Malinen <jouni@codeaurora.org> wrote:
>> >>=20
>> >> > It is possible for there to be pending frames in TXQs with a refere=
nce
>> >> > to the key cache entry that is being deleted. If such a key cache e=
ntry
>> >> > is cleared, those pending frame in TXQ might get transmitted without
>> >> > proper encryption. It is safer to leave the previously used key int=
o the
>> >> > key cache in such cases. Instead, only clear the MAC address to pre=
vent
>> >> > RX processing from using this key cache entry.
>> >> >=20
>> >> > This is needed in particularly in AP mode where the TXQs cannot be
>> >> > flushed on station disconnection. This change alone may not be able=
 to
>> >> > address all cases where the key cache entry might get reused for ot=
her
>> >> > purposes immediately (the key cache entry should be released for re=
use
>> >> > only once the TXQs do not have any remaining references to them), b=
ut
>> >> > this makes it less likely to get unprotected frames and the more
>> >> > complete changes may end up being significantly more complex.
>> >> >=20
>> >> > Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>> >> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>> >>=20
>> >> 5 patches applied to ath-next branch of ath.git, thanks.
>> >>=20
>> >> 56c5485c9e44 ath: Use safer key clearing with key cache entries
>> >> 73488cb2fa3b ath9k: Clear key cache explicitly on disabling hardware
>> >> d2d3e36498dd ath: Export ath_hw_keysetmac()
>> >> 144cd24dbc36 ath: Modify ath_key_delete() to not need full key entry
>> >> ca2848022c12 ath9k: Postpone key cache entry deletion for TXQ frames =
reference it
>> >
>> > Hello! Should not these patches be suitable for backporting into stable
>> > kernels (via CC: stable@ commit message line) as they are related to
>> > security issue CVE-2020-3702?
>>=20
>> Yeah, but you were just a little late as I already applied them.
>
> Ok, would you then send these patches to stable manually?

Sorry, I have too many patches in queue to do that. But I don't think I
need to submit them, my understanding is that anyone can submit patches
to stable.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
