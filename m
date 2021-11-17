Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5217145433C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 10:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhKQJE1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 04:04:27 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:27874 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232291AbhKQJE0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 04:04:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637139688; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=u5n52TZT1wtrTRHaAceu6U1TzFg1GLFIVdwevXoGm4M=;
 b=lC28JsTbvUuxPottuIjWyp0hb8+5HdM3/H6kjPMvTIH3WZYHm0AaTjcekS51oiPCQqZX4K47
 eLfhRGUnIP/Ii4vpJawC1XmIRqpV+eGrG9l55VyNJzEroSuNGeFgVVQC9IXASh0IAMw49GgB
 dTjwRJvUEdSfR1jQ+ih6SwCbla8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6194c4e8638a2f4d61491cf5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 09:01:28
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9413C4360C; Wed, 17 Nov 2021 09:01:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 826FCC4338F;
        Wed, 17 Nov 2021 09:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 826FCC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: support MAC address randomization in scan
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211012191638.8749-1-cjhuang@codeaurora.org>
References: <20211012191638.8749-1-cjhuang@codeaurora.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713968455.10263.9448398259570217242.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 09:01:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> wrote:

> The driver reports NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR capability
> to upper layer based on the service bit firmware reported. Driver
> sets the spoofed flag in scan_ctrl_flag to firmware if upper layer
> has enabled this feature in scan request.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>

Fails to apply:

error: patch failed: drivers/net/wireless/ath/ath11k/mac.c:7888
error: drivers/net/wireless/ath/ath11k/mac.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/wmi.c:8983
error: drivers/net/wireless/ath/ath11k/wmi.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/wmi.h:6056
error: drivers/net/wireless/ath/ath11k/wmi.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211012191638.8749-1-cjhuang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

