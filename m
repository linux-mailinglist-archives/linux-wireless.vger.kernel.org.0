Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E61F5228D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 07:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfFYFHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 01:07:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39940 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFYFHg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 01:07:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CACC16085C; Tue, 25 Jun 2019 05:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561439255;
        bh=Egj3t8C7HouFx+6HG4W2JU32zdWh1NGPFjK0kmlPsBk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Dw5MGcUUQLmVL2SqVcOd6oc64F6cQ7uVFEIgRmk0vB30iCm4gHIJmtMf6Kh8D0XHx
         ZmdLp7A0aNSnpU8wUbevb6zBGN+nVc0R+Vol3wHxmaSElW/MlKHiD8RcBFnx1igbnC
         kR+UcdRoXg5VLQ6+07DqJ4Y/ghP0xiupLh8MPZA8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 482DB601E7;
        Tue, 25 Jun 2019 05:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561439255;
        bh=Egj3t8C7HouFx+6HG4W2JU32zdWh1NGPFjK0kmlPsBk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Dw5MGcUUQLmVL2SqVcOd6oc64F6cQ7uVFEIgRmk0vB30iCm4gHIJmtMf6Kh8D0XHx
         ZmdLp7A0aNSnpU8wUbevb6zBGN+nVc0R+Vol3wHxmaSElW/MlKHiD8RcBFnx1igbnC
         kR+UcdRoXg5VLQ6+07DqJ4Y/ghP0xiupLh8MPZA8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 482DB601E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>
Cc:     H Buus <ubuntu@hbuus.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ssb/gpio: Remove unnecessary WARN_ON from driver_gpio
References: <946c86bf-7e90-a981-b9fc-757adb98adfa@hbuus.com>
        <20190610204927.2de21c9a@wiggum>
Date:   Tue, 25 Jun 2019 08:07:31 +0300
In-Reply-To: <20190610204927.2de21c9a@wiggum> ("Michael \=\?utf-8\?Q\?B\=C3\=BCs\?\=
 \=\?utf-8\?Q\?ch\=22's\?\= message of
        "Mon, 10 Jun 2019 20:49:27 +0200")
Message-ID: <87v9wus164.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Michael B=C3=BCsch <m@bues.ch> writes:

> The WARN_ON triggers on older BCM4401-B0 100Base-TX ethernet controllers.
> The warning serves no purpose. So let's just remove it.
>
> Reported-by: H Buus <ubuntu@hbuus.com>
> Signed-off-by: Michael B=C3=BCsch <m@bues.ch>

For some reason patchwork (or pwcli script) didn't like this patch so
manually applied to wireless-drivers-next:

e73e43246da6 ssb/gpio: Remove unnecessary WARN_ON from driver_gpio

I have a faint recollection that I had a similar problem with another
patch from Michael, did we ever conclude what was the issue?

--=20
Kalle Valo
