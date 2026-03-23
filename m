Return-Path: <linux-wireless+bounces-33729-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLcRLpJ5wWkQTQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33729-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 18:34:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBAE2FA04A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 18:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D17034D66BA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB03BA253;
	Mon, 23 Mar 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YqbhLWxW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BDI7n2dT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403683B7B69
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281723; cv=none; b=nX8VAAdaLr+obeWyTEFqCizUGShecvaOoyCn+q1+2pEtHLxAJA2UCx9ZtaFhvHvLZPurdFUyF3oKauqfFUdMoOf76J8o9NZtL52lF3VImnT3eT8PFkAGUyL66PnPcu1RLDKgUD8Ee1IplneW2Vav1f5zBanW7qkeqjJpT5Q88Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281723; c=relaxed/simple;
	bh=yu/Xv2YXv60jQkP9ju9axe0QVBfIwuZlL9H9yC7LSnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4T4MBsILwTq64HXEurssRZ/YaFie7xe6pIEpQpLq0PaGuw0MBanj7iZnsR6VWYZyer8oRoJ7LApMJudU/gomCUhgGiPEF9LBozz0nO6RvMousqNaGDiWFsUxo2c52evAnC/cWDkgVjdPhSk7pDYvJvL7SH5dEgh94Jp8rbWo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YqbhLWxW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BDI7n2dT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGT3Y021110
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 16:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n9zKi4orTheYudY4g3vlblU5Ag3YWsp1AgcplrH94Y0=; b=YqbhLWxWZV9mykzW
	QtYOwG4kTljvla/qOCHV5UdNf8RZ56BnwuEeTEiukZFTSn03TAnHLcD67QQ55cXZ
	d4NGBBHzelNh4gb0JDwky+kbTP6F/P/8d47tyz0w4Ja8u+Dgleki4E2Pxs5iADOu
	EuoFT7GAenIgtSE3F4etU9JOWYvDhCGvG6aMO0Poq1P9V+svp81uzNp+Xs5LNeCK
	iltnnJnv3/UlsFOXlviIrFq4VJc/2ekq9sDWT6X4pUfohFbIq8+YfzFA5IVM36Mt
	cUzdiHlKXPsyySH74KyxECgaMjkHs853okE2uM+mxdynAwAhBN5028+IzUe+7Tbn
	NsI7Hg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k3165a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 16:02:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b079b4a8c3so17663715ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774281720; x=1774886520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9zKi4orTheYudY4g3vlblU5Ag3YWsp1AgcplrH94Y0=;
        b=BDI7n2dToSIl15YxiV4ACMv6eq76c8k84d+sX+wkOYgTiwgTNjzBaDGSSjKX+2plU6
         rBtm5aO5YlDMFkmFS4mj94U0ZOm9XUbguH18G8gwqEzcJPS8vuuoUGEml2dVOz77Dsh5
         3ayFQoiQzEiZb2AJLw+PItM+W7sidKb4sdMkaZ4heMYiZxvgOIQhQrChkR6VgQgN5ZHr
         9aamkdeh0AaWIVtQkgi2sirTvtdb3spLxgMcYTp5XpxCqtXjn7jvxXLsq14pdi5aoP+o
         dNNGtb0ncIKYEDICBhXkN81s+NUgYv00nlhR0p8q5RsjexV3Lus2IdJ0ug3Ehkt1FsSp
         wWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281720; x=1774886520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9zKi4orTheYudY4g3vlblU5Ag3YWsp1AgcplrH94Y0=;
        b=jdZcqQV/7yPQXr0rdxgKuw5a2A7ewB1QB/FWFY0MEZBXBcjqZW1Ta7J6WFhisOr4NE
         w2BBL7Vs8eGZ86Bkn5vhTzEu1rUs99yfe5iNlEh+5A82uJrwZZw2t+6EL3GQleXN930a
         BIz+7EnldoHyRC7sTV0TOv8FENATdkaf/fotO7cR1tGjOjGeRbSElkx2NNSXLi67uWmU
         R4LYR7nLbOSrAaUZg4x6UYAPqce4wocM6zbyCdQsKODx6LtMV4YUjMNwB0qs/QLKEDFT
         wxRz+/+fxHeo5MN8AWXHrw55T2PmSC/6+VmrnLDehUz1mcW9GzhdW+gEgne2n7H9EsDy
         6YLg==
X-Gm-Message-State: AOJu0YzwT7uQb1+S5XbFqALEBG3nnkc6zeRYbG07sXn9F6SBwTBC2xif
	iMrtg5lU1i9zoCEUhSaxQIAyOpyZoXZwabrT1ibMUqQYWssKt2AAUL8qd7QM5QXTMWSSvyzRnTc
	nUaFK0bi+rPg2MtnNb3kgR/ufZp+m5oi34x/GQ/n1ys6H+S1tgKd11TxG5PJ2ha5aZDcf+Q==
X-Gm-Gg: ATEYQzzMZWm9bMRbGR/jOsKO4up+hZlOW95RmSLiYEIQPanQSwZNcYG5ywwnHmRyecr
	kJ6fo2iEV15AxLE6vnxgvEVL+jBbRT1+tU3vZ/lFiq9PdSI/0hb9Z/NnOdq8uJQyam6Pn5OuD9l
	gzKDOULpgOOAgTFxr6BhFRe1phOjYhLIF2VuL/LZ1FEyUz3fTaB2bv9qpdD8myctHAh02CZhpa5
	v0lYLLba3SzQvyKf/UXpxnwf0C0IAkl7RVPYTSlaNct2SgMfY6vYT2u6UIwYN67+aDkCJitNdPp
	uztMIcN2fbdTXaHD5oTkoFegg4DaARH21XSljB1gyh4eWLHDxYEnQRjmskhnEuFRe1iQzyxGNBs
	tFp2mc0v4/Rr5l1Se+ESK+ZacqGMc8jIiy5qJqj/B18rc2OZUYsCWxxTGZVJjL9YvCIlgSGml
X-Received: by 2002:a17:902:f605:b0:2b0:5084:eb1e with SMTP id d9443c01a7336-2b0827d60d6mr115009085ad.42.1774281716306;
        Mon, 23 Mar 2026 09:01:56 -0700 (PDT)
X-Received: by 2002:a17:902:f605:b0:2b0:5084:eb1e with SMTP id d9443c01a7336-2b0827d60d6mr115008615ad.42.1774281715347;
        Mon, 23 Mar 2026 09:01:55 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.198.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836ace98sm118764995ad.80.2026.03.23.09.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 09:01:54 -0700 (PDT)
Message-ID: <5a802f1a-b4a9-4ef8-90ab-2da712c36cf8@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 21:31:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath11k: Pass the correct value of each
 TID during a stop AMPDU session
To: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260319065608.2408179-1-reshma.rajkumar@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260319065608.2408179-1-reshma.rajkumar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c163f8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IA6WQLajIBRXaGJ1BcQDag==:17
 a=vkfXM0Oplov9zySb:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=6i7BSPJ9TF2FqONBaDAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyMiBTYWx0ZWRfXxzZpDQi8pBMR
 5PWMuCWzfO4vxlnFPbs0qAmg+GaRpQI7nJHDP1H6R1/34cUcz2Co69IDGGTe3LNmxrw7niDTvli
 GbyiexOkHtGw0UTCL6OnJ3nNF6lOZQCLAJs/Obj11rg+APr2DU7NNGkDXFWsblbfn5xgoQ9BVQw
 xkOsMYGy500e4Z/brg2BGUd7cXDsmupATF+IL2dVGVHwatcTgsM93HIUsBGDMm44bUy9VZ7srOi
 R/UV5sr1mcAytaIdU3xNzG6qQm82sn3rZSpBUbjvptubIbjlZeMMjmEX6s3JAf12aclkNwOQEEv
 i3pn1G3Ex2Ra43s/9h4OPr1fUxXR0T6FUq+WHvr2FtLLhJ5WiCZsaAJswVT8I8wRsmKShAz2lZC
 +b3gGkPLIrVphMLHwPgxXSqKQF6igKX8kD6B+mWF6/OcSSzx/znnS4WEM9v25IadaMnvVhWreb7
 EfVRQdyXI2SdSuxrgIA==
X-Proofpoint-GUID: ddNjWwog0CK9o4E0A64YwhophrmuxNAZ
X-Proofpoint-ORIG-GUID: ddNjWwog0CK9o4E0A64YwhophrmuxNAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230122
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33729-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3DBAE2FA04A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/19/2026 12:26 PM, Reshma Immaculate Rajkumar wrote:
> During ongoing traffic, a request to stop an AMPDU session
> for one TID could incorrectly affect other active sessions.
> This can happen because an incorrect TID reference would be
> passed when updating the BA session state, causing the wrong
> session to be stopped. As a result, the affected session would
> be reduced to a minimal BA size, leading to a noticeable
> throughput degradation.
> 
> Fix this issue by passing the correct argument from
> ath11k_dp_rx_ampdu_stop() to ath11k_peer_rx_tid_reo_update()
> during a stop AMPDU session. Instead of passing peer->tx_tid, which
> is the base address of the array, corresponding to TID 0; pass
> the value of &peer->rx_tid[params->tid], where the different TID numbers
> are accounted for.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f2895 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

