Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A094A4690A8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 08:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbhLFHON (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 02:14:13 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:27811 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhLFHOM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 02:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638774645; x=1670310645;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fbVwg0B5GwJLw1W8+Pmo/+Yfmm7M604GMenCQ8i1h8I=;
  b=xDQVPxREN0CxmNxRYY3JjjWcVmbDA82eG77EMJq1TDkx/6iMI/aog7Yc
   Q61CSmspZ9bgW9/zgbyw6slf239CqXyR+S9QegvDT9o4pL8WhnQxMg+RK
   Yp3RU8WZJ0xS9If8NQUDXHW0OfDwIQy391OfVlvfpTM346safKgTEaVAC
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 05 Dec 2021 23:10:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 23:10:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 5 Dec 2021 23:10:43 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 5 Dec 2021
 23:10:42 -0800
Message-ID: <71ee85b5-8d8c-c6e5-20a2-d225800de2ba@quicinc.com>
Date:   Mon, 6 Dec 2021 15:10:40 +0800
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
 <7318ffac-f5ec-4c1b-3e80-c816bdb28a79@quicinc.com>
 <7418334.kqliQQpNxi@ripper>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <7418334.kqliQQpNxi@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/6/2021 2:56 PM, Sven Eckelmann wrote:
> On Monday, 6 December 2021 04:29:39 CET Wen Gong wrote:
> [...]
>> I did test in my setup, not see the crash.
>>
>> I am afraid you also need this patch("ath11k: change to use dynamic
>> memory for channel list of scan",
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20211129110939.15711-1-quic_wgong@quicinc.com
>> )
>>
>> Could you apply this patch and try again?
> Tried it and I see the same problem.
Could you tell what is your test steps?
>
> Kind regards,
> 	Sven
