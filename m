Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5C45F7F76
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Oct 2022 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJGVIZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 17:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJGVIX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 17:08:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB8BA3F64
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 14:08:22 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297Kvjvk006026;
        Fri, 7 Oct 2022 21:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4p/gaPtGsYH3NLD8JwukVZtGRuOHlfHscZN3IUwOCDo=;
 b=ZrX8PB0tr/6HzgSJBtHqwNkj4gUIDqu5b+KShonyAkT5ZgmuEfzHWwHc5wc6zBRB+M5M
 5WmCy/n7y/Bfif2Q4+oMX+3d3no/ltPAHAiadNa9do6kGZirsB/OdJzzoOEh1VCoRhqt
 MB/Xx0gqYCaVhBxy4Z1OAZe82ihWKMity5Ss69XfEcwc056OtFytXzSRLiRiseNiPOQJ
 ZBp3ir2JXhrgEht6Q9FeqnrZdX7B9i3tJCad0COV/Yg/dCjqdysYNbNafnRoV3rWt7nY
 xzPqQZdqcaV30xcnPKiyN8JXHH5ULQqCFCGGrouzYZx8/4E9fCDo+F3XlLMIRUohNeJF hg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k2a7qt3tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 21:08:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 297L881k004198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Oct 2022 21:08:08 GMT
Received: from [10.110.6.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 7 Oct 2022
 14:08:08 -0700
Message-ID: <0e47a991-e4d3-95f5-2d92-6286262a59b7@quicinc.com>
Date:   Fri, 7 Oct 2022 14:08:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] wifi: ath11k: avoid deadlock during regulatory update in
 ath11k_regd_update()
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20221006151747.13757-1-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20221006151747.13757-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZCSXaSLM2ur9gVx3uAcDWIVv94VgeOve
X-Proofpoint-ORIG-GUID: ZCSXaSLM2ur9gVx3uAcDWIVv94VgeOve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210070125
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/6/2022 8:17 AM, Kalle Valo wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Running this test in a loop it is easy to reproduce an rtnl deadlock:
> 
> iw reg set FI
> ifconfig wlan0 down
> 
> What happens is that thread A (workqueue) tries to update the regulatory:
> 
>      try to acquire the rtnl_lock of ar->regd_update_work
> 
>      rtnl_lock+0x17/0x20
>      ath11k_regd_update+0x15a/0x260 [ath11k]
>      ath11k_regd_update_work+0x15/0x20 [ath11k]
>      process_one_work+0x228/0x670
>      worker_thread+0x4d/0x440
>      kthread+0x16d/0x1b0
>      ret_from_fork+0x22/0x30
> 
> And thread B (ifconfig) tries to stop the interface:
> 
>      try to cancel_work_sync(&ar->regd_update_work) in ath11k_mac_op_stop().
>      ifconfig  3109 [003]  2414.232506: probe:
> 
>      ath11k_mac_op_stop: (ffffffffc14187a0)
>      drv_stop+0x30 ([mac80211])
>      ieee80211_do_stop+0x5d2 ([mac80211])
>      ieee80211_stop+0x3e ([mac80211])
>      __dev_close_many+0x9e ([kernel.kallsyms])
>      __dev_change_flags+0xbe ([kernel.kallsyms])
>      dev_change_flags+0x23 ([kernel.kallsyms])
>      devinet_ioctl+0x5e3 ([kernel.kallsyms])
>      inet_ioctl+0x197 ([kernel.kallsyms])
>      sock_do_ioctl+0x4d ([kernel.kallsyms])
>      sock_ioctl+0x264 ([kernel.kallsyms])
>      __x64_sys_ioctl+0x92 ([kernel.kallsyms])
>      do_syscall_64+0x3a ([kernel.kallsyms])
>      entry_SYSCALL_64_after_hwframe+0x63 ([kernel.kallsyms])
>      __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.23.so)
> 
> The sequence of deadlock is:
> 
> 1. Thread B calls rtnl_lock().
> 
> 2. Thread A starts to run and calls rtnl_lock() from within
>     ath11k_regd_update_work(), then enters wait state because the lock is owned by
>     thread B.
> 
> 3. Thread B continues to run and tries to call
>     cancel_work_sync(&ar->regd_update_work), but thread A is in
>     ath11k_regd_update_work() waiting for rtnl_lock(). So cancel_work_sync()
>     forever waits for ath11k_regd_update_work() to finish and we have a deadlock.
> 
> Fix this by switching from using regulatory_set_wiphy_regd_sync() to
> regulatory_set_wiphy_regd(). Now cfg80211 will schedule another workqueue which
> handles the locking on it's own. So the ath11k workqueue can simply exit without
> taking any locks, avoiding the deadlock.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> [kvalo: improve commit log]
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

