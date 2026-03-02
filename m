Return-Path: <linux-wireless+bounces-32360-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNUONwEQpmkkJwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32360-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 23:32:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53451E5908
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 23:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7994E31739B7
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C53A2570;
	Mon,  2 Mar 2026 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NqjabR6N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cMT34w6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEC39EF2D
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485659; cv=none; b=VImRkxrNZCUdPG84tTyNusDM7m9agHVCw+OZ6MP7gDRSPm7TCkdidjULAQEj4VBtJiMvxy4cpj6YBX8Vprw/BM8m5HTm2lHCWEwjk6Pb23755702Lrwf4qdwT90nxDqcNQVBN3xf4r+UeT7tBgDZDd4keUPHtmfh1KUe5rSyEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485659; c=relaxed/simple;
	bh=Ji3N4yrSC8tX0eFZnHhyUB81/e2pQvYaPGx32WJgRAQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q6b96XNOeZwC0QnvhtN1S3QyGcYXKStHQH0R5JquvFCkMausX1w+dC8EP6xOD2L/wu1IApTTGH+6u7+iAeysScV6NT42iqel0HVL1vSc64NvKibsxXco78lKbrDhlZAeLTsSt14G8//u272k3xlU4gPhYUxfRLTbDBHypzXi/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NqjabR6N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cMT34w6L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622ERrC0662344
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 21:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	No//8h+eGpOLnCSvrZ7A+enHWGNqGIT2SyZYmXYaU6o=; b=NqjabR6NpY16r1iO
	/+NDpmWkqw1lMIUbfvMYxpeokNz7Jjn4Y6fh2YZkhTFDjG1uqN+fTTaSbA+B6xTG
	tsmJR3x4Pcxea/xM8kP6eDstu0c8cjcbx4poO5/2zjnbpzwxbDq7Or3HgX80QUcW
	h3jhMAj1gTzwYEiqawv00dozu7opdEz/h5cEKWopHRCZSBgSNa5Uzsk46CA8xI4f
	/h8sd1DhFdjBC/nQWBVAQkc6rUO+FLOCx5mkASpNe9Do1lJGQbCKUJBM8IVeKi89
	esl2kdf2vXirJlxA1RaByFNveFhSEQhgKmlbdZ79l50FCb3Fqf3+fbOuMm1AofIZ
	G5ep+w==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn6r2tnjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 21:07:38 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d194b631d6so34325408a34.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 13:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772485657; x=1773090457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No//8h+eGpOLnCSvrZ7A+enHWGNqGIT2SyZYmXYaU6o=;
        b=cMT34w6LGxPFN84HcFjvRUtc8lWntp33IUJIKP97AFL1DjhuV5sajGGquCw/bhdkNy
         aHzqvCyrK4vjg8XZk3GMHu3VIRrsh0FXLdehbMso/658RtGBTjWOGbYK3qgrmvq0RGMy
         7D9NmX/LCI7JqpnlcutCj346xDR48a4QOQHReYvLLa+kojqO1OrX3RI5U3UUZlygRzzL
         M4XV0GZI1eB4uIazbUgmQe+cKXw/Tq4Sy2Ac0qJsO8t9hokmDKcKEgZGKZIbXTykrj4d
         NXsl0iS+0K1UBn46bNXjysCEIDPP/oVGb2JFDRSKIN79qryC/ybY8eCX9qVDWWaQNyBS
         q7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485657; x=1773090457;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=No//8h+eGpOLnCSvrZ7A+enHWGNqGIT2SyZYmXYaU6o=;
        b=Ya9po5JvSnfOQGC+IjOLecAil8iicDAp3x3we175ZKQ1SYR5qgANIUJZSQb7AkpmDY
         X2Xc7UepuTGiUR+WhJyJhJGVFMsnPj7exsFTsgL0ECfLkhNJw5VTNmB82N3diTCD02cw
         C4mSuq6J6+Cw5U8e9jICPw5kONjflsNROPWTh1s6nRhrQRhtz+AOM8FtDrGdIvqCRHHF
         gjAzI8e1SU079GhO1N5/g87o31jno0GcitWbE5scwIWK29xoiCrsp34K471XXabYAyMz
         fjCBiSpGyM++31XnsBm5yoIXVDuapi+X3XCicjR/IklUlBSc82co+NIlNEyqWfFeBVM7
         xMPQ==
X-Gm-Message-State: AOJu0YznzXztWe0HMWX+DicaM4V7CMg586cEQS05baYsPXbj2KxaZim+
	S64OM/2iln3j1cGx7A/aWeyu8O/lFuh5+keLcEstyFTWlZtOR6vsL2Sm3eHTOGTA5466K6AiFGW
	aejdi0kyYzWnH4plSPyPJWTDpcIUHhwxd2ma0nd+Kx1/URVkA2Tds8mo2dA48B3cRTwsuTBX01+
	xM6w==
X-Gm-Gg: ATEYQzxVe13o/EKpCYWwmjV+a47ta/AevcWoy3yp64IXuOeGY5RlyxoKfMkH8ZWRhOb
	IL3LQdB/CVmIZUi6VBudfNxdNwWPkcVMQVrLIFTIuekREOMxCw4/EU1pU9X1rXBBXYaLtlcnJxQ
	ASVrZVjJAu/+xEQra/63Z8ooyv6Qv1Hfm7WeEfUjqyBUjy1zCHNsOYJFQxsH7h/3HghMqhKutVI
	4arq7FglFibFE+Tf5eJYstR9GCTt7syjSX5yf9KfpJcf8WV1tlDdoEARTX1TzvPxtl8pWzqRZTL
	i8jxh3j0ZXjE81yOJcgbr1eRDdsngwvZDx17qLsddcmNRiVg8UeynLe1hLZKLwNHwsuqj5wnzt1
	BoZmjQj8qmgnQd/7g6w2F18LjKNBvJMZRBIhx+8mIHyznBwi89aCua5IBNb89MzeD2adyPTn4D+
	vK
X-Received: by 2002:a05:6830:6303:b0:7cf:d213:7ecf with SMTP id 46e09a7af769-7d591c34977mr10612976a34.32.1772485657247;
        Mon, 02 Mar 2026 13:07:37 -0800 (PST)
X-Received: by 2002:a05:6830:6303:b0:7cf:d213:7ecf with SMTP id 46e09a7af769-7d591c34977mr10612963a34.32.1772485656877;
        Mon, 02 Mar 2026 13:07:36 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5998bc31asm7449967a34.23.2026.03.02.13.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:07:36 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260227042128.3494167-1-karthikeyan.periyasamy@oss.qualcomm.com>
References: <20260227042128.3494167-1-karthikeyan.periyasamy@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Remove the unused argument from
 the Rx data path
Message-Id: <177248565575.1002715.17420870053649610191.b4-ty@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 13:07:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: gEJYrjSbi6_ayjhxtpwRodjpE9fzIIiJ
X-Proofpoint-ORIG-GUID: gEJYrjSbi6_ayjhxtpwRodjpE9fzIIiJ
X-Authority-Analysis: v=2.4 cv=Hpp72kTS c=1 sm=1 tr=0 ts=69a5fc1a cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=LVef6NQiuxLdmPMVh7EA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2MCBTYWx0ZWRfX5ci29PyKEJnm
 lYul33ejnDrsCTLzFvPu9yFDHcZO7GbBkp8jggkEDU0lh77A1r6B3Y6Vobos6OpVtP0MnEDO/xH
 CBvZU28PmATMoOvNewf6CxEoMJoyXIAxqumBMuH9io3tXwrEtzVjLkaS5mD+54rFiyAt9J937QJ
 2c9nHwV8ksr5258sIeyuys3cOezuTJ07h0UVfz2bkxnkQQKNQCV9KFx/FiVaDLYciWys8izP8by
 FKIVbxolfTmrcdNBfGf4651WxkUTE8HACjN5EWDuA2FXVvLLX/SiyxpZE7ah+AvP0TmV68MDhfl
 vJpaTZj3cBLqCmG/5A8gFDx6FhghhOFOvoXSgPZJbaI8+52/2Q3aAowooryGS1I+clEGdI2eBj4
 Me3/gp2dbipWug3FpBjVdoIoY8+Znf/oTeOdyVd2fQ9rRHQQ3sZ4HHyyzXv3Bajx3C6y9CkHxUI
 /Xy60Kvdfm9UgYcxBbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020160
X-Rspamd-Queue-Id: E53451E5908
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32360-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Fri, 27 Feb 2026 09:51:28 +0530, Karthikeyan Periyasamy wrote:
> Currently, the Rx path uses new infrastructure to extract the required HAL
> parameters. Consequently, the HAL Rx descriptor argument is no longer
> needed in the following helper functions. Remove the unused argument from
> the following helper functions.
> 
> ath12k_dp_rx_h_undecap()
> ath12k_dp_rx_check_nwifi_hdr_len_valid()
> ath12k_wifi7_dp_rx_h_mpdu()
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Remove the unused argument from the Rx data path
      commit: cf7cbf97c630c3414302945617b8ac405e2b0dd7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


