Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B275B66FE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 06:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiIMEhA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 00:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiIMEgd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 00:36:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2452808
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 21:30:17 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D4PndN031022;
        Tue, 13 Sep 2022 04:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SX9tohww+nxgNIMznlpi1JktYrP5xrIWwBB7lfg10Yk=;
 b=VlBWbcTPTvmCRBHRReFogweu392ht2WGwU/A52z4lITq55L5us+x3GtvXlueeHa4lpeK
 u++Ky/fHGLSCHmsEMbS7kmAAoUpOGSC8m+voLVP9shEGHqSDt6W8AgK6yCk6RY4jFiJN
 IDTitOFN0V9/j7Bkwe/kg5i/XC58EAap9SAOiCI2W1veWGSsX2AJubrId2JWxsX52rqr
 u0LINbHQU7enlkq6tGFMIl5pp0ah26iAneQG30v2EIDsyNNEsWYVXU+fvEtF3+RvEMmt
 N3MhPY7AQDmuuHGvy0Y/jh8qadTR6MPn1TntnE6CYWKKzw2W6ra1j4qcBYruICpf+nEw JQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk636260-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 04:29:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D4TmHX015828
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 04:29:48 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 21:29:46 -0700
Message-ID: <c28b9240-c45e-c8cd-ece7-d967da93896c@quicinc.com>
Date:   Tue, 13 Sep 2022 12:29:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] wifi: mac80211: RCU-ify link STA pointers
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <24df3a0c-a312-d9b6-5840-1eacd79d824b@quicinc.com>
 <87a67498b4.fsf@kernel.org>
 <7199bd7d-b45c-5c72-576e-363ad37cce82@quicinc.com>
 <875yhs97kg.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <875yhs97kg.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NnH5cWp-FXLO9qYOsgjJx_YDrsS9OSEf
X-Proofpoint-ORIG-GUID: NnH5cWp-FXLO9qYOsgjJx_YDrsS9OSEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_01,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209130019
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please ignore this mail which is not really for patch review.

On 9/12/2022 7:05 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> On 9/12/2022 6:49 PM, Kalle Valo wrote:
>>> Wen Gong <quic_wgong@quicinc.com> writes:
>>>
>>>> Hi Johannes,
>>>>
>>>> Currently for MLO test, the others links's rx_nss of struct
>>>> ieee80211_link_sta is still value 0 in ieee80211_set_associated(),
>>>> becaue they are not pass into ieee80211_sta_set_rx_nss() in
>>>> mac80211 except the deflink which means the primary link.
>>>> This lead driver get nss = 0 for other links. Will you fix it
>>>> or is it design by default?
>>>>
>>>> Only primary link has valid rx_nss value which is not 0 by below call stack.
>>>> ieee80211_assoc_success()->
>>>>       rate_control_rate_init(sta);
>>>>
>>>> commit:c71420db653aba30a234d1e4cf86dde376e604fa
>>>> wifi: mac80211: RCU-ify link STA pointers
>>> Strange format and s-o-b missing. Was this meant as an RFC patch?
>> This is not a patch for review, it is to ask some question about the patch
>>
>> "wifi: mac80211: RCU-ify link STA pointers" which is already upstream.
> Then you should not add "[PATCH]" in the subject. The string "[PATCH]"
> is supposed to inform that the email contains a patch which should be
> applied.
>
