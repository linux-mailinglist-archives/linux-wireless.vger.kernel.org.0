Return-Path: <linux-wireless+bounces-27496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7DCB87670
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183F01CC09CE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC72E5404;
	Thu, 18 Sep 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJvILq70"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA82BEFF8
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239246; cv=none; b=GNkHXD/Z8xdJ9dimH7zlMCBdukLEDu846oZsD6HJVFSZPJzn3ubp1qN9NmflgCgqevSrLFqo7f7Q9+zpk5IBKTuGiE+nu4pG6NH4+TXAQB5kwIVzfZmtfxIUJeLttp1SjNihNBydWXgVjQHygCZEHMMIbvR7lIsQAz/gWUOhgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239246; c=relaxed/simple;
	bh=W+VZMioL3cyeN/iZzuHFELSbehOTVHCsB7I6ctk9ryY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z1fLid+hoM6wtr914gIMUN9JisznPQuAXtQy0gJv74Vvq+HzFPYOhFsiwmd/tCZ9SnYoz/ubhFH5xk3pJE6gtTRbZu1dL2J412FS6chE2RLoMrsGO9yrdmBiXYyg3cXEpqApELz1wKKFf+7TMNyy2CtKCV7oSpZHsk23CsXJtiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RJvILq70; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFKak1007100
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GGhKWo06xdjZ1sk8lDnAZ11n0wQycBWzDYLA/JUlzxc=; b=RJvILq70UFY9u+hN
	ggNWmmvUT3e/O1/W+F+WiF1U/lUOkYNiU/jhnmi6L9piNdrov4I8Iw5yzGqJJkhX
	XnCDjmN2Hrw8vdMokbROXC1qTWAZ/tJnEZ70VtTzKTcabsJLhAULP2CV66jqxvlT
	scXp14OszAAckmaKfieWnFHRmTA9VgWKvkj35ak+2obRfebfv4f9+PKwoHzhkCU8
	gLRujYf1T1aBv6YY4WBcdVvFV3Rep4Qhg5xwKCzJU+gJ3QnrCW0JlLDzdvXJ7V/N
	4rbCHo13ot8MreZkT7cMh5eCoCTCLu4BLpWM5EQNxzEmgacpIhCW2S1XMkduK40G
	fd2+gQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebetwf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-25d21fddb85so27509335ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239243; x=1758844043;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGhKWo06xdjZ1sk8lDnAZ11n0wQycBWzDYLA/JUlzxc=;
        b=cufMVfOpfi9EP/0L8KmhLQxYKcGayp2EgJV296xAkNFddVQRYmTx6anUTTTA2W1oBC
         ValA3ik3urSIrjgMVTDx3YUXaxC4tiWXQUrj9FUD2N5yj7ZrnAUci5cvslxG+vcW7QRo
         tShyHcPesGFO+fCpzNvjUDhilo4U7mbTDJx2PtMnAxZhAc0Hjmci0o34ZzUrvcH9tqTV
         A3gNLW4ngl5D2GlHsmEKgQoKyVSWWYfHXPCRcsHENwjiHoZahcsq77VIdFTZTHMLxU0C
         WcRZXUjeO4WGCU70RW8NpXPlWtDKjJe2/8uDvOEsLtAPxnG42CRSKanzNl1q82cPJuIY
         NZbw==
X-Gm-Message-State: AOJu0YyLJdeQcWdEtcfJHlQkrlZQFCRY0p9EaeU1uhRxUAgM+Q/u3Go7
	0nRciFpBLup9bNhGgW6tPsxBc8vxxatkr64eVYZbCdGBtH82IxQFRow97iC/+jcLcLZn+TpSlsV
	3GOlwRs8PnxfLCxgUfFv62w2DusRJQvyHaeG7hYTb5Sltsu2DVPP8uPD6XD/Kg8il5HU33Q==
X-Gm-Gg: ASbGncs/+RLK7MKDgGfb9YVvKTV9zC3wPtpcxjmCDGMD74mdEHZeHinQCPfv63foKax
	E16UUPBtGcQrEKyJQXedyD9ooedkKG+4iVYqUZn6kFgC8gSPFkCDilXmwkNey39piQPgIed3hsQ
	nzr8DvQ2HfhRl47OzeuIA/qeUBNIpqfWzzF3WlPSnw9U9aS3dovYrnbLrSiSrDByHVPa6SpzC0M
	QNxLA4jZhrsjQMUb0t75v2lnoyCp73JCOJZB1IGDIfUTXFLJU2gSg3jPJiQlESqcKcRAMcNWvqX
	EmDeoy+dxE3XGUuPeykEEveYhW/GBAKfwf/dNK5BrktApWZAvFy9TGLFP+boYYsizoOiWvjNpTa
	+
X-Received: by 2002:a17:902:e806:b0:263:a2f7:60a0 with SMTP id d9443c01a7336-269ba54f32dmr18333095ad.48.1758239243528;
        Thu, 18 Sep 2025 16:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS5ESImz9azKWgPEaT6zJE0wYFMba62mGhYFWVz45LYnnJ/jvGx1WRG7NesaMARFfeVaFrmw==
X-Received: by 2002:a17:902:e806:b0:263:a2f7:60a0 with SMTP id d9443c01a7336-269ba54f32dmr18332805ad.48.1758239243126;
        Thu, 18 Sep 2025 16:47:23 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:22 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        ath12k@lists.infradead.org
In-Reply-To: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
References: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/3] wifi: ath: downgrade logging level for CE
 buffer enqueue failure
Message-Id: <175823924196.3217488.6845685039081313219.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Q9nMoC3RH_1X-ZDgyn60x6sOFDbhO2Qi
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cc9a0c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TpeBPK0GJKfZ0rfD3RcA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Q9nMoC3RH_1X-ZDgyn60x6sOFDbhO2Qi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX+xnKqDG40Xb9
 QK6FeJ9UgAD2hwaa8NXiDSir77+9/U9rGX2mQzB7I4KjuqqRZGGP16s3/rC4YztG0GZgQ2uJt91
 O3O95Z7K/93wpCse9EDrMb3rMRR8k7lIdU+40Pav6ll6zGbAHD+10JCbPtoZJKc3IENLrF24TOa
 TNnNg7rGmB6UIyZCP/78umjvc/A5L6oLrCS+iihTZKAgStJ8ZQiwGuzm9N1eBk/CJsJq+tXQyIl
 tvoHamJNIPCHgPFgrpVPwjAQFXXpJ+qyZRTehmjWiUh/9xQInq/SUrKqDMCI7jE1z4OwIqqvqpH
 RiE39nPQx3d/KqtRbmo6HYF96bo+jTIGjKMNRHyV7HJy1DKFrPWaSsrzkvfHDXce9jqNShExFMt
 XCbnW8Cg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074


On Fri, 15 Aug 2025 09:44:55 +0800, Baochen Qiang wrote:
> The CE buffer enqueue failure won't cause any functional issue, downgrade
> logging level to avoid misleading.
> 
> Also fix an incorrect debug ID usage for CE.
> 
> 

Applied, thanks!

[1/3] wifi: ath11k: downgrade log level for CE buffer enqueue failure
      commit: 541a201e9f46c6633aa1a08df4ab17cc7c96bf89
[2/3] wifi: ath12k: fix wrong logging ID used for CE
      commit: 43746f13fec67f6f223d64cfe96c095c9b468e70
[3/3] wifi: ath12k: downgrade log level for CE buffer enqueue failure
      commit: 8873edecb38888726ce411b32de91b96cf41bbdb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


