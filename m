Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715C0475A9B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 15:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhLOOX4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 09:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLOOXz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 09:23:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE5C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 06:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA0E1618CF
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 14:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E637C34605;
        Wed, 15 Dec 2021 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639578234;
        bh=+mgIa1Ig+dD5MXNt88Lj5gDCMpAT/wRrfP8VkfdF2PQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pzMyPMY/38zmOYyrLt8/7UMig/0Y670jbem3MKZSR2ep6kG04DXKWA4QTBxAwbmiW
         cY8OX/2CVkGqY/6vmcTRx3GFJCEUXLTb71PA2Id/vch9eupzUv7Qgvf1Ud+ge8fO3V
         AJxNXXQGqkx3MeX2zvW3PRx/s0x2wn4Jh8PW/cBPPeetZP6aiB8E37N0QtVUWCsU7M
         od4WgajLTpTfAudvsdqY5ws26wpedTRPgcBSF6CqSEBSVk+77q+ZilhFFQY8nSuJAt
         28mAdpW2t161YRpoJAYhY85Rmw44FcBt35GjHF1+nQasm7PqNRXsvi84SGN6ijZ2vD
         hVCnPwNXzndcA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] brcmfmac: add CYW43570 PCIE device
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <bbd6262b-8055-9a2f-55c5-81d6527014cb@infineon.com>
References: <bbd6262b-8055-9a2f-55c5-81d6527014cb@infineon.com>
To:     "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin-ee@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        <Chi-Hsien.Lin@infineon.com>, <Wright.Feng@infineon.com>,
        <Double.Lo@infineon.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163957823009.6130.17486515581645978504.kvalo@kernel.org>
Date:   Wed, 15 Dec 2021 14:23:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin-ee@infineon.com> wrote:

> From: Soontak Lee <soontak.lee@cypress.com>
> 
> CYW43570 is a 3-antenna, 2x2 MIMO,802.11a/b/g/n/ac, PCIe 3.0 for WLAN.
> It is BT/WIFI combo.
> 
> Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@infineon.com>
> Signed-off-by: Ian Lin <ian.lin-ee@infineon.com>

The indentation looks wrong and also the patch is corrupted. It looks like you
used Mozilla to submit the patch so it's not surprising there are problems,
see the wiki below for more information how to submit patches using git
send-email.

error: corrupt patch at line 19

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/bbd6262b-8055-9a2f-55c5-81d6527014cb@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

