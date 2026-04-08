Return-Path: <linux-wireless+bounces-34527-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DxTII+N1mnzGAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34527-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 19:17:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D2D3BF61E
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 19:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 721623029AC3
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532973D75A5;
	Wed,  8 Apr 2026 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VMBXpyGx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XzWuq3NC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076523D668C
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668514; cv=none; b=gYuppSp+W6h4O8+zqhtr1YR1C3nm0/kFbJmHRjW7t5h9t5ePQfOtPK5h+J9ZCXgNC3VFJuIH/bYjMSDVTBrvkoiUM0PXib5xW0OniWEqF9OGMw+ZPBiVFiGYHGkDJgZJa+V6gnny+vGj/LLc1xQzEEPTmpGveaGfnNz7DZRB7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668514; c=relaxed/simple;
	bh=nh/U9xN6LkQ/KvTu465vaWXNTfMFIKFvmSb75M2Id90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QQ4XqR+INvKFsJWSOq5UOwaGPqrkXzM3ohSpElSZ4zTA/FSLGi1f7pRhvK6zjSw5siF9tovEaQLW5rSFDFwqEYB4h9org9wMLk/6ntlPycMvjqXcV5lYjB/mDwwTbw9+AxmsqoOUcCw2hc6u08vi+uJ3rQemH94FY4lE2r15Jl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VMBXpyGx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XzWuq3NC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638GHYgU4051444
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 17:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eEX0eT0+9Pfr6i6e4HPyfeGdSAUc+2Nxl9Ny4Lo9MeY=; b=VMBXpyGxVNWwe6oy
	18Ef2/MGEVePa27+QQ3YRBkIFvhUPfQpeEMHsLNwG3C3u+D5tDBibQ7LwE3QPh7S
	zrI7iOEsCKey/VhkfFnWr/VWWW0nFZ4Gae2lTwH8f4P3k5GcneQ85znvPzzBFfEa
	lPl5hg9qEc90RpASLMzjApxmTfL41IAt5PM4rW5aKL0Z7baJ0OzbXdDrILCN7P16
	sFVbNVKosp+CZnYwQqBSWG8CFeG1m4f/hAQj6BuVoHrRrbmwBkjfc28v+/s7RJvO
	Shs60masP6S+2Fhc1HPDHrf4fuLmWNQ3N2kJ8eeOwvJ845GPM/XChT+gbQbwJh6t
	j7aiug==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtd70725-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 17:15:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7422397574so188844a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775668511; x=1776273311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEX0eT0+9Pfr6i6e4HPyfeGdSAUc+2Nxl9Ny4Lo9MeY=;
        b=XzWuq3NCB5SeLDCoV6DRmcejRK6V15W0p2bPROFdoVHdvhGR0gny60wX971LOqLLn3
         CpgcH4SfmPhM2NliWOXZC12/L3GRBZ+WbdWpy1WmftH8/8HIbVlGDvEvXI9y37+0uCST
         TzH/+rOoYa3r9/CSmkvDTkMjiN98zcCq89cJdyws8kJNpJQ6xKuNDLqRxEK4YzP88FEW
         zzw/q2BF4/wAyjhVOnSm27hVUlkQ18ZdfvkOUKzwGEBk5v4fQaFd/JPyiIQkR8nGCCFM
         RlCH6HlxdpzJCx7KzIzNyahe+NnSAzBZXjQyrxH74SHbhZZUBH5FTeFPVVTDnJK+46ZA
         LEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668511; x=1776273311;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eEX0eT0+9Pfr6i6e4HPyfeGdSAUc+2Nxl9Ny4Lo9MeY=;
        b=HY6D2HqKLSQo2ki+vmi+Ls05wVmlw/WqMxs36k6Lrf+VlfOwCTQUeUOC/jPvD/hRn3
         o1hzTtXqeFOqURIouxD9RegS/9vMmi++rXF2Rm2YQH7sGGTXWiAzkv7DTKW3hAzzKXwz
         2LmJXoWfYj953bZ+HRWJwhwiYGx7OZ2q5PC/jAQM6fFSWmgGxtd42vy9KYNkrOoOiirJ
         Ku00DZYJNhnCwD2i40v0fTImsRjVJx7bEUEWKXFvNn6sUOPXGhwtze57qbEaOQU3ZNiJ
         mfidxvx+ImUW12vfEtKZ7f3315S5pL4gXqGgmVO2HQR2fN5xc4F0ZtZBg17r5c/0xZgN
         tXRg==
X-Forwarded-Encrypted: i=1; AJvYcCXJNX99gXHYCyyvc2Qnq8M+xb8EuU2hFH5A6q7vZ2hHKv/tIl7M92jo1DlpPfniENIOCBB5Yqv/D9hHr7w+og==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDbqSDaR1TjRI/mdJmpA/lNsrDSpeCCHNqgMe03xLGmvFsuFDR
	kxDUQTl2iq3KibK/vAFm0fGbe0XnxkPr3zAlwwGwTWDQOIn7H3egIkbRVwoytngMVmliC6VgCal
	IdyAbKUF8F6ux9t36NM+ChaSoYMmQHeEQOKu35MEqcg9tPIbPYMgz+G5IQMP6qnR6CHDlUg==
X-Gm-Gg: AeBDiev7prCquwnfeyywW5eglkUUj+ZLsb7fPlAl221AOUIL2ZRLxRBCd4Zj+xsBcM4
	ecbHKY+/dZX2vBF31YFUG40Av64rvS+ERlGNuWeSg3rojcEDp8Y4Unehn4ApE52/kHHWZUwrpRU
	MTNjy7vDvMotaWt+VHnCMwdke2JuzLDzfU9ki4Gxs/bmxHYwUEmB+JXqhrPm7Se5zTlSCfLs8R/
	5esvm920rB6xk/v8ZAoniFS1FEMeU2OuwBEna6SAq5Scu3uljvBoLBgQpNHBOqIDMkMm6DHveia
	BaB7709/vbv9e0CPhQOx545XTf/sj4uGa12sUEgvkjs4gJH7Q74Me0XJFl0amngfj4WQV2s8xXh
	s6+rev/bmNrqI4SR4w/ZZ1bAn7fOiB2ooz3/cleSTHzDDSjbju6B4ZFu9+G1O+zDfmelSlb8U4Y
	P2
X-Received: by 2002:a05:7022:6ab:b0:123:3488:899f with SMTP id a92af1059eb24-12c28c2d224mr128638c88.32.1775668510868;
        Wed, 08 Apr 2026 10:15:10 -0700 (PDT)
X-Received: by 2002:a05:7022:6ab:b0:123:3488:899f with SMTP id a92af1059eb24-12c28c2d224mr128609c88.32.1775668510171;
        Wed, 08 Apr 2026 10:15:10 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm26103624c88.0.2026.04.08.10.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:15:09 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Paul Sajna <sajattack@postmarketos.org>,
        David Heidelberg <david@ixit.cz>
Cc: Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
In-Reply-To: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
References: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
Subject: Re: [PATCH v4 0/3] ath10k: Introduce a devicetree quirk to skip
 host cap QMI requests
Message-Id: <177566850912.1322920.17816533595535960130.b4-ty@oss.qualcomm.com>
Date: Wed, 08 Apr 2026 10:15:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=QoRuG1yd c=1 sm=1 tr=0 ts=69d68d20 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=XIgAiO59-CApRadi8WAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: kcxG__qDY3wpy1ZOZOpin1iONJxV-GK4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE2MCBTYWx0ZWRfX5v+KiGqwDSHp
 5FLwMW+nQOY+JVKye1jenYDvZszLEmFoH5iHohhgGvdmA5ZvyGEntX+iK2WkS32pRAxA9INhcKg
 6vADxnUWj3H9IN5Jy6Uk2Po3+0NhFft3Ezz7mZE4Iqg+YoskhXNmq1cZKVcmg+1SyAm4YIQHv/M
 umoyiICmKLt+zuyD9mrlAKUc9HzhU02vXewh6tdA+QqzLnYB5KQD6yQBCEJRq8CkPNPr6ebHWtW
 ycDtenuNZ5euJdFkNzqDyr33zSLMlRQxiITUleL2uYkpbQ1ArOST7KaakPhSU0BCA632O2gx/Mt
 kbvd6s2FmcxgrasRZG7bKiN7C10lSPZcTjQ3QiAD/FAz4RUNw1iodH1zYlr4n952CB26k3uXzzu
 LyihNmuHVw5r8wWu1uDrJ4fq7Z2WRGeo0LTVnDTHWWVE5Utk011mLkVrvtMpc1XqllGnyJiTWdK
 AMcAYqVWVpUgMhpndkg==
X-Proofpoint-GUID: kcxG__qDY3wpy1ZOZOpin1iONJxV-GK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080160
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34527-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C2D2D3BF61E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 25 Mar 2026 18:57:14 +0100, David Heidelberg wrote:
> This quirk is used so far used on:
>  - LG G7 ThinQ
>  - Xiaomi Poco F1
> 
> I'm resending it after ~ 4 years since initial send due to Snapdragon
> 845 being one of best supported platform for mobile phones running
> Linux, so it would be shame to not have shiny support.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: wireless: ath10k: Add quirk to skip host cap QMI requests
      commit: 3d7640b6c371a1795e6d9580695d20caf16be9a4
[2/3] ath10k: Add device-tree quirk to skip host cap QMI requests
      (no commit info)
[3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable ath10k host-cap skip quirk
      (no commit info)

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


