Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309517A7041
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 04:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjITCMk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 22:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjITCMj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 22:12:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E7BBE
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 19:12:33 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K1JKxU006060;
        Wed, 20 Sep 2023 02:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=10EeeZpDflKUk7CQvRG7jyrqOr8t7dL3SSXQ+LokSVo=;
 b=gr+tlDDnPj01hMcJmE9KS91PNGJOQzrV58MeMYM6dGb1t2neSMY2+pIJnKQBZuGqO4ZB
 odj7O2F37SfMPO+jgliong2oRVsdMPqEprr6GEC5NdWHtVs5ix/hwpMXmuiT5ZVSkl5L
 RP2MFumcCzM6ymloc53xB0A8vgtUVclWsompXv1CCoNQf/H4fbR+azuNZKSGdfdnIu/o
 rH9ilclJn93z0gOXFmHD0yc6SNmkjoaP4dNXaQpNeTxiI3Rggl6mxcWv4hzoYXM306Db
 Au3UkpU3qzIpI0q2PPa1awc/MgY1JFYvNjPSu/rAEl96b/FFbdW7uWyL6y36EDJZ0Ugr cA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t77wna2eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 02:12:29 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K2CSXt016530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 02:12:29 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 19:10:31 -0700
Message-ID: <46b69fe7-d007-18b0-baae-e59ffb035e42@quicinc.com>
Date:   Wed, 20 Sep 2023 10:10:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/7] wifi: ath12k: add support to select 6 GHz Regulatory
 type
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Aishwarya R <quic_aisr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
 <20230919071724.15505-2-quic_aisr@quicinc.com>
 <4282f92a-3543-4863-bc00-478ae03759e0@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <4282f92a-3543-4863-bc00-478ae03759e0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rY6A1WNRQhVsqUY6oyMPQF9KiZSrUn17
X-Proofpoint-GUID: rY6A1WNRQhVsqUY6oyMPQF9KiZSrUn17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=783 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200015
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/20/2023 1:47 AM, Jeff Johnson wrote:
> On 9/19/2023 12:17 AM, Aishwarya R wrote:
>> There are 3 types of regulatory rules for AP mode and 6 types for
>> STATION mode. This is to add wmi_vdev_type and ieee80211_ap_reg_power
>> to select the exact reg rules.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Wen,
> Can you provide a "Tested-on: WCN7850" tag for this series?
>
Jeff, it is this tag below.

I have not tested this serials on WCN7850.

Should I test this serials on WCN7850?

Tested-on: WCN7850 hw2.0 PCI 
WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

[...]

