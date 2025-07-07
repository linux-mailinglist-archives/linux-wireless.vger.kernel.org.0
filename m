Return-Path: <linux-wireless+bounces-24888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AC0AFBE49
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 00:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718297B313D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D603285CA7;
	Mon,  7 Jul 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BhmZIHvw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4722B8CB
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927786; cv=none; b=k+BGvo9KL906iNgNRzxHbII+ZVN0gTqKqkV4oB41vbEP78lOSUce6pAc50tqrQF/vd1prupl5F8nY69ngoUsrYfI4WW/Z1RWG3z45dXq8kP+8zx8/i3XUiOPx6mhNWMlI3s/nzLNbkhVz5dPJnpiuAazGXsYYQ8eBfDNFe/s44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927786; c=relaxed/simple;
	bh=YkbuhjDgaRmvtKN1aWFXpA8UZhqLcaMciIo7JBfvJf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NFtnZXk44l0qTX4rN4zVnoy10TgV16iLgqTO6tUsivH5D11oy5SK1TdsVpPEUZgfKJiZ5ntT4f4gMPYuUaS2MLxsRHkv8nKR+bTYMBVEpaJuqQQ9EuT7TdFMpCnGo8/t7pOx/qXStac8g91r/kH99PoRCDg0Mr6i9J0ocLWJiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BhmZIHvw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567ItniG024132
	for <linux-wireless@vger.kernel.org>; Mon, 7 Jul 2025 22:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	58sLsyVBxSODICZUsU9uTkMyvgRokbpHZA7Sf2AjOd0=; b=BhmZIHvw63tpvk/8
	QpeKBX5hTMzaabOhnxdkJjDkNVtM50WxVy3aGR5SKBcG83JFBPg3XSwCDME169Z3
	i7nsETj4OGz+5Wqi2aVerkRTkgo12QXYXGln08SQMzc/2g5x4Ij+ulkF5MasdbJL
	a+GdJVrHBWU8uSHx7y3jZvjLqZw6SrRgk0IWwnQYh3yeHZW8mNlVjWteD5H4Cd9e
	+Lhz6KV4F7TUgVHcWHtjWiiOy1BDNIWvXJ2WrzdYJ/L0YfKNElt4WOCEBho5t9VY
	Td/UkHQlEmz6TY3tjsr8SDoyuCJfxnA98OadwMBx0w61sJfJ6QN0szGnu04r8enn
	Xz+64w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvtkgpc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 22:36:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7489ac848f3so5622366b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 15:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751927783; x=1752532583;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58sLsyVBxSODICZUsU9uTkMyvgRokbpHZA7Sf2AjOd0=;
        b=Icvr4dRin3dShreesvct45U2E0tQDgby962DtuszMZRU/ovL6WQVt26zP1RA6PuNSN
         E14xNTh8oPgAKblbXGafxU9YFFdhQ5Slb9bMrEDK/aiguGxKx/bCAyeuIBarqjqQ4mIn
         n2oStIKPpk6MY8Tq3kbrfwXmWR/UR8HKnwD+Zb4gY2PwcLfc4TTB+SKnneKS7DpOJwoY
         zWSjwTnLVkEby0zC4TJyjRQN5VaAZoYk9AsMbbGTn0XY3W8UIMcOzpqIDhUTASqLbTNr
         64mODwgNRFRhPyHiIm9uJnGigkFJpQ4Lur3p+/tOzeF7LOphZLvOkHSyCmdICnnurAX9
         2I8g==
X-Gm-Message-State: AOJu0Yx4ngM3EsjPPHyMSTfkNJsM/Cpx98KGsq5rhkDou9lxS/FCDs6m
	Okbh6z3TjKgxFFqkDwBeybBI8J+7TqCJ3ISHp5L2doir15WcKFiHhLvII/FaoNfPne9FPIQH3ii
	k69mplh/cSE+a1h/W+RPBWA6lYZid2JUgIGYWAiDVIfsvoSvDHvwcMau7zO6eMF4qx04NfA==
X-Gm-Gg: ASbGncsoQ/u1MgC/JaI60yyDJ0Rp8e4icnWBURZ0S6VzahHU9Qn/2isIVEufEGgXdJF
	Fo89D9Z+o6wgk4xlNNkSYrb6rzGu/O9bjz3WGUCwb/6XDF3jqfa2/hZaAvObcdUjvS0RoFaaboW
	LlshLFIVeFf9D7/uCoptbdmravdIsXR0NKp1QvOIchD8jrSf1G0x1WJlD24oz54T0bA4rcFfk5+
	VS4Y+YF9wfjUfA1NVXNf3LugT2EA9rgei2o98TRzaiG17TSNIdOD6in8D1Mn2JGKsNfn+EC28VM
	s6wERBzjnF7NctMi/jTmTW/8CIRig3ye3HNHuzNQ1wN1bf3p3GD7gV6W/90=
X-Received: by 2002:a05:6a00:2354:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-74ce8ab166amr21446829b3a.15.1751927782730;
        Mon, 07 Jul 2025 15:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwBqL+fxR/ucQx5k8AE51TsXkHh05PJEkfhYYKNNad+uzcD6SMzfUayMwxjD5BCxoUPKNXaA==
X-Received: by 2002:a05:6a00:2354:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-74ce8ab166amr21446812b3a.15.1751927782351;
        Mon, 07 Jul 2025 15:36:22 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee6358edsm9668064a12.58.2025.07.07.15.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:36:21 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
References: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: add support for Tx Power
 insertion
Message-Id: <175192778158.314276.5668474308481760371.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Jul 2025 15:36:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDE1NiBTYWx0ZWRfX5bWjBKOqqSM0
 RPOpUO4fSNPVAUXcX5CebCFHAk0DWWffExwhIGcO1qgIO3zSmtIfrFVLY1aYMx9TlOtjQex7aJE
 yp9j5foTHbAl6dMinDr8i/xC8xwOZ+rQreHsWtk3UCyGSeH6xhNPYnNzH3D/uctGS1dUUlhzuzL
 JFJMq5Bb8Q9oEU64HltnlM9rzb916TCPaAPmwn4mqA0KY3zvgQnXEHfpm9k/u6HNGeiZRPv80aD
 sXS5ysPYd6GRdjTNyiXI0G4WqoB2bw5mlWfXD64iLzIoea112T4VaZyGrjoW+XvSmZ/mAUCJr+G
 3vr4dm9OPvFsbxqp941LC4TEu56C0TQHG+NeNIFcuJEGHJRv7BNmuJPQ+bpr38gf/2jOLTvVnTs
 oWEwWETdSpNybY5BQp0YuDfoSKqx4cV5i3aWbm+/K+qonm4jHCmwwgEWpxNmgnYDNnasZIxT
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=686c4be7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=bhy6XtatztNBMhLyL1sA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: HFE-Fv3-iWa75cLQzRAGfVv-a-1CRGD1
X-Proofpoint-GUID: HFE-Fv3-iWa75cLQzRAGfVv-a-1CRGD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=963 impostorscore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507070156


On Mon, 30 Jun 2025 09:45:14 +0530, Aditya Kumar Singh wrote:
> For certain action frames like the TPC Report IE in the spectrum management
> TPC Report action frame, and in the Radio Measurement Link Measurement
> Report action frame there is a requirement to fill in the current
> and max Tx power of the device in the packet.
> 
> Add support to populate these fields in the relevant packets. Advertise
> this capability from the driver using the feature flag
> NL80211_FEATURE_TX_POWER_INSERTION.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: add support for Tx Power insertion in RRM action frame
      commit: d45d015448fcfbb5dde7c09f2b0dffe5d689e6ca
[2/2] wifi: ath12k: advertise NL80211_FEATURE_TX_POWER_INSERTION support
      commit: 93a1cdb9cd94c7b8a2aac33e4b13ca61d712f5eb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


