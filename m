Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F211F3503
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFIHgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 03:36:05 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37231 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgFIHgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 03:36:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591688164; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2S8jjaIxaL+rFw6a6rIsjTP2YlHKLBy4tIQRKCGilzs=;
 b=o1cfWMRHNDcHRYMdpPIxIQt9xHU3XopYhfg9ZJMstjXWhdZ/fYoSpKmq7ADrSFGcJ1dlszcI
 v1VIDHaU4mOX6OcUYvQNckCzIRMlWuDvxiqEkn5DB9oXhhQmS+f4chZoMxLO8kRdvRGMGJNh
 DtoF+xy6c6oMMp7W6pqKxq8ITWs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5edf3bd196950fa0ffd49856 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 07:35:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0497DC433C6; Tue,  9 Jun 2020 07:35:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1379C433C6;
        Tue,  9 Jun 2020 07:35:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Jun 2020 13:05:43 +0530
From:   Karthikeyan periyasamy <periyasa@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] ath11k: Add direct buffer ring support
In-Reply-To: <20200609063958.C3869C43391@smtp.codeaurora.org>
References: <1591673945-25300-1-git-send-email-periyasa@codeaurora.org>
 <20200609063958.C3869C43391@smtp.codeaurora.org>
Message-ID: <b48ac64d3defa14e65ca1fa40b65b857@codeaurora.org>
X-Sender: periyasa@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>> Add direct buffer ring (dbring) with helper API, which is used by the
>> spectral scan. Initialise the direct buffer ring based on the dma ring
>> capability, which get announced in the wmi service ready extended 
>> event.
>> This ring is slightly changed from data path rings. Compare to data 
>> path
>> ring this ring shares the hp and tp address to firmware though WMI 
>> commands.
>> Also the replenish buffer size is derived from firmware announcement.
>> driver receive indication through WMI event
>> WMI_PDEV_DMA_RING_BUF_RELEASE_EVENTID.
>> 
>> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> 
> Fails to build:
> 
> Error in reading or end of file.
> drivers/net/wireless/ath/ath11k/dbring.c: In function
> 'ath11k_dbring_buffer_release_event':
> drivers/net/wireless/ath/ath11k/dbring.c:271:8: error: assignment to
> 'struct ath11k_dbring *' from incompatible pointer type 'struct
> ath11k_db_ring *' [-Werror=incompatible-pointer-types]
>   271 |   ring = ath11k_spectral_get_dbring(ar);
>       |        ^
> cc1: some warnings being treated as errors
> make[5]: *** [drivers/net/wireless/ath/ath11k/dbring.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [drivers/net/wireless/ath/ath11k] Error 2
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [drivers/net/wireless/ath] Error 2
> make[2]: *** [drivers/net/wireless] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
> 
> 2 patches set to Changes Requested.
> 
> 11594295 [1/2] ath11k: Add direct buffer ring support
> 11594297 [2/2] ath11k: add support for spectral scan


My bad, fixed this build error in the next version patch

Thanks,
Karthikeyan
