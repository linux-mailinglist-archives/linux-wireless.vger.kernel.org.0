Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6507DC335
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 00:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjJ3XfD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 19:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3XfC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 19:35:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478A6FA
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 16:35:00 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UNS6pG022263;
        Mon, 30 Oct 2023 23:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LGFm/6htql5qYJ2ctvGV3KEbt1gHigZrgdfYLf4gT44=;
 b=EutInS3wtPON65WtEkkDIVn0g9oPMYIgqdxXu9FtftagPzc54YGDLslVxZhF7krgk2xW
 9Z7UKZ7/q2hhDFvG7v/0DDqYbO0250vNa2gVFeNKc1BWH0KDSrobjIuJ97SG5/3ibwIY
 E9PB3crRv39Nk/a4ZZjzvjuoDoVkLxhLA0OHg4OEqIS3pN+iIajN/GdOd+Ran3uDjfIR
 Jd9Pt2bKTZRmzb9a/bmGXaEygxPTgD4YwNYzi49W6ndH5tNvOFataGZJYs/0jmjpiv7n
 QWM1UoSsUKJ5+Lke0ccCKsmV9LkzjePAYL+IqxLk++SKKcd4CWbiVKHGHksPm9pPg8BS pA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2c4rsffa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 23:34:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UNYvVK020557
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 23:34:57 GMT
Received: from [10.48.245.206] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 16:34:57 -0700
Message-ID: <13753715-9dbd-4f82-b526-55e65a9b9894@quicinc.com>
Date:   Mon, 30 Oct 2023 16:34:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] wifi: ath12k: remove hal_desc_sz from hw params
Content-Language: en-US
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
 <20231030222700.18914-10-quic_rajkbhag@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231030222700.18914-10-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EsESw4WlLoGXgs3hdU4kZdEz73qizSeb
X-Proofpoint-GUID: EsESw4WlLoGXgs3hdU4kZdEz73qizSeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/2023 3:26 PM, Raj Kumar Bhagat wrote:
> With word mask subscription support, the rx_desc structure will
> change. The fields in this structure rx_desc will be reduced to only
> the required fields. To make word mask subscription changes compatible
> with the older firmware version (firmware that does not support word
> mask subscription), two different structures of rx_desc will be
> required for the same hardware.
> 
> The hardware param hal_desc_sz value cannot be constant for the same
> hardware. It depends on the size of rx_desc structure which may
> change based on firmware capability to support word mask subscription.
> Hence, remove hal_desc_sz from hardware param and add hal_rx_ops
> to get the size of rx_desc in run time.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


