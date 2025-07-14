Return-Path: <linux-wireless+bounces-25390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E22B041D2
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A427F4A207B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D62E370A;
	Mon, 14 Jul 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RH/jC2ak"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB71922F4
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503725; cv=none; b=j+cydFpD0ciuE0ePn4Smkhw99+2+GEd27D+EY0Tu4OCX2QfHGkAxbGzyeZUpDhu7tFPOB8xYhFFOSnCQG/a5udnK5slF4ryT1NAR83c7j2Bh+G+3eh1+08fwzpanvVveiXKSRfK/tA9rdB5SDkPDb6AaHYMw2vLWEeYDw+jDgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503725; c=relaxed/simple;
	bh=CSO9diQmy7M9zgo7ZmISc1U10ZKviVOiAdcy25/y1wI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ADu+IDMENyJRzLwCdQAcoYH7P+uV6kYfGXCnPvhK+z6jhSSSlItEvJEgd72IS33GOEyNAEjLkNN54hL4fhraCVK+dGtKDNU/gK0LUeP8Q5t+SEfSQJYlyH4OSnrIj5WVMcrMFl3L6VGaVHcogmsXsHSK8XKWeRwdeW6lqzqwat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RH/jC2ak; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9aJcU007777
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 14:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rN3xI+b2jQb0LT3/s36eZ2egfjGu+f/4HTByzPiJLj0=; b=RH/jC2akp9/04loj
	rWB/OqxDPo4yJOUbazoble4MWsmKlNuWc0CzKYvhIaN5w+oX63RxIP8vprEvddTW
	hbptpdvVzkNRW5Fy+ovBdxUN6/I80ZlFcMvBF8rtvzYj0nQYz6Ywi2cyfK5MaQ6W
	Wgvg/ysSdLw2oaVlmguh508im0uKUPuQYPAyqQFKSmQ5ZN2U7Hs7mkMWsQ6cY7Nw
	4V/JSyH/TOPvMg3pPwO1iuIdDG7CceJFVWg8QelSZ/SsXyVe8w78gO/qJ9vhrtpu
	1L98ekWmEAeALRu4dSxLmAyrY6qioBkqHO/F9cAZedhk7Qcy1JiNp/KS6MrJRyt+
	ThyA6A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47v56a3gby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 14:35:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2382607509fso26275075ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 07:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503716; x=1753108516;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rN3xI+b2jQb0LT3/s36eZ2egfjGu+f/4HTByzPiJLj0=;
        b=FQD2nxhWipr26gsmH7RyDHSuLBwHsn6zhC54Daykt6ybBzL4ij1II8wpCiW0aeEyc4
         KpFNRn3YznU0yRrRk3v3vLtOG2lBdDNh8yPjR/9uhG3CkMxfxjEECa18iE/xglpGiL6f
         ZKiMn6AMM34EwmPETiTDk19mEwa1G5kPCP3KWJTURiXAoVI5p730Lu6m9840t2l5UUHW
         wQ84IQeM0ilf1ieY4KZdkz3BED/iTjZ8xfUKYUW+JLO88nfujym+KGqWlHrNjsSUTyYJ
         oQrp26MBwwSNhDvECFRTD5sWQZFeXiw7docWg+d+hM/aScO0zYwUcEGhwCGQ6XmJ21Qh
         y4dQ==
X-Gm-Message-State: AOJu0Yw7leaK71mDbZSh/IjjzYYb7B/6/WnO/Pr0kYUfNANAkWSe3XWW
	9w30LuUyXe9Oh3DWqE2toOBl95byX24q3C+ex6NoGLi4zf/jFUInNPtiCTqIitxEma7oJ5XQ07i
	QG/boJgLtasB+cQn6p+zRd/kI5ZXhm9upiTF1xqDVWdwYwcuRcHag/YtCUUcNBLyCanLWBw==
X-Gm-Gg: ASbGncsOIXoTldmoOPqVTgN72KzrRho1LIyjCVd1/h9RoBZ6OX9riPA/80VU5wAAX4J
	r2meowliLoMePscx2Xu1AErum9ko+TwQ4zaeXwvZsD2Jc5/wb2spzbOyShd1MNVO7IuLD1YUl81
	hHUCX64wK1lbxaMHY7+4ruJQ8jatAdj8y3tAKvfLJKNkpL/fbTU/91P60+4URXu0TkdW3GfOxeG
	eFGYrTliMIcSsRH7L/TXml1Ys66joUVa6ARAj0t2yjbV1Pfyt+0f/Cozmg/heTIEwwy5hPt97d7
	gg2MNaezlwjMxZTQ0CIpn2920pXNo7sWjTMG3eIXL6Q8usol/vTD/Bvn4aliCvd+cVWMD7MXxDx
	U
X-Received: by 2002:a17:902:f603:b0:234:d292:be7f with SMTP id d9443c01a7336-23dede7d45dmr179425385ad.31.1752503715835;
        Mon, 14 Jul 2025 07:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe0JsKnhzgQMV0HTKNkoIOJWCm4t2UqcNbD2jbln+6oqnUb0KMlhnhxmEtmpq7iTEOsr3aZw==
X-Received: by 2002:a17:902:f603:b0:234:d292:be7f with SMTP id d9443c01a7336-23dede7d45dmr179425015ad.31.1752503715222;
        Mon, 14 Jul 2025 07:35:15 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4331900sm92953295ad.150.2025.07.14.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:35:14 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
In-Reply-To: <20250711091704.3704379-1-quic_rdevanat@quicinc.com>
References: <20250711091704.3704379-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v3] wifi: ath12k: Add support to enqueue management
 frame at MLD level
Message-Id: <175250371444.2067518.17555745608400098717.b4-ty@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 07:35:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: ulWaqC31iVKmIRJMAa5n0XpPAOftksQG
X-Authority-Analysis: v=2.4 cv=X7BSKHTe c=1 sm=1 tr=0 ts=687515aa cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KBP__w1C_Dc6RnaA_GkA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ulWaqC31iVKmIRJMAa5n0XpPAOftksQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NiBTYWx0ZWRfX4LAEtYl41B/P
 R1mFbcLgCt5+yhHkbZx0Xa4MH2aubwJcQtg0K2Qbb8JuuG397r3gaLTmeDdzSaertHOXpRLhrXg
 6L2BDqVJpxqQVmMWvtkKfC6D6/9K54ooduK+mNzL+mKb3CW5qi/y0vAf8wF4UnIUGb1GquK/1Dt
 YFYt2xsEclpCdMWo0ULp0E6eLJhkcPnlW5FD4Pr+zJxIrmkiXf3iKe4gDEo4WCfDJiTSAmxfpCx
 8opiGOW/cW/sCdy/+amlDXwZXPbBggch9ALdggZxniJlt8FDkNyTc32jPz88E7sYWk1ozY6cMwg
 gm97LzSvMXDlGsTGjS/qJdm0PvcGlzPYKCMzFJS7BirbiO108n84gVGc7raMmfcoABVpjua+CZW
 PcRjPl6AhAPtr6RERfi8Hc6/9UWQsQ3Q+1tHLWm2YelUjdVzOOJowaTpoCVSdF/gDkDN1wKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=915 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140086


On Fri, 11 Jul 2025 14:47:04 +0530, Roopni Devanathan wrote:
> A multi-link client can use any link for transmissions. It can decide to
> put one link in power save mode for longer periods while listening on the
> other links as per MLD listen interval. Unicast management frames sent to
> that link station might get dropped if that link station is in power save
> mode or inactive. In such cases, firmware can take decision on which link
> to use.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add support to enqueue management frame at MLD level
      commit: 9d2abd4162fca8a1eb46f664268dffad35c8ad20

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


