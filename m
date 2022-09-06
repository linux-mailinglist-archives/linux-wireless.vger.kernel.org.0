Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C03B5AE362
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 10:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbiIFIqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 04:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239547AbiIFIqa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 04:46:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833197CA8E
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 01:42:30 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28667irW012344;
        Tue, 6 Sep 2022 08:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aiGv0pB103saa7xUlM1KSja0zbIEm+Khxfi+4ZlkNIY=;
 b=p5k/VGMriw/8VeUCn+iRLVNIl0eUu5zV0FZaxRj3aNGnihPA3ujI9snmeZz4MY4m/Fg7
 ny2c8SZftjeIfPH4lsnnen+wakpDR17Uta+vF99gX7NjMA3zBqcItYk4duD5MxItj+rn
 1SoG9yPFsp3ByH5RhiiNxIQKk7bg2tU12po+TfX9ZWkWXTrfh36qyMGVQgO8zpsyG/7V
 VuxvsakR1oK2hvzhSGO9r08URs5BfxOoQ94ZASMmFFn4vLF9jXL1iom1LC4mK3OLibZt
 psBeQFVqHwWmen5n8UGaYqToAoUTW3AE9lLq2+/tlHdGtaCgLTCRHEtfnvVS4+PQ3b4/ 6A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3je0mfrqjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 08:42:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2868g5pi005086
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Sep 2022 08:42:07 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 6 Sep 2022
 01:42:03 -0700
Message-ID: <f3afceb8-8120-12c7-74b9-caa3abce5cb8@quicinc.com>
Date:   Tue, 6 Sep 2022 16:42:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 00/27] another set of MLO patches
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ilan.peer@intel.com>, <andrei.otcheretianski@intel.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
 <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
 <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
 <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9o5n2rlDe87FfvysD8HPkNACzhrI0V_g
X-Proofpoint-ORIG-GUID: 9o5n2rlDe87FfvysD8HPkNACzhrI0V_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_03,2022-09-05_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060041
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/6/2022 4:03 PM, Johannes Berg wrote:
> On Tue, 2022-09-06 at 15:58 +0800, Wen Gong wrote:
>> Now I hit an issue is: wpa_supplicant reject the authentication from AP
>> while connecting.
>> because the addr of authentication is replaced the link
>> bssid(00:03:7f:12:99:99) with MLD address(aa:03:7f:12:99:99) in
>> mac80211's ieee80211_prepare_and_rx_handle().
>> wls1: SME: Ignore authentication with unexpected peer aa:03:7f:12:99:99
>>
> Well, OK, you obviously are adjusting the supplicant to work with MLO
> (otherwise you wouldn't get an MLO connection in the first place), so
> yeah, this is part of the adjustments needed.
>
> Ilan/Andrei have all of this working, maybe we can share the patches
> even before rebase etc.
>
> johannes

Thanks.

It is good to share me the wpa_supplicant patches ASAP.

And I have another question:

When mac80211 use the MLD addr in authentication/assoc request,

finally, it should be replaced with one link's address in air port, right?

It means the MLD addr will never exist in mac80211 header of packet in 
the air port, right?

