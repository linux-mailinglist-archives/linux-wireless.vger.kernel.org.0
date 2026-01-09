Return-Path: <linux-wireless+bounces-30605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D97D0B0C0
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 16:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11881309ADEB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4C3624DB;
	Fri,  9 Jan 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NAbJAxGv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DFCMO8Ji"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88054312827
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973525; cv=none; b=q7r5FPiz41VSY8lAUTxxr+j8Ivp0oo31duZXp8wBhn6tMYDuSKbCt9GhheOrdx3VghHAZ0yLRHBU2+d6UeCu5Oqbl2O/y4RdzlSde0q1hSQqpiIOa9bPABmJtczQGwh8A6i7D7+4XmCatebt/FleGdQRTwzVzrHDpLWVio3fbgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973525; c=relaxed/simple;
	bh=M00mJV5cMuXtrKsplXWVdp3Oup3FNSXlU8GS9iB/sY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UM93Lxr4s4hBdV429QecQXArxMGn5E4rKji87WVyqKD7p2IlF/QDD1+tHUPyHbqSKeM6CJALQqX+hwzbGAKgTLRqeqaFCO88VWmaZvjZ5qGAdfn9JCKBzZHW+i+NDYeavbpyuFZ3ULhjWb9M0AT3NXxPiZHS+gmX1jDiCjQ0Fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NAbJAxGv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DFCMO8Ji; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609B39aa1063483
	for <linux-wireless@vger.kernel.org>; Fri, 9 Jan 2026 15:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ODQQxUBDpSSDgzBzbSVqkcIEt6G9NnCCFOxruI1fiGg=; b=NAbJAxGvQwDZ/q2P
	5JzMrRFta+br5cDLTu/9D8n5IxGxRQwYDIfhtkDuyft0UJpD8p9FwrpvGihax7Qs
	jGiSG5qz7Uft9VXtBcx+9cIYiI1zV7qcesr2D3QZ6Qf/ZbjDWa9AzhNt9CrP8eTV
	3FEXgGbNn6Lor9lzJfzoUjot9svR2N+mzNCqikymTRf45Z5g55pykAqVfhB/MUZ9
	gevF7Szmlz3V8b13NaUli7YppqIHp3Tsqb3AV884koR4GINrHjZiuwWOs8d/HrbS
	spGWSAiwdN7Mig9UmAYpIYWNxGpiIHPwBbmCTg9igfkJshg2RixalI/BGnKTTA1O
	eSLmJw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bk0f68rhc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 15:45:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ac363a9465so3490525eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767973521; x=1768578321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODQQxUBDpSSDgzBzbSVqkcIEt6G9NnCCFOxruI1fiGg=;
        b=DFCMO8JiMQ8Iw0NqpIpjuf/Iyylp6nF4a4bGJ3H6+Eb2Fi/6NquW7icve0jShhPtqf
         +ZYupQlirmCicUsSuRdGuBhKFj0s/GJS+eWv+8ljsFh/3f3yF5Fq598bl3Pr4hjhR3rS
         rS3yTTsutF9yCFz2tp/G+W8KsszklsRuLSOmPdkC3qlqhhS5uegV99TvXIMlHH2ISzz1
         +ePdvH8set6A5PwO7/C/10ivm1pIofQ65fSJLvONKuAKevEBM8ponXoCKcuixUjwXVxi
         OtA0mt0/FhgopdslG6XhvGdmKIcOIFtgJzd7pDkpit4zU3u7E9+xv+r/TSa7UGB8yFrr
         yIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767973521; x=1768578321;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODQQxUBDpSSDgzBzbSVqkcIEt6G9NnCCFOxruI1fiGg=;
        b=grrrTicpvugkQ6lED5seShA/4+mos3BWOZYCPvc05DEPHUd6PRikjmlXlV0kKFHYh+
         DAeCqFxdBOmIwgIzzZUEVV9kuaDwGcWtsAdVGBT34wfhCnwbAjGlVB2FGRxiv+43xZYA
         t6GaN9khX8eU9y4UnBNdge87giWLkVmpXq7/yojCT5uBomsfOC5g4aSaVoYp76jR71DO
         MIB3Ys9pT2ZMNG3Qd6AAEpkVNhOaPuXhRhYeFK9q8JN+8WfeR75syfHw3ksuXk5fCczv
         iMNtdUIfgvommrVbvnUuGrjHvBMAKwWgNVYD1RrFV+WyFJU5cfiO5HJqYD1eaSuTu8Bs
         1ntQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYqhD2l4QH1PC7nShq3kPsWfoqNAhllJjQMPhsTsletFiJGOEg4S/NAE2prW29W7/sIYQ54vKbKxmYTxqy6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCkD9PMSTEKF6/Fc2mgPrifdC6VKOyZP204047GNa7JLbiZ6t
	3WwVclsn0YCU1UPSkTSgS+X0x0+B4iFwliXFbGCfxhrtt/IpVu/CT1nDC1QNoYTxNwegwBdlcfO
	dRQY9mK4utTC0TUK3668qwl/nqmFbbIIQjuS9PgAX7+CpE12o3woCDBWK9pfVwB1dWpWifg==
X-Gm-Gg: AY/fxX63zuZv+KRQeQ87q+uTtF6mi9JMDhEQrX6C/+DV9SaLm37H9Oy+u9aPD0w1YIz
	lljhOOoQwXZ4fgqRG8M4qmxjo6FleuM8ZTQhiMPnbiHLkMK/UFffyc3NfccdZg3fy+h2BJsTfUa
	huH0arPZX47cy+8mgkvoasVErTXsoZaBPlGRJWuxhl7jD3meoxEa/j6DvZzuZnaMQyVoTU9g77n
	tSCnBmA2/z3+Y0TSRVyCbqe6FzLSP62ZimUce7YHAMpPEMZG/SOHdkOQGFkbQjqKQJs3GHSU8RA
	euWM2xQ2gFQsGJhhowFOk0N8m7wvsTMcK82GuKHQUu7f9UP1NlkHoNjMUnWNp7gX6vIHNUSwHGm
	Sg9sDOYhhfk22R12hM2YxBwQXWslB6E576/tte55+K6tEE3/xahUVg9zDkHokJaCy
X-Received: by 2002:a05:7300:8290:b0:2ae:598e:abe5 with SMTP id 5a478bee46e88-2b17d321a6dmr5550960eec.35.1767973521396;
        Fri, 09 Jan 2026 07:45:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzeEmToM+pLvDD8pk/75vshZI3WatO3trU2XnbBkHWqxZ/l7rfFBwfToAGPYoY73ncIV7pYw==
X-Received: by 2002:a05:7300:8290:b0:2ae:598e:abe5 with SMTP id 5a478bee46e88-2b17d321a6dmr5550940eec.35.1767973520863;
        Fri, 09 Jan 2026 07:45:20 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd8fsm13212585eec.20.2026.01.09.07.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 07:45:20 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
        Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260106084905.18622-2-fourier.thomas@gmail.com>
References: <20260106084905.18622-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH net] wifi: ath12k: fix dma_free_coherent() pointer
Message-Id: <176797352034.2503774.14369689269983981548.b4-ty@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 07:45:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=P803RyAu c=1 sm=1 tr=0 ts=69612292 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDExOCBTYWx0ZWRfX3o+MDtCJ7XqV
 4MA+hbDVBGCJZI1QD5GsG3UIhdAnmpQVMsjQlFqLsPmp5neeFDBXsbrEnQBm6scHI0xpb/GdouK
 iBNkwLMl9nGel9jSnr1j1GsC+CMAI+WTQcc5+yIzzuG2M5+lEkrhZf5ZzgdljvcR2i66SfMENyB
 zZ1vXmTMqXvfUYSpQp2BPlVa0WIkcaXA5XovNmVZTWLfNFoV6fQP1HjMa9GvZEGGxnFv34tMN0p
 ReksWZeI/D0eVRxfq9txBP8uuS0EsR61ThqaCEVdNXgcRG51pt18EYMWiPXpaX37oHMdyZ8z9B1
 UWTNrTxPS5rPtQNKJ2Ng80PJC1LbFq0LYzq7Y6cytVclOfSkJYnaa7hEMhSSO7qsibcbGUJSSXY
 fqxvt9f1QakyGzvQMjCFoZUyHKexTjPLRAgu3b/oRsnK+zsJN9jdZQzaQG94sfRJeeeWr1069Bi
 tn/UX1x5J3J55QodKTA==
X-Proofpoint-GUID: oM7HO8K5RPQ6tsT_OlnPBLoI8p9jmSBE
X-Proofpoint-ORIG-GUID: oM7HO8K5RPQ6tsT_OlnPBLoI8p9jmSBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090118


On Tue, 06 Jan 2026 09:49:04 +0100, Thomas Fourier wrote:
> dma_alloc_coherent() allocates a DMA mapped buffer and stores the
> addresses in XXX_unaligned fields.  Those should be reused when freeing
> the buffer rather than the aligned addresses.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: fix dma_free_coherent() pointer
      commit: bb97131fbf9b708dd9616ac2bdc793ad102b5c48

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


