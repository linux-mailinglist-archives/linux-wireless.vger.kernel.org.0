Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776F11C6BF5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 10:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgEFIkK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 04:40:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:54358 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728524AbgEFIkK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 04:40:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588754409; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SxiHQgwz44TmABspag5ajI7IXF/QGzpOvbYtbljzGAQ=;
 b=HCVhfAC43X26RN1qxIhG0ZU64xan3VefTE4s69mU9g8QCoEqEgf4YNNbOL7wPWFgAR6nh/IT
 9lDV4McPku4tIwU3dSKH9oCmKZ1k6ii4xMaIEry9F6tkvrxT8ip1D2oPUI7xik9+9zp4g2Vr
 DdhfNVV04vAyuGKOVB5aJ8xQqSs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb277e7.7f9c7657ba40-smtp-out-n05;
 Wed, 06 May 2020 08:40:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AE6D2C43637; Wed,  6 May 2020 08:40:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F49FC433BA;
        Wed,  6 May 2020 08:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F49FC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] brcmfmac: support the second p2p connection
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588572453-194663-2-git-send-email-wright.feng@cypress.com>
References: <1588572453-194663-2-git-send-email-wright.feng@cypress.com>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200506084006.AE6D2C43637@smtp.codeaurora.org>
Date:   Wed,  6 May 2020 08:40:06 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> wrote:

> With RSDB feature, firmware is able to support two P2P-AGO or two
> P2P-GC at the same time. So we add the second p2p connection type
> to map to the second P2P connection bsscfg.
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>

3 patches applied to wireless-drivers-next.git, thanks.

babfd3caf356 brcmfmac: support the second p2p connection
9c29da3f4e7e brcmfmac: Fix P2P Group Formation failure via Go-neg method
7f26cedfc9fd brcmfmac: Add P2P Action Frame retry delay to fix GAS Comeback Response failure issue

-- 
https://patchwork.kernel.org/patch/11525053/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
