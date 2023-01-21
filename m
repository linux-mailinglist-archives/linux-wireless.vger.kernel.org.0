Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C79676598
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jan 2023 11:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjAUKMd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Jan 2023 05:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjAUKMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Jan 2023 05:12:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE6166C8
        for <linux-wireless@vger.kernel.org>; Sat, 21 Jan 2023 02:12:23 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30LAAuaX004767;
        Sat, 21 Jan 2023 10:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HhikkN011FZIylbXBQZJ+of3LXxc/Vkor6GsU1cFCkM=;
 b=O2JQQH4WCSW6oj0sgFon+MMYk+Im4NopWUW7Xclz5P2rKHEGHPckkQ6mwNuHSy6z7Nlx
 mvMX3Mj69QZfqQ9xjeOabk3h2vEkuix09pFQhwMYVguV6K1sgelOIli1+okF/jE0oPTc
 7G6ebfYMgQIBfPOmUDfe+lwdRwxd/dEiy72hkmFoIiVtdv9/0XkC1M2nGvccqD2r/x5V
 rc7Anco/IAXv19gwd9t0WVbz0NFKCxo1qcGUKUoCJhBA4M2wEebnphhdVSVyYptUANGy
 eH6p7fFiC7sK8AfHrzXch1aM3kPaSEerlREAARyF7aKt5cs/Toat2tbUIw3V7oaV12Wx XQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89f589bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 10:12:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30LACJWv004332
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 10:12:19 GMT
Received: from [10.216.53.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 21 Jan
 2023 02:12:17 -0800
Message-ID: <0c3a8227-6499-1899-5e7a-3a956323da11@quicinc.com>
Date:   Sat, 21 Jan 2023 15:42:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] wifi: cfg80211: Extend
 cfg80211_update_owe_info_event() for MLD AP
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20221206080226.1702646-1-quic_vjakkam@quicinc.com>
 <20221206080226.1702646-3-quic_vjakkam@quicinc.com>
 <47838da1d6563d10ba3a2fe0e747c59eb4ae75b3.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <47838da1d6563d10ba3a2fe0e747c59eb4ae75b3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KNV0rvR1b0QJw15t2TQcaNhIyF5t1CH4
X-Proofpoint-GUID: KNV0rvR1b0QJw15t2TQcaNhIyF5t1CH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_04,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=525 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301210099
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 1/18/2023 9:12 PM, Johannes Berg wrote:
> On Tue, 2022-12-06 at 13:32 +0530, Veerendranath Jakkam wrote:
>> + * @assoc_link_id: Indicates link ID of the AP MLD link on which (re)association
>> + *	requested by peer. In non-MLD AP mode, it will be -1. Used only with OWE
>> + *	update event (driver to user space).
>> + * @peer_mld_addr: MLD address of the peer. For non-MLD peer, it will be all
>> + *	zeros. Used only with OWE update event (driver to user space).
>
> Similar here - why require setting assoc_link_id == -1 if
> peer_mld_address can be left zeroes to indicate non-MLO connection?


"assoc_link_id" will be set to -1 when the AP operating in non-MLD mode, 
in that case peer_mld_addr can always be ignored since STAs always 
connects in non-MLO mode only.

When the AP operating in MLD mode, "assoc_link_id" should always be 
filled irrespective of the STA is MLD or not. This is needed to indicate 
user space about the event belong which affiliated AP of the AP MLD.

"peer_mld_addr" filled to indicate whether the peer is MLD or not.

Ex: if the AP operating in MLD mode and connected STA is non-MLD then 
"peer_mld_addr" will be all zeros but still "assoc_link_id" will set 
link ID of the corresponding AP under the AP MLD.

---

veeru





