Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B1476F0A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 11:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhLPKmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 05:42:00 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:36818 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhLPKmA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 05:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639651320; x=1671187320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ce6TWqHLh9socF/wU+/riY2KrQOak3CF37lCpR67frU=;
  b=vF0EcSewzCiIR+gR5/03GMd21lzBtiZyxVLYgz/TD66R2uX44Oy0Vyiv
   HrJqQbUciLCjA9BdFfX4kJx/+2SN5Tf2j8rF1LxLeLQHIdm+xDIPonTwR
   XuT1nbb1p+wjC1cDCNAC3j8kAcvxigwp9bNba3b0+F64KMNT9DBFolkCe
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Dec 2021 02:42:00 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 02:41:59 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 16 Dec 2021 02:41:59 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 16 Dec
 2021 02:41:58 -0800
Message-ID: <2aecb0d6-6710-d460-4505-0594ae7a55a2@quicinc.com>
Date:   Thu, 16 Dec 2021 18:41:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ath11k: report tx bitrate for iw wlan station dump
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20211213102723.4857-1-quic_wgong@quicinc.com>
 <87y24ngjaa.fsf@codeaurora.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87y24ngjaa.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/15/2021 1:58 AM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
...
> I briefly tested this and tx rate didn't look correct to me:
>
> $ iw wlan0 link
> Connected to xx (on wlan0)
> 	SSID: <censored>
> 	freq: 2442
> 	RX: 8838 bytes (80 packets)
> 	TX: 1551 bytes (15 packets)
> 	signal: -104 dBm
> 	rx bitrate: 39.0 MBit/s MCS 4
> 	tx bitrate: (unknown) MCS 253
Yes, I reproduced this strange tx bitrate value after try with 3 AP.
AP1: tx bitrate:     144.4 MBit/s VHT-MCS 7 short GI VHT-NSS 2
AP2: tx bitrate:     286.7 MBit/s HE-MCS 11 HE-NSS 2 HE-GI 0 HE-DCM 0
AP3: tx bitrate:     (unknown) MCS 254
I will check it.
>
> I guess the signal isn't correct either, are you planning to fix it also
> at some point?
I have sent patch to fix signal:
[v2] ath11k: add signal report to mac80211 for QCA6390 and WCN6855
https://patchwork.kernel.org/project/linux-wireless/patch/20211216070535.31732-1-quic_wgong@quicinc.com/

The new signal value of "iw wlan station dump":
         signal:         -50 [-51, -55] dBm
> Also I see new warnings with this patch:
>
> [  174.373905] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
> [  174.386303] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
> [  174.388733] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
> [  174.472723] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
> [  174.573331] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
> [  174.838234] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
> [  174.881577] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
> [  174.985640] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
> [  175.076154] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
> [  175.113921] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
> [  180.206378] ath11k_warn: 34 callbacks suppressed
> [  180.206396] ath11k_pci 0000:06:00.0: failed to find the peer by id 14
>
