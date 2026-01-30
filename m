Return-Path: <linux-wireless+bounces-31375-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPytGj/LfGnaOgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31375-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:16:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 979ABBBEF8
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5A1C30106BB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91437646B;
	Fri, 30 Jan 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lKcbldHQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U9iNZbSR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C84367F28
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786141; cv=none; b=BV9XjRGokqAo/ABKFHwC6K0sO9MzRKLs2xTGdYBLrIhEa25GOSt5oTVLkVc8O0JwNP3BcgEDE7Mp4GlqdR6MLIx16GgIQRIk7ACKW40ELQK/DDfTPUex+nFr0TQ+9VtQu4Zj2+JIvCBhBDpqWN9ANkdiyDGaMHqox6vECVR6q7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786141; c=relaxed/simple;
	bh=3avCcRgvlxmpfE2Y0b7FVNe5zWN1RWCact2En/PDQXI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aQTn391iGGkpjZgzmo+VUHIX7vWs+P2FUwU2rOWq+BU3lfMh+KHgX9a2K7O6qQtarSq5YAXmAvTqKQq8Qz/YtjQyusetnrOWNAXQKyhFLqO87dGdMPsBQEjeTk/hkOoQcHR6wosomtJohRS/dvqg+wecGEzCIh1aCxpHdMfkH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lKcbldHQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U9iNZbSR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAZilZ1488340
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DbshZACaI2TpgweTBaG0IrkB/gEbCmAGAJhjyCn4Ijc=; b=lKcbldHQhpSwq61E
	u+kGUfYX/EjLX0cujxO7mPvaZdKVLAkvSsz2szdGgnemisiREB1NANcTOzR+DbGx
	DW9F38RTwKxjttj08t9DqWyo7Q/R6jVzCyZYqFQGj0VRDaoMQqoVc+JTTdhC5j8V
	xohQoMuB/bzbks1y14YYyq+eon9g7mAbHatg1fazj4vL0RKnB/Ujz9ZR10j0E5Cn
	hNgjlE0Jv28Qx27HYEtKQ2SpShmXK2LHMVAECiqXudtDWt2s416se+McuHvawXXt
	C7rDZT9KF92fUAR8hSu9YcQcuLJcqzElAzaInmSwtBuH2oVOjzTvf0j7HVJcVnUy
	5Cx+Kw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bp3unys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b715b26fc3so3140162eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769786139; x=1770390939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbshZACaI2TpgweTBaG0IrkB/gEbCmAGAJhjyCn4Ijc=;
        b=U9iNZbSRATkIWt3IIv44j80aCu5HfoUDaIArPo4Wh6cTCOCHbafp10ga/flR5G/oxv
         7H0Z2ZwbaYmtOQtYTWZuWB2UPzv+jWY+c2W+UMXEdiRuZlGD+T1tj2y+utRaBIlYYfV3
         AxQ+fx69r2IzTKi1Gv4yp3NdsHNjaocprogcEw1wm4uvWnUJ9uTcr1vDiiGop31rTPyS
         5LLakwrkQXmPZP4MGvyIS6x4SBInMZ0EHNdSaPF8fE/5HIqpv0rDwVukJoCNBOc5YEqB
         emM8NdwgfRsrR/HXw7cViFYk50hiVeQDJ+3wANgfMEJXEktUX6bte2kDKyexW1XLPsLj
         V9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786139; x=1770390939;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DbshZACaI2TpgweTBaG0IrkB/gEbCmAGAJhjyCn4Ijc=;
        b=oMRVjezRmMSWZKA58CS10+l9fU/1RGz7Bw5sD49D/kL9Wfaf149uPXSao/9CUrcJR4
         JUV6KEu4UD5xmcTERrT8sVkFvoWDxyJW/df5feA4uD6mG/lLW+M+s6Zeq02tgSlV2S+7
         FeWNgx+hgmcPWnvThzXIMx1NZ5rGae0WDaOzVlzC9NH4XxKi+bYbhfkf4U2/s9CqDGw7
         f6mnuBUHp0Ck8849QadLWZ3hDSvlPFY1suzenzM84TD3LghCw20J+gLKlVtQcClj7mb8
         DYQdO0umLeugU2lMqv7Auop2ZrUK+c+cQNNuxBE8lqTlihcIFpHCykB6XXe9lW4aZCre
         pSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeqeMMHOcdLj7mgvC3mgAoW4wdK4YT7uRyZ+WmkmQSi73Pr+oVoxy6M1EbDEN09P1AZ2uviMJa9zulYmAfnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm52W7OhX6Y3+Bk6IYOiCIoOUhJWZOfk3yOYIfP3gl1wl2JTIw
	pqVCvesehY/kybqSnlK3kvqCWo6ONh7sfg2lqLp9ER2vu1I5P0moVMwXz3WueaN9y9QxE9pMOkG
	oEnJssW5VgHsnWKrqzXQqBAK4uXkhzEkxT27YigeWImpSF906FNoY+hHaMr/bW+IJnE4hzQ==
X-Gm-Gg: AZuq6aLZkYJZW3aEel8SpPLE6Rh877p2rPIMXJu1XtIerlqm4MHN0Bu7wVEvzUeJTO0
	CZ4A1w0tFK9ZUGFYj+rRzVZ79tqSBRDHmgIRHtNvfEZf/VnGr/cVijoiuYnGUBiHdNygECaXBN1
	oFdqtnATXWwkmMr/wYQZxLZu5/0x34yDMINAxF/C+4linTH+bE32xyeAMwAhq74K/zb0eY71OiM
	w6zuLwaXwoRiARGcIMBiXgiUEGEltm1NEHb+wsAUcrNk3kaEEVnCITyHn8ULIkoITj8dT5C4mbr
	1mHdmRZCoyjyk6MArjhHSbwfB0Zm6C6OxlgXp3Hb0aKAgoX5QhN4HFA/Ruc3L/m5GByeAN/U7OU
	Hxdn1J90wKjDbrAbOfBOn+xevSUZeVckn/FUSaubf+YaUNkOVRGM+Mxgk1NmvTmyS
X-Received: by 2002:a05:7022:160b:b0:119:e56b:98a5 with SMTP id a92af1059eb24-125c0f95977mr1556929c88.12.1769786139040;
        Fri, 30 Jan 2026 07:15:39 -0800 (PST)
X-Received: by 2002:a05:7022:160b:b0:119:e56b:98a5 with SMTP id a92af1059eb24-125c0f95977mr1556898c88.12.1769786138469;
        Fri, 30 Jan 2026 07:15:38 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f95asm10252849c88.7.2026.01.30.07.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:15:37 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonas.gorski@gmail.com, krzk@kernel.org
In-Reply-To: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
References: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH v4 ath-current 0/2] wifi: ath11k: add usecase firmware
 handling based on device compatible
Message-Id: <176978613758.3951544.9836085450267342032.b4-ty@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 07:15:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: jyKDBRLdgeS1hJRN0aXPDxgh8DFadu4y
X-Proofpoint-ORIG-GUID: jyKDBRLdgeS1hJRN0aXPDxgh8DFadu4y
X-Authority-Analysis: v=2.4 cv=d6T4CBjE c=1 sm=1 tr=0 ts=697ccb1b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=EQHXZ3lbxlMgNUwFsMcA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNSBTYWx0ZWRfX7GP0E5eo9Zft
 JfJNT/QBQ+kosiYfnROG7Cv84H+CPqLaw/3BeK6TBR8YXcLI/Wk2OzRUV00X42dCr8+F9wfHVnQ
 ZdT2NngilaN0gKoJzYMYmCLHkYsB9VfRh4vE6g4nme4xeHvks5eVeAi4l5B0Ajr8YbqBOVJYlY9
 lSux9i8JF6oZ0RPtYPXHvkOPY3Ezg5mQncVW7M4pVwjRUZdZMuKgHxeH4QGvRFc7e3/UoGkiFNT
 hZZxoOMhPAnYin9yu+8gbVfFlTagE4lEpSCK1awutohc/Go3EQ+UMCEBi8rZI/QYnVtLZUqw+1G
 OvrVYr+GjHPC5Q95i+LI/LT+XjPhElC0lt0/NtN/wwlZoHZe5IZUG0CN+1i0C6NhRSotVVpWD8Y
 tbbJf2G/MaCTV4ECmPf9E5WoC0sjkO9VEfFhFQ53PAiRzZJ4U2tJUazB5km3EzulMWDvpZatp6P
 OoR4k4E+mBFPDAjbBnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-31375-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 979ABBBEF8
X-Rspamd-Action: no action


On Wed, 21 Jan 2026 17:50:53 +0800, Miaoqing Pan wrote:
> The 'firmware-name' property was introduced to allow end-users and
> integrators to select use-case-specific firmware for the WCN6855.
> But for M.2 WLAN chips, there is no suitable DTS node to specify
> the 'firmware-name' property. In addition, assigning firmware for
> the M.2 PCIe interface causes chips that do not use use-case-specific
> firmware to fail. Therefore, abandoning the approach of specifying
> firmware in DTS. As an alternative, propose a static lookup table
> mapping device compatible to firmware names.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath11k: add usecase firmware handling based on device compatible
      commit: c386a2b1068910538e87ef1cf2fc938ebf7e218f
[2/2] dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name' property
      commit: adce4fa499611c1c6eaf19d6fb0305ec0731d06f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


