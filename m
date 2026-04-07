Return-Path: <linux-wireless+bounces-34487-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FzbKISwx1Wly2QcAu9opvQ
	(envelope-from <linux-wireless+bounces-34487-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:30:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C823B1DE3
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F55E305F77A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 16:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BE43CC9EA;
	Tue,  7 Apr 2026 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I5Q6J92D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HodrBQRp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46533CD8D7
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579106; cv=none; b=QtmKhSh7u2K7SMtjki6mw3PMdATPVAC1FIwou5BE6fW9RqBn6b1bU0CMIOXOK4H8tfx18je6D7IUBraFveqmHPeYu6Frj5KRPwICFWnvEdHIiRf7MNqhvoqeqZDedv/PKmHf01YJF9mIttUf3LcgEclMptDu4rnYmfXO/CFyzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579106; c=relaxed/simple;
	bh=/Z7nJoXrX/j9JxDhrDNFc0+ngR+l3YGtMA6BvVmESb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwZarydDR/sQ7x6eKhWjgj5hRjRZM8nzd0Bqr8tfqVRa37DAMIXXyHPeU6agMXTefdAjGlNe87eOyK6+93q1sbPS9qBkHiYofgnJWvBunWlDVdpsb7jusrYGa5J9ShqLmRItIq3Zjjo5KN34yXIE2E5zBAscxMp0Sk0udVJRc2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I5Q6J92D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HodrBQRp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CuiEj3402569
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 16:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jeLN+Cf+q0pIwJp1heaBQRX13+3H6jm6F5Vc6u6zK5I=; b=I5Q6J92DL950P3vE
	2V80jBrdQZzWsElp0M/YjI3XUs+YPHS1A317mDQIldR43zo5dz3Wgr53oO5zvv7c
	aAjlpF9azajXaE3SL/1HKwp+6Fs6FLgTkNZ34e9AVw9UNrNd0Hp6PCLSpg80Nttc
	naCsBczV/fydfwraeI7oJPnqmkFuAkpsFeau/HtiI/ooA6J8kvz/nhmjiR7/ntrI
	NXmONz2iWp7tq27sndFlhBO3MbssRDQB8ZFUudytMgHVbKuA0diFFLQydmsk1XEK
	NhZLYRaesmdfd41aHJII8cNE89JxubtbLE3CfI5s82Cz2yp0fBUwBcsqgI/cLyqF
	O2kdTQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhukea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 16:25:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82cf8dcd079so3732700b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775579100; x=1776183900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeLN+Cf+q0pIwJp1heaBQRX13+3H6jm6F5Vc6u6zK5I=;
        b=HodrBQRpnVhl29FcjrranPk2lYJjZPGCy99NpWr8mTNzooe2+x4PZF1jTdYl/BGa7r
         pT+Rod8jgI5Mc59748qGqAUuhzrXBB7JY9mAbMOSd5L8qr97E5gZglq8AvUBrVKgIEEf
         BQI2v46wyoKNWQgHyWTeE+dni91tMBFOgBzEcq4Mg90iS3Bw+m0/eD2OoEVFEUNKX/rX
         xSqG2BaDSc/Xv6zlYPmK1MnGYUJKrqyroKZQ/VJqm0odu2yGfWly4Mk54/yII0v3xk0M
         unyaDVxTYQJ110+hiUX0U7piGu9QKgz9PziPLXK1kWwV/6AALSrYH7mnWdW8isBWmwny
         2yVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579100; x=1776183900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeLN+Cf+q0pIwJp1heaBQRX13+3H6jm6F5Vc6u6zK5I=;
        b=pmnXK+2d+zsCsV6JsehLO+fmNUjnEptDHsdeTQ5vtC2yTo0MDOF1rtGWYyNjXIDk19
         6dTSDPLUwooLpjroZ/ORhdIUuLd4C9ssdT2NpMbNYisQh69jyg63aaHGIDG/xuD9kLOP
         38TdzCnPhFYRzaW9K8tb5+1S4Kji0YiWXIfDp//Db2FkDvw/hBvLRqp3+D++dW57eOSO
         ni5rqKWp39EzbH1/gff0ihHgFcI6LVbQWoB65RMl+XZZZCiTOvtnROphaepCgl4DhORK
         NJQzDDjGpyQYq7gIfa7Yh5lujVoBylCTUR4xE7mx8B9XX90FvEC+w+qclf9uqCDBZVlw
         LGmg==
X-Gm-Message-State: AOJu0Yz2Hovl2dhwNXRxl32aCzCuzQRScw9rHbf7CRRt7Fr5q2l3WX5/
	7uwqS/HbVvRwMbAatFnU/J+y3U2pTouHJLgMCVZ8Xh/idJ5JRFtxnbzH70v02Oe4RFTeCUR3LqY
	Cn4BnyMIa5FlCP+y7K7EgWEbydn1Tpf2KdRWK2bMeKAglAqiLXdzsHIZ6QFFYtyqRqgtk2A==
X-Gm-Gg: AeBDieuuRghJoe2wxncM5XCwl6IgZ8M6Rj/SwaX7LUh5pqWMr6TLngkqJVMgeIdR6t7
	ezZIIMmHAF0dif7J/9knoTE7aKgWhbbklQyZYJBExKgl/e47ytkFUBseTfQGc6sRnv5Wrf2MmA8
	tIuJIBOFSx7wzp5VB4FICT+JvdSFeiJo7TTX0wK5GMULMyyd7mmxO5SwK7KctPU9oQCmzQiYJql
	vzgNV1XVBLLsBbs77nokDoAzVCavsV5FzouJdPUOiqgVYY+48SAkyd3T7FBtUKYBsRO4iuKr5ya
	o7kkp3XC/V/ZmmKxKD1jqleJlML0nEnzfsn+mqPuxWYroCS2zCxA8BDpdad688Dz/5wOcNZ1GCo
	1bPe4TdTfRCGhCYV+EJF5AYbweKgJBBmRfKpFWiNCLnLXoXR4S/os+9smt7BTy82OvA==
X-Received: by 2002:a05:6a00:1d9e:b0:82c:ac06:3004 with SMTP id d2e1a72fcca58-82d0da2ae27mr16676998b3a.8.1775579100225;
        Tue, 07 Apr 2026 09:25:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d9e:b0:82c:ac06:3004 with SMTP id d2e1a72fcca58-82d0da2ae27mr16676956b3a.8.1775579099647;
        Tue, 07 Apr 2026 09:24:59 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d1d6b221csm12125067b3a.56.2026.04.07.09.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 09:24:59 -0700 (PDT)
Message-ID: <53817665-ef49-445f-b549-41bdc7a847cc@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 21:54:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5 6/6] wifi: ath12k: Enable IPQ5424 WiFi device
 support
To: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
References: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
 <20260407-ath12k-ipq5424-v5-6-8e96aa660ec4@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260407-ath12k-ipq5424-v5-6-8e96aa660ec4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0NyBTYWx0ZWRfXxEO55ZCAuQTG
 xAx+vMiFF1YJn6IfIjfKutYtDZHSOgPeY894QEw6xWaXZEJsF8+wrBC0krL4yuffqQ9AB/7dIWB
 gn415t/A/QmHD0H9UhGwqeyXVOktRat476tv8AmlHB7WJ3K7ywL2vEE8YH+qq8lAF5Uqdr+uE02
 N/qWPevxlrwUMIduK7K/GuTjFSKygZpkGwsSfuZbhgi4nkmz7XcrQfLt5r7rAMPE8OOsMyOI1NI
 xQ9pUM5hhWK9ArJ8BP3lTm28YX83FTqAr2O82LZn5a7UkcG7Ua1wL4HLBvA43ZMRFaqUnjiSefa
 GZwIS8Ic+0N8vduwMvnpyyLmOZlzcJvesVefgEk/wnbZWHuOSmRkGDANUSHPtZ9SgbRnoR4dl7v
 No38Ijp29+BZd5pWE3wUts0QZLgz4lQ+6DMWEV7GUKZVwFMjdR1eVKF7X3DC+Mn2MjNYjCMd893
 ry0dwsh6tHmqkyLG0dA==
X-Proofpoint-GUID: 2qLhSIztOWaqbt2Pn_dAxA2xYJ5rtZpj
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d52fdd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=lXj5p0v04NcqoRae9OgA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 2qLhSIztOWaqbt2Pn_dAxA2xYJ5rtZpj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070147
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34487-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quicinc.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F2C823B1DE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/2026 10:56 AM, Raj Kumar Bhagat wrote:
> From: Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>
> 
> Currently, ath12k AHB (in IPQ5332) uses SCM calls to authenticate the
> firmware image to bring up userpd. From IPQ5424 onwards, Q6 firmware can
> directly communicate with the Trusted Management Engine - Lite (TME-L),
> eliminating the need for SCM calls for userpd bring-up.
> 
> Hence, to enable IPQ5424 device support, use qcom_mdt_load_no_init() and
> skip the SCM call as Q6 will directly authenticate the userpd firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>
> Co-developed-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
> Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
> Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/ahb.c       | 36 ++++++++++++++++++-----------
>   drivers/net/wireless/ath/ath12k/ahb.h       |  1 +
>   drivers/net/wireless/ath/ath12k/wifi7/ahb.c |  8 +++++++
>   3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
> index 9a4d34e49104..2dcf0a52e4c1 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> @@ -382,8 +382,12 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
>   		ATH12K_AHB_UPD_SWID;
>   
>   	/* Load FW image to a reserved memory location */
> -	ret = qcom_mdt_load(dev, fw, fw_name, pasid, mem_region, mem_phys, mem_size,
> -			    &mem_phys);
> +	if (ab_ahb->scm_auth_enabled)
> +		ret = qcom_mdt_load(dev, fw, fw_name, pasid, mem_region,
> +				    mem_phys, mem_size, &mem_phys);
> +	else
> +		ret = qcom_mdt_load_no_init(dev, fw, fw_name, mem_region,
> +					    mem_phys, mem_size, &mem_phys);
>   	if (ret) {
>   		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
>   		goto err_fw;
> @@ -414,11 +418,13 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
>   		goto err_fw2;
>   	}
>   
> -	/* Authenticate FW image using peripheral ID */
> -	ret = qcom_scm_pas_auth_and_reset(pasid);
> -	if (ret) {
> -		ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
> -		goto err_fw2;
> +	if (ab_ahb->scm_auth_enabled) {
> +		/* Authenticate FW image using peripheral ID */
> +		ret = qcom_scm_pas_auth_and_reset(pasid);
> +		if (ret) {
> +			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
> +			goto err_fw2;
> +		}
>   	}
>   
>   	/* Instruct Q6 to spawn userPD thread */
> @@ -475,13 +481,15 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
>   
>   	qcom_smem_state_update_bits(ab_ahb->stop_state, BIT(ab_ahb->stop_bit), 0);
>   
> -	pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
> -		ATH12K_AHB_UPD_SWID;
> -	/* Release the firmware */
> -	ret = qcom_scm_pas_shutdown(pasid);
> -	if (ret)
> -		ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
> -			   ab_ahb->userpd_id, ret);
> +	if (ab_ahb->scm_auth_enabled) {
> +		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
> +			 ATH12K_AHB_UPD_SWID;
> +		/* Release the firmware */
> +		ret = qcom_scm_pas_shutdown(pasid);
> +		if (ret)
> +			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> +				   ab_ahb->userpd_id);
> +	}
>   }
>   
>   static void ath12k_ahb_init_qmi_ce_config(struct ath12k_base *ab)
> diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
> index be9e31b3682d..0fa15daaa3e6 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.h
> +++ b/drivers/net/wireless/ath/ath12k/ahb.h
> @@ -68,6 +68,7 @@ struct ath12k_ahb {
>   	int userpd_irq_num[ATH12K_USERPD_MAX_IRQ];
>   	const struct ath12k_ahb_ops *ahb_ops;
>   	const struct ath12k_ahb_device_family_ops *device_family_ops;
> +	bool scm_auth_enabled;
>   };
>   
>   struct ath12k_ahb_driver {
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/ahb.c b/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
> index a6c5f7689edd..6a8b8b2a56f9 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
> @@ -19,6 +19,9 @@ static const struct of_device_id ath12k_wifi7_ahb_of_match[] = {
>   	{ .compatible = "qcom,ipq5332-wifi",
>   	  .data = (void *)ATH12K_HW_IPQ5332_HW10,
>   	},
> +	{ .compatible = "qcom,ipq5424-wifi",
> +	  .data = (void *)ATH12K_HW_IPQ5424_HW10,
> +	},
>   	{ }
>   };
>   
> @@ -38,6 +41,11 @@ static int ath12k_wifi7_ahb_probe(struct platform_device *pdev)
>   	switch (hw_rev) {
>   	case ATH12K_HW_IPQ5332_HW10:
>   		ab_ahb->userpd_id = ATH12K_IPQ5332_USERPD_ID;
> +		ab_ahb->scm_auth_enabled = true;
> +		break;
> +	case ATH12K_HW_IPQ5424_HW10:
> +		ab_ahb->userpd_id = ATH12K_IPQ5332_USERPD_ID;
> +		ab_ahb->scm_auth_enabled = false;
>   		break;
>   	default:
>   		return -EOPNOTSUPP;
> 

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>


