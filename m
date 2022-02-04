Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971BD4A9DEC
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 18:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377040AbiBDRnr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 12:43:47 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:17062 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377078AbiBDRnq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 12:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643996626; x=1675532626;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jOgeMI/q0s8ZpC74gONTo8NGB0DW6o/6tpNdHhxYJRg=;
  b=sYDYzddvqRL8Izn6p6GBm/c2omMmd+kf15KwW2QkX1vdLUxOEdnPExaO
   Yb9Ppyw6VtBZgTJ/PooBypuwmhC1PhZhDxU8abh6R9DcLQxc/g6WURaxS
   75E+9i02nQkRWPo9rTYLrjhHEuznu5HQy3/hMMliYnztOfEr7zLaOpMjG
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 04 Feb 2022 09:43:46 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 09:43:46 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 4 Feb 2022 09:43:45 -0800
Received: from [10.213.109.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 4 Feb 2022
 09:43:42 -0800
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
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Message-ID: <9bd12810-19a7-ad74-6577-d43c4b2ab9e5@quicinc.com>
Date:   Fri, 4 Feb 2022 23:13:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <91d3b826accb22194c9fa3134cd1f3137950e863.camel@sipsolutions.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/4/22 8:13 PM, Johannes Berg wrote:
> On Fri, 2022-02-04 at 20:07 +0530, Veerendranath Jakkam wrote:
>> There are some references for NSS > 8, ex: Table 9-33a, P802.11be_D1.3
>> hence I used 81.
> Right, the spec confuses me. In a lot of places it reserves enough space
> for 8 < NSS <= 16, but then it has e.g. Table 36-40 with 4 bits, but
> saying "for up to 8 spatial streams" (MU-MIMO). And even for OFDMA it
> states in a lot of places that the maximum is only 8.
>
>> Please let me know if you would like this to be changed to 51
>>
> Nah, don't worry. I think it probably doesn't even really *matter*, we
> can safely leave it at 81 anyway (I had evidently miscalculated as 80
> before, so I was confused).
>
> We also already had some patches in this area, and I'm just working on a
> combination - e.g. in your first patch I don't like the use of FIELD_GET
> so much, preferring uXX_get_bits(), but Ilan already had patches here
> that deal with that.
>
> For many of the other patches, Ilan and you arrived at a literally bit-
> identical version of things!
>
> So I think I'm going to pick a couple of things from him and a couple of
> things from you, and send out a combined series. Perhaps later today, if
> I manage to get it done.


Sure, Thanks for the update.

> Also in your later nl80211 patch I'm thinking we should combine the
> HE/EHT GI settings etc., there's no point duplicating all the enums,
> though we might want to do some renaming.
>
> Sounds OK?
>
> johannes


Yeah, This looks fine for me.

meanwhile I will upload new patch set with the suggested changes in last 
patch.

