Return-Path: <linux-wireless+bounces-27542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36796B8CAD0
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 16:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D149662183B
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB74D21B9FD;
	Sat, 20 Sep 2025 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/kIlhJK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244B3BBF0
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758380343; cv=none; b=srYCwyWWdnAvHytVNTeIE/pUlCvP1CkmqhVTBsTbODwME8Nc8IlgYeyYXFK1ja+lmmf8p30Nu9spgacBNwh3dPdPgk9GeZAoUFoyqkpn6PIAjoic8AEKjHnXoNktjVeGcohwaksez9RTSI/RrKtC6DF1TWXDoa9wZr6my2wyU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758380343; c=relaxed/simple;
	bh=lM8aa04NeOEDVWTxhYvlgECYiGUl+cTlQT4avepBPJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ESQMf5TdHL+6CKN+kQLy5NMGe99L6sfGcDOyTgcXMECvAG2swgQP0viYBJNxDFmZswpPgNhiPYndNQK9pS236o4u9s1OCPb6H4MA33+i5G62N5sR/b8RLFqVwF2q3mWPsbE5YwVJ2ZG8+fEeyGlCh4W9oYHiZghnScFk6aVF2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/kIlhJK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K4mAVt015962
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 14:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KuVkgYir3XNP9uZ6/co9rkHLCCHI4sXn2YnlbaAk8gQ=; b=K/kIlhJK1mSytMf+
	vetoxUufgF4jqKlOvjhHPfsetuVIeBhqrEO+rL2EI5mof66GvWLzyHEJ38CEXBRk
	GqQf1f801Wxw34rIRMUPv4U/c31+DHR2LmNxEuYPpKHFcGQvh08ivfq2sOo9qMjg
	5OaHcCMnf5SfTrrbR/eMQlRcUrpaxNYEWvjbqLeB3XKjftiswUK4I4jQwG7Qa6Gg
	7NW7sAG2AY3dPbpZBkREhrGZer+XAIP4tSYE24F4p1Jt51eNvlM5XpIzAEOehuzs
	9jZcLbNy4Q7fy+28+rSbWS1IhY9NA2HeF9pyuxdXhabbRiG3iRe6IbsK+wEnBDxu
	oEBBAw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nj8rqse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 14:59:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445806b18aso35679255ad.1
        for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 07:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758380340; x=1758985140;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuVkgYir3XNP9uZ6/co9rkHLCCHI4sXn2YnlbaAk8gQ=;
        b=caQERuiRDEmF+x0uQfuDObAUIG2rN9l1CoS1q1pF2onIjOroivV39VSGixXvLFK1ON
         nLO/xkWq7gF1RUXoQ9PVFMGi//SOqfKEDf7EsC0IQ7+rdIJJo7X1FfSfVaoIGNLCYsKr
         /oZXd8nWuhKkqrCjN5Pn1CzXX68DW8MgXK5zMdXOPrMwoIOxvESej+22gjFr9GwFZjfo
         rRF1c7htZH92Aq4ATZjTrhcysUuBDdOr/muFQdCyPLwUStssLFJVkq6APMUEF8dptvvX
         6i3Zbv+xw5qnBSfZt86KunJNrkYOzTlwKQeOQwjptOD+Als07hKg+LindbTJlJxJN4zB
         UK4A==
X-Gm-Message-State: AOJu0YxtLcLi7urxMAv4VoJjTknSsJ0pz3/0ruDT3qnI6C7lcY1e/p2e
	9/Je/LzfBxlEcsGS/KPl86Csro6AL4a1i/dz0kCEHgloQ1DPshHYR5Wc6ft4CbgbZRvtM/KWXNk
	b3yBxJxodZxdwvYrVCgn/BD6YrgCLCAItemC+ztxFHj5aoBBYenMezUUR5x5IOlZjPKQt2g==
X-Gm-Gg: ASbGnctIxwaXuCxYQrak5IzJQun+e0Ha+7mCIzB4qL1lfdIVT4GO0e2fTwfdscXNGxL
	mbvshH6X+F5vqeQR0Doq/VVQnqQ1cO/5em9uzS+i2J3JRxhfoalC8NFvc6rJbcW6JbxwSRaTDcM
	T4dSk8xZ3WhjzpxQwnJllBdGT4VjGvcgJom23Yjx4fA8F+1NqqgJnfKwXNKSVm0Zn3NYnjUdueM
	Wy6s+oLNSYxFRrmSp11QfKWsblrxMAYfZU96iyEzb9iRMKu2Oa8bgIid40qSxe0hXW/lYH2QeBR
	OH1Fg8MobMHMK52cSXF0wmc4xSk+b8L8dbFlrsyK3BgRNWKf0B4qdJLBncS9NpHCncX/p7qH5Sk
	1
X-Received: by 2002:a17:903:4b04:b0:268:14d2:8748 with SMTP id d9443c01a7336-269ba51ed09mr85839905ad.44.1758380339893;
        Sat, 20 Sep 2025 07:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEErKisgrpby1ggUMDrrdDWa6JrHCex884ZPc7njT/ykZ+AHrYTPGBfwvt5J/jMfiVxaR/xUw==
X-Received: by 2002:a17:903:4b04:b0:268:14d2:8748 with SMTP id d9443c01a7336-269ba51ed09mr85839685ad.44.1758380339387;
        Sat, 20 Sep 2025 07:58:59 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dff50sm85198925ad.85.2025.09.20.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 07:58:58 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>
In-Reply-To: <20250724040552.1170642-1-aishwarya.r@oss.qualcomm.com>
References: <20250724040552.1170642-1-aishwarya.r@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix peer lookup in
 ath12k_dp_mon_rx_deliver_msdu()
Message-Id: <175838033844.1001242.7090157541392245370.b4-ty@oss.qualcomm.com>
Date: Sat, 20 Sep 2025 07:58:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dZ6A3WXe c=1 sm=1 tr=0 ts=68cec134 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=K65mQHiRMMjqrrAT7w4A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Gcs2QvR7l6DmsQqNpv33GjIzyheY-RBX
X-Proofpoint-GUID: Gcs2QvR7l6DmsQqNpv33GjIzyheY-RBX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MyBTYWx0ZWRfXzeAuwszPgr8A
 sZ7SE4lm54ZWJQcIJU6T7DCh52WrVBLDwfzMPgmz5dc2FIbXJ7vT3PXitZDDDkSesoG35jjzgzn
 wssxDliqfwugft0hPXP1+cutsK5D3tFaiYFc+39zICb4WSajs1jcopdmSor5zyhP0W0/LES35TX
 qQY0cWrrDuctMKpVE8UejZrtSoZ0lUthH7VeEkp0ThgIHbKXfK1Hj41QEQsM2URPla3K+Ht67CU
 A9Q/BpOP4wftUcUchQILMmaCkyTjCOSLnc0/tzcxuj3+19Yz646av3K1/GhUuFyXjGOlS99MgeB
 Ox+hW9LHr4ljyHFORAdVHuJCoHmdIArQdxqiQYdlPKFdZii3CZGFAs3pSMEavmAMRPSCOaQTwI0
 arMGh9Ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200043


On Thu, 24 Jul 2025 09:35:52 +0530, Aishwarya R wrote:
> In ath12k_dp_mon_rx_deliver_msdu(), peer lookup fails because
> rxcb->peer_id is not updated with a valid value. This is expected
> in monitor mode, where RX frames bypass the regular RX
> descriptor path that typically sets rxcb->peer_id.
> As a result, the peer is NULL, and link_id and link_valid fields
> in the RX status are not populated. This leads to a WARN_ON in
> mac80211 when it receives data frame from an associated station
> with invalid link_id.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix peer lookup in ath12k_dp_mon_rx_deliver_msdu()
      commit: 7ca61ed8b3f3fc9a7decd68039cb1d7d1238c566

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


