Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D516CB57E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 06:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC1Erh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 00:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1Erg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 00:47:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7CB1FEE
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 21:47:35 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S3kNNj026463;
        Tue, 28 Mar 2023 04:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m1ETkqQDyH5uYhMWfsgLcfrA3+Nvwy4QgGaXwtS8DEQ=;
 b=PhbapCYuhEwi19BVnEA4FiS30Y92k7/NL85f3cMKTTgDvYRPr4Oc3TVv7UGPU69qgXBA
 BLPiagBq2H44oo/t/tytgqnI6980kF0NSZa1Y9dhALNJFd0sUFK0RG6e43Gcot7ZIpiu
 BQ9P5iBmvCvPVl9hOo4N5c6Gm3ZsRJzvmSqDnmArndibIPUdko2hQ1pBRMuAwAeXChYk
 H5tXn4VfgoJ3/yRS17wj6q8KXd7s+XsCma6URpkdUxmzRZ/4daeVzNSECoSVAWBZe2kf
 ROk8puCW1sJKMwkJXWza3/AAeYerbKJ3g2iigDorf/QySDjWBMLJiMlOQ26Snzv+Goua Xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk8pvjdsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 04:47:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S4lJoI030166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 04:47:19 GMT
Received: from [10.242.242.48] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 21:47:17 -0700
Message-ID: <0289c7f1-e729-e924-5ae8-a6156266e675@quicinc.com>
Date:   Tue, 28 Mar 2023 10:16:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] ath11k: factory test mode support
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230213130854.2473-1-quic_rajkbhag@quicinc.com>
 <87edpson9o.fsf@kernel.org>
Content-Language: en-US
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <87edpson9o.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yV2G2Ec1YiJSJX-wiyyzPG4WUVrR3xdS
X-Proofpoint-ORIG-GUID: yV2G2Ec1YiJSJX-wiyyzPG4WUVrR3xdS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 mlxlogscore=818
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280037
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/13/2023 5:51 PM, Kalle Valo wrote:
> Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:
> 
>> Device is booted in factory test mode to calibrate the board.
>> The commands are sent from a userspace application, which is
>> sent to firmware using wmi commands. Firmware will send the
>> response back to the application which stores the calibration
>> data in caldata.bin file. This file will be loaded when the
>> device boots up normally next time.
>>
>> Govindaraj Saminathan (1):
>>   wifi: ath11k: factory test mode support
>>
>> Sowmiya Sree Elavalagan (1):
>>   wifi: ath11k: Allow ath11k to boot without caldata in ftm mode
> 
> While reviewing the patches I made quite a few style cleanup to patches
> (too many to list):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=4a5ca29c396ace5c46b208a8c15a3ba53eabaddd
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=ba74c7478f5d15ce38e609b9ad4810db7511a3dd
> 
> I only compile tested them. Please use these as the baseline for v2.
> 
Hi Kalle,

Unable to get the baseline patch for v2 from the above link. Getting the
below error with the link:
Bad commit reference: 4a5ca29c396ace5c46b208a8c15a3ba53eabaddd
