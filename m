Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF96FEFC2
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 12:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbjEKKPk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbjEKKPi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 06:15:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD6F10DD
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 03:15:37 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B8EN91021129;
        Thu, 11 May 2023 10:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3dcVaqAB/bdugJEpbEzzQDKLrrtwmbvcyw9R2s1UEIg=;
 b=Xe0o68WFffKTBaQOisXPdgWpifTm3ELPPmJE8kZUVO9rXjigqUnXPUHioYotXa38GYqn
 Df7xXV2HIz3iw3CPvnX7v5nqmdq9GBB3WjITm6lmWh5eaidZe0nH0LpDtgdZQoNgXbop
 wKhIgjzqUvzLzyf/pW6J3CLyAeQw6znqr+hUJs3wtnsL/Lmkj+fE4/zXp3UAXC5iCD3Z
 sX/nFx6lrBsFC7WB+CMdQ+J//8a6WC9rFK9vlcR5J0lUIPWkX+zpEcKTlUqxtRvEGu3h
 7vga3J0mbGlCiIHxXqOdKWclJQ+2jHr1IQJzshBPa4RM7p36tP54UHgXniRLYqzh0br7 bQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgv1t8bde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 10:15:26 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34BAFQJ3004987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 10:15:26 GMT
Received: from [10.201.192.62] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 11 May
 2023 03:15:24 -0700
Message-ID: <dd5c9dfb-519f-0d64-72a8-50f72f7a9998@quicinc.com>
Date:   Thu, 11 May 2023 15:45:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] ath11k: Relocate the func
 ath11k_mac_bitrate_mask_num_ht_rates() and change hweight16 to hweight8
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230504092033.3542456-2-quic_mkenna@quicinc.com>
 <a409ded2-f6e5-bc74-3fdb-231a92d9bde5@quicinc.com>
 <877ctfnpnb.fsf@kernel.org>
Content-Language: en-US
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <877ctfnpnb.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NjNlN1IH-OIivDoucrgD9d4_WpM6esyR
X-Proofpoint-GUID: NjNlN1IH-OIivDoucrgD9d4_WpM6esyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=858 malwarescore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110087
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 5/11/2023 3:41 PM, Kalle Valo wrote:
> Maharaja Kennadyrajan <quic_mkenna@quicinc.com> writes:
>
>> Ignore this patchset, I have sent the v2 version of this patchset by
>> rebasing it on latest TOT.
> Why? I had already applied v1 to the pending branch without issues:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=e3fd9d322448ee29c65a30e9bedaed222d7548b9
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=b7c3ee0ddc2bf3ecf511793aa55622a9aa62e420
>
> Is there a reason why I should take v2 instead?
[Maha]: No change in v2. As the cover letter of v1 patch was not sent 
along with with v1 patches, cover letter mail didn't link to the patches 
mail in the patchwork. Hence, sent v2 patch.
Please proceed with v1 patch if it is already in progress.
