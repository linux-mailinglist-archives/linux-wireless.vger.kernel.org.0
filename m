Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF44642605
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 10:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiLEJqd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 04:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiLEJqb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 04:46:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC66319039
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 01:46:29 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B59NGg0014201;
        Mon, 5 Dec 2022 09:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OhTp2WvMu2UaAzetr2/JMUgEf9/T4n4ZdOdow+OJoj0=;
 b=dj/fb7GfyLD+j9QvZb2g+a1Tr8Fr5nnVymu6d44fvo6nQCw5auTs0m5OqEMS0t9hqtGK
 VlTJX8DKqMDEhl3RHCJgQ6XUElUHIir6Jdb5gqb2CumVxC1gJoQBhCHGkY7CMEzDAOYe
 d7e/Ry0kSfZG0g3GCA3/TojuEDep6x6lvU7NiyZFaXNhnQYpPsunf5tChW2XX8HqkU7o
 e0LPxBIspOt7Rh/hN92aW0zRat6I6pUt1wZK/nLuubsetVtfICGlUxc3EgcP7NHXhhsV
 rxvmhu60xaXrSMNB/ZOb3f1ROp7jv9kPfs7q2OG+vQ2KDO1hb7TAKxDw6VezZApBLNmF Ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7v5mbx9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 09:46:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B59kJIT012357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 09:46:19 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 5 Dec 2022
 01:46:17 -0800
Message-ID: <9bce39db-1de4-f129-8d2f-77f51a64a5db@quicinc.com>
Date:   Mon, 5 Dec 2022 17:46:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 4/5] mac80211: run late dequeue late tx handlers without
 holding fq->lock
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
References: <20190316170634.13125-1-nbd@nbd.name>
 <20190316170634.13125-4-nbd@nbd.name>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20190316170634.13125-4-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jjPRV8iF-eYLevvM9EY2lvCUG3tCEeKb
X-Proofpoint-GUID: jjPRV8iF-eYLevvM9EY2lvCUG3tCEeKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050078
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/17/2019 1:06 AM, Felix Fietkau wrote:
> Reduces lock contention on enqueue/dequeue of iTXQ packets
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/mac80211/tx.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 8127e43e12b1..f85344c9af62 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3544,6 +3544,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>   	ieee80211_tx_result r;
>   	struct ieee80211_vif *vif = txq->vif;
>   
> +begin:
>   	spin_lock_bh(&fq->lock);
Maybe use-after-free will happened?

You can see ieee80211_tx_dequeue() in tx.c as below, after 
ieee80211_free_txskb(), it will goto begin,
If goto out happened in below check, then the skb which is freed will be 
returned, and use-after-free will happen.

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/tree/net/mac80211/tx.c?id=ded4698b58cb23c22b0dcbd829ced19ce4e6ce02#n3538
begin:
     spin_lock_bh(&fq->lock);

     if (test_bit(IEEE80211_TXQ_STOP, &txqi->flags) ||
         test_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txqi->flags))
         goto out;

     if (vif->txqs_stopped[ieee80211_ac_from_tid(txq->tid)]) {
         set_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txqi->flags);
         goto out;
     }

     /* Make sure fragments stay together. */
     skb = __skb_dequeue(&txqi->frags);
     if (skb)
         goto out;

     skb = fq_tin_dequeue(fq, tin, fq_tin_dequeue_func);
     if (!skb)
         goto out;

     spin_unlock_bh(&fq->lock);

Maybe "skb = NULL;" should be added after "begin:".

...

