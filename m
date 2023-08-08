Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97C47749FD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 22:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjHHUJY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHHUI6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 16:08:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20DAEBA7
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 11:41:27 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378HsJXk004748;
        Tue, 8 Aug 2023 18:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CYWKzFLj8tPIOt1AQ64shes+ojHmHSR8wJf/9q4ibbI=;
 b=XrN7hesrCIt1u18mjYTOtkD4q2BfZcsty7pcLP/1oAr0vPpUWA35TZNJ2dJ0wgbXC02p
 4FMO4qXKzHR5MPZhLv6JuzAOIRHS0//18v6bYyNNAMbqjtZ60dhoNqc9BqfSAL6IKm0O
 aoqlpqqBCq9dAB6N+wOt7iu6RdYTIscEoX+xYHWJX/t4tkcRKkeVTxSnOQWbRBm5aAvH
 hwchd8+hKFWU8n661XqpD7yv/yZ+P8SJV5bCKugHtCo70cXbH6RUhFvg3GX6nCBIaj3W
 8Uq/FerECYzsv3ePUFgss3RXq8wqkppRqHjKO+Vu0ECHTLAIfl8dBx7+gG9WsARq7xAa mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbpqs0nv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:41:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 378IfIVW021423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 18:41:18 GMT
Received: from [10.111.180.219] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 11:41:17 -0700
Message-ID: <0daa237a-43bc-e5d0-3069-dea9b4263521@quicinc.com>
Date:   Tue, 8 Aug 2023 11:41:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] wifi: cfg80211: Add short_beacon_tail/head/period
Content-Language: en-US
To:     Bassem Dawood <bassem@morsemicro.com>, <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        kernel test robot <lkp@intel.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
References: <20230417012151.2512303-1-gilad.itzkovitch@virscient.com>
 <20230808102732.37270-1-bassem@morsemicro.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230808102732.37270-1-bassem@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HoJaINOKBpyDUKJRq4weoicSdOcDIaOl
X-Proofpoint-ORIG-GUID: HoJaINOKBpyDUKJRq4weoicSdOcDIaOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_15,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=946 malwarescore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/8/2023 3:27 AM, Bassem Dawood wrote:
[snip]
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index 88eb85c63029..03df70b0238e 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2794,6 +2794,12 @@ enum nl80211_commands {
>    *	indicates that the sub-channel is punctured. Higher 16 bits are
>    *	reserved.
>    *
> + * @NL80211_ATTR_SHORT_BEACON_PERIOD: (u16) period for S1G long beacon
> + * @NL80211_ATTR_SHORT_BEACON_HEAD: portion of the S1G short beacon before
> + *  the TIM element
> + * @NL80211_ATTR_SHORT_BEACON_TAIL: portion of the S1G short beacon after
> + *  the TIM element
> + *
>    * @NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS: Maximum number of peers that HW
>    *	timestamping can be enabled for concurrently (u16), a wiphy attribute.
>    *	A value of 0xffff indicates setting for all peers (i.e. not specifying
> @@ -3346,6 +3352,10 @@ enum nl80211_attrs {
>   
>   	NL80211_ATTR_PUNCT_BITMAP,
>   
> +	NL80211_ATTR_SHORT_BEACON_PERIOD,
> +	NL80211_ATTR_SHORT_BEACON_HEAD,
> +	NL80211_ATTR_SHORT_BEACON_TAIL,
> +

This is a UAPI so all additions must go at the end to avoid renumbering 
the values of existing enumerations

>   	NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS,
>   	NL80211_ATTR_HW_TIMESTAMP_ENABLED,


