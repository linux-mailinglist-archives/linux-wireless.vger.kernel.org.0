Return-Path: <linux-wireless+bounces-32332-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEEbMrbopGlVvQUAu9opvQ
	(envelope-from <linux-wireless+bounces-32332-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 02:32:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDED1D24E2
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 02:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75BC93008D58
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 01:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDACD2798F3;
	Mon,  2 Mar 2026 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X01K4PAe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FKSfelLf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018C632
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772415155; cv=none; b=IhS9O6OSsxe3m6B0ZTnwCvMAQvNl1omO5m1HFqSEa+GzVZVtVyXo9r+9ToSfsTeZdFjzJMsucKA6BzsEBseR+m8uKAYpYJ8JCQL0Bri/Rs6D6Y1A1sKcLJAYkTwbeSEMDGVeAHq9Y2124SaWQ43CMHRZ/ANbXsQCDCw2YXpPH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772415155; c=relaxed/simple;
	bh=CERNNmYTnHI66/z4x50WUGdd5Jf5ZWdxsiSD5vGDWtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6ouXDS1/UeOPeOu08MoeBdKUGJlWArOqMZMnD36kkmml/ReTF5rgXZukRjk7xCvbNjY2Bzl1zk8nb7yfvx/4pYw1Yhzmx6rNHd3EPySXpZoLU7gj1NjOEeyqPeTd1+l/KTD1BJ7vj9umGYQn42bUoar9AtYFLR2fl+cc9TywbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X01K4PAe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FKSfelLf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621FiZTA3324790
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 01:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hg7jEDKqAjrvcGMc2MwAhzR/RK1kkh9IRIU9FZY40Ro=; b=X01K4PAelQNu1s8A
	M7ZzvufC3LO96Mwxo3YLBMEQStYsgoSr0sYxehBgIQfSR20Gw/VmBq44zDFHG3Ri
	s06qiaH0cnDpxKMJaD54VHvD3L7khIi6PN+TJ9ZXYkQ+h9auDU41q3ZtTRzP/jNY
	+zfd825zNa1XDe07Kq1d6h/xJfVLLkKpi1UJgVXetBLGzKnTUKF5ndIpxSH8lrhO
	Ul/sCS5APyBsTgVis0x33s6vaty2cFCFhTO61I/MO5ytvDEkkZ61825M7NtSGcOr
	hOTEMHNd2N9pchr3wSg+rtdFbajPPTDT8FVIarhKEzUmDQRsJgOlMuh+BsI8E1fw
	32NB0w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf6kh0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 01:32:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3595485abbbso2856228a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 01 Mar 2026 17:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772415152; x=1773019952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hg7jEDKqAjrvcGMc2MwAhzR/RK1kkh9IRIU9FZY40Ro=;
        b=FKSfelLfRejeFRVabtHz9d7QAJXEjGINDMfQ4w7OPHK/P/kYuitRmAdMXkLbP+vJ5T
         7QDz1KWhId1m9eLsCvNMn+DRqt733uCFdqtluohdKTYrL1iQkva/gKvQOgkyhQs5tt2X
         BBm3pc77+owWCjljAWcrTM4rVJoW+Mr6tdAB0fHs6TzUitdSo66xs1JJGmZd5au37TLv
         vSR7owE+beRCmkUEfcVvvihmuVth+J9KaQFa9/dgf7MiKkqGwYOayNW2+6mum9OVwgip
         pDxK2xEwpXq29gEGQco8p5MKubXilSwgUSbkk9FnTsTNmO+kY5Gjk2YinOnoNoqAZsf9
         ce+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772415152; x=1773019952;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hg7jEDKqAjrvcGMc2MwAhzR/RK1kkh9IRIU9FZY40Ro=;
        b=fmsf1dCUgthS5YkqyMByzEKvtu+hpiCa8P2R3eDXiVArZbN18n5vzuYVCPuHuRTYzQ
         zoz/ledOOIY7iYa1f9nCfxwl8KJh+EekdMlRBi+B2gaZT7bZuw5evDcy6Jxv2AQfbd1N
         yXT3OPExjA1VitZpIBn743Fmd8rinVSrWACHRCRLToa/5pQoWt3LDRg+1NVdEmuB4QRR
         d4rlq9KSdnQYUKkg44aLtYdmNNCxiCv4ZpbkmAiShZq8m2KcipNMozqcH04Rov/Ok1Hh
         H+cb++5mPBE/NpWpKejYbsB0Pm8RCY3zuSVYjQIstoakBMC1MmDCDd/3ZeTDtpBHNjGR
         0/FA==
X-Gm-Message-State: AOJu0YxLGv5v3EvC28LdQIIy2CynwbsVBDKxCmlqag16NJtw0o02jH8y
	/zu0jwN4AB1g6vM6c/639IzqvGq8I9tXWuCy8ltUysUQv1daVEg+4Imbq1w0hXHb81le35cGHkI
	+p96fVsisJ+sG8684PJ0vDCT644Dc0ccxkAv3u63DB1kULzZmC0eDqsDZF7peNIZHHaBlFg==
X-Gm-Gg: ATEYQzzNvimbTj7GDAYQygLsKz1BVh5Do3d+PRQ2zRsYlzXFvNGKNEmY5bdslL3HWlo
	eqiSRyMkkGQIGeVKRmunoR0MGXoKSdFGGMYZ7GgbUbWZlEo3ybF4VabyMc4YFrsKLqdm9tO/5VE
	f5Z/iCTsgaCQ/Qm6/9SB4fOcdm2muchAE4guBxBK7edtXSC1SgPJH/cuKM0ffoODHT3X9YqvlzF
	SVUvq7/5UD4M9aZoHPLQQTg44J4hOYEkVQRENCYBUokgnTdDCyZgmrt8UQ7kffU6+u9o034Wx9N
	ieJUGmQrluKhQi4rBwNwYUtNKaea1e1kYVgL7MYJOvgjvRNkJGosPtWSrFdzb3pexuNiGlCaeQ7
	I7uxDX5wc67K7K9Ra+YxxByVZ2mPvh4IQDppug5JK1zc7Rs9FxGWmw2ZLUj9EM9sdLHkUWtSfw1
	S4l2S4r4W9vg4h+BAU9yM=
X-Received: by 2002:a17:90b:578e:b0:34c:9cec:dd83 with SMTP id 98e67ed59e1d1-35965cca925mr8775007a91.27.1772415151957;
        Sun, 01 Mar 2026 17:32:31 -0800 (PST)
X-Received: by 2002:a17:90b:578e:b0:34c:9cec:dd83 with SMTP id 98e67ed59e1d1-35965cca925mr8774980a91.27.1772415151405;
        Sun, 01 Mar 2026 17:32:31 -0800 (PST)
Received: from [10.133.33.249] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35980594d37sm4719722a91.16.2026.03.01.17.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 17:32:31 -0800 (PST)
Message-ID: <86089c00-a6ba-4a36-af14-f63f557d1099@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 09:32:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Pass the correct value of each
 TID during a stop AMPDU session
To: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260227110123.3726354-1-reshma.rajkumar@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260227110123.3726354-1-reshma.rajkumar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aZoGNPqUecti1AgS1mjCdusCxWuCLPcD
X-Authority-Analysis: v=2.4 cv=JoL8bc4C c=1 sm=1 tr=0 ts=69a4e8b1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vkfXM0Oplov9zySb:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=duuHIgzx20vBNMS0sRsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAxMSBTYWx0ZWRfX4Jwvd0Ru+Yg7
 THBjtbv7DWNFhXJEdIHv9/6qmfvuGpOoqdgJw0SvcBiQajxMGM2opk5l9/dAwujbdFxceGyAjUk
 YdUnD6fCrWmoFHjg2AmBxxBrLtBhv0rGrzfns7itPpz3E5gCw8d4MU6sQqRGx73CL+ZI2rndA7i
 wHavS7jpgUyNioA46esq6UeMaD1D5FW1Vj26CICB392clEbKTZiqz4FeOLN0n3A0aAC9Ez9s7sE
 HaYDbUZZa3jcQKYGgTdkOf0Gv67mvHfDTCTWKB75dk5KyEaKJuJmSHLUxb6JhUEQAb0AdMuAR9u
 phEblZGC7D/Z81+bGUs7iHFq6wTFkaV3t/bQu47pMtR4o8jWYq8n292+FEg4UFXc06sbD8Xlrc3
 eBxylyqF2JlV9kymZtrpgDNMXSiNMyK0aaYKi6uL9mc9IcMRUMUd2f9UcWXMchkcD4ckh3Bwp9T
 Jb4YdGaSUwMxqso3YsA==
X-Proofpoint-GUID: aZoGNPqUecti1AgS1mjCdusCxWuCLPcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32332-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6DDED1D24E2
X-Rspamd-Action: no action



On 2/27/2026 7:01 PM, Reshma Immaculate Rajkumar wrote:
> With traffic ongoing for data TID [TID 0], an DELBA request to
> stop AMPDU for the BA session was received on management TID [TID 4].
> The corresponding TID number was incorrectly passed to stop the BA session,
> resulting in the BA session for data TIDs being stopped and the BA size
> being reduced to 1, causing an overall dip in TCP throughput.
> 
> Fix this issue by passing the correct argument from
> ath12k_dp_rx_ampdu_stop() to ath12k_dp_arch_peer_rx_tid_reo_update()
> during an AMPDU stop session. Instead of passing peer->dp_peer->rx_tid,
> which is the base address of the array, corresponding to TID 0, pass
> the value of &peer->dp_peer->rx_tid[params->tid]. With this, the
> different TID numbers are accounted for.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
> ---
> v2:
> * modify 'ADDBA' to 'DELBA' request in commit message
>  drivers/net/wireless/ath/ath12k/dp_rx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index a32ee9f8061a..640f752eaa03 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -735,6 +735,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
>  	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
>  	struct ath12k_dp_link_peer *peer;
>  	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(params->sta);
> +	struct ath12k_dp_rx_tid *rx_tid;
>  	struct ath12k_link_sta *arsta;
>  	int vdev_id;
>  	bool active;
> @@ -770,7 +771,8 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
>  		return 0;
>  	}
>  
> -	ret = ath12k_dp_arch_peer_rx_tid_reo_update(dp, peer, peer->dp_peer->rx_tid,
> +	rx_tid = &peer->dp_peer->rx_tid[params->tid];
> +	ret = ath12k_dp_arch_peer_rx_tid_reo_update(dp, peer, rx_tid,
>  						    1, 0, false);
>  	spin_unlock_bh(&dp->dp_lock);
>  	if (ret) {
> 
> base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


