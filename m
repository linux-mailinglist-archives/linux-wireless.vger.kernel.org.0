Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3983D1CEF7B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgELIv1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 04:51:27 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16076 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgELIv0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 04:51:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589273486; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=YPlr7y7N+/19DGAK/A8pu0D3g/m/P1zOujGhx/9Ruu4=;
 b=l9oC46rrOmxag0OJ3Ry6pLZ/Zg27mZLLoLvBAsXDG8hs3p76yTfurbX0olcOQSpTDcRfmjqa
 BEbWHABEjTU9RhDB9e323ZQkAYgkwCekgoNLhzg4Z708XbIncwP5ycBF434VzB5dbHpVt/9n
 w5nEMG5rA4KY+eIyPip9lBpPELE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba6384.7fea8d077df8-smtp-out-n01;
 Tue, 12 May 2020 08:51:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80E07C433CB; Tue, 12 May 2020 08:51:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A6F9C433F2;
        Tue, 12 May 2020 08:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A6F9C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] brcmfmac: map 802.1d priority to precedence level
 based
 on AP WMM params
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588661487-21884-2-git-send-email-chi-hsien.lin@cypress.com>
References: <1588661487-21884-2-git-send-email-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Saravanan Shanmugham <saravanan.shanmugham@cypress.com>,
        Justin Li <justin.li@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200512085115.80E07C433CB@smtp.codeaurora.org>
Date:   Tue, 12 May 2020 08:51:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> wrote:

> From: Saravanan Shanmugham <saravanan.shanmugham@cypress.com>
> 
> In WLAN, priority among various access categories of traffic is
> always set by the AP using WMM parameters and this may not always
> follow the standard 802.1d priority.
> 
> In this change, priority is adjusted based on the AP WMM params
> received as part of the Assoc Response and the same is later used
> to map the priority of all incoming traffic.
> 
> In a specific scenario where EDCA parameters are configured to be same
> for all ACs, use the default FW priority definition to avoid queuing
> packets of all ACs to the same priority queue.
> 
> This change fixes the following 802.11 certification tests:
> * 11n - 5.2.31 ACM Bit Conformance test
> * 11n - 5.2.32 AC Parameter Modification test
> * 11ac - 5.2.33 TXOP Limit test
> 
> Signed-off-by: Saravanan Shanmugham <saravanan.shanmugham@cypress.com>
> Signed-off-by: Justin Li <justin.li@cypress.com>
> Signed-off-by: Madhan Mohan R <madhanmohan.r@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>

2 patches applied to wireless-drivers-next.git, thanks.

92072e5fb099 brcmfmac: map 802.1d priority to precedence level based on AP WMM params
f5da2a370f2f brcmfmac: fix 802.1d priority to ac mapping for pcie dongles

-- 
https://patchwork.kernel.org/patch/11528265/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
