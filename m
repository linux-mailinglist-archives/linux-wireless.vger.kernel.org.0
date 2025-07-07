Return-Path: <linux-wireless+bounces-24884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF4EAFBB70
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95380188B0EF
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB431C7009;
	Mon,  7 Jul 2025 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BAuoe74W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44519755B
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915121; cv=none; b=QHBMicXgM4CgoVsiJA+I0+UK1BlEx2tlwMoQMUzFnH6kiVJM0UQNLhAFM0VCfrLYwpbJSQzyUPrQddLGgT4vanmXqX3WwvRfozKfsT05+HsVQmk26gS/dj/sOcIPK66HWQd+n432eaQRoWU+XIqy2SnKtCZm7N7AICgfZPMgKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915121; c=relaxed/simple;
	bh=r1nF+f6JKQ0uhK9R4N4jkHaHb1MA2XFxDZ/AoL/wOe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfFhVBTibPSdLwrLYXMYH5WHwCCyTgGIQ2X069DWBsJhhQsez/w3en+WOT6r/gdQPlJnm63khfJmeKdWqqc/osVAnMp7bj/m8rmavV3DOIsp2WK/AB3H/nMmuPcfdNdHwsdGHwuVxjLqNImwodCxFyfLuLrzHoyL4KrxjzpVULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BAuoe74W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5679iXCv011890
	for <linux-wireless@vger.kernel.org>; Mon, 7 Jul 2025 19:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsTdXAqzbwRiweAJeTreHIDlEx3TVbwkfu8OKafAfwA=; b=BAuoe74WuHZXXQYT
	oSG45QPN/fxj2ZOWZQCsckCYdtj1kQcwXYwh7Hd4kq6hJdO4hp+QepYTGgpnOUH0
	TLMZO467aDKDphmRgyQlQY8VV1nZFae4klKDMJFF8250NChAP8/XoO1xJQkE6mVl
	VJWRIzbaSYNIrD81Hg/VeiFn9qM66E+8KnxhKQDh9yrdZ4mROoPRReTORRAdP0qF
	7k4Y+yKfpRx14GIz83Qf+nmXZAmFKrETSRHPQL247lxCI9XShdA/vp7Cp/MNDLgl
	CGSVmv6PipnzR4r3DFwwb1KiTLlojLthZ98seuL+1C4lagAqYppNPdEJdLypJSnF
	bxe0RQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2aywht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 19:05:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3928ad6176so318939a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 12:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751915117; x=1752519917;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsTdXAqzbwRiweAJeTreHIDlEx3TVbwkfu8OKafAfwA=;
        b=SxmEfK1rCRm1yJv1YnbQTWfRegScRaYMcXdAOFAapHUuhLl20fPQsBWQ3WaiZsqcy+
         Ph5ToYxOROJe9oXkXefahhQ2pLMNHSZPvGlL0WquR4dsvddKXJI5wJ1Cr32sk+HMiMpz
         aFcGKLai7bdvZGe4mP68hZedwB+/+Wgkoda7AIttCpoEW84UftGFBLRPvuevndX+zm0k
         ZP0JdySVXD/2CbugrT1aZkoRFDTcNzz1ybAL8rmzhKMLEoTAEi71WftbXX74sZFRfwGV
         EQC0zQudEKaLYYgh3+bCvm9IJV9rWkmYHxKFIAJyxT2d47eQ2Xtvt03SHxpH4lO+Rbj9
         GwFQ==
X-Gm-Message-State: AOJu0YzBk9vHT67/RyKUco6oHByOVNy+YGZILzql9N8WoupcS5TOqPOF
	pcpcZJ9B9trgAeyWM3eV7HT2ZXPh6Qwjr3Xz4fTxHzznge2HHHfTLWOv5wbI1I9qpqZ/JwLvlXQ
	eCxkY8tSVMoLhxqyeZy5mL34zqbzuCc04ruRfARdwv7quUpECHNJc4gke+yFnyym4QNuffQ==
X-Gm-Gg: ASbGncuvENN4lDFS5ZX6KQPIJa5YOZPrOrgoUlRvloo9OttQnbDKTYU1E2P4f/a/nMW
	IHMohmvB4/F3Mk5O232Xu4Xx/9Q4MmzAgVKFnDxdRu+AW5W2ibnVQgEzUYnLR+4M0ALaB0Q7koc
	/rV5cDyN/HogOn7AQb85JMsyRPIY8+81qnbDNMV+OHGYes2VukKqsx2tRwBg9RrP6qh6+XSuWhZ
	0KWoOyYPrjYm+7gzSUHveEGEytvXPkmuUdUX+RKdXzFmaKJmVFZQtGKpNghqSmnUOvD4HjjsVk2
	KdNms1JIcsqC5WudcMLcCYiTRrq3tnswdtJKpOiEKSmkohOjfIdtmDsfPCX0LuntLj9KRbNKSBD
	tUlERCifsnsU4q2o=
X-Received: by 2002:a05:6a21:920a:b0:1f5:882e:60f with SMTP id adf61e73a8af0-22b438d2707mr263981637.17.1751915117106;
        Mon, 07 Jul 2025 12:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr83xlA6HKmhSNZcd2CoeB9isQNFJXc5M84pANYDDK+A/XRCNtW7/5oSgPI37tP57E0Wdq/Q==
X-Received: by 2002:a05:6a21:920a:b0:1f5:882e:60f with SMTP id adf61e73a8af0-22b438d2707mr263938637.17.1751915116497;
        Mon, 07 Jul 2025 12:05:16 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee478b30sm9471979a12.27.2025.07.07.12.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 12:05:16 -0700 (PDT)
Message-ID: <10d52ab4-a0cd-445f-a23d-9396904b10df@oss.qualcomm.com>
Date: Mon, 7 Jul 2025 12:05:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: support average ack rssi in
 station dump
To: Nicolas Escande <nico.escande@gmail.com>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sivashankari Madhavan <quic_sivamadh@quicinc.com>
References: <20250612114620.1055840-1-quic_ssreeela@quicinc.com>
 <DAKJLG9RLFCQ.3H8XQHL8ZY3GT@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <DAKJLG9RLFCQ.3H8XQHL8ZY3GT@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEyNyBTYWx0ZWRfX4fNZBigwyJTv
 bpfY29u1yoXiS0iKaflTMGMbTlUHxktU41hDtT7rNuVgYPobRJSB3amftfBq+e/ef0uWKPv5WGS
 nqr3mt2cUZWmV8CyHfMN++5wxbIkfQaeXPqG9oiHgxba8RekXxdLFoUTOGTd9nRjtQHx29AMphH
 hFsmm58DkOKQj9A2N7QDm9SO+JclE+zK7v9Uz0sSOBL7Lk4ff6rem94VEfXVa9DKEQecMkv6l6K
 678N7NAAlNnGFknUu515DBgoo/pSLUEPYL6KeW/9pL1OEaiAffcPST2qchHh2OiGkf1qAzBWhoG
 iHgLGd+mbbTp8mVcIgrrU/jHAeq8AYg3+HKwbRe9BiZ5DtDyCwEHf3Beu/tZK5uXXj3KwYZcJD8
 0HGEACoL72ubHkBrtQBhhjWTqVXgerY2bXrBubyIAQl6VAJ+YuJn8uY8OVcb0Z3ywThJYHNj
X-Proofpoint-ORIG-GUID: OtpNK6BnerYdPXN7RLHpSRbtniWaGCQG
X-Proofpoint-GUID: OtpNK6BnerYdPXN7RLHpSRbtniWaGCQG
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686c1a6e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=53z-MDVfSCvoV5mJ9WkA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507070127

On 6/12/2025 5:10 AM, Nicolas Escande wrote:
> On Thu Jun 12, 2025 at 1:46 PM CEST, Sowmiya Sree Elavalagan wrote:
>> From: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
>>
>> Currently, the ACK RSSI value is not shown in station dump. Enable WMI
>> resource flag for ACK RSSI in WMI INIT command to add ACK RSSI value in
>> management TX completion event from WMI. Update ACK RSSI value obtained
>> in management and data frame completion path to ieee80211_tx_info. Also
>> advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag during hardware
>> register to mac80211 layer so that ACK RSSI is added to station dump
>> message.
>>
>> Example output :
>> Station 00:03:7f:01:5c:4b (on wlp88s0)
>>         inactive time:  46584 ms
>>         rx bytes:       955
>>         rx packets:     10
>>         tx bytes:       769
>>         tx packets:     6
>>         tx retries:     81
>>         tx failed:      0
>>         rx drop misc:   0
>>         signal:         -39 dBm
>>         signal avg:     -40 dBm
>>         tx bitrate:     6.0 MBit/s
>>         tx duration:    1185 us
>>         rx bitrate:     309.7 MBit/s 40MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
>>         rx duration:    0 us
>>         last ack signal:-41 dBm
>>         avg ack signal: -40 dBm
>>         authorized:     yes
>>         authenticated:  yes
>> 	.......
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> [...]
>> @@ -5651,6 +5655,8 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
>>  	param->pdev_id = ev->pdev_id;
>>  	param->desc_id = ev->desc_id;
>>  	param->status = ev->status;
>> +	param->ppdu_id = ev->ppdu_id;
> Hello,
> It seems this ppdu_id is retrieved from frimware but not used in this patchset
> Is this by design ?

I'm guessing it is for completeness (parse all members even if they aren't
used). Do you think this is a problem?

/jeff

