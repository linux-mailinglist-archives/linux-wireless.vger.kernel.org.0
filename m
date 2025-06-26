Return-Path: <linux-wireless+bounces-24585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F14AEAA60
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E311C27A82
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27A246326;
	Thu, 26 Jun 2025 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8S7ldVa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395052356DA
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979724; cv=none; b=OcpWFCEiE5BypqHlNssqKSSNLbqTsi87a7Zmi+iTnWUfH3DMTIuyuBFf27L4z18SZliAPbNa/VZk1LTtRxwg0fuMQa48coiSkuuj4t+b7hdt7NafvwvJ6hMP9TiKjvaQA1Zq/xpXQnrLfqMViU3pyJEKND40H2OSC7uqpuZmhPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979724; c=relaxed/simple;
	bh=w2sT1viLmwGuVerrSHUizrAniEsd9n83pLlCmClHrBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CwhgV1myUo5Y6yzvpGwhHtloGAk1enzeSU+1U3BNKzLkYNZ7Z1FnjET9UQ+/gr1eRmx7WG8+DJhFbnMEgxVUFb7Se9yAu51D9Raxy0rCHwzwBJVODpKnbbL/gFAA/1usvCF6GVV3E+2TO5VPnuCDv6Yu7I4e1K/qd1VvqE/7xqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h8S7ldVa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QIIeMX001592
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NCmAE4vAUTYfqGxjNQ/L/Y/x4AK5ePy9reGNlC+lbEU=; b=h8S7ldVax3fWwCiR
	nXaNkcZO0ZF0qpABXHMcusLat2JevP6HzrT2MGV+H2JZkXGP3e6GU5To1rVZeYFy
	GPOX51C4XM0BEOwIlFg+uRzscrTZG/KayXTYHa/5GizBB53ZBSTM+b1n2dhnqW4k
	hEBTjkzLe20ZGjhhNKdQWiBSxPY8tU9NDv1BBZWBnPf+jE8F0uR1SXv3MJwqluxb
	OBwKWc8n2dqO1ipPPCz+2ZlIUUuJyiHS5XgbASzNOHEJNnQRa8QP4za811jO+x82
	NwojnkwU5FLNI8N2PUUjxnSX3M1hdmXRkFnrDzBU4m+69si/xRZ3L2FAMS25P4tn
	qHyXIg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rq51x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-315af08594fso1536040a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979721; x=1751584521;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCmAE4vAUTYfqGxjNQ/L/Y/x4AK5ePy9reGNlC+lbEU=;
        b=YafpdKzR2VeBS92ZP1vCGcavAiax+YofGCcsyN7ORqCe5r2J1pyHN3+AolXZGruXfF
         oJY64HWCsYofYEqMZv30T+GeJQzvEtscNX88TEJ+ibxyTXqkHBNhq/CREE8KH1ydgNuB
         4QjfDzg29yryBOUYkhpcTmtP7uT9qvLQYId2Uk1yTuMQpSzloZYASZxcTVoLzx6HeE1D
         VBU5aTGY5uPw+tSmKpo4CgukeB9ffTWzofxIQLPa75mcLYupr5SvgNat+HhQNHZDKloP
         ejEviMsYjTqeSVi9SIjpRyLyv5DdSVh4+1k4yzhClkdqZB+r37GSV9NBf5FRLkNDHiz0
         Bimg==
X-Gm-Message-State: AOJu0YxYQEajPshcozMG/+UtxLqLc168UbadYWoNd1vG8xMtVF/+NoQX
	QZO4+FTMuKWA1iifSxJ2WFglT0tVAdO1z8wA/Ity7drN4Eu3UDkDENyudej/jhLRa7ZG3/BVvl9
	9QpyIxRYosQGyihW3SPVjpNp7ZBSgg/AuZeGfAb6P8UAFgiY1LdEthHPDJWpiQhB9BV8aJ/YcKT
	tQ9Q==
X-Gm-Gg: ASbGnctE5wLdTaPpup4+uqGZHah6sqHoZ6Rpo101b5U6g2FDutRcdrgbRjvNPV3nw4i
	yPyY9UVCx4gili5Lta+zzQiAG8S22eN3N1tox+PKkuo8DKPJ4sL7nqky3L3/PRwGtAwp5UEptU9
	sD55kCW7ZvoX+EEE7Lk+aLbRXqHh9HIlXSTTO/g6i69RuOJZp4oIzf4eURahcNRHO5uaAJ60ZId
	XsgUDbmK8WMjvPT83tdMM9ehIQ6Pq54gEiZbsG5gCLTi2kwS062cUudjkx+JaiY1WG7BqOsDgHK
	XRUMDuS+izZ78g/zYG1bGm7UjTc4GVaTzYxumNxf9nOhpQ9RZtcimXNOCow=
X-Received: by 2002:a17:90b:3c50:b0:311:ef19:824d with SMTP id 98e67ed59e1d1-318c8ec3a7dmr1314715a91.2.1750979720622;
        Thu, 26 Jun 2025 16:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzktJw/3vnYkuK0cx+q6CNUeuzwTkm3RxbcArsj4cl25qctu5smOg1IXkjMzGzn2AWIoteyQ==
X-Received: by 2002:a17:90b:3c50:b0:311:ef19:824d with SMTP id 98e67ed59e1d1-318c8ec3a7dmr1314647a91.2.1750979720016;
        Thu, 26 Jun 2025 16:15:20 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:19 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
In-Reply-To: <20250608145651.1735236-1-ramasamy.kaliappan@oss.qualcomm.com>
References: <20250608145651.1735236-1-ramasamy.kaliappan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Clear auth flag only for actual
 association in security mode
Message-Id: <175097971940.153431.4490704491841906367.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685dd48a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=iL3hp5CSDfIOlDBT6hoA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMCBTYWx0ZWRfX2LilzAU0L5J2
 dMQ4xfUaUJ8++znDa28/8q2Qu5YJNsI0SclZDe8iZZeNAwt7sAGbzA3F10uJEwPR2gh0VLZHbbE
 0M2x6X6rksGLjFNuh/aEM5ASD2dfnsAORxBD+gSkR6yguq+2v4ACxT4ugAyX6vFWTdskYTzKTqH
 TCRKmZSM8vismvbmwizfJjuUaZBxVpwNyw0ZM+DqJFVKY9HIGLZ0Y4+apEJkKwQsVHJMaCQFMEQ
 64a4KU5oP9NbgJb0q0VtSS47SIfIoXYX9KGR8rqMc/P1IdhQNEwLPamovy7u3p0w6T0hCEmtKLL
 hGOeqpD8vRXYOgXhYmpXiCumpwvlllRQZWt5J8NLHcECh4kSQ4TnrY5/1PHI0MqYMuEgc30/OM+
 T30CXlkAfevxmyI4s3Ep6caeaYbqwrEspi3nC9GqqXV3q9tAjhSVhsmC49JXIxlHZG5rJJIw
X-Proofpoint-ORIG-GUID: MlHTAa8MHsB7FW9lHG-FJAHQKRGxTR1X
X-Proofpoint-GUID: MlHTAa8MHsB7FW9lHG-FJAHQKRGxTR1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260200


On Sun, 08 Jun 2025 20:26:51 +0530, Ramasamy Kaliappan wrote:
> When setting a new bitrate, WMI peer association command is sent from
> the host without the peer authentication bit set in peer_flags for
> security mode, which causes ping failure.
> 
> The firmware handles peer_flags when the client is associating, as the
> peer authentication bit in peer_flags is set after the key exchange.
> When the WMI peer association command is sent from the host to update
> the new bitrate for an associated STA, the firmware expects the WMI
> peer authentication bit to be set in peer_flags.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Clear auth flag only for actual association in security mode
      commit: c27bb624b3d789a337df3bbcc020a575680555cc

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


