Return-Path: <linux-wireless+bounces-22178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED21AA0170
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF7D480E68
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C621EEE0;
	Tue, 29 Apr 2025 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N+CT+Tnz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD901922F4
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 04:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745901695; cv=none; b=Ox1CWrVPU2b64N/pfZaZjqfNS8bwCw0QXgtOBdhr57xaJWOV91i6oLR9yC9UC0p0fFIe2C7zD4Wp44dbzt35VuINdSwQndqVCBFCD30UHbByIAqqVNrwW95hP1JbrZJX6vx+np15j1KdPnMp9ud+CkvGSW/6Yr7hSdvUXOcQmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745901695; c=relaxed/simple;
	bh=YGRXeq11qjaIGaYkwRxQiQ+7QUhs0kKx9KLPmm9Wnic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ECEi5KP/86iRHo6OOrZ+6PfllAi4JVXy8sFpGritCJwePT3UhcHgqSqmIn+CN6UAFLBkJsoIQj5JYPqHX7dJo0KEvxiBe4294OHr37Bj0uHRU4sFOhhuT79eYAetQNy6XwgO6vOQlnF9FLRfr9mpW++efmTANe/Lcg/B5xmH6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N+CT+Tnz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNqO9h015584;
	Tue, 29 Apr 2025 04:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Clhtlzk52W4Ho/45gmL/HcHJmfy5Q6V0S6OQ+yvPLRY=; b=N+CT+Tnz58GIHPGu
	qktqq8I6KjIU1d3mdNnSOEW+xqD1mkZNZ3L7swBIVGJScrmkpWUZr+CPKoieDYni
	R6rS5t2PVPKE75tnPpiXNq3oAqF2Oq9UzdqrQtzP1/XgmxW5LJJoPKb+3Mhr1Myo
	cMgTRlGGZBL325Zwo7Nw8E7h8Cgw5w1hPLjrbiZS+j+TA7esBljiGs8jaJwMeBzd
	DuHTADt7Qufpplt5WmwzoStdlQ7kkAMjJj+8P/uAb9JrRt+xOInQXsq6zRBxgfLC
	EFQWVML7HW/Wf329S0jlTbgld61HJs8SKl2Xtj1UPHgkf5uALGk0wAYV6RCJ0mZP
	ZZv3vQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qjwu7ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:41:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53T4fT6o012483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:41:29 GMT
Received: from [10.216.24.29] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 21:41:27 -0700
Message-ID: <da668e68-b5dd-4380-ab99-c16427faf507@quicinc.com>
Date: Tue, 29 Apr 2025 10:11:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 3/3] wifi: ath12k: print device dp stats in
 debugfs
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vinith Kumar R
	<quic_vinithku@quicinc.com>
References: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250425012802.698914-4-nithyanantham.paramasivam@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250425012802.698914-4-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uy66qH3UX1DE1zXXyyj-Pki9O9H3R3iM
X-Proofpoint-GUID: uy66qH3UX1DE1zXXyyj-Pki9O9H3R3iM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzMyBTYWx0ZWRfXwkk+ITr53yVR W9NLGwKF8CB8x+S/MNBoyiK8MPh6yBrozZDAH41GoCoSdrZ8hcJdj2X1P3VRT/kUtE7NKeqQ8NI ONvJeBCAv0dQKndfEaFUoLCS0OBCpVZayEmf6+kXE2iW0zdeoaU87wcFU1SdxxNPUQOBoECn8j3
 6LUB/3AF44kKzzjqosDNCRk8YXNIul9xq9UhItMh820kBvteljpDFulJS54iKsp/NorMRbOVlsv /dpnFKj87bY9z/mTzODF/EXEOK78WMa16fy28HGrhcUV4/Nml8/srZAhx3JPIg3grE8WvDz+a1w hz08g2l1iY+ezXxJ1vohXK9+M9ID1zMREgC9mOUcPdh9kxoHdI6DwQInRAqGZg+xkfR7iQyFfdq
 xhdgdxIQ/eral5H0VD5mx1Zi0tKDC6c/prpTnNnvJ+dNMTVJ92NxrfyuuONOmQtny2gaQcw1
X-Authority-Analysis: v=2.4 cv=c/urQQ9l c=1 sm=1 tr=0 ts=6810587a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=1TW_jAoz3lgWVXBuO_cA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290033

On 4/25/2025 6:58 AM, Nithyanantham Paramasivam wrote:
> From: Vinith Kumar R <quic_vinithku@quicinc.com>
> 
> Print the data path related device specific stats in debugfs.
> These device_dp_stats are exposed in the ath12k debugfs directory.
> 
> Output of device_dp_stats:
> root@CDCWLEX0799743-LIN:/home/qctest#
> cat /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/device_dp_stats
> DEVICE RX STATS:
> 
> err ring pkts: 0
> Invalid RBM: 0
> 
> RXDMA errors:
> Overflow: 0
> MPDU len: 0
> FCS: 0
> Decrypt: 0
> TKIP MIC: 0
> Unencrypt: 0
> MSDU len: 0
> MSDU limit: 0
> WiFi parse: 0
> AMSDU parse: 0
> SA timeout: 0
> DA timeout: 0
> Flow timeout: 0
> Flush req: 0
> AMSDU frag: 0
> Multicast echo: 0
> AMSDU mismatch: 0
> Unauth WDS: 0
> AMSDU or WDS: 0
> 
> REO errors:
> Desc addr zero: 0
> Desc inval: 0
> AMPDU in non BA: 0
> Non BA dup: 0
> BA dup: 0
> Frame 2k jump: 0
> BAR 2k jump: 0
> Frame OOR: 155
> BAR OOR: 0
> No BA session: 0
> Frame SN equal SSN: 0
> PN check fail: 0
> 2k err: 0
> PN err: 0
> Desc blocked: 0
> 
> HAL REO errors:
> ring0: 0
> ring1: 0
> ring2: 0
> ring3: 0
> ring4: 0
> ring5: 0
> ring6: 0
> ring7: 0
> 
> DEVICE TX STATS:
> 
> TCL Ring Full Failures:
> ring0: 0
> ring1: 0
> ring2: 0
> ring3: 0
> 
> Misc Transmit Failures: 0
> 
> tx_wbm_rel_source: 0:986 1:0 2:0 3:57 4:0
> 
> tqm_rel_reason: 0:1043 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0 12:0 13:0 14:0
> 
> fw_tx_status: 0:57 1:0 2:0 3:0 4:0 5:0 6:0
> 
> tx_enqueued: 0:329 1:145 2:464 3:105
> 
> tx_completed: 0:329 1:145 2:464 3:105
> 
> radio0 tx_pending: 0
> 
> REO Rx Received:
> Ring1:  0:201   1:0     2:0
> Ring2:  0:0     1:0     2:0
> Ring3:  0:6152  1:0     2:0
> Ring4:  0:9     1:0     2:0
> Ring5:  0:0     1:0     2:0
> Ring6:  0:0     1:0     2:0
> Ring7:  0:0     1:0     2:0
> Ring8:  0:0     1:0     2:0
> 
> Rx WBM REL SRC Errors:
> TQM:    0:0     1:0     2:0
> Rxdma:  0:0     1:0     2:0
> Reo:    0:155   1:0     2:0
> FW:     0:0     1:0     2:0
> SW:     0:0     1:0     2:0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c    |   2 +
>  drivers/net/wireless/ath/ath12k/debugfs.c | 199 +++++++++++++++++++++-
>  2 files changed, 195 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 2cfeb853289d..5203d94c8b10 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -789,6 +789,8 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
>  		goto err_qmi_deinit;
>  	}
>  
> +	ath12k_debugfs_pdev_create(ab);
> +
>  	return 0;
>  
>  err_qmi_deinit:
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
> index 1f0983c33885..dd624d73b8b2 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
> @@ -103,12 +103,6 @@ static const struct file_operations fops_simulate_fw_crash = {
>  	.llseek = default_llseek,
>  };
>  
> -void ath12k_debugfs_pdev_create(struct ath12k_base *ab)
> -{
> -	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
> -			    &fops_simulate_fw_crash);
> -}
> -
>  static ssize_t ath12k_write_tpc_stats_type(struct file *file,
>  					   const char __user *user_buf,
>  					   size_t count, loff_t *ppos)
> @@ -1027,6 +1021,199 @@ void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
>  			    &ath12k_fops_link_stats);
>  }
>  
> +static ssize_t ath12k_debugfs_dump_device_dp_stats(struct file *file,
> +						   char __user *user_buf,
> +						   size_t count, loff_t *ppos)
> +{
> +	struct ath12k_base *ab = file->private_data;
> +	struct ath12k_device_dp_stats *device_stats = &ab->device_stats;
> +	int len = 0, i, j, ret;
> +	struct ath12k *ar;
> +	const int size = 4096;
> +	static const char *rxdma_err[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX] = {
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_OVERFLOW_ERR] = "Overflow",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_MPDU_LEN_ERR] = "MPDU len",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_FCS_ERR] = "FCS",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR] = "Decrypt",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR] = "TKIP MIC",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_UNECRYPTED_ERR] = "Unencrypt",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_MSDU_LEN_ERR] = "MSDU len",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_MSDU_LIMIT_ERR] = "MSDU limit",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_WIFI_PARSE_ERR] = "WiFi parse",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_PARSE_ERR] = "AMSDU parse",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_SA_TIMEOUT_ERR] = "SA timeout",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_DA_TIMEOUT_ERR] = "DA timeout",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_FLOW_TIMEOUT_ERR] = "Flow timeout",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_FLUSH_REQUEST_ERR] = "Flush req",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_FRAG_ERR] = "AMSDU frag",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_MULTICAST_ECHO_ERR] = "Multicast echo",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_MISMATCH_ERR] = "AMSDU mismatch",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_UNAUTH_WDS_ERR] = "Unauth WDS",
> +		[HAL_REO_ENTR_RING_RXDMA_ECODE_GRPCAST_AMSDU_WDS_ERR] = "AMSDU or WDS"};
> +
> +	static const char *reo_err[HAL_REO_DEST_RING_ERROR_CODE_MAX] = {
> +		[HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO] = "Desc addr zero",
> +		[HAL_REO_DEST_RING_ERROR_CODE_DESC_INVALID] = "Desc inval",
> +		[HAL_REO_DEST_RING_ERROR_CODE_AMPDU_IN_NON_BA] =  "AMPDU in non BA",
> +		[HAL_REO_DEST_RING_ERROR_CODE_NON_BA_DUPLICATE] = "Non BA dup",
> +		[HAL_REO_DEST_RING_ERROR_CODE_BA_DUPLICATE] = "BA dup",
> +		[HAL_REO_DEST_RING_ERROR_CODE_FRAME_2K_JUMP] = "Frame 2k jump",
> +		[HAL_REO_DEST_RING_ERROR_CODE_BAR_2K_JUMP] = "BAR 2k jump",
> +		[HAL_REO_DEST_RING_ERROR_CODE_FRAME_OOR] = "Frame OOR",
> +		[HAL_REO_DEST_RING_ERROR_CODE_BAR_OOR] = "BAR OOR",
> +		[HAL_REO_DEST_RING_ERROR_CODE_NO_BA_SESSION] = "No BA session",
> +		[HAL_REO_DEST_RING_ERROR_CODE_FRAME_SN_EQUALS_SSN] = "Frame SN equal SSN",
> +		[HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED] = "PN check fail",
> +		[HAL_REO_DEST_RING_ERROR_CODE_2K_ERR_FLAG_SET] = "2k err",
> +		[HAL_REO_DEST_RING_ERROR_CODE_PN_ERR_FLAG_SET] = "PN err",
> +		[HAL_REO_DEST_RING_ERROR_CODE_DESC_BLOCKED] = "Desc blocked"};
> +
> +	static const char *wbm_rel_src[HAL_WBM_REL_SRC_MODULE_MAX] = {
> +		[HAL_WBM_REL_SRC_MODULE_TQM] = "TQM",
> +		[HAL_WBM_REL_SRC_MODULE_RXDMA] = "Rxdma",
> +		[HAL_WBM_REL_SRC_MODULE_REO] = "Reo",
> +		[HAL_WBM_REL_SRC_MODULE_FW] = "FW",
> +		[HAL_WBM_REL_SRC_MODULE_SW] = "SW"};
> +
> +	char *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	len += scnprintf(buf + len, size - len, "DEVICE RX STATS:\n\n");
> +	len += scnprintf(buf + len, size - len, "err ring pkts: %u\n",
> +			 device_stats->err_ring_pkts);
> +	len += scnprintf(buf + len, size - len, "Invalid RBM: %u\n\n",
> +			 device_stats->invalid_rbm);
> +	len += scnprintf(buf + len, size - len, "RXDMA errors:\n");
> +
> +	for (i = 0; i < HAL_REO_ENTR_RING_RXDMA_ECODE_MAX; i++)
> +		len += scnprintf(buf + len, size - len, "%s: %u\n",
> +				 rxdma_err[i], device_stats->rxdma_error[i]);
> +
> +	len += scnprintf(buf + len, size - len, "\nREO errors:\n");
> +
> +	for (i = 0; i < HAL_REO_DEST_RING_ERROR_CODE_MAX; i++)
> +		len += scnprintf(buf + len, size - len, "%s: %u\n",
> +				 reo_err[i], device_stats->reo_error[i]);
> +
> +	len += scnprintf(buf + len, size - len, "\nHAL REO errors:\n");
> +
> +	for (i = 0; i < DP_REO_DST_RING_MAX; i++)
> +		len += scnprintf(buf + len, size - len,
> +				 "ring%d: %u\n", i,
> +				 device_stats->hal_reo_error[i]);
> +
> +	len += scnprintf(buf + len, size - len, "\nDEVICE TX STATS:\n");
> +	len += scnprintf(buf + len, size - len, "\nTCL Ring Full Failures:\n");
> +
> +	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
> +		len += scnprintf(buf + len, size - len, "ring%d: %u\n",
> +				 i, device_stats->tx_err.desc_na[i]);
> +
> +	len += scnprintf(buf + len, size - len,
> +			 "\nMisc Transmit Failures: %d\n",
> +			 atomic_read(&device_stats->tx_err.misc_fail));
> +
> +	len += scnprintf(buf + len, size - len, "\ntx_wbm_rel_source:");
> +
> +	for (i = 0; i < HAL_WBM_REL_SRC_MODULE_MAX; i++)
> +		len += scnprintf(buf + len, size - len, " %d:%u",
> +				 i, device_stats->tx_wbm_rel_source[i]);
> +
> +	len += scnprintf(buf + len, size - len, "\n");
> +
> +	len += scnprintf(buf + len, size - len, "\ntqm_rel_reason:");
> +
> +	for (i = 0; i < MAX_TQM_RELEASE_REASON; i++)
> +		len += scnprintf(buf + len, size - len, " %d:%u",
> +				 i, device_stats->tqm_rel_reason[i]);
> +
> +	len += scnprintf(buf + len, size - len, "\n");
> +
> +	len += scnprintf(buf + len, size - len, "\nfw_tx_status:");
> +
> +	for (i = 0; i < MAX_FW_TX_STATUS; i++)
> +		len += scnprintf(buf + len, size - len, " %d:%u",
> +				 i, device_stats->fw_tx_status[i]);
> +
> +	len += scnprintf(buf + len, size - len, "\n");
> +
> +	len += scnprintf(buf + len, size - len, "\ntx_enqueued:");
> +
> +	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
> +		len += scnprintf(buf + len, size - len, " %d:%u", i,
> +				 device_stats->tx_enqueued[i]);
> +
> +	len += scnprintf(buf + len, size - len, "\n");
> +
> +	len += scnprintf(buf + len, size - len, "\ntx_completed:");
> +
> +	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
> +		len += scnprintf(buf + len, size - len, " %d:%u",
> +				 i, device_stats->tx_completed[i]);
> +
> +	len += scnprintf(buf + len, size - len, "\n");
> +
> +	for (i = 0; i < ab->num_radios; i++) {
> +		ar = ath12k_mac_get_ar_by_pdev_id(ab, DP_SW2HW_MACID(i));
> +		if (ar) {
> +			len += scnprintf(buf + len, size - len,
> +					"\nradio%d tx_pending: %u\n", i,
> +					atomic_read(&ar->dp.num_tx_pending));
> +		}
> +	}
> +
> +	len += scnprintf(buf + len, size - len, "\nREO Rx Received:\n");
> +
> +	for (i = 0; i < DP_REO_DST_RING_MAX; i++) {
> +		len += scnprintf(buf + len, size - len, "Ring%d:", i + 1);
> +
> +		for (j = 0; j < ATH12K_MAX_DEVICES; j++) {
> +			len += scnprintf(buf + len, size - len,
> +					"\t%d:%u", j,
> +					 device_stats->reo_rx[i][j]);
> +		}
> +
> +		len += scnprintf(buf + len, size - len, "\n");
> +	}
> +
> +	len += scnprintf(buf + len, size - len, "\nRx WBM REL SRC Errors:\n");
> +
> +	for (i = 0; i < HAL_WBM_REL_SRC_MODULE_MAX; i++) {
> +		len += scnprintf(buf + len, size - len, "%s:", wbm_rel_src[i]);
> +
> +		for (j = 0; j < ATH12K_MAX_DEVICES; j++) {
> +			len += scnprintf(buf + len,
> +					 size - len,
> +					 "\t%d:%u", j,
> +					 device_stats->rx_wbm_rel_source[i][j]);
> +		}
> +
> +		len += scnprintf(buf + len, size - len, "\n");
> +	}
> +
> +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations fops_device_dp_stats = {
> +	.read = ath12k_debugfs_dump_device_dp_stats,
> +	.open = simple_open,
> +	.owner = THIS_MODULE,
> +	.llseek = default_llseek,
> +};
> +
> +void ath12k_debugfs_pdev_create(struct ath12k_base *ab)
> +{
> +	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
> +			    &fops_simulate_fw_crash);
> +
> +	debugfs_create_file("device_dp_stats", 0400, ab->debugfs_soc, ab,
> +			    &fops_device_dp_stats);
> +}
> +
>  void ath12k_debugfs_soc_create(struct ath12k_base *ab)
>  {
>  	bool dput_needed;

Reviewed-by: Mahendran P <quic_mahep@quicinc.com>


