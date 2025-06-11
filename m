Return-Path: <linux-wireless+bounces-23956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B937AD4929
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0A217CB9A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EDE225A39;
	Wed, 11 Jun 2025 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LbkIPTVb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E314B965;
	Wed, 11 Jun 2025 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749611082; cv=none; b=AW/K1Lsogb0V59IXvaYKWQx2kNj/9eXLZGt8SxCfkftZ5rFH+/9FnggM1q82Im9hbVMZ4/zx2OSExJnJOOB/8JPSziD1GXLmeZIvtT6UIDHGkmGzbHbxm/PFoZAX+VJs15/I18UoFW23nHOGwJ//qDUoqGKkuSzmzGOBfOjKbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749611082; c=relaxed/simple;
	bh=tMVbwX8q7yKp+m/nWv/8AM1ELenkBxHLUa86v+2rir8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TSNxtMZNmGEsckgPjbVhGLa2CaF6HzKfkHqScc+28ENZC7gGTWMLnl0R+BbAUdJ3lnm6O+MPuioANv3Ygye4rzBhKwYZd8g2r1cb75g53LL1LgXOKrFWTqo3+hobpDri5rV4wxNtsP3jqglNyycu10Qb9+pryGqGB1sfNdRKUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LbkIPTVb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIPrhO030928;
	Wed, 11 Jun 2025 03:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VzkC5ZKh9OUNH1vFltysfWJB99nL7fmVjscSBmNOAHQ=; b=LbkIPTVb3emW06kR
	KWZQsPbZixTNjMtXamaXD+u4PRD2JCnEYNCy5IrclZ25d7LWSIbvtrBYI4H1YDCx
	HyHGov51QKP9Tlg4BslBOOAYk5HdmrnHm7Ps6haYFS6ue0vaBuwXWScbC6eq18yG
	LWDFrCiRjmJQx6Oxh+emywTF22RvMIym7FhiECtp3Cy9joM/FSs4CsOffoT12pr2
	syylg0AJqNddiXLN5EqzcIEu8Lg9w1zUx9+1moOGF0y5cmsK2ZuI3zGM5XgSO6a1
	TKLpVWEkFnS48rx5ZmHBAaqx39YrTniHmtZY5/XT5WP7Y7gyA1P1lOx8wCWaPsC2
	WLLeaA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475v2te4qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 03:04:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55B34W3q004140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 03:04:32 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Jun
 2025 20:04:30 -0700
Message-ID: <3676e97c-fafd-4cf0-987c-64f139bab78f@quicinc.com>
Date: Wed, 11 Jun 2025 11:04:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Avoid CPU busy-wait by handling VDEV_STAT
 and BCN_STAT
To: Bjorn Andersson <andersson@kernel.org>,
        Rameshkumar Sundaram
	<rameshkumar.sundaram@oss.qualcomm.com>
CC: <bjorn.andersson@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Mahendran P
	<quic_mahep@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20250609-ath12k-fw-stats-done-v1-1-2b3624656697@oss.qualcomm.com>
 <c2d138ba-5b08-4daa-95b3-e1f95f05938d@oss.qualcomm.com>
 <v44xnvqxjdqtonpfvnn6iblzmchgxbhtj7t25dhaxcimippba5@rbjf5roopwdx>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <v44xnvqxjdqtonpfvnn6iblzmchgxbhtj7t25dhaxcimippba5@rbjf5roopwdx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wu8zE6l1f0_EW8xIMHWRwke_gCyKWebW
X-Authority-Analysis: v=2.4 cv=GoxC+l1C c=1 sm=1 tr=0 ts=6848f241 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=XhntT_gzShnWNOLXFk8A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: wu8zE6l1f0_EW8xIMHWRwke_gCyKWebW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDAyNSBTYWx0ZWRfX3NLVirWRLwkV
 xdo8lA9m1WeoZUTA+4y+SRzBZ7uBNB5IsiXBypN0H3L8oh/DuwYaoKC8QYzXUNvblE4j368Xa4a
 LhP5PKbxj2BswoH/W2+bpMTiXnMZAgOtfwVFLPArdrlQ8QLPhPtww41v6FkQrMUmFtxvM3l96wo
 6Oqq4/cC6N2iT5c2ztDLTcdFy4bN46A+vrtUw9Nx2eakgO5FCqoU5UXcD4gTO8oXmUtT2rhnCan
 G5V25Igyl83H7GvXbEo/EPZwfCO9G0ip7+z1L6xY/0yBe9lWMEJXi2EU7ayqp+t1x1OYzR8klMx
 DwNdM/dsJc2r4rvbS5tQDTUUIizTv+01mtMtuOHTCBZVUawf86Pn5Xm2PM76Iz9SGqml0h+8Lzb
 NEOfVP0VSEi0BtdWgBi6TZy7vmrJ1IohX4gVzBNYX/MNAPshEtjLuL0NCOfPommTUwD7KB/R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110025



On 6/11/2025 1:41 AM, Bjorn Andersson wrote:
> On Tue, Jun 10, 2025 at 01:16:30PM +0530, Rameshkumar Sundaram wrote:
>>
>>
>> On 6/10/2025 8:36 AM, Bjorn Andersson via B4 Relay wrote:
>>> From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
>>>
>>> When the ath12k driver is built without CONFIG_ATH12K_DEBUG, the
>>> recently refactored stats code can cause any user space application
>>> (such at NetworkManager) to consume 100% CPU for 3 seconds, every time
>>> stats are read.
>>>
>>> Commit 'b8a0d83fe4c7 ("wifi: ath12k: move firmware stats out of
>>> debugfs")' moved ath12k_debugfs_fw_stats_request() out of debugfs, by
>>> merging the additional logic into ath12k_mac_get_fw_stats().
>>>
>>> Among the added responsibility of ath12k_mac_get_fw_stats() was the
>>> busy-wait for `fw_stats_done`.
>>>
>>> Signalling of `fw_stats_done` happens when one of the
>>> WMI_REQUEST_PDEV_STAT, WMI_REQUEST_VDEV_STAT, and WMI_REQUEST_BCN_STAT
>>> messages are received, but the handling of the latter two commands remained
>>> in the debugfs code. As `fw_stats_done` isn't signalled, the calling
>>> processes will spin until the timeout (3 seconds) is reached.
>>>
>>> Moving the handling of these two additional responses out of debugfs
>>> resolves the issue.
>>>
>>> Fixes: b8a0d83fe4c7 ("wifi: ath12k: move firmware stats out of debugfs")
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
>>> ---
>>>   drivers/net/wireless/ath/ath12k/debugfs.c | 58 --------------------------
>>>   drivers/net/wireless/ath/ath12k/debugfs.h |  7 ----
>>>   drivers/net/wireless/ath/ath12k/wmi.c     | 67 +++++++++++++++++++++++++++----
>>>   3 files changed, 60 insertions(+), 72 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
>>> index dd624d73b8b2714e77c9d89b5a52f7b3fcb02951..23da93afaa5c25e806c9859dbbdd796afd23d78a 100644
>>> --- a/drivers/net/wireless/ath/ath12k/debugfs.c
>>> +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
>>> @@ -1251,64 +1251,6 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
>>>   	 */
>>>   }
>>> -void
>>> -ath12k_debugfs_fw_stats_process(struct ath12k *ar,
>>> -				struct ath12k_fw_stats *stats)
>>> -{
>>> -	struct ath12k_base *ab = ar->ab;
>>> -	struct ath12k_pdev *pdev;
>>> -	bool is_end;
>>> -	static unsigned int num_vdev, num_bcn;
>>> -	size_t total_vdevs_started = 0;
>>> -	int i;
>>> -
>>> -	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
>>> -		if (list_empty(&stats->vdevs)) {
>>> -			ath12k_warn(ab, "empty vdev stats");
>>> -			return;
>>> -		}
>>> -		/* FW sends all the active VDEV stats irrespective of PDEV,
>>> -		 * hence limit until the count of all VDEVs started
>>> -		 */
>>> -		rcu_read_lock();
>>> -		for (i = 0; i < ab->num_radios; i++) {
>>> -			pdev = rcu_dereference(ab->pdevs_active[i]);
>>> -			if (pdev && pdev->ar)
>>> -				total_vdevs_started += pdev->ar->num_started_vdevs;
>>> -		}
>>> -		rcu_read_unlock();
>>> -
>>> -		is_end = ((++num_vdev) == total_vdevs_started);
>>> -
>>> -		list_splice_tail_init(&stats->vdevs,
>>> -				      &ar->fw_stats.vdevs);
>>> -
>>> -		if (is_end) {
>>> -			ar->fw_stats.fw_stats_done = true;
>>> -			num_vdev = 0;
>>> -		}
>>> -		return;
>>> -	}
>>> -	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
>>> -		if (list_empty(&stats->bcn)) {
>>> -			ath12k_warn(ab, "empty beacon stats");
>>> -			return;
>>> -		}
>>> -		/* Mark end until we reached the count of all started VDEVs
>>> -		 * within the PDEV
>>> -		 */
>>> -		is_end = ((++num_bcn) == ar->num_started_vdevs);
>>> -
>>> -		list_splice_tail_init(&stats->bcn,
>>> -				      &ar->fw_stats.bcn);
>>> -
>>> -		if (is_end) {
>>> -			ar->fw_stats.fw_stats_done = true;
>>> -			num_bcn = 0;
>>> -		}
>>> -	}
>>> -}
>>> -
>>>   static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
>>>   {
>>>   	struct ath12k *ar = inode->i_private;
>>> diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
>>> index ebef7dace3448e4bdf2d6cb155d089267315172c..21641a8a03460c6cc1b34929a353e5605bb834ce 100644
>>> --- a/drivers/net/wireless/ath/ath12k/debugfs.h
>>> +++ b/drivers/net/wireless/ath/ath12k/debugfs.h
>>> @@ -12,8 +12,6 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab);
>>>   void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
>>>   void ath12k_debugfs_register(struct ath12k *ar);
>>>   void ath12k_debugfs_unregister(struct ath12k *ar);
>>> -void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
>>> -				     struct ath12k_fw_stats *stats);
>>>   void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
>>>   			       struct ieee80211_vif *vif);
>>>   void ath12k_debugfs_pdev_create(struct ath12k_base *ab);
>>> @@ -126,11 +124,6 @@ static inline void ath12k_debugfs_unregister(struct ath12k *ar)
>>>   {
>>>   }
>>> -static inline void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
>>> -						   struct ath12k_fw_stats *stats)
>>> -{
>>> -}
>>> -
>>>   static inline bool ath12k_debugfs_is_extd_rx_stats_enabled(struct ath12k *ar)
>>>   {
>>>   	return false;
>>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
>>> index 60e2444fe08cefa39ae218d07eb9736d2a0c982b..2d2444417e2b2d9281754d113f2b073034e27739 100644
>>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>>> @@ -7626,6 +7626,63 @@ static int ath12k_wmi_pull_fw_stats(struct ath12k_base *ab, struct sk_buff *skb,
>>>   				   &parse);
>>>   }
>>> +static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
>>> +					struct ath12k_fw_stats *stats)
>>> +{
>>> +	struct ath12k_base *ab = ar->ab;
>>> +	struct ath12k_pdev *pdev;
>>> +	bool is_end;
>>> +	static unsigned int num_vdev, num_bcn;
>>> +	size_t total_vdevs_started = 0;
>>> +	int i;
>>> +
>>> +	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
>>> +		if (list_empty(&stats->vdevs)) {
>>> +			ath12k_warn(ab, "empty vdev stats");
>>> +			return;
>>> +		}
>>> +		/* FW sends all the active VDEV stats irrespective of PDEV,
>>> +		 * hence limit until the count of all VDEVs started
>>> +		 */
>>> +		rcu_read_lock();
>>> +		for (i = 0; i < ab->num_radios; i++) {
>>> +			pdev = rcu_dereference(ab->pdevs_active[i]);
>>> +			if (pdev && pdev->ar)
>>> +				total_vdevs_started += pdev->ar->num_started_vdevs;
>>> +		}
>>> +		rcu_read_unlock();
>>> +
>>> +		is_end = ((++num_vdev) == total_vdevs_started);
>>> +
>>> +		list_splice_tail_init(&stats->vdevs,
>>> +				      &ar->fw_stats.vdevs);
>>> +
>>> +		if (is_end) {
>>> +			ar->fw_stats.fw_stats_done = true;
>>> +			num_vdev = 0;
>>> +		}
>>> +		return;
>>> +	}
>>> +	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
>>> +		if (list_empty(&stats->bcn)) {
>>> +			ath12k_warn(ab, "empty beacon stats");
>>> +			return;
>>> +		}
>>> +		/* Mark end until we reached the count of all started VDEVs
>>> +		 * within the PDEV
>>> +		 */
>>> +		is_end = ((++num_bcn) == ar->num_started_vdevs);
>>> +
>>> +		list_splice_tail_init(&stats->bcn,
>>> +				      &ar->fw_stats.bcn);
>>> +
>>> +		if (is_end) {
>>> +			ar->fw_stats.fw_stats_done = true;
>>> +			num_bcn = 0;
>>> +		}
>>> +	}
>>> +}
>>> +
>>>   static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *skb)
>>>   {
>>>   	struct ath12k_fw_stats stats = {};
>>> @@ -7655,19 +7712,15 @@ static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *sk
>>>   	spin_lock_bh(&ar->data_lock);
>>> -	/* WMI_REQUEST_PDEV_STAT can be requested via .get_txpower mac ops or via
>>> -	 * debugfs fw stats. Therefore, processing it separately.
>>> -	 */
>>> +	/* Handle WMI_REQUEST_PDEV_STAT status update */
>>>   	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
>>>   		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
>>>   		ar->fw_stats.fw_stats_done = true;
>>>   		goto complete;
>>>   	}
>>> -	/* WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT are currently requested only
>>> -	 * via debugfs fw stats. Hence, processing these in debugfs context.
>>> -	 */
>>> -	ath12k_debugfs_fw_stats_process(ar, &stats);
>>> +	/* Handle WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT updates. */
>>> +	ath12k_wmi_fw_stats_process(ar, &stats);
>>>   complete:
>>>   	complete(&ar->fw_stats_complete);
>>>
>>
>>
>> This look fine to me, Thanks for fixing this.
>>
>> Apart from this we may also have to free up the stats buffer list maintained
>> when the stats is requested out of debugfs (like ath12k_mac_op_get_txpower()
>> and ath12k_mac_op_sta_statistics()) once its scope of usage is done, else
>> the memory will be held untill next fw stats request or module unload.
>>
> 
> I agree with this. In fact it seems to me that the majority of [1]
> should be considered for ath12k as well (and Jeff acknowledged the
> same).

Yeah, there are some other issues in addition to this DEBUGFS one, I jsut posted the fix
for review.

> 
> The purpose of this patch was solely to deal with the regression from
> the previous behavior introduced in v6.16-rc1, causing my X Elite laptop
> to idle about 10C warmer. (Afaict neither distros or upstream arm64
> defconfig has ATH12K_DEBUG enabled)
> 
> The "also fix X, Y, Z" would at least be separate patches, and could be
> applied either to -rc or v6.17 on top of something like this.
> 
> [1] https://lore.kernel.org/ath11k/20250220082448.31039-1-quic_bqiang@quicinc.com/
> 
> Regards,
> Bjorn
> 
>> -- 
>> --
>> Ramesh
>>
>>
> 


