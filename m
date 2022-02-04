Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F359C4A9468
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 08:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349682AbiBDHSb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 02:18:31 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:17982 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349571AbiBDHSb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 02:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643959111; x=1675495111;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Mvpl4YWb3cLuRU6iu/slEEgzV2MZtVQ+RZukju3fa/Y=;
  b=JsramQm5GE4YV5Fl+9PIspT/X9BzvjRd/Yp9Y7efSivXdddZ0ql3Yeac
   f19Boc6HCfQMQr6HrZF6Ogc6bVsU9obstYzFZJ0s1wHYHuYfrYVeIvQjy
   Yf7gLVYrMWDusUlIr8CS0FVctLcL/5X5hKfrMbw1ny5srmJawvUvzqRuG
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Feb 2022 23:18:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 23:18:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 23:18:30 -0800
Received: from [10.213.109.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 3 Feb 2022
 23:18:27 -0800
Subject: Re: [PATCH 3/6] nl80211: add support to send EHT capabilities from
 userspace
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vikram@quicinc.com>,
        <quic_alokad@quicinc.com>, <quic_jiad@quicinc.com>,
        <quic_periyasa@quicinc.com>, <quic_msinada@quicinc.com>,
        <quic_srirrama@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
 <1640163883-12696-4-git-send-email-quic_vjakkam@quicinc.com>
 <3189c4ca8ae154a37d8bb69b7f9043b4ac30bbe5.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Message-ID: <d6f91c9a-db93-2243-c642-6183d338af45@quicinc.com>
Date:   Fri, 4 Feb 2022 12:48:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3189c4ca8ae154a37d8bb69b7f9043b4ac30bbe5.camel@sipsolutions.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/3/22 6:17 PM, Johannes Berg wrote:
> On Wed, 2021-12-22 at 14:34 +0530, Veerendranath Jakkam wrote:
>> +#define NL80211_EHT_MIN_CAPABILITY_LEN           10
>>
> And that's 13, no? You have to support 80 MHz.
>
> johannes

I considered fixed fields lengths only for minimum length.

But I agree that we can include minimum possible length of MCS-NSS Set 
field also.


