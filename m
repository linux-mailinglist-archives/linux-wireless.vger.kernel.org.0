Return-Path: <linux-wireless+bounces-31256-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPxLEyyTeWmOxgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31256-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 05:40:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0339D07C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 05:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20ED33006390
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 04:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BA426CE1E;
	Wed, 28 Jan 2026 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WI/YzHm0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PyR97Qju"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4848C8CE
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 04:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575209; cv=none; b=MsDDpwLCWISvT12LMHYgvsy1Elto7Ds4/SFbTNFn0OHZDzOL60SxaAUyUR7sCE+wxxRfzdIX35701PvDL/Szxer5CZeZ0pwS7Bm9Zk8VrmJogd3d88ya9EkRBvMzEL/XyCXOPhUjTuUNJ6scFlLS2ogS7CxwPYavd6u/oGOe18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575209; c=relaxed/simple;
	bh=VI70bI5p6Z+lHl+b4PFsiY7aHIkUUnCybTPYhKND04M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOkUgu3Z11ZNKuZifVZHTqZeEm7VFE0f//lW6syPLWf3MP0dX5YeLH3aX6pusbGkic+jGIQ5hLS+tReOXrMkhVeGpVU2liUHrfi1uWbjmKJGbppDSXf0HM8t7DIwxITCcA0MUs4nDtYkwIHO489QSiPYGjlsihYJSnqGPv6TN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WI/YzHm0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PyR97Qju; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S3XDcP2729440
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 04:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/m2MVJFquCUf6rZalmsL0Ff8nZ7ouqP3cLm1Wdrs14Y=; b=WI/YzHm0TIGGohq1
	nlI0uA8LhMRegio34PNgkoQU3yDCVnbk5Tr390SPTbavoOS6Ab5Cf6MjmN8xuWfZ
	yArV5U3oM7mQdpj6A8rETPZvDO5XHEafc46FPr1LJjeqNSUChLjLRIQ0Oeph94P8
	TODZ/QNdVUCb24Pph54ruuqpuhrSTzjpEvNT/4wClBDA++Jk0Jj0Q1zT/AjNu4gE
	rJF93fXnYol7udUhZbvb4qQwWKzidOzTJL3O/Cw2SdcGFWxTVmS9FtTnUqRG0fXl
	mc/5eY0QRaxdvWoBtZlF4nkvwEdVj+kaKOH/KOu38zM9O3iGIVpMH6K6+M3MkTDw
	vjf3qQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byanag59s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 04:40:07 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6187bdadcdso3660316a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 20:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769575206; x=1770180006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/m2MVJFquCUf6rZalmsL0Ff8nZ7ouqP3cLm1Wdrs14Y=;
        b=PyR97QjuCJA80hCmIY52iGqOGodiTl1ienSevwqPwbeNxRE3yIIg70N915Ebjw8eAP
         SiKuNepy4NdxyyCG/aBnhSu8Ox+ePVZYP6I98nnMw9XGSmZHUsJM5xcGw+O+Eid8e4GZ
         +ldXCWpCAnx/TzaD7JDjkE/3KB2NCN/bpekV5jbeaX9xDssqueIJyUC7gEEDwRsBoLNC
         KY9AHSS1XXHWkZBwbNMK75+I1QVI6DyiJwi2DQdqUTKue4Ak2JSRDv/pOGgYQdaKFa8p
         Z5ud1y7BG1a2Gi/IazZtZzl89GSI4VSHAcd9m8la3Nqw0g8g97fj19OD8wLb02CEN9Du
         qhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769575206; x=1770180006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/m2MVJFquCUf6rZalmsL0Ff8nZ7ouqP3cLm1Wdrs14Y=;
        b=Xrpdq/9RILE2OFEemUq9F3rhH8DuMaIoNb4p+nmE8i5+LvyRS+6y412exwcY0Qccja
         9numkGRCnb/zDqMlSVWJ8QThxe7JrYTOP71nHoGvqakFeKyIQZrvLu3IM63L01K5URp0
         jgQGPFLBxAtksaJqeNr/leG/wUYxuB44sXANw6PyYujZE06x05ztE6tWy1I1Au2FjSnw
         sKMZUppA/8FebZumfXMgMS749yTUewgpRMXNrqhXpr5yD8DMQ4M6Bv73YYyWRkrQPcfI
         Kpzwn3DEvqQAY54wraJnXCCvIt2j74rI/CJ0298NCFimhv+s9terJAXthhZolDM5ajYD
         Oiiw==
X-Gm-Message-State: AOJu0YzKap3FefDQ0E7CILYN4Xa4P5I4lfT7dl1KfX2+YJAG2aOIf707
	NLEPXooor3x2DyiykPyTBDPuWHJnO7Bd7L2ganauE7Dzsrp7JAo0nPyJdmC8CMO0QdLFOTBuQT9
	moFvzuK4GdnwuqMpoVpd2uMamTvNUmTKeTBlVh2JMiLN20dEFnNgio6n0VBWJX/01/L0U+w==
X-Gm-Gg: AZuq6aIAwYzmO6NmH59qXya8zw8xc+S4oBkTiXnSk+IH3XMOt50jOE+xV3/tSrjDmTX
	VQXvJj89Jsq5q3jiX+qF9CtVK4rNupKWs2L80Rxz5c5oX5/kpWKOp6bwRq8myRaBpJTncRDR9vM
	pHHhdzmyud6cDyk7yGuip/DXMKGxGR82rhsUsTa6gaKr2AKKH7zCQpqzuUwUBiQtyufLWFSV9mQ
	5Q2dt3Mhz870m7lO33ehs7ynLFrYAxW1Qn6dZiH/WzqTYjGZxd2stmEMgO9X8Q/Nm3vT+DUkuBL
	DgimmHI9irFt/wHdyHQJggpMqpbL2Bxz/CsydOLSlMzz1zbxtnvinLfdIlbOGzYmEmQjpqGYvYd
	H1ytN1nJeCavUB2WX9ISm5so1UUfFDcMfZmo5VR+DZjgegseLr2KdDFw=
X-Received: by 2002:a17:902:eb8d:b0:2a7:b412:6cbf with SMTP id d9443c01a7336-2a870e3694amr39557615ad.55.1769575206358;
        Tue, 27 Jan 2026 20:40:06 -0800 (PST)
X-Received: by 2002:a17:902:eb8d:b0:2a7:b412:6cbf with SMTP id d9443c01a7336-2a870e3694amr39557425ad.55.1769575205800;
        Tue, 27 Jan 2026 20:40:05 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4317sm8438905ad.85.2026.01.27.20.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 20:40:05 -0800 (PST)
Message-ID: <4ed536c2-e584-45a8-8c37-60639347296e@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 10:10:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current v2] wifi: ath12k: fix wrong TID passed when
 stopping AMPDU session
To: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>, ath12k@lists.infradead.org,
        jeff.johnson@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
References: <20260126173655.1369715-1-pmartin-gomez@freebox.fr>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260126173655.1369715-1-pmartin-gomez@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tE-9_nZsSRP3Vu4VvuNf9HDJsgBqcI4I
X-Proofpoint-ORIG-GUID: tE-9_nZsSRP3Vu4VvuNf9HDJsgBqcI4I
X-Authority-Analysis: v=2.4 cv=N58k1m9B c=1 sm=1 tr=0 ts=69799327 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=iWM9MhxghFcvANyY_NEA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAzNCBTYWx0ZWRfXzFgQV87MX6g4
 8JFiwCViOKjAZuQXEk327zVJNrYiDkX1lia1HjSfXVX0lrPTLzossoU5lm733N7nWZLn2mhAYNE
 bVnLcoiyp8t4e3EuGtKSMl+2nGY6FAs7JtCE0QJG0wUj4Jo9ihjH++a9NA9oMZJP1nrChE2BESP
 78oJiY5Yb2EWPPgKkqlJDO0VRM5ikLMz7oS0pnPBNM25SlbCUbfdHRSfJDC3Jdp8Lh9G8Nx3KKb
 Qbes4EglYbg03YQ6giTK2up7yV8iJkJUNs0RktYmDoM6PPbt2acNhvUBV6CCtyw/+J3IzdOATSk
 54S0XnlFf4pDxOGfZuUs+i4xs8fZ1Yl5aG2BTLFid0N7RkgaxKGDQDvh1A4RQtWBcw3UqIgllGi
 e2TeYzHWlPZdBmlMCxYAnw4MCKKmrStUDzXVKWDLTOe3dpHV7mVBWsKWwqXw2zAbyyCuZFFB4xE
 li/XA/MEoUbs3jM+kOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280034
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31256-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox.fr:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9F0339D07C
X-Rspamd-Action: no action



On 1/26/2026 11:06 PM, Pablo Martin-Gomez wrote:
> When handling a DELBA request, ath12k_dp_rx_ampdu_stop() calls
> ath12k_peer_rx_tid_reo_update() to tear down the BA session for the
> specified TID. However, it currently passes peer->rx_tid instead of the
> entry corresponding to params->tid.
> 
> Since peer->rx_tid is an array, this decays to a pointer to the first
> element, effectively operating on TID 0 regardless of the TID in the
> DELBA request. As a result, the BA session for TID 0 is stopped while
> the intended TID remains active.
> 
> This leads to incorrect BA session state and may significantly reduce
> RX throughput, as traffic that should use aggregation falls back to a
> BA window size of 1 on TID 0.
> 
> Fix this by passing the correct TID entry:
>    &peer->rx_tid[params->tid]
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

