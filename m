Return-Path: <linux-wireless+bounces-18251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A84A24368
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 20:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B5A1644B8
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 19:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B251F1316;
	Fri, 31 Jan 2025 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJx4MuvD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E502143888
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352062; cv=none; b=SJjgCFkOdfbb4ZaPN1uMYyc1Vp3u2f9NUmBJnPS7Tv16UTwCBP2ZjkYCUeYkrl+jXgRMpkEbELBLYlW4v68yUoRS6BBzr31Do52gWzlY5JtCyclvUH6EqSSxYliSz9rTRp4zuVuE7zP5NfHbAb99yEPJ4+EJVTNKQu8QhdyCGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352062; c=relaxed/simple;
	bh=Zx5E5lHPkKpNDrWt5//5V7B516IwmrWT4737gUdaWFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VHGndnTeIXqaV4gOISqIWqGH60dx78d4rorivX7y+pdsvtBWcwm9TR9hoR655RP9/8a7cK9Ef4tqhFla6TNw1wYfDziE/VU+0LlaMtHBNDvZT6QYwZilhAEI6pyezX0bebZe43IrxqAu3kSOZtiGJ6k636hjucHLdZlL+s1VUck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DJx4MuvD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VDLcQX021465
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/iW/2qxNn2EpMG6+5p2BMofbrneeebFTJmziMbge0Qs=; b=DJx4MuvDfeSHhcVJ
	XlMbmaHwr2Qw/EP6eCQcLe63uE6dWWNvhGuzJpGFmLGQF4FbxZ5sfyjcRZY9LqIG
	PwvMPJ4l+5aBbDg2cp/MHzGnfFwGHHtXS50CGOsRMDQNNkTeoY9cf0e3zv8OFrN5
	px7W8m+lTe8gGXgKodYpZdpkWJHtCt2hxPTaLhX2esWxtkVKVZRUhxcS/9kz4x92
	3+JVPlQ4zTssU1iT8+Qow9MixMVleiVQmKrFwkUbFepigLR+O9GwRSkTHZmzq9BH
	ME9mTn/tGnHPv9SePSHsBwZXUlfzDw7UGU4S6BHb0dLK0swbLHptgBXzs8ZBQjny
	hcL2Ew==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gyapgvf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:34:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21650d4612eso63665795ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 11:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738352059; x=1738956859;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iW/2qxNn2EpMG6+5p2BMofbrneeebFTJmziMbge0Qs=;
        b=JcppnP0PLgdOKPNHDTa54OvF+pHiMwtK0jcGtbmQSqs4NAgssJQM9NXKAjIhtG86NH
         UqVwvxyzqdL8R01zFpN3xakkb4/PbCBM+bErrO658wUF3Vyw8QlWC55dkExEvD6Xzs3R
         0adY3er33qh0suHVrqei3TYBg8P1QsLY/k/JD56tBb9Guc35O7Mb3pM0IUsN9C1aH6bY
         /GNV8KON2+FEqGi+3m9kiobGRKGO3AgAhjVSst/OZ+kQ6cKscYA9cTa6MRq7XgfM19lh
         5gqxL5Co56qgY8xJ17F/o2SA//s9k6TCdLz8WvPz2WBmERXS8U9Yf+r8DKXqOX9vNAhZ
         Naqw==
X-Forwarded-Encrypted: i=1; AJvYcCVnTFPwK0vlxcjzEFqQE9Ec73OE13jiIxkquUwYJGBt6FfnGtKRlSLhgxEnuV+sQKJFG9W64crxTHD89/3YFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYt/elFjXXE3eXOwu0BRmwUWN4ZzFtoS0JHacIl8WxHNbmEig
	CK8bC5ot2SdeYuKxTQ5OlawBbVVvFRETa+Kn0b05/rRZZLq6LpH08wGsKTLTPUU0vaVrt+c9kEJ
	es3JHKnNHV4lFXBS9d9aUUreAZAHWgDuv7NroGuo9xQJOwGbxSS0BHhcDF9JrN0+L2CwvMMah9Q
	==
X-Gm-Gg: ASbGnctCJQv+wBuctn+KpmX2w2D1GSGBwTSvAnX6OKyxIOixJBNSSqShWA6T3TzTzVZ
	6qUl3Gk3k3fZURYBS8u9sJ6zzBFURfAf9Y+x+Tmf0HgkkXpaVKaMmpFDvgCLPsaZkOPG1Rmhuz/
	QCCjg6UkfoqDKLrOGkpRt9+1wlNL1AdobjEcpXjbCtWuzT92O96cCoh2EAMg6n8btPUSr3nM36u
	nbKHZiKds7pHWuNB30V78drEkMGrSSdEjUlki1tDJN7faaZaGy+2850gw0zjLWM0eP5A96ToWLJ
	MaqRAoWDqDSWxSQaLnsrkRI3Ym7z01/HaCHsp/WSbg==
X-Received: by 2002:a17:902:d48a:b0:216:4064:53ad with SMTP id d9443c01a7336-21dd7de20f8mr215305265ad.48.1738352058601;
        Fri, 31 Jan 2025 11:34:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyfULQeSiiDYkhpqhyZgfXGSUVIibS7WsKtnPhn9q9CqH8uXiXQ0B8xheM4FWNRiqBoIAKdA==
X-Received: by 2002:a17:902:d48a:b0:216:4064:53ad with SMTP id d9443c01a7336-21dd7de20f8mr215305015ad.48.1738352058247;
        Fri, 31 Jan 2025 11:34:18 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3302a50sm33721995ad.188.2025.01.31.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:34:17 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
In-Reply-To: <38c2a7c4f7eaf57b9306bb95a9e6c42b7d987e05.1738169458.git.repk@triplefau.lt>
References: <38c2a7c4f7eaf57b9306bb95a9e6c42b7d987e05.1738169458.git.repk@triplefau.lt>
Subject: Re: [PATCH v2] wifi: ath12k: remove return for empty tx bitrate in
 mac_op_sta_statistics
Message-Id: <173835205758.1098484.10102684203904092972.b4-ty@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 11:34:17 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: -053uTpr6YxxD5fY5O7FKAECG4bxOTyE
X-Proofpoint-ORIG-GUID: -053uTpr6YxxD5fY5O7FKAECG4bxOTyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=681 bulkscore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310148


On Wed, 29 Jan 2025 17:55:17 +0100, Remi Pommarel wrote:
> Currently in ath12k_mac_op_sta_statistics() there is the following
> logic:
> 
>     if (!arsta->txrate.legacy && !arsta->txrate.nss)
>         return;
> 
> Because ath12k_sta_statistics is used to report many info to iw wlan0 link,
> if it return for empty legacy and nss of arsta->txrate, then the other
> stats after it will not be set.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: remove return for empty tx bitrate in mac_op_sta_statistics
      commit: 8a5ad319f2e6f0462dbcb1bd3a6ba5097f629a5b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


