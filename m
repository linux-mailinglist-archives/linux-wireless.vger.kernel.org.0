Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02502695C48
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 09:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjBNIJe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 03:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBNIJc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 03:09:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790CC12F24
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 00:09:31 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E2ZKo9030886;
        Tue, 14 Feb 2023 08:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0qDo/XKEy4hSlya0XvASDJXV7HUWAhTladZrSWoZEw0=;
 b=dlqqQy/lra2Pm5/SeMd/my6eWfVk0hOGGNkFPVf0tzBg6/t0fWSylnYRFWA66FHMaQk5
 XRb9tAoyNVWUjZSA0AioT97dr3XXo96bublK2XeRUE2jbRCAZOsr/4j0WeuzTe0ab+rE
 NH1wLYKq+ZBknlljz6v50yPq65Z0vU+ES0JQCSbWEAoe9Nc4dCpdA64UIwplg/v4eNna
 vJ8vuhLXhYL/eiASHwMs9Hby6CAF4HGDhBISQSFAJo8mXNd1515ZGMIoq9JEnszKlS9K
 F5pK50X0773Q46WCu4eR9tHsnRda6p+96n/u4QHAo+hX09E2/tvvbKECLiiJEzFT0QGf Dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv09f7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 08:09:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31E89PPY013296
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 08:09:25 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 00:09:23 -0800
Message-ID: <0c15bfd6-819e-3e76-391b-f2ab70eb7eba@quicinc.com>
Date:   Tue, 14 Feb 2023 16:09:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 04/15] mac80211: make channel context code MLO-aware
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
 <20220601093922.fb3f0f434c72.Icea7e695b0626177e27ab73bc8799202d623cebf@changeid>
 <34121f87-4aa6-7f20-fb1e-4d5b02d06f28@quicinc.com>
 <0e889e3be774aced1813152b18d505c0616fc110.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <0e889e3be774aced1813152b18d505c0616fc110.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7iT3D0YaWBVe4QD1ixZ-xS0icbmzIu-W
X-Proofpoint-ORIG-GUID: 7iT3D0YaWBVe4QD1ixZ-xS0icbmzIu-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_04,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=932 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140068
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/14/2023 4:04 PM, Johannes Berg wrote:
> On Tue, 2023-02-14 at 15:57 +0800, Wen Gong wrote:
>>>    void rate_control_rate_update(struct ieee80211_local *local,
>>> -				    struct ieee80211_supported_band *sband,
>>> -				    struct sta_info *sta, u32 changed)
>>> +			      struct ieee80211_supported_band *sband,
>>> +			      struct sta_info *sta, unsigned int link_id,
>>> +			      u32 changed)
>>>    {
>>>    	struct rate_control_ref *ref = local->rate_ctrl;
>>>    	struct ieee80211_sta *ista = &sta->sta;
>>>    	void *priv_sta = sta->rate_ctrl_priv;
>>>    	struct ieee80211_chanctx_conf *chanctx_conf;
>>>    
>>> +	WARN_ON(link_id != 0);
>>> +
>>>    	if (ref && ref->ops->rate_update) {
>>>    		rcu_read_lock();
>>>    
>> Why link_id must = 0 here?
>>
> The whole software rate scaling hasn't been adjusted for MLO yet.

Got it. Thanks.

So I guess this WARN_ON will be change later.

>
> johannes
