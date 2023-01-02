Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB65D65B3E5
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 16:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjABPMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 10:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjABPMI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 10:12:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF25C05
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 07:12:07 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302EhYwx026366;
        Mon, 2 Jan 2023 15:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XMWJbyxnDWH9dthU9G1eyMhcSQ+ZhjqQx7iO1JyKUug=;
 b=HsPsBYxkOScLCJW+YSzkoHjASHmFd+MWEpGE6kJ7auUByxqLTJLj6fBJ7ZKJDxmNSaws
 ngYUXEiGg1mOgAyK9bXoo7SVIKcYw0IQuMLwLsiSLpRw0ALIu11XZ2M8qe1JAAO8+dBz
 Eq25ZZ5hb+yOUsrGEzZ2lOdQaaejSGeZ/6dOmvsprNYHuZP7ZQbdpHsDdAgI2Vj68oa2
 bMRXwaan5DH6RkI5ETWv2V9HoG2NdTQ5AgNxgCpAK1E6sdmtqaydhx6wrO62EEu4L+7x
 vDPJftn/jxrhB0aL+XMp8jupfja0A3GIg5EgenzpizELL0qTzwNFSmVJcu0eoV8z5+zJ ng== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mtd61b5hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 15:11:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 302FBpUp017726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Jan 2023 15:11:52 GMT
Received: from [10.216.48.166] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 2 Jan 2023
 07:11:50 -0800
Message-ID: <bf54c4b8-68f8-4ffe-f38d-0019044434d5@quicinc.com>
Date:   Mon, 2 Jan 2023 20:41:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ath11k: debugfs: fix to work with multiple PCI devices
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20221220121231.20120-1-kvalo@kernel.org>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20221220121231.20120-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4ucmo8rD4K1CQDMg5__30aWw2T16eZno
X-Proofpoint-ORIG-GUID: 4ucmo8rD4K1CQDMg5__30aWw2T16eZno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_09,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020137
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 12/20/2022 5:42 PM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> ath11k fails to load if there are multiple ath11k PCI devices with same name:
> 
>   ath11k_pci 0000:01:00.0: Hardware name qcn9074 hw1.0
>   debugfs: Directory 'ath11k' with parent '/' already present!
>   ath11k_pci 0000:01:00.0: failed to create ath11k debugfs
>   ath11k_pci 0000:01:00.0: failed to create soc core: -17
>   ath11k_pci 0000:01:00.0: failed to init core: -17
>   ath11k_pci: probe of 0000:01:00.0 failed with error -17
> 
> Fix this by creating a directory for each ath11k device using schema
> <bus>-<devname>, for example "pci-0000:06:00.0". This directory created under
> the top-level ath11k directory, for example /sys/kernel/debug/ath11k.
> 
> The reference to the toplevel ath11k directory is not stored anymore within ath11k, instead
> it's retrieved using debugfs_lookup(). If the directory does not exist it will
> be created. After the last directory from the ath11k directory is removed, for
> example when doing rmmod ath11k, the empty ath11k directory is left in place,
> it's a minor cosmetic issue anyway.
> 
> Here's an example hierarchy with one WCN6855:
> 
> ath11k
> `-- pci-0000:06:00.0
>      |-- mac0
>      |   |-- dfs_block_radar_events
>      |   |-- dfs_simulate_radar
>      |   |-- ext_rx_stats
>      |   |-- ext_tx_stats
>      |   |-- fw_dbglog_config
>      |   |-- fw_stats
>      |   |   |-- beacon_stats
>      |   |   |-- pdev_stats
>      |   |   `-- vdev_stats
>      |   |-- htt_stats
>      |   |-- htt_stats_reset
>      |   |-- htt_stats_type
>      |   `-- pktlog_filter
>      |-- simulate_fw_crash
>      `-- soc_dp_stats
> 
> I didn't have a test setup where I could connect multiple ath11k devices to the
> same the host, so I have only tested this with one device.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/core.h    |  1 -
>   drivers/net/wireless/ath/ath11k/debugfs.c | 48 +++++++++++++++++++----
>   2 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index a8acb8b7b8d5..beb552108ac3 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -921,7 +921,6 @@ struct ath11k_base {
>   	enum ath11k_dfs_region dfs_region;
>   #ifdef CONFIG_ATH11K_DEBUGFS
>   	struct dentry *debugfs_soc;
> -	struct dentry *debugfs_ath11k;
>   #endif
>   	struct ath11k_soc_dp_stats soc_stats;
>   
> diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
> index ccdf3d5ba1ab..5bb6fd17fdf6 100644
> --- a/drivers/net/wireless/ath/ath11k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath11k/debugfs.c
> @@ -976,10 +976,6 @@ int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
>   	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
>   		return 0;
>   
> -	ab->debugfs_soc = debugfs_create_dir(ab->hw_params.name, ab->debugfs_ath11k);
> -	if (IS_ERR(ab->debugfs_soc))
> -		return PTR_ERR(ab->debugfs_soc);
> -
>   	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
>   			    &fops_simulate_fw_crash);
>   
> @@ -1001,15 +997,51 @@ void ath11k_debugfs_pdev_destroy(struct ath11k_base *ab)
>   
>   int ath11k_debugfs_soc_create(struct ath11k_base *ab)
>   {
> -	ab->debugfs_ath11k = debugfs_create_dir("ath11k", NULL);
> +	struct dentry *root;
> +	bool dput_needed;
> +	char name[64];
> +	int ret;
> +
> +	root = debugfs_lookup("ath11k", NULL);
> +	if (!root) {
> +		root = debugfs_create_dir("ath11k", NULL);
> +		if (IS_ERR_OR_NULL(root))
> +			return PTR_ERR(root);
> +
> +		dput_needed = false;
> +	} else {
> +		/* a dentry from lookup() needs dput() after we don't use it */
> +		dput_needed = true;
> +	}
> +
> +	scnprintf(name, sizeof(name), "%s-%s", ath11k_bus_str(ab->hif.bus),
> +		  dev_name(ab->dev));
> +
> +	ab->debugfs_soc = debugfs_create_dir(name, root);
> +	if (IS_ERR_OR_NULL(ab->debugfs_soc)) {
> +		ret = PTR_ERR(ab->debugfs_soc);
> +		goto out;
> +	}
> +
> +	ret = 0;
>   
> -	return PTR_ERR_OR_ZERO(ab->debugfs_ath11k);
> +out:
> +	if (dput_needed)
> +		dput(root);
> +
> +	return ret;
>   }
>   
>   void ath11k_debugfs_soc_destroy(struct ath11k_base *ab)
>   {
> -	debugfs_remove_recursive(ab->debugfs_ath11k);
> -	ab->debugfs_ath11k = NULL;
> +	debugfs_remove_recursive(ab->debugfs_soc);
> +	ab->debugfs_soc = NULL;
> +
> +	/* We are not removing ath11k directory on purpose, even if it
> +	 * would be empty. This simplifies the directory handling and it's
> +	 * a minor cosmetic issue to leave an empty ath11k directory to
> +	 * debugfs.
> +	 */
>   }
>   EXPORT_SYMBOL(ath11k_debugfs_soc_destroy);
>   
> 
> base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025

looks good to me

Vasanth
