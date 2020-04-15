Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E5D1A95CB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 10:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635595AbgDOIIG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 04:08:06 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19233 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2635584AbgDOIIA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 04:08:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586938079; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vVMLaqkLICcto/eiMUDxkqMTXjEUOb5GRGusH5kiVf0=;
 b=j4GoOTnDL96/M/MHtlgfb9DxRPrTvooz0Ijz9Q+8ERu7sVD6XO7fslOgxDs/HyGYJNIcRu6E
 XEOzGz5VciwemHvesoP5cKsf2dkcd99rFqByTH900s+Cmy/CJw3V+TtFWCLYPbRcnnHWkaIw
 rjZXWGNGkMX0CNW6wNPWoW7z/0k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96c0d9.7f210512c730-smtp-out-n04;
 Wed, 15 Apr 2020 08:07:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 02F66C43636; Wed, 15 Apr 2020 08:07:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABB52C433CB;
        Wed, 15 Apr 2020 08:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABB52C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add dynamic tcl ring selection logic with retry
 mechanism
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1586782622-22570-1-git-send-email-srirrama@codeaurora.org>
References: <1586782622-22570-1-git-send-email-srirrama@codeaurora.org>
To:     Sriram R <srirrama@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415080753.02F66C43636@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 08:07:52 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <srirrama@codeaurora.org> wrote:

> IPQ8074 HW supports three TCL rings for tx. Currently these rings
> are mapped based on the Access categories, viz. VO, VI, BE, BK.
> In case, one of the traffic type dominates, then it could stress
> the same tcl rings. Rather, it would be optimal to make use of all
> the rings in a round robin fashion irrespective of the traffic type
> so that the load could be evenly distributed among all the rings.
> Also, in case the selected ring is busy or full, a retry mechanism
> is used to ensure other available ring is selected without dropping
> the packet.
> 
> In SMP systems, this change avoids a single CPU from getting hogged
> when heavy traffic of same category is transmitted.
> The tx completion interrupts corresponding to the used tcl ring
> would be more which causes the assigned CPU to get hogged.
> Distribution of tx packets to different tcl rings helps balance
> this load.
> 
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

d687275b268b ath11k: Add dynamic tcl ring selection logic with retry mechanism

-- 
https://patchwork.kernel.org/patch/11485549/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
