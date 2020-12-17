Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA252DD4F2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 17:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgLQQH1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 11:07:27 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:29511 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgLQQH1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 11:07:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608221223; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=QAEgX2Wvaq+oBIXDEcZp5ABlmZruy4PcNZJC3K3tuKk=; b=bXzsv6/bm6gc7hPHQRPguAeZQhjFG8iKS+mFKRkpCtH+rxFRDKcIduNsRSN+HegXJJQAsFf4
 yitTXgEhMK5vgt/VHzD6wsthuJvlTzBPkh4+MZNhWv+TrkzZ3WreM0uhGWCEQfFwphgWDq5f
 71T4zJBsuIkMoEkSaRhSCsHGAAo=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fdb82087549779c5b324474 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 16:06:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B300EC433CA; Thu, 17 Dec 2020 16:06:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 74770C433C6;
        Thu, 17 Dec 2020 16:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74770C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/5] ath: Use safer key clearing with key cache entries
References: <20201214172118.18100-2-jouni@codeaurora.org>
        <20201217065148.188F7C433ED@smtp.codeaurora.org>
        <20201217094059.zxyaiskfdypc7q47@pali>
Date:   Thu, 17 Dec 2020 18:06:27 +0200
In-Reply-To: <20201217094059.zxyaiskfdypc7q47@pali> ("Pali \=\?utf-8\?Q\?Roh\?\=
 \=\?utf-8\?Q\?\=C3\=A1r\=22's\?\= message of
        "Thu, 17 Dec 2020 10:40:59 +0100")
Message-ID: <871rfoto1o.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Thursday 17 December 2020 06:51:48 Kalle Valo wrote:
>> Jouni Malinen <jouni@codeaurora.org> wrote:
>>=20
>> > It is possible for there to be pending frames in TXQs with a reference
>> > to the key cache entry that is being deleted. If such a key cache entry
>> > is cleared, those pending frame in TXQ might get transmitted without
>> > proper encryption. It is safer to leave the previously used key into t=
he
>> > key cache in such cases. Instead, only clear the MAC address to prevent
>> > RX processing from using this key cache entry.
>> >=20
>> > This is needed in particularly in AP mode where the TXQs cannot be
>> > flushed on station disconnection. This change alone may not be able to
>> > address all cases where the key cache entry might get reused for other
>> > purposes immediately (the key cache entry should be released for reuse
>> > only once the TXQs do not have any remaining references to them), but
>> > this makes it less likely to get unprotected frames and the more
>> > complete changes may end up being significantly more complex.
>> >=20
>> > Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>=20
>> 5 patches applied to ath-next branch of ath.git, thanks.
>>=20
>> 56c5485c9e44 ath: Use safer key clearing with key cache entries
>> 73488cb2fa3b ath9k: Clear key cache explicitly on disabling hardware
>> d2d3e36498dd ath: Export ath_hw_keysetmac()
>> 144cd24dbc36 ath: Modify ath_key_delete() to not need full key entry
>> ca2848022c12 ath9k: Postpone key cache entry deletion for TXQ frames ref=
erence it
>
> Hello! Should not these patches be suitable for backporting into stable
> kernels (via CC: stable@ commit message line) as they are related to
> security issue CVE-2020-3702?

Yeah, but you were just a little late as I already applied them.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
