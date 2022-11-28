Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FB263A359
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 09:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiK1IpX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 03:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiK1IpV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 03:45:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723FD17AB9
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 00:45:19 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS5oJTA018909;
        Mon, 28 Nov 2022 08:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jus7okDsZiVBsZ9MUogqbWkyxD8xss8oPtgSM/wya8E=;
 b=OP+6AisnARUAinT/mzBAuipCEOlbrR1Kn+Ggl4DW0ypWsVoP0cJ5T10ks9Vemb4vHFWq
 Rb6CQCXT0KDxi4Yx5Mg/0RzlyyxqPEbzAtLi1ijr4AZPhdrUarXlVCqrAS5XxAnJa2Ar
 67X6g678m9BeT5p8hXQ0eQBGBEene9nnRrspQdcLUZCj6Uh8sMaQ5kicNDWaKqdeiyBQ
 A8l3oVA7V3xVyTA7/lsHFH/HEgFwqVeOfWa9KZL5hqbQjlSIBrStKx1Yq5jUsg1AkL1r
 jeTa31MBVZvlt5GZyEmhmOotuh1cpo8wG9f+9WsVPiHbPtVEJtNON+jVpvg87iFUPiiY 5w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m3bywutuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 08:45:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AS8j7j7025262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 08:45:07 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 28 Nov
 2022 00:45:05 -0800
Message-ID: <a3edddb2-82e4-2c79-564f-1918b59aead9@quicinc.com>
Date:   Mon, 28 Nov 2022 16:45:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: wifi: hostapd:/wpa_supplicant MLO Re: [PATCH 00/27] another set
 of MLO patches
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Peer, Ilan" <ilan.peer@intel.com>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
 <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
 <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
 <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
 <f3afceb8-8120-12c7-74b9-caa3abce5cb8@quicinc.com>
 <DM6PR11MB3897D1A4E13419D9F938F559F5449@DM6PR11MB3897.namprd11.prod.outlook.com>
 <96bcc467-c530-46de-8f91-c5eb0af7a368@quicinc.com>
 <776991f3-384e-f487-83b7-e1fbfd40cc4f@quicinc.com>
 <de54f4e0-810b-70a0-7629-39a2957ecd3d@quicinc.com>
In-Reply-To: <de54f4e0-810b-70a0-7629-39a2957ecd3d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lyAcXvc_U3sxVIY_J-_kUeEDSB16VFEV
X-Proofpoint-GUID: lyAcXvc_U3sxVIY_J-_kUeEDSB16VFEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_07,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280067
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Andrei,

Is below all your patches for MLO in wpa_suppplicant for station mode?

[00/13] MLD STA: Add SME MLO support

https://patchwork.ozlabs.org/project/hostap/list/?series=329909&state=*

On 10/19/2022 6:04 PM, Wen Gong wrote:
> Hi Ilan/Andrei,
>
> Will you send your patches of wpa_supplicant for MLO to upstream?😁
>
> On 10/11/2022 10:28 AM, Wen Gong wrote:
>> Hi Ilan/Andrei,
>>
>> Will you send your patches of wpa_supplicant to upstream?😁
>>
>> On 9/28/2022 11:12 PM, Wen Gong wrote:
>>> On 9/12/2022 9:17 PM, Otcheretianski, Andrei wrote:
>>>>>> Well, OK, you obviously are adjusting the supplicant to work with 
>>>>>> MLO
>>>>>> (otherwise you wouldn't get an MLO connection in the first 
>>>>>> place), so
>>>>>> yeah, this is part of the adjustments needed.
>>>>>>
>>>>>> Ilan/Andrei have all of this working, maybe we can share the patches
>>>>>> even before rebase etc.
>>>> Hi,
>>>> Our implementation is based on our internal tree, so it will take 
>>>> some time to cleanup and port it for upstream.
>>>> Hopefully I will have some time to work on it this and next week 
>>>> and maybe we will be able to share something initial.
>>> May I get your patches?
>>>>
>>>> Andrei
>>>>>> johannes
>>>>> Thanks.
>>>>>
>>>>> It is good to share me the wpa_supplicant patches ASAP.
>>>>>
>>>>> And I have another question:
>>>>>
>>>>> When mac80211 use the MLD addr in authentication/assoc request,
>>>>>
>>>>> finally, it should be replaced with one link's address in air 
>>>>> port, right?
>>>>>
>>>>> It means the MLD addr will never exist in mac80211 header of 
>>>>> packet in the
>>>>> air port, right?
