Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4C1A75AC
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407113AbgDNIRS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 04:17:18 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45212 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407098AbgDNIRO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 04:17:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586852228; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=8A0tWiU6dYMr8UR9T26N9n+bF+KeHME879f3zAyz8Us=; b=CV2TjgUqku1KQ+7Yu0G5uCWVOO7Mo5aT/7dxno2qySmG4mDvAs4jikjtClgz27PLjq0Bd20+
 e5ARfxX0U6YiLWZDC8O5hhi7WrQXN7NPi+Zg4dFZ9XT41rCyFDIAzb3FvfiKo0TCCzdl82eF
 t2avEF+82YkpLYVNoyceW7AV7mM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e957178.7f0505dacc70-smtp-out-n05;
 Tue, 14 Apr 2020 08:16:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8126CC43636; Tue, 14 Apr 2020 08:16:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB3CBC433F2;
        Tue, 14 Apr 2020 08:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB3CBC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Nils =?utf-8?Q?ANDR=C3=89-CHANG?= <nils@nilsand.re>
Cc:     trivial@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] Formatting: remove leading space
References: <20200412171900.xzedxhzd56gox5kf@nixos>
Date:   Tue, 14 Apr 2020 11:16:52 +0300
In-Reply-To: <20200412171900.xzedxhzd56gox5kf@nixos> ("Nils \=\?utf-8\?Q\?ANDR\?\=
 \=\?utf-8\?Q\?\=C3\=89-CHANG\=22's\?\=
        message of "Sun, 12 Apr 2020 18:19:00 +0100")
Message-ID: <878siytrbf.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nils ANDR=C3=89-CHANG <nils@nilsand.re> writes:

> Signed-off-by: Nils ANDR=C3=89-CHANG <nils@nilsand.re>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The title should be:

brcmfmac: remove leading space

I can fix that during commit.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
