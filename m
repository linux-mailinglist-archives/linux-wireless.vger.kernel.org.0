Return-Path: <linux-wireless+bounces-25495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77FAB064DB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 19:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DBA5675C7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198BF280024;
	Tue, 15 Jul 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XUHQzie5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871581DF258
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599029; cv=none; b=p0Krx9d4ZI9ysa+W6k4acwTVLeL8Aks7XDRZUrjoddtdBQiqyhpvhJDJtHbrUlwolBDXUUqrd8nta05v5GcY+ZAzegmx9INDhw3Zy1GgVdSUtMe3/C4nw5e+jrHJ+GE+m5LW1j4e81CaQH0ObKejJL7W3L98U078uWavp7jVAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599029; c=relaxed/simple;
	bh=dicjAlJPe6baE6YbcoZnBwLfYS+y9yn57Ov6Q6RToYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gof3x2xPKLGqNz88PFKoTVlqbv7V6stf1f7o4uN3hHX9Qbt5BccUCfqwmswhS2jmdrDIoQ1X1+7Z6ZoIqgTs+4rPgx0C4V7C/hnzZ6lQGZo3KGVxdvNKuXS9NcyWeB7IJkNfURLxdx8URbcrcwC2mcC1sQaV5fncjoE8Zk6jTgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XUHQzie5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDBuI025690
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 17:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	90GpV8+hUwlfdrE85xu/G/2AfYKG3ln+ooGRMjQFTQI=; b=XUHQzie5MoNqwmRZ
	LEjEvfT5o7uDvBOnW2CgImO7Q56a+i5SNOUEKJCmWjRKvlfV4m6Pv9b/I/7ZWpMD
	0GQpLkMI46EoOqou9u/rnzUfmCAPUwiIMiQIPrViTsxVyUj4vvo5EUtFv792PUbF
	NFkn6CkYc6xO8x1GpYuCHWUw4H7w5wd4GjFnJA4c5MM44q6zK96U6X/K9udNeBiz
	UCcXmhBYaIaJqh73jtHsj7RPjKcT2mpVDq3eoLzD+j8mOg/22jc1DvKi9XAUam8S
	UUHz9NZvOeSTWsp7EJolVr6rZ6f8syqQTRW3phQm3c07bG7kP0Gv9Ss7uoi07RHk
	KanEWw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy0s0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 17:03:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234b133b428so46279955ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 10:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599026; x=1753203826;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90GpV8+hUwlfdrE85xu/G/2AfYKG3ln+ooGRMjQFTQI=;
        b=EAOKDpk25tR1yibSCcBs477A5saYler1io5YR+tKPhM/WwRe7/hGuBX6KCODVDHGkH
         SRP2D6KzAe6pgKXVuffQ1dAzyzuJcUppcKhHZeuxNEomNpvnjCzIf7dFh58IJIOuasPs
         x98FMtrrDXG0Pi6CHcm59qheIOs872DOI02IOqfQh1B1sOCCTuBcXTVSuBAvaxle0mQf
         iDZYpkV33sL4izBT7kx1Jm/qo5HusrRQD27Vi8JcjHeby4cxx4xZXRfETSyFuV47VoN4
         NrHjrQishiUaN4MAoUs2BZHe75FATlKOFYDTRzj0NPn30fBvZoXpuFDqGFGltnHWXOYX
         0ksg==
X-Gm-Message-State: AOJu0YzBTlCnXYJ3BQmYkt+iEmD3KoFbX6jP9+YJdZ966CNXTDa9IKMV
	kreUjJrytgfTF7BwPRbiCGQZ9FMa9tAd6HabXMYxOl+1BXHVLWq76vtkGo84tOmZgAATSXUaJRu
	mIb+FKAUPLNXc/uvGjH0jcNVaZMe6dBvU7hbQEnv7rlnZVE2oogyP7c1VUxa2MuWulvgNFA==
X-Gm-Gg: ASbGncujrSgNaKFpKL9vMCorghfrZfzu5jpwhTKDhkKG+4Mafn/vceeNMFu0zNSF3rR
	LzQsZpn8viXI8O4EisLR8vaBnA//6xWRQB4KfL9jNuUAKjt0SXGLe0JVyRCTrUFqYeOGqgFAtIo
	8UktX/AKEC03cPkTcqA8ITMtJnlJ1DGOdJ8fqVCdTccuaQiIlU3ZWbItbz41k+BVCK/R1o+S9ze
	mbvJQr1UoCxhamkQK0S8pOMoT/AQyQl2IAfOw/9a3k6WsC0hv86aypLnnEc5pbhZpxtX1g4ZR9R
	91/wMMc5z2rUl5GBX5Sa8tx/orpcJgAbQjvM960X156IhThoJCFcEFvQnVBCECohqEIlkarqvrv
	T
X-Received: by 2002:a17:903:1448:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-23df07da8b3mr303638915ad.1.1752599025822;
        Tue, 15 Jul 2025 10:03:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+5ygamHAh1vx+QECJOZ2mYRZ3B1D8qXh5iQiUIr+MN993YDsA1qSa7iS48ILhmJyiSBMqUQ==
X-Received: by 2002:a17:903:1448:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-23df07da8b3mr303638435ad.1.1752599025297;
        Tue, 15 Jul 2025 10:03:45 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322cbcsm118733715ad.137.2025.07.15.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:03:44 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250603-ath11k-use-non-atomic-iterator-v1-1-d75762068d56@quicinc.com>
References: <20250603-ath11k-use-non-atomic-iterator-v1-1-d75762068d56@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: fix sleeping-in-atomic in
 ath11k_mac_op_set_bitrate_mask()
Message-Id: <175259902445.3668196.7323548526989354054.b4-ty@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 10:03:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfX7F6y28FP1Yi3
 Cu7ohfEVCNfLlnjRJbfuYbT1gef0N122Nkt2VT9K0yf7FhWCppVkCdrQfCV3eXot+gMpTpApMfW
 nf5EULG3+tzUKBue9YiihaFCnm7bKh5v2QyBs+Ls7AKeCwKAiohWLQdxGFC28k/UnryqPk/3FHm
 xlaPzzvswuPWqUKTJkKTFBXin/vcLOP+OcShcs5NsXblXh7QhOtrmnW8G7TtvfQqUKzR9+/KJDG
 iM5XA8HpkVsz5EegpUSuOOgWrbQxsiMVe58FWQc47xkzGEWXDbTIgQSNCy6QVjKmMfdsc4hapC0
 owbNAAEu0KfvqFIXSSn3FTEuJkY0jpJuJiSiEP+F8fH5weGQXktZFDg8Keg8t57qt+oJwllOLra
 Lrf2QQud7Szn09LSNTvg30aE4kUBVNxvS90/w64EXDWwGQulicNfPct503ak3ge/zjEi6jSD
X-Proofpoint-GUID: nFFZxebIKuMApUR681G4zYjflKCBKJIc
X-Proofpoint-ORIG-GUID: nFFZxebIKuMApUR681G4zYjflKCBKJIc
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=687689f2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=MkI95_h35qG_dB8Vl04A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=798 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150156


On Tue, 03 Jun 2025 10:25:28 +0800, Baochen Qiang wrote:
> ath11k_mac_disable_peer_fixed_rate() is passed as the iterator to
> ieee80211_iterate_stations_atomic(). Note in this case the iterator is
> required to be atomic, however ath11k_mac_disable_peer_fixed_rate() does
> not follow it as it might sleep. Consequently below warning is seen:
> 
> BUG: sleeping function called from invalid context at wmi.c:304
> Call Trace:
>  <TASK>
>  dump_stack_lvl
>  __might_resched.cold
>  ath11k_wmi_cmd_send
>  ath11k_wmi_set_peer_param
>  ath11k_mac_disable_peer_fixed_rate
>  ieee80211_iterate_stations_atomic
>  ath11k_mac_op_set_bitrate_mask.cold
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix sleeping-in-atomic in ath11k_mac_op_set_bitrate_mask()
      commit: 65c12b104cb942d588a1a093acc4537fb3d3b129

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


