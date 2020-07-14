Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B080721ED27
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGNJrt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 05:47:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59512 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgGNJrt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 05:47:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594720068; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=C0XWeKTt3biYo5u+U/gSSmcY0mXUvndmcNYoXzQKdbM=;
 b=D2wVIZNQWU3iCtAStMc8u7epVNoOr9N2RSZUUXtzuGFLVZ7JNFJniuiTRXQ4hmDXaZWKtuGZ
 E4kwG/93PVpgCU1BMnTksjJPKBZqhqwwsqFBzRPR4A3FWWhXATi3Cf2EpC1Mw57hA34VRLDI
 HAwP624g3m83xQDqH5G6UQ5vFY4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f0d7f362991e765cd126261 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 09:47:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D4A07C43387; Tue, 14 Jul 2020 09:47:33 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDA7FC433C8;
        Tue, 14 Jul 2020 09:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDA7FC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 1/6] brcmfmac: allow credit borrowing for all access
 categories
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200610152106.175257-2-chi-hsien.lin@cypress.com>
References: <20200610152106.175257-2-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Raveendran Somu <raveendran.somu@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200714094733.D4A07C43387@smtp.codeaurora.org>
Date:   Tue, 14 Jul 2020 09:47:33 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> wrote:

> From: Raveendran Somu <raveendran.somu@cypress.com>
> 
> Current credit borrowing allows only the access category BE to
> borrow the credits. This change is to fix the credit borrowing
> logic, to make borrowing available for all access categories
> and also to borrow only from the lower categories. This fixes WFA
> 802.11n certs 5.2.27 failures.
> 
> Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
> Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
> Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>

6 patches applied to wireless-drivers-next.git, thanks.

683608bde030 brcmfmac: allow credit borrowing for all access categories
fc4aa125974d brcmfmac: increase message buffer size for control packets
b41c232d3366 brcmfmac: reserve 2 credits for host tx control path
d843246ee761 brcmfmac: update tx status flags to sync with firmware
bbf7ae3dcb42 brcmfmac: fix throughput zero stalls on PM 1 mode due to credit map
ad96bc27032c brcmfmac: initialize the requested dwell time

-- 
https://patchwork.kernel.org/patch/11598099/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

