Return-Path: <linux-wireless+bounces-37277-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G2xJZG7HWo/dQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37277-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:04:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F6B622FCE
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62295308F2A6
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BDD3DBD72;
	Mon,  1 Jun 2026 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nfnqer63";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y+1MKNEp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62293DCD92
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333246; cv=none; b=cBNEqYX19f2DqhAdVu6v/I4+yIrUvjJm3A81t6iHzhezV2doRB+YRb8AJFjHseuD/nB+paEictGMwrfq9OEeQBBA+aoDmXNnL9RCvIqilNuntI09Ey/frQD8MS/ZTJe5cifotrLkzBoHdBWog4pmhYooRjCUz7haZqFOPxQTQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333246; c=relaxed/simple;
	bh=2ltdm4Se17Ytwt8dQmXAuiKR0zyqhSei/InRbDyT1Ig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D8JLYaHmbt3+RUCJ7g2NF8/bE6xENal8UtOmQflgKAQ3ycQBufjoMAg0130xhZ63FQTad90VF4GDwP8zo09neNsz624uBFc+g8HsZFCiIQO0g9dsQ6omLum7qEY5vkzPJ/B1+6uqFIjqgFTIXTEhlfDUcLNUXzB/OTk2ieNnnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nfnqer63; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y+1MKNEp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651FVITN144977
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 17:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FmCco955bc17kWMyGDeYhFYeOOTUsIA2WBLdaUViSe8=; b=Nfnqer63y5lByocI
	jQIWypkzL87M4b7co8UyPzeQmZvJa5WyMaeDWhnvm0SoPZfjgIQHhDKP5EmIsl10
	vB+lgBuIMRmsHL6HjmyBZI+IIrsRrFzPy4b65xXTH97FfeU9QnxkgkrVi5PIThWw
	FFHS3ZSqDWuZm19V9li9fBCM+kVfpOsW6xpOhBqMj6T04eUOOUHl8SHZYybEyUiL
	Vwzf/CrddxSkGcnvY71RhBNNLBmCFJaW3zLymQMdStJyp4xGpoBi2ZHeu8VZ9jh+
	n97SqxDxH2eHFSka1jPOpAflx/GDcT4xUMvRhawBgMUrFc6NWoT14NMobjdzMsCk
	zXJxjA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6stt1fu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 17:00:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304e3e3fba5so16115931eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780333241; x=1780938041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmCco955bc17kWMyGDeYhFYeOOTUsIA2WBLdaUViSe8=;
        b=Y+1MKNEpopxnUetfYqGAGkL4XUVBWMF67xr3aOD+3YL0rCD2BarUGbmV9O4rpHkJpg
         XmjdEKfuX1pT7Vg2PY4ply64JJBK7uSrSLzn5dZS5WjCsz1D4TuNfEHgUPmb7AN3nV3A
         X6pubR/UYIlgvzC9u0FdIy2Py7/mMS/tW2MUal8TNbJk/fr/kezzjjQcH9K21ORFL3wI
         r6FokGRVUuotVOFaVoN228UO1P0pxMOK+d1hbDiCqiTzLU88yE0he7oOnFUKQRXO4zQh
         20TG9YrJ4UvcTWY90NqCiqpyQKfDyX3UIFiB0zYFG8nV6jvwRHaxyBBt7tUFipqkxVlg
         VK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333241; x=1780938041;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmCco955bc17kWMyGDeYhFYeOOTUsIA2WBLdaUViSe8=;
        b=kwJJIcTcNmnm5brEI4yb6kZBx488HJsHXImIUwDsZdGVtigmiChgivwhRKv2gS4aTB
         QQLwv+nzgsfld8a0ozau2cMeuL8K+TkjGjVu3hXVQ5DqeBYJ+3BVv3rARMaP0l/hZoH8
         mg+AwPHRajiirdfPbrVC4vtDfH+zwaF8MVLTh3E5/BCoVWNeDABL3aXuHkEtIHbYUaB2
         BtA3+GWmWNDy3xssgTfeuqPO2hCwE1HHl8KgDZI+1d7zqhKsxtrFe+wEy9Hjb+daW129
         aeWzszSUkcjMbgEGGbdViqrFRghNsrmPsSMfymUwiit7bnUiaS6DWS7bwdeiwtUyH066
         55fQ==
X-Gm-Message-State: AOJu0YzZd3rsP8Kr1ZRF4/+Y7VO0VtlY/ZvCLAq3+ICcMaPj7VDwxsD7
	SayDaAsWHqXhwebCxOFoSb0+EjGSqHnrElmvvTX79N2jptC/HV+y2HGOrlfOoUoH4KzUDTjaswz
	QP6LvoRP2Hy/glZvZrRR/JS5iVp5ERIrqfgFlxXHeVXPz1GmJmvCTsH4YwhEyQbqtLTstOy8OJs
	IhlA==
X-Gm-Gg: Acq92OEr6qBwcquehRbFJogldyN3eh2+Cuwv2KHVKNDW6AE3Jd2MWa/2tFV9Gry1Ozx
	ooGzQtnS5TVLNMxsjJexCgV+Vn79LcUpUfmuf3mciKlwoNQsIkTXx95Sr/wc1QvFBkF8sIFrcmY
	OALBQVaRtNMKdzlM/8/dhe7E2fvqccLT7CPfdjLzJb0Yp+IqYdKgx3rGzaCnzTcvzRmVkzUKXwQ
	IihEa24AsaKHdfjrDvSYBLCUIMk8NiFNFXIWh7rBjaLXURtjSIVHUTwnSkx0AKWbp8U8QEb1GkB
	uaqrLm/uGnwWGzS/eOzWocQEPpG4vu3MljUDBeM3hUjIExD06JfNM7aSvJqzGPYXIbCf/vRDmqv
	y2XRn0Dgm6iYJT/rbRr3jYS1QNB6vj4CLhutkyP8iAgFxANfXn5H0pd33x3u2sFc9D8HebDi8UG
	9nAxMXT7y1Wbw=
X-Received: by 2002:a05:7022:619f:b0:137:6781:7dd7 with SMTP id a92af1059eb24-137d4271679mr4471280c88.20.1780333241157;
        Mon, 01 Jun 2026 10:00:41 -0700 (PDT)
X-Received: by 2002:a05:7022:619f:b0:137:6781:7dd7 with SMTP id a92af1059eb24-137d4271679mr4471247c88.20.1780333240458;
        Mon, 01 Jun 2026 10:00:40 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7151625c88.9.2026.06.01.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:00:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
References: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/6] wifi: ath12k: Add driver support for WDS
 mode
Message-Id: <178033323970.2045173.3868733357693878077.b4-ty@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 10:00:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2OCBTYWx0ZWRfXw59o5zV2+FqH
 psFORL4wBmUp8e17GHUMdwjNM2hNuLa2JAzp6RHVGTYdsOWTDU7Rqdvt1CpU0i+/uc8HADxPqwh
 2UznYR1MuQSCEoqPPJgL+VRWAI0KkqxlgKlU7p6kND+dgV/LYrWd7QHW+4wooV1ZjeYB/xaUtMS
 xO3o6z77rcPjmfRbWGea+H3K63P2s816De4//GeV52fkwwvI84W7Z6X37VNxREFkH5ae9jgYTPy
 hLUmdD1MNm9HLbfEG7lTMyKie9cShTq03+iXCsl3NywK8A5wnxGYebmwooQWkuXmYtLVwBCK3H4
 KNVJrScjZOyfuKA+YJPTlsb5c72zqE9bE2FvDYAHgMBE6VK0eEFuoq02MHguFP08NQ3YiyXkylp
 Cs4ENimRTVB3zxr9FsjlGs9lFETMY9kNQpBaGKwhVLJZfztJ47wYHVRILOtSdDGwkeV5vamGyX1
 jiMJ6THfZJBic8QGZRw==
X-Proofpoint-ORIG-GUID: LbPy9WgpNbrMrpz1okn97vc_O4_o6t8N
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1dbaba cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=F5F8lLM9lksX-Kl9fnkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: LbPy9WgpNbrMrpz1okn97vc_O4_o6t8N
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37277-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 16F6B622FCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 25 May 2026 16:39:36 +0530, Tamizh Chelvam Raja wrote:
> This patch series introduces support for WDS in the driver by adding
> below changes
> 
> Handling of 4-address frame formats required for WDS operation.
> Proper setting of peer 4-address WMI param to ensure correct transmission
> and reception of multicast and unicast frames in WDS mode.
> Conversion of eth offload Rx frame to 802.11 frame for mac80211 to
> detect 4address frame and initiate AP_VLAN creation.
> 
> [...]

Applied, thanks!

[1/6] wifi: ath12k: Set WDS vdev parameter for 4-address station interface
      commit: e1125b0ab6fdda21dde19f7be631a477d14b684c
[2/6] wifi: ath12k: Add support for 4-address mode
      commit: 2f57f737dbf3005951a045eb9d1daaff0095f6c1
[3/6] wifi: ath12k: Add 4-address mode support for eth offload
      commit: 729cad3c3c9e09ca9900744fe2a02b25e23cdab5
[4/6] wifi: ath12k: Add support for 4-address NULL frame handling
      commit: 6d0572f61539c5d4e2971139e7b501e37b7632d6
[5/6] wifi: ath12k: Add support for 4-address frame notification
      commit: f818260ac66b2971a2a587ea08b171b135a2c1e6
[6/6] wifi: ath12k: Handle 4-address EAPOL frames from WBM error path
      commit: 565257a857690244211d85593b2cd490ce86783a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


