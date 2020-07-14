Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AD021ED20
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGNJob (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 05:44:31 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11180 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbgGNJoa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 05:44:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594719870; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SB1dVKMUKbiIHtS7YcdBx+9RbdVAtKV44lqVVLZR+uw=;
 b=wptju59Dhe3ZRaWf/yiyiOzrVLko0vJ+G6YiVX+UHAUtP8iQNsgEzMK7mDYcwIct3eVIHjyp
 xf/CiX01vk0nL0YxyZqepDS+A23G11OOQIez6CE80eU0pUOB4HBOMTHj4XT+pt0md5fd0p+q
 P3KMw+ouiLAnMw9/BGRThMSX8is=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-east-1.postgun.com with SMTP id
 5f0d7e70e3bee12510435b6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 09:44:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 78855C433CB; Tue, 14 Jul 2020 09:44:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB202C433C8;
        Tue, 14 Jul 2020 09:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB202C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/5] brcmfmac: To fix kernel crash on out of boundary
 access
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200604071835.3842-2-wright.feng@cypress.com>
References: <20200604071835.3842-2-wright.feng@cypress.com>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, wright.feng@cypress.com,
        brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com,
        Raveendran Somu <raveendran.somu@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200714094415.78855C433CB@smtp.codeaurora.org>
Date:   Tue, 14 Jul 2020 09:44:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> wrote:

> From: Raveendran Somu <raveendran.somu@cypress.com>
> 
> To truncate the additional bytes, if extra bytes have been received.
> Current code only have a warning and proceed without handling it.
> But in one of the crash reported by DVT, these causes the
> crash intermittently. So the processing is limit to the skb->len.
> 
> Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>

5 patches applied to wireless-drivers-next.git, thanks.

698bae2e6ea1 brcmfmac: To fix kernel crash on out of boundary access
1eb4e9f62998 brcmfmac: fix invalid permanent MAC address in wiphy
eccbf46b15bb brcmfmac: keep SDIO watchdog running when console_interval is non-zero
ec3428bb8915 brcmfmac: reduce maximum station interface from 2 to 1 in RSDB mode
fa3266541b13 brcmfmac: To fix Bss Info flag definition Bug

-- 
https://patchwork.kernel.org/patch/11587075/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

