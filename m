Return-Path: <linux-wireless+bounces-35957-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGBfGQdw+mngOwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35957-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 00:32:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D150B4D45E3
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 00:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF566301AA88
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7FF175A80;
	Tue,  5 May 2026 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MmlwDAih";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YH+Xa7XD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72E175A7B
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020354; cv=none; b=cnR3tclMofrMgMoHPOxO4LRlBsruLZiReg6sVlV1uFSKIhDhQiQXklLVjGZge+fKBxR/31FdFq8hTn0DVU1KKnskQXtar9TKwzRlw3quTWu/BGbE3DuZqYT1VWXg0S1coN7McYBeUO75eDQjeD+QWZ2k2CDB03RQ8/FQZfeG7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020354; c=relaxed/simple;
	bh=qwRyyrtpKHVPVLPR/Qk5rBLsShvuyIaH12lOQO993Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKZO0MwvrrRpE6jadCFLHccmZ+qci+jtOEL88NWPseb9NHAPnqcko5BN29UKgbVNeAXehQ5nn/F7YQdPV4G7laVoO6lwA0gYGtX5/twl5vUfGXKOfQY93UUVa/wqhp0ctLl6+OEhdSq8QtGLj7FHb1pvdjV0G8wGEhBeiAR9AwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MmlwDAih; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YH+Xa7XD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645G440T3741203
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 22:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZaJWnG2TUmYaXY/GqVPohLhTNo2BQ8ByiLvDOJZwP7s=; b=MmlwDAihjhVpWPIN
	KEMyT5XqozxLP06Y7Cn8o7Tpg+QlkhfqDmq0yAyX5QBGzYyLpJ5lrOdQUqcPJe+h
	3owMCecyLBTKAB+YiO24jL4mkbucjQHzvEss36ZJzkaMtbAuScP8iwo5pB1Osq+g
	eG+nh10+JS5On7clRmdiEh+eSYRHXgmYxrzKiPwyYMYjWG63ayCgtDzw3TxJ6alh
	BjxGoRHhJkrUZ3esbz3wj6q6dHYV4fSTtnFh5AXFaZvuXQjOj0VS1dmOQqRve+vS
	Wc2ooLpEWG5uGAPUhoz5lfExVGmpwfHTdHMu3qbTpQKCytLrSvL98rspTb5/dkvK
	s0bKLw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyefqauyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 22:32:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b81ff82e3cso193440eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778020351; x=1778625151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZaJWnG2TUmYaXY/GqVPohLhTNo2BQ8ByiLvDOJZwP7s=;
        b=YH+Xa7XD29XL8gJfINtkzqHviQw0es+EiBmsvf5M+Lju1ks9UpEGaF6z56ENiH6egN
         ATNH4lo55qt153/sEbOreVyH6/bh5HQFyzTwGOsGUUTfWvrOAEKc3V8fkHGzCI1Uju0k
         7SSYeZ6l2IdLAD16J7P7dpU1SCRYMRDUsNL0CnrQVaIiTjinEEHhzj1QvsTBpKFjel0z
         CpFZ/Xb9bb21Wbjrtuvf+RNlvWXV2TcsnenhIxQ/ictsP44XU2Jzt4zqRd+G/DbhccJ5
         GOXX/2jvhYnEkinEU8ecEcEqtwWlkTrvOazs7jyKp5ktQ59JO3hrMdhJEnbqXsUVe7v/
         4bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020351; x=1778625151;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaJWnG2TUmYaXY/GqVPohLhTNo2BQ8ByiLvDOJZwP7s=;
        b=nX+jf9FIkyAuySZtVu+5oXYbHDhYrN1iXByVcfjYmUg4RpMV/RHc7ZHhFWNO0d9mA9
         Mi+ggEJm15xurMniMVNKTOibTf+Yf2pV40I8usbv5bITaGUDfKsO94+sbsNQo/gUrYdH
         qScAhylhHqPBfWYWSUDEs24zMf3WWHBMblBRrZ4QyhA3puMYG+Gz6ZHX+fVkksWKC3Sg
         daRdBng+Dqj/rQWWCMN0nsGb7TNfb6NdcIZZVkPW7YDWQkkyltRX8IzggaFh7Bv03pJ6
         1VsgJgfNQokF0G4bz27xifAWNueQBibXj45pVq6ekWw6n0DEuJSHRs0TuLWGJNTFKcp4
         jRfA==
X-Forwarded-Encrypted: i=1; AFNElJ/mJmEPyBUsr2s3/QNWhm2ngbG+YNj8XZ4CipEi/EZkBJVy6z6ItkBrpFvhp0RC4aB2jf0yiNyVDyt+BLtGhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9+7ACikuKyKH25SytaqTSsnhacDPHEiCb2ONfXUSKAn4Ilss
	jFlv1KZFz7x3IRLJcuJo7A7EQO1NDnPxy40Rbc0AXUIoMF3vYgkFl5NBe0FxLkG2yUkzAdJq1n4
	9LXqhH+w5OulyLI/o5Sin5KC31vaxR+7zzSGIFp1nD2re2o48QFiNbedn8xyZ2E6m2CQvxA==
X-Gm-Gg: AeBDiesSlivCSsiahx+XhbHjpB8SEt5gwXUM7sCvb1FIToyU1+g3SA6xiBicO+Jes7z
	z7u8dpJfhLr3avzHIeYTvORw07sLb1nkpIy1opDMriG0iGYTO3dKqO4RmdcuP0R2dJnFlFmvwUF
	AzZVkZiS4x/+e6q1d75ynIY6cGVjMKr7LUXdLKxTBfT0/U1ipB3h3DITZ4/RYA1pvXNsxrGTr5b
	3Sdf7GQ7K9cUPQunQSvaCTHPiIh+N3ZqpIioNxY4dVjzXDYkhE5s66O/ubAs0681xq5jxjUpp8Y
	3rkfHxC8+tMSiPHMB2xVVS7uV//RPDNIO0Efw2NiRoyExSvrppkRl8S9OLlTxwXuIogdmEL62/d
	Iz7NQ5erVPrf8aKMSW/21mvVmqGffUcHSGG775YCJ8AQFUzLnRdlL6f58Lbew0+wCPDto7xVcFx
	9W8NbbrtZB4ZKa6Dgil8PrvDHD
X-Received: by 2002:a05:7300:b10b:b0:2f3:b7b2:cbd3 with SMTP id 5a478bee46e88-2f558c796cdmr353928eec.5.1778020350680;
        Tue, 05 May 2026 15:32:30 -0700 (PDT)
X-Received: by 2002:a05:7300:b10b:b0:2f3:b7b2:cbd3 with SMTP id 5a478bee46e88-2f558c796cdmr353915eec.5.1778020350020;
        Tue, 05 May 2026 15:32:30 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec592asm937403eec.5.2026.05.05.15.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 15:32:29 -0700 (PDT)
Message-ID: <32843bc8-15c3-4b18-8044-b0466b9223a9@oss.qualcomm.com>
Date: Tue, 5 May 2026 15:32:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: ath11k: fix monitor mode frame length by
 using correct descriptor size
To: Praneesh P <praneesh.p@oss.qualcomm.com>,
        Joshua Klinesmith <joshuaklinesmith@gmail.com>,
        linux-wireless@vger.kernel.org
Cc: ath11k@lists.infradead.org
References: <20260407024836.53871-1-joshuaklinesmith@gmail.com>
 <299f83be-748c-458c-be07-df6a0fe02f38@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <299f83be-748c-458c-be07-df6a0fe02f38@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIxOSBTYWx0ZWRfX/dL6HggUnjTj
 OiJ+gV7BIvvpjloWf+X/hL6wvB+jl0Qix1Ara/LwFY/TiTpjcL/vZ92ZQlZ6E7EUILynbPo+RWV
 kBjr5N8ckAgbo8ZtMQX9dApV1BA/tg0B6Of0ovSsIN0xBzYQiqLB36wjcTj04Fn+DGuMj9qXJKU
 WxtlwIlW+2lCWn+cdVJLI/HVfX+KgDyW8AXhedxNQMUDuYa+MqZyjTDB3NseSxtMgqaJcknJoq4
 HoAn4nUTBfnEAYx39J6eKBX09ESXAhc2jhuW6VMdD8WmlltYTQVE0Sm4l/+oCwEKnSpRSZMnlYo
 1mqyModZw9RLP05ve5i/2vUSNVeV2fzcwjYPNiFMvVj6YgbmdvUHi7SIvczsEIjzVzP+UAXmufC
 GzBDavvPISEiqqXzMS+CDiRQXN5OWQmSBvLfGDpkjN/Id96wf/hYDbLwxGxmxB2q1Ah2A6760q2
 cziX0W8uc1ANpkpIipw==
X-Proofpoint-ORIG-GUID: v-7LBYNCeSe-PSHQi98RmDXDsJZlaGxI
X-Proofpoint-GUID: v-7LBYNCeSe-PSHQi98RmDXDsJZlaGxI
X-Authority-Analysis: v=2.4 cv=edoNubEH c=1 sm=1 tr=0 ts=69fa6fff cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=8pGESeWOdjOF7JQ2IL8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050219
X-Rspamd-Queue-Id: D150B4D45E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35957-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/29/2026 2:52 AM, Praneesh P wrote:
> On 4/7/2026 8:18 AM, Joshua Klinesmith wrote:
>> The monitor mode RX path in ath11k_dp_rx_mon_mpdu_pop() and
>> ath11k_dp_rx_full_mon_mpdu_pop() uses sizeof(struct hal_rx_desc) to
>> compute the packet buffer offset. This is the size of the union of all
>> chip-specific descriptors (the maximum), not the actual descriptor size
>> for the running chip. The later ath11k_dp_rx_msdus_set_payload() then
>> strips only hw_params.hal_desc_sz bytes (the chip-specific size) from
>> the front of the skb.
>>
>> On IPQ8074 and QCN9074, sizeof(struct hal_rx_desc) is 392 but
>> hal_desc_sz is 384, leaving 8 extra bytes of descriptor data at the
>> end of every monitor mode frame delivered to userspace. On WCN6855 the
>> sizes happen to match so the bug is not visible.
>>
>> The same mismatch in ath11k_dp_mon_set_frag_len() causes incorrect
>> fragment length calculation for multi-buffer MSDUs, under-counting
>> intermediate fragments by 8 bytes and over-counting the last fragment.
>>
>> Fix by using ar->ab->hw_params.hal_desc_sz consistently in both
>> monitor mpdu_pop functions and passing it through to set_frag_len.
>>
>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>> Link: https://github.com/openwrt/openwrt/issues/16183
>> Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/dp_rx.c | 27 ++++++++++++++-----------
>>   1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
>> index 85defe11750d..c86ffc203f15 100644
>> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
>> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
>> @@ -4511,10 +4511,11 @@ int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int mac_id)
>>   	return 0;
>>   }
>>   
>> -static void ath11k_dp_mon_set_frag_len(u32 *total_len, u32 *frag_len)
>> +static void ath11k_dp_mon_set_frag_len(u32 *total_len, u32 *frag_len,
>> +				       u32 hal_desc_sz)
>>   {
>> -	if (*total_len >= (DP_RX_BUFFER_SIZE - sizeof(struct hal_rx_desc))) {
>> -		*frag_len = DP_RX_BUFFER_SIZE - sizeof(struct hal_rx_desc);
>> +	if (*total_len >= (DP_RX_BUFFER_SIZE - hal_desc_sz)) {
>> +		*frag_len = DP_RX_BUFFER_SIZE - hal_desc_sz;
>>   		*total_len -= *frag_len;
>>   	} else {
>>   		*frag_len = *total_len;
>> @@ -4658,19 +4659,19 @@ static u32 ath11k_dp_rx_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id,
>>   
>>   static void ath11k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
>>   				      bool *is_frag, u32 *total_len,
>> -				      u32 *frag_len, u32 *msdu_cnt)
>> +				      u32 *frag_len, u32 *msdu_cnt,
>> +				      u32 hal_desc_sz)
>>   {
>>   	if (info->msdu_flags & RX_MSDU_DESC_INFO0_MSDU_CONTINUATION) {
>>   		if (!*is_frag) {
>>   			*total_len = info->msdu_len;
>>   			*is_frag = true;
>>   		}
>> -		ath11k_dp_mon_set_frag_len(total_len,
>> -					   frag_len);
>> +		ath11k_dp_mon_set_frag_len(total_len, frag_len, hal_desc_sz);
>>   	} else {
>>   		if (*is_frag) {
>> -			ath11k_dp_mon_set_frag_len(total_len,
>> -						   frag_len);
>> +			ath11k_dp_mon_set_frag_len(total_len, frag_len,
>> +						   hal_desc_sz);
>>   		} else {
>>   			*frag_len = info->msdu_len;
>>   		}
>> @@ -4792,7 +4793,7 @@ u32 ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
>>   
>>   			rx_desc = (struct hal_rx_desc *)msdu->data;
>>   
>> -			rx_pkt_offset = sizeof(struct hal_rx_desc);
>> +			rx_pkt_offset = ar->ab->hw_params.hal_desc_sz;
>>   			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, rx_desc);
>>   
>>   			if (is_first_msdu) {
>> @@ -4823,7 +4824,8 @@ u32 ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
>>   			}
>>   			ath11k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
>>   						  &is_frag, &total_len,
>> -						  &frag_len, &msdu_cnt);
>> +						  &frag_len, &msdu_cnt,
>> +						  rx_pkt_offset);
>>   			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
>>   
>>   			ath11k_dp_pkt_set_pktlen(msdu, rx_buf_size);
>> @@ -5424,7 +5426,7 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
>>   
>>   			rx_desc = (struct hal_rx_desc *)msdu->data;
>>   
>> -			rx_pkt_offset = sizeof(struct hal_rx_desc);
>> +			rx_pkt_offset = ar->ab->hw_params.hal_desc_sz;
>>   			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, rx_desc);
>>   
>>   			if (is_first_msdu) {
>> @@ -5439,7 +5441,8 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
>>   
>>   			ath11k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
>>   						  &is_frag, &total_len,
>> -						  &frag_len, &msdu_cnt);
>> +						  &frag_len, &msdu_cnt,
>> +						  rx_pkt_offset);
>>   
>>   			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
> 
> Thanks for fixing the offset handling in the monitor Rx path, but still 
> there is another instance that still relies on sizeof(struct hal_rx_desc).
> 
> ath11k_dp_rx_h_ppdu(), which is also invoked from the monitor path, uses:
> 
> ath11k_dbg_dump(ab, ATH11K_DBG_DATA, NULL, "", rx_desc, sizeof(struct 
> hal_rx_desc));
> 
> This should likewise be converted to use hw_params.hal_desc_sz to avoid 
> dumping beyond the chip-specific descriptor size on platforms where they 
> differ.

Joshua, can you submit a v2 that addresses this observation?

/jeff

