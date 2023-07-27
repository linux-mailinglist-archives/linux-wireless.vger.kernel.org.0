Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B76176530F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjG0MAr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 08:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjG0MAq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 08:00:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0290C272A
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 05:00:43 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R80CXN013108;
        Thu, 27 Jul 2023 12:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yzBNCFjs3BQDgEnY0hEgRVorqFsbUoUsDcjCM3bB7DU=;
 b=lfX222ddN2S+MK3kwv5tbY07UMeQil6IzXvQwMytzQk0g4TfbsYDyaLRV/yXE3EywrQj
 5Wi9XSnfD6L4RyOYbfXLgFsGHL4SxEgpMH2+5k1aX/wDW5ClCsCl3lvue9edJehGe8J+
 in+8gMQmzJhAqqbbnYs4Q8hyGcH6ZF4JhEb6eX2opsRmYgFpleJAbCvHUgH4U47MA1mY
 sDarN5KODqwFCv4MjzY4dVivwghdbDGeu7P4QbT6cCxYBtmu1ZMr+V9gIZcWWRmdTJBT
 mzpFUik01Judj3SIJ8EjNInfbXE7G1H9T9Jq24jnUyjk3sQJKEl0bDy80F9e2i0SS8tU Pg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s32jn2r06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 12:00:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RC0YD3018949
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 12:00:34 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 05:00:33 -0700
Message-ID: <db8afcb0-2297-7748-daeb-625eeb0b1c6c@quicinc.com>
Date:   Thu, 27 Jul 2023 17:30:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] wifi: ath11k: fix band selection for ppdu received in
 channel 177 of 5 GHz
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230726044624.20507-1-quic_adisi@quicinc.com>
 <8fe1a927-14da-445c-4c48-e3f4b4c324d4@quicinc.com>
 <87bkfx287p.fsf@kernel.org>
Content-Language: en-US
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <87bkfx287p.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gr7Nte_IOz_JsSSWUMzBd_4D0cY1oJ35
X-Proofpoint-ORIG-GUID: gr7Nte_IOz_JsSSWUMzBd_4D0cY1oJ35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=834 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270107
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/27/2023 11:42, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 7/25/2023 9:46 PM, Aditya Kumar Singh wrote:
>>> 5 GHz band channel 177 support was added with the commit
>>> "wifi: ath11k: add channel 177 into 5 GHz channel list". However,
>>
>> I'd use the same syntax here as in the Fixes tag:
>> e5e94d10c856 ("wifi: ath11k: add channel 177 into 5 GHz channel list")
>>
>>> during processing for the received ppdu in ath11k_dp_rx_h_ppdu(), channel
>>> number is checked only till 173. This leads to driver code checking for
>>> channel and then fetching the band from it which is extra effort since
>>> firmware has already given the channel number in the meta deta.
>>
>> nit: s/meta deta/metadata/
> 
> I can fix these in the pending branch.
Thanks Kalle.

