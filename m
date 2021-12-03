Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F98467142
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 05:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354713AbhLCEyS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 23:54:18 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2416 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243582AbhLCEyM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 23:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638507049; x=1670043049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rn6guE8t3ATE79e1Z/gD4ZZpnsVGldU9vizoH3ue/2c=;
  b=j2bUN2rg7CbQD47easQaaUkt7WjALm9z92jU9ewWQdyjVNRLjb8hMouo
   AMlOHuigC20cRW8pQ/hfldiV9Mj1O/UrKYmA8CEyRRImMZpDc2fDqWEWM
   z9aTQCgx7OHbBsKywYic0/5hhNE1cP9sBq33OGmQ1a5+3jKZ41AX0Gf07
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Dec 2021 20:50:46 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 20:50:46 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 20:50:45 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 2 Dec 2021
 20:50:44 -0800
Message-ID: <2b017c54-9f2a-ed9d-7593-44663a64bda2@quicinc.com>
Date:   Fri, 3 Dec 2021 12:50:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] ath11k: add regdb.bin download for regdb offload
Content-Language: en-US
To:     Sven Eckelmann <sven@narfation.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20211202083616.15406-1-quic_wgong@quicinc.com>
 <2715590.fzSe1J7v7S@sven-l14>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <2715590.fzSe1J7v7S@sven-l14>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/3/2021 2:36 AM, Sven Eckelmann wrote:
> On Thursday, 2 December 2021 09:36:16 CET Wen Gong wrote:
>> The regdomain is self-managed type for ath11k, the regdomain info is
>> reported from firmware, it is not from wireless regdb. Firmware fetch
>> the regdomain info from board data file before. Currently most of the
>> regdomain info has moved to another file regdb.bin from board data
>> file for some chips such as QCA6390 and WCN6855, so the regdomain info
>> left in board data file is not enough to support the feature which need
>> more reg rules such as 6 GHz LPI, SP and VLP.
> But for the latter, you are also missing the patch to support the
> WMI_REG_CHAN_LIST_CC_EXT_EVENTID (with the 6GHz specific fields in the struct
> wmi_reg_chan_list_cc_ext_event)? Otherwise it should not be possible to
> get the 6GHz reg rules (which you showed in your commit message).
>
> struct wmi_reg_chan_list_cc_event (for WMI_REG_CHAN_LIST_CC_EVENTID) supports
> only 2.4GHz and 5GHz.

WMI_REG_CHAN_LIST_CC_EVENTID also support 6 GHz, But it dose not support
6 GHz LPI, SP and VLP.

I did test with the board-2.bin/m3.bin/amss.bin(without regdb.bin) of this commit
https://github.com/kvalo/ath11k-firmware/commit/0b1d1b2e10f9839ee0675a2ac496bfeb87c304c1.
It only support country US. After added regdb.bin, it support many country.

So regdb.bin is needed now.

>
> Kind regards,
> 	Sven
>
> [1] https://source.codeaurora.org/quic/qsdk/oss/system/feeds/wlan-open/tree/mac80211/patches/302-ath11k-Add-support-to-parse-new-wmi-event-for-6G-reg.patch?h=NHSS.QSDK.11.4.0.5
