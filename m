Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE467F17E7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 16:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjKTPyc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 10:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjKTPyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 10:54:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFE8100
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 07:54:28 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKBDatH030911;
        Mon, 20 Nov 2023 15:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4bd0XRe4FCwWZRIDjVvl8uD5OUgY+a0/D7Aa0HY1R1c=;
 b=PIdYeLte7DstmGy1+5p6oshebbpDm1Ks8AkwNwOoJVrTxIR4h6I5oIvlE6c510wX5WgP
 YXo1iQchsfRnj+dcZ4SgGcMohgdgglDMWUq3w4/iFsHnmYoaHPWw8wj9YWa0jVEptfqy
 UHlnJwzkbeG8gkGzKgmEoP1EzJ61PiWtdttvm3PLbDIRtAJAdUyI42ZV8ZOUqngGKx0T
 WJaDdSEcIy5XXXd4rTtnHmrXNGA7jyc5DRqrzPVR4ZwVLoxKkFDehv9c0mtJLwfG7LQJ
 3yW8S2eFDcnt2wigaUyCeNchqe3uyp/xz2cwn66DAX1+9aHNNf2t/mTAmQyYGZcQZaEz Vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uepjhma5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 15:54:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKFs1FN001416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 15:54:01 GMT
Received: from [10.110.116.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 07:54:00 -0800
Message-ID: <05f2ec30-07ed-46ca-958e-b3f5e3a18ea9@quicinc.com>
Date:   Mon, 20 Nov 2023 07:54:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] wifi: ath12k: do not restore ASPM in case of single
 MSI vector
Content-Language: en-US
To:     Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231120101543.4369-1-quic_kangyang@quicinc.com>
 <20231120101543.4369-7-quic_kangyang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231120101543.4369-7-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q4kzSwsbvGHkFb5QD0AoxPDxj5qHAxI2
X-Proofpoint-GUID: q4kzSwsbvGHkFb5QD0AoxPDxj5qHAxI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_16,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=809 clxscore=1015 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200112
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/20/2023 2:15 AM, Kang Yang wrote:
> Current code enables ASPM by default, it allows MHI to enter M2 state.
> In case of one MSI vector, system hang is observed if ath12k does MHI
> register reading in this state.
> 
> The workaround here is to prevent MHI from entering M2 state, this can
> be done by disabling ASPM if only one MSI vector is used. When using 32
> vectors ASPM is enabled as before.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

