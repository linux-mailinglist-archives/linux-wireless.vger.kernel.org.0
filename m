Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31D17DBEB0
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjJ3RU3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJ3RU2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 13:20:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF02C8E
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 10:20:26 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UEjbxN002123;
        Mon, 30 Oct 2023 17:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hKHlqhiTGuM6R1Y8v3BQ07PM/z+bLQD9LA/TEArtAjI=;
 b=UDwYpt1lZIPMVEzYSIfLN0psLRFYlQMqpqVq5/WoehvrwelO0QENsTnuDWg5yZ6YigyH
 0b20+yyaieWnuZyt0e7uNkJmy9nEv+MFtvRMJyylKCLUIT6eYgo5p4wTWfHFxn4BvZod
 f7sey5ih8LsF17JCswrnDbb0BcWlwsWa4a+UfiT0sF/1WjwZ9muDMNlt3m1JnDBg83hE
 hf+iCLWLGCGBva1kL8S5/cZ+Nm5ls7/YPgPjqbMh5qTfTovSjOhxiG5VoyxngPJXIhuL
 kHHwiI8Yf1gXm1S2LxEzh3ZGMa5mCMS2FM8Ts7Q65GMgWL9nFk0ufr4HLC5M5xwlQUNH Vw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2egsrefq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 17:20:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UHKLEW021230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 17:20:21 GMT
Received: from [10.48.245.206] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 10:20:21 -0700
Message-ID: <458d0da2-f293-431a-91d3-4a8f929bf1e6@quicinc.com>
Date:   Mon, 30 Oct 2023 10:20:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] wifi: ath12k: add factory test mode support
Content-Language: en-US
To:     Aaradhana Sahu <quic_aarasahu@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231030082749.17855-1-quic_aarasahu@quicinc.com>
 <20231030082749.17855-4-quic_aarasahu@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231030082749.17855-4-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aO3o_JjvFsy8EeUb6PoNMV8T53enm82w
X-Proofpoint-GUID: aO3o_JjvFsy8EeUb6PoNMV8T53enm82w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=878 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/2023 1:27 AM, Aaradhana Sahu wrote:
...
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
...
> +struct ath12k_wmi_ftm_event {
> +	struct ath12k_wmi_ftm_seg_hdr_params seg_hdr;
> +	u8 data[];
> +} __packed;

should be a blank line here

>   #define WMI_BEACON_TX_BUFFER_SIZE	512
>   
>   struct wmi_bcn_tmpl_cmd {

