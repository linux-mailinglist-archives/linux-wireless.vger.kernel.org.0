Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146F23FAB29
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 13:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhH2LrD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 07:47:03 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12190 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhH2LrD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 07:47:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630237571; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=GfsV9Ojb7BBcgW10iYMoWARqBmNOVkCSIs35OVYOwgE=;
 b=gHElNMs58w9+Pt/OTZ9eFiFHo13zo2b1xJgEU/YMOt97RFsC2Rm9iKQw1vtnLlrM/BKTMGPu
 9ABZMIJhqbUr4nFjVGCBxG6MgdCaOz8VuQ4slb4O4+sViFlm21hnhkKLTwY41Iwjg0Vi6Lrs
 HY9fS0phG6csrJaY5R/rhsP4cu0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 612b736c6fc2cf7ad978d22a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 11:45:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 76F0BC4361B; Sun, 29 Aug 2021 11:45:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4F5CC43460;
        Sun, 29 Aug 2021 11:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A4F5CC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: brcmfmac: pcie: fix oops on failure to resume and reprobe
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210817063521.22450-1-a.fatoum@pengutronix.de>
References: <20210817063521.22450-1-a.fatoum@pengutronix.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210829114547.76F0BC4361B@smtp.codeaurora.org>
Date:   Sun, 29 Aug 2021 11:45:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> When resuming from suspend, brcmf_pcie_pm_leave_D3 will first attempt a
> hot resume and then fall back to removing the PCI device and then
> reprobing. If this probe fails, the kernel will oops, because brcmf_err,
> which is called to report the failure will dereference the stale bus
> pointer. Open code and use the default bus-less brcmf_err to avoid this.
> 
> Fixes: 8602e62441ab ("brcmfmac: pass bus to the __brcmf_err() in pcie.c")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Patch applied to wireless-drivers-next.git, thanks.

d745ca4f2c4a brcmfmac: pcie: fix oops on failure to resume and reprobe

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210817063521.22450-1-a.fatoum@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

