Return-Path: <linux-wireless+bounces-35593-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKaqJvLi8WlZlAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35593-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 12:52:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 249964932F2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B715D300B624
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EB022689C;
	Wed, 29 Apr 2026 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c27k3Ryx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GAKXUkjh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C282D7D27
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459652; cv=none; b=qVKBsMRCsIbBKKpW2rXBJkzjJvqpbAsxyEmVoktVIVDH3ohzJ6D3Hawo/5camXcfZZdJcPK5KlzP2oGga09lfm4KiDC/FypdjXxgFqbXH7EAdut1/c1AYU/M+Hh0Tp5laKhRaLGcDmWCoYi56kagJV+VlAlEPaNwlRla+0B8i0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459652; c=relaxed/simple;
	bh=iXwIgo+CDgQrzSeSZeqT53aIvgq10SsRqbd0Eq8v7gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzcMb9TWP75Pt7YgXL2E/cqGPDmi1pXZnGG0PACSj7xH1o9mOEJ2vD6rW+00YI9/7i+EhBYtqc5MwGTZBhKYqUlHe9rKlY3kLrmC4xFjXsu8pT2518OUwkbssIhl6Rw11i7iHcXxF3/u7Z+VbEl32pjVTpGF0xW5ewV3TIp3Hno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c27k3Ryx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GAKXUkjh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qEx73066918
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 10:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rxVEKYY0dWTGsyxKYcIlCqWw+5zr0t/mtNf6F1e0geQ=; b=c27k3Ryx//VaQ5A7
	DL7wWwca+Zmq5GMroQfryHSwRzDUB25vBKdDdw6k8+2NeKre17Y4PhnlgjxUjGck
	B9agAIg4e/IzcpijX259856DwvhtzSY8COhX6s8wq+GuUBP6Q6+K1C4A/0RZVexr
	QPFlFtwOPJi6dG9dObEL/XdE4t1KWQA0/8iDJ2oB6tz5vKxRtAg0Hmm8HM1J2zas
	tBLr2TSt8S+jqi2aU7X3wfIBZsgQWhK7WLgVrNNEgRA7VAXzds9H3xcLu5KFmZ/B
	B+k6oe8wy2PM4MZVPqLbz7h+jh4cdeewXqjtvhy7ZJm6nYtCduBDqO7QTmweruxx
	xyhKyg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxa4n7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 10:47:29 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f71437218so8216108b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777459649; x=1778064449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxVEKYY0dWTGsyxKYcIlCqWw+5zr0t/mtNf6F1e0geQ=;
        b=GAKXUkjhFcY6j+14rZM6Ux6H2UgQrbNhzIkux4uwX5CH+Yev85Nzr4aKxHcSD+7UUP
         PIujsqxzgKjTuoq4xEuuca2W8a/nQ5ta/G65wAqr4Fqg46yGryPc+I1lxPR6aYp4K4zV
         rPNYs3gA+DtLprXVj0AY0/ZAAuVaZyumhNKZwfkX00lLwv9eY4fJmw8tA1H7+E9sZRH6
         DZ93R9nvNyNZWcucS6E90CKnDlQjqAKFK1ulwwogWDNR2k1jTyo+8LM6znznxN6/tOzV
         j4lGgaps0dI4BKGANFMygrKoezbpjXEyvgdwS+jnMR7u3xg1SqPamdwKtK+Emzucjmmu
         1Xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777459649; x=1778064449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxVEKYY0dWTGsyxKYcIlCqWw+5zr0t/mtNf6F1e0geQ=;
        b=L5SOw6Uzhe30xAhBTdAhZT+sMnAaIsw4cB1y1K0ZSZXzGdAyYd7JIendSBqtcn1Urb
         y0CljV+0ZpA77RTCm87LA6V7sJ6EJ/VSy6EglNPewG3oK/bpoypeSNrtFKrTq8ykObWi
         ZJpsjuJxgDPIy2vFWKyx1fmzMRvhb1d7wL760+WMeMTTFLEycLV6We/zlra1jud66gQX
         JWID8bRGvI+MGD968eXeM+bJfpgUkSAhf1MIDfFfptrUkvBTicohN9vneuh/sd/BXIp+
         GS/h6/moSvPzIF1VW7EznN2aq2upweUWvtK9Zv+2DwvkYyrM3frnk9ocNzAVjOl+90j3
         fs0A==
X-Forwarded-Encrypted: i=1; AFNElJ8ZRu869VKRsoPyXs9T0wIMrIsB7EE4xaAG9gzAUzO/GI7Fc+6WZPGMtIjcJYEnbJSn7LIKwiJjVONqLtWKYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7/pKPcBL6l6VvA+u7sMxRca6Hq1LD3ZGkoaa0DutNPDJyYiQz
	CvGzYwa44bi+t1blcdApUtz/1Frk/qzrvEDPfM8+LjLcaDc0OdCkvaiUzOsr6oVcbsVL0fhT02P
	Nq/dZiCPdZgtvHH4IKXe4sctioLbaWksVRyYzfk0OtUaGWOKYjSHLNTiEleNqO+kSRCsHQw==
X-Gm-Gg: AeBDiesxTIIYDjSbIUIKn0tp5fGsoJ01rdwNKBrSULtg+9jwVS1aSvVQEmd5PAJcbi+
	L+Hfto7rVudlf9unxarRFC1U08Akb4pRwPYVzEikCl9aKzARI83svbZWM4PuJzIZMcQHZJwYpuB
	l9Lu+f+mJ2ByK4GvPY+v772vkSnWYaLDFdw0r3NY1nsG+Toz3H74Wo8VFhuEHe+Ru7ueBu36zPx
	5/78proSGwMPgXWQx8SoMhVKezG+VSCUScjm2C9ffUCpmV/jMlqcayC6D2IQ2yEu1ezWIuX+0X0
	KP7ERAcNhC/dLz0FEvAt+pF1dwZOKHzQhn5GxZJcg6pr35v6f8G+S/m2hPSogQIs2ilYpNQLYMU
	XXDkGphaYAY6rrK5Z0sPptnlcrsIeXq0o9iI+uKnjOxRoJig3VUYt+a1ydoRi
X-Received: by 2002:a05:6a00:440f:b0:827:441a:c970 with SMTP id d2e1a72fcca58-834dda62f5cmr7028206b3a.6.1777459648645;
        Wed, 29 Apr 2026 03:47:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:440f:b0:827:441a:c970 with SMTP id d2e1a72fcca58-834dda62f5cmr7028175b3a.6.1777459648170;
        Wed, 29 Apr 2026 03:47:28 -0700 (PDT)
Received: from [10.152.204.131] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm1642551b3a.54.2026.04.29.03.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 03:47:27 -0700 (PDT)
Message-ID: <e248e911-d317-41ee-a590-1385c39ee2e1@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:17:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath11k: fix peer resolution on rx path when
 peer_id=0
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20260424-ath11k-null-peerid-workaround-v4-1-252b224d3cf6@collabora.com>
 <530a9e0b-ae5e-48ae-a2c8-73152e2dd6df@oss.qualcomm.com>
Content-Language: en-US
From: Praneesh P <praneesh.p@oss.qualcomm.com>
In-Reply-To: <530a9e0b-ae5e-48ae-a2c8-73152e2dd6df@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pPT4PIxxKokc6ayoBdHfXPn6RUW32KnV
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f1e1c1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=_3_nlreopyH617X7MHwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=FO4_E8m0qiDe52t0p3_H:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEwOSBTYWx0ZWRfX1mLE9l0qZnaK
 mUK187DIwBR/IiBcSuufpqm3L9OzVrvAegImAXwBLZwm2O1nVxgQ7PlFONmAgm9AHdEbXK67Ibi
 Kaoaq5PMNLSrQTllwHzqG2guycNlVsjy/2rzsgM1+Hu6oN0kwosuRxDPwznzxKCB51kSOoFvYtL
 xyk/hgglNePP6tZR7Am+lSrWVSlKUfFPyzwJVWi2Q9HGX5QujdV+8d3MD4sD4gos8Bhn6SXvCCE
 4B+oju2ntOIHStY82StXFj1iLd99jJ09CSkrHfg5UDe8g4+NwkSJOm1HhuO68TtBjhPSWNHAkCt
 gH/NwazUzoWE0NpSdZP7ven183905HENULaZLUlgjVl2NtBTts31YnFUJ0fJUb30JDN7+dSVxtl
 dzZSRLcn/NSpb/DnNCuqiTWhUrwUQEO+wRFbeYgsQ5xVO5l9pz+ZOr4KMY797otia0MHhKnvYpS
 53WsqyOkJaZHY0nNm6g==
X-Proofpoint-ORIG-GUID: pPT4PIxxKokc6ayoBdHfXPn6RUW32KnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290109
X-Rspamd-Queue-Id: 249964932F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,infradead.org:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35593-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]


On 4/29/2026 1:06 PM, Baochen Qiang wrote:
>
> On 4/24/2026 5:50 PM, Matthew Leach wrote:
>> It has been observed that on certain chipsets a peer can be assigned
>> peer_id=0. For reception of non-aggregated MPDUs this is fine as
>> ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
>> based upon the source MAC address. On an aggregated link, the mpdu_start
>> header is only populated by hardware on the first sub-MSDU. This causes
>> the peer resolution to be skipped for the subsequent MSDUs and the
>> encryption type of these frames to be set to an incorrect value,
>> resulting in these MSDUs being dropped by ieee80211.
>>
>> ath11k_pci 0000:03:00.0: data rx skb 000000002f4b704d len 1534 peer xx:xx:xx:xx:xx:xx 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 1 last_msdu 0
>> ath11k_pci 0000:03:00.0: data rx skb 0000000038acd580 len 1534 peer (null) 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d00 fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 0 last_msdu 1
>>
>> Remove the null peer_id checks in ath11k_dp_rx_h_find_peer() and
>> ath11k_hal_rx_parse_mon_status_tlv(), allowing peers with an assigned ID
>> of 0 to be resolved.
>>
>> Fixes: 2167fa606c0f ("ath11k: Add support for RX decapsulation offload")
>> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.9
> Tested-on: is not an official tag but is ath driver specific, so generally it is put above
> all official tags:
>
> Tested-on: ...
> <blank line>
> Fixes: ...
> s-o-b: ...
>
> But since this is trivial I think Jeff can make the change when he merges it, so no need
> to respin just for it.
For QCN9074, IPQ8074, IPQ5018 and IPQ6018, Peer_id 0 is not a expected 
value. Like ath12k, it is better to handle it through hw_params.
>> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
>> ---
>> Changes in v4:
>> - Prefix subsystem with 'wifi:'.
>> - Added the 'Tested-by' and 'Fixes' trailers.
>> - Link to v3: https://patch.msgid.link/20260417-ath11k-null-peerid-workaround-v3-1-d04302284486@collabora.com
>>
>> Changes in v3:
>> - Clarified that the mpdu_start header isn't populated by the h/w for
>>    all sub-MSDUs in the commit message.
>> - Fix second null-peer check in ath11k_hal_rx_parse_mon_status_tlv().
>> - Link to v2: https://patch.msgid.link/20260415-ath11k-null-peerid-workaround-v2-1-2abae3bbac16@collabora.com
>>
>> Changes in v2:
>>
>> - Since peer_id=0 is a valid condition on some chips, remove the guard
>>    that prevented the peer lookup.
>> - Link to v1: https://patch.msgid.link/20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com
>>
>> To: Jeff Johnson <jjohnson@kernel.org>
>> Cc: linux-wireless@vger.kernel.org
>> Cc: ath11k@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   drivers/net/wireless/ath/ath11k/dp_rx.c  | 3 +--
>>   drivers/net/wireless/ath/ath11k/hal_rx.c | 5 +----
>>   2 files changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
>> index 49d959b2e148..ff2c78a4e5f3 100644
>> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
>> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
>> @@ -2215,8 +2215,7 @@ ath11k_dp_rx_h_find_peer(struct ath11k_base *ab, struct sk_buff *msdu)
>>   
>>   	lockdep_assert_held(&ab->base_lock);
>>   
>> -	if (rxcb->peer_id)
>> -		peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
>> +	peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
>>   
>>   	if (peer)
>>   		return peer;
>> diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
>> index 753bd93f0212..51e0840bc0d1 100644
>> --- a/drivers/net/wireless/ath/ath11k/hal_rx.c
>> +++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
>> @@ -1467,11 +1467,8 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
>>   	case HAL_RX_MPDU_START: {
>>   		struct hal_rx_mpdu_info *mpdu_info =
>>   				(struct hal_rx_mpdu_info *)tlv_data;
>> -		u16 peer_id;
>>   
>> -		peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
>> -		if (peer_id)
>> -			ppdu_info->peer_id = peer_id;
>> +		ppdu_info->peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
>>   		break;
>>   	}
>>   	case HAL_RXPCU_PPDU_END_INFO: {
>>
>> ---
>> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
>> change-id: 20260326-ath11k-null-peerid-workaround-625a129781b1
>>
>> Best regards,
>> --
>> Matt
>>
>

