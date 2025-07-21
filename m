Return-Path: <linux-wireless+bounces-25773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA99B0CCC5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 23:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DC97B29DA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 21:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857324EF6B;
	Mon, 21 Jul 2025 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="flpSvoJQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC362417D4
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133826; cv=none; b=b1JWSnsBHQRedM2O7MC9EDhcZ4Z5FZlS932BZA4u1Tr/1oKj5bqxoN/oOIb/NKuAroPuxMCNSjgrwWSInqCy197mP1wqwRvQwwNw6MIJ5dTrrX+X3wyFmqAGoSE7N2YRxiIiwVJ2Xj8J0T4GJtNGcrxVj96HXL1seO9CLacf244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133826; c=relaxed/simple;
	bh=vo1sZ07pZw88S4fU0eXJupPKC01FVjQefO9fB5OV448=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m8gN7HyF9B5xO3vAwZJHtKcX6hQEztXkDnvaCtYQH0EdKaz+vjOotF9xL1z0kZrKp1TW8bRRQosNBnhl7R/s+VP/lSvO8y//xGB5EPVBePkfj6dBDgIXBuvUo3uHJRQOysmAhJuw+nUHVqKwdUT7R0e6rsK0pG/X9GACRvGQJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=flpSvoJQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGNBPm016286
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UpWXbETewfbjKdm/uesf4U6sOxQjAz10hl/r+X1ya68=; b=flpSvoJQUeUGunIB
	A6gzfI9CR0ERvd1RfN/fPXGA8hw6hYO1uGiY+JNZyvdW5wlgFnV8Wfk7kBHMlGg8
	Yor4m5XfY6n4KJKFGM+KmWqHfC70wCuZBR9+NZTrBD7GTj8gOUDPVXDNLJ2YKjD8
	nuGIyCpitDDZsoXSxxmglNYQAkeLZ3x5z0oty7xZ4xmfYJWjOXmKRyvSXC2AVPJi
	TDMthvACz2D+mD4OyMDN8EbDxh0Jtwo4MR37ac20DPQEIJpNLukoPCtvATX1W0st
	H14PQj1Y3LJQO2mcaZAP73RTp7L6KC6SQwNyH7Snylbu18j8PSaM1d/2bxpSVKQo
	DWu+sg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048ry9wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748d96b974cso4439407b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 14:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133822; x=1753738622;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpWXbETewfbjKdm/uesf4U6sOxQjAz10hl/r+X1ya68=;
        b=GmczEY7g5b0p5kE7xiVtNIQFFgOQCRsOOHy1QyJTXuXLFL2r9/itnUTq3PXUJNjpZw
         pouocqdOb+XKgh+qb52M9j0YYDpRCDBiJTU+rt90ZgbqrDH47kTuK6eCCYXxv2w4nplT
         BuzAvDFwpaJV8dH8MuBC/S1LhfXWu/wUUtk7lu/GNnHPZsSb2ZiBxNHTdK93whcMFcua
         2v5kuUbk64foi+vbSRfLD9nADxAGr1nHFgE2GKIiI4O0dlFAbFvokkYuwXx6Sy861tae
         tVj65iI0I2i6yGSNA/VtOpbOt8+jcXJaScj9BM3wWwgcErXdLd9hysOT4hh76wyZ5Sqn
         XPlQ==
X-Gm-Message-State: AOJu0YwG1lGsVmlVGfzuTiTBt30xuDdl75nrZT4QQ/lQ09OhsGOQOpE9
	6MXztY/OpT5xKQDE+gxn2/tEJ/vTRJNYknTP3uUb7/76F7bpcwUKqS8CssB4jrX5yr5sphHcvl4
	4X28M42YAqK38GbmJ596HdoYDinbf3rn1bLNvqQ7uuY2aOdy28Nm6hpJhzlwB9KW5V2y//R++iX
	g7tw==
X-Gm-Gg: ASbGncsN2JoLSUJU4/koMPK2uArWmoqAUibxXTdoXAjF88f+NgvSmzlU3aN8DPCKzaz
	/aykgceoNYnsGcMEyK8t7xHHNi7yDHOOUZMvX0wfAnMSfgn0hRASH5jMvOwTyxfv2/NLPsB3kWf
	l4lIkW7eN/jOTJDfZ4ItExuO2RXHQofV68jPnWSG4WxgnQDJL+pu8l9fI9cXKpQxkj6TZAESLhx
	RiXYQOXBvr0I/E3G0R5jCrZM701UuRP4tk6ns7f3BdUE6DgpDSQoQZMG5OsflkZa/Y1h3++quwY
	epJ2AYC3NwlkrNYQWOzlm54UayidgOKvPC/wOYLgfUG+sWhVLZ7Er9DZi6tp+WQMNenwmRJXNej
	b
X-Received: by 2002:a05:6a00:1410:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-756e7acfa48mr32771115b3a.4.1753133822334;
        Mon, 21 Jul 2025 14:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPUG2SMRJgY+/lzdESBOLJ/M6DzqEnQrb4E4X1LflHnB7zeYCzcFGFzGjBSw/owjRxRJ4aew==
X-Received: by 2002:a05:6a00:1410:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-756e7acfa48mr32771086b3a.4.1753133821844;
        Mon, 21 Jul 2025 14:37:01 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68046sm6201934b3a.151.2025.07.21.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:37:01 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250721061749.886732-1-quic_sarishar@quicinc.com>
References: <20250721061749.886732-1-quic_sarishar@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Correct tid cleanup when tid
 setup fails
Message-Id: <175313382123.971667.15852637463136449839.b4-ty@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 14:37:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MSBTYWx0ZWRfXw/I+/9XHx/dB
 65yod8dyOVpdYSxU4zVeWl806Dya5NgWrChELAXsgJSxgZHj+SojVRbBxVWBxjkF0LV7KaMEA7i
 XDO5SMCMLIyNLkJ45YRgwkHBkBosQWFZaHvagMTRKvKrfAoOKpFOGPeMsD4nRssDZ6c9R1iSjKl
 sN0aTn4rj/XGv5QMK0Azae2cwRhLtZPXscfcx6eZa8e3anQWZTCRSqF0k/d/ytxUp7qsQ/zXekt
 42d+5lAqtI9X5Btrl3UBJ7LFMTy2e9mMUk1BICyTAh3DZKzt8wVbS1b3WddCGapwahsizQuo67V
 T29PzLv5rXGPvfiyKHdSxS/JF/iwG+XdqRfRE7Qup0+W7oZO1DfQ63nvhYVQFb4VDVPoAeS0EBl
 xru17IjCaJkeqO509cIRizu4JUPooc9mWz03+o3jfZvhv7ddRus7uHWrNYtFqhKOt1x+m8f8
X-Proofpoint-ORIG-GUID: fffKxCilaRhicoyJ7ub2bWkVjim6xsXY
X-Proofpoint-GUID: fffKxCilaRhicoyJ7ub2bWkVjim6xsXY
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687eb2ff cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=grRxx7Cr2Ne4EJ9EsKUA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=808 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210191


On Mon, 21 Jul 2025 11:47:49 +0530, Sarika Sharma wrote:
> Currently, if any error occurs during ath12k_dp_rx_peer_tid_setup(),
> the tid value is already incremented, even though the corresponding
> TID is not actually allocated. Proceed to
> ath12k_dp_rx_peer_tid_delete() starting from unallocated tid,
> which might leads to freeing unallocated TID and cause potential
> crash or out-of-bounds access.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Correct tid cleanup when tid setup fails
      commit: 4a2bf707270f897ab8077baee8ed5842a5321686

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


