Return-Path: <linux-wireless+bounces-18776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A8FA3100B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0F916494B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE906253B5C;
	Tue, 11 Feb 2025 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bjza727o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5AC25334D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288681; cv=none; b=o7gl7DS6RUV6ZtXXHhzQTZnVToCbT0m2vgaZFtuBSzixQQXHfBb3/+OK6XhFP2g2mzIGA4RgKrvwiWvNQi3kBaCHQSliCgso8DnlZXHpFplnYKKWt4NBx4sHcwV1GJJ8ppudayiZ3T1g5Me6Vf1rstvnTFVkiKsljdiR9H1JPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288681; c=relaxed/simple;
	bh=48nMAEwXEzX/Yo1mUWo+ebiVsDlUSGzSGeLi0pvZIM0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SK1jA9yqnaR1luHAbrufTmic0FzCKrZhrL4XG4dVPWtipvXmERiicnkYGfAAoWezR3HF6vtq+0D5fEiHHdAhruz3r8FE8HtQWMtUY64fQr+20e0KSMqh6SWZ6Dl7YMJOxKy7pfm6LEGbbTFZq/yowbtvsUF12FiY8ciYYQvTJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bjza727o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BBHti5026555
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ITrKwMNT4N06eKH0yPG6F/r0R/zla5c3IopqvKxzWL0=; b=Bjza727oKzfUGNg1
	vbgo/m1KZ6VOOfGgbKCy9nFuDzhKjszrwdnNrSR4YShDA+iLPe+LWKokZQQYkErh
	cDP/RY+3aMl273NZJH2w/dTvXOVQtvkQxzjpf1ZzHmVdLuxIBDzMT8bZ8C5mTS5b
	cfW81IhVYaAMES+6Z7joGbVoRWQv7N+WrMPOBC9wQWAUAjnf7TJztJy8nfmPPtl1
	/+cZeAqDhsLOzpgKdJtwiU0t8ZSsxeG/dvpnUDWs5md6vspN3PQV/wIVoHVHJYHw
	xe9qjN1EFUqyegy1T79/WKzY1MxXhjHLjSIm5F+IeacdUMDBbeuTpvFuBWqMM2IF
	TExnAA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j58s3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fa57c42965so6106825a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288678; x=1739893478;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITrKwMNT4N06eKH0yPG6F/r0R/zla5c3IopqvKxzWL0=;
        b=ptoehFGYqKRWq10mTXlRP75U9UgQPAjL0MoHuJxI/bjgwMfYt5kI4J6bKvjcNa2itq
         /G7rjTd0qhy3gpqf9TxhhkkkkB88IYyE/ukqPmtjJnFZft+XLsSGEfar5Eu7/TUkiBPo
         osrFiccR7sLjo0b71SphS387PQAF91VlOAjtAbddaWqMMzj2Wovqtf/nKhAQ59Yrg7Cu
         kcWOHDLZQz3doo3TDtn2BRiW0jEMqyIkGDs5kIN2AEpKQ6cHhFIpxlS3TP9UMivT2YUO
         lyEzG8NBQykUczeZLPqq0a3uVK1Mslm653Ga6E2dpVtLUhPqCTsBrAki7PUe9GE3/TS9
         dhWQ==
X-Gm-Message-State: AOJu0Yz+PPSpXCc/BAd2M3cXeo9LQRmi2OnmtUzZv+LPxtg4RdGXc6Xy
	o3ByxLC+klSlWo4Q6sHPmWmV4reiltO10bDMi3gs3WOq/u9gdlSPAGb8DKh1xfaw4O8O2l8Ml11
	TxxX7+kwH+ttahhuRlo8HkNjWoJPaEuxBcj4StpjURklaoU9PgwvqgDlAvHEdT8Ibh4N4d76R+Q
	==
X-Gm-Gg: ASbGnctYPawP4NRz6A7M6Pdlaou4QoNl8kF89yYoLB2zG3WiqaRIj1SFNa0/wmWUEFv
	/jhYvfGpWNlWICRtEKBgki+uts3iENuqMovvL3IUSg+mg56siqUL33fLO+KVTihjoh6bvmWO5fu
	I5adjGsxVY4M/gCtRDmKAxJlv1Zwpjg9oXmmyewMYdFNOcv6KwA33ag0ieMuN4QoLCcQfLmINlg
	ebOrMXdkgBPEGWgNEtRXp4HzKJrl7Xobace0678JL0zsnVQZopjOjun5wlT5r5/XC0oj0pWcWRd
	iNQV3WTtQ2Kdu0lIYt5le5XzHWgzGCuWh7qQfQ/djQ==
X-Received: by 2002:a17:90b:3c90:b0:2fa:15ab:4dff with SMTP id 98e67ed59e1d1-2fa243ed7e4mr24018579a91.31.1739288677776;
        Tue, 11 Feb 2025 07:44:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwqRPrVGYpETO8nhswSaTSKsf4vcBIsDHnEOSxVVV0E0ousBwAvMIFvAhjcWHW+/3WS+pURQ==
X-Received: by 2002:a17:90b:3c90:b0:2fa:15ab:4dff with SMTP id 98e67ed59e1d1-2fa243ed7e4mr24018546a91.31.1739288677314;
        Tue, 11 Feb 2025 07:44:37 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36510e34sm98399365ad.28.2025.02.11.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:44:36 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250203212647.2694566-1-quic_bmahalin@quicinc.com>
References: <20250203212647.2694566-1-quic_bmahalin@quicinc.com>
Subject: Re: [PATCH v4 0/2] wifi: ath12k: Add support for MLO Multicast
 Handling
Message-Id: <173928867612.1115150.17986588793384621390.b4-ty@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 07:44:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 3da7qxBkEHpyNA9GZxY-zIEkyMV4ZQtK
X-Proofpoint-GUID: 3da7qxBkEHpyNA9GZxY-zIEkyMV4ZQtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=857 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110104


On Mon, 03 Feb 2025 13:26:45 -0800, Balamurugan Mahalingam wrote:
> Patch 1 updates the HTT TCL metadata version to use the new bit definitions
> 	of the field to pass additional information from Host to Firmware.
> 
> Patch 2 moves the MLO Multicast frame duplication logic to the driver to
> 	have more flexibility to update the HTT TCL metadata with the global
> 	sequence and with a special vdev id to indicate Multicast handling
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
      commit: 5d964966bd3ff48af92d941e1dcb581e6e572642
[2/2] wifi: ath12k: Add support for MLO Multicast handling in driver
      commit: 2f50de7256777003d40931f1732e6c644ec8cb80

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


