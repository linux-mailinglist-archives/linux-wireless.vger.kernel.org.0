Return-Path: <linux-wireless+bounces-28318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E90EFC0E7B0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 15:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304741890F04
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709161E32D6;
	Mon, 27 Oct 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZoDbPgR4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75EA5695
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575823; cv=none; b=CNNUJUUjuCcSQDNj8/Z2Ala89Tr0EuwiQWlGk3rUUv1Mu3IdHQf1QKZiG37gHPTO7NCEpDxOkDHqQnV6hXASBFsayzWr8QWbyMVcTK5CENflnXiUh1m08TsSgYfPaFG7hf8kh+QJoCKg4wHTh5Wk18kuL0BQlQk60IP615U337c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575823; c=relaxed/simple;
	bh=mKA8M4vfL370JKWki80w/7va4FeuR6o73Z36dRPy9X8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dAqsk3SXdSGfiuXLxJl5PPmfB4Av9q0B5fnMJxhzSWf6EytcSvjwep++TgUqhD5vBCveyzS6HqvV1SOJFy9kkTqsPKCp9d3dosdp02fVkQagHZ6IYPLxCdSb0ggKMMVNDxlxIP/AVQ0XN0rEgI10PSlI5f6/Zwa82qXIiSbAaA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZoDbPgR4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RBJeDc2546590
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 14:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yDJoOWucDsqB5K9PCwP7EzuNd8EKSXZV0OeeK1jEzkI=; b=ZoDbPgR4Lygtjnja
	hFaQ8LvZDGrGEBQiiA9r8L+jC0jovn5UXVd6wSt85MdPD6ZlKPtH7gDjYXeDQNyf
	/buQ8gZ/rdN1v2nLaxcvpmN5O3xGNjk23mAGOiFlu2NRdUr6B103S3zvC16vAo/M
	fkd9f7cT3mKdXHMUTAONMS/C9Qj//di6cwbgA3N4lQ49SM7pZ9z/lLfTydgGrDbj
	w3nf0YLaiUansDL5oOKAOVgHDGbzwPa5bWNuM2iF2uhYHFt+KN60GycfLIiQhHpZ
	VOXxnDjxFHhszSNRESz7JPLzJZofISrca5mq+BkLaWjF3uQ7JpN8wxhIHdRwk178
	cOqosw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2gj9f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 14:37:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so7615927a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 07:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575819; x=1762180619;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDJoOWucDsqB5K9PCwP7EzuNd8EKSXZV0OeeK1jEzkI=;
        b=lVuswfaxIGtoLZ2IdjbqCVK89uEb9iQpCPI3EIdb6A+hgGR1ZDsC3jMnK31YR2whwS
         O7HNB3tua69af6RmeSD50yZoIv5E6bDHXXn7iCpVq9cx9cWE8ldpChxqqVB9a359WNoD
         Yt4/XlkURuSIwf2a/cxhjvW3uxJmjr+M77chNF2PPjwM9N8IGRJ5xynE/clGHPf/HWf9
         +PExf2E74SVCE+EVRUQLZoqr8XV0FYS15495ogMMCedgrLoujRV4VzlQoQaNzf1Dw3/3
         D0u7ZptYYcYzSudsxJCt/VETH8KTAnoPYwq+yBcY5Ap9nFdnJEuIOP6iirBwl4QCB30g
         dJsg==
X-Forwarded-Encrypted: i=1; AJvYcCVjf+JFiF4E9+qGCdrRIAX9c0NCj+LBTA1G0nGAKpfDOTYkLkAPS3FNQUJljjE0FLz2ahBUf3euifIcmq9clg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNfi5iOYPAT9WrELaew3pYIEe4GgbLWvJ6bX8/uomJTz9M+6ZF
	rEPdF5m9CcppAj4SghAto5z7cDCZP+AqrIew+GNVnXIZV1xYX3od9Jkcg4w0gbTmOzbgd0Lg6he
	PFh5gC/Yd2/ViwpPzl65VqqM2U8xvizevC4aMrZvGoxRqUuNA+DFK+7+Es5u4d5Ch40onYqtaFi
	GhJw==
X-Gm-Gg: ASbGnctVtaFF/aM2QRCNlZhKLBf/kCZDbjTICI+3IO4tDMILIQ8j1/XuEUcU8S57fvJ
	nCgGNgqqrlbNt/xK39NMggpgqWhQ4P956AuAWx8rIMqjsVREAeksi8yE16/eb+bjucVyLtUU2E3
	zuE2w/bTxuBJcO7zHGUF/LeG9H1O6obg3o7PrfHnDkR9q0NoRzK6w9VZb2suOMmqL0LxzXsMUnk
	dv+X0XYm6Iw70sOerxelIYwYlN1VPisTHQx95AmNAvApRuEL+FW/E4bnG/j2cRBH5uWMByqPV0X
	6NwaYnBwoJYoPDL+XXNFcbx5no20+Ri+sd/3hn2spl6ezefpjMIx9ehxzzhpdm0AERX5zmknvTn
	mCQFCkWjtNj9AJ2n3jz8Vy6ocFdBRys4kAw8=
X-Received: by 2002:a17:90b:3806:b0:33f:ee05:56e7 with SMTP id 98e67ed59e1d1-34027a03349mr71851a91.16.1761575819449;
        Mon, 27 Oct 2025 07:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLI2Y1Zzj+255lVEV69R1zaLBMf/vkd9sTRc/FrK7Wh+yrPZjW2eHP7+rD3nyG7cJKigIxow==
X-Received: by 2002:a17:90b:3806:b0:33f:ee05:56e7 with SMTP id 98e67ed59e1d1-34027a03349mr71788a91.16.1761575818839;
        Mon, 27 Oct 2025 07:36:58 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712f0c13e0sm7496748a12.34.2025.10.27.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:36:58 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: klaus.kudielka@gmail.com, yannick.martin@okazoo.eu,
        andreas.tobler@onway.ch, mathias.kretschmer@fit.fraunhofer.de,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
In-Reply-To: <20251027-ath10k-revert-polling-first-change-v1-1-89aaf3bcbfa1@oss.qualcomm.com>
References: <20251027-ath10k-revert-polling-first-change-v1-1-89aaf3bcbfa1@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] Revert "wifi: ath10k: avoid unnecessary
 wait for service ready message"
Message-Id: <176157581767.355959.13478681330409784890.b4-ty@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 07:36:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: qeGNe_hkPgFqBy3-lffWKA-ZOaoPvG4q
X-Proofpoint-GUID: qeGNe_hkPgFqBy3-lffWKA-ZOaoPvG4q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEzNiBTYWx0ZWRfX9SXuQKRlFxK8
 EmYNdrT/ZOS3hzXWkqdQya6rwCN+IFLdSppPnTcnTaaE7abWKbn7BpcTeQyX/zAdF2gT4GqE5rr
 NVX1IfkSHIOJb9nrqpMt3Lbm1p+DVPF4dopp3E9RWq857uaP3gVcVGo+ctKsYsaDkz2jSs/7g2S
 FcRfAkHszAJQQbreQKkauhlZPirVJouBsJr1P2mx56VqoENSCdOYgN4yeNFZkE0dci5a4+5lXc5
 Y8ruw49MMhauZ7OtIcS5yhDil3nkyvD9tHV5tATQuetRuIj6Rj+T/3bmvNX+JyBKowxp2h20tlW
 f3uoPS99mBkRAEdoauzRYdVNIORV+woKEmlyOgMkc4k57PYPBA4Npg912pjnLBS10e2szejarbR
 o+xCfEO456bQDPZZEIu+2lhsGfSlaw==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=68ff838c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0dCs_J3m0UDQCHnNMicA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270136


On Mon, 27 Oct 2025 09:49:12 +0800, Baochen Qiang wrote:
> This reverts commit 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7a.
> 
> Although this commit benefits QCA6174, it breaks QCA988x and
> QCA9984 [1][2]. Since it is not likely to root cause/fix this
> issue in a short time, revert it to get those chips back.
> 
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] Revert "wifi: ath10k: avoid unnecessary wait for service ready message"
      commit: 2469bb6a6af944755a7d7daf66be90f3b8decbf9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


