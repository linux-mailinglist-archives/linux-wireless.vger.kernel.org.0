Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044947DC3C0
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 02:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjJaBBh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 21:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaBBg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 21:01:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD4BC2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 18:01:33 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V0j9PV012095;
        Tue, 31 Oct 2023 01:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NqpG0HY9NznEIOYNaUGWpcy0PLVZ80Mu2FaWtICuwXg=;
 b=b7JSPkfI+w3Lg6WBdd6J5hYY/xsYGNJdOEdb+gr7cLqETa4X9dmVWuWq9B4Kxe9dSgt9
 ccIcR3OdFYz/w14LS/L05ycE0LazT2fn+t+pbCV/uI9PhQ794TRP0QQsw2oIdfOqKuEz
 Cv34d6vPdUuJbwdfmvOGFchUL7ZeXExvbWl/yV3Wa+w4BVKHPjmUb1CjrTzIyfupOY/z
 r7VQC34IGpj9/3fqtPkeeH+4YLg/CB7VY2yuIThs4kEhcLrL1Ss99b+iCWcQ2h7mtTCA
 YTA6SBefKU3f4mtu/HY6cpSzpFGChCkTKJHXCNN5o95rBq9qI+PFylPfkWihA3LLV/ZE RA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2b2qssgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 01:01:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V11Tnq005145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 01:01:29 GMT
Received: from [10.48.245.206] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 18:01:29 -0700
Message-ID: <6bf9561d-6fa4-48cc-bfc0-59534bd7d6c6@quicinc.com>
Date:   Mon, 30 Oct 2023 18:01:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] wifi: ath12k: add MAC id support in WBM error path
Content-Language: en-US
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
 <20231030222700.18914-12-quic_rajkbhag@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231030222700.18914-12-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qU1i7SQBEalOkERIoyCdf7C_Kb5p0mld
X-Proofpoint-ORIG-GUID: qU1i7SQBEalOkERIoyCdf7C_Kb5p0mld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501 mlxlogscore=801
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310310007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/2023 3:26 PM, Raj Kumar Bhagat wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> When more than one pdev is supported in the chip/SoC, the packet
> belonging to second pdev is given to first pdev due to not identifying
> the MAC id in the WBM error path. So ping fails.
> 
> In WBM error path, src link id information not available in the
> descriptor. So get this information from the msdu_end 64bit tag. It
> is necessary to get the src link id to identify the MAC id in the
> given chip. Then only we can pass the skb to the corresponding pdev.

based upon the code it seems this only works when compact descriptors 
are in use? IMO that should be highlighted.

> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

