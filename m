Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF310BC16A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 07:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438541AbfIXFaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 01:30:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438519AbfIXFaY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 01:30:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA98C602F0; Tue, 24 Sep 2019 05:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569303023;
        bh=SKpoTL5qdqpCZE8jfMpeNULCFOVTf1yiWa2F+YGyiUY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=i3ZY2OYdN2lGQe+y7MbsWqxJOYxpD0Ec7VitiyHqBIquXU/qK2wNGgUI6nAbehWVB
         NT80mtpExC9mph25W5QYL5vF+AJoUCoTtraD+lWUtAgkHPWrV9rjMhnlG2gfZsBzbu
         d+0509hQHGcuv3BAtAcFNk56bfcb9XVsHJDcs4yw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 416EE60240;
        Tue, 24 Sep 2019 05:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569303023;
        bh=SKpoTL5qdqpCZE8jfMpeNULCFOVTf1yiWa2F+YGyiUY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=i3ZY2OYdN2lGQe+y7MbsWqxJOYxpD0Ec7VitiyHqBIquXU/qK2wNGgUI6nAbehWVB
         NT80mtpExC9mph25W5QYL5vF+AJoUCoTtraD+lWUtAgkHPWrV9rjMhnlG2gfZsBzbu
         d+0509hQHGcuv3BAtAcFNk56bfcb9XVsHJDcs4yw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 416EE60240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH 5/5] ath10k: pull_svc_rdy code-style fix
References: <1569268165-1639-1-git-send-email-pozega.tomislav@gmail.com>
        <1569268165-1639-5-git-send-email-pozega.tomislav@gmail.com>
Date:   Tue, 24 Sep 2019 08:30:19 +0300
In-Reply-To: <1569268165-1639-5-git-send-email-pozega.tomislav@gmail.com>
        ("Tomislav \=\?utf-8\?Q\?Po\=C5\=BEega\=22's\?\= message of "Mon, 23 Sep 2019
 21:49:25 +0200")
Message-ID: <87d0fq5kic.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tomislav Po=C5=BEega <pozega.tomislav@gmail.com> writes:

> Drop unneeded lines by moving skb data in both main and 10x WMI
> pull service ready event operations.
>
> Signed-off-by: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/wmi.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless=
/ath/ath10k/wmi.c
> index 59d2d2a..8ab178c 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -5345,13 +5345,12 @@ static int ath10k_wmi_alloc_host_mem(struct ath10=
k *ar, u32 req_id,
>  ath10k_wmi_main_op_pull_svc_rdy_ev(struct ath10k *ar, struct sk_buff *sk=
b,
>  				   struct wmi_svc_rdy_ev_arg *arg)
>  {
> -	struct wmi_service_ready_event *ev;
> +	struct wmi_service_ready_event *ev =3D (void *)skb->data;
>  	size_t i, n;
>=20=20
>  	if (skb->len < sizeof(*ev))
>  		return -EPROTO;
>=20=20
> -	ev =3D (void *)skb->data;

Actually I prefer the original style, so that we first check the data in
skb is valid and only then assign the data to ev.

--=20
Kalle Valo
