Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814646EF8B1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 18:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjDZQtn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 12:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDZQtl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 12:49:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4365FF4
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 09:49:39 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QG4XYH025015;
        Wed, 26 Apr 2023 16:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OGFCBSk9Ao2wgRC4CQBkJE67+vbisEmpOdkqP44I7UI=;
 b=R/wF55uO4Xg6cf5yblw3Iv7d0+fvlOEmEF5rFQYnMQfcURLY4PVLdq3kaNvmMn1/Hfh+
 1+iOaTR9dkE+VCi2xJOmIOi3YWG/Bv84rSYlX8lV12uQ6Y6XuWqLuy0T2smpx5wn8Sfi
 zZRkFS7xilUfaer7FFjc15AlI3qf8fePa83tik0mH7s2yCzBmdRUNcI808/QMmQ437Os
 CV4cFlX9rlEp3tNVueKYTwXhho8HAQ5TkQMXDll27mYsz1QU5rknBL83OQeqoQxHYOOi
 +cxv2w0m+/hZ1ZS2SpzK630IkNgRy2lHsKxQok8OcjLUyq4bDsawDLpanyxJjyHtnigA rA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q6uprst0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 16:49:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33QGnT3i007847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 16:49:29 GMT
Received: from [10.110.11.241] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 26 Apr
 2023 09:49:29 -0700
Message-ID: <759bf2e8-ce51-b882-7d26-7ae57b8cf571@quicinc.com>
Date:   Wed, 26 Apr 2023 09:49:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 00/11] wifi: ath12k: (v3) EHT support
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230413215156.2649-1-quic_alokad@quicinc.com>
 <87ildjtc1c.fsf@kernel.org>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <87ildjtc1c.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8Ua1JzCLdsQzG9TIEPwsyCC_wqqpXbmD
X-Proofpoint-GUID: 8Ua1JzCLdsQzG9TIEPwsyCC_wqqpXbmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_08,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260148
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/25/2023 11:03 PM, Kalle Valo wrote:
> Aloka Dixit <quic_alokad@quicinc.com> writes:
> 
>> Add driver support to bring AP up in EHT mode, configure a preamble
>> puncturing bitmap and associate with an EHT client.
>>
>> v3: Modified patches 6 and 9 to fix some issues,
>> changelog included in the respective patches.
>> v2: This version modifies only few commit descriptions,
>> changelog included in the respective patches.
>>
> This breaks WCN7850 support:
> 
> [  144.039164] ath12k_pci 0000:06:00.0: BAR 0: assigned [mem 0xda200000-0xda3fffff 64bit]
> [  144.039315] ath12k_pci 0000:06:00.0: enabling device (0000 -> 0002)
> [  144.046220] ath12k_pci 0000:06:00.0: Hardware name: wcn7850 hw2.0
> [  144.118539] mhi mhi0: Requested to power ON
> [  144.118716] mhi mhi0: Power on setup success
> [  144.222303] mhi mhi0: Wait for device to enter SBL or Mission mode
> [  144.627712] ath12k_pci 0000:06:00.0: chip_id 0x2 chip_family 0x4 board_id 0x104 soc_id 0x40170200
> [  144.627945] ath12k_pci 0000:06:00.0: fw_version 0x1005bc12 fw_build_timestamp 2022-10-11 12:13 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> [  144.959196] ath12k_pci 0000:06:00.0: failed to parse tlv -22
> [  144.959317] ath12k_pci 0000:06:00.0: failed to parse ext2 event tlv -22
> [  150.263567] ath12k_pci 0000:06:00.0: failed to receive wmi service ready event: -110
> [  150.276547] ath12k_pci 0000:06:00.0: failed to start core: -110
> 

I have started seeing ETIMEDOUT on QCN9274 as well, AP bring up fails in 
vdev sync. It works if the sync timeout is increased.
