Return-Path: <linux-wireless+bounces-33484-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGvbBTUFvGmurAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33484-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 15:16:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647C2CC8C7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 15:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FDA4302C36C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0067531AA8F;
	Thu, 19 Mar 2026 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DH3Z8IaR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EP27yWRK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AD30E83F
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929671; cv=none; b=YQCqjoWFvjVxVnFH7UXkjqI71RcFtg9lLOdf/uq9SUoSNe38+Yxc0kS3pSFhueiKMBRCUPa/fBg6sN2pNE1k/ewtGsiVfnrWw8y2duVj6XmfeP2MdbAna7AT/CIIfbxY0MCDKtMZhxPsnh6K0WXvnTs5+MFixzJb3DnMeo5ynEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929671; c=relaxed/simple;
	bh=4czNDYSaKmynd9iftkMiE0ugn6+t+5jSgjCXfybUZPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vc7zTEXVzmdWddVtZNc9e7qaZMkLBI17/XE6cY/FgxPlvsVvrU4G6ryPAHYF0rYpvHD+r3ambFDMTPgxxKcLPV63PPNWSfdJY20GMcDwRPRRmlkBYbxzJrNYFZYm5/PW3yNjsAr5NvK/voDUoxGvWdsH7K1dp5mXo1A+1b5oyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DH3Z8IaR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EP27yWRK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J73uob1770604
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 14:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bt5S92KQQ206jKW4aSaTmm+Ht5CJzX8Upbglh6zGhlE=; b=DH3Z8IaRGUVTFyKq
	3WSRk7s23ijnlTyxesx6MiSEhfpr13h9B8sMgY6gqpa9VdE4QjFT/2Kv3zeUvo2y
	G1RFwWG6L4Hjq2ghswHSZNYXxHh+dzIawD64NXGKROtXplQhNqfQajxex3tycGOT
	K7GeIpyxgzfPdnnLlO6E6o/k8361Sd6ujBn2AAsYM9QofZJUXktyfH4zvSGewOAn
	XTHyYdLVq1+qXlT2M7r4erVu9arV2x6pIsRFdAl5dR+sLgPgwghzkD0nyWisAaBh
	W3EaUxN6PYqmMyeeupOrv7C7PE4KRNFACyxbSKxtCE2m/mvrE+CNN9hzNnN/hM/9
	lyLGaw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyy75uqe0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 14:14:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b04db6c138so13584375ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773929669; x=1774534469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bt5S92KQQ206jKW4aSaTmm+Ht5CJzX8Upbglh6zGhlE=;
        b=EP27yWRKw+n8YJVRhxUVLw/+tQZWGGO2LaGGMXU3+iYAOa0bmjTIQe7DulO0WTx23N
         PZTrhwMxUI1ioSk5dYd9DvCRjXSmTrTykXXr1GB00TpPshGUslQ3LYWiIGzvF9D1PBaq
         X4SzHy/yJ8hiDgKUWudq/cewwvKhW+WzbccHe8nmtCdtL3Enh4gZS4+2HVGsPUHEzO2g
         WiCPTzo/IrwHvtLQL/iogUxolxogh9zENbrbEj758Zvljc6SOO4SnWIQDE+oJSQGbO/X
         tJRgxANkpd29ajzWyke68jSvZUNsWCUPL0gUceILC/DF10fbjqDQM/0W/J9u9wGXljPm
         qLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929669; x=1774534469;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bt5S92KQQ206jKW4aSaTmm+Ht5CJzX8Upbglh6zGhlE=;
        b=U0bn5jJa9+edBnkd9MSkdMp89RjaSwTGc1hYUuyfw6lboW0FhvSuqtjqXKGnJahCCv
         H0XjGdTjOpynJDOpIkB2xoCgoX0cH9vegSslCZNNaGnLTujiEM4if3FfKWNYusQ/0Jyw
         bCnh4gQvmHYrtw9tg97NV5KaWp1PE7CrbnbaAMDD7SeDCZ4dURSxI2uwAffqGf6OEAaP
         vT4JIsbwaaRbL4ZfJ9tvpjtV1sW4dpG7nvGSHWyUAfssYt2OgeSHEtR32qKcjj0TCuPV
         jqN4FJ9uaRFPJPHvo+DLvqamEed2E46PA4wQlBwJWTG8SRwMCR7B4QDCUHBwzjcRdPn8
         VeCA==
X-Gm-Message-State: AOJu0Ywsynqmkxm0RjP188xtBDlhq4WbFHvYsisAI4D6bClggnJp5H+H
	osOmnMnxfgr48g7DN0UU+ec4NHReIq/1NR8NEywAgnL6/2C/dSRRpxzJUHPIAmlgGqJznGeomYk
	5b84XmpBORI470oV9aF9JwuhcV4c4n3eAu/5/vps4aRKAzfkwIltzn2wpsAgpixninTeASR86PR
	coow==
X-Gm-Gg: ATEYQzxCLdbDyE5K1oM1Cyp4FzA/xeGOj/NBZYVWE9XONqlgWB9DN73E2EAvTRaynIK
	9Dbb6+8ga3+y5ETRUL5xQfyNb0JLVTpKTHdtgrWgsnD14S8EZ1/gFhFU6gpCLuhyT0GUosjvSL4
	vIRUBe/5hsfRN1E+UfqbMuoxu6/fNOm1PG8xZYypb0UkY3LqJMUT/PkJbPj+/D1PEmfV+6ZlQ8E
	blPK7GbmycmacqhOXzniU4AWGiJL/5aZZju8ipntIGcnGeDctDPorPyiOjTB1vPTemWXv6xu4R4
	7vwLW461AMTlm2Kh9f600ZZxWjL/f7Vo2VobA4uMeyLef/4tcr2xtkDy2cnucpC0n+2m2x/Ckmh
	JPCtbEfskaJaHnPCiU0U0vsGk5y+aaVPP6P1hvc9bSmtd+UuyGuXmIYd7rmXTAExA+Og16/fuGF
	6mSZBgWQn6tz2DpA==
X-Received: by 2002:a17:903:1ac8:b0:2ae:471b:e55 with SMTP id d9443c01a7336-2b06e3c5c83mr76302035ad.30.1773929669309;
        Thu, 19 Mar 2026 07:14:29 -0700 (PDT)
X-Received: by 2002:a17:903:1ac8:b0:2ae:471b:e55 with SMTP id d9443c01a7336-2b06e3c5c83mr76301695ad.30.1773929668767;
        Thu, 19 Mar 2026 07:14:28 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e5ef519sm60441445ad.49.2026.03.19.07.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 07:14:28 -0700 (PDT)
Message-ID: <1a037a6b-f39d-4624-8f3d-1298da8c50bf@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 07:14:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: prepare REO update element only
 for primary link
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260210-ath12k-rxtid-double-free-v1-1-8b523fb2886d@oss.qualcomm.com>
 <8056cb5f-cdde-4890-b8cf-3b37d1c3483f@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8056cb5f-cdde-4890-b8cf-3b37d1c3483f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDExMiBTYWx0ZWRfX/HTmqocPJ/I1
 jHlPspNKIrMV23EIAhcmfoIMdR3/6Y0QSZONOTc83w1CXgxROF+tgOKmcU5fuiefvBWQsDMXJLB
 iR8LpWGp8Ef70EzRKlZJ4ct8KuZwhhpgkfSL7zJBs8Eus3J4kgIAwfqhdqwtfoWonsh98rTCDaL
 P/p68shDD+7Tze/bE4pI91H5wQLtfGoj/gINMaC76RAhgEoyipvgSOvhnHm8hr4i1m0r0/pLu5e
 83QAWoRJMKn72eVgSnsb0Z5l1gj02pzkQrOtM3/BA5X1NilCy8IS0UAfGjweMGjpOiFdRrpVBoH
 P+mK38zNCKD6NFY5yeVZuR+ZlfoaE/lUdrIsrgsvaTtzskRZbpHoEdbxBDPQ9T6B6wz6XzIPANy
 gVW/GSThRWWLcUqENpjgMQ2HFYp+5d8TobbEamRZ2cLQVVohIrVcSgkDT20xJV+Ui8CWtzZoUxD
 F68Jxr87glh47fckXSQ==
X-Proofpoint-ORIG-GUID: 9hkOGP4Xr2NHDcCui64BNyIPwVkGDBtX
X-Authority-Analysis: v=2.4 cv=A7hh/qWG c=1 sm=1 tr=0 ts=69bc04c6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ALmzmtPoW6pM4TZLvQEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 9hkOGP4Xr2NHDcCui64BNyIPwVkGDBtX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190112
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33484-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8647C2CC8C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/2026 8:46 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 2/10/2026 8:37 AM, Baochen Qiang wrote:
>> Commit [1] introduces dp->reo_cmd_update_rx_queue_list for the purpose
>> of tracking all pending REO queue flush commands. The helper
>> ath12k_dp_prepare_reo_update_elem() allocates an element and populates
>> it with REO queue information, then add it to the list. The element would
>> be helpful during clean up stage to finally unmap/free the corresponding
>> REO queue buffer.
>>
>> In MLO scenarios with more than one links, for non dp_primary_link_only
>> chips like WCN7850, that helper is called for each link peer. This
>> results in multiple elements added to the list but all of them pointing
>> to the same REO queue buffer. Consequently the same buffer gets
>> unmap/freed multiple times:
>>
>> BUG kmalloc-2k (Tainted: G    B   W  O       ): Object already free
>> -----------------------------------------------------------------------------
>> Allocated in ath12k_wifi7_dp_rx_assign_reoq+0xce/0x280 [ath12k_wifi7] age=7436 cpu=10 pid=16130
>>   __kmalloc_noprof
>>   ath12k_wifi7_dp_rx_assign_reoq
>>   ath12k_dp_rx_peer_tid_setup
>>   ath12k_dp_peer_setup
>>   ath12k_mac_station_add
>>   ath12k_mac_op_sta_state
>>   [...]
>> Freed in ath12k_dp_rx_tid_cleanup.part.0+0x25/0x40 [ath12k] age=1 cpu=27 pid=16137
>>   kfree
>>   ath12k_dp_rx_tid_cleanup.part.0
>>   ath12k_dp_rx_reo_cmd_list_cleanup
>>   ath12k_dp_cmn_device_deinit
>>   ath12k_core_stop
>>   ath12k_core_hw_group_cleanup
>>   ath12k_pci_remove
>>
>> Fix this by allowing list addition for primary link only. Note
>> dp_primary_link_only chips like QCN9274 are not affected by this change,
>> because that's what they were doing in the first place.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
>>
>> Fixes: 3bf2e57e7d6c ("wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures") # [1]
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221011
>> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> 
> Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

Was there supposed to be a tag in front of that?


