Return-Path: <linux-wireless+bounces-17173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D64A04E24
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 01:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BCC7A279C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 00:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154C5684;
	Wed,  8 Jan 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oal097CT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198A17555
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736296351; cv=none; b=oGoJN+kv/IhHEbvJUfqo90d/uFqYTmh9lo8blsrsm0UwERNNbNgFaX9KMW14LiUd2ORP78xjsZdCB40VT/ZPBxoQgMaR+FXq3tuIDMD4Ebyva5SJwWe+yV9ox9NDBpiwTYBP1QrjiXJ9btH9OF98wWhuytscZ5tBxUBxxsJSt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736296351; c=relaxed/simple;
	bh=IhMerI38csl0U/DzbCYAAEppIZIlUk6sHVuHzsmUIRc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q9VehSxzhjaUBgq+bcXazqc95u3d+M9odEVsePOBsGL8dBhfINjdMoAHnlexu+OGKKbABgpjFuvhUvpDxyKc8ty5Kp10v445bjdhlLjH45eN9kvDDg03tSE+XFyugMLfFs9OM7zjmUuAzXIl804iyZPkrohQGsqYbUC0AMNYziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oal097CT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507KPddu002704
	for <linux-wireless@vger.kernel.org>; Wed, 8 Jan 2025 00:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZYwqajZr8THajm52U0U9+17Jpe4L46VqtT5A9QTXZ88=; b=Oal097CTAJOCY2NA
	piZcXlVX4lS2AAhDWmOoJDrvYEeJVB+RzrqUHsKh3rV9li/BTnF44MjxrgVrJt/B
	VCWBnm/r4gQbyY/P+TlWu16W3oWPudEhM6uyO+wr4H5c8wxgm80QcwO/bb/UO4Rn
	bTuwtV63mJqHiJnAts5oU76D+9RGizTDqdLoqqffzkF2NWBU5YpWZIx2Q3amPWvr
	GgVliZiELhtc5aBIpcMVVATRPXwr+8cMX6MRDc8/fZl/JgvUJTP0m/n/4z0IUGqq
	2AuGp4jXYOrXtpeuoThi9bw+Q0P7vZhzXYk1VFSaKoZY2/QYyvcTt8l4g0+xdMnu
	7dao0g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441ba00d99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 00:32:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so36313880a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 16:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736296347; x=1736901147;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYwqajZr8THajm52U0U9+17Jpe4L46VqtT5A9QTXZ88=;
        b=HXsoNrx0qWKCE6vOr1Sb6YI3cWaIo6Ua7KNGtB3hbwHvVKAum1LCac3pcPCQi1TYco
         1fsQ52UIhFIjYrCWXlqMcJCY97Yox3c1vodnduU2gxdl2HWPqb4qByT+892QQUsTkA3S
         glT7ww3UsLIvvvQd32eeup8Tyrmbw7yQml4t78UdwoIoYbsq9krQG9Q50mxOHrfxxamn
         T+wZR/M2FFzbvYnhHwZfmFn5p+33WChBMA2x6CoLJb8oVWdIUkLby9FQe7t8YRpv7D6b
         av1E2A8Te20Zp/ZDOsqnNbluj/B5jt3G9XGdK2Ixk8UpMZLIRFPTyat0AD5qxsQLZkRy
         8j1A==
X-Gm-Message-State: AOJu0YzCFT0qvi2LqIitV2nFzK8HCpSAU/Fku/cRXF0I/rH3/xNlIVlS
	oE+eYrTnCvdxHLaJkOYzB77YGQ/l67XATa3lGiweSJPTIXg+d4N8itEanh0WVt0M2NknyFdBKo7
	rSwMNxvYhKdkc56/agJj+vMEihNnoRPTQNpOSZnFF+GDAUCRL3c+8q77tyOkew2rbrQ==
X-Gm-Gg: ASbGnctpWG5S5vf56DRjZB8qGzv12BXhrgTDR9IqsJrI9pfD5ASzX7McLDoQhhoF5y5
	OgaxIghP21OJkf2r97GQ/CRMblP8A63OJ0eA3BaLglDVfXOh3Y2IMWALY9aZiETOXkmfNc8jUbX
	TVgG1BIVTt/nmypCCqnWBJj6/zYSvpSR2QnCErmr5A/VjFifDDzjhgVXWD/SvEdH996EO9AvqQK
	CCVPkTWGNxcGfYNIoIw4VgIA3cJke1uz9V6kfQhy7WUcynkY9ikBMVTfdoppSbUmfwbqUyiA480
	SiDr4099Q5FrbPD1dA==
X-Received: by 2002:a05:6a00:179f:b0:72a:bc54:84f7 with SMTP id d2e1a72fcca58-72d21f4f2e5mr1434664b3a.12.1736296347597;
        Tue, 07 Jan 2025 16:32:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4LyTRPZ2Y7N91l4iAy90SJCNr5cuqrtOUJ3JGaN/4mogKJPcxGYJq1gxhkBi7cUgTpYGyfg==
X-Received: by 2002:a05:6a00:179f:b0:72a:bc54:84f7 with SMTP id d2e1a72fcca58-72d21f4f2e5mr1434632b3a.12.1736296347220;
        Tue, 07 Jan 2025 16:32:27 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dba83sm34041162b3a.116.2025.01.07.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 16:32:26 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Muna Sinada <quic_msinada@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
In-Reply-To: <20241219190845.605116-1-quic_msinada@quicinc.com>
References: <20241219190845.605116-1-quic_msinada@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: set flag for mgmt no-ack frames in Tx
 completion
Message-Id: <173629634607.3079396.7620610575380191117.b4-ty@oss.qualcomm.com>
Date: Tue, 07 Jan 2025 16:32:26 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: cZw4SArIyGKjR1mgUODVSBwfNyS2-vIY
X-Proofpoint-GUID: cZw4SArIyGKjR1mgUODVSBwfNyS2-vIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=963
 mlxscore=0 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080002


On Thu, 19 Dec 2024 11:08:45 -0800, Muna Sinada wrote:
> IEEE80211_TX_STAT_NOACK_TRANSMITTED flag signifies that frame was
> successfully transmitted without any errors when no-ack is requested.
> 
> In WMI Tx management completion path, driver is not setting
> IEEE80211_TX_STAT_NOACK_TRANSMITTED flag for the frames with
> IEEE80211_TX_CTL_NO_ACK. Without this flag, the management frame
> statistics will not track such frames.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: set flag for mgmt no-ack frames in Tx completion
      commit: 2d64da9ed5d8cee44a11ed3872dbfa6a914ee2b2

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


