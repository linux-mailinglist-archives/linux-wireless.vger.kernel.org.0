Return-Path: <linux-wireless+bounces-27587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54DB93407
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 22:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D29D2A27D1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92593265CBD;
	Mon, 22 Sep 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nkoc5lxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4183261B8F
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573788; cv=none; b=AUVm7NPO731xfn7ySC6O4meBcPqgPMTqRvpWrQAslJp30Trj93Ap3cptFY6oqdReU379DmpnGwyG6I+zantr+nU95fcEjNFEOaXjFtFclQWeTUmoUIQJdtEFyugiJ3NXuTx5rtUPkN+BTG6L1KDsSa+XLwwLciUgDg/f8BHIrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573788; c=relaxed/simple;
	bh=52JbI0s4aJ0wlJBIxQ7v8JLU7D8dtXVacE5hsg3PXQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pPNIwJ4T6cfOZ3kBdah32YWyPY13Z4/zpdzekVkRgfmAhloahVpKavpRwUfxG+j2oNxTJL6RqDC9l7M6Y7La63JtA3U9jtwOg4FPzRNE56PnEIXN+nZXkcmoVapIkm6n7uRNVFLhINs3W8oxX1YstuhF7Y29JBozfA/owq0kMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkoc5lxt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGAGe8007664
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 20:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3cqwvkVWW2/xt/kPparBDxu8gcaOUPtl4f/hYXlPlio=; b=nkoc5lxtdi7i3YzX
	TtWwQ+ToWmpiQPe8M4IaK/5+niNG8n0m6gVd+E32mshgPIyp3SrbUW1arYFixnK3
	qY6peCU+d94v/ZvqRiFF62L03bFoEOC1JI8ZdWW8YbhWMKvr+3eD1gBCmNOBH6Ux
	thKCuKGZwbOz0o8yhgJdHI9xbwc1E5vP80hO4ZfHhUFQ271XYSeRW/52Xsj8k/Wu
	RWbXhR5oX7tDTaXGVNdwWrjnrs7DTRkklq9cvbPjcdBPMo38ZfnNOlnpUNE4le7u
	5tFzUsGzHA3RTqBdj3wj/voeNuXtgxtZs5XwWectTWMCTZrKUjEjlyLT6smB0/jx
	ZwqS0g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyepd80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 20:43:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25bdf8126ceso96273705ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 13:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573785; x=1759178585;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cqwvkVWW2/xt/kPparBDxu8gcaOUPtl4f/hYXlPlio=;
        b=EN61L4uqnVbmSOGse6h4wNU2xC5d3aFUpftgyXWyL7pj9rCe+q0OjXwxOolUYs85hv
         BKL/EX39+r309Ugl+3YQiG1cU5mHfuEWpKLBi27Bk3vJEkam6FnVXovaLYw553Gi/bIG
         AAoxBAXDY/Ngb+3Xt3wlZGniYJHyFdBHqfOsU0SfXkcrl/aDPn98LXqWzXksaVN+2wJY
         t2GNA4obG5JCp/m2ZetF8EQCjXXzcC22YfEI+aGx60JgDBVgMdrLPuOpdNLadC59x0kw
         a5zG3bLUoEiZ5AlJ680nVl1ITkoVug0+PB0icFQzcEJOizmlOASmRJtciRO3qL0CIl/t
         ID4w==
X-Gm-Message-State: AOJu0YzkHGpIPhp/CCsZ8IWsd4Vd9JrVP0tZL9bMpnBCYA7noCFIldrL
	5St17+/7wArg5DdfFkiS/uqxUDmOMzKWx43O5ZS8VpOAAH2YGcE4uapjY1g3oMf58ZAwEK4OOhc
	IKUKM6s1mgqA/Mzijiq3AmfIQPlcVd5qicADLWUTl/8MZZ7dLSJdVT2EHwtKn5givU45/1Bpn7f
	Tgmg==
X-Gm-Gg: ASbGncvFVmdvIinxSDiKdlo1H5o9HKgRXUnqAj5lMsuDEGurM0cnX6ockzrfGslf7UT
	uhJL4KD2f6GVrtfNG+CELunpx5lnLqBn536gU7kdG4wnqKjBVAS5paUzzKsTkfsoAJAjPxGJ7z8
	cbrjUjqHox1Kb7+NjZhyT3/wi76yAYUnWpNhaN5D+Jys2vDjd1WW0umT0BTFVddv6V123zbF4aa
	4XFw6J/2P1xw36x8D1nXYFQS9x/F7ICrF9Ee8BV6P+r8uZ+lEFnLzo8XTAmANQJGWZOJFSRA7gX
	0a6Wz6Jxv+D7+fYuX0qZ2dYiCaR4gW28P6pyWeors10wDKeEuqQQxjw3kUnPaWH0qCspittbycY
	j
X-Received: by 2002:a17:902:f101:b0:270:ced4:9116 with SMTP id d9443c01a7336-27cc6785ebdmr1107205ad.33.1758573784565;
        Mon, 22 Sep 2025 13:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERMjo0/jq7MVqzGKb8aFEWS6Ln1AUh3yqaOjrG0v45gklsxV8QHYKyxlA/kLyAlFJ2Y8jDuQ==
X-Received: by 2002:a17:902:f101:b0:270:ced4:9116 with SMTP id d9443c01a7336-27cc6785ebdmr1107075ad.33.1758573784141;
        Mon, 22 Sep 2025 13:43:04 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27cc8b251f7sm817935ad.8.2025.09.22.13.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 13:43:03 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
Subject: Re: [PATCH ath-current 0/7] wifi: ath12k: Fix Issues in REO RX
 Queue Updates
Message-Id: <175857378340.47334.15939102906187566074.b4-ty@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 13:43:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Tu-abCeS0wYZHSYTlLKAHYFDfViA6L2g
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d1b4da cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8XKf7K1G5lwa0OuaegoA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX5xplYpqeYK3g
 Mlj3v2ENUwRf9eTy3Z74oM8B5xUS9BOJsez9xhKDCPtYrFU1vKYtvuGTDa9uIQWPoRdf/ANFhm4
 k87/ipj8V7Mr45IeZ8UnzKpZWYQm5i48v9lehunILh7Vz3TQyZHGWlooqO9PWvG/X6lZO8WmDY8
 zBxc4VJVPBMW+6Ge4PjXydEfsApNUhpK9SoLqqFshopoyDfIMXdT2znW8pZWnHl8rMM7hPajmb1
 FtoYaP2yQ5pZ78K81M/yCfUnRfGuTRjXkzeGSeFoudclpeN9CzgwbWNIh20Vi2wYSBa0LOVoOQA
 3wcWvYA1nn1a40qw/Vboz3nSepaoWfdfz3AEBeogbI0tsG0J75i81ifEMWTTPJKAWMGYev24db6
 dIeF/CCE
X-Proofpoint-ORIG-GUID: Tu-abCeS0wYZHSYTlLKAHYFDfViA6L2g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004


On Wed, 06 Aug 2025 16:47:43 +0530, Nithyanantham Paramasivam wrote:
> During stress test scenarios, when the REO command ring becomes full,
> the RX queue update command issued during peer deletion fails due to
> insufficient space. In response, the host performs a dma_unmap and
> frees the associated memory. However, the hardware still retains a
> reference to the same memory address. If the kernel later reallocates
> this address, unaware that the hardware is still using it, it can
> lead to memory corruption-since the host might access or modify
> memory that is still actively referenced by the hardware.
> 
> [...]

Applied, thanks!

[1/7] wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256
      commit: 82993345aef6987a916337ebd2fca3ff4a6250a7
[2/7] wifi: ath12k: Refactor RX TID deletion handling into helper function
      commit: 7c32476253f11210ac24c7818ca07e19bc032521
[3/7] wifi: ath12k: Refactor RX TID buffer cleanup into helper function
      commit: f829a1f8f27555742c9759870895f22c4ab7febb
[4/7] wifi: ath12k: Refactor REO command to use ath12k_dp_rx_tid_rxq
      commit: 6a01985105843e8c043c2bffe25c54b71bc45002
[5/7] wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures
      commit: 3bf2e57e7d6cd3e0896c2aa5e86f11aeb7bc3702
[6/7] wifi: ath12k: Fix flush cache failure during RX queue update
      commit: 5e32edc6942570429d9c64d0641fc2addbf92be1
[7/7] wifi: ath12k: Use 1KB Cache Flush Command for QoS TID Descriptors
      commit: b706fb4e580ba66b2c05be93809807c9312008e2

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


