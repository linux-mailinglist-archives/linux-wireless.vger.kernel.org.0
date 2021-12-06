Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0189468FB5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 04:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhLFDdM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Dec 2021 22:33:12 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:1243 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236194AbhLFDdM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Dec 2021 22:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638761384; x=1670297384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sB/d1mkmPUKJT68Yrx31VUTayqORBAAs9fOSofT7vuo=;
  b=wUnFHfuMuq13SNWkCss7xchfGxyzu5OkCC06rbymGkD3ZHKUHySzWXy2
   i4oNE51mPU8yBodjO3a8kq/K9/MV+9rVKvlJSbxFgzxv9fI0T+Bt8VWzz
   EpScbdfuzGslkFXDFk3QHuIrNU1cGRPe4JlNbfksO6OPR0yMwlPeZvdyx
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Dec 2021 19:29:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 19:29:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 5 Dec 2021 19:29:43 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 5 Dec 2021
 19:29:42 -0800
Message-ID: <7318ffac-f5ec-4c1b-3e80-c816bdb28a79@quicinc.com>
Date:   Mon, 6 Dec 2021 11:29:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for
 WCN6855
Content-Language: en-US
To:     Sven Eckelmann <sven@narfation.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20211129101309.2931-1-quic_wgong@quicinc.com>
 <1854698.r8H18GsEis@ripper>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <1854698.r8H18GsEis@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/3/2021 10:09 PM, Sven Eckelmann wrote:
> On Monday, 29 November 2021 11:13:09 CET Wen Gong wrote:
...
> I've tested this on ath-next on commit a93789ae541c ("ath11k: Avoid NULL ptr
> access during mgmt tx cleanup") with a WCN6856 card (EmWicon/jjplus WMX7205)
> with firmware WLAN.HSP.1.1-02892.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1. ath-next
> was required for me because 32 MSI vectors are not available on the
> used system.
>
> Without this patch, it works fine. With patch, I just have to connect to an AP
> via wpa_supplicant to crash the system. See the attached x86-64 .config, the
> stacktrace and the decoded stacktrace.

I did test in my setup, not see the crash.

I am afraid you also need this patch("ath11k: change to use dynamic 
memory for channel list of scan",

https://patchwork.kernel.org/project/linux-wireless/patch/20211129110939.15711-1-quic_wgong@quicinc.com 
)

Could you apply this patch and try again?

> Kind regards,
> 	Sven
