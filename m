Return-Path: <linux-wireless+bounces-37268-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G1zJnSxHWqOdAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37268-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 18:21:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA946227CD
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 18:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 538C6310CA93
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543AA2EBB89;
	Mon,  1 Jun 2026 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HEAx/FOL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X6G6Bf42"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA42EA154
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330162; cv=none; b=nYH+8dQUnzVY6iDuNWvtfJUTDV9kVkroKe1/hfMKSfU1emCyz7Nkk0bI8aKZG8M0CREEAGl+B7grpueai8tUtf9341fG6BWbEyzo+KUHa3iXRMYSB8Igp4gUn3u1gyOUP9nafQgtEjywUM62+OIYYXV/8HhbS2zczndPHAE8jG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330162; c=relaxed/simple;
	bh=bGnsh7o7wBgoQXtnQxFsz4RoWlKXrVOgieSjjFPrIQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mb740hvIEcpoCqIbxUaSxun6GdpjL/NqiIaSLBh8soZz8jbhJ7sR7YzqH3etoul45Os0uBb7qUoWuVUt8Tg6gO/GGtDrsItlOah2RkpX9HQafnE3U8X1Icq1dw1Jp47uZ8ir+4EExeMhTjevbH0TNHzea4gjjLGN/p+p3dXtgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HEAx/FOL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X6G6Bf42; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651EZJEK2740421
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 16:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r85YYvRXUgeOdHZjMqt3osRrQ3RltXHNQbceWHFhVYg=; b=HEAx/FOLtHxgirbF
	1kbN8Aa2p+KUzYqfOBHMc/lKglW1x2tkH77zMxhRPuI+gArY79zFQ0QqTa3iC8CA
	Y9lMJFkrsRkTRGUI+CuRGsEXQ2IZDi41sBhBid5PaJwKno4Qq3c0qg/KawMX61Ei
	P8Svvk3Fg9Nj6ciokF34prsgNqCZPs1VYYFi2D4aDnQVsi2b38h1qRtoQAF7gttj
	GguoBOk9qcKKWD7gDjJnh1Z8upZiR3PeXVruChS2LWyzLtgWyUK5TmeUl/AzHx1s
	G5X1ODB2yeQuf24UsDhoIHQg8kKEh9UUm+g942EOKgsxz6fUOS3N5L08Kf6zVjzs
	x2ltwg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sqhw6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 16:09:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304e7fbfaf5so3589698eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780330158; x=1780934958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r85YYvRXUgeOdHZjMqt3osRrQ3RltXHNQbceWHFhVYg=;
        b=X6G6Bf42HOFIHISD3gQDqw+PH1pqKsx1Cpq6qk531xwLEuB3Jq9076Ay580dSH32r4
         fV83iBx7j2ih9yvSndT5Mh2fmpK4NKfq5xiA4L66OT9AEDb/3dhJiKdJGEq05fOtztWP
         p+HEhGrwLMoioRDUtokzT04EzkahAT2LqFQ+YGbO9Di21aZeYl4CeQSZ+BAQpldr6tjU
         mFLwMURnEnRrChrAoN6B+eUYMgGrNUm8/GvbHPeAFDf40l8vWTxD2BiSVMLGaN+3+6zE
         6D9JvSTCcMToHVyU9IQ+9zuT3j9mRdJwJXWtDAkQVhqBU0QKCFP8ZqQ9KyI8aH3vfN9A
         gu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780330158; x=1780934958;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r85YYvRXUgeOdHZjMqt3osRrQ3RltXHNQbceWHFhVYg=;
        b=VUszJtRTNkj5XkkC29VtkMNv9VJ/0r/9jBBaCb3tOs12QtahkSEs2qKU//CJdZoahi
         BR1fWzeBSkV29dpbud0Z0xXtL5w+y8y258A64hHmuOp8NiJCMNUubgbV1Ir6DtTaWuTD
         hj0bMlBPNGePTIh6gxaQZehWwPzXtzyx2PBUJieTmGEsoJTcIAlJZ7hcjqJvFjB/O6Xq
         a4GBgdSV72JDJ9U3gJ/UPVtxSm8Aw52UDmMGQrynODLcNfVTVfigfchQxvQJ7HXJZx2d
         ao1mfkKepB9OhkL/0eew4Wsi+rsKU9W+4qKxPkO4e1h7yl4nmeZ3zo94z3inzu4Fl5Rx
         re6g==
X-Forwarded-Encrypted: i=1; AFNElJ+s2SNTgdEEa5C5Gxmt/f6yvegmQPzUO4KY262OqVSEKwu2mLHUnn9Jh2PG9D5zbE0DwDXdkPndWncCWkRBhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAMI32NXnykU5hbHqLnTrlOMeWwrJ5Y2aLoxKs9E3qiZIRMwN
	497OJqXVBBokkx+F6FD5ToKttWztOGmXDl3R0I4rLbYxVW8MaW2/ZAMTY9vzlKUkKsFQJsZ7qVJ
	xDS2nA7R7OHckoZHUSabnz6PeAe7IYL2rOeUDDWDZDoxQkK6dBYYBQClDufZOdHmewkKnEg==
X-Gm-Gg: Acq92OFXL2w0gZmqwWUxWg3+ewyf7UJPbHgGUnubivhOfsfhfnCDdRCZmsqxnflSBBP
	mD0YZrI8HOrJjG4T4DUDofMB9zxSiOvH10G1bXjlfBzPPWsUCRZEI/R70KJCPYlSYE66BvSpfcv
	N9SDnl6JJ8575TjuyIcnFXKV/sTnaq4bYByHwxGZmyncBGk6TeatVzMJp+KQoJR39rKE7fvpZHQ
	T/eRA+lMLVo7E5Vchc+aeQt9SGxrUV7eQymQDl72E/8A9kZKIJaMWFKgphbNOl2hcIN2UeMKCDG
	e1y6s2zMtlRQJw8Bv5ECzGptFHNH0wCpUZh4Om7x+mu5w14Cl0ZCuXWKnAE0D7dU0VLup1LU13A
	xbF+Bap4xTmwjWTeewtSOzwPJkDrCqMRLFw0DimN0UwfCJ+mqKZm2I/dDH7FsrJMILbYPIpbA4i
	1z1H4nDyKe+h09C9n7
X-Received: by 2002:a05:7301:6a18:b0:2ed:e15:c926 with SMTP id 5a478bee46e88-304fa69c7ffmr5559223eec.34.1780330158258;
        Mon, 01 Jun 2026 09:09:18 -0700 (PDT)
X-Received: by 2002:a05:7301:6a18:b0:2ed:e15:c926 with SMTP id 5a478bee46e88-304fa69c7ffmr5559188eec.34.1780330157690;
        Mon, 01 Jun 2026 09:09:17 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5f6426sm9016059eec.31.2026.06.01.09.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 09:09:17 -0700 (PDT)
Message-ID: <84b140b1-1060-47ad-ac3f-ecaea7f97d40@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 09:09:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/2] wifi: ath11k: fix invalid data access in
 ath11k_dp_rx_h_undecap_nwifi
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
 <20260512022351.2033155-2-miaoqing.pan@oss.qualcomm.com>
 <f89f90ea-a9f2-4f1c-b55f-2b77ddc505e1@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f89f90ea-a9f2-4f1c-b55f-2b77ddc505e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iDFm8pH3yynBG42PIqakGiXNDFdmSAPs
X-Proofpoint-GUID: iDFm8pH3yynBG42PIqakGiXNDFdmSAPs
X-Authority-Analysis: v=2.4 cv=eqnvCIpX c=1 sm=1 tr=0 ts=6a1daeaf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PbU15OE6me5PO1c1xRkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2MCBTYWx0ZWRfX1C/vMbdwAUDb
 NnvGZ1tAFsMveTEU8rwRpVXR83LVti8yOtcHKVzq8LTyd7C7GRqr7knShnejkUtRqrcJLNqeVyt
 XFUxil6gBodC7z6ddQviPIiJKwsjwhK3QpNa8GirDsept4ZrKvOSPqYEC/9BKQN3X24ze8zJeOP
 TEhhCh5UyF0+uENg+eSnUdUEozD7OdX6Y1tjKPUDnG5DJx0D6mDK6mmCilx1a8UwW1yM9EGBS7t
 JAVrG7/dScRbwFqdXJ6CsRSBt5P4wzFwPMF0Wz5u8t5ynruz918VdoEKb7TxdxwNgW/ep2D++OD
 agqzlRe2o0tea29fXC5gU4wOnY2/IdA0W7+QCJ/mmq4/pzktK8Jk/OLFQQXXt3pF3AcG/CcgZnU
 wcxgvgUbnzzHEC9l/aKj10Sl7mHS2zYLr/liUMpa+hXLb5El8h7CP5r/HKDu4LK635P93Qgd9ch
 Smr2nV98HAOGWRJF/mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010160
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37268-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0CA946227CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/31/2026 8:47 PM, Baochen Qiang wrote:
> 
> 
> On 5/12/2026 10:23 AM, Miaoqing Pan wrote:
>> In certain cases, hardware might provide packets with a
>> length greater than the maximum native Wi-Fi header length.
>> This can lead to accessing and modifying fields in the header
>> within the ath11k_dp_rx_h_undecap_nwifi() function for the
>> DP_RX_DECAP_TYPE_NATIVE_WIFI decap type and
>> potentially result in invalid data access and memory corruption.
>>
>> Kernel stack is corrupted in: ath11k_dp_rx_h_undecap+0x6b0/0x6b0 [ath11k]
>> Call trace:
>>  ath11k_dp_rx_h_mpdu+0x0/0x2e8 [ath11k]
>>  ath11k_dp_rx_h_mpdu+0x1e0/0x2e8 [ath11k]
>>  ath11k_dp_rx_wbm_err+0x1e0/0x450 [ath11k]
>>  ath11k_dp_rx_process_wbm_err+0x2fc/0x460 [ath11k]
>>  ath11k_dp_service_srng+0x2e0/0x348 [ath11k]
>>
>> Add a sanity check before processing the SKB to prevent invalid
>> data access in the undecap native Wi-Fi function for the
>> DP_RX_DECAP_TYPE_NATIVE_WIFI decap type.
>>
>> This adapted from the discussion/patch of the ath12k driver [1].
>>
>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
>>
>> Link: https://lore.kernel.org/linux-wireless/20250211090302.4105141-1-tamizh.raja@oss.qualcomm.com/ # [1]
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/dp_rx.c | 50 +++++++++++++++++++++++--
>>  1 file changed, 47 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
>> index fe79109adc70..fbe2061a544d 100644
>> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
>> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
>> @@ -2502,6 +2502,29 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
>>  	ieee80211_rx_napi(ar->hw, pubsta, msdu, napi);
>>  }
>>  
>> +static bool ath11k_dp_rx_check_nwifi_hdr_len_valid(struct ath11k_base *ab,
>> +						   struct hal_rx_desc *rx_desc,
>> +						   struct sk_buff *msdu)
>> +{
>> +	struct ieee80211_hdr *hdr;
>> +	u8 decap_type;
>> +	u32 hdr_len;
>> +
>> +	decap_type = ath11k_dp_rx_h_msdu_start_decap_type(ab, rx_desc);
>> +	if (decap_type != DP_RX_DECAP_TYPE_NATIVE_WIFI)
>> +		return true;
>> +
>> +	hdr = (struct ieee80211_hdr *)msdu->data;
>> +	hdr_len = ieee80211_hdrlen(hdr->frame_control);
>> +
>> +	if ((likely(hdr_len <= DP_MAX_NWIFI_HDR_LEN)))
> 
> nit: Double parentheses on likely()
I've fixed this in the 'pending' branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=99f35f3f082fca14fc3324e48abd805871d39c69

