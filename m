Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2CE7AD8FE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 15:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjIYNZP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 09:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjIYNZO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 09:25:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B67FE
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 06:25:07 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PASHfr025988;
        Mon, 25 Sep 2023 13:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1dhmgDgrHtpDlPa5DU2fApfUUjBvdKNVhkJdw7X5Hkw=;
 b=g6qtyYM//QcD97hx8tLR+X1zJ2DFUXpH/udPBjIcqcuz55/vqP2ee5dy8bkaLd9a5cpW
 PRvd2d/2VqfYfEH1Gcxd51n4fHKR6EfE4fZ+yQGR9qmE8sRgZj7Y8qNbVHhYL8orqlRR
 njAdtwYtWFxbMsvHeNPAl5PRiIGPJ7lTdNO4OGgCH11uR/DpAK3As3hIHmNBrbBz8fEk
 zGmWWDbCOn2/vpmTJTjErDxPan8CjcQ6A5+6JUxBt5fO91DvyePJ9EdS6dDSyn0235tr
 KbTLwVaNs3fhMCwkKxvqFdqOqUIKKbi3BA0h6VDmGpqilMYbnV+DQCoeMbudyqAqfBsx Sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9rddbw0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 13:25:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PDP0hi027123
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 13:25:03 GMT
Received: from [10.216.1.235] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 06:25:00 -0700
Message-ID: <43014134-2702-47d2-8120-52459ae08660@quicinc.com>
Date:   Mon, 25 Sep 2023 18:54:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: add support for AP
 channel switch with MLO
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230925115822.12131-1-quic_adisi@quicinc.com>
 <20230925115822.12131-2-quic_adisi@quicinc.com>
 <aae994910abeeb7e445eb2731eeb7dac0b3e43cb.camel@sipsolutions.net>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <aae994910abeeb7e445eb2731eeb7dac0b3e43cb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ESDtadym23Y1vKqrf8VYej8Ah6cZqxeJ
X-Proofpoint-ORIG-GUID: ESDtadym23Y1vKqrf8VYej8Ah6cZqxeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_10,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=735
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/25/23 18:42, Johannes Berg wrote:
> On Mon, 2023-09-25 at 17:28 +0530, Aditya Kumar Singh wrote:
>>
>> -void ieee80211_csa_finish(struct ieee80211_vif *vif)
>> +void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
>>   {
>>   	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>>   	struct ieee80211_local *local = sdata->local;
>> +	struct ieee80211_link_data *link_data;
>> +
>> +	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))
>> +		return;
> 
>> =.
> 
> You also have that in the other patch.Sure, got it. Thanks.
