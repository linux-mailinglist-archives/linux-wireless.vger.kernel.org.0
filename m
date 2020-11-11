Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9742AEC21
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 09:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKKIhy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 03:37:54 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:43899 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgKKIhy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 03:37:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605083873; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=o8nH4OT3yGZqG4GIHA3injM4LW0PCFEkAK1OE29Ord0=; b=fgTaHvNzH0cDGFfwC/MEQqR8F1GYC5/jjE2qdbK6szcYf5BOa1ghwelBUs1zwZhMAqYGF520
 RB9YCmPweUQaTx3w50krQGt4xEVFGF3iW6PPDSsjyA1Tm7NGaI0ghkCWVZblB2CtEKLW0BhJ
 ZrV30U5fgL2pgVkS8EglethcdHM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5faba2e10d87d6377558c695 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 08:37:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D2B5C433C9; Wed, 11 Nov 2020 08:37:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8853CC433C6;
        Wed, 11 Nov 2020 08:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8853CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 08/11] rtw88: coex: fix BT performance drop during initial/power-on step
References: <20201111022108.9834-1-pkshih@realtek.com>
        <20201111022108.9834-9-pkshih@realtek.com>
Date:   Wed, 11 Nov 2020 10:37:48 +0200
In-Reply-To: <20201111022108.9834-9-pkshih@realtek.com> (pkshih@realtek.com's
        message of "Wed, 11 Nov 2020 10:21:05 +0800")
Message-ID: <87wnysb86b.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> writes:

> From: Ching-Te Ku <ku920601@realtek.com>
>
> Force set the coexistence to BT high priority during
> WLAN initial/power-on step. Since the duration the related setting
> may be not ready yet.
>
> The score board is not related to scan when initialing, remove the scan
> parameter.
>
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/coex.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/coT=C3=94=C3=88 b/driver=
s/net/wireless/realtek/rtw88/coex.c8Ilex.cc7216245557..6ec3f45a64c1 100644

Something is wrong here, the new lines are replaced with '^H' control
character.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
