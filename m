Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3741A75A5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 10:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407094AbgDNIPm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 04:15:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47455 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407079AbgDNIPk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 04:15:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586852140; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=wBgcOHAFoeYWDQ1HyU/hHqVhtVaAPtrNB2ffJOIsrT0=; b=sBvokxflfBchVw5Wld2ryGMExDiykQtJ5bs70X0tSEQK2lmqV7nyifVC+8p4lD+sgOOts9vq
 MYfW+1sJN5iDRkMpn79FNm+hIx/iact4DF8fliBgUy27MBf+a7xYnEggHagsQNQkNuoDzhnt
 k39HSWpMs7RfCGVxnOZVaAiLa4U=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e957117.7ff1f55b0c00-smtp-out-n05;
 Tue, 14 Apr 2020 08:15:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C1F0EC432C2; Tue, 14 Apr 2020 08:15:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 150B5C433BA;
        Tue, 14 Apr 2020 08:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 150B5C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Nils =?utf-8?Q?ANDR=C3=89-CHANG?= <nils@nilsand.re>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update URL for wireless drivers
References: <20200412110724.6uaoqmjc3it73nzo@nixos>
Date:   Tue, 14 Apr 2020 11:15:13 +0300
In-Reply-To: <20200412110724.6uaoqmjc3it73nzo@nixos> ("Nils \=\?utf-8\?Q\?ANDR\?\=
 \=\?utf-8\?Q\?\=C3\=89-CHANG\=22's\?\=
        message of "Sun, 12 Apr 2020 12:07:24 +0100")
Message-ID: <87d08atre6.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nils ANDR=C3=89-CHANG <nils@nilsand.re> writes:

> Previously, http://wireless.kernel.org would redirect to
> https://wireless.wiki.kernel.org, however, this is no longer the case
> and most pages return 404.
>
> https is used because http://wireless.kernel.org/* redirects to
> https://wireless.wiki.kernel.org/*
>
> Signed-off-by: Nils ANDR=C3=89-CHANG <nils@nilsand.re>

I'll queue this to v5.7.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
