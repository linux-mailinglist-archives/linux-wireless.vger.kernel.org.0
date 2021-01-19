Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1F2FB4CF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 10:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbhASJGR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 04:06:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57924 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbhASJFo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 04:05:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10J94Bad003756;
        Tue, 19 Jan 2021 09:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=vVdPUD8wm0Fsp9pzp+T37MULTfPYFnKJxOUt/d72fOo=;
 b=Dv0+jFuGcLCVf2Prw8/tWsrXPuc8WQLMRZ59DAo5C+D2tzxl3aI8+UWetmJxE0FA+Vdl
 LKOhNdn8d1ngul+SwtqxGRHz4Mos/olIcdtM3MHbHyYXuo0RJdc+Tw6yfUrUX22BUhOp
 kwCPaIHHKE2gpo+QE3TcHDoi6l3Ev2qrb9q4vjHwS5QUHK+VJvuuCNX8/YWgBGmfsy5r
 Q9widLgFh4G2B2RLBk39ix4d0F2+1g6GTC/Bodmtv2EVa1OMGZTVlU6NOY9Y+GmuKf5G
 oWwFkSZ2IbucAbxDADWo8nIxnP2tO3ZRIrxCIN98rTkk0ANxh0wW6FeeDUyXjvHLtTUJ Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 363r3kr16k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 09:04:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10J902P1134837;
        Tue, 19 Jan 2021 09:04:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 364a1xdf23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 09:04:29 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10J94QZ3021732;
        Tue, 19 Jan 2021 09:04:26 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 01:04:24 -0800
Date:   Tue, 19 Jan 2021 12:04:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kees Cook <keescook@chromium.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>,
        linux-wireless@vger.kernel.org
Subject: drivers/net/wireless/intel/iwlegacy/4965-mac.c:2822 il4965_hdl_tx()
 error: uninitialized symbol 'tid'.
Message-ID: <20210119090416.GJ2696@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Iys0Un1O+0sigPHU"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190056
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Iys0Un1O+0sigPHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0da0a8a0a0e1845f495431c3d8d733d2bbf9e9e5
commit: 3f649ab728cda8038259d8f14492fe400fbab911 treewide: Remove uninitialized_var() usage
config: x86_64-randconfig-m001-20210117 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/wireless/intel/iwlegacy/4965-mac.c:2822 il4965_hdl_tx() error: uninitialized symbol 'tid'.

vim +/tid +2822 drivers/net/wireless/intel/iwlegacy/4965-mac.c

3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2759  static void
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2760  il4965_hdl_tx(struct il_priv *il, struct il_rx_buf *rxb)
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2761  {
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2762  	struct il_rx_pkt *pkt = rxb_addr(rxb);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2763  	u16 sequence = le16_to_cpu(pkt->hdr.sequence);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2764  	int txq_id = SEQ_TO_QUEUE(sequence);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2765  	int idx = SEQ_TO_IDX(sequence);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2766  	struct il_tx_queue *txq = &il->txq[txq_id];
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2767  	struct sk_buff *skb;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2768  	struct ieee80211_hdr *hdr;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2769  	struct ieee80211_tx_info *info;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2770  	struct il4965_tx_resp *tx_resp = (void *)&pkt->u.raw[0];
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2771  	u32 status = le32_to_cpu(tx_resp->u.status);
3f649ab728cda803 drivers/net/wireless/intel/iwlegacy/4965-mac.c Kees Cook         2020-06-03  2772  	int tid;
                                                                                                        ^^^^^^^

3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2773  	int sta_id;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2774  	int freed;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2775  	u8 *qc = NULL;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2776  	unsigned long flags;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2777  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2778  	if (idx >= txq->q.n_bd || il_queue_used(&txq->q, idx) == 0) {
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2779  		IL_ERR("Read idx for DMA queue txq_id (%d) idx %d "
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2780  		       "is out of range [0-%d] %d %d\n", txq_id, idx,
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2781  		       txq->q.n_bd, txq->q.write_ptr, txq->q.read_ptr);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2782  		return;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2783  	}
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2784  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2785  	txq->time_stamp = jiffies;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2786  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2787  	skb = txq->skbs[txq->q.read_ptr];
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2788  	info = IEEE80211_SKB_CB(skb);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2789  	memset(&info->status, 0, sizeof(info->status));
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2790  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2791  	hdr = (struct ieee80211_hdr *) skb->data;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2792  	if (ieee80211_is_data_qos(hdr->frame_control)) {
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2793  		qc = ieee80211_get_qos_ctl(hdr);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2794  		tid = qc[0] & 0xf;

"tid" is not initialized on the else path.  Is "txq->sched_retry"
definitely set on this path?

3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2795  	}
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2796  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2797  	sta_id = il4965_get_ra_sta_id(il, hdr);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2798  	if (txq->sched_retry && unlikely(sta_id == IL_INVALID_STATION)) {
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2799  		IL_ERR("Station not known\n");
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2800  		return;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2801  	}
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2802  
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2803  	/*
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2804  	 * Firmware will not transmit frame on passive channel, if it not yet
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2805  	 * received some valid frame on that channel. When this error happen
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2806  	 * we have to wait until firmware will unblock itself i.e. when we
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2807  	 * note received beacon or other frame. We unblock queues in
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2808  	 * il4965_pass_packet_to_mac80211 or in il_mac_bss_info_changed.
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2809  	 */
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2810  	if (unlikely((status & TX_STATUS_MSK) == TX_STATUS_FAIL_PASSIVE_NO_RX) &&
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2811  	    il->iw_mode == NL80211_IFTYPE_STATION) {
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2812  		il_stop_queues_by_reason(il, IL_STOP_REASON_PASSIVE);
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2813  		D_INFO("Stopped queues - RX waiting on passive channel\n");
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2814  	}
8cdbab7f07e82f26 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2815  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2816  	spin_lock_irqsave(&il->sta_lock, flags);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2817  	if (txq->sched_retry) {
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2818  		const u32 scd_ssn = il4965_get_scd_ssn(tx_resp);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2819  		struct il_ht_agg *agg = NULL;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2820  		WARN_ON(!qc);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2821  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13 @2822  		agg = &il->stations[sta_id].tid[tid].agg;
                                                                                                                                                ^^^

3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2823  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2824  		il4965_tx_status_reply_tx(il, agg, tx_resp, txq_id, idx);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2825  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2826  		/* check if BAR is needed */
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2827  		if (tx_resp->frame_count == 1 &&
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2828  		    !il4965_is_tx_success(status))
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2829  			info->flags |= IEEE80211_TX_STAT_AMPDU_NO_BACK;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2830  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2831  		if (txq->q.read_ptr != (scd_ssn & 0xff)) {
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2832  			idx = il_queue_dec_wrap(scd_ssn & 0xff, txq->q.n_bd);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2833  			D_TX_REPLY("Retry scheduler reclaim scd_ssn "
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2834  				   "%d idx %d\n", scd_ssn, idx);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2835  			freed = il4965_tx_queue_reclaim(il, txq_id, idx);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2836  			if (qc)
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2837  				il4965_free_tfds_in_queue(il, sta_id, tid,
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2838  							  freed);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2839  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2840  			if (il->mac80211_registered &&
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2841  			    il_queue_space(&txq->q) > txq->q.low_mark &&
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2842  			    agg->state != IL_EMPTYING_HW_QUEUE_DELBA)
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2843  				il_wake_queue(il, txq);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2844  		}
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2845  	} else {
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2846  		info->status.rates[0].count = tx_resp->failure_frame + 1;
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2847  		info->flags |= il4965_tx_status_to_mac80211(status);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2848  		il4965_hwrate_to_tx_control(il,
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2849  					    le32_to_cpu(tx_resp->rate_n_flags),
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2850  					    info);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2851  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2852  		D_TX_REPLY("TXQ %d status %s (0x%08x) "
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2853  			   "rate_n_flags 0x%x retries %d\n", txq_id,
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2854  			   il4965_get_tx_fail_reason(status), status,
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2855  			   le32_to_cpu(tx_resp->rate_n_flags),
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2856  			   tx_resp->failure_frame);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2857  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2858  		freed = il4965_tx_queue_reclaim(il, txq_id, idx);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2859  		if (qc && likely(sta_id != IL_INVALID_STATION))
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2860  			il4965_free_tfds_in_queue(il, sta_id, tid, freed);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2861  		else if (sta_id == IL_INVALID_STATION)
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2862  			D_TX_REPLY("Station not known\n");
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2863  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2864  		if (il->mac80211_registered &&
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2865  		    il_queue_space(&txq->q) > txq->q.low_mark)
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2866  			il_wake_queue(il, txq);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2867  	}
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2868  	if (qc && likely(sta_id != IL_INVALID_STATION))
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2869  		il4965_txq_check_empty(il, sta_id, tid, txq_id);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2870  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2871  	il4965_check_abort_status(il, tx_resp->frame_count, status);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2872  
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2873  	spin_unlock_irqrestore(&il->sta_lock, flags);
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2874  }
3dfea27d103e9913 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2875  

:::::: The code at line 2822 was first introduced by commit
:::::: 3dfea27d103e9913698cf1a2c86745a74c7c556b iwlegacy: gather all 4965 handlers in one place

:::::: TO: Stanislaw Gruszka <sgruszka@redhat.com>
:::::: CC: John W. Linville <linville@tuxdriver.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Iys0Un1O+0sigPHU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Gt8CAgA=

--Iys0Un1O+0sigPHU--
