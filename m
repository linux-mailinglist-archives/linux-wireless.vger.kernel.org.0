Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7DC10A06
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEAP0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 11:26:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEAP0a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 11:26:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 48475602F5; Wed,  1 May 2019 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556724390;
        bh=s+DaP76waYwUzTVcUZEtIMGRlqA0iOhcb6eogQTkwko=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QgcdAMl2kxi39lf2Fuun2mnyTTYhVvOk3fGMm2xxXUBlFv7k/4+F9KMjt0WfY44SN
         dx1ItUY1YLWTcjFz8CzKS3NU140QkYnlSd9U7lK2FNrEJ3Lm6IMmfXQrjtHTQNhVru
         nxCBC96JsaPQ7mkaSMMmBPzRtUwpvyeM5I2t1nrk=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A0B3602F5;
        Wed,  1 May 2019 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556724389;
        bh=s+DaP76waYwUzTVcUZEtIMGRlqA0iOhcb6eogQTkwko=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=fuq9pG60IoSsJfSBrQCqSjgy9EJyav9LZKuPOV273ZmBCJBjPoUmVqjS4IQHJK2G6
         Nr/0WbQPzg9l3EU0K5MW9wGrhXXW48TPgentl5R56ivjwK+X8MGqOOeXpOxobHb8KW
         NUuYEwdpJuRB0ALIW2Mh7ZD/dHpZ3IDY/HK3b9c8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A0B3602F5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] brcmfmac: set txflow request id from 1 to pktids array
 size
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1556250092-3834-1-git-send-email-wright.feng@cypress.com>
References: <1556250092-3834-1-git-send-email-wright.feng@cypress.com>
To:     Wright Feng <Wright.Feng@cypress.com>
Cc:     "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190501152630.48475602F5@smtp.codeaurora.org>
Date:   Wed,  1 May 2019 15:26:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <Wright.Feng@cypress.com> wrote:

> Some PCIE firmwares drop txstatus if pktid is 0 and make packet held in
> host side and never be released. If that packet type is 802.1x, the
> pend_8021x_cnt value will be always greater than 0 and show "Timed out
> waiting for no pending 802.1x packets" error message when sending key to
> dongle every time.
> 
> To be compatible with all firmwares, host should set txflow request id
> from 1 instead of from 0.
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>

Patch applied to wireless-drivers-next.git, thanks.

2d91c8ad068a brcmfmac: set txflow request id from 1 to pktids array size

-- 
https://patchwork.kernel.org/patch/10918007/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

