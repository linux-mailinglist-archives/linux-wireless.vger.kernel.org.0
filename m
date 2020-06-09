Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A561F342B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 08:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFIGkU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 02:40:20 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35167 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbgFIGkT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 02:40:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591684819; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=njWSdLSpywTV34pSBIFjvSxMIrtSqDQXkNhqysPolGA=;
 b=tOvAqDLR0Jsc/3CM3u4MIw+FxUajKXHbXuNyAcrFsdepBiQfI0Boku/q3eThZIkAh/a2kVrF
 AqIMbTALP0axlpUy9q/ccZGVwT/ADeJUiuc1LslO9GTg9P+sD3Cx1dLBGpeJXXxUae9qa2QE
 VReZU7iD8Lky3CHFDMR6ocYicHI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5edf2ebf96950fa0ffc52f3d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 06:39:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B90DC433CA; Tue,  9 Jun 2020 06:39:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51BD1C433C6;
        Tue,  9 Jun 2020 06:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51BD1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: Add direct buffer ring support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1591673945-25300-1-git-send-email-periyasa@codeaurora.org>
References: <1591673945-25300-1-git-send-email-periyasa@codeaurora.org>
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200609063958.9B90DC433CA@smtp.codeaurora.org>
Date:   Tue,  9 Jun 2020 06:39:58 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <periyasa@codeaurora.org> wrote:

> Add direct buffer ring (dbring) with helper API, which is used by the
> spectral scan. Initialise the direct buffer ring based on the dma ring
> capability, which get announced in the wmi service ready extended event.
> This ring is slightly changed from data path rings. Compare to data path
> ring this ring shares the hp and tp address to firmware though WMI commands.
> Also the replenish buffer size is derived from firmware announcement.
> driver receive indication through WMI event
> WMI_PDEV_DMA_RING_BUF_RELEASE_EVENTID.
> 
> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Fails to build:

Error in reading or end of file.
drivers/net/wireless/ath/ath11k/dbring.c: In function 'ath11k_dbring_buffer_release_event':
drivers/net/wireless/ath/ath11k/dbring.c:271:8: error: assignment to 'struct ath11k_dbring *' from incompatible pointer type 'struct ath11k_db_ring *' [-Werror=incompatible-pointer-types]
  271 |   ring = ath11k_spectral_get_dbring(ar);
      |        ^
cc1: some warnings being treated as errors
make[5]: *** [drivers/net/wireless/ath/ath11k/dbring.o] Error 1
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [drivers/net/wireless/ath/ath11k] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [drivers/net/wireless/ath] Error 2
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

2 patches set to Changes Requested.

11594295 [1/2] ath11k: Add direct buffer ring support
11594297 [2/2] ath11k: add support for spectral scan

-- 
https://patchwork.kernel.org/patch/11594295/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

