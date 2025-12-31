Return-Path: <linux-wireless+bounces-30226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5ACEBD24
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 11:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 399513010FC5
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B6431691E;
	Wed, 31 Dec 2025 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9LalVlH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fcAgL+Q0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D43148BB
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767178556; cv=none; b=guv+75nFtT17W/3n+6KEm9oIGFp6Pejs+45l50fFNPKMhI21FNzCKxSVLrTXrcy+8LofiXBfHpCK0+MwfBcuDdD2U7GgQx+tYAIx18R0PnF/NPffVqmvOht1nFRdKTOdPiO6NpMEpddNNits3xBItsihopkSZyLgZhm263QPEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767178556; c=relaxed/simple;
	bh=HaoGokyMCKS6sYN1xubOMqBe4hgsaEX+B8nRrEYfBZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VQjbROmnTmpF/CcbD7Bbc4r1pRnxoJjH0lcv8qe/V0nlJxC1O1i97eULEudc0A1caQEEbnAXEh83XKSGwlMUXsbl0cNgr9AbV90lS4ZyFeKgzf3olptW3sPoBLk4ICZqPYm0cBDx9yPNQdFGal0wJAkr3vndGEdK0pgm7yeCnJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9LalVlH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fcAgL+Q0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUNke5H3138113
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 10:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O+f7Mi5vx+QI3KHSGUaTpC6QdSIVzAVg+5x+XC0DFt4=; b=l9LalVlHnMCVESuA
	ktNoLFmYgR+yMVeRPmZ1JFaUS088FgaON98gaUXZiHac/q7y5EeYEAVhiSnb1ZAs
	bYT+nenGTAW/98+5957nIK3Pr9Yc487SIjLLFsPE3gnkNCbWbIo3ZBBxFrTCoTdK
	khuLOhMy8IAWzxCWzztVs4hz4Kcl5cvgc8fD+mE0Mfp4uZWixQ1IaVnRZ1KWAq41
	edQTCHKA1PUAvPJLc6h0JiA83UANl8JKbLs7O3Uf0ZpoojkDqxfTTdBzgaYir3SN
	77Kp5o6ebyhoMAclhFdxW9LbhvNNHHTcT7l7pkeRIVAhRR6276p8C4+OyjObaxgD
	SQHIsA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc8ky39w4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 10:55:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b9208e1976so19778466b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 02:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767178553; x=1767783353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+f7Mi5vx+QI3KHSGUaTpC6QdSIVzAVg+5x+XC0DFt4=;
        b=fcAgL+Q0PlGLTWioVBv0R+4CnWJCHxamNFT6l+8ap0U7UXjXg9SCNahihs9bC05+2t
         9SOY9e2TjimrPqckwKP3yhztjhzAih1NENRWmL/wGjkSkt9aAB8aP/3P4EduouZS2T+q
         jo/osOws5ndMflEOKsqeX+Ur6WKLZ1gCmfwzet0x0fx7HovXSczhlq9eWt+RDRPozwrE
         O0NI388lheEc6mg2NJGPQNJnhPZQfVeIRSagUHOIzthrEwwIVQyg/iSKDFs1ZK2cbH2k
         zXr1TFumekbuik9VFbK1FNHqHKihSpA54aGgLY5TWUF8+K3B+m4gmHdnXRn+nmAWEAka
         E5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767178553; x=1767783353;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+f7Mi5vx+QI3KHSGUaTpC6QdSIVzAVg+5x+XC0DFt4=;
        b=PII43UqQOBvS5d/E5zpVCBlElCoGBMRDaXQnEr3NwMTbEHk/CVU8n1DbRrHY7F31gn
         fbKvPCH/CukXc1YzgBRnGzYjsXZ67sYLptAgWFcSY6QhTi/jTZbOceKimPbntF/hGOfs
         XHQ0ox0Unmef3BIGA/RDA3/WPU3MZmHeEttP7YOpSoMWwqoB4kFvx9kHHUu/eHo7bBfr
         C7x58zl72FR1/qXpHrizzlOrygK1Glvvvve2Zx0G7fwJBlKsdkFZL/17TXXj4bayIexl
         Po+MHe/6RUfUEPyrs/TTik/ViFVqsHBK+cOEG6jLDYzc5qRBAjlki4Lo7Y6P0UZtZiLY
         QuNw==
X-Forwarded-Encrypted: i=1; AJvYcCUTDPNHAJM8FBBPJ2UEHQmV8iSVEhaAyEQ/ZwYLt0+LzgMUmMn4eYbBtTHhI+w0tOe8zGUasC5rZRD670wVkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVy4BWGxBG7j66cyeCX5W/zGGFymksoBkA/VkqFQNExrwRLcx
	iU7PXokUMUwy1MwnYdTxfhCs2qXrW/7t42RkzjbLP5mFq8oLpM0W4nbJFNaNzDviHybMAYqSx0u
	yD5vvM/qLt0Wlf67hlBSZxzqm9lj7BK60FJLKDyp18UtkHmlG2FRJ8ofp+FXadkfZylBwHA==
X-Gm-Gg: AY/fxX5wfrNXH7xiheNM7a8ya/m8k7wV/fdVvLY/bJkwxwR0X6/WrmOVSwyE40siIvZ
	5pFiwBfvYakURdlG26tTtrz3UvvitY/Zd8bf/TSfDsNQ/mK9uTQrVbYVuR+CMHKO9RUUz00l89W
	QQambif3t3W9LHONz7LfhHoNJSlddhEFGY8GkFLmweD3QQUtOBbgO9SVbwoyDiPEA76EQxuELzL
	tRB/QOd3Hj8eoWJIdEMp8r268brq/XBO9dAc3dCcwUMQFdFINnFeobyWS6yMCnN5JeERyQsEfw8
	iqP7s/4iFjk6WLhhuNJcOIT0KH8IID0WNBAURMY3b7GY8T849muKSUzCa7SdGeb1Of2Ru4ICy4j
	7L/OOF1N55GRjD1UtujMwl1AEp9Ft7m0BbyT6cA==
X-Received: by 2002:a05:6a00:348a:b0:7e1:730a:613b with SMTP id d2e1a72fcca58-7ff64ec6724mr32190524b3a.31.1767178553538;
        Wed, 31 Dec 2025 02:55:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGioiLvW2U0joeR5pbtZjSEPSozpQwlq9uIpJCK2UPjGGzU6NNfRTPRLdM9fVlDl9M9HcekTA==
X-Received: by 2002:a05:6a00:348a:b0:7e1:730a:613b with SMTP id d2e1a72fcca58-7ff64ec6724mr32190489b3a.31.1767178553048;
        Wed, 31 Dec 2025 02:55:53 -0800 (PST)
Received: from [192.168.1.102] ([120.60.65.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cea1sm35616794b3a.45.2025.12.31.02.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 02:55:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        stable@vger.kernel.org
In-Reply-To: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
References: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] net: qrtr: Drop the MHI 'auto_queue' feature
Message-Id: <176717854647.8976.2100798756796791971.b4-ty@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 16:25:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA5NiBTYWx0ZWRfX+V7bEyfGiorQ
 uvc1F0FU4EorFedpGxpyOHXPgwQpQVGkreiAmuwZ9rbD0Yomkn4gSHJp1wf1eRRx5CXN0kRpgD0
 CaKjkz0Y9cYtb2QShiq0tDAuKrMaXgLlvrPVRuvKBxjllvh9+ybz9S1yv+vzq9zZnWsnEZU5Aal
 2FFNaSZncQLmS0PCL4B//IaWKoKnVTcO+zptICfMoM9oZZBBC0N4f1kUCdmM7ZR/V5ob+/gT5mR
 uhm/vmQlL+xJiB3MzNBg3R+gdLijaluOQrRkHZCeY0UZFqxvN1+AqQ8RB9tvHmtJNUF6qPbTozf
 tKSIxl35NEPRCo+4TDQ/+6ugGQzN4/jJ57HFgDA1Q39yFSxWQWMRVyBJxgT5w2gx73P9j6SiSQ+
 it1hVfE6b2WhaIToCSwmrcY831LLovg9ZKk8vZz5Zvlu6hYngRcGh6Adyf6k/zlc1WLlxZK/ujV
 h+JNaTqtkaV+WgbAPMg==
X-Proofpoint-ORIG-GUID: UxwYChZuEXj6qeX_j31k6GW8pY8MMY42
X-Authority-Analysis: v=2.4 cv=BuuQAIX5 c=1 sm=1 tr=0 ts=6955013a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=+SK5D59PVgoENw9OlSzWFQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=d1LwL24QG6zMnwvM45oA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: UxwYChZuEXj6qeX_j31k6GW8pY8MMY42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310096


On Thu, 18 Dec 2025 22:21:43 +0530, Manivannan Sadhasivam wrote:
> This series intends to fix the race between the MHI stack and the MHI client
> drivers due to the MHI 'auto_queue' feature. As it turns out often, the best
> way to fix an issue in a feature is to drop the feature itself and this series
> does exactly that.
> 
> There is no real benefit in having the 'auto_queue' feature in the MHI stack,
> other than saving a few lines of code in the client drivers. Since the QRTR is
> the only client driver which makes use of this feature, this series reworks the
> QRTR driver to manage the buffer on its own.
> 
> [...]

Applied, thanks!

[1/2] net: qrtr: Drop the MHI auto_queue feature for IPCR DL channels
      commit: 51731792a25cb312ca94cdccfa139eb46de1b2ef
[2/2] bus: mhi: host: Drop the auto_queue support
      commit: 4a9ba211d0264131dcfca0cbc10bff5ff277ff0a

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


