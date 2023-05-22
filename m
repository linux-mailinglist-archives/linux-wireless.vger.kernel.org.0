Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04CF70BA2C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjEVKac (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 06:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjEVKaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 06:30:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6381A5
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 03:30:03 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M9pFjG005172;
        Mon, 22 May 2023 10:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vrMxRStfgjFU+Q5pAq2tUukJWCBvSe62os97n9wFLXg=;
 b=Ewi7n9eiCvUjQaJu7sMoJcfZ+bhhLjkHyRTV+t1e32czmdE+GP2NMVncNvjj0MeHqjZz
 GmjTyYq689cIpjtRu26mS4fK16Qop9cJ3AsLq313e/OZGxHAwEojWlJhdnQw0tGQMvId
 73Q1Sf5fDp4uXNOxDTosIdwO1UZYrM2HvednG4oPpQfrTzZ/2ywbBWPmUzm2U8MVjDV/
 bb30tgWsDo+dtg86qu+cF2NGa2bHAYkn2vVVeabHoX3u4zY9YYZn4ZPqm019NPw0AFzL
 CDBM3tDQO7GEIa/evOjYmGVzFs43U2CZvsdB+lbsQKPUWQ5kLAe3+ksR5tKsE2uEKwMq iA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpnhrufek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:29:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34MATfIp013394
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:29:42 GMT
Received: from [10.216.55.15] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 03:29:40 -0700
Message-ID: <c344366f-7fa6-9436-73c4-55e4eb57a109@quicinc.com>
Date:   Mon, 22 May 2023 15:59:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Subject: Re: [PATCH] wifi: mac80211: Add support to randomize TA of auth and
 deauth frames
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230112012415.167556-3-quic_vjakkam@quicinc.com>
 <20230307102225.74883-1-johannes@sipsolutions.net>
 <bd40816c-9759-a0af-9075-cc684f81fd70@quicinc.com>
 <67d681751d9af226fc84c533649d620ea1bb7664.camel@sipsolutions.net>
Content-Language: en-US
In-Reply-To: <67d681751d9af226fc84c533649d620ea1bb7664.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X4wqpKw6ao5h__URL2UxXnzhBJ89CHYl
X-Proofpoint-GUID: X4wqpKw6ao5h__URL2UxXnzhBJ89CHYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=949 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220088
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 4/11/2023 3:45 PM, Johannes Berg wrote:
>
> Huh, yeah, looks like I just missed that? Sorry about that.
>
> Seeing that though, I remembered another thing - don't we have to adjust
> the merging logic in ieee80211_start_roc_work() and maybe also
> ieee80211_coalesce_hw_started_roc()?
>
> johannes


All the cases(HW/SW RoCs, merged/combined RoCs) handled in 
ieee80211_start_roc_work() and ieee80211_coalesce_hw_started_roc() 
should end up calling ieee80211_handle_roc_started(), hence kept the 
temp_address configuration logic in ieee80211_handle_roc_started(). 
Please let me know if I am missing something?

--

veeru


