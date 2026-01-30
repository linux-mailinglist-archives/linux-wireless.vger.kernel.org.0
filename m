Return-Path: <linux-wireless+bounces-31374-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEnYJybLfGnaOgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31374-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:15:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC743BBEC3
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 836E4300B461
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1A353ED3;
	Fri, 30 Jan 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gmy6svRU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gDCeJ8X+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F882857CD
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786140; cv=none; b=rKN8AsOe1NAhbvLrhbRwPoU7GiyUCO6wIcyhn7qdDtIIV1HvklVteUPc/MVH/mIb1qbDA6FOpGVKVnwyZctM9i+w9GDPHWx+ftUH7uUlbPfER+ugqaf/VQFXoLUCmUz4IbrZ1EokNF49aax8Xb9w/OXdI6ebWCNfJQnEJ/ub69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786140; c=relaxed/simple;
	bh=QMaFrcjLt4waT97iMzumzlM+XY3F1p9RNuu8D7U/QZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jDSzj7WzThQmGhKS6J/gBvpTh0+H9w4/1Bndrvfj13nXrPg27YR3JN5PEhHIFRozd4eUNAcAgSL+emV8ZsrsqZfBPmI8cMQNxY8pSE8svf4M40ZDetPjLr4ZHXDrTQwSqH8oG1uM7h0SSX8KIDBwC1Jd1fN+iDM3mFU5pI9+6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gmy6svRU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gDCeJ8X+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAZq2W1022153
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mIZREWITnjl1/FIFaSe23yCY0lDik0S4hWoOA7m7i1A=; b=gmy6svRUWsYWQg1H
	gWSRgxZf0Y0BcJ+NOrGdoSUG5V7/ls2X5r52gEI9QycnVMPVifK48Mrt5GBRwtLs
	KZ3AGcmmf7/Xqp/htdSQJ/cD3kp+iTy2l3RzxfQdC/TOFRcZsgFQoO/taFNk57Ke
	tDWiLOow69qFqk1Drw1xWQtl/UibG1/NncZpP/UJOIGGfOQtt5f3wKcXO+eIrhlA
	DBpvKLoM+dSTgfW7Z3KbAtoZSTG8XrBEvVlUf55jeccCvNcXGen46bcVNUjj+NoM
	Gaez8yIhsu4pQ4PIRdbeMF6L0GPKcP8pNWJvmI3YbhesqEqYOCjZISXxuWc8/qbm
	OQjBKg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0e3kb20n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b71c5826fbso2566279eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769786136; x=1770390936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIZREWITnjl1/FIFaSe23yCY0lDik0S4hWoOA7m7i1A=;
        b=gDCeJ8X+QDm8FMscUWiCbTh5m6rXlpxg8rz1LlHncSpIs9ivh6/5XdGPCdWun8LJit
         2Q9S2s5QQ92FoxEDmkiaLFsu9lpQx+y6kLmxmvO5Hx4nI2guKNT/EqB3wAYYpEqES1V4
         QSYG/LP2Y7Gg1JW6V1gtkDnGxbIuVRv+u58tF5+bcGnd3d1RuDIKnHylX1dgBbSYJhju
         3VWLiT1yZY2h9pjerBaY0qd2sYpknBO57pWg24ZZYTZX02rZpDOOWi3hhKhIz4KAOb4X
         lCuJxLzQ3WgsE00cUxDuqykf7HgT3CDRWAw+DK7VNPzglggZ2dk5SyAK8pjPwo5uRV0n
         oUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786136; x=1770390936;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIZREWITnjl1/FIFaSe23yCY0lDik0S4hWoOA7m7i1A=;
        b=Cx26V47BcT286eyuOco6jEYQJNba+YZDjeB144rrGB1RGTFEK1N+4JG1mg4/g1Nd0O
         u1LNqjWBaZmH+0KYIKpuOG6paeoDUzkE6ZE5D6iV2eBB9CZjXqTnhQXNCJE7hRVnMWvB
         P0PH6Qqym79krGJ98mvw6WGfoENbztv45T/RTD2aOUMiZRj20RyQ3iIVPMwhAStb0DOm
         wO7Cl380uWcPpL+ww4s3u+M9/xqLPhOwHvhK1RpsVWBVrjsBSO7iNUOE9wpM74zA6RNe
         Onrrbw5RPx/s4rtfElZFNEI5+8WgVTeYBSjG8YBb3o6IuYKbNnFM2291lXIDf7wiTDcD
         6ZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK2LZrVbvfbqlob+dCm7wTf3vCzCtjc+DMPJzWZBpZcAhN/buOgsSCyh0e4iPaMkMyF0iR5/gkTLI1NHkj8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kHH0MW/41o9DFSrJhjHyN0K/jVvg+ztutRugmew2Qms2VV8a
	5rvzmtZk3YrOegXTAQ9lw88ISXOKxzvWX49/afanylk5q4uHUjk83OWC2Rn0RsMwCwcvR5elKbp
	qko1Pqow5rlcJwb1+4pevR66CjTAUOUr/qZsjlYwHVPXoEOKIK15jRR32T8Uf7qiwsE9RjQ==
X-Gm-Gg: AZuq6aJB+EyhBtC4kKF4bcwkrfukNX5YoCpeWsLr4q1wcvzBbgLVsD3uzxul1VMDEQ0
	R9yCp79hZoKkcRWHXdRcY5SdNhVVWCUI5yFN877MI+zl253/dE6Nhu8b4mmrlPS0hWHtjtCAGZs
	ddK2NTN8ne5+QmH368E9X8Ep6uD1DYvbcd6JGAS61JeieaT/C+WAcoRmJKXAKsS+axBso/i8zHO
	RTlNP2TUBepjq3Q5/ewPbuM0MT+uJNyj2G1PX55HmDBISs1toRmcyAYT/4GLwUSgzILom+goHEQ
	BdTJqeDnucY06IkHoGlMGS9nUpj/iNHLhR4ydRniYL6rLCamiEkFSFOtABKNm7W6NulCIb9I8Iz
	YbxNu+3rpXFbswgd+PC6cT55k5ENDY3BZjkl/bmmfZyy9OAdOj9/rrysVQFahDB9c
X-Received: by 2002:a05:7022:396:b0:11b:d211:3a64 with SMTP id a92af1059eb24-125c0f1e671mr1354678c88.0.1769786136363;
        Fri, 30 Jan 2026 07:15:36 -0800 (PST)
X-Received: by 2002:a05:7022:396:b0:11b:d211:3a64 with SMTP id a92af1059eb24-125c0f1e671mr1354659c88.0.1769786135739;
        Fri, 30 Jan 2026 07:15:35 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f95asm10252849c88.7.2026.01.30.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:15:35 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/8] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Message-Id: <176978613488.3951544.16310124318895182345.b4-ty@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 07:15:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=VI3QXtPX c=1 sm=1 tr=0 ts=697ccb19 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9BDlGpjYJg453-lo7M4A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: pzxI52thqVSlZ1R-J0s_JkPhVkz9qcHi
X-Proofpoint-ORIG-GUID: pzxI52thqVSlZ1R-J0s_JkPhVkz9qcHi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNSBTYWx0ZWRfXxu5BwD9WzxXq
 ePDz43K4o0XZgqlc3zGn08uGMS9pSpQ2mUb03krncdJlrHE5VC48Z7FzzDaeoPF6nROVmUqNMlz
 jZCu1F4Lpsu3EjkhwC4rwblkv3LkUPNzdJN3aes2BYtyvxeYKDrZcuM4CknXWwIU28wfQptGKS2
 MEPQUkxJSrZp4q1JozSBg+H8/JdKgXhQSKlt/hcGwAt9o+14fpYz2Ui8/7o30XCm8rWSJ6K9jBs
 vP1BBLnnNWHg2WIRqrrwZ7L10GkZcVi2UESznE8X0QS0rGXTyHfkHzfVrVFIT2S7eMIPEQreoHq
 GlojcS2xsQhtGB93lP9l/TuzXJiBcHQX90myvgnA5Xv2lhIqnvA5MQzIyM0oyPt46UXRgxU+oyk
 XGbwwdzITdZ1P04t0UUxupX/JnUypzm6oCiRb/kUi0gKK9XdfjaD9dMPm44dHY6pXYGTRo6mgBK
 AXD5dpRl7eLoXKamyfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31374-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,holtmann.org,quicinc.com,chromium.org,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
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
X-Rspamd-Queue-Id: BC743BBEC3
X-Rspamd-Action: no action


On Mon, 19 Jan 2026 19:07:57 +0200, Dmitry Baryshkov wrote:
> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> voltages over internal rails. Implement support for using powersequencer
> for this family of ATH10k devices in addition to using regulators.
> 
> 

Applied, thanks!

[3/8] wifi: ath10k: snoc: support powering on the device via pwrseq
      commit: afcf3ec615c918dd71139e7ca2f4812ceea48cd7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


