Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A461FA35
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfD3N1t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 09:27:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfD3NZe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 09:25:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E61960E7A; Tue, 30 Apr 2019 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556630733;
        bh=M3snicRDGK0OgZ0glnVBGEvcyeWdDYcxTrYt8Ih0giE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CbDqAxYkcXXDndzgQX2f+0/M45q6gzfle9tfE6/JPlzFqw4EAl8iLmpAht5K4qe+p
         UsesoEIng40GRg5AnenZK8y6C74AI0fUsqMHvhYw7zkuC2b16lDtCPuoYhiZk4apxF
         NvOp9DMqZMFMnp9fxdRafkHXQ9NxaqjO4hCo+Hnw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BD8B60E7A;
        Tue, 30 Apr 2019 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556630732;
        bh=M3snicRDGK0OgZ0glnVBGEvcyeWdDYcxTrYt8Ih0giE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NUPMuK42KZvdxWF23xKi96JWXVPM47gk3914upFoA87icTndiACol98DjDITiFyzd
         RF399SJ81EcX3vE0QW8qe9MOO3i/TMIs3/o6IS8fYAW1qRm8GtlsA5+t3yIxuHu9/8
         Z35/Ur/1Dgo333UogTAyvM620PFhE80Ne0oZUojY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BD8B60E7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: Re: [RFC/RFT 7/7] rt2800: do not enable watchdog by default
References: <1556535270-3551-1-git-send-email-sgruszka@redhat.com>
        <1556535270-3551-8-git-send-email-sgruszka@redhat.com>
Date:   Tue, 30 Apr 2019 16:25:29 +0300
In-Reply-To: <1556535270-3551-8-git-send-email-sgruszka@redhat.com> (Stanislaw
        Gruszka's message of "Mon, 29 Apr 2019 12:54:30 +0200")
Message-ID: <87o94nwrp2.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> Make watchdog disabled by default and add module parameter to enable it.
>
> User will have to create file in /etc/modprobe.d/ with
>
> options rt2800lib watchdog=1
>
> to enable the watchdog or load "rt2800lib watchdog=1" module manually
> before loading rt2800{soc,pci,usb} module.
>
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

[...]

> +static bool modparam_watchdog;
> +module_param_named(watchdog, modparam_watchdog, bool, S_IRUGO);
> +MODULE_PARM_DESC(watchdog, "Enable watchdog.");

You could describe a bit more what this watchdog does and that it's in
driver (or at least I assume so).

-- 
Kalle Valo
