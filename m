Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C900249FD96
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 17:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349902AbiA1QEo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 11:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiA1QEo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 11:04:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBFC061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 08:04:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DE5761ECD
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 16:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94639C340E0;
        Fri, 28 Jan 2022 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385883;
        bh=hIyMgQMs9ZmgifpyUV8prIs5lm2motGv1d1gXo4KMig=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mXTlYZi2+jBqK/Rg557QoS542GBZpwueEisXKQ8zrQFVqZAXNVHogWq6c/AmAue6J
         SKj77FVD5hnjx7dMHEffjUG7WIpdQpUA3MWYbtJkbkV/d+fWvVrh44/tm9eekh7nCl
         Dn32UvUV4fKxrPeg9qvvvSOtYILr3q/R7ddC4kcl7SvpupGJWbarMi2Bl/6IbU7RS5
         MkoUA3JIVxtc1X3zeRSM4TpfJZ5nbDSOcVAqsm5ejGDQ/QwxZvsNFf6HfcyqA8lGbk
         KobA5XxQsWbDxi1GiGGMtda7alyvNdQwVumJKd9z/2LPZCdIFpzHCxCUqY2nZEMWxl
         CrsPkSgU96IMw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] brcmfmac: add CYW43570 PCIE device
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211229035144.9205-1-ian.lin-ee@infineon.com>
References: <20211229035144.9205-1-ian.lin-ee@infineon.com>
To:     Ian Lin <ian.lin-ee@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@codeaurora.org>,
        <Chi-Hsien.Lin@infineon.com>, <Wright.Feng@infineon.com>,
        <Double.Lo@infineon.com>, Ian Lin <ian.lin-ee@infineon.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338587883.19531.16672744156205025446.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 16:04:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ian Lin <ian.lin-ee@infineon.com> wrote:

> From: Soontak Lee <soontak.lee@cypress.com>
> 
> CYW43570 is a 3-antenna, 2x2 MIMO,802.11a/b/g/n/ac, PCIe 3.0 for WLAN.
> It is BT/WIFI combo.
> 
> Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@infineon.com>
> Signed-off-by: Ian Lin <ian.lin-ee@infineon.com>

Patch applied to wireless-next.git, thanks.

8ec10f1576d6 brcmfmac: add CYW43570 PCIE device

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211229035144.9205-1-ian.lin-ee@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

