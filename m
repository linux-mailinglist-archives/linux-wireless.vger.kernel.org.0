Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAA112042B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 12:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLPLlO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 06:41:14 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:33930 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727276AbfLPLlO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 06:41:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576496473; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=Z30igGNUdrFHS9qpIwYJruR2OxAGXIzzkvS7S6WcmPU=; b=NwCzXezs1RZBu6MUPg+w5myDXgJEhJohqv7RahelhzgCtt1MZ2Ql6e+BRqxq8nwiw2HhmI3t
 bgHuUvHuWo05/IYBJ/Qh4TSw41cxfHoefJ1/J3FoSOxxUbA0TfXDxoBuPiciTK6kY1exUu53
 KQzbY52ko0PvjE0HXGgfMmKRCW4=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df76d56.7fc4b3d000a0-smtp-out-n01;
 Mon, 16 Dec 2019 11:41:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2FA32C43383; Mon, 16 Dec 2019 11:41:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FCA7C433CB;
        Mon, 16 Dec 2019 11:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FCA7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] mac80211: Turn AQL into an NL80211_EXT_FEATURE
References: <20191212111437.224294-1-toke@redhat.com>
Date:   Mon, 16 Dec 2019 13:41:06 +0200
In-Reply-To: <20191212111437.224294-1-toke@redhat.com> ("Toke
        \=\?utf-8\?Q\?H\=C3\=B8iland-J\=C3\=B8rgensen\=22's\?\= message of "Thu, 12 Dec 2019
 12:14:37 +0100")
Message-ID: <87fthk4hwt.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Instead of just having an airtime flag in debugfs, turn AQL into a proper
> NL80211_EXT_FEATURE, so drivers can turn it on when they are ready, and so
> we also expose the presence of the feature to userspace.
>
> This also has the effect of flipping the default, so drivers have to opt =
in
> to using AQL instead of getting it by default with TXQs. To keep
> functionality the same as pre-patch, we set this feature for ath10k (which
> is where it is needed the most).
>
> While we're at it, split out the debugfs interface so AQL gets its own
> per-station debugfs file instead of using the 'airtime' file.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
> v2:
>   - Squash into a single patch
>   - Add kernel doc for NL80211_EXT_FEATURE_AQL
>
>  drivers/net/wireless/ath/ath10k/mac.c |  1 +

Acked-by: Kalle Valo <kvalo@codeaurora.org>

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
