Return-Path: <linux-wireless+bounces-30886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8462AD2999F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB80630463BD
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C533314DE;
	Fri, 16 Jan 2026 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mr4AHzDX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cWKo9uai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC33328F0
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526825; cv=none; b=W2ySyoZrirnbOaSVT+DlpJrDN6Bs1Z7qNEdlQidsVT4OecILjkS5FmYZHNOr6/j6YikLsQvhFwiCqpzIlUNTeqqDS+lMLiHcB6kgkpgWgag725+DZ1Ppx4sG+DS5QWG0VfFJCWomG1dG20OTJrW5mCL22NUQW4CE0rBmiRLlyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526825; c=relaxed/simple;
	bh=D+AMquHd7DKvyao3Rnk6M3mPHyrk0j6/gr0d+RGLTgM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r5SyP7PjYAScN8BfGSYmuMJG3T8fQFSLGQn4n7o4frFB+eWO1Ka/uymx697fKhQxf2sd/vHl0Y02KkKPjsy2Yq9ckOUZyNm9C4UB9b9RlBlh3L8VRDiQUhiJbnGhGMjV3zkBRh9OSvPfff7Aut/N4ICQIsKWXlZZeIO/1uv13A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mr4AHzDX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cWKo9uai; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbOAx3714330
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qbJ0E6T3LBvjew4aO3Z1wvMfZiBEQELCcotF0vqyonk=; b=Mr4AHzDXT/gylJq6
	ixk5UyBjb2/uWLl8/QyVoNmZBRZ4/ewOVYNOaieK95VitriAsaci6CarTIqDL5I7
	QhQCLi1yNknrf3eawBfG7JrbHaDlJCtNn4Z4rq/08i1kpaw2FBeDD1bUHR/MswKk
	RpyBUsuCH37t4Bsy1k2iAmZD+nQDXuGAmEgZiTv3rG9MQkadalXIomNHyavsXavk
	01BSjeMk/LY7CWfw3+iYDoFh77+LSN2pcKvGq1ce4v1hpV4djxoiH7vCuM36eFUv
	O4gj3YrgW+GBT2RszeDiD53BPu/xlZXi2kGyyPnXY41XjwBynb0q+rc5pkvaHX0m
	zC+23A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96p8b51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:51 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-123308e5e6aso2880616c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526810; x=1769131610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbJ0E6T3LBvjew4aO3Z1wvMfZiBEQELCcotF0vqyonk=;
        b=cWKo9uaid8qucpr26fnwRFvhfETmrtv6ZyNAWRyRSjKwhdn+a6YRAR5ZFhbXF0gWex
         Qm6EAPPY/ntdDGt56Zqu2HUf0rzemmITOuutxQS8oGm5P8MBLxA+PI5NKn1uPvOihkxL
         O/vM+Kkoy9crcvtZe/4jVRW/nU8lQSnhxBvzMK4cDInkfSTU/Bb6SbEkG09aVVJysPnr
         /tTJlac45OfiF8U1akSPUnSTndubpeTrzUgm6jW8iOJn8bF21HIWDpzu0jpdEZZ4A4vO
         T6Wrnkq03jjL1B3WOl7tYEoJeIJOabSv4Xw19emGo2H3RpdKT09+991+6PwmZBEMNz5W
         eQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526810; x=1769131610;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbJ0E6T3LBvjew4aO3Z1wvMfZiBEQELCcotF0vqyonk=;
        b=UcVuy2/rHRhK69A6BSntC9yRxYPIeyC6Gxa5FXvmNur61/ogjPmFdc2Dlf6xXIK1hO
         LAEuXzsurwi6LVfdmYJm8A4i5mTuVfe+iJPNHBtY/LhG5dlMWIDRDoJSx5bc0wndvtXs
         YZsMOpGt++BoeQLUHZNp/pz7N0vbvXySO3H4io/unmfy3Pwd2qHg4uDmZZgIksr39rEw
         4kaQ7ANaf77oW7BHqkenYin2bQH09hI6DKWxArJFKP9KVLdjnHVH6Vvk77AcscCHmS/j
         fOTGbzM9vAEYUviduXlOF9n6oW7tEFaZCc025g3Yyq6EP/RYZiv0eJv5V5kJ3JKXq7tE
         +Cxg==
X-Gm-Message-State: AOJu0YxNQs8UWASOWgpQklRAiKvqCZwvItF3cb3Wt5wt7VL9IsQVr8B0
	a48iL6cjM8btC9HKrWd/cKlehzWIuIW+Z4oFoTOj1HHfnUR6dSrBYxx/uLmx3ttep6SQ7fOPPLf
	5XBTKMS3ELnkclPMTBgtTp98CG2hLL72kWMbHRnS4WqMotLizyq4jAWnJV0gebZzlM6aASZIJcO
	jcew==
X-Gm-Gg: AY/fxX58/uBvnhvi36EKp+U2y4DOBggPAApr6gfCpUUPITPQOq3JUHCOHTSQqQLTkO6
	zb+RfJQTCf3lL59WSyiDgB5NZR6gkaIcABSzaL510upCsB+v/Sr7VEwPb8Pi7Van8bBlnh/CdJb
	FUcYJ/9+dVZqEZM0ZEpTkvQ7DsA1OVC4+lKd4hDPGNEeRn04gwqrNanAqLXHxBVJb3a5aTZIj76
	O/wQjrQs94udhZQzGW+ZBDnj+0ZD0Rps9p9f8RfRW7omMCxoB24VjzMoJ32G5FPNaYv5WQ7Eq8h
	vDrn9ooA19OM3Q345eUHm8yPWpkYW0adKNkCDI2VebA0oYvhqhN9jwMIA95DizO9bidPPC0nZV+
	Hs03GD4Z5/I4O42zU5imZiEU+y/prPFzgexLmJb9iSSkwwn3Fola+H89xlNGb9M3G
X-Received: by 2002:a05:7022:6b99:b0:11b:a892:80a5 with SMTP id a92af1059eb24-1244a6e0ceemr1558429c88.13.1768526810241;
        Thu, 15 Jan 2026 17:26:50 -0800 (PST)
X-Received: by 2002:a05:7022:6b99:b0:11b:a892:80a5 with SMTP id a92af1059eb24-1244a6e0ceemr1558415c88.13.1768526809722;
        Thu, 15 Jan 2026 17:26:49 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:49 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Alexander Minchev <adminchev@proton.me>
Cc: linux-wireless@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20251127072839.14167-2-adminchev@proton.me>
References: <20251126170213.27959-1-adminchev@proton.me>
 <20251127072839.14167-1-adminchev@proton.me>
 <20251127072839.14167-2-adminchev@proton.me>
Subject: Re: [PATCH v2] wifi: ath12k: remove redundant pci_set_drvdata()
 call
Message-Id: <176852680902.1143034.13916014376553790993.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX+GYDXZbPIlAq
 or04q7h2d3JDfSt6i3q0W5JdIzD9E4n/o+IIQxz0fBbz/FQXjnbfhZ5KMLZ6Jm5ALtCckuRcFk5
 6hKsGYcRGxNIVL8GZhRwe/ZE+sb7eVKRaY37WNKMjHHcYJi75xtzgd67cGLJInYXqSdApS6OxjN
 xHF8S3rQd3cQW0OnPmLa6696w3PhtZbunuH3YkMISVZWz3KFuJ5aBd0tlkaoqn5CmRZaWN9DS8l
 6nCGL4/JVsRGFv+DyUVwYQW1zSN6LAlSLG0fcbMgFgrxczuyycM0nre64TXxJErmLzVBmzpm3HB
 cC3y2ucb26AITjnywt23a7xOZxq65rrs/FJQaYayKXIneaCR0FGqDl2D6LJWiEqC0K/bFBpicWR
 4wV2ETj55RMkthEirDez+8xyF/pzpLby+ZnZejox16m05BnRuLSKnSrPIVFcy/zbFWVCrYHXYNK
 vRVtx5/ooP0lD6o++qQ==
X-Authority-Analysis: v=2.4 cv=M7ZA6iws c=1 sm=1 tr=0 ts=696993db cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=nlFqCsrgqNAn5X4r5XIA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: zzgG5YHDsFylvYlYMNgVt9cM7UkshPCR
X-Proofpoint-ORIG-GUID: zzgG5YHDsFylvYlYMNgVt9cM7UkshPCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Thu, 27 Nov 2025 07:29:37 +0000, Alexander Minchev wrote:
> pci_set_drvdata() is called twice in ath12k_pci_probe() with the
> same pointer. Remove the earlier call so drvdata is set after
> ath12k_base and ath12k_pci initialization is complete.
> 
> Having two calls might suggest that drvdata needs to be set early for
> some reason, even though it is not used until after the 'ab' struct
> ath12k_base is fully populated. Even though exact placement is
> not critical, keeping a single pci_set_drvdata() at the end of
> the initialization makes it clearer that drvdata points to a
> fully initialized structure and avoids confusion for future changes.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: remove redundant pci_set_drvdata() call
      commit: 8fb264d1a0c5b3feae5f492ee2bc2997b71b63e3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


