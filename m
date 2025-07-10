Return-Path: <linux-wireless+bounces-25181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E133B0055E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C6516B57E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2AC27056F;
	Thu, 10 Jul 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BASj/fjA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BAE17B421
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158177; cv=none; b=PPXOk2ErQIMjsv2cYPhqFouCZda45t0llnpoqw4U6KHtRTFGoR9ouO7thnRALs/Gzh53jLqUHf8M8uujCtt8axfIhceZKNqvNfX/Wk4WGMufdVKxo6DPWLTjS/EBkGblpSAVCS5dUMubZldsWnI6pVJI0eA9OtnsNk5nVUA1MZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158177; c=relaxed/simple;
	bh=Ytx25GY/nU2VdOgti3tVVr3OQnWg7YcdFoOvC8ch0v0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pcTcR+KErcu9pc7qK2HTsFFQYfZ7SRKWhi/WdcTm/X9sy9thwWu7NZg0tB+N/t3P7E9LBvQUYH8njfyU3Q/j/4Uem6CMmO4KBbulNVITNMzSHsex2dKasGlag13YYZBDkT8iUBoNLT0bB06aX2fYXyNhHDuvFcALp69owMfA0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BASj/fjA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9MJXA002667
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dg7JRVt95il8s/jz7TuZQeqrrUbBN3RXqv3GEYrwXmg=; b=BASj/fjA2/M3JW1H
	Jjzwo7BNCShSOzIgYCtHAkZcjMTlcqsowPg7g4GiX+ES/LbqfBtw/eHMYr6PH7E+
	SnCxpFMNGak4XtwuQegrknF2rmDVrCVX/NSa53kTm1wMntgsbrHwAHV/S6EBh39F
	GY2ZV2+cPFsjBhBDnPdg3fYc9kh5GV+Pca77/sgmOmtrmvIVXsfiWOMtdfrXyyrq
	uljgQgO5HKl+aHGddRgCTtopYdi1Kb5yfOfITvts9Cg0Pcvmz+Kg8NxhhHCu18eo
	W5dH0tF81N5Bb26kpH9ATYQBos9pdOWfyuqtKpwI3gzafjGsVtxT1TGhd8cGHicB
	+jZZFQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bgjbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2349498f00eso19018015ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 07:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158173; x=1752762973;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg7JRVt95il8s/jz7TuZQeqrrUbBN3RXqv3GEYrwXmg=;
        b=un24V9MuGv8eelVid7wR0FJMBZyO+uMJPBR9eHj/GGdcehLKGqZ11yMeedNFHq7KIs
         SpNuNVLzOev5JKaNxujVkFDvObHQbx7rx6GBNqtxISL0QP4+cJPcGgIjDi4LuyrnNu9d
         3YwsYDlBUXvQ3Ar0tp/d8KSv6kWUVK3V9MPi4nD/Rv8n8LS032upqHgTWErUSxaSFd8c
         PeJvFXpXYaZL/SqtAAmL++cXRGyWZJGuLp4Iu6IUXfW67suohvoTTs3w7trIveKNkldL
         ax5gwM3+mSMrduyvEfPibPr3pKytgIc00D14qQMVnJCqBlRuRz+96slZO5lZ9AIS2kTp
         588w==
X-Gm-Message-State: AOJu0YwBulgtRIAZsHNPzrdpc+W9lVcUxDnQB5OTMvRoY/wi/CvenDca
	NNeHrfW98H4bIkLiTcQ6KIM2G9Pf7UtJxBhmvV1ecp/K7p0sWipg0d7XY9oTL2dX+oDyxz0czhy
	Lk/Ai/iVeK0fA6IhmLAJ+N2ffHqODKA9gEaFv0g0dhByOYiz8w7QWZl3Z+o/nL++SfQdzGw==
X-Gm-Gg: ASbGncs31ecQ8G66O0uPYOewii+m3/wYZAxbHKuXakTgAXVqgUfpdFG9RoekBuizwyj
	ACaDxGs2rZzMbljuKRR+i7gLh5XM/wCwi55L1B/lykd1L10YYASR+LIxwZ8rR8qrXPE+NzlrzqP
	56wRZW6om0qeQ9NulZQfkRHIyEjnxscYnaahJM+iTD+IbKguStDGNOIVQK7wiDFx4XpVAdvtcRU
	qoenK236SXz54FkDC6XP7O+76Iu8C2KgX2QIGw+Dxj+rjrGHG4i/OYh3tfDE6V0nRQI2kWw4GRb
	CnrnBGIIj4IUaD5unwTBn9AMAep72kfQLIUArGa845C1GLuEQfygIeXvXUY=
X-Received: by 2002:a17:903:b50:b0:234:adce:3eb8 with SMTP id d9443c01a7336-23de2f7dcb5mr61822945ad.12.1752158173432;
        Thu, 10 Jul 2025 07:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7OiZudC6nBSVY2ndwLIYd90vpOrAhe8RwjSa8EPgDYPyCW0TtT34tHP6hcM40vgh3hSHMbw==
X-Received: by 2002:a17:903:b50:b0:234:adce:3eb8 with SMTP id d9443c01a7336-23de2f7dcb5mr61822465ad.12.1752158173010;
        Thu, 10 Jul 2025 07:36:13 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359a86sm23758055ad.210.2025.07.10.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:36:12 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Lingbo Kong <quic_lingbok@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250702-debugfs_htt_packed-v1-1-07bd18b31e79@oss.qualcomm.com>
References: <20250702-debugfs_htt_packed-v1-1-07bd18b31e79@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: pack HTT pdev rate stats
 structs
Message-Id: <175215817183.507672.13750771482128165327.b4-ty@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 07:36:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEyNCBTYWx0ZWRfX2XDzEA9oDLHe
 LEbiH6TgFV52lr7HZ5Pk1GgqAQG4vfJhH9oFTRiWAjCVSS4Uczy5sL9+E+BeS9giiOQk2MjNQuk
 jhP9LkhK8V6J53K+gtmjnl+1CajbGvdZxi+Sp5kWQNB/k5jb0yRSUJbhzgZje1YeOM4/j2tXnt8
 enI9SQIwgl1OmjZ7xo1/WjV+m2dULB8bRXFUvHrKa7/KeBBs6KhBqVUHZ9NmJagS9DcqZrIx1iq
 LPY0faPerUnHGJA38oOUlIpJJWfkFgJ3WT/u7RRQG1EugbesGnnO1+fTvw60hrund7pBrgU4Eho
 L6IlERVecqb+jggd60J94UqwXwDQdXVMQz0mCMaVdMnlI3BxMedS8lVpbrD+FzabGl0s3/Wx9QG
 Umv99QD3i0wxgLpdaRqFuxR32vXdlrNMZ1rpO24v8KuiRP0eQJvhOddRRoEoHdkCJfQ+SFeI
X-Proofpoint-ORIG-GUID: eJjP4FKrM9dKIenlpWwCA0MXLVDGRjmL
X-Proofpoint-GUID: eJjP4FKrM9dKIenlpWwCA0MXLVDGRjmL
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686fcfde cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=UczwlVCNLZ8JH68BmIEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=782 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100124


On Wed, 02 Jul 2025 14:29:12 -0700, Jeff Johnson wrote:
> In order to ensure the HTT DebugFS structs shared with firmware have
> matching alignment, the structs should be packed. Most of the structs
> are correctly packed, however the following are not:
> 
> ath12k_htt_tx_pdev_rate_stats_tlv
> ath12k_htt_rx_pdev_rate_stats_tlv
> ath12k_htt_rx_pdev_rate_ext_stats_tlv
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: pack HTT pdev rate stats structs
      commit: fee9b1f6691120182136edacf590f52d62d9de7f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


