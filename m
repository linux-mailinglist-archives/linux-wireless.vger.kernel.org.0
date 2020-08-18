Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CDD24879F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHROdc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 10:33:32 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:26762 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726585AbgHROda (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 10:33:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597761210; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2MGRWF13So/BGj/B6Ko1KmWo35UfT+78Ejs7qalFLSA=;
 b=DON5orpbnnGlGGTRy3b2Kdtn0br7DKYmI436frfwkuJDz2W2rub615ENs/5/bnoUa3Rc1MFx
 9qEYbzaHEvgKbKMhyC/zmtC3c1CpQRX4RjH2/2+gY0Sv2eOxurnDpzcpE1L8fqR2ENgMq/gh
 8ytOmaZ+HFmzO8+Vc+3H31RRLFg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f3be6b3247ccc308c423201 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 14:33:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07C0AC433CB; Tue, 18 Aug 2020 14:33:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93F7AC433C6;
        Tue, 18 Aug 2020 14:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93F7AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: reserve tx credit only when txctl is ready to
 send
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200813070017.89023-1-wright.feng@cypress.com>
References: <20200813070017.89023-1-wright.feng@cypress.com>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, wright.feng@cypress.com,
        brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com, Dmitry Osipenko <digetx@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200818143322.07C0AC433CB@smtp.codeaurora.org>
Date:   Tue, 18 Aug 2020 14:33:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> wrote:

> The 4329 throughput drops from 40.2 Mbits/sec to 190 Kbits/sec in 2G
> 11n mode because the commit b41c232d33666 ("brcmfmac: reserve 2 credits
> for host tx control path"). To fix the issue, host driver only reserves
> tx control credit when there is a txctl frame is pending to send. And
> we also check available credit by using "not equal to 0" instead of
> "greater than 0" because tx_max and tx_seq are circled positive numbers.
> 
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Fixes: b41c232d33666 ("brcmfmac: reserve 2 credits for host tx control path")
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

Patch applied to wireless-drivers.git, thanks.

9a2a0862d973 brcmfmac: reserve tx credit only when txctl is ready to send

-- 
https://patchwork.kernel.org/patch/11711809/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

