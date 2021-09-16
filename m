Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE440D5F1
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhIPJSJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 05:18:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45086 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235846AbhIPJR2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 05:17:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631783768; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=dU4Zj6Bc6XMmEfqTT/EHCTOao20OJDLFZLLRcw85Pls=;
 b=KsxIGyRyyGqPxcNAjCgYpsMBFjJYP8j6kHKt/d/6r8NCTzeZCeXnuBXdUJGPKk+9JSoJ64iV
 bB6m1VrB5DBTo1G+UCM6qBOWytjYV9zjUKgpjlmMDSbfYqmCjUcSR8DPiyc4rqeU7e0LjBhL
 98MxrXF51gGttXYeVlL7FkzRLmw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61430b51d914b05182f901eb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 09:16:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 47D85C4314D; Thu, 16 Sep 2021 09:16:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C551C4314D;
        Thu, 16 Sep 2021 09:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1C551C4314D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: fix 4-addr tx failure for AP and STA modes
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210720213147.90042-1-jouni@codeaurora.org>
References: <20210720213147.90042-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210916091600.47D85C4314D@smtp.codeaurora.org>
Date:   Thu, 16 Sep 2021 09:16:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> Ath11k FW requires peer parameter WMI_PEER_USE_4ADDR to be set for
> 4-addr peers allowing 4-address frame transmission to those peers.
> 
> Add ath11k driver callback for sta_set_4addr() to queue new workq
> set_4addr_wk only once based on new boolean, use_4addr_set.
> 
> sta_set_4addr() will be called during 4-addr STA association cases
> applicable for both AP and STA modes.
> 
> In ath11k_sta_set_4addr_wk(),
> 
> AP mode:
>         WMI_PEER_USE_4ADDR will be set for the corresponding
>         associated 4-addr STA(s)
> 
> STA mode:
>         WMI_PEER_USE_4ADDR will be set for the AP to which the
>         4-addr STA got associated.
> 
> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

34c67dc36641 ath11k: fix 4-addr tx failure for AP and STA modes
e20cfa3b62ae ath11k: fix 4addr multicast packet tx

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210720213147.90042-1-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

