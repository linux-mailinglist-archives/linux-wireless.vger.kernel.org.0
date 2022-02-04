Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1EE4A9B1A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 15:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359359AbiBDOhn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 09:37:43 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:28849 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359353AbiBDOhm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 09:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643985462; x=1675521462;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DJszCNuVGBSFUG4gd+j9U/uy0cDXbjKkT1aFDoaQ3Ag=;
  b=wbZzSgnFu6LvVk7dFbWrwfHV/JhY8r9176NebJnqjLS5PWReJQIwEY+F
   M2mSe5O6dn8uayvdd1UwrvrCtfqsUSAKh9I6JUZ+l0D8nMLgcye5cXxKg
   zW5hD+v4Wt+bDb7cRrDQBKqIfmlxxujJXlVXdV8XMoML1Ue0qJAZhSAMh
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Feb 2022 06:37:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 06:37:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 4 Feb 2022 06:37:42 -0800
Received: from [10.213.109.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 4 Feb 2022
 06:37:39 -0800
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
 <0644274d-7a9f-642c-eef2-02c662a5adcc@quicinc.com>
 <0c0ba8cebb877384172b5bd314cbbbb035d1f348.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Message-ID: <382a29fe-dea3-7d32-2aeb-16ba18e9da28@quicinc.com>
Date:   Fri, 4 Feb 2022 20:07:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0c0ba8cebb877384172b5bd314cbbbb035d1f348.camel@sipsolutions.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/4/22 1:41 PM, Johannes Berg wrote:
> On Fri, 2022-02-04 at 12:42 +0530, Veerendranath Jakkam wrote:
>>> I calculate only 51, based on the assumption that we can only have
>>> NSS==8. Even if you think NSS==16 (which I doubt), I get to 80 only?
>> So total max length would be 81 bytes
>>
> Right. Now I don't know how I got to 80...
>
> Regardless, I don't think NSS>8 is actually valid, the PHY spec always
> says it's max of 8, so I think we can safely limit to 51?
>
> johannes


There are some references for NSS > 8, ex: Table 9-33a, P802.11be_D1.3 
hence I used 81.

Please let me know if you would like this to be changed to 51

