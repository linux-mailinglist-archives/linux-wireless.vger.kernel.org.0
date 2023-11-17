Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432497EF7E5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 20:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjKQTf0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 14:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjKQTfZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 14:35:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852E5B6
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 11:35:22 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHJVAo4016374;
        Fri, 17 Nov 2023 19:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8byxBhH7wXFu++Zwxc85DKH2QvBYYahRzsH7zwtBEpc=;
 b=mZByX0z0avEossBxnNwPKm1DsNroTDrKlHANPLSCQ9ECC/ElunoMrrgSu8rYb+7v7Ij4
 NmPwwb8Gs96FgoTRz1dYRdW1XjNX6rTfETn8dvyfhkJnlhpAh3q1dGNXWeQl2gsN54MK
 XopLkw7i98mexgAAKZxX5r19fJTG4fFOfSVlLNORmBVNWAL+YDHJL1Rqmlv0Wr6aFNf9
 ttgg9Jf699TXDYRwVtJTDkb/3QbO/ceLCu8XFu4E7OUKsdr1D38zpYgor6e4rwWNqsvG
 m2nECpZK2zNrXha0SvLXOr1UNwy3dwLzmIPafSXz/pX6aqDIRG1aSKac1ZdvKDIK6ywZ SA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udt8btj7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 19:35:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHJZIIC022386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 19:35:18 GMT
Received: from [10.110.1.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 17 Nov
 2023 11:35:17 -0800
Message-ID: <3ec5a1d3-a645-4289-821d-f9d04cd401a8@quicinc.com>
Date:   Fri, 17 Nov 2023 11:35:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: Rename bssid to peer_addr in
 cfg80211_pmksa
Content-Language: en-US
To:     Anuj Khera <quic_akhera@quicinc.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20231117120843.29164-1-quic_akhera@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231117120843.29164-1-quic_akhera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d2y_6R8leuNXZg13ueIdYKMa7vAIow8A
X-Proofpoint-GUID: d2y_6R8leuNXZg13ueIdYKMa7vAIow8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_18,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=705 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170149
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/17/2023 4:08 AM, Anuj Khera wrote:
> The cfg80211_pmksa structure uses bssid member to store
> the PMKSA for a BSS in Station mode. Change the name of
> structure member bssid to peer_addr so that same member
> can be used to store the PMKSA for a station in AP mode
> using station MAC address.
> 
> Signed-off-by: Anuj Khera <quic_akhera@quicinc.com>
> ---

..snip..

> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index b137a33a1b68..0bacd705c030 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -3370,7 +3370,7 @@ enum wiphy_params_flags {
>   *	threshold to generate a new PMK before the current one expires.
>   */
>  struct cfg80211_pmksa {
> -	const u8 *bssid;
> +	const u8 *peer_addr;

are you missing a related kernel-doc change?

