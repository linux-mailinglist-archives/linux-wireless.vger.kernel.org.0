Return-Path: <linux-wireless+bounces-29613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C960CAEA82
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 02:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8ABE030024BF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F50214A9B;
	Tue,  9 Dec 2025 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c7QtzM9Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M51yN8vZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431C3009E5
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765245011; cv=none; b=WFA3wibTZPJHR8Ndih8n6+1xAVtuw4YbSVO4oFeNXWyftHIKPT9++Razz08IDiycT5JSQTF2aFX6rH6i+UobA1z2kL6GutBOuikw4cVHQvrMMc/77jgjNLJSaWgfC2eXoLe6RWsZ72IwyP0Zgp4naIDPlp9jNiT69YKHcyOGstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765245011; c=relaxed/simple;
	bh=CO3j+yLs2PElKBdc7gdP8a0rhdn66Oe7mlh6HqMHoCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihvlhH4S4mdyzv/dlplwlkKtbZX2MwSqbWL6DbnYDLkJWzVpqKt3sox1AOzLXW8SjRBjmmb0MuZtJZiqt8/cbhabFtsmYHFbU3hzUkqbVBw6LECQvkfE8O0B73gConffxmJSICMfoM+A1A4Xv45iJuVhuwCKJV2Iy+DDgYZF4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c7QtzM9Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M51yN8vZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8NX5OD2429242
	for <linux-wireless@vger.kernel.org>; Tue, 9 Dec 2025 01:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iYMwWGOVBSgGJklHUSVmoJod4PG9XIn06diCPF7M+jc=; b=c7QtzM9ZHiBkzWhf
	Tjd3xbdUFkZIjVTFf/fnuq3bJX6sb7PBWHHUvtsmk6mvows4QaSqb/x6Rz/plro4
	p7sniiffXEpiFws9C+Jj/VttOhK14NpD1GMhBlubtSQrURebbAzQezGsw52vJYf0
	oX9gSsLNsz+pDgzsFPWJ7ZLMzpTKgozFlS8zxbpBN95H43/hCMrlsUx6LHh+ZGJp
	dtaDqAaN6mLqXGppoYdNoF28HruQwbP/4Kf0pdbrxVa8C+kJ5YrPrTak8W5R6Q/I
	nymBg/xXTpsc+CuGMGIcHD/vJAG7F9+UXisTqeJOMZW5OBQI0HFKQFed1hrT4LaD
	LgEpYQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ax2rf17e6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 01:50:08 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-349aadb8ab9so4775327a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 17:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765245007; x=1765849807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYMwWGOVBSgGJklHUSVmoJod4PG9XIn06diCPF7M+jc=;
        b=M51yN8vZpjnXjYgRYk0/n2OjsA/xUT5cbx14xINyUEfkupiAPHokOdNU2vsR8culMB
         A6qyp8edTDC2sfDiiqRXj0frNLReICJQ+IiL9p0iKZdOO8TmOaMxuHzd166ckeW1bMPK
         wm8zTeUERCOXZ/whFD9hCd932vfaHhhbojXOmtx/SnyPAesbXhdN0VaBqFDnZ7cVCq9S
         +adaofJ36uxTCYgtcmvgXBkJ5rIJpql1P/r/NxBspu6knoCv/UzjXsmEUtVcnPyAlUQ8
         XtFAnzCmHlcPooss+bFECmYSWxz1x0r4z2oobADBh3vqDTBZXGh8Qc5ta8Hp8wCZv/Q0
         c8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765245007; x=1765849807;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYMwWGOVBSgGJklHUSVmoJod4PG9XIn06diCPF7M+jc=;
        b=lrJ0Et3APmTnaLOOBL25gdKxkoTVyePCrklX7fYrLkWqZF1ZvGZCRT98st2uyKw63H
         vbZInWORU3hjjvNFxdwvelFpX16on0cTQWvzUW9Ly91I5HiWdjeOTDaYjOdJE1J1QUYC
         dbzyMTO5yg8V0zQt4xGasrXdSlR1XrKR1GtpIPXeDEYgClTCc0NMpzu4edr/bLQomyiV
         Gvxfw0SuWe+tbd3CEOUkN6sPydRWMZQ6Chf0ntaQWHBJdJzZP9JfBoGHAEatST9gMaPK
         QqFg/Qw65UrVP3wzsxmo2HFfEu1STDXLzPwMktM+rZ1Xe5IzuVoIyBVmMrrIMKxQqaqA
         JOyw==
X-Gm-Message-State: AOJu0YyvemdAITZXWqNduBBNtqdkDAFDCl30r+Zd04aEMMdpspbNfwLS
	YW/27x8GVmuWmdk+TIu0KgYcmqChM43F5kXEHvpHSwK9ifQ2YyAj3zGOFn1HWBgv91hTTs/HNnK
	0FEDEeCdFPpkFjgkrVtHuXAvhSrDSTwvS24LYiJrfrXqiPEGaXSVQ+zXj01pVN3uULiATK3UhVE
	7+0g==
X-Gm-Gg: ASbGncuzw5sEhuGAFIkCaiy74gd2hfM0Kdt5B1BDFSSuMrYsGbDc/8YCGqb46rQZr4n
	Vs5LlgfzzrkqOQukeaXldI61/BOXqfJlQf2iYAbV8tP2k74CtkOySI+BB+C0SlP07yBtl4pbcEu
	f1hF31wTkDqafTiGlCBYW3vLW3u4UeIoYJk5Caan92XXr9aH8xRZaLmvzdVjnzXv7vamKtzpHPQ
	dtkrVnVmcQ2ESezMBMcAs/uQZLackc4+93kMAZJ1FLgCr65YlUnrSRAeNkUR9ZGv6aRKavyhhbL
	UAuk7kX26Zzz32KW8zlx6llV3tMVAXloyDmrAU+3VBTnEubNWI9KjJf4SYpp9PYa1XmP+hML8Ib
	OuUIk+7eekRJ9GSoNzA7oR5stHtHfoU/7EPef65ASNWJ8woLizXFQGlyphm83UVOBuWAtC5jkDF
	bcD0ll7NI=
X-Received: by 2002:a17:90b:2ccb:b0:343:747e:2cac with SMTP id 98e67ed59e1d1-349a26081fbmr7387585a91.31.1765245007161;
        Mon, 08 Dec 2025 17:50:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxRX16HOt31Ofctpv4cUfI8JUUGyeaSIELIX8maSH5nbDjdOrzYQEDTC8aAAW+ive5qww6cg==
X-Received: by 2002:a17:90b:2ccb:b0:343:747e:2cac with SMTP id 98e67ed59e1d1-349a26081fbmr7387568a91.31.1765245006635;
        Mon, 08 Dec 2025 17:50:06 -0800 (PST)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a49658704sm524982a91.6.2025.12.08.17.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 17:50:06 -0800 (PST)
Message-ID: <94374e66-f7bd-4e5b-a683-8802616472b9@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 09:50:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng] wifi: ath12k: Skip DP peer creation for scan
 vdev
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251207072717.95542-1-quic_rdeuri@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251207072717.95542-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ee0wvrEH c=1 sm=1 tr=0 ts=69378050 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=uoGj4bbEhODSdn1brq8A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 58K_jfzl5GxSCHJZqmGyzoJp55Jai9TY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDAxMSBTYWx0ZWRfX4jBBAD9dGjLa
 APgbWqX7LNn7jMzS8/ojrVCdED36hLEwxk9p6B8yijiS6USZXIhQhIiKEsYBa6UVQT7VqjasBy+
 GwScGrFI3gN3Q0wbN5wQUE5T773bcKops6PlvVaySmfFBQ5R0/NhWblBFpwoFESaHSYxZf3h/Ob
 lTGRso7JoZKU1Er5UQawu1oj+7HUIvOmUxvsA7Z9N+MFxiQaeP0uBfjr6Ppx4PD70ljB0xN5Fyz
 VZ0eeRs86xSyhmBTpc+Wl2s8xLxWulkooi7ymGpubEsHJOhExdo7ihPcNFoN9uaYW44M+/HTYIK
 +PginIWe5LSCdliEbaqmBPo2S9v+Wdt9dONITizQtIydOcy0BQX1eEfWCXdRpJ+njyRpBk50fwI
 xkSF0IBWKv+8MpY/6E4KGwr2zzkYMg==
X-Proofpoint-ORIG-GUID: 58K_jfzl5GxSCHJZqmGyzoJp55Jai9TY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-08_07,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090011



On 12/7/2025 3:27 PM, Ripan Deuri wrote:
> Consider a multi-link AP configuration:
> 
>     MLD vif (MAC addr: aa:bb)
>         |-- 2.4 GHz link (BSSID: aa:bb)
>         |-- 5 GHz link   (BSSID: cc:dd)
> 
> For AP vdevs, ath12k creates a DP peer using the arvif's BSSID and stores
> it in dp_hw->dp_peers_list. During scan operations, the driver assigns an
> arvif to the scan vdev and uses the vif's MAC address as its BSSID. In
> the above scenario, the scan vdev MAC address (aa:bb) matches the BSSID
> of the 2.4 GHz AP link, causing a duplicate entry in dp_hw->dp_peers_list
> and leading to scan vdev creation failure.
> 
> Failure in vif bringup sequence:
> 1. Create AP vdev for 2.4 GHz link:
>    - Assign arvif with BSSID = aa:bb and link_id = 0.
>    - Create DP peer with address aa:bb and add to dp_hw->dp_peers_list.
> 
> 2. Create scan vdev for 5 GHz link:
>    - Assign arvif with BSSID = aa:bb (same as vif MAC address) and
>      link_id = 15.
>    - Attempt to create another DP peer with address aa:bb.
>    - Operation fails because aa:bb already exists in dp_hw->dp_peers_list,
>      resulting in duplicate entry conflict.
> 
> 3. Delete scan vdev for 5 GHz link.
> 4. Create AP vdev for 5 GHz link.
> 
> Since DP peer is not needed for scan operations, identify scan vdev using
> arvif->link_id >= IEEE80211_MLD_MAX_NUM_LINKS and skip DP peer creation
> and deletion.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c  | 22 ++++++++++++++--------
>  drivers/net/wireless/ath/ath12k/peer.c | 12 +++++++-----
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 3649f58fef84..42e750376926 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -1229,7 +1229,8 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
>  
>  	/* Delete all the self dp_peers on asserted radio */
>  	list_for_each_entry_safe_reverse(arvif, tmp_vif, &ar->arvifs, list) {
> -		if (arvif->ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
> +		if ((arvif->ahvif->vdev_type == WMI_VDEV_TYPE_AP) &&
> +		    (arvif->link_id < IEEE80211_MLD_MAX_NUM_LINKS)) {
>  			ath12k_dp_peer_delete(dp_hw, arvif->bssid, NULL);
>  			arvif->num_stations = 0;
>  		}
> @@ -4031,7 +4032,8 @@ static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
>  			ath12k_warn(ar->ab, "failed to submit AP self-peer removal on vdev %d link id %d: %d",
>  				    arvif->vdev_id, arvif->link_id, ret);
>  
> -		ath12k_dp_peer_delete(&ah->dp_hw, arvif->bssid, NULL);
> +		if (arvif->link_id < IEEE80211_MLD_MAX_NUM_LINKS)
> +			ath12k_dp_peer_delete(&ah->dp_hw, arvif->bssid, NULL);
>  	}
>  	ath12k_mac_vdev_delete(ar, arvif);
>  }
> @@ -9720,6 +9722,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>  	u8 link_id;
>  	struct ath12k_dp_link_vif *dp_link_vif = NULL;
>  	struct ath12k_dp_peer_create_params params = {};
> +	bool dp_peer_created = false;
>  
>  	lockdep_assert_wiphy(hw->wiphy);
>  
> @@ -9805,11 +9808,14 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>  	case WMI_VDEV_TYPE_AP:
>  		params.ucast_ra_only = true;
>  
> -		ret = ath12k_dp_peer_create(&ah->dp_hw, arvif->bssid, &params);
> -		if (ret) {
> -			ath12k_warn(ab, "failed to vdev %d create dp_peer for AP: %d\n",
> -				    arvif->vdev_id, ret);
> -			goto err_vdev_del;
> +		if (arvif->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
> +			ret = ath12k_dp_peer_create(&ah->dp_hw, arvif->bssid, &params);
> +			if (ret) {
> +				ath12k_warn(ab, "failed to vdev %d create dp_peer for AP: %d\n",
> +					    arvif->vdev_id, ret);
> +				goto err_vdev_del;
> +			}
> +			dp_peer_created = true;
>  		}
>  
>  		peer_param.vdev_id = arvif->vdev_id;
> @@ -9925,7 +9931,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>  	}
>  
>  err_dp_peer_del:
> -	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP)
> +	if (dp_peer_created)
>  		ath12k_dp_peer_delete(&ah->dp_hw, arvif->bssid, NULL);
>  
>  err_vdev_del:
> diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
> index c2fb5bbd6cea..5f3bd3b9a3e9 100644
> --- a/drivers/net/wireless/ath/ath12k/peer.c
> +++ b/drivers/net/wireless/ath/ath12k/peer.c
> @@ -241,11 +241,13 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
>  
>  	spin_unlock_bh(&dp->dp_lock);
>  
> -	ret = ath12k_dp_link_peer_assign(ath12k_ab_to_dp(ar->ab),
> -					 &(ath12k_ar_to_ah(ar)->dp_hw),
> -					 arvif->vdev_id, sta,
> -					 (u8 *)arg->peer_addr, link_id,
> -					 ar->hw_link_id);
> +	if (arvif->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
> +		ret = ath12k_dp_link_peer_assign(ath12k_ab_to_dp(ar->ab),
> +						 &(ath12k_ar_to_ah(ar)->dp_hw),
> +						 arvif->vdev_id, sta,
> +						 (u8 *)arg->peer_addr, link_id,
> +						 ar->hw_link_id);
> +	}
>  
>  	return ret;
>  }
> 
> base-commit: a1e19289932aeef26085feb97597d624da6302ab

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


