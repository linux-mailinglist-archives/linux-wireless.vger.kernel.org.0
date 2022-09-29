Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FCD5EEB62
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 03:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiI2B6j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 21:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiI2B6h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 21:58:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6689F122634
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 18:58:35 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SNY7sh018224;
        Thu, 29 Sep 2022 01:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kzVp61ULiNEr/UheqPybYwtTY6JF+p9P2hQujSFnfqk=;
 b=p7sOn75wQfntSVTYZ/geTMGyNUfoa7wiW+qrFDVBgWTTQEmbSgrs9wU+HpzFGhRx+ZZd
 4VeyzuLddot2uiPilJ9nIYZSlwuhH7Egc8G6pt8NrTrcOcFXGt9llvI4rUlbKR26cbtM
 KWTWMc3DWliuia07fJjkvrjvfqMNa4BDn2l74x5RGESo+pNTrsFwZUDaqTC+6tZHlloS
 9ZfAnz+F2DSu2RoSaTo1VD0NBV12PwqqxnpvvQt5ATTTkQ53635JzlFUeewM1gWQKPct
 a5IEy0qlPmhh5BhYwzoC/xhdgrQUMdx32EGrPhFjRzrajz+MFfVpJPn1maFsNZoA9rzj 8w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvm4vhsj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 01:58:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28T1wQV2032667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 01:58:26 GMT
Received: from [10.253.33.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 18:58:25 -0700
Message-ID: <d054b305-b711-7b80-a0f7-f32dd1682d27@quicinc.com>
Date:   Thu, 29 Sep 2022 09:58:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: parsing the multi-link element with STA profile wifi: mac80211:
 support MLO authentication/association with one link
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <48715509-62fd-2307-e38f-176234b482c1@quicinc.com>
 <f240b33d507daf898480b0a11eb27d4475e45164.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <f240b33d507daf898480b0a11eb27d4475e45164.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6JyFy0_siqUFp-oZu3ALQU7Tj7BoEMx1
X-Proofpoint-GUID: 6JyFy0_siqUFp-oZu3ALQU7Tj7BoEMx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_11,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=913 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290011
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/29/2022 3:28 AM, Johannes Berg wrote:
> On Wed, 2022-09-28 at 23:33 +0800, Wen Gong wrote:
>> Hi Johannes,
>>
>> May I know the status for below work which is written in the patch below?
>> I think it is needed in
>> ieee80211_assoc_config_link()/ieee80211_assoc_success(), right?
>>
> It passed the plugfest last week ;-)
it is good for that :)  -)
> Yes, I need to get this posted ... but now I got another urgent thing to
> look at, so it'll be some time.
>
> johannes
