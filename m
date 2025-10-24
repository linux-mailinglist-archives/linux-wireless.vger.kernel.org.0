Return-Path: <linux-wireless+bounces-28223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B6C06C32
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 16:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745901B86A15
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587220F079;
	Fri, 24 Oct 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZHjt9leR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58782230270
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317230; cv=none; b=q54K0mGNUfAtp0FTePfeuvnqVd/fCZ1oqHA7RMDcke8WRrnPx55B37j2L4lnxEayvE5UnlZXBmMnU5bjri7VN7Z5I/OG5Wnij+XmLdA4r/oOHmA4p7m1OT8OW8h13EAg0RPVLgaUfiL27TzENOrmKz6CgK00eX3S/FQzqAEBpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317230; c=relaxed/simple;
	bh=QAtQORC7ivgciIIZx0F1txr49gK+qSkCd0+eeTCB6KI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H8wdTwHzJSdAaWjXdbTywbD9H6+rhH7KUA3aGCllcFE8zPiZPNZAW/irkZ9VqWMldOcD4xt1NwW/W/NcrATUx3IqXIMNsZDsUK3COwCtAg0JHJwYJmIy1/3dNVqzBo/CqmwwjVizRMmUerw1AT6Or3wIXUhETnXOQZ1KenhwPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZHjt9leR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OBtPWg022678
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 14:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8tUMUyakynfKB8Xyi0j8WHxEx4h2ADucIePXA/2iTng=; b=ZHjt9leRNa5ItDNX
	eVNlJk9JhO+p97kQO6aJv+n0sa0uIzVYdOiiPMvLq0F26oE/uUoYs6+JpI3rXuBg
	zrvrzVxs9ZbOwTRskVyxer0FJyCyTuTxbjD8xX8J/KlIap+J1LwFDzJp1SW4Zsjl
	S36JMH8EVsooC7p84BXA71/c4mKRoGT0QN+L1bfCCZQCcwXwJKwhFpnXDnjljVnA
	CPN25zypFNtxyjS0Xt6KUcsNGzLWTWCFzKTwP5iqJqPzcEC6y9ZpHGK/Qgg0oVlQ
	Ru3Fi8UhTrlqVt3tIXBpsEsDO7g8clRLYbhWQgqSpIMHPbaiYp9GHAstXOFETu28
	Q6hu2w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8phcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 14:47:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290bd7c835dso20928335ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 07:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317226; x=1761922026;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tUMUyakynfKB8Xyi0j8WHxEx4h2ADucIePXA/2iTng=;
        b=qI7jDSej1O2IIwk0qgWuAYOSa4XTIAPrIe2QyiMHkQhYiITHnp/5f7sTqWLyjbPkY2
         dE7jP268zk6SNgA1PBsi4l8XRJviTDBu7l9IUuoxKa/GH1IOhzlKZuy18yK6UB2MaVTS
         2wZKlWhtm8eW5uiWKICTvp2f1DpPWoilHVptWJBE2KpwFmjh7V+W7mBdf/BXMyG23uzH
         R5X4LlMbXtr6eh10Wh8X4u/W7KFzvn+Ub4z9QfT/u1GOV5spZv22HqIztB2XZxVQYAcC
         YsbufsePxo71R7xj+6SHDwZku7E/uPUw+uT0ea/jcOB3UtYdjQNTUojij0rqt97nFZG7
         qnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7xaq+pj1pPsE/d3wjvDZN6pRT8Jcr9Lwypya5gJhttFP1OUVgZ3Fjge5cLnSvQf3EUHNUrXMWBcDLvAwXQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcOI7ehw62ITSqO5i7jy1qgtFd4mXn/dm0c2KPvO3UZoJUXMk
	XWGVNfi5/aO2gkYbIX0LhgizaJMWJeWRSGo+vz/nrGN2MQWh4Yq2vfpeXfbf4DMrbVc0j54cZjR
	fGhbPxCpCpBMJqfAMppTBdG2FtXVDtvNCJYNr9FRXlINE+bmgoxjPdXb2nVdVF4C/BKLzaw==
X-Gm-Gg: ASbGnctiaKnI39eTEKWZpW9S6Hf9D7EQ8B4vEMISYZ0ZQJtpjj0g/1KELE3Lr3NIgjt
	Mcu3al2E5q7j2p1Xo3Mkm06kWDDKEypFjQMRonYZ+sbpoI1fQcxRGFc5tpMSw6Kfvtot0N0tGGt
	zJfbHD/esBEwRZmDZkOaxrquNe6P7WtRnx9Zm/LpS7Pf3NqCrQecZLe+MroDxMKfsFlafgkNrIo
	z9Fh8zndz62jc2Juku8EfcAV7f/JygOH+QgGk5ImlSDRHUejWFwoltM9nBv/MMS65GXwNJMmgZb
	onvTtvZjLu0Q8SFa2pOk+lKIuwBsDfi3lb2SCCHxqpxr7AtLOrsar4jLXLNutpTwNQZSGd1TTza
	wJlKcMRVf07tUMdL3xa9On5pBBefF7liz4O8=
X-Received: by 2002:a17:903:2309:b0:262:79a:93fb with SMTP id d9443c01a7336-290ca121803mr384424985ad.32.1761317225806;
        Fri, 24 Oct 2025 07:47:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV/SyNy88bCx9RA0BmgRcHQMdPgTjByIaAKXxLkGcLIUgfzWvT5s4/cufHiu/Pk8jWjrZKtw==
X-Received: by 2002:a17:903:2309:b0:262:79a:93fb with SMTP id d9443c01a7336-290ca121803mr384424575ad.32.1761317225360;
        Fri, 24 Oct 2025 07:47:05 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda5771sm58169035ad.18.2025.10.24.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:47:04 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Wei Zhang <wei.zhang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
In-Reply-To: <20251017060100.1751692-1-wei.zhang@oss.qualcomm.com>
References: <20251017060100.1751692-1-wei.zhang@oss.qualcomm.com>
Subject: Re: [PATCH v2 ath-next] wifi: ath12k: add support for BSS color
 change
Message-Id: <176131722470.1606896.2554698564582461997.b4-ty@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 07:47:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: VzNhM2hkWWqNK4B1EjvEx1CxDjfVH4qk
X-Proofpoint-GUID: VzNhM2hkWWqNK4B1EjvEx1CxDjfVH4qk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX1V8CEqHe7JEy
 Q6O4sPsaxye4RnzUmm5hcKa2EwZC0cxwk+lWIE9keGQnZ13uD0xr1tJ1ku3TiCsiHdUZk5hf1em
 ErZYyYUlTUKOsK2dTr7vDQ010HVJa5YSWY8nR3kVEgaQv26u0baC3KwwIXFFFr+ZTtej0y6ED7n
 mUugAxgPIaRMXA3TKfgojhodDp0VCAgKD2LB4nb49MEVKfBNxsHCmINAQ4zOIbPJYafKTbhO4Pc
 SjsQ5r2R0V3t1i6AHPLHjuJHkp7a/ROwDiS5kd5DK04VfiI3aNtrfLPY4Ld94F63dut0ZAAHPo4
 83eOwzjorVRXvFeg94obqh7Gk6jy0qgo85x2uTjLHv+qaDBooqPBnhupgYpcrWRlrZO7U7jLFzJ
 ilS8Vx05ERKPke3znJJhbUcS1Tcurw==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fb916b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=wmkh4GOX6cRBnxIyw40A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164


On Thu, 16 Oct 2025 23:01:00 -0700, Wei Zhang wrote:
> Add support for handling BSS color collision events reported by firmware.
> 
> There are two scenarios where a BSS color collision may be detected:
> 1. The AP's MAC detects the collision directly, and firmware reports a
>    BSS color collision event to the host.
> 2. A STA associated with the AP detects the collision. The notification
>    frame from the peer is routed directly to the AP firmware, which handles
>    it and sends the BSS color collision event to the host.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: add support for BSS color change
      commit: f7746cfcdbc5d3af9c5059deed30e277d926098b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


