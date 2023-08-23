Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B9B78609E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjHWT3M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 15:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjHWT25 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 15:28:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D72E6E
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 12:28:56 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NHu0uM031525;
        Wed, 23 Aug 2023 19:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nWkX+BUg99eXcykkBankFCkg8ZVaQEgKD6CtJCFVD44=;
 b=Id4HPBFb1+0qXNnpa+LE9+e9nj+fkLBshuSdSQGsAX4zpmO2wq+9Jog6vjCh4RB/Eyh1
 7qM2F62B7ZL1Wi0MrlNtq6SkwCwheSr4aMsQzf82RZvHPMkS01b0+K/pAI7II5vvM1de
 rEqcf0z3fxi4/OnsAFnxzTl5kwx6R1Pt1V39+LK29bNP4CUE8mraM5xBtDd9e+BxvMGo
 qsP/pfQ0Qg8OA2bkWKYh4Qfl53MA5O6VRNqS/grSdJm79zIqlHm3oVQLApWzmjuF2fic
 S5WP1D18ASfwrRVphgjX9897/DK3QBgLGcwZYTnpfGz2U2J8lUEVO4Ow2yA8xkmTZ3t2 Iw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn208k2b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 19:28:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NJSmaX017649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 19:28:48 GMT
Received: from [10.48.244.52] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 12:28:47 -0700
Message-ID: <e5a64ac0-7f4b-40c3-8f63-d96cae2568e9@quicinc.com>
Date:   Wed, 23 Aug 2023 12:28:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] wifi: ath12k: add msdu_end structure for WCN7850
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230815062610.59248-1-quic_kangyang@quicinc.com>
 <18b72ba8-7f0c-ed88-38f7-7422a179519f@quicinc.com>
 <87jztlhboj.fsf@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87jztlhboj.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HRuNPNaqQRHpRflOOI5ovZ8ZDv5-OmZd
X-Proofpoint-ORIG-GUID: HRuNPNaqQRHpRflOOI5ovZ8ZDv5-OmZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 impostorscore=0 mlxlogscore=394 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/23/2023 11:10 AM, Kalle Valo wrote:
> Jeff, for some reason your mail didn't have Cc linux-wireless so
> patchwork don't show your comments:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20230815062610.59248-1-quic_kangyang@quicinc.com/
> 
> The problem is that if there are no comments in patchwork I will most
> likely miss them. Adding linux-wireless back now.
> 

Thanks for the reminder to make sure I always select Reply-All vs Reply-list
