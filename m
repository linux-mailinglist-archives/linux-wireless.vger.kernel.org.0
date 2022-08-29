Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEF95A424B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 07:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiH2Faa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 01:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH2Fa2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 01:30:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A01C1704A
        for <linux-wireless@vger.kernel.org>; Sun, 28 Aug 2022 22:30:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T47rYN014243;
        Mon, 29 Aug 2022 05:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7JAuPFUgJ5bVpdlxV7UK5EHXLqVkEtstMPi2lQF8dNw=;
 b=ljcwAQoyFYhCGVQzDjErHd7jqU0le2nKeDTe1x1onONYrJQLDT9SQNxHooz8KpXjq1JO
 SofLRydhI40ySHXXxzptco8Bw+QxZX9+6HP5yvcTpf++UjR90FI+QaSmyCQVXN3N3a4X
 EWbzU1xdw6ROJb6bRTwBMtQW8DANzMtqG/moLORR/Oa6DG7xYhRrx2es4CuLDZpwmqFX
 PeiK6fDNjOaNw/OLkxtq2AXip54vBvbgWmfu9hE730uohA5iIXhMej+SHVxo63v53aON
 tmUiynUa4c1gBLBEVLdHYyEacL87eUR4zBS8VnNsjzHG9WWDMlQlaFDR1jHrHB4w5J7j Bg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j7c1qkgy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:30:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27T5UK9e025498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:30:20 GMT
Received: from [10.204.117.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 28 Aug
 2022 22:30:18 -0700
Message-ID: <7df6efae-0797-a27a-1372-db7ad16e71d2@quicinc.com>
Date:   Mon, 29 Aug 2022 11:00:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/4] ath11k: Enable low power mode when WLAN is not active
Content-Language: en-US
To:     Mark Herbert <mark.herbert42@gmail.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
 <ad99d238-dc1a-3233-fc6b-0cd49e428903@amd.com>
 <6daefd60-dcbc-06e1-8091-ea225690edf8@amd.com>
 <ecce8764-1760-4617-49aa-c111305ebd55@quicinc.com>
 <7e00cc36-3a07-92e2-c60e-a3c8939b407e@amd.com>
 <ccdb8f94-0879-2c06-5b48-25c2340d1659@gmail.com>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <ccdb8f94-0879-2c06-5b48-25c2340d1659@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ilf-BaQcp12EFdJP853Jmz0QcLHuyjMu
X-Proofpoint-GUID: ilf-BaQcp12EFdJP853Jmz0QcLHuyjMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=913 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/26/2022 2:31 AM, Mark Herbert wrote:
>>
>>> The changes that I have posted will not work on other targets like 
>>> WCN6855 as is. It requires additional changes and therefore lots of 
>>> testing.
>>
> 
> Will the changes be possible for QCA6390 as well?  Currently this chip 
> only activates power saving mode when it is connected, but behaves badly 
> when not associated to any network. So there is a chance that this kind 
> of solution will help.
> 

Not associated to any network as in Wi-Fi is ON and not connected or 
Wi-Fi is off?

Manikanta
