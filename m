Return-Path: <linux-wireless+bounces-27890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA3FBC6061
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEA13B0F7F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B062BE625;
	Wed,  8 Oct 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JPq2XO0s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B42BE04F
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940891; cv=none; b=lV5qrRfjc5cw9+52xtMWP10IwNrNvexGjqymUDzxzkpBpR5ypc6irpAFKHIcm/MAWm65pm/3U/Z8mR+tNlvR7yf6sXuppPGbWkWdKKs/Vhpmo5V5GrermC2DpOWgFpw1I586gIe0xxsKyn7BiG42imLHvJ6vKl9h5s5XYJy5jyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940891; c=relaxed/simple;
	bh=dCDsW9sW8AOh7KTZAjATq3USirbXTat+kM5J8iIb4Y4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FV9bwpiiCMS35g0agMWS0l5Wc+W4L7rR0i4YJ4Hr8EiIRZ5YoIYjkoaCcoXj7IIyjd+VN03GHzD2f00COqM93YogFF/KY+AlITrPu/3lHv8brh3tpT70xsBBOF74m7xGuy/vPPM+RBN0Re4+6ltE6VqzutOi4PqzVXffEfRhIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JPq2XO0s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890SR7028975
	for <linux-wireless@vger.kernel.org>; Wed, 8 Oct 2025 16:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C/Lh5vXes8BWGIZJc7F8+OO0nenf5hQxsJ1S9WXM38I=; b=JPq2XO0swKej+68P
	OCu3FA3q8alhME6HQ8inmZ8q8HwIDYMWvsl4EvtUuTh52anIUPAEYesJeBmDyQLa
	9ziSf08zyvK6Pmn97W0+Saua96y7QnNNHUEJJI3iML9zXpDUolsIA9Dy4oDxigDA
	0irJqFYQNS7CIiM5GU8bhwdxpsVe8Te0OZHUVB31sCmSafTLgU2Ve65fsYjTKn6U
	ayCtxg0MUxodOBLJvSnvtnXNfEsH6tEUuDyZOFheEVJ3J0w0vQce/0Z5LDvID9bk
	xWJAoTxE0+wly/hG/FfM3Z6SrfKPOeAGcRReUNSsYtd0TofiQpmdg+pyd6QIqo6V
	UXwWTQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9e3en0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 16:28:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77e7808cf4bso11984b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 09:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940888; x=1760545688;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/Lh5vXes8BWGIZJc7F8+OO0nenf5hQxsJ1S9WXM38I=;
        b=d19sWpWu6xCqfv4738Fm7X6L6vXx74dO3WJmaaL7ycIvw0GSS5LZggz38Xk3HJgG5w
         iWPbkEoDdv0v/ZNUvob3W1WiVlRuE4zNogOVgGRdnieHFnrwXvjnUZ1IQHjRLHp3z0hr
         DoddFi9tE12fFrawFfWA+ZQPzUccCm/f+Byc7qgw8w19GAIyYJ/O0q2DVjuj0N6KkY9K
         S/QGGWhjV02hSFdzrPIK7knVXsCDh45kR4FUjoj97qrPjR69TY95BXm0cind5+ozqwFc
         P9gcTxOnWxtMbM1Q/M1hvvvTeGyOa2LgQX/jGKQ+0vkDsuQedl3juDEl4f23f9Ju88CK
         PgdA==
X-Gm-Message-State: AOJu0Yxi+XSEFs0XGQU7EQQy/woirLhR3dwPw7F4Iu1Bx+6ugNz7xGaz
	6FF3NDoSF3XGU7UkAzeQleC20B0v9GS4CX+zhAKaWunw3kLfWNzEifq0bjmObNOyYT+Ifva5x9H
	uZpVAjPMF+I6oaGpK0OdyG2dl2GPkk6RyRIiYyvcBFlJF4AfG/rdhtHn8nE8XmBXu2JsPVq5jfq
	5hhA==
X-Gm-Gg: ASbGncsuPhXr5DAXtugiCY+n9gOtKQ52EUqjeNGWgQOaoYmrTnVcUm2KsCzbfoiTbte
	DnaZqBokdre80O5D1f1ZcXA6vUvpJuIKrehGlX2GqDRKi5h4HKowzuMMnJ3CDnIOTQ+gTW5retK
	vGo1eD3FeIUnc4c2fBOEpHdS6k6aqX3oHgvKkWWlOyUKkJNamGNntNSpqSWf8Qcca2hyDyKtyRT
	jE0BwMN82Rye5a7CjQ67c2s379smixSMp8DKIZadi5R4v8vBP9nxLOtjmFD8Jfwb/5jCSvQXtOO
	sQqt2LnOKfzklc3FIdvoNGvLmUsDXjxLtG9jOxvi4Qx/O3TTS2ljeshTbNGPPkn0CH3MC+YOlbF
	dH1kYkA==
X-Received: by 2002:a05:6a00:92a2:b0:783:c2c4:9aa5 with SMTP id d2e1a72fcca58-79387d0f5aamr5801833b3a.32.1759940887511;
        Wed, 08 Oct 2025 09:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdpkirxIo87+yizG57TPPUjHz57MPqLEwoBEZBrybuU5QOQ06+d4WSXjU+s384HGdLO4g5Qg==
X-Received: by 2002:a05:6a00:92a2:b0:783:c2c4:9aa5 with SMTP id d2e1a72fcca58-79387d0f5aamr5801777b3a.32.1759940886823;
        Wed, 08 Oct 2025 09:28:06 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e33f0cb3sm156806b3a.78.2025.10.08.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:28:06 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Ripan Deuri <quic_rdeuri@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251007110203.1541167-1-quic_rdeuri@quicinc.com>
References: <20251007110203.1541167-1-quic_rdeuri@quicinc.com>
Subject: Re: [PATCH ath12k-ng v2 0/2] wifi: ath12k: Modularization of PDEV
 object for Next Generation Driver
Message-Id: <175994088614.478288.1426868951079450309.b4-ty@oss.qualcomm.com>
Date: Wed, 08 Oct 2025 09:28:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e69118 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=B_2yNedsmjAXjeJ8S0MA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: JLSNdLgWN49uAO2TToVuUFSbvAqubn6Y
X-Proofpoint-ORIG-GUID: JLSNdLgWN49uAO2TToVuUFSbvAqubn6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX25hFyE/MWw/i
 KKLsatiCwkZzT0hZn3evJzCvQEZbUhn5bOHbPlHOYsEQyWzWUZCSoYg7p8N0dEYZFRhs02+zXdA
 lIRth+OuMkJesn0Spy9jiy27CiXWAKvcv4Qr6U0mFhB2n8jTXnxR6BiNcbzLWh7XsIwG7PlFj2x
 cOU+mm7WmmXWGLU3ntW0rKbcwT7yc2OKCw3x3Pr3xBngBBrx8RZhZ73zdoE+q6BGtkioee1lR4t
 nBiY5ddWhDKVoi3caabGvJiDtDycURx3W+jHHNEsvDrJQyAWIIYyRBbihgCW10IEIgZDuv6EsiJ
 8ons6mzpif7K2/jDHXreM6N05Ib1ITA6t6479yddxpsFYQI18lNjS48SAlCX6Br6SrypwDxgEEQ
 VQ8JWPj/7irIdTvcw45/qmZZuAGwLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004


On Tue, 07 Oct 2025 16:32:01 +0530, Ripan Deuri wrote:
> This patch series continues the effort to modularize data path structures
> in ath12k, focusing on improving the organization of DP pdev handling and
> preparing for future architecture-specific extensions.
> 
> Patch 1 refactors DP pdev handling by consolidating all DP-related fields
> of a radio into struct ath12k_pdev_dp structure. An RCU-protected array of
> these objects is introduced in ath12k_dp to facilitate dp_pdev lookup from
> ath12k_dp.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Refactor data path pdev struct
      commit: 9e0ee04f818f42ec879b053e4b5d0c9c230415da
[2/2] wifi: ath12k: Rearrange PPDU radio stats
      commit: c57176c0dad91a00bd20feb5f6dc4e8d575f4628

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


