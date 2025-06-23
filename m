Return-Path: <linux-wireless+bounces-24356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC2DAE4769
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA6D16A6CA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1426E142;
	Mon, 23 Jun 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ftV3liio"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2126D4F1
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690127; cv=none; b=RLWKLcIniMRW+gLVSSBRT3i0oflk0B+9F7KOom131IRSfNp2yu03R/CkP0m3/zsYmW/8DOzHgq+1aKIscgVdDwa/lSpP4zhN9odXskqyNtQroTRcszoNydFNeP7FBFUpS1DdZzxJw5wwirlLdmp64rq6/ZH6iPUybl7mQw2ZYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690127; c=relaxed/simple;
	bh=kC2JjAxpViZ4gsNaEZ7QLBCHBVX7ZMl25Hmr9XBHSl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tLVG1zSc1Ap2fg/OMrE9fK8/Exx7Vzfj7RG7ERfb8WPGRph21HpPYSfnqyZyGWShWvRq5YfmBfEPPez+1Szq8HbInwZenf+pJeoNTpurypGCNKxURSj3sp6Y4R3qrEedPrynBZuh13CzgY6vXgbIzfp3KEA7Pdo2ewzstirMNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ftV3liio; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9JFo3011924
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	smrlmfw7K0HprX+c2QJnRSvyFhrOeWmixWsgoCpa1Bg=; b=ftV3liiohGEg4EIe
	9LQrLfU3FIAFuaLDEg8RC93bMs2UlScy6QyZZ4/BE5ZohLJA+sCLPC8fUZkLxiVD
	my1cJWBY/MU1MShbO+Qg2GXNtsfdwPCcoz4MhU0vn74UY4OR4taD2qRTe8bZkn/G
	w7UbY3l+qVommVSkVilZFEvFQZ2goCYMpKDRrx9gYP5/OQqloi+7dOuBrIRHWxdu
	zIA/GhNJjA00jw6l9QN10viBCj/8Y1MNMixDLsp3uKlYfJX+PahV2aQCQAfeR9j9
	agAQvdRMXu9H59SCExGqAip0KMxwZXMM/WiX9p5mWv7FeRZvGgGI2dZG2e6TMMGj
	/8ahLQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec2637qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74890390d17so3634278b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690125; x=1751294925;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smrlmfw7K0HprX+c2QJnRSvyFhrOeWmixWsgoCpa1Bg=;
        b=u3ve6dzdQYi+KlbAXspt3aU7FAClcHTEb5/Pb9M+wY0F291q+1TBoDcoVOHxBnz8t1
         PoaI5sd2N9p6oQymqNGwF+HRFdr2xTkHZT0V2igXcWPq66MWDaiQWZ7hcZqax6rKsrH2
         qdEbfMhzxre0JUe0YU178hz5vCTw1yqTS8X1Gg6ZwE8rvayal6el6hWz9DyNYvmczi3P
         WF53f8MFVrv+ov2XaXISmxJ8KzFA57W/vNZpmN6ba56gLtjiePttlev+qBiZLwniHxit
         aToBi/475P8REU45rYxkvt6c1TyzJl9E0HvD9zQMVsokE2td5HZdFBtOmaSQr6kOvOZj
         epcg==
X-Gm-Message-State: AOJu0YxdTcFrfXaijcvR3r+DftJudhKcGsMsBcjRIYzBm2iKsHY5YvBV
	sWVmxemka7dNcWynca3/T9hF6dsbmwksadHUeqJL22N0cvN6d0Cm5iPUMQ55XkiDRSIu40JYI4t
	KphfddElhP2NYFtrYr0N8ZcE+nSsXc5bXrI5VYyOvfBmSQgvMRZNN9fFkeONQsjdgxD6QQQ==
X-Gm-Gg: ASbGnctAnbC+1l1B3E8PJ5dLAAH2YR5hxLxT0wobKdJxyKg5FYcX1W/RwUSdUgFtK84
	2JZyJedHboQntVHot7jBDhqyoVZLMiEVp42ZHP1K/0/VMO0JpgviYH/JwJX+t/0X6UgOOXzFurT
	szQ9Vfha+tDXCfYCJ9kIZV/FZ3vf8QcGnwdkoHQJDmdE37H38rwZdezyIVBdRRgoTLV+HMUc357
	/7yigiaQHbwbpTtO8GNN7vkDKBU6G59FxAE9u9dIlLol1Hx92/VwKyLTud+47eB37seKmnfLV82
	aEyDd10+V/UY97NCs1aZBm139LAaGAlwHcBo9sMCW/NuxP54G0e8EkyIYt8=
X-Received: by 2002:a05:6a00:a87:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7490d7abc7bmr15085691b3a.10.1750690124690;
        Mon, 23 Jun 2025 07:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI8H4aioeCCO3BadXRxVD5Z6GQweKGC54MAANid7328O86mBLGyJUYhNGAGHLFEk0y2GC6sQ==
X-Received: by 2002:a05:6a00:a87:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7490d7abc7bmr15085665b3a.10.1750690124268;
        Mon, 23 Jun 2025 07:48:44 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:43 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250617-handle_user_regd_update_hints_during_insmod-v2-1-10a6a48efe81@oss.qualcomm.com>
References: <20250617-handle_user_regd_update_hints_during_insmod-v2-1-10a6a48efe81@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: handle regulatory hints
 during mac registration
Message-Id: <175069012350.3758471.8696092328804905972.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfX5LSdNVFIKBxV
 rHMIAtsjhBZ8TdHfQv3B4ukxUpAThM2ww+4exPpGP5mPIqP7JRlxFzJH5a1YhCiIBhROpzS0Ln2
 1ZYPui2qAhMGIXx2rwGg7Lk0HjtvO/chl//TiKMyMQ2xIaqj7ye85PINjTSGkkdsqOv44a3DzOa
 GMQ1So5Ic9pCaDG/Lfi+sq6pNUYopgUmxfpfFWToy27roz3xfnpqtFGqglccWcFVlODlOK8RoBe
 vD6yT1GboRa1/fXFXex38sM/uFhbdFBp6Uv12F8/RLgUURfT1per6ZoMHtpSxvRU552Xf1sosxp
 G16IuMUR+pNAGr/FAxom4fX6HwgmabrXYNpbEBjqGCFUHYF3K1iwulJKYOS5+jt75RfhKLLDtoA
 5W5NUTnqk6INIDdYPqzUCnXkikPXne4h1pSIy/SKzjBQQkk5Tk+p+G3Kp8RB0lWcye0M+Lv+
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=6859694d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=ZM6Ol1wdqZ8AtCD_V_4A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 3cFicB67HhSKpFKV9OfcVrS5e_QF1By7
X-Proofpoint-ORIG-GUID: 3cFicB67HhSKpFKV9OfcVrS5e_QF1By7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=889 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230088


On Tue, 17 Jun 2025 09:05:59 +0530, Aditya Kumar Singh wrote:
> If a regulatory notification is there in the system while the hardware is
> being registered, it attempts to set the new regulatory country. However,
> ath12k currently boots with a default country derived from the BDF. If this
> default country differs from the one provided in the notification, a race
> condition can occur while updating the regulatory information back to
> userspace. This potentially leads to driver having the incorrect regulatory
> applied.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: handle regulatory hints during mac registration
      commit: 906619a0096747adbce9415e10b639cfd2c5e714

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


