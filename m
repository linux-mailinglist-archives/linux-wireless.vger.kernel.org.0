Return-Path: <linux-wireless+bounces-36286-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPb5C0CiAmqRvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36286-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:45:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877DA5196AA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B1563009CF3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C601624C0;
	Tue, 12 May 2026 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipK20JMm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W6wQE5HY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AFE224AF2
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778557501; cv=none; b=hge1m87H5eAVUsGKBMwGZA+h2MEVp/M5Dl7uH3yNihj/gIutPye1e+jrVGdRElIyFwKFVSUIowZs/nMaKL6R8vEZ2xj9RipsX2MCYBQAQChHZsDrZHfF/oP+k8T87y1VSh1aBeSp6mCRnEJfRIWUrvLOsEzkMBVt71h46nSWccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778557501; c=relaxed/simple;
	bh=pcTbfU+kVBSZjhvIM8SIGcFBU81yF/Q9pKIzc2dzPWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWM0RgsqFrsGhb5Cuw9LD0h7gVS9E8nMXGTqLW2dB7Qao8llD56N7AMSQQjw+DHpWunUcmgPPp7U9J8bMFhGPuj22yyAQP4Ux0wtP5N8nHhVrx+J85aeaaznOWWdBZTbnmZIQnlmQh9Bts2wdYAfqeK80JPBJy5tusL+u2qPJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipK20JMm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W6wQE5HY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7B7x2804751
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 03:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8LcGKsBWnDz5XCQZOm9zW7vWC0qVrq2TSrnS/NYguLM=; b=ipK20JMmepJ/AolU
	OBSuWlCmffWQnpDRlDjswoYK2laHLwLUpL9Zq1RQJxrthc5ZUJ5q/5i0HZO4OXtr
	YeEZAR9hMdBGZKW3qTkPS9GIRolSYuQxVKtEalo68xaiGEmnn+BDyrQSS3PRT+bP
	wIh+fQLDKwWL/rE28PGddtvHTqgLXvvHo0R+diXlYf4D8OcJYDQNlVc08dAYZ57v
	n0it/f8FN0ke+IXFsPAh7skdwUxGBuj9p3qw+8UMCA1metYwX8Q3wK0xukAfAaWv
	D/oGK3yUInOzFJVf+dt0ps21GwTUKqlZPHl5rU34X4f++n/J24pvYmdBOzlLqm10
	J3VhnQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv39b1b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 03:44:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bc6899bfb1so35763705ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 20:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778557498; x=1779162298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LcGKsBWnDz5XCQZOm9zW7vWC0qVrq2TSrnS/NYguLM=;
        b=W6wQE5HY7COZ9U7nNwPxrpQEjkButY0MzBWiJgKiI3MpxkvfiwgEoNvHG3VfFbJXkN
         d+DoPFus+Lk6WAdx0AXhu7XY/64qXBcwajCX6MbEreM0PdZa/23FHcYX+4MKU1to7Szn
         x8sJfGAbRwHQeMVpyETtwKYcIEccEgdatZEuhhlMLJGB6MHHZQUOEWppquLWnsj5BIfg
         8wvGkwHI+iRSiOF7ehHLxKhkYTIKIErzCHAPLtGqDv3TYLA3+yRnTf5/D81lj6VH6INS
         DoaEquyb4l6flpOefIs0QY3i0nd0TbxInLcRphWrk48dygGGZJwYr57L3Ed9XiY9CdW6
         xUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778557498; x=1779162298;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LcGKsBWnDz5XCQZOm9zW7vWC0qVrq2TSrnS/NYguLM=;
        b=OpoGBqNWHT2jIXvl8VYN30N/ZGGY+33djRlsrwrO/2ET2ZV2OTNJB+WzcWeSfRfeBl
         qNY++E8zIJENJ8wXLSUa3b2OKk8A39L7lqUYTvIIN/TkYL+0a+hEV7w/4d/i9Q09m6Ko
         rnxKNu5AcpRzHC3ZXTgnynCxKGFGaWvcvgpSJoDlvUuGvwTZpOLmDSEqrQzrOipnSDW0
         yxnGh+kWYHcwEU5TF/U1l99CIQvPKq5jCNXTmlEJ0pL7mgHnhblWLd6YjOS0Sy1i1icW
         Ip9Fsd9B4nDcRnvfYj8CR7Eq/am/ltmjx8wyi4uXhyZdAmPahuJkOx0akLBXHwcA072l
         vGZA==
X-Forwarded-Encrypted: i=1; AFNElJ/6s8ADgtgoMioXQzx9Uau/XfwTmFs3jIFwqvcBZ3PUargECONQeZyVv4waMMwdd5T3TLg8znopUAAYKtM3iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBP26B6DyByRCff7I2qX3SFgecM0jAv4WKAzackluQ6lcyJi9k
	OrE4ek+J3J52tgFCnzni/nXsXNWfndMQl2IPKqAR4FchCMnQVe3UkPpPTtZkmfmOV0/RSMeD2B2
	Yn83hIINlReag1zLUTynZ6RiqaQuXNxZWhl/TFuRiTWGsbUCRc5IKziXDwi0vG1dnI8IVQg==
X-Gm-Gg: Acq92OEv2kCenAnb6bI+KKq9NbTjuDkUrYTXmUocNkp0m4anKvOQSrDJ/t6LBqnM+q+
	XV/jwaoKTPyTmmFxxP0tcREsQ406SdLGDDDZbv6zqR4iNqmTWUsOMviBiUZW8v4DI1S27mZx5CN
	55jA3ls9hoT0NZsqweWBl3UbVANbfla2s5/XJEzUnQe2SH5qRWphmCLUBLoFGMkX9yfNqdq/KH6
	si+KkVOt+FQTaAUdU6EQDuBfVhBc6bz5zlgOhdwL+mrZV6dV6hNmtEry0DZBH3UQDfzVs0VtGpH
	xyo5SFBD/YKYfwq6542ne33+QJX1nFGGZ6kBcaC20iP2JHFd/T3seq18q+cTL63taFi4sdzNFfz
	V42PbHQky6Qj5mh4GtQlFkZRetE8OiQMG3vlJV4lRtfZMGa3t6owLGBhR1MH+xD4BYTWQbRJuQ9
	9wW6DM18X1WvieoQhxmoY=
X-Received: by 2002:a17:903:3c6d:b0:2bc:b80f:6782 with SMTP id d9443c01a7336-2bd0110f01dmr15833525ad.11.1778557498101;
        Mon, 11 May 2026 20:44:58 -0700 (PDT)
X-Received: by 2002:a17:903:3c6d:b0:2bc:b80f:6782 with SMTP id d9443c01a7336-2bd0110f01dmr15833115ad.11.1778557497569;
        Mon, 11 May 2026 20:44:57 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e847d0sm114977145ad.62.2026.05.11.20.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 20:44:57 -0700 (PDT)
Message-ID: <ffc197a7-b9bf-440b-9a0e-1753034d8334@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:44:53 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath11k: fix peer resolution on rx path when
 peer_id=0
To: Praneesh P <praneesh.p@oss.qualcomm.com>,
        Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20260424-ath11k-null-peerid-workaround-v4-1-252b224d3cf6@collabora.com>
 <530a9e0b-ae5e-48ae-a2c8-73152e2dd6df@oss.qualcomm.com>
 <e248e911-d317-41ee-a590-1385c39ee2e1@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e248e911-d317-41ee-a590-1385c39ee2e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAzMSBTYWx0ZWRfX3zMOLzSOenff
 HHhIF2BwQydYmA5g/XeIF5YX6q6FqzkzHUuZ05tA3sRzHhiEeH9WrdqsL2LCnOvA2S7QdwxO6Y3
 /WTKR6zbBDjkea0asv0aL5olMBkvKQeszVW77G7cQTeyAUq4rulzdbXIB7UELFpvecide9wjyXt
 lczM7iorBTGNZR9D9mIzwOfRSz6srFDwm88msMhihozlYSEJMafJtzsPybsoio+U44EMvxxHcE3
 C+i/vWQk60JxM0OGGaaxeRNfpYu++k0FKpzBT+ZtyDO+yG8mmnOtoxV5hbn5qmM3hecxqMWXIgj
 QdCHic8gPVYyFD4btaszPFvE0kK4Q2G3Z3kiPGbBtX/XKEeLVNSXcNYUzeUnjHJwODZs1sQJHDq
 /1TIeBEF10m/2ITxa6OHkfpBjy3qb2zRuWW2kEEjrLrQBvaK9eC5dUM9ilZLXq0ldq8i3jAF/qC
 BukVcdlJqNkwhAUxR0w==
X-Authority-Analysis: v=2.4 cv=Kvp9H2WN c=1 sm=1 tr=0 ts=6a02a23b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Vmrqkdg0PNoj9Cys2bsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: mx1w2thZLA2lcuOEuWVWPwGh8j27WBYh
X-Proofpoint-GUID: mx1w2thZLA2lcuOEuWVWPwGh8j27WBYh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120031
X-Rspamd-Queue-Id: 877DA5196AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36286-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 4/29/2026 6:47 PM, Praneesh P wrote:
> 
> On 4/29/2026 1:06 PM, Baochen Qiang wrote:
>>
>> On 4/24/2026 5:50 PM, Matthew Leach wrote:
>>> It has been observed that on certain chipsets a peer can be assigned
>>> peer_id=0. For reception of non-aggregated MPDUs this is fine as
>>> ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
>>> based upon the source MAC address. On an aggregated link, the mpdu_start
>>> header is only populated by hardware on the first sub-MSDU. This causes
>>> the peer resolution to be skipped for the subsequent MSDUs and the
>>> encryption type of these frames to be set to an incorrect value,
>>> resulting in these MSDUs being dropped by ieee80211.
>>>
>>> ath11k_pci 0000:03:00.0: data rx skb 000000002f4b704d len 1534 peer xx:xx:xx:xx:xx:xx 0
>>> ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d1a fcs-err 0 mic-
>>> err 0 amsdu-more 0 peer_id 0 first_msdu 1 last_msdu 0
>>> ath11k_pci 0000:03:00.0: data rx skb 0000000038acd580 len 1534 peer (null) 0 ucast sn
>>> 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d00 fcs-err 0 mic-err 0
>>> amsdu-more 0 peer_id 0 first_msdu 0 last_msdu 1
>>>
>>> Remove the null peer_id checks in ath11k_dp_rx_h_find_peer() and
>>> ath11k_hal_rx_parse_mon_status_tlv(), allowing peers with an assigned ID
>>> of 0 to be resolved.
>>>
>>> Fixes: 2167fa606c0f ("ath11k: Add support for RX decapsulation offload")
>>> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.9
>> Tested-on: is not an official tag but is ath driver specific, so generally it is put above
>> all official tags:
>>
>> Tested-on: ...
>> <blank line>
>> Fixes: ...
>> s-o-b: ...
>>
>> But since this is trivial I think Jeff can make the change when he merges it, so no need
>> to respin just for it.
> For QCN9074, IPQ8074, IPQ5018 and IPQ6018, Peer_id 0 is not a expected value. Like ath12k,
> it is better to handle it through hw_params.

ath12k takes the same way as used in this patch:

https://lore.kernel.org/all/20260512025732.1297849-1-hangtian.zhu@oss.qualcomm.com/

