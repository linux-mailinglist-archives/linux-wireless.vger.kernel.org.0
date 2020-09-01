Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC02258DE2
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 14:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgIAMG2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 08:06:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29550 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbgIAMAu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 08:00:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598961619; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=0jMDgX0W1BZ/pON/uohBkNZ0K8cxTtaj7bi4Iz5LFzw=;
 b=svlLqCdGWVgP1jF4RIsno1MBUGrvmeujSRbAopl7yOiTBgwUHTg7VkbDX14/gKbkFquMYS7V
 z881Wf+1CBUqJrtPp9FpwNZVBlzrt/AyvL4wtiBzO8kxvQeYUyb118xc2h7aZywAZjixiXiY
 j2+zpsZTNAhmtOb4w7xzgFM2M/g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f4e37bf252c52244081a493 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 11:59:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9E3EC433C6; Tue,  1 Sep 2020 11:59:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 126B1C433C9;
        Tue,  1 Sep 2020 11:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 126B1C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200901115959.B9E3EC433C6@smtp.codeaurora.org>
Date:   Tue,  1 Sep 2020 11:59:59 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> Currently the NAPI processing loops through all
> the copy engines and processes a particular copy
> engine is the copy completion is set for that copy
> engine. The host driver is not supposed to access
> any copy engine register after clearing the interrupt
> status register.
> 
> This might result in kernel crash like the one below
> [ 1159.220143] Call trace:
> [ 1159.220170]  ath10k_snoc_read32+0x20/0x40 [ath10k_snoc]
> [ 1159.220193]  ath10k_ce_per_engine_service_any+0x78/0x130 [ath10k_core]
> [ 1159.220203]  ath10k_snoc_napi_poll+0x38/0x8c [ath10k_snoc]
> [ 1159.220270]  net_rx_action+0x100/0x3b0
> [ 1159.220312]  __do_softirq+0x164/0x30c
> [ 1159.220345]  run_ksoftirqd+0x2c/0x64
> [ 1159.220380]  smpboot_thread_fn+0x1b0/0x288
> [ 1159.220405]  kthread+0x11c/0x12c
> [ 1159.220423]  ret_from_fork+0x10/0x18
> 
> To avoid such a scenario, we generate an interrupt
> summary by reading the copy completion for all the
> copy engine before actually processing any of them.
> This will avoid reading the interrupt status register
> for any CE after the interrupt status is cleared.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b92aba35d39d ath10k: Add interrupt summary based CE processing

-- 
https://patchwork.kernel.org/patch/11628289/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

