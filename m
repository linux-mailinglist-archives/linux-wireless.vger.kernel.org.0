Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BAF7A53DC
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 22:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjIRUVx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 16:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRUVw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 16:21:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4EB6
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 13:21:45 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IKBBs9024626;
        Mon, 18 Sep 2023 20:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eMo5vWtdj/5uwatk1KEA8Bc8hsnrzv25vKdjqemRxO8=;
 b=SjMO6lXA5D5Gc/mkwDGOGFUmN1lIJozMY2eDCNBaocVGZY2Z6heTzzFpvq/EcGQ/9oFT
 g4vlrAXaVJfw3AxRbpIUSLwzfWM0M45u4KHYc5e1U28ezdIgwouUdGSs8BFt/bf2lf4K
 wRE5IWloXvXSupylMNHH4tKhof6XvUFPJ3ZHwQGfP9wHRx6maQiHPSfXPh1lNMiWH3SN
 33EeToS0e/05U1m9ZPY/AdRZ7alFLR6XzXuBmymIZGr4fNYI8CUU6e1zJjOzcCCVzvwg
 s/eKsxsyFaNn4R6OJ02NAWXxfNDCTUa6ZWuEn+9TSDlHzP0DKLQUjP2MTx+efzGmlqMt 0g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6nh795p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 20:21:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38IKLeWp025276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 20:21:40 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 18 Sep
 2023 13:21:38 -0700
Message-ID: <427095d0-10a2-4054-a4b5-5c96522e6765@quicinc.com>
Date:   Mon, 18 Sep 2023 13:21:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] wifi: mac80211: Notify the low level driver on
 change in MLO valid links
Content-Language: en-US
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, Ilan Peer <ilan.peer@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
 <20230918140607.7f08b3dd70a4.I64238e0e892709a2bd4764b3bca93cdcf021e2fd@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230918140607.7f08b3dd70a4.I64238e0e892709a2bd4764b3bca93cdcf021e2fd@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tMFacj1z22AIbhRJr7AFUQkGZqKVAXfM
X-Proofpoint-GUID: tMFacj1z22AIbhRJr7AFUQkGZqKVAXfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_09,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxlogscore=694 bulkscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/18/2023 4:10 AM, gregory.greenman@intel.com wrote:
> From: Ilan Peer <ilan.peer@intel.com>
> 
> Notify the low level driver when there is change in the valid links
> links.

s/links links/links/ ??

