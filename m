Return-Path: <linux-wireless+bounces-23104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AAFABA566
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 23:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF291C01AEC
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 21:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4597328032D;
	Fri, 16 May 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="llwuOhif"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528E22F746
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431423; cv=none; b=SqRtkOW3lISNq17IUnb9m4GBW1hPY0uncQuV7gTrqCTI3cIq1ObB3fmLZFNUKFw6VQIh7vB/vu58nEiyDHy9+V5GO5Li+0wHWTIKAes1Lum5i53SHJXeW3B89icum5y6unImR6vyOsPNLAvGnHn/+4A0t/cWKxQHqtHlAgWYWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431423; c=relaxed/simple;
	bh=e6l5drTBTCZJyJYPneZmWvhTmZIwm0KhpERGZ5jKs+0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NGQv0hC+nf51lMVXUd8TbVYPGjSIC8q4gGiXPJ9bPAYVV9TRPBWtUGaelV3CqUlXEWkTw4q44Q9SRrQmlsnJGPde0RkoXfr1sGATPBHQI+K9RZDwEtGZKjOBk1PzMqFpk289GGPpWn95RbLu6uZ+Tr6Ro58eiORKOWk3Jje/+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=llwuOhif; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBIDHT026131
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 21:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZvexSBQf9AqvTEL0MQV2xVh+Hjlmn9UIZPmY5emHet0=; b=llwuOhifEInXFWey
	kuJmN4LfIjKr9jymAX1ilEN2hSQS2keCYjIK+Iqpfs/ZTa36M1ehmzWagZ6gHlHN
	4a8D3J1jVJk1veZQxLw7gBzSWmcaIVd/7eIxenS5qSugRjL/n4Swr/rjCl1hn6SF
	2CO/DEzcgo27vAs0wpdjIoCBSWEm9ndPJ6GmFXmagOo6sz3aWZgVzGq8RRczNvHC
	R5qpYWZK1bjIKJe8r8R87T82LkpoqEfxsBIRhSQSSP6GHqepfr538+JCDN3ViIzm
	bOCxpdgZSlRbryu6IKmR2ZSUAT0C0ygsc7mI2pNwq+474GZlrM26HE32gR3b3PUj
	aROMiQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyue9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 21:37:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-30e2bd11716so2626077a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 14:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747431419; x=1748036219;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvexSBQf9AqvTEL0MQV2xVh+Hjlmn9UIZPmY5emHet0=;
        b=PPn3QWdbG74Wr+AK0tYnZbYet8D2r+BYDhCZtH+yAqqBGvrBJshQQmTnlrM3qt/K32
         f+T1eoZ5du9Djiy/NgLB8Nhj1RZw9Km+fzFp4WqR6p+iYmPOtPl5tOjNn8moaxpg5rnc
         dgm9lYDc9gMc8S92OGnX05lvlOr4Y5O6KydbbLmzfeOn7nUGQ7hLKfl8Knt/1A+d9i6w
         qyY50NfphsfycaZ6q9DvELT9TDdBIC3aGFDSwy0+g+8EjXHQjGplEv89S4ehTVzQvBuz
         NFG+dSNglEW//eofGASyriZE118HblDK6OJawPCFgh+e+rzt2OYLVvPaMEzOHfQnRnVb
         xb+Q==
X-Gm-Message-State: AOJu0YxPqPXnsH8YnZszAiYKPbM+hmvRBoKnJJ9ytR02GqimzctYGqzs
	k8r5XyxH/3rU3WY/DJZZ5lM36LcNBOiaKjUlnapyNM62po1uJfTnzpVIgBvZ3BBVPdGpsosZYQ7
	r6xkgZe48Czgm4AKdtTbM9fKMSmktKKYel5T+HmVvY3qHNpegBHh0iXvuGyHSz5wioPDqIg==
X-Gm-Gg: ASbGncv5slnGpgaooHZJpcTWoP29kfzFXVP38klFHZgSjlLg2EcSOq3mc/9JXpt9Daw
	D1YYdFJyYfygVCVHpvZsLsnN+USQj6VXpah7BpsnD9oX9//2imJ04woZyJDDqPZH+r598j61qpQ
	jGjRbCztbm8t2XlU8FbMqMhROi9fVaoFdVUZ595WtnBQHXvqrlQq/4+PdXEHY25ye5bFzm4XiWr
	yzyfnzTYUPNzszfKh117CxObKeQW0XelQfjrQaZvx5V39YMu/nydh5GtvdWyS6ypEr+TklSfs/o
	N3cazc3YyQau5imizQlNMuGVta2Mb/+NVnA1ot64mF27G5It
X-Received: by 2002:a17:90b:3b8f:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-30e830ebf2cmr6020184a91.13.1747431419364;
        Fri, 16 May 2025 14:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4iAEj2lGvHPTdxtDA1MTNbRsd2iYilUgI8JO1IutY2WKZ40LXK71qBKF63X0diDwgdPQNFQ==
X-Received: by 2002:a17:90b:3b8f:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-30e830ebf2cmr6020160a91.13.1747431418987;
        Fri, 16 May 2025 14:36:58 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33435b25sm5658010a91.17.2025.05.16.14.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 14:36:58 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <20250408184501.3715887-1-aloka.dixit@oss.qualcomm.com>
References: <20250408184501.3715887-1-aloka.dixit@oss.qualcomm.com>
Subject: Re: (subset) [PATCH wireless-next v5 0/3] wifi: MBSSID support in
 MLO
Message-Id: <174743141835.3870542.2654124463344102892.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 14:36:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: kD7pftTM_4Ua_00g0EOMbSIHb-ZphDX4
X-Proofpoint-ORIG-GUID: kD7pftTM_4Ua_00g0EOMbSIHb-ZphDX4
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=6827affc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=aA1yfRMYb10aeN-VgkwA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDIxMiBTYWx0ZWRfX5eF8y0FEzBh7
 z2xDG3qvlGPLs1ONlFNUepJ/G/Y6q/xik2MYG+xoYL6I6BanwDhtt3A9G1A/rrL5ZhVkyLEWbf2
 uPkK1h5MnF0lNenw+6lzILgDUm629/9PmOnkgZW13battuhYAXEHEEt+715FJVKHUTWsBkUAr/I
 FheN5OcjjBr90utTTmKdcfUaM8sJ+FZiA8a05V3gc52RHRnJ0jurY18F/ufEmlGlq42INTmZAGS
 +ZndOukwE8DhiC3dsjoejQdgtJEIoNsdwkyNIlj6uGpTmtaQTjVXKUddlxa0zndCuZWrYihxnco
 IgZdYaF8who+y5BOCvJr6kWpvicIA6duzJgrpluckellB1Tk5TV+gPenpCWAegedBsNCzYexvhS
 +LkilLxfzUpv1ROAfqBu3xwAjN0RWqWd6KHSFXe1MsPb37QykVdRIW9/n0gIMrVLL7g5RyiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=923 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160212


On Tue, 08 Apr 2025 11:44:58 -0700, Aloka Dixit wrote:
> During non-transmitted (nontx) profile configuration, interface
> index of the transmitted (tx) profile is used to retrieve the
> wireless device (wdev) associated with it. With MLO, this 'wdev'
> may be part of an MLD with more than one link, hence only
> interface index is not sufficient anymore to retrieve the correct
> tx profile. Add a new attribute to configure link id of tx profile.
> 
> [...]

Applied, thanks!

[3/3] wifi: ath12k: pass link_conf for tx_arvif retrieval
      commit: 172e1570e1d31260f11f43e828d98aff020726a8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


