Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB877E770
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 19:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbjHPRQl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 13:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbjHPRQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 13:16:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE526A4
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 10:16:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFQ0Js004658;
        Wed, 16 Aug 2023 17:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Wqt8OCpL07OU0gTSF3R3GX6R0XS2k8uPgoYDjDf3U9A=;
 b=FLphrX0zLEFaiPfSntTk993sArbpfBucPxEfTZ0cAE8YINko60TpeFBuo1YFXFULcAtG
 mShCid6ZBEIf6W6MxVIFITxowHC0mudbgFNmBjdeHOMn083qL/8hH9tTG2OfcGls9a0J
 JSBbmiF2mBECvsDhfVL0z4oqIh61DrrnZjSibdqWhdQY7c3CZ2+dkTAQnZKl9/Rv63jX
 zQXpGbCK4ARjEMg7SCj1Gn7NOKvUa6S7pO07aN0rFaOe50AXAxp6/sVzoWAPQxzD4Bpm
 dlKUMmrwaXqOtY62riMTS6ztapTD5Lwwl/SGwt94eClC0AMBuzkEB6Aix+K4BnVZ2PEn IQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgmkksups-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:16:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37GHGNJE012568
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:16:23 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 10:16:23 -0700
Message-ID: <a0b5b463-31b7-e641-4af6-9ec186ce1b93@quicinc.com>
Date:   Wed, 16 Aug 2023 10:16:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: beacon EHT rate support
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230329000902.17992-1-quic_alokad@quicinc.com>
 <d54800ae88be1eb232df7794e741dfc304c3ee9a.camel@sipsolutions.net>
 <312f1476-b78b-b7f0-26f9-512a7dc2b6b7@quicinc.com>
 <3abb2d127eaa3b76a8f4f34c795ddd6d502ce470.camel@sipsolutions.net>
 <1aa6178f-2041-797e-fcb8-78fe2c08de24@quicinc.com>
 <d2bd82291f6588c75aa17d43086ecd14f25f691f.camel@sipsolutions.net>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <d2bd82291f6588c75aa17d43086ecd14f25f691f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mqjhDNOFqlXsbgdKDccEke4hDyYwiUEA
X-Proofpoint-GUID: mqjhDNOFqlXsbgdKDccEke4hDyYwiUEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_17,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=513 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/15/2023 8:12 AM, Johannes Berg wrote:
> Sorry, I completely dropped the ball on this.
> 
> I don't know? I guess you need it somehow? Can we fix mac80211? Or maybe
> just make it clear that it won't work there? To be honest, it's not
> really in my head anymore now, unfortunately.
> 
> What exactly do you need? Maybe we can work back from that.
> 
> johannes

Will get back to you on this in few days.
Thanks.
