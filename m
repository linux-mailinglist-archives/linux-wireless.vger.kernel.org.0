Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A496E1E26
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 10:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDNIZr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 04:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjDNIZZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 04:25:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B392983CF
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 01:25:01 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E6UlqX010400;
        Fri, 14 Apr 2023 08:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LHHC+U9HzioRAhvYDCaTny494jxNOISznZO8QE0GEyE=;
 b=FVA1GnQyP18HmnQf1xZZJpzi8x2KZGIQet6KKUdtRYhUkJL2nrw6eZiL6njMHiqx2vG7
 snEbketQPj3euS9DxDqkaYembOL6jwVIfQswmAaGDlI/Oh/u0A7+pBOzchFb+Ctd3pac
 czuaYzFlK0NchhTfqmtAKK9/eb2g0FdIprZDckl6j09PvwncOjvOSyA5Xg/wQ/ojUS9o
 fSR1UMPmsYMtUYb/UmOLb1kceuInIe/EzjNHArcJ74Zn+dt6jSkMMDjEJ0UvEZuGuzev
 1xTC20GNW7mBdZ7EPudosiz3lEEpjPzqFmDk8gBaXm8nw4kGWolHh1LIugFnM6LZS2HC pg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py0xurcg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:24:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33E8OXoq017035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:24:33 GMT
Received: from [10.242.243.157] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 01:24:32 -0700
Message-ID: <a30f4f1d-0652-7ece-7a29-636e3f7cb7d5@quicinc.com>
Date:   Fri, 14 Apr 2023 13:54:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support for
 all power modes
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
Content-Language: en-US
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20230315132904.31779-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zas_g8HmBscMMDjWXFmgU9i5DA-1eTvN
X-Proofpoint-ORIG-GUID: Zas_g8HmBscMMDjWXFmgU9i5DA-1eTvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=644 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304140074
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/15/2023 18:58, Aditya Kumar Singh wrote:
> 6 GHz introduces various power modes of operation. Currently, based
> on the power mode, channel's Power Spectral Density (PSD) value,
> Regulatory power value, as well as channel disabled flag can change.
> For single interface, current implementation works just fine. But for
> multi-interfaces, for example AP-STA concurrency, two different channel
> context needs to be maintained. This is because, STA power mode also
> depends on the AP's power mode it is going to associate with. Hence,
> PSD value, regulatory power value and channel disabled flag might vary.
> In this case, same channel context cannot be used for both AP and STA.
> 
> Therefore, to support multiple channel space for each power mode, the
> 6 GHz channels needs a separate storage space in data structure
> ieee80211_supported_band. Because of this, the existing APIs to get the
> channel/frequency from frequency/channel will not work for 6 GHz band.
> 
> Add support to store all possible 6 GHz channel pools according to the
> power mode as well as add API support for getting channel/frequency info
> from the new struct ieee80211_6ghz_channel.
> 
> 
[..]
> 

Hi Johannes,

Could you review this series and provide your comments please?

Aditya

