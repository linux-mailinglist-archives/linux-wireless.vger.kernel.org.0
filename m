Return-Path: <linux-wireless+bounces-34497-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF8JCFum1WnE8QcAu9opvQ
	(envelope-from <linux-wireless+bounces-34497-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:50:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA5F3B5C48
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE4613027DB3
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 00:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C3110F1;
	Wed,  8 Apr 2026 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WUi+BZ+1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Picz4vVR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254632EBBA9
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609431; cv=none; b=Iude1g8szTMZPDsLykthM7DQSJnGdrozrYhcFF1n+22nf1bRC2tInj3Hi3IFuvRMprVIiSYDG4meytt5FTR8X28sFoDfzfNDzVLebUlhm6OazVkQJYIH44ImP9RKPgZqAarNyVKmeMYk0D/UmLuaLWIQ/aWtvrokWLZZNVC+sag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609431; c=relaxed/simple;
	bh=qYF0E35YUdBJp7OfqT0QGBxYEk0EmRp3tGYViOD1WJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VkUs/yQ8qQjmx1oahSD2ODDpV+gx9Ukw7FPtss4yxc2sjB/tOMZFs5MWCJbUE6gIByKm36wBz30DmQItNNlnnmLcc2HgIC1FDHOKdW6bJeznAIOfOibb3oskHi/hQ5NDetKYdZruWyrT5DTNeL85jI76m+MJU42RC+ZfWd99vDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WUi+BZ+1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Picz4vVR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637KOA4k249513
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 00:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q/us5c8Z6txQt4vML8JPniKku7wXE456bDjUT+1dlC0=; b=WUi+BZ+1DX62WVt6
	BdsNSHMCboDKGj0SgOSuFAXFonkIS3o32RXWpFZtyIlm+iuhj1my2sLRMTV6CJA2
	sJXsdsTTHldTInDF/pZleIsqLJmUteKqjqbfqFvzED0VlzG0Bcdy62erZx+2mCSx
	rgqqkwzGwUKRWck3G5YDyD4J8BzNwIhwD1j1SDlyZiv9pAGyyuCWSpvOanuZSfa3
	3jr6+Wex2r6ijBF8lmTSCwD3ZzmiJssqGM3KtItuZr+arrtlz9pOMbvaj/wER+5U
	pkk/KWwv41aG9hQvnAVvFdC/F33ijcdfgJ2q/LjrrwBdc7QcXOYhqJniklVS+uKq
	FMyKjw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8x98m8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 00:50:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bda35eab74so396195eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 17:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775609428; x=1776214228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/us5c8Z6txQt4vML8JPniKku7wXE456bDjUT+1dlC0=;
        b=Picz4vVRSIfi/GcURzdEX/Dx+hhaDkjVoKjjV9AB2yMmuZHBS+o86p6YigfBTnN0b7
         Q/MzHB7La/iy3h3MhSkJBno7DhRUfmq3QuGATneAkxR9alf1fKvfgp0JaaJnO78pOUSt
         w0f8GKYb47eOW2hXIVXi68UKlfJ6PDd2Vo5yOabDwrKlMb4sd3hQbFXTEnbaYI4n0GDs
         YVfiov8ZlLLb1yjB8NbhVkq6OtODoHxMfEAiXC5KxTuoBg+2D5zs5pwiMq+aBDKeNUIu
         /VRp1YsKkX17XituhnyvPNx5UUvmP5T8sjsIyssEq/NuuMloLb7CMJZ/5zNm9CtrbjVp
         PZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609428; x=1776214228;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q/us5c8Z6txQt4vML8JPniKku7wXE456bDjUT+1dlC0=;
        b=ASXq3316taV38PsrJehdjEUcmJ62yjzshbAPgFl7BN5Mb/ZVl4EV9CaJY3014vBQpB
         MSZHQvDLmR8QKbqSyM2l0JV4PJ7yqHrY2HYF5QtlUveRpnobxMRuyYhQPH+EZqCSc9bs
         I+UFnH7svQRaADDWOxtcSKWKLRYx1RZXpPNT43K1B5j2kXkYH+H/r70afBrgxb3eFpiw
         YZw8aAfgWStWEGyJz0TVoLvTxBue7gDquX3NTDD0SnqFFSdXF/waiKtsLaq5SWV8P9lK
         dF1L5+X7omNEvWbRw7vBKhN/CwXRlz4cjRejf+TkA2vwLMpID7X8xF/nutReOhMqAhTc
         E2QQ==
X-Gm-Message-State: AOJu0YzFT7YSIMOop4nyBsIP6WeARXKjX2KZiAKAPgeGOhwU6TTOVzwY
	b55xJEd+UkFEHRUupiThdXkhgjJkDArFORh6kUWFK4r9cXNABzaoE0SzLwlabH2vU54fyXw27Tx
	dM973qBYHsBC0luV11yoRfs8h4yH32B+U+EUk7nH7c/kkENk6eA7H0lqO1QfG5qyVAZ7RdF3N7g
	ltbQ==
X-Gm-Gg: AeBDiesDqxU3ArN3I1DluYt1U0u6+u0bMhOlm+/A45GtAM5vy+C7N1MXsH0w2vNEWYD
	GOfSrPT+KbX4JOoIAWOThYwQD+ysJppIPVMHkI/0qmbSk1/6LUNVZ3/ZMXRYpWcbqD9i6BshEmi
	O6ikI1m2nidJNd/l6L47jJ/AIERkHzD4WMRYFtT5tkZ76fJLR8l2997Ctu49q8RRS4D/zBHBpHX
	+OdNkroF4V8eXIMfVQJjzc5LMtETl7bA35LMWobCDqE/Efzo0/isNBsZUbDi63WZjNC2/DAMIEu
	LTxUsbQkqJpZlVj96DfuJFEnUVqSuUzFWJm6nQBmwNBhVH9n3fnon6GeDnXL2EVosVmwgLK62B6
	NPUACn6TitKESYzNFefP1+4RjS3CR49knA7jz3CoXjQ97vZtdR2jIAXNqLubjVXs3GoHxqWkaGi
	9j
X-Received: by 2002:a05:7301:730d:b0:2d1:9b35:4edb with SMTP id 5a478bee46e88-2d19b4501aemr1574107eec.0.1775609427519;
        Tue, 07 Apr 2026 17:50:27 -0700 (PDT)
X-Received: by 2002:a05:7301:730d:b0:2d1:9b35:4edb with SMTP id 5a478bee46e88-2d19b4501aemr1574099eec.0.1775609426960;
        Tue, 07 Apr 2026 17:50:26 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d2d5409fd1sm1257301eec.13.2026.04.07.17.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:50:26 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Avula Sri Charan <quic_asrichar@quicinc.com>
In-Reply-To: <20260330040732.1847263-1-roopni.devanathan@oss.qualcomm.com>
References: <20260330040732.1847263-1-roopni.devanathan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Skip adding inactive partner
 vdev info
Message-Id: <177560942608.2878209.17143932137054668382.b4-ty@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 17:50:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Rr716imK c=1 sm=1 tr=0 ts=69d5a654 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=T1yrVSn06Lq-3bePM1AA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAwMyBTYWx0ZWRfX5k4XacWLm4kJ
 HGqZCwiq7GVllyJ4sNoBXT/vFZwyEoreGSWgJP1hrkiVN+f+4aYblEXu7bMgSxxjxIuv2Uq1lIU
 Cg0xv3mtX1OcCGqA4PzJQd66wq8FbOQqBO+c45lUsm6aJnYcO3P3QoHv7XisJAm8kWmlSD9Db0v
 FHzJ1t/mCZJCojkxwD5gHyRTzNRh5of1hBGH0WBTIz/axwuzOvi9RzxHGylaAwG+bfLLUlnqtDs
 B2tffHrQDy8ArW35otXIMThs8abjJL5mGe11AqoKeeiSOUSzggY/VJkjVatgGPUA1r23y3/tp5i
 S5clh7PlYU++UyukultoEv67C+mi/icg79gY7u/bnLCkhmgRcx6PoYiUirNMEb7GxQBQQJZljpv
 aYU2S7BlLsXGsl+FPSFM0GqE9QP/o8PU49GBN00bvVrLGDn+Pej6Rq+NYmpTPsn6B1ed95uypSa
 Zg4q+oe1h1IOFA/mqgg==
X-Proofpoint-ORIG-GUID: jihGXds9O5f0PiOB0DgUqR4P7gixn4jT
X-Proofpoint-GUID: jihGXds9O5f0PiOB0DgUqR4P7gixn4jT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080003
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34497-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8FA5F3B5C48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 30 Mar 2026 09:37:32 +0530, Roopni Devanathan wrote:
> Currently, a vdev that is created is considered active for partner link
> population. In case of an MLD station, non-associated link vdevs can be
> created but not started. Yet, they are added as partner links. This leads
> to the creation of stale FW partner entries which accumulate and cause
> assertions.
> 
> To resolve this issue, check if the vdev is started and operating on a
> chosen frequency, i.e., arvif->is_started, instead of checking if the vdev
> is created, i.e., arvif->is_created. This determines if the vdev is active
> or not and skips adding it as a partner link if it's inactive.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Skip adding inactive partner vdev info
      commit: 7d7dc26f72abb7a76abb4a68ebad75d5ab7b375e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


