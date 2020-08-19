Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93424A508
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHSRgz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 13:36:55 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:38837 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbgHSRgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 13:36:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597858612; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=8Tq5PEF/foUw0IFKugsxPWNHu1HF6vytXmRPCH1gWVc=;
 b=VImPVisl7R3hsSlsC1+6f9gCRvIS7d0KfT+2TXYP9uueD9YRaQOhfqdAD+OrEEcN2A9mfNeP
 nfhs5/b/3yEM0wbXjwZzDIrTpt/n4P9RK8QVR0ChgKPCsUpZZLNXGn9MBzlI1KVuWe+0RX0n
 IgYu1330c1zgpMZNa9nyuXvE06w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f3d6332b51414ba27104b50 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 17:36:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7F3FC433CB; Wed, 19 Aug 2020 17:36:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFABBC433C6;
        Wed, 19 Aug 2020 17:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFABBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] ath10k: add bus type for each layout of coredump
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1569310030-834-2-git-send-email-wgong@codeaurora.org>
References: <1569310030-834-2-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200819173649.D7F3FC433CB@smtp.codeaurora.org>
Date:   Wed, 19 Aug 2020 17:36:49 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> For some hw version, it has more than one bus type, it need to add bus
> type to distinguish different chip.
> 
> Tested-on: QCA6174 SDIO WLAN.RMH.4.4.1-00018-QCARMSWP-1
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

c796d513c6ae ath10k: add bus type for each layout of coredump
3c45f21af84e ath10k: sdio: add firmware coredump support

-- 
https://patchwork.kernel.org/patch/11158043/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

