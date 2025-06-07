Return-Path: <linux-wireless+bounces-23823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF0FAD0E00
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C4C3B0D4D
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA4D1DEFE8;
	Sat,  7 Jun 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FcD6bmaD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F681DC9B0
	for <linux-wireless@vger.kernel.org>; Sat,  7 Jun 2025 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749307446; cv=none; b=IVTrgpUq/2OUrWGrIEMXDco1reTvRGNtbHyhIiyoaWyoWBHoLEPent3YMnmzLSmj2ksHzYI9NyLVV+w2iaIqFpMix8uDMYe+oZTkyNxuhE2bT3IJXdT5WsmFpEz+cPJh4nVaXG6iHfuAwn+0Nr7z0ZPgnE6H0lC5IKNPDX3mpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749307446; c=relaxed/simple;
	bh=06QCCbe7hzLwzefTu1oYClxucg70yv46g5wjQoX3JU8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pCnC0zyAV/TEcLsdWNjfG73za8gXtowOdaNtuGQCgtcseEEkIoPYnhDoDw2/7TtyHoBfbrniwE74t3O5hQYiZun9hGZLVYpS1BAxdVltlVAC8X9PVsbQ9yN5R/OrXW5n33f8ASW5QcMWcZynY4/fBbyDPcKzWwSJd1069t2gb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FcD6bmaD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 557Dfs4r004979
	for <linux-wireless@vger.kernel.org>; Sat, 7 Jun 2025 14:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5AJoV7kJK8wLd0qFjYQ9a0bVzN+q1YKr+TdV+FiHH+8=; b=FcD6bmaDgt/ua2bd
	ZdQdUHNg2LPkXbU44nxJvyiOwq4V0s+KKBcmsGsNFAc1zycL27/UntEhij2/mkhF
	D+/SHsEeIOAnuvBEVH11+Xhhwq993dv5uQaYhdgyOPcwb/7g1vNbTVeWPz+wSVZU
	S/OeBnXzrtq9Sue0CPbwEWLtjWxand1q2K/8O7pIDaGySrfX7NgnWVD19JlXtoo9
	AM517xO6iJ8JfdpzeifdgxqrVPHtwr4gZKqrhxW/8LUnzuKY8VPzrH9BfD6Xnvbo
	cCDe3Fx4tfPzx/Epmo0MyJl3Lm/YXWfbKpV6/FQBjw7CKclULrib775US3AYHTJG
	EohoVg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ccv0sm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 14:44:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23505adcac8so26644945ad.3
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 07:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749307443; x=1749912243;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AJoV7kJK8wLd0qFjYQ9a0bVzN+q1YKr+TdV+FiHH+8=;
        b=goaXP7CKnHEABhjfJkgwSslsCeoTpZlyPI/3HLoyX7shfjJxX4G+XpMvcuihIliS3s
         1+amnhGAd9BTqni4LupKOzxOy3NzxjRdAWh63Rtx7p26wxIX0iINZ6csjSx/91y4GXIh
         JaKJPYv4eleMRLlfHA3PogXO4PYDvv2MeIM+1wgncW5RNNRcVZQ1d2GUC1RwFetBLfPK
         IMa1C9bitr/yoFV1qPveq5fYJ1JxUGpr150DsXY45zA4ZanK6JfDWj6n94jP+kevpJkG
         /asbZ9QJY6fi97ZuYOtRjmonq3qBVG2d6vVd2n+qeAw5poj5me83L5O6rtZDpgOoQfLN
         EEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrL2Cx9rOy9KjO34DsrZ+3cT3FpAfewqIXRqf34N2SB9+JOqZ0l1dn//6ptfCJEH90VY5JswoUNt0EChU/VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0EbaMFTpH6oG00QV2FNf/z8QvK2ajNb6y+GDYbWnyJYXrsN4
	iLkYOpKDCkX5JLDQ85CFJ3SVswNIo1CEItQFb5PgVp9Ykm9rbFF37emgxGjbV0LmZlRE6TMFD5o
	UF1fkqggNZf0COOYYnYQLTUABd03BhGG6peDk6eDosY1m7sW1oJdcEIT2b6w6dNjfojckyQ==
X-Gm-Gg: ASbGncuu6ljUcI6qwGqnf8bbhUBBMz1+nmA6BkLjZS1AoZYoJidDmLiofbMQB/pQZRk
	BgGpAUYrzGaZt/7mrdYkp8DmFH+gFRKxd6one/pQePlrekZY0aAmkyXrf+zCqn4lWCmINpRppN7
	WNWk5iHEbSBDzYEIrpNKk/0Gey9qM+XkX1sfPc4u2t9BMI2cgJEpryBPGChv0tESFLn7G6ZnZUh
	7EH0WqXG1ZoMY+m2E5J8ufi+sT6xuyFI9i/KDscN2qGES5rUi1UCUKsTtpAYKxpqrpxkAM9zWy1
	MM6XxScZP9PqDYA51bCRvjNKMRbkZu6ev0NTaN2/d6vXsddK
X-Received: by 2002:a17:902:da88:b0:235:129e:f649 with SMTP id d9443c01a7336-23601d01ddamr113333275ad.12.1749307443226;
        Sat, 07 Jun 2025 07:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf5t4bZmgcbYoheZ9gcH9Maf9GoA/v2OUQJJJafoOCAMV80dVHYCz/9D7MSymX39J2T0nWVA==
X-Received: by 2002:a17:902:da88:b0:235:129e:f649 with SMTP id d9443c01a7336-23601d01ddamr113332985ad.12.1749307442864;
        Sat, 07 Jun 2025 07:44:02 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm27626415ad.72.2025.06.07.07.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 07:44:02 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Sriram R <quic_srirrama@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Parth Panchoil <parth105105@gmail.com>
In-Reply-To: <20250523-ath12k-wrong-global-reset-addr-v1-1-3b06eb556196@quicinc.com>
References: <20250523-ath12k-wrong-global-reset-addr-v1-1-3b06eb556196@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST
 definition for WCN7850
Message-Id: <174930744132.154748.8693669637865725058.b4-ty@oss.qualcomm.com>
Date: Sat, 07 Jun 2025 07:44:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: px7vE5Wh9usASvmKaUZYUTytc1Ptr-6u
X-Authority-Analysis: v=2.4 cv=TsLmhCXh c=1 sm=1 tr=0 ts=68445034 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=17ir-Gtp1zVAAPY-F3MA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: px7vE5Wh9usASvmKaUZYUTytc1Ptr-6u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDEwNiBTYWx0ZWRfX6RtR+HENkrjb
 L4fD8d7eN1CD06seyY3cmp2Sy155xTFYHpc3Lni15VKiI0PHtr0YnhygKinFvo62PDgCLQu8PFR
 SUMLZjZKy4ikPnYKkof57VZX0s4ZsCrTCo/t72tYacWUtRq86u6jtpgJB9W42tWJc8N+H9/Z+48
 OdNr9b1ULJkXgy4i9QM8yuI25AO0oVa8GIS7pLBDxR5sRJglUX7/mZRn4wmppgE6yEV/qx+7+cG
 52yAnBo+8dcLNeGBqP+aJJb/tIL5cSFRzQCx68hTmsy1M64fEbC67Z+ja1s9QY/t3kfdvYBYwIs
 SHF9RQw41E4WAh1w2IWyAfBOIIf/MCazqquWuXRO3PdnJopRIo/jv3m+JaS4Aj08FGj5Fjc2wVH
 AfqoJxQU8tYBOQ6BLJI2jfoiFKYErhuLKJwEqVco1rI1qEnBdLnD3I/A6qe+sa1hbLzcd+uH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=653 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506070106


On Fri, 23 May 2025 10:23:05 +0800, Baochen Qiang wrote:
> GCC_GCC_PCIE_HOT_RST is wrongly defined for WCN7850, causing kernel crash
> on some specific platforms.
> 
> Since this register is divergent for WCN7850 and QCN9274, move it to
> register table to allow different definitions. Then correct the register
> address for WCN7850 to fix this issue.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition for WCN7850
      commit: 7588a893cde5385ad308400ff167d29a29913b3a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


