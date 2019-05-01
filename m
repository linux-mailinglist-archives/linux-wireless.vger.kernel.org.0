Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9961010A08
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 17:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEAP1u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 11:27:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfEAP1u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 11:27:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81ECE607DF; Wed,  1 May 2019 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556724469;
        bh=MJfC9RafauewWFrYRr9IYdRD10knT9RsO+zTvWruTP4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gVFqH88YHlCT7VDv4tKY8i4aaBecwDQRDZmBCupe/y4vGOraSKM7nIJ/iEBvxoTnt
         l0M6J6vk3Uel5lPohz7JmyVjW9fxvUkEXyRRUIc9hsKO7CBzMe5LBfyMfQX/X/xpve
         RWYutVs6RW3gOPn6WtqvNLTNKpKeL2Jz/8XkFPqc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD32760735;
        Wed,  1 May 2019 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556724469;
        bh=MJfC9RafauewWFrYRr9IYdRD10knT9RsO+zTvWruTP4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=SqttRQSDTtXTOdvTeJqvU6F7o7FzAiAtcm9lzGCaGxbS2uTBDABMNekE7C1iANoe8
         war8NVNASnitnvZ7FL+Q/G0SYcQ5nfQzk9dVOaFXvd0BNrhRZ0WBLLxgFquI0CdtTB
         HJwi7dZthm+ZWDqCciDNPKiyQExcC3NAx0YXgpN4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD32760735
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] brcmfmac: print firmware messages after a firmware
 crash
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190428213826.24526-1-zajec5@gmail.com>
References: <20190428213826.24526-1-zajec5@gmail.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190501152749.81ECE607DF@smtp.codeaurora.org>
Date:   Wed,  1 May 2019 15:27:49 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Normally firmware messages are printed with debugging enabled only. It's
> a good idea as firmware may print a lot of messages that normal users
> don't need to care about.
> 
> However, on firmware crash, it may be very helpful to log all recent
> messages. There is almost always a backtrace available as well as rought
> info on the latest actions/state.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-drivers-next.git, thanks.

47dd82e3d25e brcmfmac: print firmware messages after a firmware crash

-- 
https://patchwork.kernel.org/patch/10921071/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

