Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B2600760
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Oct 2022 09:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJQHKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 03:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJQHKu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 03:10:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D024158B76
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 00:10:43 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H77PxL018508;
        Mon, 17 Oct 2022 07:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BhlGNW953+5Y219pY2aK+nsabIJDn+S+PDNng0R+ELE=;
 b=J1zTMi03xDWuCal5YBeYRUmcn2aOqR6XE662Y+SeVOFCydXLj+m7QeScaWNO/11ZUO59
 52v333rD6/8ULNtHre8UFJiC2CVgxkd+WHKveZ9VAc1OO0W5w+B32vcOMs2Pswe8nOI7
 n2jLL2LJLfSbGKs4XzoOdwylNCD314AePN+mlLwc9IsKfQcan8i4VRWGbPrCO7GI4T4N
 OMMRXpksC9VSyBozxmu7/WRgGjU2l5uzyvx592fFZkl8Ips+McysavenERiA/L0JCZ7J
 okLKsA0NoiKb+5xgojD15HgXdqbfT0uJOBh23OVnmWu04yAzU0f3Q7LiIez0409tmmD1 lA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k7kvgbd9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 07:10:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29H7ARGT025132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 07:10:27 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 00:10:25 -0700
Message-ID: <1a440c62-ffd0-9602-9454-f08765beadf0@quicinc.com>
Date:   Mon, 17 Oct 2022 15:10:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: wifi: mac80211: mlo rx nss value 0 of wifi
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <913ee04f-a16f-f765-96c2-0586282831b4@quicinc.com>
In-Reply-To: <913ee04f-a16f-f765-96c2-0586282831b4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5Yqr-mI0_OPkrZmMzcUA1RIEScPzYWJo
X-Proofpoint-GUID: 5Yqr-mI0_OPkrZmMzcUA1RIEScPzYWJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_06,2022-10-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 mlxlogscore=835 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170041
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

May I get your comment about this?

On 9/13/2022 12:37 PM, Wen Gong wrote:
> Hi Johannes,
>
> Currently for MLO test, the others links's rx_nss of struct
> ieee80211_link_sta is still value 0 in ieee80211_set_associated(),
> becaue they are not pass into ieee80211_sta_set_rx_nss() in
> mac80211 except the deflink which means the primary link in
> rate_control_rate_init(). This lead driver get nss = 0 for
> other links. Will you fix it or is it design by default?
>
> Only primary link has valid rx_nss value which is not 0 by below call 
> stack.
> ieee80211_assoc_success()
>     ->rate_control_rate_init(sta);
>         ->ieee80211_sta_set_rx_nss(&sta->deflink);
