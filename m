Return-Path: <linux-wireless+bounces-19622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 035B9A4A342
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 20:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DEC97AC646
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A8A275604;
	Fri, 28 Feb 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pqkq5q9z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662E0230BE0
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772611; cv=none; b=t5Hq/CGQxL4S5ab4oYbEFx6ijo936MHnExCyX4EVJR5W15bMrD4+RrtGLoFpfzsKfcsu3QtmZJNoIBz9SHyJViyUJ/zuI2R+KROZoUByf1yCmwEcWY2V+mNztv3QfVtHdVE4i+FppzpsYuP6ulF81t61e3EDllwPZgorgb2Me6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772611; c=relaxed/simple;
	bh=nR7GxmEXg7VGItWZ6hJDTqU2JJXxAoyRBDwxDJpinzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ta8GvbbfeSfI6p+g38O63CGtUraS4KF4lHoapv7/kb4GIaWNk+uIX8Ec/5l0PcMhRpkMIpPZcAXQnbv3qcCWoaiGwGwDxEpshwscogu/JZjNm2yI47utYkYDqUnd9eDTaokR2sAfH/0lPUdHMd16lsJyEme8a1vPNOPXCZB7roI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pqkq5q9z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXIBX020355
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J9y/X4woGoV6thmMJzh3rYyjcSrpjUI+L7VLsGt3e5s=; b=Pqkq5q9zcXCCigNv
	BhtAgnQtUgCcDbYd0HidlT7gCkc9cPBe6Xhqypdv1Oyjw3wc5KsSRqoyQz0t/AF2
	WtbiipqzSf5bvVn889boBxc9+e/7+SwGzZHYEv1OpK28hzIicdDvE9PVOIDhTeNJ
	RPm+Um/lXECM6o1GC9AB+XPcZLRBJnNsa7SMiBfIOGAxaP6AIUUPhaE+QjIk2ShO
	0QdqOL20XukxwH5U/cjB7kiigiA+wUBg2Q/u6I8O+E3+zJt0wZrKcURDMwMWkX3V
	Z7lQRGt91DVeGyj5x+tkfQ1UeeS55BEG823FBGH7Vo4FzcwrTNd4CShFX5ECE29v
	HCBWqw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4539uphw59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2234c09240fso46912055ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 11:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740772608; x=1741377408;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9y/X4woGoV6thmMJzh3rYyjcSrpjUI+L7VLsGt3e5s=;
        b=KLLQJpNTtwaOqInC0SbkhQGragtCYnu+/ZmRvAs7jep8V2zhGRwQuS3MDAal772/ZH
         hw8IkwItOqET24XWdY0RdYNp2q4taAriCIeg6a+W/yLU1XQGqsSQ2VJXSUo85TLBMS6C
         Mp3jiHCo33NdfgEjYDb97+24CLWJQHVho7TC4alGEw4GF1G4AEiTc4HB57nES0NbEMQt
         Gg8kxhDvGS4Tuz3mCpj7U8vbZnrYTHZmN6VqkiNm4PNh6m9WuGRaVj7u/d7Y7UWa+oA6
         qaTCpfAQKs4nho2mn9UXUFnwoUn0B/9ZJd8ouOvPnzTMRYh/aUDI3NJhOFguY8XbQU6N
         MrVA==
X-Gm-Message-State: AOJu0YyR0mwrIYTSo7DmySYiqV9wN75nSkpJqeD0/Rgf+DZM5xm+Mb8I
	imnUMomugqkhdTnh9dwtjtF9bCd31ToKWYmwcge4BMEPIy76fJX98oZYW+3Lcvlgid1Y4Twk24N
	/E5d/KBtrIIhVHWVFE3Nh5jGphb/VUhGdkHAybgS7O2rE/fwXgxUWzuUlNoV/Vft+bg==
X-Gm-Gg: ASbGncuOtGQhuyikLdwhdNbGoytF+KUGAe6isuvs2UcvMHVYbbLOVZa2Ll6QjNP4wk0
	tNXTLFrzbQkDQ9o0URAtLZKjkQHQwxRLJw2iJ4CsLV/lsVICvuGHHx8GHgN5NqN0OsEDF+VY4k5
	nmecxVePPA7ASPDeo9/om2DgNXMwiLqu6vzF9TMO25fjfc9LpfIuM74lWJTpXe5RMAn1H7x6xog
	LvdDJBnlbxfMPIkgdjS0UsCZbYw3n2TlODmTWXIaPyKuMnntSYneeToeg/o57OBTf4WiRIrNUpu
	pVYpYvlXz/6UvTaR6WPYam4X9zJBO6VycxZEWqIs2XWE5qfGV1AP
X-Received: by 2002:a17:903:244d:b0:215:9470:7e82 with SMTP id d9443c01a7336-22368f71b7amr67121435ad.4.1740772608512;
        Fri, 28 Feb 2025 11:56:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4j10JGtHmNwKP72SX75j17DpyBXdLgOH+c6J+R8rMSYaNZsEjsrcf7abSJqj4W0twfzCrjg==
X-Received: by 2002:a17:903:244d:b0:215:9470:7e82 with SMTP id d9443c01a7336-22368f71b7amr67121175ad.4.1740772608147;
        Fri, 28 Feb 2025 11:56:48 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505336ecsm37140165ad.244.2025.02.28.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:56:47 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Vinith Kumar R <quic_vinithku@quicinc.com>
In-Reply-To: <20241122173432.2064858-1-quic_tamizhr@quicinc.com>
References: <20241122173432.2064858-1-quic_tamizhr@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Report proper tx completion status to
 mac80211
Message-Id: <174077260737.4132177.15272767288760816552.b4-ty@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 11:56:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: iEsA4h87TXzh3hZRdsTPVel7J8JF1X0a
X-Proofpoint-GUID: iEsA4h87TXzh3hZRdsTPVel7J8JF1X0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280144


On Fri, 22 Nov 2024 23:04:32 +0530, Tamizh Chelvam Raja wrote:
> Currently Tx completion for few exception packets are received from
> firmware and the tx status updated to mac80211. The tx status values of
> HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP and HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL
> are considered as tx failure and reported as tx failure to mac80211.
> But these failure status is due to internal firmware tx drop and these
> packets were not tried to transmit in the air.
> In case of mesh this invalid tx status report might trigger mpath broken
> issue due to increase in mpath fail average.
> So do not report these tx status as tx failure instead free the skb
> by calling ieee80211_free_txskb(), and that will be accounted as dropped
> frame.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Report proper tx completion status to mac80211
      commit: d2d9c9b8de725e1006d3aa3d18678a732f5d3584

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


