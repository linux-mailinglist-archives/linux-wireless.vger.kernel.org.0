Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE87267EF1C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jan 2023 21:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjA0UEa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Jan 2023 15:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjA0UEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Jan 2023 15:04:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D2112F20
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jan 2023 12:02:28 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RJeT8Y003894;
        Fri, 27 Jan 2023 20:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kU7XYuKyzW8hQcA0tQEyAxxlKHY2nKRVd4ER+ogj5nk=;
 b=EUz3sAd8G61a3kzs4cG3C3k7p9wOSAW+3VSg08cTA19a4/m6c1Tg0M12U81X9GQcGIZz
 urP1M50W4PEyImT74QwmzOWfGJVTqTPtwWujwS7Y3X5Lrvvq6UW23IMPdHvS8lTPS5IT
 oMazUs/SO28PujtelP5MkVyZVZUvN5BRpFi+XsVCxkRquktOlIHLvu/b/ssQBujMBM89
 zfCP9lLQJL8lkY+OQbvmmct/xfuOSfCfcD0Ym8e02sWvluVrd+5+7M0DtpkTcMwogowo
 sYUZjiTHxocPzCMmYQ+RqGTpqinMMbeaT9Iry/NWNPdlH8iDXOHpNFrpIQwCKiEmS9qQ SQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nc9yss8bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 20:02:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RK2MvE032686
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 20:02:22 GMT
Received: from [10.48.245.22] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 12:02:22 -0800
Message-ID: <dfce2942-cb1c-0990-319d-f47e5ccd953f@quicinc.com>
Date:   Fri, 27 Jan 2023 12:02:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] wifi: mac80211: mlme: handle EHT channel puncturing
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Muna Sinada <quic_msinada@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
References: <20230127123930.4fbc74582331.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <20230127123930.4fbc74582331.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oVpzBXReX4zNJo5LnAy326J3wqT_w4xb
X-Proofpoint-GUID: oVpzBXReX4zNJo5LnAy326J3wqT_w4xb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_12,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=543 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270184
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/27/2023 3:39 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Handle the Puncturing info received from the AP in the
> EHT Operation element in beacons.
> 
> +
> +static bool ieee80211_valid_disable_subchannel_bitmap(u16 *bitmap,
> +						      enum nl80211_chan_width bw)

Please export this function instead of making it static as we need to 
use it for AP mode as well.
Thanks.

