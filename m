Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C01F3A20
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 13:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgFILyZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 07:54:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:53437 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728926AbgFILyY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 07:54:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591703664; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RYKgxD4b+eTBChAp0PClGRzy5JiZAHQYJs8m2IKmXDQ=;
 b=ZmxPClj64YVPvb3qw9D0tFWNBmiZOD+4Z/34/tD2LsJKACYIavcNFPALQkHtuwWVjOq8p1Ms
 Waz6U2F7fmS81iJlZxgZ/6s4J2Zq9F3cbDrKFKv7hJveAFjsWNQCPZsBOBS11RBpXNM6Yw7c
 8baTgPw7d0DTwHgNKAdczmt9Rtc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5edf7865d26ace6bd54254f3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 11:54:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07E4BC43391; Tue,  9 Jun 2020 11:54:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A230C433CA;
        Tue,  9 Jun 2020 11:54:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Jun 2020 17:24:12 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ritesh Singh <ritesi@codeaurora.org>
Subject: Re: [PATCH 3/3] ath11k: remove "ath11k_mac_get_ar_vdev_stop_status"
 references
In-Reply-To: <20200528073034.F14B9C43387@smtp.codeaurora.org>
References: <1590067829-26109-4-git-send-email-mkenna@codeaurora.org>
 <20200528073034.F14B9C43387@smtp.codeaurora.org>
Message-ID: <80107de209f1149ecae07a50a7cf86a9@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-28 13:00, Kalle Valo wrote:
> Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:
> 
>> Unused structure ath11k_vdev_stop_status is removed.
>> 'ath11k_mac_get_ar_vdev_stop_status' api has been replaced
>> with 'ath11k_mac_get_ar_by_vdev_id' inside vdev_stopped_event.
>> 
>> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
>> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> 
> What about other firmware branches? For example, will this break
> 2.1.0.1 branch support?

[Maha]: It won't break 2.1.0.1 branch as it is host related change.


Regards,
Maha
