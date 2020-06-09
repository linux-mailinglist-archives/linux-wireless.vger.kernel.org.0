Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199101F3431
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 08:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgFIGno (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 02:43:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13648 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbgFIGno (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 02:43:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591685024; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=3kwJ97K60i/LuHHIbBHmzkzNrkbdub+dJDPKA54DSGA=; b=v28tQJYuXAl26JVdou6QTqStVj2Gco6hySa04R98mhymXDD/g64msZpaiPtoWsKShRURGnnH
 6RMWVx4OU8t1VaXTHHWb4dA+eJBQwJeBcvqe/pSOzyQSS1rr0/4ADpwLQVaKFxjcFugz4eGP
 fa40M44914FK6S+CuwqcKLlaxtY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5edf2f8d8d5a8bd2195f859e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 06:43:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 05A42C433CA; Tue,  9 Jun 2020 06:43:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBF2EC433C6;
        Tue,  9 Jun 2020 06:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBF2EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/8] ath11k: Add IPQ6018 support
References: <1591678993-11016-1-git-send-email-akolli@codeaurora.org>
Date:   Tue, 09 Jun 2020 09:43:21 +0300
In-Reply-To: <1591678993-11016-1-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Tue, 9 Jun 2020 10:33:05 +0530")
Message-ID: <87bllszqly.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> IPQ6018 has a 5G radio and 2G radio with 2x2
> and shares IPQ8074 configuration.
>
> Tested on: IPQ6018 WLAN.HK.2.2-02134-QCAHKSWPL_SILICONZ-1
> Tested on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1 
>
> Anilkumar Kolli (8):
>   ath11k: update firmware files read path
>   ath11k: rename default board file
>   dt: bindings: net: update compatible for ath11k
>   ath11k: add IPQ6018 support
>   ath11k: define max_radios in hw_params
>   ath11k: add hw_ops for pdev id to hw_mac mapping
>   ath11k: add ce services for IPQ6018
>   ath11k: Add bdf-addr in hw_params

You need to CC the device tree list, so please resubmit as v2. And to
make their review easier please move the binding doc update as the first
patch.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
