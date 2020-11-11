Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54B22AE828
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 06:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKKF3k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 00:29:40 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:28250 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKKF3k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 00:29:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605072579; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=cnDR0YphiWKlpCg7dESEcebK4sYiGb7IsL1nhcrG9wA=;
 b=U6zBSZPdrglGQatGb963k9grEEeNR4mrliRTjEX2Vm+gx3msnL77zEQNZmQcLJamlcrdAw0u
 XDMIISWB4hhrZDuLvMWlCTIOJk7UQWJs7XHw4m18+ZtYLHuIfjuGdM0kgQ9mOFDyq+tPGA6p
 V6AhHCkAXDSV09wQhtQiZWXlgvY=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fab76bde9dd187f53602a55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 05:29:33
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D44ADC433CB; Wed, 11 Nov 2020 05:29:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E2F0C433C9;
        Wed, 11 Nov 2020 05:29:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Nov 2020 10:59:32 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ritesh Singh <ritesi@codeaurora.org>
Subject: Re: [PATCH 1/3] ath11k: vdev delete synchronization with firmware
In-Reply-To: <20201110182825.3D1C6C433FE@smtp.codeaurora.org>
References: <1590067829-26109-2-git-send-email-mkenna@codeaurora.org>
 <20201110182825.3D1C6C433FE@smtp.codeaurora.org>
Message-ID: <40170802ba4bc4787c126004a42be3e8@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-10 23:58, Kalle Valo wrote:
> Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:
> 
>> From: Ritesh Singh <ritesi@codeaurora.org>
>> 
>> When the interface is added immediately after removing the
>> interface, vdev deletion in firmware might not have been
>> completed.
>> 
>> Hence, add vdev_delete_resp_event and wait_event_timeout
>> to synchronize with firmware.
>> 
>> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
>> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> 
> Does not apply anymore, please rebase.
> 
> error: patch failed: drivers/net/wireless/ath/ath11k/wmi.c:97
> error: drivers/net/wireless/ath/ath11k/wmi.c: patch does not apply
> stg import: Diff does not apply cleanly
> 
> 3 patches set to Changes Requested.

[Maha]: Sure, Kalle. I will rebase and send the next version of this 
patch.

> 11562969 [1/3] ath11k: vdev delete synchronization with firmware
> 11562967 [2/3] ath11k: peer delete synchronization with firmware
> 11562971 [3/3] ath11k: remove "ath11k_mac_get_ar_vdev_stop_status" 
> references

Regards,
Maha
