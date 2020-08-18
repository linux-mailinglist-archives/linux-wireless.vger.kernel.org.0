Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2731B24822E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgHRJt3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 05:49:29 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11818 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgHRJt1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 05:49:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597744167; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3wksdGO40o3VARZadJ14XsJCGAyoRmPiBj/5YMig9kA=;
 b=e6jFup17nQ9efCDcboudP5054bPRR59gub2PcAjSR2Nze5R4mRgEhX7Rb8CiFNvDYDpuQrnn
 GtenhFlfRMHog637BqAxicGVh714/abTaaXh5qWQvjNoD7EVYPveMO9MOAnNwf+bOqnh0Qiw
 fQlNkKgBpYixXC5KsSljB3VghDo=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f3ba40d8567201751074d2f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 09:49:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D38E5C433CB; Tue, 18 Aug 2020 09:49:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 680A9C433CA;
        Tue, 18 Aug 2020 09:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 680A9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Register shutdown handler
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1593193981-30161-1-git-send-email-pillair@codeaurora.org>
References: <1593193981-30161-1-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200818094900.D38E5C433CB@smtp.codeaurora.org>
Date:   Tue, 18 Aug 2020 09:49:00 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> As a part of device shutdown the smmu driver will be
> stopped and henceforth any IOVA address translation
> will not be done. The wlan driver, being one of the
> smmu driver consumer, should stop all the dma related
> activity as a part of shutdown, and thereby ensuring
> that no dma activity is done once the smmu driver
> shuts down.
> 
> During the device shutdown, the smmu calls shutdown
> for all its consumers in order to indicate them to
> stop all their dma activities.
> 
> Register the shutdown handler to stop the wlan
> driver and avoid any dma operations.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

caf275463d37 ath10k: Register shutdown handler

-- 
https://patchwork.kernel.org/patch/11628291/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

