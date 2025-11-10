Return-Path: <linux-wireless+bounces-28813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DFAC4942B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 21:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8393A645B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 20:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9202F0C7C;
	Mon, 10 Nov 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8QbNoBr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ot1WIuoZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6DC2EE608
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806959; cv=none; b=RzHJkv4hXbwH4Zn3CDkocok+BJIapg/KI+7Ff0zIDBK0QECsKa8fGPVL6VX/82bTgN3eXjTydR8Hl/AqzCNmvYWJsUtjDPuPa/afqUjMXSEvzchNXtFl0P1rweglJ2vlLbxkqvHZwva5TJrdJDfRcyAEPJPYSrs7Z+fS2igvT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806959; c=relaxed/simple;
	bh=6214/vB/U2T9ZxG1wVNkrl1tZxoGhwbwSuU0K4bc0oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMoFf13v4coW9nJb0StF9NPU9txSL4dNzwxM+UjaDeChSGXps+Kb/xtwn1B1X1o9EoLJOEr1LezxY110ZBXTb3P3R3BuoHcJA1cEZa6rmeXSek7RQO/gD6OLDLij94uL5/mUOyqFTggCNnpeLpZK1GIwnzIEf8DBUTK7Mqt/F8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h8QbNoBr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ot1WIuoZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAGnoA14073894
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 20:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HrusHWa4xpz02NNq9Rv00ajz
	hsc5feN0A2MEhrWFj7Q=; b=h8QbNoBrG44TqkkpXtfasvkklbUzYf28BBnTtLPd
	CVq0Gch/ivO9Z86GYUrPpG6y7SDtJBZvkdDPeQI2zrhP5LxpDO1zR4ACotuTaO6N
	2yoY+57FkIBCWaPs2Z5fbg8/okriYWLgZELUfCVTFCyzWKgCYT9ltpSE/dhpplLF
	JB7J2XG2WsCJHMh5/+0fg7D7GfJe9Kf17kUYhyG5SNrUclP7ATSVEA/+IzZFb/go
	yXMwQd10dGgodh6eqzdshBR8pV3fMzk7nbDWV49RvrsaZHH2P5Q4MDiuCXjUD2Hm
	JrH/eFeMAJWGegHu6rtMwwSFhZNdk8Tg3w3trcRQIGdX2Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abkws8mqp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 20:35:55 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8823fbb4990so67188846d6.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762806955; x=1763411755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrusHWa4xpz02NNq9Rv00ajzhsc5feN0A2MEhrWFj7Q=;
        b=Ot1WIuoZr1jXGaqKoID78kWyRMNSsc5aJAKI6EA5t6nlzvPpgCL5+/8inKsVR7B8xZ
         mPsrwZod4f6LLOUOUuHF+kqvctd+Qp04n9+X9lNnjXE+foynGJUKbcotAE5VvSDPmZob
         lYT3g1MRurw7HkISrmGVwU2XSVCAJkD0TgKFvK5TnckHXmZgTZo5N3QFXq1E3DGv23sm
         3nlIljBgerA7ppqQW0SOPRXamgB5TR8unz2MJqhj/9soZqs6+ZM3im1UisKnvESglv0Q
         +l0/sWF3lKYiVxLeFtOPLEKRvA+nTKq4y3MmskuHcWZbVwqNW4kyp87cYe7xHSafxRWw
         PACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806955; x=1763411755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrusHWa4xpz02NNq9Rv00ajzhsc5feN0A2MEhrWFj7Q=;
        b=b3fZ6qpxx2ZI38QSSVKjLOChUKlB0fsP5pGuqfjpxT1tBQOB846zPcfLAHgKD720mX
         vw8TcVyHsGNd2eDTaYdSzIq27ZH7CGdgyEQuAAfC6SckPmE2Nx2RJpgCBn2fzAEZJA3d
         wE8BkU5PTYgzRQgpgOap33Y+RNyDeb9KemfaZY+Qgwk5GTcRxNhdw2wqGo6kTRgXupGi
         IPkKE1Rvy9jmn9cSzzuMc0Oja3cyrOpdHHePT65xE+/h9qbIknXxblS8cRc+t8nTbHw6
         jwHJM8WhnDdYbpeR/UUDGDcU0k6jbd1pA7NcR8VgwVqjRiDQEdJnwPIAVQGdvKk4ZZUR
         EouQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtUor/WwPQ8nGkoTx7927Jr1SJw/OpqoqbSFJmRUnpOurgw5jIDjj+J5Re6XniLVcg90wvV57ee6g2TRmlAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwciiSqnZ+MZwq5HrRk+TXOP1jxLNpT4r0urU/9GRasRTbqODFt
	gEtQ2nvcoIFP9e+uVxUbsU6dbYqPuDk6+fekvEHwGmXlt6pgBadpMseJRGV5P3GhySRISyWxw/E
	5FVkv+qOjMkL5IszpoPTx0XQxFcq3rutJRcp8idKIA0ugk7VKg+jJT9vYhHr6+I44g81OrA==
X-Gm-Gg: ASbGncsRgvj0v1zIKHXU7ikd+/x8R/5q2HaTuastWOfcRXpUfZriB6xbprdOmPhJD/T
	KAelrhH/LxaGdjT1B0VKvwekEgggcWb5XV1F606d1OIy2fvXODqE1/68V/Vc5BYg3weF2JBvHnK
	6MhKzZAy4D6OTMhuS20P4v5u7kl8y3HBNEKAdUljP5r1XtxOwP6GkC+Ab7Kioeu1CoUHxNl6AIf
	+TIWzjNri2yPOhO1E91I9vdwFriPw4RMRl3ztOqv47rizxYBGZPI2LyM7WBBhhakTScqwP48cKT
	1Kwme3sEcX/a8BDNwO3H4YjZRe1v+pzztCDu8MXyhM2qp/JasUrWLIiHoM/jECoHYL2InBYZ2im
	MRfbePS+TjHdMsc+1IrhySCN3icU0YAk2IY0IVnOi8FhBw4+WhsIfqcW45JBaSYbLq0euA3qink
	hPtyWtqtRbeICi
X-Received: by 2002:a05:622a:15d1:b0:4ed:67bc:50de with SMTP id d75a77b69052e-4eda4ec8bf8mr113489671cf.24.1762806955260;
        Mon, 10 Nov 2025 12:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ5ssDcgmggW4lpYvEvrEq74tSuo8cOVQiuKY1y0jHjepaZLONK7Do79X9y4s2nxZqgmpA+A==
X-Received: by 2002:a05:622a:15d1:b0:4ed:67bc:50de with SMTP id d75a77b69052e-4eda4ec8bf8mr113489431cf.24.1762806954848;
        Mon, 10 Nov 2025 12:35:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013bd8sm4360891e87.1.2025.11.10.12.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:35:54 -0800 (PST)
Date: Mon, 10 Nov 2025 22:35:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: wireless: ath10k: Introduce quirk to
 skip host cap QMI requests
Message-ID: <xgyd3ofvv7blcfo2iw26p7sh3p7lkb5w6kkbogryzrgytkrmva@foo72an5qs3y>
References: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
 <20251110-skip-host-cam-qmi-req-v2-1-0daf485a987a@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-skip-host-cam-qmi-req-v2-1-0daf485a987a@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3NSBTYWx0ZWRfX1MsUVE/orNs7
 PY0TJk/qYM50yfOzJFEBb+lXBgyPZtHJBj6hn2yaFscYRxTHA44FQwmp2iCMdaUOan7q6YEwo1A
 DjwamY46kqyCSdfrNSLIeD5AJpBf50kNr62a1UvokyjZBfKWLeDMUAIE0xOOkGqSXuJv+Vzip3m
 kwo4fQqmufAsaJ8R+t25AddMJRjuFOzJqP6i4EhLDZZ01/GJr34kQs36W/w3FDpLVrGAzVmwmjc
 21GxhxptC+TAYuQC3s7/iQov8X+4rrViMz0+V/A9ytMCR/zkxZ6EGOJ3v+jVsfMMvOvCGfsC2tb
 3kdV5OL038eR0KiuLRGXJDNn0UmNcm+eA05jCxnxnh8HCGQoY+IJI43z4DPvpJh3dyXA2yAebGU
 03K7v9GsRfmqipgQyp2oN/qyAmkyEQ==
X-Authority-Analysis: v=2.4 cv=Vosuwu2n c=1 sm=1 tr=0 ts=69124cab cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=bBTs48EDRqzxHWfT9_gA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wjfMN2jImW5nnIT-HMt2Fu8v7G2Ea5Un
X-Proofpoint-ORIG-GUID: wjfMN2jImW5nnIT-HMt2Fu8v7G2Ea5Un
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100175

On Mon, Nov 10, 2025 at 03:26:24PM +0100, David Heidelberg via B4 Relay wrote:
> From: Amit Pundir <amit.pundir@linaro.org>
> 
> Introducing this quirk to skip host capability QMI request for the firmware
> versions which do not support this feature.

If it is a firmware mis-feature, why don't we describe it in the
firmware-N.bin file?

> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

-- 
With best wishes
Dmitry

