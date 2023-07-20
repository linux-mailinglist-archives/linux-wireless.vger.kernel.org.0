Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F3175A4F4
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 06:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGTECP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 00:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjGTECO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 00:02:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A871FED
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 21:02:12 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K1cDPX011558;
        Thu, 20 Jul 2023 04:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EWZqkbrEmic5ZlxtmoYvb9Wmnk37sbY4h/I6kQinElQ=;
 b=jcrQ0kMyfI27nCz5s97daIYoxO/G8L3u55Qgtz3bfG9Gmzyt0M2aR95G4fdhH/48oH/p
 VKoGWD6ywMBoWXGQDEMww/tktaNswrpJgEHDnZsOeGE/dCPyMbSbtfvzCErhmfV/2wUs
 5t8jdUO/XyOppF+fmbZXJQiGLUdWSw3bWmu/1yHIcRoQ0NKLKAPSkGnmSEOlP+z//fIK
 w29aaPJ4rZaR+Qk9EdMkob6JuwKBOmR1bcSOGD8GstHveMLOECxqZlCJSV5tsiKZ+ojH
 PaI0E5MbpaKiHN6o6tkrB1DgNzh+k4mBozmAqmKNcsc2JBCpzqINN34K1Twgi2ZM88zh 1A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxpyqrk45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 04:02:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K4270K011381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 04:02:07 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 21:02:05 -0700
Message-ID: <2027bcac-cfd9-3858-3438-9a7297600350@quicinc.com>
Date:   Thu, 20 Jul 2023 12:02:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/14] wifi: iwlwifi: mvm: add support for Extra EHT LTF
Content-Language: en-US
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
 <20230613155501.de019d7cc174.I806f0f6042b89274192701a60b4f7900822db666@changeid>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20230613155501.de019d7cc174.I806f0f6042b89274192701a60b4f7900822db666@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5BJJlO0ADYecwbsWsSsMFs5woAqezjQ1
X-Proofpoint-ORIG-GUID: 5BJJlO0ADYecwbsWsSsMFs5woAqezjQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=864 malwarescore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200031
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/13/2023 8:57 PM, gregory.greenman@intel.com wrote:
> From: Gregory Greenman <gregory.greenman@intel.com>
>
> Add support for Extra EHT LTF defined in 9.4.2.313
> EHT Capabilities element.
>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>   drivers/net/wireless/intel/iwlwifi/fw/api/rs.h    |  2 ++
>   .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 ++
>   drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 15 +++++++++++++++
>   include/linux/ieee80211.h                         |  1 +
>   4 files changed, 20 insertions(+)
>
This patch changed both ieee80211.h and iwlwifi, if separate the change 
of ieee80211.h
to another patch such as commit 4fdeb8471302(wifi: ieee80211: clean up 
public action codes),
then it will be easy for someone to pick the patch if he/she only need 
the change of ieee80211.h.

Also same for commit 2c9abe653bc5(wifi: ieee80211: correctly mark FTM 
frames non-bufferable)
and commit 1a30a6b25f26(wifi: brcmfmac: p2p: Introduce generic flexible 
array frame member).

Right?😁

