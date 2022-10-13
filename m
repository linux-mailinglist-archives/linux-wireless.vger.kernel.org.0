Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1556F5FD538
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 08:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJMGtj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 02:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJMGtM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 02:49:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC6C146394
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 23:49:07 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29D6GMQ9013034;
        Thu, 13 Oct 2022 06:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a6U//oY0YCxqmouz69JeHfl8MwMuzHzUbsHfq5Levjs=;
 b=FuKP22hFWRUy2qy2NmEBgPrdQ8KZOYANkF3BzNbDWlBySJ+cTG9z4eS4d9Ta/YWuiLFw
 dWwkaqNwoUaHBlQqQRDOSI1Pro4xkOCMVhNFhqs5Pr6MS763yMRMJm9QucXNShFbMVAR
 GMgM31bgK+IApjDPx0XogDajuS7o2vn4aKxIAgWRs2WCPDZe9VHx2k+1sXJ8ghefN0w8
 51cywPosr2i3/WVRTMW/Y9h07fo3dTubH+niAcrhNQy5oIB6L42Kq7hecHukGjuM0nuT
 9FHiG9y/pOXTXDe3mVm9gFxNs07Lqr0ci/pwGBBl/wKjMegnCMnYGDe6Xr4+Vk190fVs Og== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k6br7rcg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 06:48:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29D6mvtH009757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 06:48:57 GMT
Received: from [10.110.65.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 23:48:56 -0700
Message-ID: <92ad1bee-d9c6-9244-f8bf-5fce8ddf4a55@quicinc.com>
Date:   Wed, 12 Oct 2022 23:48:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 15/50] wifi: ath12k: add dp_rx.c
To:     "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-16-kvalo@kernel.org>
 <576a0720-fe45-36bd-abd1-b772dbe380b0@quicinc.com>
 <SN6PR02MB43342E0EDCE5420D93DD1EC7F7229@SN6PR02MB4334.namprd02.prod.outlook.com>
Content-Language: en-US
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <SN6PR02MB43342E0EDCE5420D93DD1EC7F7229@SN6PR02MB4334.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V0AQatNCWPzD0qMrQRkzwk9hNAkelmAI
X-Proofpoint-ORIG-GUID: V0AQatNCWPzD0qMrQRkzwk9hNAkelmAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_04,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=618 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1011 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130041
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/12/2022 4:29 PM, Sriram R (QUIC) wrote:
>>> +static u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
>>> +                               struct sk_buff *skb) {
>>> +     struct ieee80211_hdr *hdr;
>>> +
>>> +     hdr = (struct ieee80211_hdr *)(skb->data + ab->hw_params-
>>> hal_desc_sz);
>>> +     return le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
>>
>> should there be an ieee80211.h function for this? we already have:
>> ieee80211_is_first_frag()
>> ieee80211_is_frag()
> Yeah, but we needed the frag no in this case.

understand. so create an ieee80211_frag_number() function in ieee80211.h

