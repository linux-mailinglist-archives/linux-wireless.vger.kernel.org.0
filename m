Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F494C24D4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 08:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiBXH7j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 02:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiBXH7j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 02:59:39 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3E62465D4
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 23:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645689546; x=1677225546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QmLN3tStZtRIrZYMhJObjNbtDYBgSAccqAAfvbubH0U=;
  b=KiDbWfZ1QHJCpYPfWACZp3u1E4OFUXCvyqP6FjBv8nypHJlmfslyz6rO
   d3TkChxFpdfO6H8hrl0LI927115rcdqLKnW99/1gP4fvE4QUgyz1hh6Z3
   DBbNuZTX1pJNU8l3XqZXGpFMllUi3Tb2sLjv8HWBBdfIpYpvZnJU2BVVU
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Feb 2022 23:59:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 23:59:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 23:59:05 -0800
Received: from [10.216.15.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 23 Feb
 2022 23:59:03 -0800
Message-ID: <b0b9d6c8-9b0e-6aec-8fd1-d6a4d3e26202@quicinc.com>
Date:   Thu, 24 Feb 2022 13:29:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/3] cfg80211: Add NL80211_IFTYPE_MLO_LINK type for MLO
 links on MLD STA
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_usdutt@quicinc.com>
References: <1645613200-30221-1-git-send-email-quic_vjakkam@quicinc.com>
 <1645613200-30221-2-git-send-email-quic_vjakkam@quicinc.com>
 <269dcdce-ca21-211f-9f87-bc1dfc7d29b2@broadcom.com>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <269dcdce-ca21-211f-9f87-bc1dfc7d29b2@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2/23/2022 6:09 PM, Arend van Spriel wrote:
> On 2/23/2022 11:46 AM, Veerendranath Jakkam wrote:
>> In contrast, NL80211_IFTYPE_MLO_LINK can't be used to represent AP MLO
>> link since an MLD AP must support pre-11be and 11be clients
>> simultaneously so each AP MLO link affiliated with AP MLD must also act
>> as independent AP for pre-11be clients so each AP MLO link must be
> 
> Not just for pre-11be clients. 11be clients can opt-out right?
> 

I think as of now spec is mandating to use multi-link capabilities in 
11BE association. Anyways, current design is allows single link 11be 
connections also in case if it is going to be allowed by spec in future.


-- 
- veeru
