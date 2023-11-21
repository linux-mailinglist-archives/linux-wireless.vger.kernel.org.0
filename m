Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811717F226D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 01:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjKUAlw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 19:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjKUAlg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 19:41:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F23BC
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 16:41:33 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL0C2oO025597;
        Tue, 21 Nov 2023 00:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hja+Vk8uwZic9pm0nwLPmiIIPeEmGvnjR0Rvf6zX9J0=;
 b=pkO8GMz5gKFfgelne4QCwbmBwBK+9+ZbDPxuG6r8MMgqzIGKNyt7NG/qWBTyb3ylCMt5
 3OvOypp9DZje2Qer75D71ipSZYANCkNAu6xdwsVXUtg9/0z4mC4gZZw0ruHFcYx79tdh
 2ojN8+sNT5MkFFQBMQ6J07AXORmo0+Q3NY3Tg0Z/lueBxdl0pzMXkpYfCVNdxnlRy6TZ
 BucqwpbQbPBreJQkkuf9CUMTo41wO795KvJMSCyNpCfIweUdpOKfEHM9DUdtBJLfSRvL
 9X+snRk8Ya6bqZJWwwE6K+igX972JfVu/mG9/r2LuNfRqopUBtyep8FmmTqE09QEKDts Nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug2axac69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 00:41:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL0fT7a029183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 00:41:29 GMT
Received: from [10.110.116.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 16:41:28 -0800
Message-ID: <fb2f4684-0f72-4ab4-975e-ff54fc37b9ec@quicinc.com>
Date:   Mon, 20 Nov 2023 16:41:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Optimize the mac80211 hw data access
Content-Language: en-US
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231120235812.2602198-1-quic_periyasa@quicinc.com>
 <20231120235812.2602198-2-quic_periyasa@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231120235812.2602198-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bsugHk6lafj4ZoODW2otDPcl3Hp2syFc
X-Proofpoint-ORIG-GUID: bsugHk6lafj4ZoODW2otDPcl3Hp2syFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=496 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/20/2023 3:58 PM, Karthikeyan Periyasamy wrote:
> Currently mac80211 hw data is accessed by convert the hw to radio (ar)
> structure and then radio to hw structure which is not necessary in some
> places where mac80211 hw data is already present. So in that kind of
> places avoid the conversion and directly access the mac80211 hw data.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

