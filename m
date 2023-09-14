Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE457A0977
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbjINPiY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 11:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbjINPiX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 11:38:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F4A99
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 08:38:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EFET44003724;
        Thu, 14 Sep 2023 15:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XMQMDc+eLKKF7l5RHNDJuxkzaT2DtFCyXhWXGas25Yg=;
 b=ZN2pFyz1vATBCmmBEGJDmpsgESjWbcKzx+/5mndYqob7xkERzNmjwDsjKC8GZn4zOYTV
 cdUJG8n8cBVkoQcgQ1xdGcZKayAF2rCo1xFfCGs13CfgDVUbdbzjlpUW1vooQOGUTFET
 XLeDtkPp6FV6zwOlgUrVxvdCvJznqV1os/rE+OaUxCrMxt0Lzo8sSU39MgPR6f95uzf+
 2pCxBik6RiVWNMPayA82m3RkpKbTxROJmqOxTOHVifMFl8TI36+zLpnR/l3WwH4ZQGy+
 MJLxiI87uQzryTMmsjkiczlz5g+G/YpnMKvVsCNrM1IiH0TI6JBDw1PllBIOrXPAN0km sw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t411s8x39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 15:38:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EFc9uO031249
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 15:38:09 GMT
Received: from [10.111.183.186] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 08:38:08 -0700
Message-ID: <18eac255-720a-488e-882e-b79f098aba65@quicinc.com>
Date:   Thu, 14 Sep 2023 08:38:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On status handling in ath10k_htt_rx_tx_compl_ind()
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <9485af8e-3379-f592-0e8f-0eaebf4fbc05@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <9485af8e-3379-f592-0e8f-0eaebf4fbc05@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vmnhJs9XD29LuWFc7kpIQ2-9croUaUJT
X-Proofpoint-GUID: vmnhJs9XD29LuWFc7kpIQ2-9croUaUJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=516 lowpriorityscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140135
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/2023 10:15 PM, Dmitry Antipov wrote:
> In 'ath10k_htt_rx_tx_compl_ind()',
> 
> int status = MS(resp->data_tx_completion.flags, HTT_DATA_TX_STATUS);
> 
> actually is
> 
> int status = (((resp->data_tx_completion.flags) & 0x07) >> 0);
> 
> which can't be equal to HTT_DATA_TX_STATUS_DOWNLOAD_FAIL (128)
> regardless of the 'data_tx_completion.flags' value. This is most
> likely a weird (but I have no clue how serious it may be) bug.
> 
> Dmitry

Looking at firmware code I don't see any reference to a "download fail" 
status so I don't think firmware would ever send such a status.

If you want to submit a patch, the correct fix is to remove all 
references to HTT_DATA_TX_STATUS_DOWNLOAD_FAIL.

/jeff
