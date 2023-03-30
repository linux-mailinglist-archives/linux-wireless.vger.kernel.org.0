Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875FE6D124B
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 00:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjC3Wkt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 18:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjC3Wkq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 18:40:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7AAE04A
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 15:40:42 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UKf4cv017105;
        Thu, 30 Mar 2023 22:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ursZ6cIpxv/PhupnppCiMkE7G+9RFjrMp73sjQnoYYM=;
 b=TzD7gVcTqj+O2hYiqTBNnG4cR71SozX6CjBHzH4J8nvaziwdZrd7BlY/L2Z5apKVZMlS
 5jjftrGgoyFm9f76ncVpnzwJ8kKGsyHjM7zDTCTyWH7sEjof+g1jtaJOW56qqWcGXhgx
 j41oA7fGdkdr8v91LtF5uvwGHTwF9niVGBeucOCUtrP97T9+weI7UBD4FoTj0UCSEJJL
 HxdaHdI+kyOO5+TUZDAVzdeb9FQR+6VqmVFtxLYfya225rdV7iTRs8QW4ZkSOfDDlmFG
 IJCGJyrNdfcLOwF7Wxji+fTXdzodSvGDicgKnr3XmsZA3SYkhg1KM/gTfhJEFEZa+sz2 Ow== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3png55gcx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 22:40:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32UMeJID017064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 22:40:19 GMT
Received: from [10.110.89.180] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 30 Mar
 2023 15:40:19 -0700
Message-ID: <312f1476-b78b-b7f0-26f9-512a7dc2b6b7@quicinc.com>
Date:   Thu, 30 Mar 2023 15:40:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] wifi: cfg80211: beacon EHT rate support
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230329000902.17992-1-quic_alokad@quicinc.com>
 <d54800ae88be1eb232df7794e741dfc304c3ee9a.camel@sipsolutions.net>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <d54800ae88be1eb232df7794e741dfc304c3ee9a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E3o11il3aPtMz5Eye_nYs2Fa_7Ee4FxQ
X-Proofpoint-ORIG-GUID: E3o11il3aPtMz5Eye_nYs2Fa_7Ee4FxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_13,2023-03-30_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300178
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/30/2023 3:44 AM, Johannes Berg wrote:
> On Tue, 2023-03-28 at 17:09 -0700, Aloka Dixit wrote:
> 
>> +		switch (wdev->iftype) {
>> +		case NL80211_IFTYPE_AP:
>> +			width = wdev->u.ap.preset_chandef.width;
> 
> This seems a bit awkward and annoying, it means that we have to keep
> using the API that sets the preset_chandef first, and it also means it
> won't work for multi-link.
> 

Okay, I can do it the same with it is done in he_get_txmcsmap():
	chandef = wdev_chandef(wdev, link_id);

> Couldn't you link it with the config in start_ap/join_mesh? And per-link
> config in set_tx_bitrate_mask()?
> 

Please correct me if I'm wrong but ieee80211_set_bitrate_mask() need not 
be changed for setting the beacon rate in non-MLO case, right?
Because it does not have anything related to he_mcs currently too.

> Also not sure about this at all in parse_tid_conf()?
> 

Can you please explain this point.

I didn't find existing HWSIM support for this feature so I mainly tested 
manually - setting the beacon rate in hostapd and checking that the mask 
generated in nl80211.c is valid.

Thanks.
