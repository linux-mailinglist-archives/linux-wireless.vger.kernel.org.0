Return-Path: <linux-wireless+bounces-37273-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DQeGf67HWo/dQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37273-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:06:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 039DD623026
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07DFA3086999
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869023DBD55;
	Mon,  1 Jun 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dCjZBY5Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJH8jcyO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B682882DE
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333234; cv=none; b=h+8St+9idA/VXCTt89MrHUTFWoAXoIH381MnFi545T1SwK/5dwCgkYxjM6DNwBVKv/c92xei1Cv8ax7GgrRh5rlhy4qpsONY+rCi6keu1wkwPHT044ED8Shu7eYbD7s5HuoLPjk2eUFWQiIOFLJkKLjNbn5zbWmTSl46/ZaEY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333234; c=relaxed/simple;
	bh=9GtM+wkKjh1nElacNW0re+mFOR6wVOjpOQIveT2XeYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LY/JwkMeM1zKISmPSITjlSf904OE0UAAQ7RQo6p1pBvC6DZqJQSvgmQf29Pl/57zQ4VDH1pt5PFyZ4HYKrwcg2IxZqe1KmnCbqxPCXaR3/la5nqNgZFLVZ9khYjrqk6eAiCyZWg8fjwwcN7O0Gbqkj/K2erePBV2AsFlCGSwk1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dCjZBY5Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SJH8jcyO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651EwpnC144951
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 17:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	88zSpBHefWdrVhaVs9vohNFyJNRTMhiCBZF1tpTs2bE=; b=dCjZBY5Y8IsquOfy
	kvJGrG8ih9yWu5OnllWj39TFFfau7ct2Amaog5PDHVPMb7nCXcMEvLm6AXZPPF3e
	fyg0H9HuLMhvvgxVSmKHXY5S9aybF4K+amoc4WZuwtjHrGXlMlF1aWq5fe6ZhEFl
	CKlTW0PDc+vA8zKqmYG6ZvR0GEmxUKZCgpITzRxJ1WIyg/phBJs20Vk4++9lPR8G
	zA0rxA3Q8XmCvVB1DH6GCman1jZnhTO7JoFQBlzB19Es65SVB9Zsraew5hiGpOz5
	8/nLcIhF7Rgg2ucUWmAdM+Vxzq73wTDaGscMxqybCFiaHyKkVL9w/H29NXGmN18o
	VAT8eA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6stt1ea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 17:00:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-137ea73393cso2212403c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780333232; x=1780938032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88zSpBHefWdrVhaVs9vohNFyJNRTMhiCBZF1tpTs2bE=;
        b=SJH8jcyOaKof0DTglaSrWD3eDOW2D3dwmzrcsELb94e1wGX8Fq/HaSCAK1oVbdPEyt
         /G7rFHbe5cKlCSug28DoO9bcfc4AxDf1O/cAr5kpjPGqSAXCsBi1/i/dXW2G9abWFEEp
         GpCx+IyqV+pz3OG5gsIVAvkEHIBh4XRKy+89nDdeobP2toyqCIWf/rdfBWAw1roW5BpA
         kD5mHhGTK1t5qQKetnEmyyliOJE149zSwTUNNyeP0cDHlO0s8uo8M0D/rD/l9i487Lzc
         It86vz7JJcdzd+JmxRkYeGQBRVlkDOp/yZqPG5EPy+O5GCeUgOJ+27qDGqyr5jpOyeTZ
         2pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333232; x=1780938032;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88zSpBHefWdrVhaVs9vohNFyJNRTMhiCBZF1tpTs2bE=;
        b=NaZj+BR0taVx8UXzmPehP6B+b4ApwdKVIg5tDirOxBzdWZR+cXMQnZmnQ6BdS2Vgw6
         E/NxSeRZNDgMMTvii/Ntku/RkKZDx28++qzh/Ss9uJBtimDutSJK9Fl+Vh5STYXb7uAs
         XJx/UP2iWA0rg65F45vjDq5J3Q8FThVXNU7+b19JsiPGlA0btUTvVIIBhkm01KuK+I/2
         TKL8kSNatYGIyYM72Cmew7BWxQEYWErWcnfiFysmTNhdYB1D1VKgFlVcIJafpPBMTAFz
         JNnVQgwaFlpJtjpMaO9+enY9AHS2cdoVR3KZVGukAE0lXjCqpIHJKLApStIfw/MoA6xO
         j0kw==
X-Forwarded-Encrypted: i=1; AFNElJ+LtOI58MB1EAgXX5dAtSTZJOYFgjpCkLbdhL95V9GtZ3nAXEO2Qk82zBhPeIDidGooY63VSpGQkqiGBk0+Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Mu6SvfNOCDA2sooAA4LYjtA5kDkiAEG1m2YDo5kQRyCoRcfr
	hGJBJvxmDcd16ExR8lnzu5m2rpEtUlNhpcr4eGUiX72u1tWA+8KmPtmhJhW4xMOQRnbuO8FdbH8
	kG+GTeesJxW8zW7HGhiY52l4uj9lqm0mK7Y7/sxdZJoNHoPcnRysofbyfdA9QRg+WQIGQwVps1P
	WgCw==
X-Gm-Gg: Acq92OF6+9dRMZz1vnwcoanZsWCF4ZRx9YKpVRh2Y5FOjD0NOsvGig70c6rcgt/vWq5
	dScARTuGEUxe7RMIdduNeShCmDADJ40ubpklBPBuot+C6aoS/qYU4GLgFlMjCoQoaRGXnKVw1mD
	ILXftNcDyzbyHNYssop1BI590f++BlaG7gXef1F2t/vNsz20YoDibhDFV8qhOmMjeRxrVxejgNU
	cCkawRy5cHE7q1GwlhFGJyyVEDcHm7RFmwbMr3VD9zIP0NoS9FhEPbk4KCVKVU/BQFBB4vpUC7m
	9raAQWwT8aUG1TOJVZUnGDiZObUq6xfipk+SO9LB3/YQFnNp6j/d/OTjlfM6jg1bJ3yPie6sngQ
	G/a4QewyfcfWDWmBlUa2QR/SAX5Zr0K6WBIBEVMkBaGVn0+omSsQLygOw9Ik3dmMN7Y51KXOAM8
	NIO8GnjYT9DeI=
X-Received: by 2002:a05:7022:b99:b0:127:33e0:ea44 with SMTP id a92af1059eb24-137d4284c55mr5447673c88.29.1780333231702;
        Mon, 01 Jun 2026 10:00:31 -0700 (PDT)
X-Received: by 2002:a05:7022:b99:b0:127:33e0:ea44 with SMTP id a92af1059eb24-137d4284c55mr5447641c88.29.1780333231020;
        Mon, 01 Jun 2026 10:00:31 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7151625c88.9.2026.06.01.10.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:00:30 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Wei Zhang <wei.zhang@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260525020711.2590815-1-wei.zhang@oss.qualcomm.com>
References: <20260525020711.2590815-1-wei.zhang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: raise max vdevs to 4 on
 hardware with P2P and dual-station support
Message-Id: <178033323035.2045173.12176429326839245310.b4-ty@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 10:00:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2OCBTYWx0ZWRfX60bhfjoICU4I
 eohbBPZ11UAH1v839jHQxood1VL04WqAzvYKbcESiBySbxIFpUZx48SIp5iP76gkHql7jFtGRMk
 BTHM6sjyelxRWB5tzfaLJiAwQtvau05AG9iYveeBBrun/1s7lZnHAwKj+yQyydIEBCIxSCFqMIx
 eTE2nb6jrBtrzkp56VTNlGv520hfhh+TsH7fMirt0RrwazWxRa+MTlxaUqK2kDDgZa7N30bW0aL
 QRmUBa7zBaWkdbF7btkkosK0U6VcdnXqo7k9x+qMSRg1c6mnM9vr0EI1d6H9ummfL5o7DiaBIoR
 2v/wVG7SMRZ3spIgc9t9J4tXjp28eratVaxuQFVWGt4JeWBKZYcqugi2P/5PVM5ZO/jVKnHVx5c
 TyoFZBztDKZHcNAe4EPkOXUQq7C8NwG4mNU05rPslH2IR83k/TtRYHQRYjYu/bUokYrH3iJpEl0
 5t0nNEZQ9+sn3xWt0rQ==
X-Proofpoint-ORIG-GUID: mlRnlwkrT-oW0BaK8vvvryerv1M6u3eA
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1dbab0 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bzN_VnlbJtnZpAVkCYgA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: mlRnlwkrT-oW0BaK8vvvryerv1M6u3eA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010168
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37273-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 039DD623026
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sun, 24 May 2026 19:07:11 -0700, Wei Zhang wrote:
> When P2P support is enabled, wpa_supplicant creates a p2p-device
> interface by default, which implicitly consumes one vdev. On systems
> managed by NetworkManager, this interface cannot be reliably disabled,
> leaving only two usable interfaces for user configurations.
> 
> Increase num_vdevs to four for QCA6390 hw2.0, WCN6855 hw2.0/hw2.1,
> QCA2066 hw2.1, and QCA6698AQ hw2.1 to account for the implicit
> p2p-device and enable common concurrency scenarios such as AP + AP + STA.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: raise max vdevs to 4 on hardware with P2P and dual-station support
      commit: 209887467581116a93490e6122b87b6fe0787627

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


