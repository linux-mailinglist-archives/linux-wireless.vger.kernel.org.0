Return-Path: <linux-wireless+bounces-28222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8012C06C2F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 16:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3341B869A6
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71F81EFF93;
	Fri, 24 Oct 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TkMmepsC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F620F079
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317228; cv=none; b=CNEt6hA68ELmU4C/5vHaObqJHwhe5z82uRshohJ0saqsOWu/w9WWANwmTfdlaPgTfhVTNWvqK9IDzCiHtGmqr0SiKpI4sJ1eNerNkz3dSHm6eKreE8rOXuDLI0VadyM+vgkOdQsXkSJNc+GNTv+jz16wZSg8f3pqsw5TiLnGnoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317228; c=relaxed/simple;
	bh=b+/wYuyeNiElLoRMUwxBrh/AMnzPvjbKUGQC6Wk7u34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LNxmzHWn1GHkRbUF8vssRZmPhPuVGOqYgboe76N/fj6wqC+aSqIpWKZJj4Q298oCZciR4WIT677GKmLHuZvguYdyOmP6qO8BCxBfRegZLyjJk2F3Nj5AaS5b3pKu4iWmL94ErPOfLRIJ4Mi1GJlkm55s1K4QqFcd8NW1mukZ/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TkMmepsC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OBdtCt011090
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 14:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6V6F0xq9gjnOgNAcXk2tN5OfB5dID9k3MmSC3lL6enc=; b=TkMmepsCqekhJcqu
	deaxfxy/uigiAOx24/BIVa/olmKwmn59i4SsXvnme1nxBJXUwW7jUEepDyuSPdSR
	DqFckZ4hLLW5gOVx7szbfjyI+jPUOd5dutUelNxHhuzLNW/8wd4GtJMKAutQDuSb
	CDq+0+1HYKm4dh09vnmJqeCQIm8Zkd0Qxnzifc/b7RG0GpczMneu4apygDJn7/ES
	kJhbexY89fvWgx0jdkrD7rsqZmj6aIlPJr2/Q1IOaDp47UO1cnWmBM5NLOXbsfnH
	W6uPVGA5sXZ3WQiLWskl5GPbbk08XjQ5tgWuYeFVs69jMoyoU+pCX33WzBDQurfF
	2LIIvA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524ehyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 14:47:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33d75897745so4507751a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 07:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317224; x=1761922024;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V6F0xq9gjnOgNAcXk2tN5OfB5dID9k3MmSC3lL6enc=;
        b=JAfaOpn6SDVCj/S/qly2NfdU0no/xYNpTBNnfMhEsk7yojfGzFdnbRTXvEW6lbyE3/
         vnrvo8NNt6gc50zOt4vt67m3vp4FTVz97Fs2sFghZllfXWsN4b/qf+cY1jkoaw1MVrMX
         PHn9Qp0dc1daiNXxRmvfLoo9a4hKBzjVyIpIkSJr5jCEDSj4Ondq6FQBM4bgJ8OlNksg
         Lc9zLybWJjbn05d/cM0Wf27YxmrMRuj/ACBwPzagkAD0wMGtomUnWzNoYPYjdffCPhnu
         OLOxD91rUlgTT8lf1NwOPXnLf+XzzaE+CsGgPS4zed4ef9pId+0w/exwiG/EuiEN7KAT
         iOsw==
X-Gm-Message-State: AOJu0YznO4yb02mHUxzKRzKyQv5VEO3zHyz0uA4YPj+jk8tZSwjMd1j4
	M41bibn1NmKyydewGK6yoTHiTuw/QfbIF3BEvRhc9QlsmHTsDwJR58R2H6nYw7TxovWWxFSQ4uE
	9ARXyLqHcglPogTmH9PANOb692TerDmvkjmfC0du7U61ssFQCMyjOA6DtZ954xkv55KYIYYn0px
	yWWQ==
X-Gm-Gg: ASbGnctHuUMTSyyNK3t9lJMAcJG7xPbodJMX0b5aqupom0klX6eh1/lOeQ+y9RmtgrB
	p7ybtspAj0/nI245IKRwD5/vYjjc6Ghf6DhrYcVi3qK6hRQFu6yeXKTDJVDRs1kitMBSsFOR0gC
	smvIP1zeOcucgLNLl+YgBy5kOe8/aYTdVonDL+KYRluKj47er8vuAKF9D9yIKfkFWrrPARHD5JW
	sdX3tpQogScjFuy7NdCERrIF5D2ew/P3iVGSjx/9kwQmQaiU2lzKZxXVyMtWE5BvZ9fvL8owZvo
	Yx1VGFT0xkdHXVm4//RGG9tT1wJTjmXlw66h3ctTGKp4oqf7UTYgEQElsHhg4VtsmsnkXYz9x+Q
	/mqwYsK1pg3L8RNEiOKsYfJaAMEWKRrqSGPk=
X-Received: by 2002:a17:903:22c3:b0:293:57e:c8a7 with SMTP id d9443c01a7336-293057eca74mr118517105ad.23.1761317224400;
        Fri, 24 Oct 2025 07:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/N9mfDdUkFMrFduZyJ7BJqc/QkAT49hfYFmk8eMT9eQd48OzYInqmsbKv0sBuWn94u3Gz/Q==
X-Received: by 2002:a17:903:22c3:b0:293:57e:c8a7 with SMTP id d9443c01a7336-293057eca74mr118516605ad.23.1761317223665;
        Fri, 24 Oct 2025 07:47:03 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda5771sm58169035ad.18.2025.10.24.07.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:47:03 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
In-Reply-To: <20251017-ath12k-reset-window-cache-v1-1-29e0e751deed@oss.qualcomm.com>
References: <20251017-ath12k-reset-window-cache-v1-1-29e0e751deed@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: restore register window after
 global reset
Message-Id: <176131722281.1606896.15789445114117878112.b4-ty@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 07:47:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfXxPjkVmw0+BLG
 Y5iKdXzNMKtB3+Rn/ZzulkkoEaIH2ZGFk/tXU8E3jzGxURKPisAo0AYS9VTuHRL5Zvn7ym5zyoA
 BaJCvbqwDkvu0/BLzTjOFHL0+janjH7SYpKIchHoa29rvM/W11NWmp4s9s4e4i/SsT9uFaIY9y2
 2n06MSFKrtAddo303Q4T7dscUjjLLOrMkzVapzTq2iUwHKmvkYt19p+JADWDITFYIg0J75ac6qg
 gSlJqUhpCIC/AKJCxQhn0u2jcGTGIMvPo9jFg67R3YTD0UTjYv091DeTTJxlBA383R7j9q4nrv+
 FOIMFfNPOVLunLd+ONQmUL8gxISYy8CqNfqFUUGUPYRxgKZ4VQUP8RfIECPCEhzQZwqG1JswUny
 wb7QlA3I5wWqQO2G1W49DrauxWLAFg==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fb9169 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bE-cqvqhFDU5jN8ZjzcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: _v4RFV-jZqvq5e8_qs2_swFNYB2NLnoi
X-Proofpoint-ORIG-GUID: _v4RFV-jZqvq5e8_qs2_swFNYB2NLnoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155


On Fri, 17 Oct 2025 10:36:36 +0800, Baochen Qiang wrote:
> Hardware target implements an address space larger than that PCI BAR can
> map. In order to be able to access the whole target address space, the
> BAR space is split into 4 segments, of which the last 3, called windows,
> can be dynamically mapped to the desired area. This is achieved by
> updating WINDOW_REG_ADDRESS register with appropriate window value.
> Currently each time when accessing a register that beyond WINDOW_START,
> host calculates the window value and caches it after window update,
> this way next time when accessing a register falling in the same window,
> host knows that the window is already good hence no additional update
> needed.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: restore register window after global reset
      commit: a41281f6518e485220d180a6031d302a736fc463

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


