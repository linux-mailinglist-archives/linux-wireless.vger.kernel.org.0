Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557DE676552
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jan 2023 09:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjAUIzk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Jan 2023 03:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjAUIze (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Jan 2023 03:55:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3B265F00
        for <linux-wireless@vger.kernel.org>; Sat, 21 Jan 2023 00:55:32 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30L8jPOo006064;
        Sat, 21 Jan 2023 08:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VT3gdqmdYNrkQDnFHZsLbEbJsJKcMkleVZP+7NyTuIQ=;
 b=JU8tj70Kf4JbRrY9GfHHRb5P/EgwSLYrWX8FPQ/0LKMkPJ0mV2owZu2H1y6QHLIWnsot
 Ca7DkAa67XC3RUfY4a74IoNx7AgEcAwDQyygynr9K6vA83FLWM/CAIEEwJ3wdKTOn4qP
 VqRjOOtADNPnw714cMf0JeAN8PLj0/HdRbw+24qz4UfLowDM+WcwxIR6E1s57njrVcfV
 VHf0XGzMRBMDoHgNKJPk7PUh5Jz6hEp9s+EdapMFQ4QzuwKl7C7iV5k7WxfTR7sNVtv/
 IUeL8U/6CZAtS9dmk2lhsrRyKMO0ILvPjuSLvNFZqGopC8iY6+HWTOxKPqsbh8nts18G 8A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89htr6ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 08:55:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30L8tSF2028763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 08:55:28 GMT
Received: from [10.216.53.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 21 Jan
 2023 00:55:26 -0800
Message-ID: <ee6c0210-8bec-f924-4f5d-e2f23395a58a@quicinc.com>
Date:   Sat, 21 Jan 2023 14:25:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] wifi: cfg80211: Extend cfg80211_new_sta() for MLD AP
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20221206080226.1702646-1-quic_vjakkam@quicinc.com>
 <20221206080226.1702646-2-quic_vjakkam@quicinc.com>
 <f6a13b05feb05eb648dbd4b6f91932d75b353fbf.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <f6a13b05feb05eb648dbd4b6f91932d75b353fbf.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7V1-Lt3FVUDWa_TiwTNq4eHWjpkVFERx
X-Proofpoint-GUID: 7V1-Lt3FVUDWa_TiwTNq4eHWjpkVFERx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_04,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=712 suspectscore=0 clxscore=1015 phishscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301210086
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks Johannes for reviewing the patches.


On 1/18/2023 9:11 PM, Johannes Berg wrote:
> Hi,
>
>> + * @mlo_params_valid: Indicates @assoc_link_id and @mld_addr fields are valid.
>> + *	Drivers use this only in cfg80211_new_sta() calls when AP MLD's MLME/SME
>> + *	is offload to driver. Drivers won't fill this information in
>> + *	cfg80211_del_sta_sinfo(), get_station() and dump_station() callbacks.
>>
>> + * @mld_addr: MLD address if the station is an MLD. Otherwise, set to all zeros.
>
>> +	if (sinfo->mlo_params_valid) {
>> +		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
>> +			       sinfo->assoc_link_id))
>> +			goto nla_put_failure;
>> +
>> +		if (!is_zero_ether_addr(sinfo->mld_addr) &&
>> +		    nla_put(msg, NL80211_ATTR_MLD_ADDR, ETH_ALEN,
>> +			    sinfo->mld_addr))
>>
>
> It'd be invalid, but now you could have mlo_params_valid == true &&
> is_zero_ether_addr(sinfo->mld_addr), which would lead to a very strange
> situation for userspace, it would see a link ID but no MLD address.


Only link ID and no MLD address also a valid combination. It indicates 
the connected STA is non-MLD.  User space needs the link ID information 
to determine "STA connected to which affiliated AP of the AP MLD".

>
> With the documented requirement that
> 	mlo_params_valid == (mld_addr is valid)


No, I think there is some misinterpretation of the documentation here. 
Let me submit new patch-set after adding more detailed text in the 
documentation.

Actually what I mean,  cfg80211 can consider parsing both the 
"assoc_link_id" and "mld_addr" fields when "mlo_params_valid" is true. 
"assoc_link_id" will be set to link ID of the affiliated AP on which STA 
(MLD/non-MLD) completed association. "mld_addr" will be set to MLD 
address of the STA if applicable (i.e., MLD STA) . Otherwise, will be 
set to zeros (i.e., non-MLD STA).

--

veeru

