Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF823FAA14
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 10:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhH2IQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 04:16:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46894 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbhH2IQj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 04:16:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630224947; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=Cj4LI5NZUAbDL5bazBJ646LLcDUcOxCvYVg409hDueo=; b=kXzMMOFDclovzUfoTJY+SBhCwgMzOFPBG9og4d2Ox9jbL84iHy/waEYNqD3BwgxM6ZXwSfAe
 pIGROTAbx2alXhEp/mQbaM0Q8ww4U0LNw6+UJcPoL35OL+CX5K40LRvXvVWCqVK3FoNwqGea
 wGOvPtllq0Iy8Z1AoQokniFfSKc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 612b421e97222b4b5b57f76d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 08:15:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3609C4360D; Sun, 29 Aug 2021 08:15:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6801BC4338F;
        Sun, 29 Aug 2021 08:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6801BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org,
        Ugo =?utf-8?Q?R=C3=A9mery?= <ugo.remery@gmail.com>
Subject: Re: [PATCH v3] rtw88: add quirk to disable pci caps on HP Pavilion 14-ce0xxx
References: <20210822194932.29630-1-Larry.Finger@lwfinger.net>
Date:   Sun, 29 Aug 2021 11:15:19 +0300
In-Reply-To: <20210822194932.29630-1-Larry.Finger@lwfinger.net> (Larry
        Finger's message of "Sun, 22 Aug 2021 14:49:32 -0500")
Message-ID: <871r6c650o.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> From: Ugo R=C3=A9mery <ugo.remery@gmail.com>
>
>     8821CE causes random freezes on HP Pavilion 14-ce0019nf. Add a quirk
>     to disable pci ASPM capability.
>
> Signed-off-by: =3D?UTF-8?q?Ugo=3D20R=3DC3=3DA9mery?=3D <ugo.remery@gmail.=
com>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

I fixed the quoted printable before applying the patch.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
