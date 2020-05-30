Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7331E9202
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2020 16:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgE3OS1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 May 2020 10:18:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36457 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgE3OS1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 May 2020 10:18:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590848307; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=O4EcZayp+tPMsTK+g3nRVHm3/IbgvaJO9rLDAcuKTyg=;
 b=DnWor3n1p88vH8X8fHk0MxkyCYtcOt7HLNH3862uPpc19s0NPQXVsCS50irbx1jpmx8CbEjf
 7+aogAV0dtJ1jgwcGuHNFRs74CdVi3bEybhM+ZauPo+TzLykjukDmXxIsWeAxu9PkvVQ8hh4
 CXZLI55qnHpP/IznR1pVK5lYr8E=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5ed26b2827386861261bae2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 30 May 2020 14:18:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 68856C433CB; Sat, 30 May 2020 14:18:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E81B0C433C6;
        Sat, 30 May 2020 14:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E81B0C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath9k: Set RX filter based to allow broadcast Action
 frame RX
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200426084733.7889-1-jouni@codeaurora.org>
References: <20200426084733.7889-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200530141815.68856C433CB@smtp.codeaurora.org>
Date:   Sat, 30 May 2020 14:18:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> Advertise support for multicast frame registration and update the RX
> filter based on the recently added FIF_MCAST_ACTION to allow broadcast
> Action frames to be received. This is needed for Device Provisioning
> Protocol (DPP) use cases that use broadcast Public Action frames.
> 
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

c01c320d24ac ath9k: Set RX filter based to allow broadcast Action frame RX
2a9311b5d39a ath9k_htc: Set RX filter based to allow broadcast Action frame RX

-- 
https://patchwork.kernel.org/patch/11510285/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

