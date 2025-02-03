Return-Path: <linux-wireless+bounces-18326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F2AA2671D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 23:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8588B3A3EAE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FAF211298;
	Mon,  3 Feb 2025 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SNEyuXog"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6820FA96
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622954; cv=none; b=meBY9Yu9ZhZM2hNone80tIfgki3NShjSg6Uf1e0qcB+c8CZzK2MvluBeQUZDkShthlI2DQRhqSQhwV0vcvBfmBcJJQLKw5X5o1vA4JwYm1RNlJswU/NcL9pdtOzLTUn9E7rIR6L+mGcuuDq41FintVUwV5CD7INowygSONqLPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622954; c=relaxed/simple;
	bh=txpcxXnwkzYRofCbaR6fIyX9rnKHT3K0tOJD2jMPzuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QuA7vRf0FCtABafOfWN+Rg1ZOuotbsXAcK4E9vl+511lyRm/vRVJmX4uVc0W5RsdkqokJ3hqiwoe0zxZCEV+heFcJa6SG1SSI820cGf+rIcTJeVIdJj5FWVpUM7yzh27KedE0Z2Qs2XvpPJCsPsrXJleYfFuYJ8wLbQNTYZ6erk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SNEyuXog; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQuIZ027347
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 22:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zs46lDnx0AskK+LgAT1HOzws7jDPBNJqaxXTfQlukd8=; b=SNEyuXogHMjqff1m
	kzB+5Po8siA1LnA1jY0IMQ8y9sozcbhMhbIaS9atqZwLUiWT/OIVCC7uHHDRT07Z
	0eqZsjq5VD7abvJSH8cLSZvXhQ6rnV2RlXUXdOes9yOwE5pIleeKh6jggUHaJgfo
	S5dgUP5F80x/0lUx2hUFxkGB1FDIzj4Kione5GoYI5lYMnYoFNJECaegzv29LPrb
	KPqhkxXG+DHUe/3r1MQzsaA7CPRrM2glCA8EWJyYRYYeiko5D3DRkbFJeDJph259
	WcOWrz3q7qw/bMgdxsGDfYkzZr/HnoB+m5LtJJX8XOPJ4BApL8oqasLELAF3D4+5
	2/X+EA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufr8h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 22:49:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2178115051dso108713275ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 14:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622951; x=1739227751;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs46lDnx0AskK+LgAT1HOzws7jDPBNJqaxXTfQlukd8=;
        b=XMHUgU4/gItVQQ/8d+IplDI0Ewf6Y8ZbOQ52HozX71NfGZ4WsfwOenQ3ti0nc3BgYA
         vc+rgpeJIzPy5IPf22C0cQ2Ib2d+GWjKCYWj6Y51/ZaeDmH+eGWsH12eXXNd6liMXxf1
         SMVCwOj8HsAYjMYbtNMc+TgIKZC6uebgkMvxIyFUN543tLqJrjTQIBDT9a1xDehBNWUk
         M5YpYpy5kMPpzNZbBsT7uP/Ed82JC/Vezz6iGbq9b2NJibvtyJapfagNHfytnwXHA+sg
         by0TC7rY+fHz+AZkN0vpG0ZxxpHMYKXmg95F408pmZEKTJW6FFf6BIaEkZs9eryDd7WI
         5Lag==
X-Gm-Message-State: AOJu0YyPcPY285sp1U8vcEzzZvBkVaW6ry6KA/hQn4m6ghnZIBxQtH2z
	RBIUF0QtTiSGIGJMxecQWTIbkpDY8lhgDkfEwL5eDMJ2FtqDP04D5t23TWpqBJCbrejkW8vU2bJ
	jo1r4zpGxLBUZ7FXRdfkqwqdC4DSrFyDAhMWFJ3RLjoceFTL119wDbniUP6WxwN3EJucBHYbRTA
	==
X-Gm-Gg: ASbGncv3o/ICD/Fn8bujch1FWeV0eo/JiwZwS2i+i0QyAcmCg/tPCbb7ePUhGb1HyxQ
	tyieGPdHxfQ6jIb/unaCd5KNdfPIPKKFwhXx/qzYe3vZFxXnUasgd6MaQJcIHfW4M8c4WMYaBeV
	rxAEuDoLPDtp5Y1feoj2hNGNb3ctKWYeNkDT13rpRijvAWjbUxAa530UdHgdrxLj8Q9php99Z32
	pk3Tp+o6Qn9kgsJ5EnkJnVD/zwf8QG/Rq2zWvykbA2l28UG0hbUDNmb5WvRvUGZPdD6AyFnIYGS
	tejHqspUkLNpjItZLSthxNKoG0G3O7RKBlekxoaZkg==
X-Received: by 2002:a05:6a20:7f84:b0:1ed:5247:f385 with SMTP id adf61e73a8af0-1ed7a6e0689mr36660684637.38.1738622950632;
        Mon, 03 Feb 2025 14:49:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC97hIQCqs8sdJrtpJRKztQccJENt7nwzepk/QMjp93S28C7v+Oy0qD19VBoZDEZpUcJSr6Q==
X-Received: by 2002:a05:6a20:7f84:b0:1ed:5247:f385 with SMTP id adf61e73a8af0-1ed7a6e0689mr36660645637.38.1738622950114;
        Mon, 03 Feb 2025 14:49:10 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba353sm8887444b3a.112.2025.02.03.14.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:49:09 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Avula Sri Charan <quic_asrichar@quicinc.com>
In-Reply-To: <20250124090058.3194299-1-quic_tamizhr@quicinc.com>
References: <20250124090058.3194299-1-quic_tamizhr@quicinc.com>
Subject: Re: [PATCHv2] wifi: ath12k: Avoid napi_sync before napi_enable
Message-Id: <173862294944.3734728.9309905197333089194.b4-ty@oss.qualcomm.com>
Date: Mon, 03 Feb 2025 14:49:09 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: RcFrpBA880DFTxJe_iruCc6YUtuf9rr1
X-Proofpoint-ORIG-GUID: RcFrpBA880DFTxJe_iruCc6YUtuf9rr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=957
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030166


On Fri, 24 Jan 2025 14:30:58 +0530, Tamizh Chelvam Raja wrote:
> In case of MHI error a reset work will be queued
> which will try napi_disable after napi_synchronize.
> 
> As the napi will be only enabled after qmi_firmware_ready
> event trying napi_synchronize before napi_enable will
> result in indefinite sleep in case of a firmware crash
> in QMI init sequence.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Avoid napi_sync before napi_enable
      commit: 268c73d470a5790a492a2fc2ded084b909d144f3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


