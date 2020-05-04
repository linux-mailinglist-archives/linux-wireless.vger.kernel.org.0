Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C61C3613
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 11:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgEDJtr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 05:49:47 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:11921 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgEDJtq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 05:49:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588585786; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=aAybSPYoOXbi8SzeNaB+OInBOq6y5Ef01bnlX8awsl0=;
 b=lEcY1pG3LyMYUi8AtusB2m22FLl++QA2pvLSvNXJw1UnDiAGF5Z8jbEQWy6iAPB74/42WEMq
 0IZaa7g7Wl4Jqwm/yNZWaRbden25581rF2FJ3nyLyNhRa2xdKd4QySZGQHNpAZCFfodTIMkn
 87WznfT/wgLSmpdE0/KOQXTxQIE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eafe52d.7f88f6b2e110-smtp-out-n01;
 Mon, 04 May 2020 09:49:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66994C44788; Mon,  4 May 2020 09:49:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E3C2C44788;
        Mon,  4 May 2020 09:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E3C2C44788
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 1/5] brcmfmac: keep apsta enabled when AP starts with
 MCHAN
 feature
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1587970803-77700-2-git-send-email-chi-hsien.lin@cypress.com>
References: <1587970803-77700-2-git-send-email-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200504094933.66994C44788@smtp.codeaurora.org>
Date:   Mon,  4 May 2020 09:49:33 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> wrote:

> From: Wright Feng <wright.feng@cypress.com>
> 
> When starting station mode on wlan0 and AP mode on wlan1, the apsta will
> be disabled and cause data stall on wlan0(station). The apsta feature
> with MCHAN(Multi-Channel Concurrent) or RSDB(Real Simultaneous
> Dual-Band) can make STA+AP work on two bands concurrently.
> Because of that, we keep apsta enabled if firmware supports MCHAN or
> RSDB features
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>

5 patches applied to wireless-drivers-next.git, thanks.

774965f22dc7 brcmfmac: keep apsta enabled when AP starts with MCHAN feature
19f557a9b8d1 brcmfmac: remove arp_hostip_clear from brcmf_netdev_stop
d524d5ce3655 brcmfmac: p2p cert 6.1.9-support GOUT handling p2p presence request
053ac9e1438a brcmfmac: only generate random p2p address when needed
2719afcae759 brcmfmac: add vendor ie for association responses

-- 
https://patchwork.kernel.org/patch/11511247/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
