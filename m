Return-Path: <linux-wireless+bounces-18327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63801A2671E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 23:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E351C3A3F35
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72721147F;
	Mon,  3 Feb 2025 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LFH6wbR3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6A210F5A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622954; cv=none; b=MgP0kbVtAV1pjGpqDvz9LnHSiw+mFs4BBJ5VL5DyReSMGKNDJC0KBbrRSaW72LDC7LFZA5cR42tiYwPaQPAcBFN29aKhlLkIBvwLtmiYtHNk5AdtmOu7mvcRh+WRybVfxDBdlKeZo9J+Lu+Kl6MElFPn1kKb/uQ9GUxuqJRMTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622954; c=relaxed/simple;
	bh=l5srBsgiU33GZd/b1KzelfuLg2xWkCS4kDrOq7Qb7wY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T6qcG/XdvIg5uA7tMqZPBYXK+sP+q0xIz3U+Zlz92PjBTf0Yp3dT9ca3rZoy4wo4cPOcjRsQHGc5kVFpzp1xq04ClBD/Qh3DjoIFhhm3/yNGDyzaL1nYO27+Mo/9KsNdQp6kMwMUz2laQKIgJmkfs88+9H4/tgzBfrelIeXY2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LFH6wbR3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JlP8l028491
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 22:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0A6wgIKxOZI1z3zdXOomFIBddaIAgTmHOiA1HPyAkCI=; b=LFH6wbR3+rOSa9wm
	+FipN1RduRYXLHp5PChCpSAqQl4leKKugFca0P8c1uCXJgYc1tcUKbdQel1lUW2r
	yuIuwNYr8GRyBnVsILaU38MvJNPY5TthMQpyJHdODmLL5l/r23g9ltZJLHrXw7vT
	QH0OvYd3wNMozBYuORMG5M3WR671IyadFZB/rKkfqwsgvoNEXbR1tOE5DcVeksHs
	HDNx52KO28eBmb7rowG0ta3rm45Nlm3mozqnqovsKiWs4ZE0RjixehMXf0j4nQqi
	uggLglTg/NeHHgRlOGo7MYEcaYnk5LXRLg3qq1S/XmT9EeHKxbxGeKlpuqlICrCn
	AIsMAA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k492gap9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 22:49:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21648c8601cso92082175ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 14:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622952; x=1739227752;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0A6wgIKxOZI1z3zdXOomFIBddaIAgTmHOiA1HPyAkCI=;
        b=Qn7CduG4kEcRNKUVoB8a9QEH9HnX58fagTVYTlwGuaoW1TMxeWFrz5QBk0s3PeGpKW
         nVbiv9yyB0QiTFmQTJIPOOkUY9N5YcrHAhEK/V5kaDjo0QVcOj/ITSnhhiJbCYiJRDJm
         vOuVwDih2cuDaERcTpqC5Yeh6Zu7tHoTOg7KkRi1UrgKYYwKYs2kWQMGq77XauWGXrtd
         21kxizIAkd2ABPgh2SAvRQFE8KQB0lbvlLPD4ZRtIwJW0E20vacse3BccQeeaGeQmxLy
         +sCyD85EseJzFhRgDQ3HQgtzg9DFfUnU3FADmSE3D8K7/n6JlDwYOpJPD6jIguj4g77O
         S3Zg==
X-Gm-Message-State: AOJu0YyEDlzyg0NurJ/zEFGZ6rVmIufm+tZfXGCkkJ7r1wO1w1vxgNRH
	fjkzfcvwb/B5M4VfVUWSLrAd9zZQivRR9upk66xmjbDBycRW2fHo31mMSMjp+rovEbHnxVlVans
	xhQU/Wns/bPHvlK8LXBu03F1CJ9PXcPFqI9Wl7x7zzPxQELDXyryLwI9bAqOAucDV+4vgwhNa5A
	==
X-Gm-Gg: ASbGnctM/gZPFjWk2GgjP/31/W0Sb7yfImuqF+LxbjNn6Z5bBSR0Q7ceZYN7dkUq0su
	68CjaTlfT6KGUF19jls/J+AyRT85DUu4ecRg5QIhsm+zueeQMean3e/U6MuhN0fBfX7+IAGbxhf
	MVSrwwMOF3PgQB6dLBfKszEKNZQwR2eFH1KN7jiRjzJAMUGhvBWAIEXJpVdn1+L/kzEzfmMF2Tm
	LRUqdFbk7URLM8LLwNgiX5ZzcxIWOKwpBOQNGYf8ih6wM3MR8p+WpOInKb1e5zpesRix5kAH0jB
	zQF40X4ykBRHCdqRfAWtinZOQGziLnGEJ2vgZLJi7A==
X-Received: by 2002:a05:6a21:3406:b0:1e1:a576:aec with SMTP id adf61e73a8af0-1ed7a462f1dmr40404064637.8.1738622951695;
        Mon, 03 Feb 2025 14:49:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY+o8EhRGLgXC/8FHqBM3Hq6MLun4L+ClAm8k8UyqHdT3OFzYo9so1tpjQQIlwluCscLDM7Q==
X-Received: by 2002:a05:6a21:3406:b0:1e1:a576:aec with SMTP id adf61e73a8af0-1ed7a462f1dmr40404026637.8.1738622951192;
        Mon, 03 Feb 2025 14:49:11 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba353sm8887444b3a.112.2025.02.03.14.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:49:10 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250110-fix_link_sta_bandwidth_update-v1-0-61b6f3ef2ea3@quicinc.com>
References: <20250110-fix_link_sta_bandwidth_update-v1-0-61b6f3ef2ea3@quicinc.com>
Subject: Re: [PATCH 0/2] wifi: ath12k: handle
 ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta
Message-Id: <173862295041.3734728.16749672295096616341.b4-ty@oss.qualcomm.com>
Date: Mon, 03 Feb 2025 14:49:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: tHGTylwfFlQv4pV_QrauaEveSpq4LsDo
X-Proofpoint-ORIG-GUID: tHGTylwfFlQv4pV_QrauaEveSpq4LsDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=501 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030166


On Fri, 10 Jan 2025 00:13:11 +0530, Aditya Kumar Singh wrote:
> Currently ath12k_mac_ieee80211_sta_bw_to_wmi() handles the bandwidth from
> sta's deflink member. This works only for non-ML station. Now that MLO
> support is there, extend this function to use link sta instead of deflink.
> 
> Patch 1 relocates ath12k_mac_ieee80211_sta_bw_to_wmi() so that it can be
> called from a function used in Patch 2. No functionality change.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: relocate ath12k_mac_ieee80211_sta_bw_to_wmi()
      commit: 090c645b2acc835cccf52a8876dccec55629f479
[2/2] wifi: ath12k: handle ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta
      commit: 2fc98b24adb93457254ee16418cffa89de038ad9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


