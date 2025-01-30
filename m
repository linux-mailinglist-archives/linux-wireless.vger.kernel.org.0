Return-Path: <linux-wireless+bounces-18235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE65AA237E0
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 00:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F007B165B3C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 23:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F41F191D;
	Thu, 30 Jan 2025 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAP09BkH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3461B0F00
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279959; cv=none; b=SPR+rEWYqnJyddfC1oN99ruSSNlwxsnbrMi4nxfMgieqn0FKKRT6I1o3x1ogcWfwb6uT3cCVlVeElZvAMpksCsj3sB0hMsz1sYwXurAEqHjPXoFNwF6rn0tfmq+nDWU2rJdzrJpV3BkK73PzQqqjvbFAu0dnP8Dt0HGHAzODkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279959; c=relaxed/simple;
	bh=CgjAocC7axQTzXdJhNMl2//UP8PhsV7XmQmajhubHNc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MD6pEamPiva6uMM+cuFbsTia3agXI4G6rdDSkti8f79ffvMdTqlbGrqZnI/gVK5dTnX0aXFBUuZ2RMJs/3nYTTNsi9NWJZuUcIR6t6iNNNW7eRLtpu7VXFD8laFPrH3b+g+wn5EtLOUPBhvWeEDrnBVgXYRqX58qDte97EKCdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAP09BkH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ1ouR003751
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 23:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MkvDxx0ZhOvR6Fr+Vc7J+UJ+xM9SaEghyf6kX+nNdLg=; b=SAP09BkHrcAcaxCU
	503dVo9mdrR/W2PamQhML0A8YQTPL2rnL11GutpuPsFIaRR4+dnURD6xu7Set9/e
	INRMUyxHIBeT85ZUWzEKdvviAQhh+S0rtrHt+jDgCbOPjPnzLmQpSK17A1OJQnoa
	WDJo6xhlbk+4SBrIK4Ne6VbigG5LOwI3FwYgsGBcGiB4fGQkw9AcbbyjBghv3XKj
	flhtqMHs7e9nlDi4RBu9ni8nrHLrFBGYOk54PdGaKJ0nwFqVcxFmqUAv6nUPTtXA
	5Znt0bcklNCfpRXR3zz5JKRevpBLogBtxa0Jed8z6hqqscjDcEmLHNzXFfRlxEqQ
	g8Lw4g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gf7m8g4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 23:32:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216728b170cso28278535ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 15:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738279955; x=1738884755;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkvDxx0ZhOvR6Fr+Vc7J+UJ+xM9SaEghyf6kX+nNdLg=;
        b=gxIXCRZJOgoSEtW8mbl7DOAtPI955Bs5cw8UlBJVEUV5Oiz/Kw7DPdHeoZ4zDiVh1S
         hOehy1mMFkjBv7cEt0fcbmMLg4w/MPY6Y2oTu9Dn0FQl9aQEj51NWCrl3btNCeVVBU8r
         coHsa9dO9nFiTsxG4LoPIzzlkDv2dBJ8/+GoPrkfX295PYqaVJ1wqC7mZ/gQ1WCUcfZF
         kV289nfinJ4F1A4vhEfZc0yRw3vg92Oq4ExLIYq7kDQ0c6k4Rrn9x5MCsiYIf5QkEwgr
         FrpwBKWpsw2eYN+9YfKwrISZSoFb5HJgKDOmUxsoRFoi9PP7ltTSpsdhSclxzpDoDlfa
         gfxQ==
X-Gm-Message-State: AOJu0YzUptQNdC30KO19IzTOWO6I4BadFWw+IX68USjZ+ZpG/jvy8gxo
	ik1hCMfJriDqjwyuWnaIJ9ag+2goEamZ9IVuYV9Ysorf9TtHegSfQzIRQ6tzbsr2PST4KhQPw2z
	axiwrYfTReMkgqyW45fzRP7dPa7IdCNAzK2docoYO5XF5pAzau1PWmd8HU3igcgbovyVJAlv85w
	==
X-Gm-Gg: ASbGncsyO34kInxHmmHMuArRrthAx+hRAJ7EgCTOmm8bjRDnfY7B1ujzGgX812OmumI
	vgyeTuLJmpLe6kbiMhtv3xM2aF1IyizOxxZccO9M0Bt/UeGaw+YeU+KRl98/6E/QmFwBURKhAQ4
	3vVH7W0icELz6hccfkYms49RDgLXLtt15WEk/+zZPTGmz9Tz7dWSQYswaje/x4etvjcWjN3Lyku
	CTwsD1/tzbxRLyIcEAIEITZeo1Gm26og2VSjQACmBfMktrOBAZcI53lGMznaHaLO8jkOoXmUHrn
	TAh3w+HWi63Ja1Qgt8gTTSktyY9ov9DH2Bn6SJ/Q+yIYZ+L3wJXhqXm993tdpA2Ar7CeaCenqg=
	=
X-Received: by 2002:a17:903:228e:b0:216:59ed:1ab0 with SMTP id d9443c01a7336-21dd7d736d9mr126800155ad.27.1738279954969;
        Thu, 30 Jan 2025 15:32:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFugGEeK79mFsAp/BtFK2sSZqpExBLqHKqTjsHW//0aiJ4dvvfBkLobTa/kRqWRpyGnI6gXjQ==
X-Received: by 2002:a17:903:228e:b0:216:59ed:1ab0 with SMTP id d9443c01a7336-21dd7d736d9mr126799965ad.27.1738279954567;
        Thu, 30 Jan 2025 15:32:34 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea5e6sm19357535ad.152.2025.01.30.15.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 15:32:34 -0800 (PST)
Message-ID: <5c101c47-2568-4a53-a6d0-6fe9c4a38076@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 15:32:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix wrong overriding for VHT Beamformee STS
 Capability
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124075953.2282354-1-quic_yuzha@quicinc.com>
 <90c00af8-b6bf-40a2-8f6c-89b5666095bd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <90c00af8-b6bf-40a2-8f6c-89b5666095bd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4JO6pHL6ueCktY5Z2Uwdn672db7irU3x
X-Proofpoint-ORIG-GUID: 4JO6pHL6ueCktY5Z2Uwdn672db7irU3x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_10,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxlogscore=687 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501300183

On 1/30/2025 3:29 PM, Jeff Johnson wrote:
> * drivers/net/wireless/ath/ath11k/mac.c copyright missing 2025
> 
> I'll fix this in the pending branch if there are no other issues

I see this is added in another patch, so you can ignore this


