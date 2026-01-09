Return-Path: <linux-wireless+bounces-30604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED8BD0B0BA
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 16:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C63B309835F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB5B35EDA8;
	Fri,  9 Jan 2026 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJ0nPA9L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pm2TViZH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090E35A943
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973524; cv=none; b=USXX1rtOenaLV77WJ3MtPW1S8KOj2RzIIsh+JFYTSiN7ia1b7W/FgK+ezhdydR4vs/aAJ6iBAaRC6/XDejYcF1kshh0zO6yPnZ5ZmCnRsQKhpyez5CMAt5hFqR94QB8ANeA06G8B3Fd7AnsnFmvL7Ni7gNv0hjVEBoxXL5yVXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973524; c=relaxed/simple;
	bh=/kxt9hwuoRtRTjsG85IJrosVAPdkJurnFJfT4gD70UQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F09AuaDB1Qxqsis2kx0BlySM893kByD/7EWolInXKXPLZINrN/r4uh0nJOn9hhIjgZK34FV9f/1ZUtdqAxD3CuSQ6g9jwSLmHrY1juvi4aHMwoGaq4hsdwRS62Mzl+93gra3YRBWasCDPG3OQ5Ahr2NLXO29STFkyJDoZx4bNsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RJ0nPA9L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pm2TViZH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609EmDmc3142579
	for <linux-wireless@vger.kernel.org>; Fri, 9 Jan 2026 15:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nHa/kWbVVsFh5MJgGzVqkCaAwCD43l/Fqd48BAH3J7Y=; b=RJ0nPA9LGlMRIOVg
	EmrvOIQzmtGHJJn/gjY4ekKt9LrISXnDZXMfMUCq0HT66grayhQ4lqgxIHESvO5z
	AFkR1fk+y50g92ALvixMZ+D6iXGph4q/oSvrHWuHNRJiyECopqR29YV3FMLLCA10
	rSPNxdzaj4EclGO9I9NsLjKNeX6eZIX72L2TnMDguACr/rmo0uEKL/hEqxXmIUhN
	GqvpvE3BLvHZ0TUqx66rUsY1zMm0Fki8WmYkIFgX+lhXNnnN7cu5e7GLolwlnT9M
	6c/9Ue/vhx9bBwqBnzFilZrDWpThta6qqZM8nKCh02iHwfkCzl7TNI/hnMNBmxFB
	l+mvlw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjj8j35rp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 15:45:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b0751d8de7so5596190eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767973521; x=1768578321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHa/kWbVVsFh5MJgGzVqkCaAwCD43l/Fqd48BAH3J7Y=;
        b=Pm2TViZH4zMBhuzh8bKUxxrcU1flHhjkMBoSuIKgWRx2AniaW1OD3Nboj1Yka+/BDb
         X+gaqUwZJDXC97bd7ZhvNXWhWIXK4C3D50siBZPd1eajp6q9mxwAN/oXxBnRgm5gIxIv
         h7jtFgcAS2H4jG0L/Zaf9b8sl+NosajjXAQ4XGcxjPIvxHDyF/DmPiwjDQk5+zzsRnId
         fnG4X389BhgryZerZ8ANHtfG1rJPJdjodZqhRFlDhJfBUICugI2Wzcr9+9c7pe332g0+
         sGUUSqNz2pvEj78sq2VtGBnTfHiihqTFjpVeAEBadCHvSYra7i1DfzojWfVNMw/teFc+
         P+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767973521; x=1768578321;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nHa/kWbVVsFh5MJgGzVqkCaAwCD43l/Fqd48BAH3J7Y=;
        b=Q4HyCu5h82s3OTYmuj8dlu4AGxRtFu08PXzjH9lf3yyzj6IiBDc8vt4CA5nPuVL64a
         FcZngQO1HfSPbc55yraiCEisq7QwquPc6va9O16qeusfG+zdR7a6fu+jW53+q2nt9nXC
         U/WLCtagcCk3dd3dJQwRj0qdV6PZ/B0GPPpuv1SNfmAfN0DO0lz+CWWP48MEg6NWhNI/
         MmD129WbLhPn9jOMjJQwWyP8KkWoNeR8aVv6QTpfa6fKFNFpo0d9TS8vVDlKUrIr+exl
         MqVCbOKNyPEje4l4RXc6p935NpJtiKBoyEO+fi3oyKrWlP/b8khIxyqtRUrObQm5b8Jf
         ooUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9tW0J63OfKjwQfft6cs163JQe55qE+W7OyKpxzDYuIq8SXW/g2pvN6a/ymVcByu6a/n4LKRCS9j9c4Ebb4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/jHdmpvGjbyqTs9cSg5Tw8/hAR+Q6ukU/duu5HIvFjiP6Gsfl
	uiPdbZKYPwmmDQ55Kq39xXjnnmtEZLW/gvrOJpID2pr0nX6I6EE8OKCuIucGf0WSXN7apzONUhY
	uqSa/19yCaPuXbtLiq4a/RD/T1EcGlD4rMl1wCu8esrcyOjrCz8o93iYXuRMbxZ/NxumvFw==
X-Gm-Gg: AY/fxX4V6xhs2RYPs+9vrOWIoV458NxQ0dQBJkzgtQDbHT5Z6Jm3AhQNfIPLWBdekp7
	3+FF8hLQNBJkktKJzMLN4gzcIuUxOC0JEwjOvtMaPT/4OCNt1g88/v/WJuqASRx18XnT7z7ya/D
	ItvzslKi+5pvNaKdz8TPW3U3ZvndzX24W8mCPh5B+FZNB//cTUuVjTGrbC4Fdb3c/utGC0zp7oL
	dYUEu2c6HtJlLV4nGg2rIF+7XrAiRw36F0NUYWivMxQK7eSsNrbYIBj0RSfVPiIbV9HEGRYH5mt
	Qg1bjRbPO3m+QXzNMnwB5V0cNCHK6O1wIiJdmQOFhWx4zFJwErJQdpxHiqM5Uif+SKpV6v9fUHz
	AFRkZ6u5tKm3Pta0T8tkIlWMgLrnuqScppcm59gXaWsPC5IC0WvvUla6SOOs9HzJ8
X-Received: by 2002:a05:7022:d4d:b0:119:e56b:98a7 with SMTP id a92af1059eb24-121f8b0e570mr6528119c88.14.1767973520736;
        Fri, 09 Jan 2026 07:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyfybUnTYXdEVn7jn2X0VrvpXDZNh8Xo7RoiuvPAkiVw8+WZXLaMsesD2RtWgTmwgmYfJ9Cw==
X-Received: by 2002:a05:7022:d4d:b0:119:e56b:98a7 with SMTP id a92af1059eb24-121f8b0e570mr6528090c88.14.1767973520160;
        Fri, 09 Jan 2026 07:45:20 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd8fsm13212585eec.20.2026.01.09.07.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 07:45:19 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Govind Singh <govinds@qti.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260105210439.20131-2-fourier.thomas@gmail.com>
References: <20260105210439.20131-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH net] wifi: ath10k: fix dma_free_coherent() pointer
Message-Id: <176797351961.2503774.11852026073709227675.b4-ty@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 07:45:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDExOCBTYWx0ZWRfX218iqymEaEH1
 zeDG0BephzmRuIxSxCbnmRIsTcleW7mQkXzldDvbGb3Bj4ufXa14rNASiLwS6wGks03wen4Etvv
 Y0Kc6xBeOU74sQg34pPKLRqnQmwE3lmeyZO8UGlDVwxJOqYRXRFPj4QKkRwiIQ+GMmg0AMs8QtK
 2qP2D8aD50rGzpjBmHJ1z9atPfRUH7MJmVItcWh0shu1xyuse0Q2xEucNtVvDRTnv02UK5OBvgN
 Z7sD/37IMbvczzF0QikbE9N3HZP003RWwBPdOEEt7s4Sx3bhPFpypQ2t6CTXk4x8XXecS7KN9UF
 IvFr4hKUXHPb10w7hv2bZ2DbtZMbbrTF1nIQAFs/YwU49FbaTbWF0sPlwuWx6nsplLqt42/FQCq
 Q1xjDjUQvTntIGPkJi0QVAJy56w+7/SGuPGTf6IgXxz2DB5uRnA2cz0TOaAobxdkQjflT6jwE3y
 UwYqFXzT9/6OKbtRInw==
X-Authority-Analysis: v=2.4 cv=JIs2csKb c=1 sm=1 tr=0 ts=69612291 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 8DAXuefZrpe8QdbaKxzlopmuILgSoFj9
X-Proofpoint-ORIG-GUID: 8DAXuefZrpe8QdbaKxzlopmuILgSoFj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090118


On Mon, 05 Jan 2026 22:04:38 +0100, Thomas Fourier wrote:
> dma_alloc_coherent() allocates a DMA mapped buffer and stores the
> addresses in XXX_unaligned fields.  Those should be reused when freeing
> the buffer rather than the aligned addresses.
> 
> 

Applied, thanks!

[1/1] wifi: ath10k: fix dma_free_coherent() pointer
      commit: 9282a1e171ad8d2205067e8ec3bbe4e3cef4f29f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


