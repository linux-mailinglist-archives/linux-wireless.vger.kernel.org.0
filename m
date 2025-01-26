Return-Path: <linux-wireless+bounces-17976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E3A1CD7E
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06D4164F90
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7EA70823;
	Sun, 26 Jan 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="coFiyUTV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F918628F
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917111; cv=none; b=ejt7e1WNReCa1ivF9sLqSWcT8rBvmfXwaTl/BVzx75KIEDHIY1Hi38fsHY5Hlz1JyzMgbofSuouVijgi4zSCXohXewJUx70YJ34IqoqsCc7wlHs5wf+Ex9r5nvbPq+sAHAvUllao8UMtbYViiDs7iXRN3Il89t+Ad+uPU6zPnYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917111; c=relaxed/simple;
	bh=Px/E8iRne6EMyjiSG7UToSY4dcWhDOY5wos2v2r3OKc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C2kS0xBEJVp5kh92UcZE69GWx1CSIPzUshYJ6lGPOEGJGdui9IlPgTEDKcrPy9hXiEk8BNQlyz/umn5cuEhgle7xue6UUu0uIMCE8rmTRPiJiz/J/LEdza0PjVXO4UOY3+BkjlMzPN1XcSBEbAizudWu8WeZsnJ/+hFvKbC4DrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=coFiyUTV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QIRNvm010690
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5UMqbQmE5W9OIJQY3R/U8mQ+VTeXOdh2K3WVI34n92w=; b=coFiyUTVyqa3FwkF
	8fd9nSFhAnBNV7V9phscQlf1MbZpUlivBO0+6BmkttVhWBnRDkmi7nAXCrGR2eM4
	FrG/jiZNmEsJkfQIEbCysRCEQY8++7SPbYVq1ECMbmtEYydxA0RwQvbD6DwAM20t
	WW9I31HXugX6ZdNu4xdeaz3AH2k7WOQNJpd80co7A00NM0oIOL+Y7qsvnjam4SR5
	zX4pep6URYvgB20cTaAckQ3HgWjhG1NepKBypG0LpcLnzbfJuTVdS6FT19OLWCnF
	jpolpIeEh3eg8w2z7m5Y13GDxzr7OdAfHZyL3oIaC0aI9xTyortImAInWRC8mMi4
	Qj+36g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs87a67t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so7503007a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 10:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737917108; x=1738521908;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UMqbQmE5W9OIJQY3R/U8mQ+VTeXOdh2K3WVI34n92w=;
        b=a/kqDX9l0cmMrLl1XTJc6JfbCSRrVd8MiF0cllqPDN7CiwmFyufzVyucrtPlzMLdYF
         LtYHKoaFXtgfKjPRh07D87gxZPDXzeIcRkpbGe4uSR0axSMvbEc3C7bWihLIff8bEkx6
         ZAth4j5Baurzs7gPvsK2D3Yyx1jxreMKhh2lTuGVh+FBMUZfK5dUcnwtyk/JIrqSGAEi
         6o3Hc1mqN+36Sp3p31d6fKvNBC8vhMBHOOqbEMf4ITrucQEOC0ixrrcFpBuvVFw8+IBK
         m6SPY1eu/7fgWC+hsb5ozfjhZOGLYFet/sDfGNgozGq/iJVoCzp5eiB9l8FhG9rNb6tp
         XCEA==
X-Gm-Message-State: AOJu0Yy7FGtD0SwB9bi+3R3NPeeKaWqIKDwC+q2seJRhUAcQRQd0eibB
	Prgk8XtBtw6Jy53Ba9EGn7EXpHW6Ro9cli/5+lGR/vJ3yW8qg9ZI8cGHHVVEqrwnkU03A6/Awca
	LsLvRiH3/o9pdnBl/jTcf0XK96CY0fu10FWXoBf5ADOw/Y46CiQek9lSbrvGS6146LQ==
X-Gm-Gg: ASbGncs3o0N7IVg2XAzlkVsa4F3OCIQwTEoZ5vnxp8D/QLoFoZ1bdsTSsy01y/mAafK
	bH4C4im1zcTxXCSmHtmf6JrzK3zqvn988b/gdALy3+tvn+/QTGpvH+MYn6VZxUp1BUbPL72nUdz
	X9tQvT+b/0X1F+OvHR1Pac0gyrV9iDOHglxu+AE5gYTOlB5+IYFqUDNc4oksNabMZ0eAplmQwXR
	E/UyylFunM/4A4ZSC218nhDvZlmJ8KokHJMC2vwalyAo+mpxXmAyCY5d3xW7q3zqqXRNnQJhWYA
	xufRcWRx4EjyMPaOSp6L0syLzvWwK9YhtWGEggAvRA==
X-Received: by 2002:a17:90b:5208:b0:2ee:863e:9ff6 with SMTP id 98e67ed59e1d1-2f782c99682mr59663897a91.16.1737917106496;
        Sun, 26 Jan 2025 10:45:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2RZtBLfmshFWcJEFgc0Jzs47/NjdG/c5PI+9IaQ3oE+skTajJ2ueNy5p8qV3lG/BLcuBhnw==
X-Received: by 2002:a17:90b:5208:b0:2ee:863e:9ff6 with SMTP id 98e67ed59e1d1-2f782c99682mr59663875a91.16.1737917106066;
        Sun, 26 Jan 2025 10:45:06 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa44cb8sm5414795a91.6.2025.01.26.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 10:45:05 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <quic_ppranees@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
References: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
Subject: Re: [PATCH v2 00/14] wifi: ath12k: Enable monitor ring for
 updating station dump in QCN9274
Message-Id: <173791710550.2935553.1026001360946365349.b4-ty@oss.qualcomm.com>
Date: Sun, 26 Jan 2025 10:45:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: EZHxA4D0-PAekAPRmrv3oGZeN6cyuQJe
X-Proofpoint-ORIG-GUID: EZHxA4D0-PAekAPRmrv3oGZeN6cyuQJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=646
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501260152


On Mon, 23 Dec 2024 11:31:18 +0530, P Praneesh wrote:
> This series enables the monitor related rings for the QCN9274 and
> configures filters to collect statistics such as RSSI, which are
> required for updating the station dump. Also, this series does
> not impact WCN7850.
> 
> Depends-On:
> 	[PATCH 0/3] wifi: ath12k: Refactor monitor Rx handler
> 	https://lore.kernel.org/all/20241219001006.1036495-1-quic_periyasa@quicinc.com/
> 
> [...]

Applied, thanks!

[01/14] wifi: ath12k: Add HTT source ring ID for monitor rings
        commit: dbb73909eea3e89437296d75675e84fcd76a418c
[02/14] wifi: ath12k: Enable filter config for monitor destination ring
        commit: 9b0d8fb3326b32a11981a3ac6fa4ddf97248b8a6
[03/14] wifi: ath12k: Avoid multiple times configuring monitor filter
        commit: 6e8c9ba7f0308ba2a88270cec6ce7e8ef621df1f
[04/14] wifi: ath12k: Avoid code duplication in monitor ring processing
        commit: 39f1d751d2ae7050ad9b88560fc2042515dc88d5
[05/14] wifi: ath12k: Restructure the code for monitor ring processing
        commit: cf544270c7392af1dc3a3bf405b902f3b9d3f925
[06/14] wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process
        commit: 63fdc4509bcf483e79548de6bc08bf3c8e504bb3
[07/14] wifi: ath12k: Fix end offset bit definition in monitor ring descriptor
        commit: 6788a666000d600bd8f2e9f991cad9cc805e7f01
[08/14] wifi: ath12k: Add drop descriptor handling for monitor ring
        commit: 51ad34a47e9f261d03894b49a734174c170b326f
[09/14] wifi: ath12k: Handle end reason for the monitor destination ring
        commit: 8520ba9bb8f43ce9d540d9be6a5711ceeb1651cf
[10/14] wifi: ath12k: Optimize NAPI budget by adjusting PPDU processing
        commit: 394a3fa7c538060ee3cb134d52b4e9ec1f680cac
[11/14] wifi: ath12k: Handle PPDU spread across multiple buffers
        commit: 67434640e52256efd14260cb8edbea41c1faef0b
[12/14] wifi: ath12k: Avoid memory leak while enabling statistics
        commit: ecfc131389923405be8e7a6f4408fd9321e4d19b
[13/14] wifi: ath12k: Handle monitor drop TLVs scenario
        commit: 3bcc4e830e05ed604bbba89c5415926df4ccabae
[14/14] wifi: ath12k: Enable monitor ring mask for QCN9274
        commit: 58b976e4f4b4d727eea27c0e40830853ef7ecf0e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


