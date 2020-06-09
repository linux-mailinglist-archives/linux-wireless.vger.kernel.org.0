Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4631F3A81
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 14:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgFIMRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 08:17:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36506 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgFIMRF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 08:17:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591705024; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=HvKg9uqXcOXFeXObsKPAXDyp1GGyMd07gt2phDpNo6w=;
 b=LGFdbok26VAdfK4M6zq5VetxHx3JkMjG765Y0E7xaqCtxpN12/Y/WdgqmChUc8F47yzTNe6K
 w3xO06/ENHOOivk8lWC3henmRhaGuzdwNh/1ilRPu5cAMygMQh+Q4kjm+PBrNhBCRaknVnDy
 GtYuiKyQs3vbPr41buPya7Kk9GA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5edf7da7c4bb4f886d60eafe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 12:16:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D148C43387; Tue,  9 Jun 2020 12:16:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D6EB6C433C6;
        Tue,  9 Jun 2020 12:16:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Jun 2020 17:46:37 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ritesh Singh <ritesi@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 3/3] ath11k: remove "ath11k_mac_get_ar_vdev_stop_status"
 references
In-Reply-To: <87tuzkmosd.fsf@codeaurora.org>
References: <1590067829-26109-4-git-send-email-mkenna@codeaurora.org>
 <20200528073034.F14B9C43387@smtp.codeaurora.org>
 <80107de209f1149ecae07a50a7cf86a9@codeaurora.org>
 <87tuzkmosd.fsf@codeaurora.org>
Message-ID: <0fdcc91bc6e9ffd7d924e306895cf903@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-09 17:31, Kalle Valo wrote:
> Maharaja Kennadyrajan <mkenna@codeaurora.org> writes:
> 
>> On 2020-05-28 13:00, Kalle Valo wrote:
>>> Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:
>>> 
>>>> Unused structure ath11k_vdev_stop_status is removed.
>>>> 'ath11k_mac_get_ar_vdev_stop_status' api has been replaced
>>>> with 'ath11k_mac_get_ar_by_vdev_id' inside vdev_stopped_event.
>>>> 
>>>> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
>>>> 
>>>> Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
>>>> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
>>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>> 
>>> What about other firmware branches? For example, will this break
>>> 2.1.0.1 branch support?
>> 
>> [Maha]: It won't break 2.1.0.1 branch as it is host related change.
> 
> What do you mean with "host related changed" exactly? In patch 1 I see
> that you add a new handler for WMI_VDEV_DELETE_RESP_EVENTID event. So
> firmware functionality is very much involved here, right? For example,
> do all branches send that event to the host?

[Maha]: You are right, Stop event will come for all the firmware.
So, it won't break with other firmware branches.
we just replaced the ath11k_mac_get_ar_vdev_stop_status by 
ath11k_mac_get_ar_by_vdev_id.

Regards,
Maha
