Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36D41A0E86
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2020 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgDGNle (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Apr 2020 09:41:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48910 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgDGNle (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Apr 2020 09:41:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037Dd8FT116530;
        Tue, 7 Apr 2020 13:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2q8+oX7t5GJmfishCStEknlxBHQXmJtbJDBfRwG5N2A=;
 b=nB2/IvZK3I5sP01crIKIWrxjp3A5U6FGHdJ8SEdfFM0O1KriUo1V7/esDETP5oEpyxBM
 6yqABobznPCdw9inxH0HWdG6z+WXtgdENbktHbLaRLkkZ0y0HTI0gEiSx2Z3Pu4Y6P+3
 JjUB2ltTZkzLtqGrmq4kbGdNRx34BnJWDAGE6zG9AC0H+bvqFpHjW4ISWg2qLWLoWiR7
 SJ/q5PDe45O/2p6ndJvCcJ0bCSGaDtEjp2AWC6MCwe38emZ1SNiqISqSWchIJMlgmrCk
 rJOhJ5Oo+dH5mqnH8/qErqnnmEYBffsoUs5VksrsV02+UqdOTn52G2UxKrvv3uzYhc0Y MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 306jvn4yrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 13:41:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037DccVt093623;
        Tue, 7 Apr 2020 13:41:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30839tcy2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 13:41:22 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 037DfLKr020363;
        Tue, 7 Apr 2020 13:41:22 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 06:41:21 -0700
Date:   Tue, 7 Apr 2020 16:41:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mpubbise@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [bug report] ath11k: handle RX fragments
Message-ID: <20200407134115.GA108129@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=437 bulkscore=0 suspectscore=3 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=3
 mlxlogscore=484 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070118
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Manikanta Pubbisetty,

The patch 243874c64c81: "ath11k: handle RX fragments" from Mar 16,
2020, leads to the following static checker warning:

	drivers/net/wireless/ath/ath11k/dp_rx.c:3365 ath11k_dp_rx_frag_h_mpdu()
	warn: missing error code here? 'ath11k_dp_rx_h_defrag()' failed. 'ret' = '0'

drivers/net/wireless/ath/ath11k/dp_rx.c
  3343                                                HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
  3344          }
  3345  
  3346          if (!rx_tid->last_frag_no ||
  3347              rx_tid->rx_frag_bitmap != GENMASK(rx_tid->last_frag_no, 0)) {
  3348                  mod_timer(&rx_tid->frag_timer, jiffies +
  3349                                                 ATH11K_DP_RX_FRAGMENT_TIMEOUT_MS);
  3350                  goto out_unlock;
                        ^^^^^^^^^^^^^^^

All these gotos should probably set error codes instead of returning
success.

  3351          }
  3352  
  3353          spin_unlock_bh(&ab->base_lock);
  3354          del_timer_sync(&rx_tid->frag_timer);
  3355          spin_lock_bh(&ab->base_lock);
  3356  
  3357          peer = ath11k_peer_find_by_id(ab, peer_id);
  3358          if (!peer)
  3359                  goto err_frags_cleanup;
                        ^^^^^^^^^^^^^^^^^^^^^^
Etc.

  3360  
  3361          if (!ath11k_dp_rx_h_defrag_validate_incr_pn(ar, rx_tid))
  3362                  goto err_frags_cleanup;
  3363  
  3364          if (ath11k_dp_rx_h_defrag(ar, peer, rx_tid, &defrag_skb))
  3365                  goto err_frags_cleanup;
  3366  
  3367          if (!defrag_skb)
  3368                  goto err_frags_cleanup;
  3369  
  3370          if (ath11k_dp_rx_h_defrag_reo_reinject(ar, rx_tid, defrag_skb))
  3371                  goto err_frags_cleanup;
  3372  
  3373          ath11k_dp_rx_frags_cleanup(rx_tid, false);
  3374          goto out_unlock;
  3375  
  3376  err_frags_cleanup:
  3377          dev_kfree_skb_any(defrag_skb);
  3378          ath11k_dp_rx_frags_cleanup(rx_tid, true);
  3379  out_unlock:
  3380          spin_unlock_bh(&ab->base_lock);
  3381          return ret;
  3382  }

regards,
dan carpenter
