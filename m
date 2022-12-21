Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2F652BFE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 05:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiLUEDc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 23:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUED3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 23:03:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D798513DF7
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 20:03:27 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL3tien014587;
        Wed, 21 Dec 2022 04:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gMrGCfKxPrrwY87VGowNJZG2KWyCdqUNdxWrMP6Zwdw=;
 b=GZzTfPsOexkG3rHQdcBC4n3mid2vPGSPqKks8rolWBp7QT5bqFlXatn1IHyRMAw6k45c
 53+KB8reLxWOjcBl0Z80UjQW0GBCxbL03qoR29Pv/J199OOoen1D0t9J73TCq1ebTXla
 8gSTA56rMF21xYihwqxgAGJ5maeVpN9+3kp4wfMexFBm7Jo2wHdSrKsm+2EYMVS5u4QQ
 9CgexhO53lPV4Y2Q8DtK45vpACH5mE42jJSXUWqFaJcyaUNEoQm+rltMuC+xJeLnhM4t
 WtONSfv/3x9s7uCh8eZ65oLzhTcUw6gqBMYbWzUfEuRPu9qpOpKK/e5+yD4UC5Hzal0K eA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjyk53aj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 04:03:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BL43IHC024879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 04:03:18 GMT
Received: from [10.252.219.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 20:03:17 -0800
Message-ID: <2861463e-a097-7efe-bc75-f13c8faf9547@quicinc.com>
Date:   Wed, 21 Dec 2022 09:33:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] wifi: ath11k: Optimize 6 GHz scan time
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20221220043823.20382-1-quic_mpubbise@quicinc.com>
 <5DAEA8B2-2B44-4A91-9E57-12B6C6B6C1FC@holtmann.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <5DAEA8B2-2B44-4A91-9E57-12B6C6B6C1FC@holtmann.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y9HFeA0E8069duueKJ1ADO2TxwOFpX3z
X-Proofpoint-ORIG-GUID: Y9HFeA0E8069duueKJ1ADO2TxwOFpX3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_01,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210026
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/20/2022 6:36 PM, Marcel Holtmann wrote:
> Hi Manikanta,
> 
>> Currently, time taken to scan all supported channels on WCN6750
>> is ~8 seconds and connection time is almost 10 seconds. WCN6750
>> supports three Wi-Fi bands (i.e., 2.4/5/6 GHz) and the numbers of
>> channels for scan come around ~100 channels (default case).
>> Since the chip doesn't have support for DBS (Dual Band Simultaneous),
>> scans cannot be parallelized resulting in longer scan times.
>>
>> Among the 100 odd channels, ~60 channels are in 6 GHz band. Therefore,
>> optimizing the scan for 6 GHz channels will bring down the overall
>> scan time.
>>
>> WCN6750 firmware has support to scan a 6 GHz channel based on co-located
>> AP information i.e., RNR IE which is found in the legacy 2.4/5 GHz scan
>> results. When a scan request with all supported channel list is enqueued
>> to the firmware, then based on WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND
>> scan channel flag, firmware will scan only those 6 GHz channels for which
>> RNR IEs are found in the legacy scan results.
>>
>> In the proposed design, based on NL80211_SCAN_FLAG_COLOCATED_6GHZ scan
>> flag, driver will set the WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND flag
>> for non-PSC channels. Since there is high probability to find 6 GHz APs
>> on PSC channels, these channels are always scanned. Only non-PSC channels
>> are selectively scanned based on cached RNR information from the legacy
>> scan results.
>>
>> If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set in the scan flags,
>> then scan will happen on all supported channels (default behavior).
> 
> is this really a good idea? The interpretation on what scan results will
> be reported would be preferable the same no matter what hardware is
> present. Why would ath11k now have a different behavior?
> 
> And more important, why is this something driver or even Linux kernel
> specific. Let userspace select the frequencies to scan.
> 

By the way, userspace itself selects the frequencies to scan, not the 
driver.

If we see the split scan implementation in cfg80211, this is the how it 
is implemented. If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set, it selects 
all PSC channels and those non-PSC channels where RNR IE information is 
found in the legacy scan results. If this flag is not set, all channels 
in 6 GHz are included in the scan freq list. It is upto userspace to 
decide what it wants.

> Looks like that iwd and wpa_supplicant set this flag regardless which
> means to me that a driver should respect the requested frequencies to
> be scanned.
> 
> Anyhow, if you worry about time-to-connect, then fix userspace to be
> smart with scanning. I am also confused on how a savings of 1.5 seconds
> out of 8 seconds is significant.

Most of the times, we see ~2 seconds of savings. 2 seconds of scan time 
improvement out of 8 seconds is about 25% improvement and this is indeed 
significant.

8 seconds of time I'm talking here is for passive scan when the 
regdomain is set to WORLD. If correct regdomain is set and channel flags 
are proper, then the time it takes to complete scan & connection is much 
lesser with this change. It is around 4 seconds.

  It still means you spent 6+ seconds
> in the 2.4 GHz and 5 GHz bands. I assume that you spent most time in
> 5 GHz right now.
> 
> I highly doubt that a 6+ seconds plus 2 seconds connection time is
> anywhere acceptable
As I said before, this is the worst case scenario. Active scan and 
connection on legacy band takes less than 4 seconds in normal usecase.

  Have you tried using iwd and see what the
> connection time actually is after initial connection.
> 

Not really, I'll try it out. Thanks for the suggestion.

Thanks,
Manikanta
