Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DECA5B66FA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 06:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiIMEcY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 00:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIMEbz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 00:31:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79056B8E
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 21:27:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D3LUC6021254;
        Tue, 13 Sep 2022 04:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NQm8taxkIdJspYfeizD24D3FW2iOCfpoy3d9YXtyglo=;
 b=D+bm9yD3UDAuJfA51dHP1lgq75cK6hKMyXMEnHUn3G6+8QNMImvs10QVYqFNZBrEmqqE
 eUPen8Uj6X/tSddqrfbHaQWSqt2Gx+x+umqX9HyDJeP5ellA46i7C2JZ0tjSql9ncAip
 Svn3vTdJ4Sf3jua24OaTIeXCOb7/8CksTUPZAqvC2FBnBuTtPxFkhOortSzranylVFdE
 GIWXFj4s4YUuAbE4N9wdWK78SdIPxnLBbzMlst1+Bc0Yb4dHOJIpzUSGiyVRFPvnhFt6
 e/FCbvN6aaCpuv7H2DSligJbr3duq24efc+6eOkeUcMlPFWC0/zLOsz4uWp5oyGxCXH2 yg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjhu3r4cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 04:27:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D4R2fY011722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 04:27:02 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 21:27:01 -0700
Message-ID: <64549541-b18e-0627-f00c-4d364e8898c9@quicinc.com>
Date:   Tue, 13 Sep 2022 12:26:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 00/27] another set of MLO patches
Content-Language: en-US
To:     "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "Peer, Ilan" <ilan.peer@intel.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
 <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
 <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
 <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
 <f3afceb8-8120-12c7-74b9-caa3abce5cb8@quicinc.com>
 <DM6PR11MB3897D1A4E13419D9F938F559F5449@DM6PR11MB3897.namprd11.prod.outlook.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <DM6PR11MB3897D1A4E13419D9F938F559F5449@DM6PR11MB3897.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FFsWEE2HDL8_oz20KOTIMBA0sMSFBo81
X-Proofpoint-GUID: FFsWEE2HDL8_oz20KOTIMBA0sMSFBo81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_01,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130019
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/12/2022 9:17 PM, Otcheretianski, Andrei wrote:
>>> Well, OK, you obviously are adjusting the supplicant to work with MLO
>>> (otherwise you wouldn't get an MLO connection in the first place), so
>>> yeah, this is part of the adjustments needed.
>>>
>>> Ilan/Andrei have all of this working, maybe we can share the patches
>>> even before rebase etc.
> Hi,
> Our implementation is based on our internal tree, so it will take some time to cleanup and port it for upstream.
> Hopefully I will have some time to work on it this and next week and maybe we will be able to share something initial.
>
> Andrei

Thanks, waiting for your patches.

Does your patches of supplicant only support single link or support 
muti-link of MLO?

>>> johannes
>> Thanks.
>>
>> It is good to share me the wpa_supplicant patches ASAP.
>>
>> And I have another question:
>>
>> When mac80211 use the MLD addr in authentication/assoc request,
>>
>> finally, it should be replaced with one link's address in air port, right?
>>
>> It means the MLD addr will never exist in mac80211 header of packet in the
>> air port, right?
