Return-Path: <linux-wireless+bounces-17975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6CA1CD7D
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 19:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59091166AFE
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 18:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4EA185B72;
	Sun, 26 Jan 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aoRUCKTf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB680181B8F
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917109; cv=none; b=pM9j0ADJ+z7TZLoluegswSsIJjCLyn/wTiLuW5xtCXxJXB8BZIUTWvWHDqMsLDkCB+EXHIJgDZgNkcoajxpLeigxtN2FZmuVy11PDTzjilkmx2K5dPSrIIiRVs5TKYraGsfIxmXWXPYkhV2jybfQiniLWreFTCk0+xJIzAnysT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917109; c=relaxed/simple;
	bh=kS/dHvvWaugZq/H5ZkYRarbCh0Ad2w2cXRNhEqz7tdk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N0mXN/ODjMSlgF2NZdn4w7Ci9ztiNOTyKlbiVFchcv5I7ISFSk2CaEAdCJfQofACVUCOmBwXpllmB/oDVsr/A0PZ8WQPYfCY4HegNC4cMdXF2oa9bKtLYme9w9atAKz2dZd1YrAxZCzJO6aorvZln1+XPEsgMzMkZALApBJ6ClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aoRUCKTf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QCCvWI029235
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6YEi90dBSutM5+pyI0Txt01cUBPFMzvcO4GSGRYl8W4=; b=aoRUCKTfR5GRKegn
	9UIRD1VCRlR0gaWnAd2ODPRfeaGbn+RNXfk+XUAHKOWCafaWlf85V9t87p8Sa19B
	MQsTpCeqy8hKZ45FaBoAKrbU29aV6cOSB89I/k/bxAbAFFRQwRYRWCFZYuyO+X9p
	ioRcNbSbM83eqZMR/ArPUs/2B6VxCF4qSWMH4fBoT5Xx/+KkySF/GKwcswxwMK91
	fjN/7bbSU0nxDCJDsWlj0a1XvVRAfYwY9Aoi9gbm4wMfCZbju4fOdk45/yjO5mAv
	y9ThvsJbewvqQA5yx5QWRDjv/E9T2PkdFNq5Kw1Anjui1FFfBg+7tneLv38cDCwG
	lrXtIQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs87a67p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so7360242a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 10:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737917106; x=1738521906;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YEi90dBSutM5+pyI0Txt01cUBPFMzvcO4GSGRYl8W4=;
        b=GDcpczy99C6QYElKKTmyHtijmDN+ITQHi7PJXOgG7poP9fmEeZ2oe75LJ7dBtv/a1g
         Ag0ssOVFsbjrg7J7lZj8Qvs9yheTmP/ODmcIh/mutUbPyky0nFNeBta2iAvGxMUbuiZc
         QB88q6opUbY5UnaK9prMHPgwtn6lUpA4PPnB21ADR6S23tLOyIbGBdXlEPZObzeDu4qC
         MYBc/OyFCco1enxeHfRJ9RMp3gGoFmnsrkC3vMWaR6FSBo+AmWCWWpWbS1Z/4/po/zkw
         07M7dmgVg4HqOywNvYusyKjRY1G2xchqLxZMxk/7dgPyZZzgFxd0TnUw+oqv7NZtnw+/
         SK+w==
X-Gm-Message-State: AOJu0Yzk3apZPcxywjlUG37tI4nrS1z8r/ktRKHNCGUX5+UfYkqxXdOM
	t5zFCKkEoDkDy+IXiTpP3v5v5U75Gz1LgFq+nC+RohkaN8/r01Cx1TAU4i9aIXN3Em9CWEZxEHP
	YXZ2+OZqZglzWxee3XfaFIO4v/O/cRqfZO1+1w400OEGo2p2wlsRxqZsLykVrEK8Puuoyxa/zSA
	==
X-Gm-Gg: ASbGncsVk1DkKhOxs0Uyzxmx4mPeWFgrElme6/E8qAih4JRRDqSZvsyOKl+d2gpW5Zv
	6FGSqnV+l0PL7xPusf0C+E1JbvZkNOAM9d/4DSiIin5/tvkicL6DMWlcgXKoDZQku3yKQbKbXKo
	XWgkHMRW1uQa+5gCesmGMRJlkKsiN3EPk6mji/IOTY/a/WHGWOiZh3iKRZxIdSDF8TU/3hoJ2j3
	67E2TbpV6lYg5DNRuzxsShRgpcxILi6fcCB/RJq2s1Me9A0XFwxGRNuKPu7SEH6izDL8N9Zh4Gt
	HRi6K+ibAj9J8fQRnDNpX1h0VxSy3W4Xy6xvfWA8kQ==
X-Received: by 2002:a17:90a:e18f:b0:2ee:acb4:fecd with SMTP id 98e67ed59e1d1-2f782c70244mr55952260a91.9.1737917105719;
        Sun, 26 Jan 2025 10:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2dz+GvJPSZEp1N+EK0A5D27qalo50XPx0nZr0r4hAXXnvmC9ERXJ9RbzsFNSgGdLvsZ5w+Q==
X-Received: by 2002:a17:90a:e18f:b0:2ee:acb4:fecd with SMTP id 98e67ed59e1d1-2f782c70244mr55952239a91.9.1737917105350;
        Sun, 26 Jan 2025 10:45:05 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa44cb8sm5414795a91.6.2025.01.26.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 10:45:05 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250102043048.2596791-1-quic_ramess@quicinc.com>
References: <20250102043048.2596791-1-quic_ramess@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Fix pdev lookup in WBM error processing
Message-Id: <173791710479.2935553.14678906520779985511.b4-ty@oss.qualcomm.com>
Date: Sun, 26 Jan 2025 10:45:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: Bsg2sQPg6XkXKKb6aJr5lD8XALl6TVkI
X-Proofpoint-ORIG-GUID: Bsg2sQPg6XkXKKb6aJr5lD8XALl6TVkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=874
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501260152


On Thu, 02 Jan 2025 10:00:48 +0530, Rameshkumar Sundaram wrote:
> Currently in ath12k_dp_rx_process_wbm_err(), when processing packets
> received on the WBM error ring, pdev validation is done based upon the
> hw_link_id. But hw_link_id corresponds to link id of a given partner pdev
> in a MLO hardware group, and is not the correct index to use to lookup a
> pdev in an SoC(ab). As a result, pdev validation fails, and the reaped
> packets are dropped instead of being processed.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix pdev lookup in WBM error processing
      commit: 4e635b81db9d69bbb836afae8cb402978ff966a4

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


