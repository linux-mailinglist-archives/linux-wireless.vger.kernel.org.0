Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B334CC2FBF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbfJAJLu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:11:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfJAJLt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:11:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0BE8760A37; Tue,  1 Oct 2019 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569921109;
        bh=64cRdgl/w9VBwZj+X1Zjo9wnyvSCIjqjuCnmWaq54jo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jfFLapo26ZTIi6pTwYa65ZuKczdRqc5QZcKdwzZU+ynkmG4isq/tUMFMRVFPNacHP
         g0YztM77ZjhS9h3DDPYzM4Bpi3haOxw4Sgw4c1VPBlCOZLK/vi20fjouI5Wwdevxhj
         BaecR1omngPrNjY8+jO5+NKIqjlDSlx9Qefe9rdo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B88E608CE;
        Tue,  1 Oct 2019 09:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569921108;
        bh=64cRdgl/w9VBwZj+X1Zjo9wnyvSCIjqjuCnmWaq54jo=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=LQaG/LEB1BttZW9/8MHncCA3l4w8CN6pl3y+BF7Hro2Jw/CW8JTu7PVS634Wvwsim
         1T04W+6w/EWpRs3FB28g4HXx2aj3n0zlpBq0lr7e/vGObSMUHVdTm4IqQWDyVNtiqc
         d4gXhJKTI/1la+Jztk/HAsCu910HFiqdEHy4YDH0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B88E608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 2/2] brcmfmac: send port authorized event for FT-802.1X
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1557395289-41133-3-git-send-email-chi-hsien.lin@cypress.com>
References: <1557395289-41133-3-git-send-email-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191001091149.0BE8760A37@smtp.codeaurora.org>
Date:   Tue,  1 Oct 2019 09:11:49 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com> wrote:

> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> 
> With FT-802.1X, driver should send a port authorized event right after
> sending a roamed event. It is used to indicate that a new AP is already
> authorized so 802.1X is not required.
> 
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>

Patch applied to wireless-drivers-next.git, thanks.

be898fed355e brcmfmac: send port authorized event for FT-802.1X

-- 
https://patchwork.kernel.org/patch/10936943/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

