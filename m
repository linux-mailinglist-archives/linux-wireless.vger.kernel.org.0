Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894345FAA9B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 04:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJKC2m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 22:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJKC2l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 22:28:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE101857F3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 19:28:39 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B2EYK5006524;
        Tue, 11 Oct 2022 02:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lDVOT3gWzcE/ugYWnD3R2HCAa38o2zK8bwba2ar4P68=;
 b=p8Qt4c+bIA8ONoOTn2ITsSwyjWN6hPVcpKsqc8BsCrPUIkbPEmjd4UzRfznLrkX9PQRv
 aZA98WPHnsnL2UZRrEuG3KjOx/6fLguwnjSv9sKNwUlDTmDKxA3xkHGnDTgiUFCRyh3c
 6S6bQ3BmsQPUiF08hCoavnSSzMRKUZXuqYRVj3hUUIoNsUJm24pWjggKE/aN/cUCsBm1
 oFutKFLq4JZOVVVSfCs1j11U6v8WHQsK2hFEDDeK89hfb5XPqbKvnLtJGzFI2UrHt20+
 pbx8Snb1E9ukuNzT1gYUApNNkBeL/VtBZoOlf+cw4tDGqmEH/hQnhaCbtx+5GIzxdOLA +w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rxc8shf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 02:28:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29B2SSuL029191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 02:28:28 GMT
Received: from [10.253.78.175] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 19:28:26 -0700
Message-ID: <776991f3-384e-f487-83b7-e1fbfd40cc4f@quicinc.com>
Date:   Tue, 11 Oct 2022 10:28:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 00/27] another set of MLO patches
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
In-Reply-To: <96bcc467-c530-46de-8f91-c5eb0af7a368@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Of5OnLqflmA4SHIT5JG4YFFfSqr7f85t
X-Proofpoint-GUID: Of5OnLqflmA4SHIT5JG4YFFfSqr7f85t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_01,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210110011
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ilan/Andrei,

Will you send your patches of wpa_supplicant to upstream?😁

On 9/28/2022 11:12 PM, Wen Gong wrote:
> On 9/12/2022 9:17 PM, Otcheretianski, Andrei wrote:
>>>> Well, OK, you obviously are adjusting the supplicant to work with MLO
>>>> (otherwise you wouldn't get an MLO connection in the first place), so
>>>> yeah, this is part of the adjustments needed.
>>>>
>>>> Ilan/Andrei have all of this working, maybe we can share the patches
>>>> even before rebase etc.
>> Hi,
>> Our implementation is based on our internal tree, so it will take 
>> some time to cleanup and port it for upstream.
>> Hopefully I will have some time to work on it this and next week and 
>> maybe we will be able to share something initial.
> May I get your patches?
>>
>> Andrei
>>>> johannes
>>> Thanks.
>>>
>>> It is good to share me the wpa_supplicant patches ASAP.
>>>
>>> And I have another question:
>>>
>>> When mac80211 use the MLD addr in authentication/assoc request,
>>>
>>> finally, it should be replaced with one link's address in air port, 
>>> right?
>>>
>>> It means the MLD addr will never exist in mac80211 header of packet 
>>> in the
>>> air port, right?
