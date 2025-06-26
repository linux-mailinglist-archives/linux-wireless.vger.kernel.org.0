Return-Path: <linux-wireless+bounces-24589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7345AEAA63
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4895682F6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C9F25A2BB;
	Thu, 26 Jun 2025 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDs/csn3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59F2580C7
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979728; cv=none; b=Mg2n3cIyWtimtWceYwa0xJ0FPf3XvN0RKHmuNRXJXqqqO2sj8hVv6UBtdlxe1vsYVb20tsLxm5fwkrRy1Er+D9tddLdL5gs44OHYNg3iBBbcCNczsfD1IvuxTdboNd2K7AUVtkNo7c9BV4oa0Y1TLbrp6OxIikHAnObKTRYAgvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979728; c=relaxed/simple;
	bh=k5K0OHaAReQDoeWKEKaljz1uxPTCHcqHA7iRro70KgE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VMGU7C3sVfpnQ/+0EGbFX+LzJ7ZLdz7EX1bFW9RBFKVimzwqBH9bSikpd1C6B7UiAJrwmpnAEH0qbo+i8Pz/nd0ZBfBdn2c41kI246uFhs2V3MNSHl+lnKzopE3XMM6KAAW/IdiPO7y73suBiTL6XoWIi/wqL0p2+E03z0n+Uhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lDs/csn3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QLGtio013292
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7CGRflJ6B20MP/aDBbwjQX1TOBeRFLX+9ncIFL8m8u8=; b=lDs/csn37OXesSg1
	qhfHsdcd5nbgCJF68KCe+38WJTCDJGc4Eh5+NoRNxHK6myX4NyjPIHwx1eCwr7a6
	UKo4xFk8XLd/jeu8jIv1Rn9xaaIQ/rTUZ4CdVapfQAsUdxnfVc2oNJ8iq5RkW6sK
	fX6YZUhGDd9KCTgt1NcscjTwsFaPdoWLhGxTg5D8rYMxi2zII8nQIpi7YWq2MO9d
	d/2p/YaNMnKfGtaeVvoQyeO6C/Nn1MSl9hT5KY6kglrnlNVkeN/uytEBkSDZtpt7
	85NEsyirFOGP5VENZyugZl/7A5QTbRTqcpdudm0B8gg/kIjGGw1x14awKil2Wd4p
	U5TCXw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgmt35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235f6b829cfso11680055ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979714; x=1751584514;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CGRflJ6B20MP/aDBbwjQX1TOBeRFLX+9ncIFL8m8u8=;
        b=njLWpa6xzmQibv566yL3qd9/HKDQMJYB4oAwxpNtNCO4lMtFCslvMxK+yyMe+LFgaT
         hNzA7Z7wd2fLXIRH3OTqRSMThgIvek7Dg2MhPw8Uva2tWBynmMY2Z2RumKfcNGB7N9JM
         dn+IaOI5Fp4eA1QWofjXl2l4MGq1Qe9U6MZKJp59FI/pHYLTBdpq6Lw6rrqOe0bbPXDf
         lTZHPOu7fR/hsRvdIDJeqdneD6VFVnDwxo1x7UqWX2zq9mYEeWLaYVPj9qeF0RP4c4BY
         sqkY8quYOyExzLy5dR3f7o4sihCV9tB+Wa0E+op0hzJM2zKlh+7EiiUJoD32wqhfb8hH
         hi9A==
X-Forwarded-Encrypted: i=1; AJvYcCVIGOxeFEuayVWQCyU03ORO8P4/6rk52OS+/pb23gtTnzF8B4s5e2CTWD8nNts1jbyDjKA9I+Dp69FFuVcu0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSqNLl66Ofetf6afMhQr6z6gp5cHeXuOl9VyF6gTDIAPL39S5Z
	xKHS6ig0B+jjPERvBqGBQDFSJs0LGweHUoF3A0SY0uRbddP8jaWsy+slQIb1XHCIseJS5FpApQM
	+ebGrMcD0M0o0vOpZLT+q0taaIVw1eVDrUOjpSLlXboW0fUdwSvAtixzgCQKWYRB/17xiGg==
X-Gm-Gg: ASbGnctHtLF8YEe6UQsVLU0IDzr1UYlvfM6BO7JsiwfLe2GX3W1brb9MHQrjSu5ok/4
	bSXNfYlquYjgi+KUbOyERhiBF1qz4zpZVzMen/gxsb1VfsrpGRdWTEFmy9YCkLtRIWDaOlEsLUp
	WpxBu7aCYmPhhkE3h2aTMUMZ0LKNKDPSletzsdgXkL+syB2B782GA/IPx42E6uMAtub2nR6f1Fk
	IhBfMD6vfifWJ/UNMohFxi6KZOLKyCWXIkcTvAXKP4vQ3nNU5sHoQpWRw3LJuZG1qmZ2rF/90xv
	pIEX7LQ+LjWg5Zw9NV6jGmCdEXnqTwXMiAiXgauRsNVTjIoMU4i2c32Yl4M=
X-Received: by 2002:a17:902:e807:b0:234:bca7:2926 with SMTP id d9443c01a7336-23ac4605990mr15454205ad.27.1750979714463;
        Thu, 26 Jun 2025 16:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHatQQA1mUCt08p8uWEuxkLDupGYZtc8mgpT1E0dO05P3u6qH6lqBdVuZv79lzu/hrCr1rIEA==
X-Received: by 2002:a17:902:e807:b0:234:bca7:2926 with SMTP id d9443c01a7336-23ac4605990mr15453875ad.27.1750979714115;
        Thu, 26 Jun 2025 16:15:14 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:13 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250619082010.1834109-1-colin.i.king@gmail.com>
References: <20250619082010.1834109-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] wifi: ath11k: Make read-only const array svc_id
 static const
Message-Id: <175097971319.153431.8225006080279921985.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: PD53cA2VkbmKR0Wx_AiX6vAnnmqyEeQX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMCBTYWx0ZWRfXzUc9d4Jlfb4y
 0ZMF0E6Yhh2GSmRLugvdsoW1CnUx5d5TFQK8qtHyF0TX8yXWtgPQo9GuSs5AKyrJ+RZ2cy5EIQc
 gQZzd+LJv7jyXIIB9OyFOWb39PGCvecGdM5GuvHm55PG0qAXH11nuQLHeKVr32BRxB42NDdI/d+
 iMR9XmcfKbCRR5Pj9QjnhfvlG9VQ8PCcCGRNyyskrjs4DSH6XFn0kDrd/p5aI9nsjZcV1g23+C9
 5YTO9obUnVdlSxsmIhco96zoHsYljbEZmdcU8WD1AG4XEpAO+yVwAhDVdTGnvCzkhLI+l8xZ1K5
 VaSS/paoPr6MyzoVbQQoYEy3Tr2wJGVCl8bATxY6TepFGmj5N6Z1AvvkBNJr4fgpXQw5Jng4Iid
 D41nODS6GdqYA/X2tj23G2Rw7gL3mSY9SRcU1bDK4q5drQ0UdbTVa/FwtAJObY0P7F3Q1KZ5
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685dd48e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=TBCri2Webv1PiB2955kA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: PD53cA2VkbmKR0Wx_AiX6vAnnmqyEeQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=875 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260200


On Thu, 19 Jun 2025 09:20:10 +0100, Colin Ian King wrote:
> Don't populate the read-only array svc_id on the stack at run time,
> instead make it static const.
> 
> 

Applied, thanks!

[1/1] wifi: ath11k: Make read-only const array svc_id static const
      commit: d8f07889e920493845fd628407ff0debbe96fa09

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


