Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16065B58D0
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 12:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiILKzd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 06:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiILKzb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 06:55:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BF61BEAF
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 03:55:28 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CAJbmD024623;
        Mon, 12 Sep 2022 10:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=q275b5LUVDGGXXw4R+fHCTyUOBz5XGxo5EGIvSA8X3I=;
 b=USZ0iOzV49YI6iX15mpbUZOxVIdNVPGUcyLQE94MJUYaY3h6gT4Ta7zKwd6oNZKuaceQ
 A85DWzmFYcxBN+wlPhTCNaadNHq9TAg6GDCkgHyzF8cb1so3M3sL0caLzTHeSfXA8q4n
 pagU1mZlX/jkY2ukfyxR3eS61FY0cf2Ls9nZuHajfZTraC6kQkZmDorBJg/f6pZv1cd1
 S75lbOLzFrea2ill51E9bKS7J77kxLupnpx+ayf73GDUjgyP2N4gwzB5fqFwYAk3e/my
 uT9nbEuMCaKqT53/rlE6Zcddq/iZLl9YFL5XpIJ3TmGqZkWACqp3w5BJE8RbdMm95u53 sw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk3bbrnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 10:55:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CAt8Ve014042
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 10:55:08 GMT
Received: from [10.253.8.149] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 03:55:07 -0700
Message-ID: <7199bd7d-b45c-5c72-576e-363ad37cce82@quicinc.com>
Date:   Mon, 12 Sep 2022 18:55:04 +0800
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
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87a67498b4.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g-XCu7vUToFqyK6tMtK1vpmUo00pNFQV
X-Proofpoint-GUID: g-XCu7vUToFqyK6tMtK1vpmUo00pNFQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_06,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120036
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/12/2022 6:49 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> Hi Johannes,
>>
>> Currently for MLO test, the others links's rx_nss of struct
>> ieee80211_link_sta is still value 0 in ieee80211_set_associated(),
>> becaue they are not pass into ieee80211_sta_set_rx_nss() in
>> mac80211 except the deflink which means the primary link.
>> This lead driver get nss = 0 for other links. Will you fix it
>> or is it design by default?
>>
>> Only primary link has valid rx_nss value which is not 0 by below call stack.
>> ieee80211_assoc_success()->
>>      rate_control_rate_init(sta);
>>
>> commit:c71420db653aba30a234d1e4cf86dde376e604fa
>> wifi: mac80211: RCU-ify link STA pointers
> Strange format and s-o-b missing. Was this meant as an RFC patch?

This is not a patch for review, it is to ask some question about the patch

"wifi: mac80211: RCU-ify link STA pointers" which is already upstream.

