Return-Path: <linux-wireless+bounces-18779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30F7A3100E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 16:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED641687EA
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D625334D;
	Tue, 11 Feb 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PeLkYXZ6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403F253F25
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288686; cv=none; b=H5QHE4qFsLVz0zSu8I7RgnJLDl7kpQShVAib9Uco8aCraSwwXAvYIasqM7UXhxla1MWgm5BFoPHBInxHt0p0Kun4RsxIcmCzhwDMOFigByNCvc2KC4jYGIXY3n/WBPvY79N5w40qfpt5o4WRmmNIRRabatL4qPhqRNTPZJtADos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288686; c=relaxed/simple;
	bh=iaImjDck9fMCG1lVze/USMlL5xLf3uVy1HiQRHdLJPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rLIZbjbvuYwcjJc08cwHtmwLi5W4no1XIGUaKGThZB1gIaGgLb09VBN0n/E3PgYW/oZwdKgGHs6xQHc07VBGQHaXorCRNg7aFyxiRasyJLATFvMkeRUeNs/pwwbX+0p6Opf2m0CFdsAViF1JWjIvrGMMex7uCFS9v4wHcV9qQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PeLkYXZ6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B9Ljol016767
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SzAKm0ncGdsRys3hE3TVA+b5Ix0pqeJlflqEs6F5i04=; b=PeLkYXZ63QGyaStL
	2oyi03f1hM20SRkSau8JV8GI44YDyaEEFlTSCwRHvAaBNev8c12LNqwIg5R9hAzj
	tCqr3Xl8gKnaN3bqnYYb9Mrr6ziyBVkkbCKOT0vePPeaAc0ljeCCw44h8AYmlWxr
	Eaa+djdA/aH6wzEkAXpjZ0FTUkLQQzyrhj0rzskQsTn8n2Z6nySoNVgj0px/LVBq
	okvPUWNwF4Xjw9tRo4gOto1CeD3wialVTjmHyG/oRANOI1M/TYal1rM/6xb55pDR
	8M7WhCAWbH7Y9AuVLhzVhd8rWRtB1n+Sm+Yaq1FG8XQGvuNsOzcPhfAABjbJJZ7H
	NlBBYg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0gv07n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f6cb3097bso89918065ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288681; x=1739893481;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzAKm0ncGdsRys3hE3TVA+b5Ix0pqeJlflqEs6F5i04=;
        b=QmdBUYpxY8GH2YBlrz1+e4oSnUATapAoBblfRpoeqSUACwbMEMQ3O+wKOEtK4/3DRh
         MLbbHxlcCBWkqHgoo3LmRtZlqIgOf5V80IIShxSgdDhkYkGGRfde8wXOx/JNGKJy0jWQ
         IDDcfT8BeQBDn4HHDX6XX/EQi2bk9hZOtM1rK+BKFlidGvBkAzCfHpPnOHob5v1yA305
         NIiWTKmiECrtJVAxIVgdGUQAOq2GYgJAEhvCIXkgF80H6AZ6XiBO/MGjwEkkG3QQG8Rl
         LU5iskIFt9ndmnFVKtHGCuOFSamBeObE0oCCaSYFe5zEbI5Q9qQKV8absk6/++TAVP4W
         es+w==
X-Gm-Message-State: AOJu0YxGLwZpFHKLYbxeP4u2vPZ2soYKF9xg9g2Z+iN43kn6axFILS5R
	I335+5NJgXvjq1rugE8DQh/fEEuwFUWfzxevTM+Gz1PXyoJ8JBkGOaMpve+TrMa0uTtKiESSu+q
	7E53ypBQeDTIDJrZzstOmtbhWe8U4OkgFx6U/A30qmnUBo4BIbBiqVFCZStZcZZpnhXp63ECDbw
	==
X-Gm-Gg: ASbGncsbUWgVyAfbqiFQDlTomXDYB7gW1EnuFabUKXsHewTvQbrdEnWViImAXe3d/ZJ
	/uqdaeyqEovPptRd9VrjOg2yObBlU761jvhszy7RpSF9iK8ofbn1IuvMEr2lzwIxZdx08UZi91o
	qM3Yp3LAgfBsmGY629kPs1phfyRkaH7QB0mD9Gy8pTP7Lwy4p4F5a2LPElXLcJRQU6vn67D7tF/
	r8Out0MU+lR5iZPhmQwsbyfQiUSKedEhCG/dtG2sdee6bho25APU2KE08M320xKYWJ15fDzfpjm
	47sKHXEXSmO51zW1PgaAAZnNyXbTxRtnsTcNBTWhqA==
X-Received: by 2002:a17:902:d4cf:b0:215:6f9b:e447 with SMTP id d9443c01a7336-22073cead3fmr2562325ad.30.1739288681043;
        Tue, 11 Feb 2025 07:44:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZPv5IZQ5SfhwVLDLlnQOxxEM8AfTMWUD8+LJQm4I8WYh84SgeS+02XQHxBpTTryqm9NMNYw==
X-Received: by 2002:a17:902:d4cf:b0:215:6f9b:e447 with SMTP id d9443c01a7336-22073cead3fmr2562105ad.30.1739288680632;
        Tue, 11 Feb 2025 07:44:40 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36510e34sm98399365ad.28.2025.02.11.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:44:40 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250204064417.3671928-1-quic_rdevanat@quicinc.com>
References: <20250204064417.3671928-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v5 0/5] wifi: ath12k: Support Sounding, Latency,
 Trigger, FSE stats
Message-Id: <173928867986.1115150.15654166485225346353.b4-ty@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 07:44:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: -z3-WcKfVt3FQ8n2bTxfMNNJgfj1cJ7n
X-Proofpoint-GUID: -z3-WcKfVt3FQ8n2bTxfMNNJgfj1cJ7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=964 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502110104


On Tue, 04 Feb 2025 12:14:12 +0530, Roopni Devanathan wrote:
> Add support to request HTT stats type 22, 25, 26, 27 and 28 from
> firmware. These stats give sounding stats, latency stats, trigger stats
> for uplink OFDMA and MUMIMO and FSE stats, respectively.
> 
> v5:
>  - Rebased on ToT. No code changes.
> v4:
>  - Squashed patches to avoid build warning.
> v3:
>  - Rebased on ToT.
>  - Removed patch dependencies.
> v2:
>  - Added line breaks where necessary, as pointed out by Kalle.
>  - Modified the use of pointer arithmetic print_array_to_buf_s8().
>  - Modified commit logs, as suggested by Kalle.
> 
> [...]

Applied, thanks!

[1/5] wifi: ath12k: Support Sounding Stats
      commit: 5c1963119b82b369b902091502a2135b238c9793
[2/5] wifi: ath12k: Support Latency Stats
      commit: f7c5e24bb1918677f7d6195a8825b39462e0a9fc
[3/5] wifi: ath12k: Support Uplink OFDMA Trigger Stats
      commit: e669a18b20e205dc51a71a07bd3597f123979751
[4/5] wifi: ath12k: Support Uplink MUMIMO Trigger Stats
      commit: 1dbaae78e7f23819eb75f4ba8a4484e43cf625f9
[5/5] wifi: ath12k: Support Received FSE Stats
      commit: 7b19d5adadfef791d52fd0412a75ebb8f9f27a6b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


