Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB14A944A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 08:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348137AbiBDHMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 02:12:22 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:63911 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237837AbiBDHMV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 02:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643958741; x=1675494741;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XZwQJXS9L8X4LWr3d0+vWQOIuaJQw6IHSKV/yPtlNEE=;
  b=Aizah2fuafRyKCkB6JNl1u7jKo0BYX5CyGLMXNEOyadoJX9he/Bwiufv
   fP7st4ZTkv5g+EU6n0lHYuI338FFB1uz5vezgNby0yZuJDzKNTSyXClsM
   OlxU3QtLbFuR9jsy0JstUwXcECnQqjm01cN5PNLk79yFTvKvxMYQ+w3x/
   E=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Feb 2022 23:12:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 23:12:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 23:12:19 -0800
Received: from [10.213.109.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 3 Feb 2022
 23:12:16 -0800
Subject: Re: [PATCH 3/6] nl80211: add support to send EHT capabilities from
 userspace
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vikram@quicinc.com>,
        <quic_alokad@quicinc.com>, <quic_jiad@quicinc.com>,
        <quic_periyasa@quicinc.com>, <quic_msinada@quicinc.com>,
        <quic_srirrama@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
 <1640163883-12696-4-git-send-email-quic_vjakkam@quicinc.com>
 <5ede1e1ad04b6359eafb658e827abf6a8343355f.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Message-ID: <0644274d-7a9f-642c-eef2-02c662a5adcc@quicinc.com>
Date:   Fri, 4 Feb 2022 12:42:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5ede1e1ad04b6359eafb658e827abf6a8343355f.camel@sipsolutions.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/3/22 6:15 PM, Johannes Berg wrote:
> On Wed, 2021-12-22 at 14:34 +0530, Veerendranath Jakkam wrote:
>>   
>> +#define NL80211_EHT_MIN_CAPABILITY_LEN           10
>> +#define NL80211_EHT_MAX_CAPABILITY_LEN           81
>>
> How did you get to 81?
>
> I calculate only 51, based on the assumption that we can only have
> NSS==8. Even if you think NSS==16 (which I doubt), I get to 80 only?
>
> johannes

I considered max values for NSS and RU Index Bitmask sub-fields in PPE 
threshold field.

i.e. NSS=16, RU Index Bitmask = 0x11111 with this max PPE threshold info 
sub-field length is 60 bytes


Max PPE thresholds field length = 4 bits (for NSS) + 5 bits (for RU 
Index Bitmask) +  480 bits (PPE info) + 7 bits (PPE pad)= 62 bytes

EHT fixed fields length = 10 bytes

Max MCS-NSS Set field length = 9 bytes

So total max length would be 81 bytes
