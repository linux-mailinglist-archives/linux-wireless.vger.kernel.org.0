Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292397AD911
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 15:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjIYN2K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjIYN2J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 09:28:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D3CFE
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 06:28:03 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PAndTD027383;
        Mon, 25 Sep 2023 13:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LtKALEBdwAgYQ5+5yQFCocjDGUS5fBSVl/IcaRRLdIY=;
 b=lJTCaXG6fId8dIwJhn0Dui2p4S8ZwzSbInfhFHhASNOxUGQZ6e4yZUvO63sfrbPZPKxS
 WTWtLn0CKk663vFYkkocuDC4FAFb6be9vIvNimEunDJHB21EymfkoaBevVG5jcYjWKHL
 z6Ik3gs3lBWEAVRo4nBeI8xb6a83TkBwT4rYJAjCQWh9VzZPW8HxEzSlHbDvNHoSgPxM
 FgE8rLtOL3vlXpTgWw1TUs2ON7RTvG27slaVsyr/pIXoEFeNgkjjy4IsjCV2vz4daXS6
 46cqvxuemmPMEdDc+152Uv4mhq85uV0pXjlI0rmy2BvmhYs9kEEHeWulkMLoNNeMUA2Z xg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9pywcac1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 13:28:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PDRxhW013493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 13:27:59 GMT
Received: from [10.216.1.235] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 06:27:57 -0700
Message-ID: <507ac7a0-cdf4-47c1-b238-f401fd9d9791@quicinc.com>
Date:   Mon, 25 Sep 2023 18:57:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: add support for AP
 channel switch with MLO
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230925115822.12131-1-quic_adisi@quicinc.com>
 <20230925115822.12131-2-quic_adisi@quicinc.com>
 <af4a763b624363543a37140c2106fb7a05800977.camel@sipsolutions.net>
 <1d8e7395-61c1-4fba-9d83-8cebfb557b33@quicinc.com>
 <36c2d107bf8dd2d32d6864ba929db026e9b8091d.camel@sipsolutions.net>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <36c2d107bf8dd2d32d6864ba929db026e9b8091d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EwoFu4fv4N1FRIAYBqzGL_mP4g6vyzFr
X-Proofpoint-ORIG-GUID: EwoFu4fv4N1FRIAYBqzGL_mP4g6vyzFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_10,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 mlxlogscore=741 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/25/23 18:51, Johannes Berg wrote:
> On Mon, 2023-09-25 at 18:49 +0530, Aditya Kumar Singh wrote:
>>>
>>> Perhaps we should just get rid of sdata_dereference() entirely, after
>>> all, it's the same now, just the arguments are switched for no good
>>> reason.
>> Yup agreed. Are you already aware of any WIP in this regards? If not, I
>> can take care for the CSA part at least in same series (in a different
>> patch obviously :) )
> 
> No, I was just thinking out loud now :)
Sure.

> 
> It'd be a trivial spatch, but I guess it'd be nicer to not have all that
> "sdata->local->hw.wiphy" in there if there's already another local or
> even wiphy variable in the function. And then while that's probably
> still possible in spatch, it's no longer trivial ;-)
Haha! Okay, let me see what I can do.

