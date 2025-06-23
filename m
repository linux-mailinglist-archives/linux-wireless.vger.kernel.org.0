Return-Path: <linux-wireless+bounces-24357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B94FAE4751
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D49A188340C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22585256C87;
	Mon, 23 Jun 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZfMmGWn7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457726C3A8
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690129; cv=none; b=sMFVy80VmaA3uUODKoX2uE3mgZPOBwmGf/M9SgLNBDpuTRZRBcjJturAKjXYc+GGjpkFqGoA8kqHzvNNILrZv2GUrPduDoh3g+7U7dK4zLYcCdX5E5u/LBw+HzGEteWXaWULOzY2/6a/mj+mX9eMEjB8YzEOkPCKnJfaukOxbLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690129; c=relaxed/simple;
	bh=nrwvzlaqQUC8YAY+W2bmqWO9HhH2p11gVxDbaWx0z2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tD2wodujJg+guw0u/LMfUzaAed8p3RYFU0epBsXm6qNzbfu4+R645RVMaa3f+BhGmJbgnjTS8Z3PGqcN3BQ8QcfSGawY4FOsSiSL1J9wy9F836RXnrEdb0l65qj9KNwSSkPUA2OMzEmZLAJvb1qw74lzFZCqtccDsYNACoQys/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZfMmGWn7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9deI1014609
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3u2UsWwNOHw0K5RL0LIdI2bAlituELP+9ZWGZzNcnro=; b=ZfMmGWn70YeX5kZo
	YW8ck/uV5F+/T0g4IIkgOSbw2cLr50iYze25lNfj2be2HIhmEisjdtDyeBF5f4fc
	vnTMIUVDbvWqxBNxHAfbGRl694bUfxqi9GHR8JOxFikKItWlahW7aG+PjaE5ICLC
	1UiT4ViOSaqshAsS98roIhwCJNmMDPEf1RTw645zRAuSGTyfhBv31a8j/VvkOHHL
	pz5pho84jTUrewYWomlMGxaiDw/YGOIiLmDFMFcY5LIFirMjVPT54FeWp8t6Rxrj
	Tqz5/t6PLVO5oXexDT3jS+9Isqkn0k8qr0bnXtN83uksw0E6YbndBIGnFgGnU0VH
	/Tk75g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5j4pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7425efba1a3so4594151b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690125; x=1751294925;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3u2UsWwNOHw0K5RL0LIdI2bAlituELP+9ZWGZzNcnro=;
        b=kVsdTY/YvRGPV/sH3I/Bvj1RxQFiXdY8BBrXOCtdEDrFTzphwbtx6w4WAs5AWXgosi
         TopRstB8PR0nPrqxQWq0d7QzBpqg3Q0qkhwb6yT1JT/r0L5EbofFH7VGRKv8DVIdpOyK
         hIV+ms2tpmgsOEwXgMbzr0qbdQ5INRkeDKmob1Jl6rdReEHQwkVPPBmJU8XHr/JtHrao
         B1jTESZXBlj5aUljPsyAdBQidmuMJ1qB2gFXGsxOYnzz2INEhNgbHC3uG7h9WOQdaigU
         OU29dEKz15h4zBhzs+jFDUEhuKLsMbDE2Z5NVhXTfl58FOpa5dnMJ6/p2/DgxE2P1HML
         UiBQ==
X-Gm-Message-State: AOJu0Yyg5RhD+P2EGCiJI93OBhq8SqsQNU2voqEqJvQ6kfXtvbfAjJcQ
	GgVn7qGDWeJGnIr2KUjK0Mh7buryDaXxvUZc+K6+7jmkuV1zry3TcnhiZGYMO/MnGS/SLQiNGNs
	VOGg0Nh850uIp2/IJ1t//5cwHs3nE+38leETyZ2V6M6HVXYPgqyXT8srhoSSIqXsRT3kbkg==
X-Gm-Gg: ASbGnct9Cm30RPuYPMOvCtJO2wTumHxvLEl+Pry/PfIJ+pRITNpDV3dynsBtJFYgPJF
	xcjyu4pU5KftGZ1ajzJvC7h6V4etCH50f4UQGHA7LbklvlJ6jjueCqxG8/85M2hJ9vUaRj5UeII
	SlhxNPBZgRaDaE5PnrfAzenXXEvu9zspLJDjRuyY1Yfv8dGaZhsC/bq674aZuAl8j4r74f2fT/4
	4NfOmfg2O0X8Svc/jX/aw1qeJYzshNwjEUOvgpN7kXfk4qURgwrt5kgznxArFKsycP3DeThyAwF
	OCb5W7H3R9kShjzDkuIP15slxmgWpBeHGrfIJXJw2/GSooGF0c2T13GWLIo=
X-Received: by 2002:a05:6a00:4146:b0:749:1e60:bdd with SMTP id d2e1a72fcca58-7491e600defmr13374396b3a.2.1750690125500;
        Mon, 23 Jun 2025 07:48:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQRVvYAXXguR4h45hA8mHP72d4LBWLqdt8dB/qCfMgFAV4oWSoJigOJ4Z9ErviJVTpXKp06Q==
X-Received: by 2002:a05:6a00:4146:b0:749:1e60:bdd with SMTP id d2e1a72fcca58-7491e600defmr13374358b3a.2.1750690125078;
        Mon, 23 Jun 2025 07:48:45 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:44 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
Message-Id: <175069012445.3758471.34015701209057251.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: mNkVSejcQlBOKFeqqicjFDslxktyigq3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfX9jNxQQA5z2JY
 68yl4Y4PaXydQKENVNUWowfMZrRI+G5yqzHgmY7EIua6fv/OkmbAuNv5S0pGayFl9NuQV7kTv0G
 TT1Gt/k1K2DSKiEJr+gTv8G+rhyTrgWuHd/JEE6nTcNB5z5X3Txz8FuTfSAyrYO85ASpfIcIKvi
 Zqc1enWx/g5dSs5xia0bdyVUyIo/buXmqJhA93ZgECY/dBFLBIXarpa/vhpNRMK3fRiAUgv0BvB
 YDwkQ++oD5tVRATOBCqMNlAOKYWH3ofYS5waYbcrT1P9PAxQ3YkMVYz/52v3qK7oe6qshVuoKEf
 BJt6DnpXydg6xtVqO7I6UUXeGLUOJOW0xvqdSGY70f9Hf86ywUzV/vtRu92VIT0DirqDmhG37A+
 rY22EFE0XAqr6zY6BavDlsHpeAGcyPvpYSGVqOr95nCTwmSuwhkZKpY98DZTvrRkUPhiWAIy
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=6859694e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: mNkVSejcQlBOKFeqqicjFDslxktyigq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=884 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230088


On Fri, 23 May 2025 11:49:00 +0800, Baochen Qiang wrote:
> We got report that WCN7850 is not working with IWD [1][2]. Debug
> shows the reason is that IWD installs group key before pairwise
> key, which goes against WCN7850's firmware.
> 
> Reorder key install to workaround this.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218733
> [2] https://lore.kernel.org/all/AS8P190MB12051DDBD84CD88E71C40AD7873F2@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: avoid bit operation on key flags
      commit: 49375e11819b0d0f59ba59726d8e0b47656f5406
[2/2] wifi: ath12k: install pairwise key first
      commit: 66e865f9dc78d00e6d1c8c6624cb0c9004e5aafb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


