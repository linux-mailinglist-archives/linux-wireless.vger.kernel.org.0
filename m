Return-Path: <linux-wireless+bounces-24618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCAEAEBA22
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 16:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715A13B5979
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 14:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE882E7F27;
	Fri, 27 Jun 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i1rwSdl8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47F2E719E
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035427; cv=none; b=rvMLfBUUAT8FXWYuyC+BHmsOBM1bzyKPgmfH5uQs7PmpeJAEr7q+hPLqXjtaeGniB44JX/msBasYILKQj/gUdzO/wUjKQDk4csPls8udSiccMVjoPfKqiXHJ668296gl8HaZxBejCYPq3ZhmMESqfWjtuYhow79iCokca5hRWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035427; c=relaxed/simple;
	bh=RqHER0llPYqrYL6CWjpVbzvE/vaR1vYLS2HFgFolPzo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pDNYjt2dvivTl2Z7rpEYAVvCUsc8Rs03+aPYexU/nQhkdCwRXnxACGtX3t9wW5XULt8yf3RfyBdMuOFs6ANr1WhmyW+LtSOOM8JhYn26trTCRgiyBtP3JbdCOhQPcgN5CaMIBZ3Fo3ZWPB+JX6FiNkRgmP3TaMGjVM5f7zfgv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i1rwSdl8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBYLgI028868
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mrff0Eh0/7pHswQZD6QzcRarWPckGhlkojitmmAjnqg=; b=i1rwSdl8LyYF8ru2
	nOE5WTYhxuBadQ7Xhuhx4BLDQYkD2y0fx/o+j5OWGfWPlM2o0kzQ2vz0WDG6QTBa
	MXegwvTdMNLE6RaP3jDgOCfGAUhXVaSDNotGt1fQ5b0HB0LYQn5FTwbb6yeBpijx
	Kv1XjKMa1OzzB7NyxFkCtf7p6Vp5ez7CHRQek2ZdfN23RBQN+a2+bLZvl7Ou1zDM
	FgdxVC/K01nK/Ga69sl/SK6XQSxLkmLCl9kUk8ffbkB0y0olIVkzBY0T350E+rlo
	GXO/NUJAPjTTUjsDQntdPw4x1LC7zxZmuqc8ffrniekLddbc1SVKCyn99Z+PiAgP
	YtdJ0A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47hkpbhus6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:43:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748b4d5c045so1929590b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 07:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035423; x=1751640223;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrff0Eh0/7pHswQZD6QzcRarWPckGhlkojitmmAjnqg=;
        b=FIT6GC0uwDTLxsmG6NbqP8Qglh942EvnclHlSLMOomIKcMT9cG+MHovEfEwfhaiYz5
         zLIvGntwjETqEqa8nZ0GVAMWhoo1uVUCTNTyKimLPgzrVVTPYbPVcep2ojO1H0zClJAF
         1tK6rEJI8PR4IW+IdbCUxcb3IZyg92Zbr4eElxYlDe6XNc5kLMCJSTqHFS0YQOPLDOX3
         oB4+2LttOo7RpA0mnPyxYhvYfvhxuPVriX/i5FDtWb/ASDH9mmzGJWOEJs3fwuj4VgqH
         McGNcSAJOPbafWPEwXkisxkkiD7H6tuTd+FxfyrsCg62PIiKYsvarQKCy4S9jMLHq07f
         kLqQ==
X-Gm-Message-State: AOJu0YwTaTymVwPUzXwibHcBMsrdOfsVSjIpeZSVih8EEBjFJ135zvFn
	81TNn/f4FHSEvTOJCpAuhectzJyJDrm4prSutVP8a0BRo/sw6Aa772ygJGBBi1KWT/t0cjl/Igd
	HksjNxs74hksL8JnbhFYd10Hb1zHv3KSYC5jy+niS+N1a1VhfnBLLQjHvUPyRCeDvVDI1qw7VjC
	ka9g==
X-Gm-Gg: ASbGnctmC1xnDLOGfWm3v1nsmZSRXWptvBoqX9yUuy1TUW3R9+xRxpcsqK5ayZDuXVJ
	34XNQ4ZlVyMGnNqhPpc9eFzBrx2HRSx9IZn8TIs/pZtOTdJsLFGQCWUpgGXSB1G0HkzOqxhysZo
	HD1Ps5F26sHQRt9xs06e3qSW6oFTCQYJ+PYwj7CZKElgpb3N4MLtqVcgHPIIuv0tyzNFbi95d3k
	OqWlA/3KqtozPyOuTS7sdeGeXnczqoBFjlIiOLP2JUIWQC6cnlNeWI8+QEJ6GKZ3Yl8rfFldW38
	pRlw4a0tY/ReYgobciT+0uXezKpKOZBn2Rx2tFo0Bimw6bTp7J0Gd3kOIoE=
X-Received: by 2002:a05:6a21:6d87:b0:21d:fd1:9be with SMTP id adf61e73a8af0-220a12d79demr5320880637.12.1751035423430;
        Fri, 27 Jun 2025 07:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyIcQ16jrQg7zZ/66v+sKRfzIx2MtwgIs5TwJxFdfdeYQzRugkkvP+TH2uLlGHAyjE5IUTyA==
X-Received: by 2002:a05:6a21:6d87:b0:21d:fd1:9be with SMTP id adf61e73a8af0-220a12d79demr5320841637.12.1751035422998;
        Fri, 27 Jun 2025 07:43:42 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ef4ccsm2458956b3a.156.2025.06.27.07.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:43:42 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: tglx@linutronix.de, mingo@kernel.org,
        Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250521053323.284845-1-sumanth.gavini@yahoo.com>
References: <20250521053323.284845-1-sumanth.gavini.ref@yahoo.com>
 <20250521053323.284845-1-sumanth.gavini@yahoo.com>
Subject: Re: [PATCH] wifi: wil6210: wmi: Fix spellings reported by
 codespell
Message-Id: <175103542219.3295854.15091356582053137199.b4-ty@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 07:43:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyMCBTYWx0ZWRfXxMjKVg5X93QR
 BqPXZP0gVkX9cTj7Xz8B5TpK1EUkMFfyQHTCgC7KftTgcXKXokDOyxvGWbv/56x1aqY5cCVu7YL
 lp5xUSTTgY+9Nn5NRB8Z/0NMHlZovvNICKQ1BxcH6Lj0snpvHRrY9Bd44KAevf/81SKpFYLoHRZ
 wZbhI9CSPlKfz5iRicubp+SXqR5yuOyRTlbxGM9/korRv3WhJBpES6mXenJ0OKDFedYmHXFJGrE
 JaFcleP9XYIJpazh1heqQ0yyKX/lCQ5yXMV0KmA+ohkhoDDvwjv0ESTO34uDePXFXhoeGbTe0AX
 wiohdSFzwyK3O33V2Uwm/Vla9ME36oIR58Q5cmhGnvyBh1auHSukFlCzoMuij4KnsrTEL6UkGjd
 wA8t6jkurCZyFGNabrF8br7KuluKJK9OhNPJxXLUJwTBuZKyhr0+fgYdxRGWkdzQIe2yMfze
X-Proofpoint-GUID: rloGkIY2BTnKdUWg_S2U4gdQCrcNT88p
X-Authority-Analysis: v=2.4 cv=AY2xH2XG c=1 sm=1 tr=0 ts=685eae21 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: rloGkIY2BTnKdUWg_S2U4gdQCrcNT88p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=694 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270120


On Tue, 20 May 2025 22:33:21 -0700, Sumanth Gavini wrote:
> Fix "busses" to "buses"
> Fix "Measurments" to "Measurements"
> 
> 

Applied, thanks!

[1/1] wifi: wil6210: wmi: Fix spellings reported by codespell
      commit: ed259ae54de6d7daa778dcb3471c00367d32c11c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


