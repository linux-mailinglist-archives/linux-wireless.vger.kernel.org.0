Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2770E465C87
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 04:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355038AbhLBDOS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 22:14:18 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:23292 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355069AbhLBDOP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 22:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638414654; x=1669950654;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YEDLJoTCAsBp+M3JgQD45uLv2yfCKVYia8n2l6RpX/0=;
  b=zLh0/QDYMZleSg501JOUqOllifRlb3+SiDpb3171DllO5pSpUQhez3DJ
   AxLiz7iAm0iMmvdHvDFb0MyUVfKUSG5MQQEceEShO7azeVqArgKO8p+iO
   YNAv+46KjZWz7kblmAdIeiYTVq5NKDTrlgfPVlO7TtcgSHFHkMGXrGYOY
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 19:10:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 19:10:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 19:10:52 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 1 Dec 2021
 19:10:50 -0800
Message-ID: <c3769eeb-accd-2e31-78e4-d792e491b727@quicinc.com>
Date:   Thu, 2 Dec 2021 11:10:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] ath11k: add wait operation for tx management packets
 for flush from mac80211
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20211126064934.26490-1-quic_wgong@quicinc.com>
 <163836730490.316.5064011158500804861.kvalo@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <163836730490.316.5064011158500804861.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/1/2021 10:01 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> wrote:
>
>> ...
> Fails to apply:
>
> error: patch failed: drivers/net/wireless/ath/ath11k/mac.c:5224
> error: drivers/net/wireless/ath/ath11k/mac.c: patch does not apply
> stg import: Diff does not apply cleanly
>
> Patch set to Changes Requested.

The conflict is caused by below commit which commit on 2021-11-29, my v3 
patch is sent on 2021-11-26.

I will rebase it.

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/drivers/net/wireless/ath/ath11k/mac.c?id=a93789ae541c7d5c1c2a4942013adb6bcc5e2848

ath11k: Avoid NULL ptr access during mgmt tx cleanupath

