Return-Path: <linux-wireless+bounces-30882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9535CD2999C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94C4530AFF3E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5E5334C3B;
	Fri, 16 Jan 2026 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B06C8vwl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CpELI1/i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5E32E6BC
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526821; cv=none; b=jPGXokotkS2oEFGhVnKx3JcoMiz8R6O7ppqC5xtIz42XHkFnKIJeHvPbSCWPdUtpCxfNEe0ib4QC1+GH8Oe00Hnou1F8zxum1GVRTh4iP+CSidniTmXWwoa8c4Q3DON414xQxoWrGJxbkhMj7nK6Taq+m67WFSZPxHLIGzYxHy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526821; c=relaxed/simple;
	bh=tkKapXJAv3P3u+XCyncrWRqWj5pzhnVqLBlDhYSg+xo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C9nR3thZ/37ms/iaZKhwq+mzJe6IMyXZP5v0q59Fvtp55GxocEaageYX99SuNLzjZqupUgiV4Ks+1BWbImSRBJbN4TTN7DpG5hvxYZYFhklxnqqRsUwz5aOumMnBMLeALHmjB5+62J58bSHn4prqpNu/uQS0hgrzMJQnya19wUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B06C8vwl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CpELI1/i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMcqKZ4100940
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KHvpl0cOsSAPRSO1Igx8dlMLkSJkUG1m7ej0v0eL2VY=; b=B06C8vwl0TA2dTwL
	79HMs24/72z8faPrGXX3/3rhxK9IxI/5GQYbJ6SJ/at3nRbXj/0hHenCvaeh2Kqh
	uFUZBs29zeACJslZ7G5Z0MM1Ho6BPoMfUwP+DKQtaKCUkFJKBBnbJ3ITXcMBkTRJ
	DhCuigNc7yEhG46B+H8m+YsjV+GmVHxA2tTkThbyioP0xoaQSFQklha3rLSqGs+a
	rHWEL+x8RiYlE+9KaHBb+nYVYNUGafttnI/qEmEK5MVtZPR8szvt8m8hF95LmMV9
	ldAbA5CY8owqem9Rmc6sUCWN9t1JGAZbxiPCM20ffjbHmP+BdU3DARh2/yAydKep
	AoiWOA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9750atm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b6b9c1249fso209107eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526807; x=1769131607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHvpl0cOsSAPRSO1Igx8dlMLkSJkUG1m7ej0v0eL2VY=;
        b=CpELI1/ihWZsq/zc5brAeu830Mm8+jqqZJITtmopjsMgKOuYjMIyztyjzi0metl5bF
         bFtWoFLqiozGzO+xkdGGZYcFteSiMrffXPZI2ueAQbZM6agLNzRqmf4lgyywrUx9agRr
         /Mk4s2rCN87nUdQNLnxpRmxgC14EIKfcL/4QjEtiR+677P33zb1/SiSvR+OY1KnL3puD
         UmxJkGqgjXj8Acm3O2PIIuKUts1YBu3IUtdZNWzB+Q6TAticnGkVp3UpWg1Hbo05PBdX
         T+rKDySzl6r7TqgYNMiFI0MI2eMLUqQRd8Q6Wk8khbaDrGRtNtL+SiCExjC1rDara8Yb
         /k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526807; x=1769131607;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KHvpl0cOsSAPRSO1Igx8dlMLkSJkUG1m7ej0v0eL2VY=;
        b=w8PxmnSR95bLkckOEe86h8NuK/gpOlbpUABm+CJbRWq38SUrltaujcojW13gIK1rhu
         0E4CIf7yyZgXHNDYQKP6WFYmpy+l1DBWK+YVudMK7VFFsYmTqXV/OmwMOP83lzd0EYUt
         XZJYdjCNtzcXa75fKNhHJBFbB1HgSHc+ZnU7Wrh3h6D5cre0sNszzS8ecJP/qhQLs6HB
         2ObBCLzi44EpxI0vnbYYFeuCtkJAemxXA9HKpi2jJY/5tolXH6S2iRg1AEJWbxyYAww6
         HZbA+LTSWIk4oZbkZEoVAYjCWyJ/PdRrmu3c6XzmhMjSCwWn9+2zKgwVRaw2FIZFVeav
         2qkA==
X-Forwarded-Encrypted: i=1; AJvYcCVkm8AUDRIqdlX6D0rncEghGv7lq4upeePY9cFBw2ZRPt0X4o/KYY9HPvHPcCB5yzQh+L10xXF8MCg+rCAKng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Pz5Do4grIV2E4xNxjwilptOaaNAQudZjmymB0YNRdm2s96PM
	QDITS1uN6k79Wmn6BywnxXe37eDnH9afQLZVzx2UMC6UADU8i/LrHrl4BAqm0dErI1AGrrlNw2j
	S6Ai3lhPD1ntNseNxP1S9/X56EzV00FXfQv2v2c/a8AXfNz18A7gn2Et6dY8rXOeZlmPDmQ==
X-Gm-Gg: AY/fxX7tltlMusLbo/EeDy3SEfR6QM8ahHmylqHDORWfTta5RapDvCvQq2QtSM8HBeR
	pkUaI9SVGy/MvsScIu0kqEE/aoCLK+NSQ+0Uc9v8KYsN6nLugjc8OxfPsBfqB7bmxn1Wqj+HEbn
	ONTSsBKIW82Ae/p/dnwbc9v3wYKHZNgQF/C6uoM8P50nmYJaTqm3vmgpIBsFZL2/gR6j08iUjrh
	k0ImM4MqV6NagcxhG6nnq5l1Dyab9PbHxjIThdWsuFOyQvKdda18Agz17rfwWKJ/o4IvkyOVV0z
	jEpC1QiuyMJ9CcGbiHzBDlTIUXDzUkGaLyYCkmd2181MhLg3QpxYyZ0XftrEcgQxpIXM6EM8M2T
	queactCw/sSOy0Lo14bOgS6wfIfxZVh7p9DKYx/378bOhRp6F4+Ev3p/Aw7EEKAid
X-Received: by 2002:a05:7300:6d1f:b0:2ae:5cb2:cc11 with SMTP id 5a478bee46e88-2b6b46d33b4mr1526117eec.6.1768526806339;
        Thu, 15 Jan 2026 17:26:46 -0800 (PST)
X-Received: by 2002:a05:7300:6d1f:b0:2ae:5cb2:cc11 with SMTP id 5a478bee46e88-2b6b46d33b4mr1526086eec.6.1768526805328;
        Thu, 15 Jan 2026 17:26:45 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:44 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251230114835.52504-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251230114835.52504-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: net: wireless: ath11k: Combine two
 if:then: clauses
Message-Id: <176852680474.1143034.17152758892782135246.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfXz5p+ck/ul0xt
 zDISVKsCCqQuP8qPnf/0N5yBJBt24pSFbBMxYzq7UHSwU9+NM1AD6kWUma1fgS6UJMQEJOfCG9U
 Fy3IKWGrrZY5k+FnsErKsSavRKLlDoEjTkI34jb/Ja8u+R4QmQ+JEl+4Y6vCed0Y9SLxN65JR5J
 74jMkDKzdU6OU30rI6ef9FlxRRr33nyBSwQLe+a/bjjUpHagGLIZBOPkgbzY2TY8y+w+OtTDZ2s
 +exnMOdJRXqYFUURUZcvghcZ3uxzNe8TtqFlnhoQgwf1vwulrTNKjKLBCcDlfpMZtwRxvHJWEs5
 +wnvYpazAwiPdGl90/TBPnI/16zIy2VZzknpzv8aGeVY1I8Crw1zC1M8SAMZUccepG3dXz2xPM3
 rw+kgejRASg4kDXrtJlM1QGbETOG4YYJYEMKFmkSTbHjwh0QYnrYSyEH5Nmep3kPCpKORO2B59s
 z4P0eHL6bPcjpopNl2A==
X-Authority-Analysis: v=2.4 cv=Sv6dKfO0 c=1 sm=1 tr=0 ts=696993d7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YCnGg3YljQHaMnv7sjoA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: gMHyK1a3v6MH_9KdTtODGqZl6h9Nu49_
X-Proofpoint-ORIG-GUID: gMHyK1a3v6MH_9KdTtODGqZl6h9Nu49_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Tue, 30 Dec 2025 12:48:36 +0100, Krzysztof Kozlowski wrote:
> Simplify the binding by combining two if:then: clauses which have
> exactly the same conditional part.
> 
> 

Applied, thanks!

[1/1] dt-bindings: net: wireless: ath11k: Combine two if:then: clauses
      commit: 2125381d60c572684cc4ca61a2b1cf44c7eab059

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


