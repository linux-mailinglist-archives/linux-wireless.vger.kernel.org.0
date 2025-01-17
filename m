Return-Path: <linux-wireless+bounces-17669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C4AA15A0F
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 00:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968F9188304B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 23:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94461DDC0F;
	Fri, 17 Jan 2025 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lFm3+PkR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D771D8A16
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737157321; cv=none; b=cnF5I1YYcEVByytip0xUTH0bmDEUNDy08BH/vSTLga9QTB1PrTAOc8EZYotxR/4J+QYUNiXpJrCyzZ9LwUxOskAJ9WNUHyACxhXf5+anxmtNvJBv2TPOc65bI7j71kxTvc2cSYOgDvz2L26xLiCLE4TO+P5LdlYRr1PW/4lFmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737157321; c=relaxed/simple;
	bh=EkDaviZplIHvN2sgeQdsuMomddSRpbSLceBsQ396Hek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PMxccLBHwLEkZ4VswFZ8XHEkoXOvp8o05ejmdui2mL2mCwdefoSh0R9P1uB4Yfly1SL/jE8i6+PfioitOkrDUmSARB2NiPypD+zRoX06FCpCGyM5+02mX9DKfIKYFjt0qCV5vbn8JeKD6AqtpeZPa3hh+m3rvMYB+l4m8wAR/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lFm3+PkR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HC8rIi006820
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 23:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3I9N6O2525ZSgmpQsv8YEoltGzp7IfKKDEnf1lx/M7U=; b=lFm3+PkR6FwH3fsT
	NKM9tfmbLO2GRlyHp45YwIxs/WqKJaV8dYRMl4oJm6yTLlEoCTvOv0G/67K9APmv
	QBz59kVsIFQ6M2gydinKwx9bfL6MF5K7YrA9mFwtHUQ1BayuxDiUvqx08sELlOZ/
	Ihbvee9ldSL/BFH2OmAvU6o94Y7nxghza6/rQ9UalSOfvTAgDLPEKj59C7bJo+HW
	U8jwaJ3sBYYbDD11OAcEy5WkoK/LPB6FCSwHT4MtEoYo37cj2+duoDDAOfJWMFne
	tHDUOFGAZm7dAQ8Se+iv5PKiOm0lukmP7uEyuRkM+Dg89fOWu2Maaxe0LJSA2iDv
	bfr4uw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447py0he9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 23:41:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21655569152so51837215ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737157311; x=1737762111;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3I9N6O2525ZSgmpQsv8YEoltGzp7IfKKDEnf1lx/M7U=;
        b=et9G3rXo/PJ8DY6ZDnQDWHu95VWG41wNUGqZocoAdPdENzZmpU4F7nUHTsByQZwzkp
         Y1+cGJEnKu4bDQmFBo0TfiF9229o6HchicrUuo3xyUatrOoEiDu7fLRzW0jWfuIpXOUy
         AOWPxTg28P9qdMlTGatIv2/CGKLWhJLxnfDyOLiFsPvlOmuhvzA8YfQdyOYs3jDsqUVH
         A3jpU6ypGRUD1nY/+CUWgAB/qQsayQxGxCO5oAC9dtd9Xfa1tE5KG1CfkDxWcZAjUBUV
         valy4+N9rMlA/WE7L0SxLSKs7L7trSa3Mgx7NxHUEnHrxs+UVRrYYnH/7yTNmxFb7wZK
         MI+w==
X-Forwarded-Encrypted: i=1; AJvYcCWyW3B0+P9cKfvaC+qXxoPAaWOdAFciDD8a1flqwVkE2WosBU7N0KzImslMKwbIh3xukvMAmN0Y1IbX+wjzgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIM6A1bL1yf5H9rEAut75AJZXBBLSeR2aLu85xn6lH+TaaGsFd
	KYeAS5sRqxHJNRaWhtnF1x1Et8wZDd6rHyR3e2a7o10hOMFI9Njf2Z7b1znrPpgW6wC+Ra7rUKX
	YIvVrkMirfJOxzn/nH1scNG2Uea6KKBOS9/sca01Ilcz2VvrK8Ta3J2Kw4kAsf1yGX18Z4AB2+w
	==
X-Gm-Gg: ASbGncsmjsmkuBWVxIi2N9s41u+Ba0s/ikoDe5Eer6VmuDQmgKJcLd3aHiIITVElYJk
	EbOUsVWn/KWI/R0HgV+EaquGb+N0mfad0dALeOnOgZZ7vVunwmGGnkVmvTuCMQTo2bAWEGDNH1F
	EIPPYxIUpwR6SynZnPn8wxZI0bHoEFyO6cjqMml/Yx6JgjZYENPG/+Yb8VwI3M+kx1Bf70L+Ec7
	LmRiSjxUeICuLnIm1W3if4flLDBolxSogcnU+ZvJ8Fb0c7AVvhBMhPKgpukn0sOSlOBHP/6W4nv
	dx1lixZe119etDJex4iw/M9k00k0ppg=
X-Received: by 2002:a17:902:ce8a:b0:216:32c4:f7f5 with SMTP id d9443c01a7336-21c3540c7a1mr65338115ad.19.1737157311370;
        Fri, 17 Jan 2025 15:41:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhffJxXR90TLMSYEts1GuwcBKIqu+SMv2RwsGws+deMqLfkKLSJCA8m10Tgr7ndDbUFZkRKA==
X-Received: by 2002:a17:902:ce8a:b0:216:32c4:f7f5 with SMTP id d9443c01a7336-21c3540c7a1mr65337815ad.19.1737157310922;
        Fri, 17 Jan 2025 15:41:50 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3d86e1sm21565915ad.172.2025.01.17.15.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 15:41:50 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
In-Reply-To: <20250115171750.259917-1-dmantipov@yandex.ru>
References: <20250115171750.259917-1-dmantipov@yandex.ru>
Subject: Re: [PATCH 1/2] wifi: ath9k: cleanup struct ath_tx_control and
 ath_tx_prepare()
Message-Id: <173715731029.3752359.10713709573661282771.b4-ty@oss.qualcomm.com>
Date: Fri, 17 Jan 2025 15:41:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: PC17z4rr_1AbHTLEXWsaOccYdOM56dgh
X-Proofpoint-GUID: PC17z4rr_1AbHTLEXWsaOccYdOM56dgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_08,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0
 mlxlogscore=572 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170184


On Wed, 15 Jan 2025 20:17:49 +0300, Dmitry Antipov wrote:
> After switching to mac80211 software queues, pointer to 'struct ath_node'
> in 'struct ath_tx_control' is still assigned but not actually used. So drop
> it and cleanup related things in 'ath_tx_prepare()'. Compile tested only.
> 
> 

Applied, thanks!

[1/2] wifi: ath9k: cleanup struct ath_tx_control and ath_tx_prepare()
      commit: 7f2e104f2eebc2c3e15ae34740c7b05d0362040a
[2/2] wifi: ath9k: use unsigned long for activity check timestamp
      commit: 8fe64b0fedcb7348080529c46c71ae23f60c9d3e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


