Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27619F9FE
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgDFQSn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 12:18:43 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:59942 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728802AbgDFQSn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 12:18:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586189923; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=zDyOygkPVoW4doFzVlL5k48CqeupyMWYpkh9gzxcRHk=;
 b=s27aRLuas9pk82ZXh76mXm45IjS8Ao+QujY9J8C6hdi/9K8Uld80wE5ZfbfRt/aBfILOB+53
 HIqISxePEucMfWWxYdBI3hmcxyrnvc3Lu89HvTOQqbcDFdICSyeB9cQiNkCfsMU2ZVemBkB+
 PvABA25jtCb9aOb7D6UHX85k7Zs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b565a.7fbf571d8228-smtp-out-n03;
 Mon, 06 Apr 2020 16:18:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D4BBCC433BA; Mon,  6 Apr 2020 16:18:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8639DC433D2;
        Mon,  6 Apr 2020 16:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8639DC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add pktlog checksum in trace events to support
 pktlog
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585234155-30574-1-git-send-email-mkenna@codeaurora.org>
References: <1585234155-30574-1-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200406161833.D4BBCC433BA@smtp.codeaurora.org>
Date:   Mon,  6 Apr 2020 16:18:33 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> Pktlog data are different among the chipset & chipset versions.
> As part of enhancing the user space script to decode the pktlog
> trace events generated, it is desirable to know which chipset or
> which chipset version has provided the events and thereby decode
> the pktlogs appropriately.
> 
> Pktlog checksum helps to determine the chipset variant which is
> given by the firmware in the struct wmi_ready_event.
> 
> Pktlog checksums are computed during the firmware build.
> So, adding that pktlog checksum in the pklog trace events.
> 
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

21c1b063f4b9 ath11k: add pktlog checksum in trace events to support pktlog

-- 
https://patchwork.kernel.org/patch/11460287/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
