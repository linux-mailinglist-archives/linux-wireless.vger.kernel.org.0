Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B84109F9
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEAPXq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 11:23:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfEAPXq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 11:23:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 48CF960FEE; Wed,  1 May 2019 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556724225;
        bh=l2WhRhZLGZQr9Ns7eemuc2avdXN2BMxD2MBmuagdNsU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fwE9o9feaga+FkHStTK0h1Bf2vqOqoVhFfTnS54r60rYo0FdDBRffdTl8rh1FtaqL
         D8EVYMka0Lz+YDLV+c4PGN4uzsOPGih182M/ZUQOgdSMfnH9Sbkk8xVAAgLIJNLmSP
         od0P6+9m4R+dpIGZnq1FOfPwP6wDquK0/2O1JvXA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2E6460F37;
        Wed,  1 May 2019 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556724224;
        bh=l2WhRhZLGZQr9Ns7eemuc2avdXN2BMxD2MBmuagdNsU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Yc8AOimvyNaUDbgUtNeGJBH3sOY3tMtcFRApMtdrezyQrwILXBbfOpldMGKj9NT3r
         k3lFwnO49McALXtMEyJwNzQfZrsZWODnKQX7tBmxtFmbXCUsbzGoKTbxH6NLypYWs1
         Om2xQYOkGoome5Y338TyF3QB8ZLqUXvH/v9mtaio=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2E6460F37
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] brcmfmac: change the order of things in brcmf_detach()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1556532561-24428-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1556532561-24428-1-git-send-email-arend.vanspriel@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Piotr Figiel <p.figiel@camlintechnologies.com>,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190501152345.48CF960FEE@smtp.codeaurora.org>
Date:   Wed,  1 May 2019 15:23:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> When brcmf_detach() from the bus layer upon rmmod we can no longer
> communicate. Hence we will set the bus state to DOWN and cleanup
> the event and protocol layer. The network interfaces need to be
> deleted before brcmf_cfg80211_detach() because the latter does the
> wiphy_unregister() which issues a warning if there are still network
> devices linked to the wiphy instance.
> 
> This change solves a null pointer dereference issue which happened
> upon issueing rmmod while there are packets queued in bus protocol
> layer.
> 
> Reported-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Marked RFC as requested, please resend once this is ready to be applied.

Patch set to RFC.

-- 
https://patchwork.kernel.org/patch/10922029/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

