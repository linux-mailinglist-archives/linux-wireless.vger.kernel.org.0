Return-Path: <linux-wireless+bounces-35438-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tA2nBZY/8GmUQgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35438-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 07:03:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D40E47D6F3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 07:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB134301C93B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 05:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3707083C;
	Tue, 28 Apr 2026 05:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CyQhcFpN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SNosEV81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3665733E
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 05:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777352594; cv=none; b=Uf5SncBgi378E8uTSlVp9NlnbOlrrO8rH4fOsLkvnoHec2rsuODZrWorytuC8q7rb1VlGnMnotTdsRyDN44cWsGLxV/+zk3DDgmh5NIkEZeBbbRYaxP0fcE2PJY06FDZul9vzDHsmrRBoyFycTgTj4VX8sy8zQAi8Xa1AUcoTUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777352594; c=relaxed/simple;
	bh=GRdtteNBXE9HKZW3/EoirzpQBiLiE17EKG16JBWSo7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdqHLz71PsHjbDCFqnZm1Pfi3NCEkF9qfxqO9bbHgKCdjllSL2RrvYDmQ12LAHwBca6krCam08s3W9b4CTlPK6SxX+wcvKpfip34SLF8Px65i9MJyZlpHZJlNNgjsGpEmxIitbEjeYerqbvguaQXz+LIGfnzqwUs5dBF4Lk9BfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CyQhcFpN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SNosEV81; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S3sIlD1237224
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 05:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P/xnh5WaUWNjwzXKnAXaG6bkmH/ZQh0FiEHJYtnrwfs=; b=CyQhcFpNMQVUhMt8
	zR/ZmIUcGUGQJ847hCV6OZgN2xft52lYQ7QCde/55EUY0KPQlP0lZesiVLEXgzqZ
	uUJrsxj04chymbHvmb7ndUfeE37LedneC6TOhhMVitw6w8XnT60ou1NRusXniSen
	6pS/Ro5w9MyjCUthMWGt5QEWB1QM3fp96rDgMb1HeF7rjQ8+7wsMEr/a9uwXI1u6
	aJnD+djuTL+2Bq+kkIGnKKR8KyzPZaVHkQ56IXpIzFmqpMcPktdxtN0zf4U5CEFE
	26ESOBYRNy1FFUNjo/3opowtf0F73qlpOUtvnzdIXd/cwAAc1mCkUXrLAhsTn6uT
	bV/VFg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4kmdw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 05:03:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24e9b4d82so105204645ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 22:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777352591; x=1777957391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/xnh5WaUWNjwzXKnAXaG6bkmH/ZQh0FiEHJYtnrwfs=;
        b=SNosEV81n74QCAJTGK/dbS8arCzjKe3/qkuX/eFktrekq6TSbHkCAXa6KmUrsQ+VHf
         uuMcVzWfNVAaj341/wLarXRJKGkyUd9/dp80rDue727Ge7OWqbBgqOC7kLyrpxdLCmJH
         OswK6AC/WDYXjjk9R+H/3qcj6IqIDHP50MI9YJyX7Oe6hHswA6B6+PWXNAuCvorDFdeh
         27K8V4GDVqrtk3wbMrvX4yJW3NsA1qht/H88DgkA5oZ1Bol0wzQAY1K8QHibLhMeFGPM
         fjxQ0GZO79FnSqaX2HV2zXloxKLIcBm+YhLF5hUkTVB6ifeBOF5FMbqaYbx4iU763k4d
         fdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777352591; x=1777957391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/xnh5WaUWNjwzXKnAXaG6bkmH/ZQh0FiEHJYtnrwfs=;
        b=I3lN9mnRibDvqCHU2DzHZmlHEC9IIWIUJNQvL9u9MrcvK9VCHFQLGdp07wlTNTFzZL
         ffqnDMUKDoR6LPMLrsq3kYNdn9Psy5VUm2qB3uuhlsOU+fgF1eTdjELsgWwrtpAD6QjV
         vTYfht3qDPa8/UuCYziKcqeNZVNPvUGEKjqmwGvj4WFuhsiboJdZLZf3ZSwRRTN6UbvA
         Mnf9Fhe69yLEr450mPLgR+A2teUpjY/Jx+yr58Jr/IyFxOlAj6NExVRWaWOPMKkY5tdH
         uZuF/CCR/mfg0QMNibwMzp0Eds+Ow5pTJ/h3bptfwymLGElD71cdDuOEmjxAPs5wsORa
         nmrA==
X-Gm-Message-State: AOJu0Yw6kN+67eg9s/RG8vhjOgMEkScCgzLRY3Y7JxYNFrjDKFPPGaYb
	/JfSwyqdy+tafYGqffoErd7IOrsESN0eJGRtEl2HViQenrp2VxkC9l6FCW+NT6KI8j4Pe5pPbMN
	AAQ+o8w2z4ziLlqFSIgg9u9V2kXxornDjpRNDXk/l3umydy7eraIf0hZFJEa6vUa4+Lc55puFf2
	7qXA==
X-Gm-Gg: AeBDiet8mAXs8SCBuegPExX0Ur2M+aR+tE4nSpeRaHKfCnxQWxQSjZcdErTAsRZOkPe
	25OqwbB3Rd6bdLwGfmqYoXPGmGh8GObWJam/DPw9FwgL0iVvb6RVG+n8lvM+wvqYC0ncF47uUtN
	CjFTviFW7Sl47+tDfBnsNQplQdRoD/U+UrJQGIN9RTlVzTTzFM7KfP8QC5wQFs/L0+pkGRF6AEn
	jgeG/UraSubFGHhKs1DlEweS9Y/LUuqHBR+zT+Pb0E1D5NuQkDAl0ylJuTjf7RSSuyM4yz9c8rs
	bLtUI0dpuR9A/nYaWx+y2CiupxI9wkIyu8grSetCLNYKbrhHP1ok7st1eJ+xt9lHkAKUH+Dc89V
	ZhcxYXZdmaBiCbi6poXrpZ2LTvjdEEeMEGhHb0Y8A1MqJA5l16AroOB8W2eBxcxz7kYGbP+6T
X-Received: by 2002:a17:902:6b8a:b0:2b9:6a4a:137 with SMTP id d9443c01a7336-2b97c012656mr9054385ad.15.1777352590845;
        Mon, 27 Apr 2026 22:03:10 -0700 (PDT)
X-Received: by 2002:a17:902:6b8a:b0:2b9:6a4a:137 with SMTP id d9443c01a7336-2b97c012656mr9054215ad.15.1777352590333;
        Mon, 27 Apr 2026 22:03:10 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca92d5sm11691725ad.79.2026.04.27.22.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 22:03:09 -0700 (PDT)
Message-ID: <79cafc68-fedf-45da-8235-0ca0a30b1e0d@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:33:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Handle DP_RX_DECAP_TYPE_8023 type
 in Rx path
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260418163620.3633959-1-tamizh.raja@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260418163620.3633959-1-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _oPjEWDc_fB6zjNXjv8RNfE4vTB8z_4R
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69f03f90 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=M6RSCC_QK_m3dAS1aMgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: _oPjEWDc_fB6zjNXjv8RNfE4vTB8z_4R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA0MiBTYWx0ZWRfXymSBmprldApu
 LPYIy3ec5OkrZTKDIr1j5ZeW9qFUyOZ8j4P+ScIFwrTEmH80HuDP1YAIClR0v7qUYg5QDMLYbYr
 uzQ2JlXAJlwSe/V0G0MVlK6vfYCHRNjLJG/3RigNc2SexMH+Jnejd+sD/8rvO3ic+H45scW7FKp
 SkBoHwuzHViR8pKwwcFMflQwfh+SJ1RNwTU5O/hK+HlNT8lnVB2RKnMCxIysD9GbVmCdO/NcO8/
 5CtC5dB5dETHXBU8/BlYtFESjF+fvXelO72x2yMxAuMoIqOObEWvrydekf3xGy6Bx2p7s6Cbb9+
 c+3DUMQUu6JvZTxUmEef9UT06aRr4d2GcGEWNFBIkdeCEQp4rCJ5QXYyY6ygdCCTcyC7dYBX2hz
 KVyJ1KPwei7bowAJz/DT9sOZhlket6aMprovfWYolQs9N3LyYk4MPQ+D9Rr/W5Ph8T2oqCcNcTQ
 h50KcdZwy9bKAWL3iIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280042
X-Rspamd-Queue-Id: 6D40E47D6F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35438-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/18/2026 10:06 PM, Tamizh Chelvam Raja wrote:
> The driver does not currently set any rx_flag for frames received with
> decap type DP_RX_DECAP_TYPE_8023. When the hardware reports
> LLC-encapsulated packets whose length field is below 0x0600, the MSDU_END
> descriptor may indicate decap type DP_RX_DECAP_TYPE_8023.
> 
> These frames are effectively equivalent to Ethernet-II (DIX) packets,
> similar to those decoded as DP_RX_DECAP_TYPE_ETHERNET2_DIX. If the
> driver does not set RX_FLAG_8023 for these frames, mac80211 will
> misinterpret them as 802.11 frames. This causes valid frames such as
> Bridge Protocol Data Units (BPDUs) to be dropped. BPDUs are exchanged
> between switches to maintain and manage network topology, and must
> be treated as Ethernet frames.
> 
> Set RX_FLAG_8023 for decap type DP_RX_DECAP_TYPE_8023 in
> ath12k_dp_rx_h_undecap() to ensure mac80211 handles these frames
> correctly. Also add multicast packet handling support for the
> DP_RX_DECAP_TYPE_8023 decap type.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

