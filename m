Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC77F333A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 17:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjKUQH4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 11:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjKUQHz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 11:07:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C46B191
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 08:07:51 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE1owu001387;
        Tue, 21 Nov 2023 16:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uuJcEiHPCpCm9NWvHC09XJ4ZqeLEo4MaCT3fMFr2EVY=;
 b=OS2kymU9wJlL7k83bvFy/cFlChfuuN5S59S7mB8aIUuy7gpMGbANZ0ctHU3SM9VJ0FaB
 DwnZAxwx+TcazO8WAHvr/hnx+gj6ueRvp8I1/9CDxHwTnXeoSvo6nZxFSOieB0ag7/gw
 JiKVE8CNSCKyAa7hvZq/mDTtiQyGNCTUhsP+r8WfeB3Qf8yzzzUSasN83Ixf+gY6jNA/
 pkEX/Z7X9IcfCwlICwQMwG11u0fAcv7x9XFUnsTniJ4cJrql9KMDK5dCDKm/E0zjIeC7
 AD4ous3Xz1JlTeTdocm6RQFgO+WeAgkofcDLmyvJHLq0uERNWELONOLQ7tAg5b+PMZPf pA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugcqs327x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:07:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALG7nQj029540
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:07:49 GMT
Received: from [10.110.116.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 21 Nov
 2023 08:07:48 -0800
Message-ID: <1796b817-797e-4673-bfee-2f55352c37be@quicinc.com>
Date:   Tue, 21 Nov 2023 08:07:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] wifi: ath12k: add support one MSI vector
Content-Language: en-US
To:     Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231121021304.12966-1-quic_kangyang@quicinc.com>
 <20231121021304.12966-6-quic_kangyang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231121021304.12966-6-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KruSnjpAmiONdQKlv_6BwwPdYNfQ0MTG
X-Proofpoint-GUID: KruSnjpAmiONdQKlv_6BwwPdYNfQ0MTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_09,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=790
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/20/2023 6:13 PM, Kang Yang wrote:
> On some platforms it's not possible to allocate 32 MSI vectors for
> various reasons, maybe kernel configuration, VT-d disabled, buggy BIOS
> etc. So ath12k was not able to use WCN7850 PCI devices on those
> platforms. Add support for one MSI vector to solve that.
> 
> In case of one MSI vector, interrupt migration needs to be disabled.
> This is because when interrupt migration happens, the msi_data may
> change. However, msi_data is already programmed to rings during initial
> phase and ath12k has no way to know that msi_data is changed during run
> time and reprogram again.
> 
> In case of one MSI vector, MHI subsystem should not use IRQF_NO_SUSPEND
> as WCN7850 doesn't set this flag too. Ath12k doesn't need to leave IRQ
> enabled in suspend state.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

