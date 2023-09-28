Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5E7B290F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 01:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjI1XzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 19:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1XzI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 19:55:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC02195
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 16:55:05 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SNna2E019218;
        Thu, 28 Sep 2023 23:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ajkDRXkDdyhUV5/B51ivip+xpDc5MtY44NUk+Ovakx4=;
 b=AyWZ7HNpC7RDwCzr6aITGHMo6uaqf1+MGzhbSw5rYdA71lLcLHWZOB2P7h14tf1Ta9TL
 84LLrs+j2eP+t0pcntUqPyOupgewOW9AseLyJKYVHIsLaKAQwMn0X1XM89bKlkutqh4P
 wyQPmtSsDYySc3hI3nN9LRSFcbwy09kq+GeFpqzm3qcUNOtZQ2BILrM6yRKYmUEE9Lf7
 91l42HVFUURUGrsRYA6oiaJh5Kxyu2MY07ymRXcQqPd8/6D60w6zEf1CWqap2qfw2W2J
 v4Q5a54Y8aUFmTBzRZ2EnCg/FyW8YWeVAsm74DhJIb30arW7DuTaEdC4InQzj+3WvXGU PA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tda4c18p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 23:54:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SNsmK7012987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 23:54:48 GMT
Received: from [10.111.177.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 16:54:48 -0700
Message-ID: <ae8e358d-3d02-4167-9232-5da8a2ec3d1c@quicinc.com>
Date:   Thu, 28 Sep 2023 16:54:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] wifi: mac80211: mesh: fix some kdoc warnings
Content-Language: en-US
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Benjamin Berg <benjamin.berg@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
 <20230928172905.33fea2968c62.I41d197b570370ab7cad1405518512fdd36e08717@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230928172905.33fea2968c62.I41d197b570370ab7cad1405518512fdd36e08717@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vxGQTr-mRopFpO-5N5GhuPRURsfg866r
X-Proofpoint-ORIG-GUID: vxGQTr-mRopFpO-5N5GhuPRURsfg866r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_22,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=824 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/28/2023 7:35 AM, gregory.greenman@intel.com wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> These were mostly missing or incorrectly tagged return values.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>   net/mac80211/mesh.c         |  8 ++++++--
>   net/mac80211/mesh_hwmp.c    |  2 ++
>   net/mac80211/mesh_pathtbl.c | 20 +++++++++++++-------
>   net/mac80211/mesh_plink.c   |  6 +++++-
>   net/mac80211/mesh_ps.c      |  6 +++++-
>   net/mac80211/mesh_sync.c    |  4 +++-
>   6 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
> index 0d0fbae51b61..9b1fd43df6ef 100644
> --- a/net/mac80211/mesh.c
> +++ b/net/mac80211/mesh.c
> @@ -56,6 +56,8 @@ static void ieee80211_mesh_housekeeping_timer(struct timer_list *t)
>    *
>    * This function checks if the mesh configuration of a mesh point matches the
>    * local mesh configuration, i.e. if both nodes belong to the same mesh network.
> + *
> + * Returns: %true if both nodes belong to the same mesh

I thought kdoc used Return: not Returns:

<https://static.lwn.net/kerneldoc/doc-guide/kernel-doc.html#function-documentation>
