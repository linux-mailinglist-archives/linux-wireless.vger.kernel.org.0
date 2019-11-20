Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BA3103586
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 08:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfKTHqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 02:46:54 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:40420
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbfKTHqy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 02:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574236013;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=EGWrSP7PeZ1d+LSnnGzi3OKHkbcP3PQzsDjKex/ddBg=;
        b=VBtvRUlBXYP3IL2edja0GALK+JhZEc5eNgVNNGpY04oCDRI2vnXnhAMuwqaYJTmE
        LfZcW5DrUb+J7BUZi/1kZrx5dxvxrbbbYKM8pZnYD0vlUglsOCBu7tgnCYPFIbE9T+0
        HxOww2ejaIGiXnK9WJ9+Ap80i2xhjf3orAVE/JII=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574236013;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=EGWrSP7PeZ1d+LSnnGzi3OKHkbcP3PQzsDjKex/ddBg=;
        b=YWe8CYQ+3oC3tZSkKvZRVurpV8zP5Ov5g6u5Ud4WYLouUmu7ubkjjt3KrlIf2Cfl
        mC998ewbEPtR0Jc0dcKO65NTkMDdiQIilv6nGE7iSUVuMUsApBQ0Qp8LqFm9XCZANv/
        FMXTRW+kvukf+9EbxH7kSWZH0bnFzGBIMvnUkN+0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F5E0C447A5
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 5.5] brcmfmac: remove monitor interface when detaching
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191118123855.31696-1-zajec5@gmail.com>
References: <20191118123855.31696-1-zajec5@gmail.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016e87c74264-07b063c6-e6f2-4dd2-8b51-386e45b637f9-000000@us-west-2.amazonses.com>
Date:   Wed, 20 Nov 2019 07:46:53 +0000
X-SES-Outgoing: 2019.11.20-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This fixes a minor WARNING in the cfg80211:
> [  130.658034] ------------[ cut here ]------------
> [  130.662805] WARNING: CPU: 1 PID: 610 at net/wireless/core.c:954 wiphy_unregister+0xb4/0x198 [cfg80211]
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Patch applied to wireless-drivers-next.git, thanks.

4f61563da075 brcmfmac: remove monitor interface when detaching

-- 
https://patchwork.kernel.org/patch/11249727/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

