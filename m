Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BE77DF592
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 16:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjKBPCl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Nov 2023 11:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKBPCk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Nov 2023 11:02:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEBD187
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 08:02:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2CtjcZ019322;
        Thu, 2 Nov 2023 15:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i8bu6OzOOokKbxYJkmLoobVMCZTR7aocliOXz74c27k=;
 b=KjlrNpL/qkClJeY/Mh8TCVL+iQYbWgZgdkl5FCWESPs35Q9/uZfD46fhbBDWr/ysOUuZ
 4lI5NLPBnDV0vlokrL6vZ/RPWfLKaONYspiM8iFUDciJsoipMRnlsvl5asIxZY6nNdto
 hofeKmTu6SR1X89xq2GOOA3EI6zr1zYqAHwrYnTpSqlMfisZeRAyJFnd2MPlBZM114Oh
 dfONl4fOArju99wqin2o0aD1qMMUJhIdcx40uYB2AcyIjNI+tnMUhOtcK8HtXP4VR+U5
 3dcqteqyZLaZPtN19UyOdVaq5IaA9yKEickoFVytN866FPtP8OJtwd9xFZieb3aiZk9u WA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u47d50u4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 15:02:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A2F2FJW015062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Nov 2023 15:02:15 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 2 Nov
 2023 08:02:14 -0700
Message-ID: <f2f09cac-d364-46eb-9dbd-ca90ddea32f8@quicinc.com>
Date:   Thu, 2 Nov 2023 08:02:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: simplify __ath10k_htt_tx_txq_recalc()
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20231102115459.69791-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231102115459.69791-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QlkItmYuzlJ9bw7LUcS_z8gS3cugohJN
X-Proofpoint-ORIG-GUID: QlkItmYuzlJ9bw7LUcS_z8gS3cugohJN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_04,2023-11-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=456 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/2/2023 4:54 AM, Dmitry Antipov wrote:
> Since 'ieee80211_txq_get_depth()' allows NULL for 2nd and
> 3rd arguments, simplify '__ath10k_htt_tx_txq_recalc()' by
> dropping unused 'frame_cnt'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

