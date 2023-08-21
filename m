Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE2A7824D9
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 09:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjHUHsQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 03:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjHUHsP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 03:48:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CCD92
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 00:48:14 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37L7RVNu022354;
        Mon, 21 Aug 2023 07:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NXI2/SUbqvE8w14U/0XCRbpJsK9Wr2dkwOZ72ISoBjM=;
 b=dJe3IXV4QtSXxRa4vYAivNVJ1Yvt/kbA2Ak3WXbNlOXDcnx4LsR/ujNmHp7jba9NMYKF
 NEJsnQWnlTFGqHMrpw2LDcbKZ2xRftx53tt+aF3uE6DUWb3x1Za7enkUsfm1KTnsB2xG
 P/u5VPM22oG2V0IHug4UjQLyacKPxgy7+PKCFXUUTUAjx6hPlbXeG7MPdCmeKyl+aaYR
 43yq0V2i1RtaZ8v0Jx/hsmwluDPQgUrfUozKtkNw/dc6+/XHj/ABZ7fyp1N9tKvPYfom
 TMyPervcY+Tvv5R2Pb9jTqVunbgF1BNuQNw7YuK/hcM4diR22wA2GDGc0AOR/K01tO6A 5Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjny935xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 07:48:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37L7m77X024510
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 07:48:07 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 21 Aug
 2023 00:48:06 -0700
Message-ID: <0a264e30-af70-a6ff-eb2b-c3862540ee1b@quicinc.com>
Date:   Mon, 21 Aug 2023 15:48:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] wifi: mac80211: fix cfg80211_bss always hold when assoc
 response fail for MLO connection
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230821061355.18168-1-quic_wgong@quicinc.com>
 <5c072b0a45ad29dc03b989fbd9a9fd974ae0c23d.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <5c072b0a45ad29dc03b989fbd9a9fd974ae0c23d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NtxixyU_oKjlGNGN1ANlOlxmSRsGvWlY
X-Proofpoint-GUID: NtxixyU_oKjlGNGN1ANlOlxmSRsGvWlY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210070
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/21/2023 3:40 PM, Johannes Berg wrote:
> On Mon, 2023-08-21 at 02:13 -0400, Wen Gong wrote:
>> +++ b/net/mac80211/mlme.c
>> @@ -5429,17 +5429,22 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
>>   	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
>>   		struct ieee80211_link_data *link;
>>   
>> -		link = sdata_dereference(sdata->link[link_id], sdata);
>> -		if (!link)
>> -			continue;
>> -
>>   		if (!assoc_data->link[link_id].bss)
>>   			continue;
>>   
>>   		resp.links[link_id].bss = assoc_data->link[link_id].bss;
>> -		resp.links[link_id].addr = link->conf->addr;
>>   		resp.links[link_id].status = assoc_data->link[link_id].status;
>>   
>> +		link = sdata_dereference(sdata->link[link_id], sdata);
>> +
>> +		if (!link) {
>> +			/* use the addr of assoc_data link which is set in ieee80211_mgd_assoc() */
>> +			resp.links[link_id].addr = assoc_data->link[link_id].addr;
> As I mentioned before, this cannot be done - it introduces use-after-
> free since assoc_data is freed after the loop, and the
> cfg80211_rx_assoc_resp() is after that.

So I want to change the "const u8 *addr" to "u8 addr[ETH_ALEN] 
__aligned(2);" of struct

cfg80211_rx_assoc_resp and copy the value, then no use-after-free, is it OK?

>> +			continue;
>> +		}
>> +
>> +		resp.links[link_id].addr = link->conf->addr;
>>
> Also, I don't see that we need to use two different assignments for the
> two cases.
Then I will change to both use "assoc_data->link[link_id].addr", is it OK?
> johannes
