Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9417F4DAB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343929AbjKVRAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 12:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343949AbjKVRAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 12:00:18 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F840D4F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 09:00:09 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM5kqvv001503;
        Wed, 22 Nov 2023 17:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8EOJSRYPLqPXHPZGRUzlNJH1g+ch6nOGv/DJ2p8JkQY=;
 b=JLzG59JpdvVbWhtJcBKLn1/YMxAbhEyVJAWRDRO6i8GMMejnUmpXZrMIeYAYa56hoEP0
 fdfvCq/KtKwtrWvDbeKcT8mn6LGImtkBuCl7sh+ZDewhDn0k2QSYadSiaDwtFe2Je+fn
 JqIU5t3VhAuK8YuvKpb3SGsnSBBRfyv5X9D7TGvPjva4XcNRCSZc+k5sqNsvbaj0IZH9
 q6c/sgwQvuz1zVEyiX4ffOWNqo+prwmGDHj5lqwFTM1Ezl46TMQqerYA7ma8eJ1OPqnb
 dLQ+mdzK7jz7pwHbtqD3YO0oNmEm+iDLIQzoE10tuzw8YgVuXhTrcVsPHRkuc145xfhB wA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh477jkb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 17:00:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMH06HL019532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 17:00:06 GMT
Received: from [10.110.116.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 09:00:06 -0800
Message-ID: <4ea9d009-0fdc-4d91-b134-38f7f7f0a19a@quicinc.com>
Date:   Wed, 22 Nov 2023 09:00:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/12] wifi: ath11k: add support to select 6 GHz
 regulatory type
Content-Language: en-US
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231122091553.10837-1-quic_bqiang@quicinc.com>
 <20231122091553.10837-2-quic_bqiang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231122091553.10837-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ygyoXNHVVt6sq87xoFXo3b76p1epSH82
X-Proofpoint-GUID: ygyoXNHVVt6sq87xoFXo3b76p1epSH82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=787 clxscore=1015
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/22/2023 1:15 AM, Baochen Qiang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> There are 3 types of regulatory rules for AP mode and 6 type for
> station mode. Add wmi_vdev_type and ieee80211_ap_reg_power to
> select the exact reg rules.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

you need to add your Signed-off-by: to all patches that you are reposting

let me review the series for any additional comments before you post a
corrected v8

