Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D110778C98B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjH2QVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbjH2QV2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 12:21:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7741B7
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 09:21:21 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TFIxhD022304;
        Tue, 29 Aug 2023 16:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wrifinfUNjN2a6frI/lQmHrmVv1T42T/rB1KTiQ8AE8=;
 b=QMrcMmP9+0Br0iZk+1X+LjUyzixVvtl42cK1xqFNtrQ9JW4OcAF+EXB7VHVxXPOqMAMr
 gJlh6DuvF9TqkYaxe3/F2TxAWKqE+iTW1c5AQFolJELtFwBZSTu+KjDTo02qv1R0Sux+
 zobkz+yxf8nBfrodOlhvV9/4c4jbof7TXTYbfQdPtcCHN9lGlWA1AMuYpoflveTMbTyq
 t8w9q/R8C0n3521VT1KbeDNbOgjKUuj7Y1JSOLZceIk7I+iHJnx6W5RAIPYKQC32w1yA
 KCU8tCkLvN8f4XhGn3Vxzgdf1C3Nn6ztn5WNiKO7H4Z7pVMlkKlZ9XZwwYEA/WHaw4Cq SA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srybqatn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 16:21:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TGLE6O029111
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 16:21:14 GMT
Received: from [10.48.245.159] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 09:21:13 -0700
Message-ID: <5b809506-7fea-4598-b6ae-39ea94cc2849@quicinc.com>
Date:   Tue, 29 Aug 2023 09:21:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: cfg80211: remove scan_width support
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        Xinyue Ling <quic_xinyling@quicinc.com>
References: <20230829121742.634a0631eaf3.I38b5dcce8b130f93743a2d43ab9d89269b937b5d@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230829121742.634a0631eaf3.I38b5dcce8b130f93743a2d43ab9d89269b937b5d@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -fav5xm7vIM-reOrXKNwFqctlotyJvAH
X-Proofpoint-GUID: -fav5xm7vIM-reOrXKNwFqctlotyJvAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/29/2023 3:17 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There really isn't any support for scanning at different
> channel widths than 20 MHz since there's no way to set it.
> Remove this support for now, if somebody wants to maintain
> this whole thing later we can revisit how it should work.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   drivers/net/wireless/ath/wil6210/wmi.c        |  2 -
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  1 -
>   include/net/cfg80211.h                        | 63 +---------------
>   include/uapi/linux/nl80211.h                  |  2 +-
>   net/mac80211/ibss.c                           | 30 ++------
>   net/mac80211/ieee80211_i.h                    |  3 +-
>   net/mac80211/ocb.c                            |  5 +-
>   net/mac80211/scan.c                           | 71 ++++---------------
>   net/wireless/mesh.c                           |  5 +-
>   net/wireless/nl80211.c                        |  1 -
>   net/wireless/scan.c                           | 23 +-----
>   net/wireless/trace.h                          |  6 +-
>   net/wireless/util.c                           | 14 ++--
>   13 files changed, 35 insertions(+), 191 deletions(-)

Just want to remind that there were two proposals given to allow setting 
this from upstream:
<https://lore.kernel.org/all/20230301090242.1613672-1-quic_xinyling@quicinc.com/>

In the thread you asked for additional information:
<https://lore.kernel.org/all/6796c3c209a071983d330ca145d7ab8b929d53c6.camel@sipsolutions.net/>

So to see if there is any update on that request Cc: Xinyue Ling 
<quic_xinyling@quicinc.com>

Would hate to see this ripped out just to need to replace it later.

/jeff

