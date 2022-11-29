Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96B963C26E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 15:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiK2O04 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 09:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbiK2O02 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 09:26:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9910455B8
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 06:26:27 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATCL1iR029556;
        Tue, 29 Nov 2022 14:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=SZjnXHPPN1Ut8g8P2Y1+5FPJWLt+1zQbRkMMtSRzjZU=;
 b=jY2TLn1S+BOjwsx6IGv+oYLmZrt6v8mk6uUKDhlU4mkgY7zRn0Jmy/sCi0WAw8KJniy8
 bZj7KTm6SZgG9MKnWR7CaXmTqnpWa537ZqvRI4YXhOvEhbttiwNEBspaZd6QjhFcMkw6
 X19px8GhQUUKshw/8Y+mjiR1ugsFr5Uzp9putDM9iphgo7X0+n1kPs7gr/Tv3oPVt29F
 mDY42YkagSucZKvDbx9QpIYhqwQrXS9YVlZpVV4No/yeycE7UhqsWE4FyrWpyQlGXh5T
 KQfnIlOgubiAKRI9pTWHjlfX1Alo0eaMw0SIF6oUg8p7f9QVLuuZGFxh8PwjQXna/f9n eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m56vca7ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 14:26:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ATEQJCf032046
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 14:26:19 GMT
Received: from nmaran-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 29 Nov 2022 06:26:17 -0800
From:   Nagarajan Maran <quic_nmaran@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
Subject: [PATCH] wifi:ath11k: fix monitor mode bringup crash
Date:   Tue, 29 Nov 2022 19:55:32 +0530
Message-ID: <20221129142532.23421-1-quic_nmaran@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cgH_B42v_HiQ4IZaGYVB_a0tnJi6SiAa
X-Proofpoint-ORIG-GUID: cgH_B42v_HiQ4IZaGYVB_a0tnJi6SiAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_08,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=372 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the interface is brought up in monitor mode, it leads
to NULL pointer dereference crash. This crash happens when
the packet type is extracted for a SKB. This extraction
which is present in the received msdu delivery path,is
not needed for the monitor ring packets since they are
all RAW packets. Hence appending the flags with
"RX_FLAG_ONLY_MONITOR" to skip that extraction.

Observed calltrace:

Unable to handle kernel NULL pointer dereference at virtual address
0000000000000064
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000048517000
[0000000000000064] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in: ath11k_pci ath11k qmi_helpers
CPU: 2 PID: 1781 Comm: napi/-271 Not tainted
6.1.0-rc5-wt-ath-656295-gef907406320c-dirty #6
Hardware name: Qualcomm Technologies, Inc. IPQ8074/AP-HK10-C2 (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ath11k_hw_qcn9074_rx_desc_get_decap_type+0x34/0x60 [ath11k]
lr : ath11k_hw_qcn9074_rx_desc_get_decap_type+0x5c/0x60 [ath11k]
sp : ffff80000ef5bb10
x29: ffff80000ef5bb10 x28: 0000000000000000 x27: ffff000007baafa0
x26: ffff000014a91ed0 x25: 0000000000000000 x24: 0000000000000000
x23: ffff800002b77378 x22: ffff000014a91ec0 x21: ffff000006c8d600
x20: 0000000000000000 x19: ffff800002b77740 x18: 0000000000000006
x17: 736564203634343a x16: 656e694c20657079 x15: 0000000000000143
x14: 00000000ffffffea x13: ffff80000ef5b8b8 x12: ffff80000ef5b8c8
x11: ffff80000a591d30 x10: ffff80000a579d40 x9 : c0000000ffffefff
x8 : 0000000000000003 x7 : 0000000000017fe8 x6 : ffff80000a579ce8
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 3a35ec12ed7f8900 x1 : 0000000000000000 x0 : 0000000000000052
Call trace:
 ath11k_hw_qcn9074_rx_desc_get_decap_type+0x34/0x60 [ath11k]
 ath11k_dp_rx_deliver_msdu.isra.42+0xa4/0x3d0 [ath11k]
 ath11k_dp_rx_mon_deliver.isra.43+0x2f8/0x458 [ath11k]
 ath11k_dp_rx_process_mon_rings+0x310/0x4c0 [ath11k]
 ath11k_dp_service_srng+0x234/0x338 [ath11k]
 ath11k_pcic_ext_grp_napi_poll+0x30/0xb8 [ath11k]
 __napi_poll+0x5c/0x190
 napi_threaded_poll+0xf0/0x118
 kthread+0xf4/0x110
 ret_from_fork+0x10/0x20

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Reported-by: Florian Schmidt <florian@fls.name>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216573
Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index c5a4c34d7749..2c2b9da37b3f 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5022,6 +5022,7 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 		} else {
 			rxs->flag |= RX_FLAG_ALLOW_SAME_PN;
 		}
+		rxs->flag |= RX_FLAG_ONLY_MONITOR;
 		ath11k_update_radiotap(ar, ppduinfo, mon_skb, rxs);
 
 		ath11k_dp_rx_deliver_msdu(ar, napi, mon_skb, rxs);
-- 
2.17.1

