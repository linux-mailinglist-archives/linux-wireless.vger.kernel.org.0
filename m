Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB325EDFEC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 17:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiI1PP7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiI1PPz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 11:15:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521648EA2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 08:15:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SE2tHr032230;
        Wed, 28 Sep 2022 15:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BhlGNW953+5Y219pY2aK+nsabIJDn+S+PDNng0R+ELE=;
 b=GooLvqLnLhXqVYg7emDkipwybfzRQNLPkZotXuHk3pOvWpkf2ffspEZu7ofV/Si1dOJz
 tS4TjzAgyl7YivUqUE9db4dFPmoj1kjBNqkT8pv+ReGGSmqFPZcxYF0rFqp43cCVhtZf
 EN358yQ5NzBtwrRAmU0h/wvTPLVnux+jZ1+Yw6AN2k6zd5skoQLswibn4vcxxujYqEsq
 ubL3f4HVM8SEgH7hgmfY8+AIz7h9/9draShLyAoRAr0bOKjB0U9U9F3Jpc4/hwSD+CKn
 HzlctN7RK3MPd+jPqMCf9EVSNDfNkIm2W+w6+xbvkrk2SouNDsAHC+cKXkU09hR78k0V 3A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvpuv8ene-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 15:15:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SFFkxA015582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 15:15:46 GMT
Received: from [10.253.33.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 08:15:45 -0700
Message-ID: <f8690433-b264-d5f4-6806-d9babba6e6be@quicinc.com>
Date:   Wed, 28 Sep 2022 23:15:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: mlo rx nss value 0 of wifi
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JVAdmSsb48byuZAWbMVrgOGnoOO2jceN
X-Proofpoint-ORIG-GUID: JVAdmSsb48byuZAWbMVrgOGnoOO2jceN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=847 spamscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280090
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
