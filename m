Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1A51F3A50
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgFIMCZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 08:02:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30404 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgFIMCX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 08:02:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591704143; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=wd4Bo0CqtMftMm7jBD9VlrOvgfzoGDIHMAGj3pgXL6Y=; b=j4Mm/XUHUCSvxuZx+a49YU284WjpNYjOYIFAst5VsaBsV6kG6sG5RElFBJA/0koshxW54T+j
 Lx3HiYCk6feDFwYnhgj0nMo6zcWSvCIky7Zc2JweNp6t2ogdpd6IFOO9ueIy1zt9rfbou0Ke
 mFQmyMtA3fXewW3qW5Ux5VjLCCE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5edf7a0aa3d8a44743950d6a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 12:01:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CAFE0C433C6; Tue,  9 Jun 2020 12:01:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26028C433CA;
        Tue,  9 Jun 2020 12:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26028C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     Ritesh Singh <ritesi@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 3/3] ath11k: remove "ath11k_mac_get_ar_vdev_stop_status" references
References: <1590067829-26109-4-git-send-email-mkenna@codeaurora.org>
        <20200528073034.F14B9C43387@smtp.codeaurora.org>
        <80107de209f1149ecae07a50a7cf86a9@codeaurora.org>
Date:   Tue, 09 Jun 2020 15:01:06 +0300
In-Reply-To: <80107de209f1149ecae07a50a7cf86a9@codeaurora.org> (Maharaja
        Kennadyrajan's message of "Tue, 09 Jun 2020 17:24:12 +0530")
Message-ID: <87tuzkmosd.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> writes:

> On 2020-05-28 13:00, Kalle Valo wrote:
>> Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:
>>
>>> Unused structure ath11k_vdev_stop_status is removed.
>>> 'ath11k_mac_get_ar_vdev_stop_status' api has been replaced
>>> with 'ath11k_mac_get_ar_by_vdev_id' inside vdev_stopped_event.
>>>
>>> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
>>> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>
>> What about other firmware branches? For example, will this break
>> 2.1.0.1 branch support?
>
> [Maha]: It won't break 2.1.0.1 branch as it is host related change.

What do you mean with "host related changed" exactly? In patch 1 I see
that you add a new handler for WMI_VDEV_DELETE_RESP_EVENTID event. So
firmware functionality is very much involved here, right? For example,
do all branches send that event to the host?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
