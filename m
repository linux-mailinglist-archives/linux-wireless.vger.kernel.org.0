Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3776A97C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 08:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjHAGsy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 02:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjHAGst (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 02:48:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5FDB
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 23:48:46 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3714hhfI020334;
        Tue, 1 Aug 2023 06:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=o3tTn/QGtSfcH6bhNnuJPrwt2C6r5/TPqiUwkds0VKs=;
 b=UaM5aT9V6s/E3FJTzr0Q4a74UQYzX17C4WhEv2s3JcY0pHMcX/3vFVn+T3E8YbQxX/yt
 nla0b/KiXeFcr7EAE7CMNi21kqL5k2JR4SmtAubYt+jMVrs56uySh2zXGDpl2MShXDjD
 9vLNvmXx3s7LH/pgi1tezaidOY1bHqKD698OnVbJMuXtKSZxNDJrSCDRYsOi7/c16qIa
 Jio7pYUGdq20RqDlCi0mF0fXtIXu42iHJS+38da28Ug4eu7MgzAhMW3Ujc7vnniOfK3A
 xXpCLhgYsb6aGkm8RGi7LLm4SeaKMb1xPwct95KNb9eI/fIhIcn7PB5zyCgo7VxqLdyE fA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6rnnrf4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 06:48:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3716m6IB023627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 06:48:07 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 23:48:05 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <wgong@codeaurora.org>
Subject: [PATCH] wifi: mac80211: allow transmitting EAPOL frames with tainted key
Date:   Tue, 1 Aug 2023 02:47:51 -0400
Message-ID: <20230801064751.25803-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DyjqzH6hf3dE1fk95MdlhcJC-3ahzUbJ
X-Proofpoint-GUID: DyjqzH6hf3dE1fk95MdlhcJC-3ahzUbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=699
 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lower layer device driver stop/wake TX by calling ieee80211_stop_queue()/
ieee80211_wake_queue() while hw scan. Sometimes hw scan and PTK rekey are
running in parallel, when M4 sent from wpa_supplicant arrive while the TX
queue is stopped, then the M4 will pending send, and then new key install
from wpa_supplicant. After TX queue wake up by lower layer device driver,
the M4 will be dropped by below call stack.

When key install started, the current key flag is set KEY_FLAG_TAINTED in
ieee80211_pairwise_rekey(), and then mac80211 wait key install complete by
lower layer device driver. Meanwhile ieee80211_tx_h_select_key() will return
TX_DROP for the M4 in step 12 below, and then ieee80211_free_txskb() called
by ieee80211_tx_dequeue(), so the M4 will not send and free, then the rekey
process failed becaue AP not receive M4. Please see details in steps below.

There are a interval between KEY_FLAG_TAINTED set for current key flag and
install key complete by lower layer device driver, the KEY_FLAG_TAINTED is
set in this interval, all packet including M4 will be dropped in this
interval, the interval is step 8~13 as below.

issue steps:
      TX thread                 install key thread
1.   stop_queue                      -idle-
2.   sending M4                      -idle-
3.   M4 pending                      -idle-
4.     -idle-                  starting install key from wpa_supplicant
5.     -idle-                  =>ieee80211_key_replace()
6.     -idle-                  =>ieee80211_pairwise_rekey() and set
                                 currently key->flags |= KEY_FLAG_TAINTED
7.     -idle-                  =>ieee80211_key_enable_hw_accel()
8.     -idle-                  =>drv_set_key() and waiting key install
                                 complete from lower layer device driver
9.   wake_queue                     -waiting state-
10.  re-sending M4                  -waiting state-
11.  =>ieee80211_tx_h_select_key()  -waiting state-
12.  drop M4 by KEY_FLAG_TAINTED    -waiting state-
13.    -idle-                   install key complete with success/fail
                                  success: clear flag KEY_FLAG_TAINTED
                                  fail: start disconnect

Hence add check in step 11 above to allow the EAPOL send out in the
interval. If lower layer device driver use the old key/cipher to encrypt
the M4, then AP received/decrypt M4 correctly, after M4 send out, lower
layer device driver install the new key/cipher to hardware and return
success.

If lower layer device driver use new key/cipher to send the M4, then AP
will/should drop the M4, then it is same result with this issue, AP will/
should kick out station as well as this issue.

issue log:
kworker/u16:4-5238  [000]  6456.108926: stop_queue:           phy1 queue:0, reason:0
wpa_supplicant-961  [003]  6456.119737: rdev_tx_control_port: wiphy_name=phy1 name=wlan0 ifindex=6 dest=ARRAY[9e, 05, 31, 20, 9b, d0] proto=36488 unencrypted=0
wpa_supplicant-961  [003]  6456.119839: rdev_return_int_cookie: phy1, returned 0, cookie: 504
wpa_supplicant-961  [003]  6456.120287: rdev_add_key:         phy1, netdev:wlan0(6), key_index: 0, mode: 0, pairwise: true, mac addr: 9e:05:31:20:9b:d0
wpa_supplicant-961  [003]  6456.120453: drv_set_key:          phy1 vif:wlan0(2) sta:9e:05:31:20:9b:d0 cipher:0xfac04, flags=0x9, keyidx=0, hw_key_idx=0
kworker/u16:9-3829  [001]  6456.168240: wake_queue:           phy1 queue:0, reason:0
kworker/u16:9-3829  [001]  6456.168255: drv_wake_tx_queue:    phy1 vif:wlan0(2) sta:9e:05:31:20:9b:d0 ac:0 tid:7
kworker/u16:9-3829  [001]  6456.168305: cfg80211_control_port_tx_status: wdev(1), cookie: 504, ack: false
wpa_supplicant-961  [003]  6459.167982: drv_return_int:       phy1 - -110

issue call stack:
nl80211_frame_tx_status+0x230/0x340 [cfg80211]
cfg80211_control_port_tx_status+0x1c/0x28 [cfg80211]
ieee80211_report_used_skb+0x374/0x3e8 [mac80211]
ieee80211_free_txskb+0x24/0x40 [mac80211]
ieee80211_tx_dequeue+0x644/0x954 [mac80211]
ath10k_mac_tx_push_txq+0xac/0x238 [ath10k_core]
ath10k_mac_op_wake_tx_queue+0xac/0xe0 [ath10k_core]
drv_wake_tx_queue+0x80/0x168 [mac80211]
__ieee80211_wake_txqs+0xe8/0x1c8 [mac80211]
_ieee80211_wake_txqs+0xb4/0x120 [mac80211]
ieee80211_wake_txqs+0x48/0x80 [mac80211]
tasklet_action_common+0xa8/0x254
tasklet_action+0x2c/0x38
__do_softirq+0xdc/0x384

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 net/mac80211/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d8460a14b6bd..c003d9826c9b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -664,7 +664,8 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 		}
 
 		if (unlikely(tx->key && tx->key->flags & KEY_FLAG_TAINTED &&
-			     !ieee80211_is_deauth(hdr->frame_control)))
+			     !ieee80211_is_deauth(hdr->frame_control)) &&
+			     tx->skb->protocol != tx->sdata->control_port_protocol)
 			return TX_DROP;
 
 		if (!skip_hw && tx->key &&

base-commit: b21fe5be53eb873c02e7479372726c8aeed171e3
-- 
2.40.1

