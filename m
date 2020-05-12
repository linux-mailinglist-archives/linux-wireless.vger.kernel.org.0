Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7641CEF7C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 10:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgELIv7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 04:51:59 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16076 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727783AbgELIv7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 04:51:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589273518; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=A11smq5vykL6ae4fdojc+Shce0sCm4xPoNsWvt0rPN8=;
 b=AYSzbTn+Musam4/GPT5YTaylKQnjJ5U44citsuW09CiU5qvput5N327dORahyTpXsdwrlgS3
 95defcCmuBE9FN6GMmAtg3oON0VLAMdSZXD9SlmVF39GLO2sTzxfsQJYaGuG8IlmFbsCx57P
 23Pi/PmxQqV4YB9b7GcmkMAy1kI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba63ae.7f8a4b9c71f0-smtp-out-n04;
 Tue, 12 May 2020 08:51:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20CF5C433BA; Tue, 12 May 2020 08:51:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96261C433F2;
        Tue, 12 May 2020 08:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96261C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] brcmfmac: set security after reiniting interface
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588770201-54361-2-git-send-email-wright.feng@cypress.com>
References: <1588770201-54361-2-git-send-email-wright.feng@cypress.com>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, wright.feng@cypress.com,
        brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200512085157.20CF5C433BA@smtp.codeaurora.org>
Date:   Tue, 12 May 2020 08:51:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> wrote:

> From: Jia-Shyr Chuang <joseph.chuang@cypress.com>
> 
> Host driver parses and sets security params into FW passed by
> supplicant. This has to be done after reiniting interface in the
> firmware.
> 
> Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>

3 patches applied to wireless-drivers-next.git, thanks.

b46f1546a708 brcmfmac: set security after reiniting interface
30fb1b272909 brcmfmac: use actframe_abort to cancel ongoing action frame
78db077db638 brcmfmac: Use seq/seq_len and set iv_initialize when plumbing of rxiv in (GTK) keys

-- 
https://patchwork.kernel.org/patch/11531191/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
