Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97611767628
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 21:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjG1TRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjG1TRD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 15:17:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C063A81
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 12:17:02 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SBNs1P019604;
        Fri, 28 Jul 2023 16:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9FTt/DU5nps82E4MJofHYXAzrKE/lBseUwoDim5U53Y=;
 b=X18kP44f8rjvghF5p11A7+BrL6mWtH9U6RTuUOOk9IBBRED0502IwbVvcuWTkMduHOFg
 FHMVIJOT/OrWsX8ABY2jBAPpl0TCWwNjJBKBtOMfqirQ7TgUxIoRzayxDVNesp7nz+EE
 vddzi2sM+D62AfWp5GQa5BwON4UKqN5QdIBFMecVYGxvAyZ1f6pOGqy9NsRhIRAGQPu6
 Vno/jZQdcoI/XW2LEr2SRa2PQ6fThle5x9A9muMYLb59TekOk/lifYJK5JzhaLyBt1v0
 VHTtuwJ9Y2kEy0JgR1jCRDrD657A4o7mvnMxJZrQBpWn0gj7TbifyNG/YbDKhGCqn3Gu uQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s46ttheu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 16:48:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SGm6SL030722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 16:48:06 GMT
Received: from [10.111.176.45] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 09:48:06 -0700
Message-ID: <f5164a1c-dc36-48cf-10fa-2a671f36867a@quicinc.com>
Date:   Fri, 28 Jul 2023 09:48:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mwifiex: added code to support host mlme.
Content-Language: en-US
To:     David Lin <yu-hao.lin@nxp.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
References: <PA4PR04MB9638100B3F21D083F386C6D9D106A@PA4PR04MB9638.eurprd04.prod.outlook.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <PA4PR04MB9638100B3F21D083F386C6D9D106A@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g-lhsWR6W_klWmTbGMEUZO6nDkW6LBcm
X-Proofpoint-GUID: g-lhsWR6W_klWmTbGMEUZO6nDkW6LBcm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280152
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/27/2023 11:18 PM, David Lin wrote:
> 1. For station mode first.
> 2. This feature is a must for WPA3.
> 3. The code is tested with IW416. There is no guarantee for other chips.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> ---
>   .../net/wireless/marvell/mwifiex/cfg80211.c   | 327 +++++++++++++++++-
>   drivers/net/wireless/marvell/mwifiex/cmdevt.c |   2 +-
>   drivers/net/wireless/marvell/mwifiex/decl.h   |  12 +
>   drivers/net/wireless/marvell/mwifiex/fw.h     |  15 +
>   drivers/net/wireless/marvell/mwifiex/init.c   |   3 +
>   drivers/net/wireless/marvell/mwifiex/join.c   |  65 +++-
>   drivers/net/wireless/marvell/mwifiex/main.c   |   4 +
>   drivers/net/wireless/marvell/mwifiex/main.h   |  10 +
>   drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
>   .../net/wireless/marvell/mwifiex/sta_event.c  |  17 +-
>   .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   1 +
>   drivers/net/wireless/marvell/mwifiex/sta_tx.c |  10 +-
>   .../net/wireless/marvell/mwifiex/uap_cmd.c    |  25 ++
>   drivers/net/wireless/marvell/mwifiex/util.c   |  74 ++++
>   14 files changed, 558 insertions(+), 13 deletions(-)

I just did a quick scan to see if anything jumped out at me

...

> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> index f2168fac95ed..e2827e25ec38 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h

..

> +#define MWIFIEX_AUTHTYPE_SAE 6
> +
> +struct mwifiex_ie_types_sae_pwe_mode {
> +       struct mwifiex_ie_types_header header;
> +       u8 pwe[1];

this jumped out, it is not allowed (unless this really is a 1-element array)

see 
<https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays>

should just be u8 pwe[];

make sure any code that uses sizeof(struct 
mwifiex_ie_types_sae_pwe_mode) accounts for the u8 being removed from 
the struct


> +} __packed;

