Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA67F72E3F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGXLy0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 07:54:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfGXLy0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 07:54:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E7E860588; Wed, 24 Jul 2019 11:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969266;
        bh=+8V6j0NZTXOJe88Jj4gZ43jWkM2df1lu1hzUQrwDUk8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jv1OFbmsbIRXNEWCufz+nD5LAsQQFJSmQlhwv2V/wTwSB1uOjnHkocqpHdqtRYT2X
         LgQXLplBjSZFQBx7pY2IcJ2F80D5VQJeaMDooxDEHdWFOc/G08nqiO4A5pQfHuyqL1
         XAR3NzgsXJEiVc8dLq2Iel+Q/enzsKFM1d1VKUu4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0DE9260392;
        Wed, 24 Jul 2019 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969264;
        bh=+8V6j0NZTXOJe88Jj4gZ43jWkM2df1lu1hzUQrwDUk8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=nx69USPy5h4xzlvEMY2B0T/WidOCo4Nn42KsBlw6D+BQbGCIBKReIuClkooZCBy8X
         MoEWZESZs6Bgj0waa7KHIf7GFHCXHOlCwsABVsRfOt/LNemQJufSSmsecmdw0+BnfO
         nLLRsZEVo+IcC5dzpYoKVb/vH70yLxoqvs4RC7DM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DE9260392
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] brcmfmac: don't net_ratelimit() CONSOLE messages on
 firmware crash
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190721195217.26838-1-zajec5@gmail.com>
References: <20190721195217.26838-1-zajec5@gmail.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190724115426.4E7E860588@smtp.codeaurora.org>
Date:   Wed, 24 Jul 2019 11:54:26 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Firmware crash is a pretty rare event and can't happen too frequently as
> it has to be followed by a hardware reinitialization and config reload.
> It should be safe to don't use net_ratelimit() when it happens.
> 
> For reporting & debugging purposes it's important to provide a complete
> log as the last lines are actually the most important. This change
> modifies brcmfmac to print all messages in an unlimited way in that
> specific case. With this change there should be finally a backtrace of
> firmware finally visible after a crash.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-drivers-next.git, thanks.

e3b1d879ccda brcmfmac: don't net_ratelimit() CONSOLE messages on firmware crash

-- 
https://patchwork.kernel.org/patch/11051195/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

