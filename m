Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17539785B42
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbjHWO5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjHWO5n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 10:57:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1186E6D
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 07:57:41 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NDAbuA028845;
        Wed, 23 Aug 2023 14:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d7UnrTOPzHM0ma6fKGQ+AAFNHq0tpNwwB1s8dJW3voY=;
 b=kgIOZhHev98p6aztb4fOzGk1XM810cO8CFLrWOadVc0o7REYpqd6XFRsjbZF3l154UQO
 s+71gVjjrBfQD8p/3QTxbd7vjYQYSLjebcFaHPTEQNO3V3P2wIlBWKuVGFmJcDfY9GUQ
 1ESG5Dw7PStQ4auToa9MSJtUS8R91c02DzR3Y4JPP+a0yBu5FZSNOJqkuIQux9nPtCHf
 k11Ixzv1bFoCG4eQA6sFn3HHRsz7T/3Cl/gjVb+WC9iRXdzv9SG6N0yF4M5Ilf0rGjPK
 jtNG6ciANodUt1lPRQ7r8oP5QlGlKBGSbCCG/RKWSYVxUloPbStGvlhfTUhUzX7YRViC aQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn25vjcv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 14:57:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NEvZeU023205
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 14:57:35 GMT
Received: from [10.48.244.52] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 07:57:34 -0700
Message-ID: <e3c6581d-ba60-41c9-8551-8d2f2001743f@quicinc.com>
Date:   Wed, 23 Aug 2023 07:57:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] [v2] wifi: ath10k: simplify ath10k_pci_pm_suspend()
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>, <ath10k@lists.infradead.org>
References: <20230823095008.50515-1-dmantipov@yandex.ru>
 <20230823095008.50515-3-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230823095008.50515-3-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YXzSbQr8J3sT-qHhKGJ4X_qrGIJDJxBg
X-Proofpoint-GUID: YXzSbQr8J3sT-qHhKGJ4X_qrGIJDJxBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=481
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/23/2023 2:50 AM, Dmitry Antipov wrote:
> Since 'ath10k_pci_suspend()' always returns 0, it may be converted to
> 'void' and 'ath10k_pci_pm_suspend()' may be simplified accordingly.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

