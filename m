Return-Path: <linux-wireless+bounces-22233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A5AAA43B1
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 09:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D274A7E88
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462A31E98FF;
	Wed, 30 Apr 2025 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OjCQvCjC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7C1DDC33
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997438; cv=none; b=sfbbwPKkW48TYByN+4NGJ0IO82LitEJXbQV6uDRC3+3jbh3wDLf//614/sbYHydx8i9YXv+TrMmO15rzoF+vdEI2xYP4rABCzmA5R+Im7L2mHeBy9JH47GjmSOaD8mrK52xLjT+iYQuskocXPkHyPQ3czqNQjwV/zZ9mbElhPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997438; c=relaxed/simple;
	bh=MoB14kMokiy2VD26V6+YIv577REI1C1RWimUYYely/U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TIRrgz4ohu73mxP3WobC+exWsVfdMfpIaKNKVPVn4fZd9QM0hQu+9wC0MMprvF+0c794zm+xdRlWdqrxIJ0Mrx2fBj2MHExFxiZptfFZPCAiTsxxJLz5Tydckuq+GWKUtiWv7vO7U63RCnl4DeLwQScvGVD79FtgYQ60qsSr4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OjCQvCjC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLaL9t020901
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 07:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=gKeV+gkvP1ek
	ho20zXTH/6l30+OFJ0L+bvElRGml7VU=; b=OjCQvCjCA1hsSkuyW2b7AO/v0TN7
	Xs6HkOYOsAV/bw3KpkDCqAJObKRvtYc4BtAZW9XRfisADerPhsQZPrEC+6zUX1HG
	hTn4e+JF/H1IYSUAqC2EfMG8JC4tsOFjQU9y19v7/kK0hakP9gFcbbDOFX3WeiQk
	bJsPC/Eas6Nj77ZHmY3ShXbfvEdcEnrUVFzcxkqsgdoQsTFGoEwHE3NYDFghtVog
	Y1aDxjvSR3c8JxwDT1BxBaSOockbls16/eMcyXts6pmFCIlrlvPq43x36GgnTEQC
	5CTbZN+b9xsuIMIuP8/CGYrqFPeuvk1MNXpr2S/WFTGurDBMWxW22B8wSQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u1s685-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 07:17:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22aa75e6653so56210545ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 00:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745997432; x=1746602232;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKeV+gkvP1ekho20zXTH/6l30+OFJ0L+bvElRGml7VU=;
        b=ExYBmyIZS3YgWJ7G1uJlk0O1Dp9wpJGEITa+oiLD9Y/x3igBQZGPy2OHUOFcaE/aPg
         +wYoL3TYtjY+Q3odsjncEa6hCxFDes3nG3LGMQW8gG53UG76EN2keGp94ydlm/KHF+z+
         ugsFTeKVnImEAHHfXWgE8rPeu7gZLn2tiqh6MHngq7pLnDNuJcDPP3zVSJtfFx3AsnY+
         svESNmFwrR4HgBsIugT3mJbCqkb3rD/zk0+V0hTSSMsnlXRoXPI/Wd3hwpR2fY9ARc9P
         b0XH4vxfi/2AFSVrnocize+PdyEMeu48McJ53+shikVjg36pu0l2nMB+146VALWk1crf
         dUvQ==
X-Gm-Message-State: AOJu0Yx/Gqckp5ArvpgG0RN4BhrZEMgL07dLwLFTcrut2MmQLh5ufBpr
	yKOPThjsoj7DiE3NdLpppXDzb0zhJo0W0BYtefgpE9fDtCSWPlbXozWR7KRRAJrJwY1kx+kTJSa
	Uq1h8h9jjY1WJxIBl0RLLxPlQwBTyhsq9l6fUlnds6UPnW050/qROk7Rfp728DDWElw==
X-Gm-Gg: ASbGncse9la6CQMAemFABFesNSNQjRYznbun7boRBfdydD2Yqe5tKwlgKELg4qNoA8u
	pMuCEMAihoBuUzbMkTMPLj1MaR9LOr/p9mIijDovD3dGTS62+R5Q2qw02RGekrvryAmlIWSRN5w
	eEH2cYdL72oFCEKk4qPW0Ezf7Fb3G4VXrHyU4z1wMTYL/jzSd7R8RpGKUbZPtpf+0TAN6uUS7Zu
	Vf/A4U/DrSkWQCEyOTFapLmInMmnOH4oed2XfcpSDvLdFSsqLfKYiZyP1vRVQWREZSPgf6bOdYT
	MvgTSv06Lb2Z2j89goGkKvJNDVgM8f19syvBqoGzKUn16VvUaYkQWLvqZ4W/qBQQkCIBE7kVurv
	PoJLdBlCuG2HxmPUEWqpEny2823HdFow6Gco2V8j2BBD6gw==
X-Received: by 2002:a17:903:1b0e:b0:224:1eab:97b5 with SMTP id d9443c01a7336-22df34a5d2cmr35677465ad.1.1745997432432;
        Wed, 30 Apr 2025 00:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLIbx/cS7aw4DGZiMpap9jwqfVuvDZN4bfVeNIx5BGeGn/CMM5J06J9cO4IRogJMiDUpHvdg==
X-Received: by 2002:a17:903:1b0e:b0:224:1eab:97b5 with SMTP id d9443c01a7336-22df34a5d2cmr35677135ad.1.1745997431984;
        Wed, 30 Apr 2025 00:17:11 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc70efsm114817915ad.95.2025.04.30.00.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:17:11 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next RFC 0/2] wifi: mac80211: Fix Rx packet handling in multi-radio devices
Date: Wed, 30 Apr 2025 12:44:33 +0530
Message-Id: <20250430071435.2201777-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=G5AcE8k5 c=1 sm=1 tr=0 ts=6811ce79 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=XksU3ag3ArSG99RURR0A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA0OSBTYWx0ZWRfX48Yqh2pfDOuY ONj/CaO+m19woYXhkyrYkJXDhLPljNZ++0VvmIKabZOycF3DLHOrgyTCxT2Cc22PrM7gB6B98NH QQYUqyDzSp2SIQ1b7Jq0zzN7mhyaqssxHy9UD1v5wa5IqXqN4L+411nR9nnY5vnDXeas5ygTuqz
 UMMRm+asYbOi4vcRdUUfi8BDJy47MlSQMfionEB6wmmq684cUIqaU7xgdyMBFpXNQWraHYqTSYY WtRgTU2FS8beSEaPJ7a6uQXXiDXzVxS/2ndB6idRa0JjfXzlv8mJ1Mx9jSlU5A0OtFO5v85mxUb IRq3eQldWqf1tOPFXEJJ8onfE3GWzykvOQm0uYrizn6dhcz5sy5gvmax1AwaU8BxTfIrNAVhuNf
 GpCuLPhRKn0ZVo3MoIAvXBGvYweuF04ceetwMFw197PpqjzpDjFYbUo65TE2px3L4henivUv
X-Proofpoint-GUID: aTzRjVqGjf6b8PZ2Hb0_snGX1gr9P7ID
X-Proofpoint-ORIG-GUID: aTzRjVqGjf6b8PZ2Hb0_snGX1gr9P7ID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300049
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

This patch series addresses issues related to the handling of Rx group
addressed data and management frames in multi-radio devices with ath12k
driver. These frames don't have the destination station information, unlike
unicast Rx frames, and are forwarded to all the active sdata of the device.

This happens because currently there is no check to ensure if the sdata is
running on the same band as the frames are received on before start
processing those frames.

The patches ensure that packets are correctly processed and forwarded only
to the appropriate interfaces by mandating the ieee80211_rx_status::freq
for group addressed data frames and check the operating frequency against
the rx_status->freq and forward to the appropriate interface when the
frequency matches.

Marking this patch as RFC to seek feedback for the functional change which
mandates the ieee80211_rx_status::freq for group addressed data frames to
fix the above Rx packet processing issue in multi-radio devices and
following the current behavior (Rx packets are received on one band are
processed on an interface running on a different band in multi-radio
device) when the ieee80211_rx_status::freq is not reported by the driver
for the packets received.

This issue is also likely be applicable for Mediatek driver (mt76),
the other driver that registers multi-radio device (also seems to report
freq in rx_status).

Maharaja Kennadyrajan (2):
  wifi: mac80211: update ieee80211_rx_status::freq documentation for
    multi-radio
  wifi: mac80211: process group addressed Rx data and mgmt packets on
    intended interface

 include/net/mac80211.h |  6 ++--
 net/mac80211/rx.c      | 67 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 61 insertions(+), 12 deletions(-)


base-commit: 885e5cbaa0ee3738fcd99167439459ede2cc102c
-- 
2.17.1


