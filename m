Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17794A9EFB
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 19:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377489AbiBDS2z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 13:28:55 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:1404 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiBDS2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 13:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643999335; x=1675535335;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gGXxcn/I4FDA8zQ8eDbbx2gjnQfNH5E+2CDrGurTGI8=;
  b=MjO4OOKWFYAIE/m4Wv5QdtonDalDkgwpoX0P+6xQJ+2WTprsH8D5o50u
   bkkvCPlmLIF9M0d2PUBtJ7VkzZsuSNX0Ldu7ry7T08XTs/LNEXkU//AcF
   ZutReesh4sCM1amHDIt7+g3zET17bb0Ec4+28WQXUm6XwnD8GaD6mBQO2
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 04 Feb 2022 10:28:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 10:28:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 4 Feb 2022 10:28:54 -0800
Received: from [10.213.109.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 4 Feb 2022
 10:28:51 -0800
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
 <382a29fe-dea3-7d32-2aeb-16ba18e9da28@quicinc.com>
 <91d3b826accb22194c9fa3134cd1f3137950e863.camel@sipsolutions.net>
 <9bd12810-19a7-ad74-6577-d43c4b2ab9e5@quicinc.com>
 <6f175b75991159fe99abb9efbcb105eefb3734db.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Message-ID: <9eb5ee07-204e-5e7e-6996-502bd7a19329@quicinc.com>
Date:   Fri, 4 Feb 2022 23:58:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6f175b75991159fe99abb9efbcb105eefb3734db.camel@sipsolutions.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/4/22 11:15 PM, Johannes Berg wrote:
> On Fri, 2022-02-04 at 23:13 +0530, Veerendranath Jakkam wrote:
>>
>>> Also in your later nl80211 patch I'm thinking we should combine the
>>> HE/EHT GI settings etc., there's no point duplicating all the enums,
>>> though we might want to do some renaming.
> I actually just decided against that ... it gets messy because we still
> need the attributes, and the GI is the only one that's entirely the
> same, so I think probably duplicating that is more understandable (all
> the EHT stuff belongs together)...
>
>> meanwhile I will upload new patch set with the suggested changes in last
>> patch.
> No need. I'm doing rework on this, and we also have mac80211 assoc
> patches, STA capabilities, etc. I'll send it all out soon.
>
> johannes


Thank a lot for your assistance. Looking forward to see your patches.. :)


veeru


