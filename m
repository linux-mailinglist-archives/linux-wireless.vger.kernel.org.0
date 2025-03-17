Return-Path: <linux-wireless+bounces-20458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB1A65B8C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 18:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4CB7A68EF
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FA11B042E;
	Mon, 17 Mar 2025 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ldbe27MD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5281B3952
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233960; cv=none; b=VcpqpR+dHjTJJofhwDOSpaG0wXTSC9oaTct7X0pHwa6Pq3pTa9M/Z/fT5FyOOB0R8lVY0lUQaWvXTxq9vyVWzCn0Eh18I+Yp+qKCos/U+2hq977CQA1cAIigXa90moXUAcKVQpDsZ/Ab6SHJPWf5jzYqPyYLfFSd43SWeWIxOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233960; c=relaxed/simple;
	bh=wZK7V6aw7rGEy8dRyBRZWOl58cttJwxeabR7EGv/HTE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cxtwH0gz5oihGmx3/06tUTgVeuq3Tp39Y1chF7oyStXKao2x6K6yQixp3TChduTMzrMwSLSJTzcfM4CXdGfsmCfOLOYbDNtXLdfLBAsZWVrDSUSohvQgrS2TcA2TTpTEz6gIusUg5EH5tSRuflJ9/jA0SBrGjulnkhFFbhWxUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ldbe27MD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HA4FnT016310
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 17:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ThkuvgvIoIQWvJCgbTnfJTeOWF1F93DD53CLoYLqJs=; b=Ldbe27MD7shiZJ6z
	trap0DMc0bD/dnbWlPP6sai1pI8JA5eDWuBBXQZUl0/K0xqDObaKp9edB9vrnXzD
	b1j7WWNamgQITMBzo1ZAtRWVOv7EfNJ6d/xkWrEoWP4d3kfo/B3IeJ9AHHcUF5Zc
	TW5m2jOKbrMJZlPhSv5obZ1GRlArcB205M0QQLm7kcJ46uH/2MqoVMpUtZSeN1Cn
	fzZiqSE/XnzAKhqCCh9MvNejKnoGrzbZf80AFh9M2f4EoagDS+ViEHnFuHP3sGWL
	YS/qpP/8GouoUd89Kdm9mL6s7nxR+gKXWFwF9RarPd+FhZuZSBuyzXM8Pvgs9CwP
	Pc7NQg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1rdnm0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 17:52:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2262051205aso9387315ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 10:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233944; x=1742838744;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ThkuvgvIoIQWvJCgbTnfJTeOWF1F93DD53CLoYLqJs=;
        b=cYCNfjlyEFUG1sr2ulmL8vmsMEkqCBrroBc2MSLb4kYpIn8SlfGTGVBdwA1472sYxZ
         njx1iXgYEYu54Cx4t+DsGiL3OLoffidoI2oPa6KAsYJJE466EIVBvCNwBg0bIJKv2FY0
         RglmPnyH7geguc+QD1hHXSXt28QezlDPmOJMVfoFZub7X8Pj1qOXF/g848eXHKfY1R5j
         DbB2vLGNIJEBD6UPyn3qGCq9IZOOAZ2IJuhXos2ppG5Xlc9dfkIiAytgLmifNywQZSAx
         RmnyNwEthvMDResKtUIMdkHlu49gjbCDRIXFlRWNj+0iJ2TMZEsFsa1E9QvAUO8Vj4GQ
         Ibqg==
X-Gm-Message-State: AOJu0YxU/+3lHV7Y2J/mbeDLzIDJugfbOfBDyVul7uTaZBZa2UGcq7pJ
	zlZLepEtg+GC6yTpM99A7g/8fvHThevzkSkXoqEt9MbKtL1mtFQwzKN66VFn/MWl+Rf+d2cs0M6
	AjknhNdViIESohRMuBB+jXlwGM24cszZJBZFtkxq0IsNpFTJrUNOO7NZKdDoiUkmrUG2KzeQVwg
	==
X-Gm-Gg: ASbGncukxRpoo5/NclZyWTEEAHH1Ai1VL8v3MRCNoH2l1EFGm16r7kk7NVCssTqoTs6
	X9XeQqO7sd3x1GO6ntDN7VgCWgDnHwXAYzOm7CCibiFqBkwiZWxbI08MT34VAatrKui+DluE/j1
	dKDj0opVGIPYV4CWxm89vOukQcMAUcd3SbW+MIvD822LQNf8Gt5hrfN2J8obsGEKHGsv4vZ2wH/
	yvPy1NBcg5BfQN5fzy5nVuaIqfWolV4jf2drx2C2lQG06kM+akgfWoKNyTyicK6hYl+bjsxiQZW
	nrIvMqYDyV2/wyWjxgh6o76Trn98HBpIvWabAJdW6q7G3pGNwETG
X-Received: by 2002:a17:902:a60e:b0:223:35cb:e421 with SMTP id d9443c01a7336-2262c6118demr4495325ad.49.1742233943924;
        Mon, 17 Mar 2025 10:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgl+llvwHh/zRGTkW5MA2eop0V9Bnfag9v+roXQRz3G70mxDf47IcOnVb7guN27vvjEWny+Q==
X-Received: by 2002:a17:902:a60e:b0:223:35cb:e421 with SMTP id d9443c01a7336-2262c6118demr4495115ad.49.1742233943573;
        Mon, 17 Mar 2025 10:52:23 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5ce5sm78291485ad.252.2025.03.17.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:52:23 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250306102215.1300522-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250306102215.1300522-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v3 0/2] wifi: ath12k: add support for
 get_txpower mac ops
Message-Id: <174223394296.578193.9070355387885587986.b4-ty@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 10:52:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=Fe83xI+6 c=1 sm=1 tr=0 ts=67d86166 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=SU2plV4fdfOFeIHhBLYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: sNdgboCAVqtins0tAXVf5BSs_RE92Bw9
X-Proofpoint-GUID: sNdgboCAVqtins0tAXVf5BSs_RE92Bw9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170129


On Thu, 06 Mar 2025 15:52:13 +0530, Rameshkumar Sundaram wrote:
> Currently, driver does not support get_txpower mac ops because of which
> cfg80211 returns vif->bss_conf.txpower to user space. bss_conf.txpower
> gets its value from ieee80211_channel->max_reg_power. However, the final
> txpower is dependent on few other parameters apart from max regulatory
> supported power. It is the firmware which knows about all these parameters
> and considers the minimum for each packet transmission.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: move firmware stats out of debugfs
      commit: b8a0d83fe4c7a8d5c060eab91d9cc16bf0dcaa46
[2/2] wifi: ath12k: add get_txpower mac ops
      commit: e92c658b056b31fbc923a59bd72d51ca9f2ba921

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


