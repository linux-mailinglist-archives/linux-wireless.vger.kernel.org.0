Return-Path: <linux-wireless+bounces-18774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFFCA31007
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 16:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0295918894D4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B73253B5F;
	Tue, 11 Feb 2025 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCMgbtBh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929A125334D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288679; cv=none; b=uOqvxQw88B65R2BixD7rRuYGdz9SXft9bAWR4p66iryj7F3Msb71qFZz2gsUgU9m3pzdNUfS9YdCY3HCVlF2Q5D4TtPcPS4i3bRfEJJv8JeOibJMnA/WM6XjaxPFylL47pdakqu+ov+Td9RWkdmkp/XG6LvsEUvHiZe1Gt7HfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288679; c=relaxed/simple;
	bh=aYrOlTvgbndeptck2n5IxciwutiIcFQpNgYUMDpGdWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FnwJh37Cv7sekSRzu8IFaPtpa63sxnzmUaVGM1CmALJsjSTFvsPbrevNnWMJFTvsKXv0rC3CYgT5a4x/o133QJEclq+pY0eMKMaFVzieOPxRHCcPw57lmjcnUwXNTmw/elGUyctm5p7lQO5eLP2a3BuBmZYJFw67b5GW2TMjz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCMgbtBh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B8qGSl031389
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UlL5jzWhI6M1DWypiuTqms2s6pTVuYe03e0nspNkVqM=; b=kCMgbtBhnARTGY7O
	ZEnOMH7OasNrz2M+zmrj2Ef8UR2p9x6t2ESqUwvvtvdp/1a+iZO7m6qMJSESk9Ov
	H7uNgnZasNE+7CqljdAjkk+PtXzYylndHDzWu9oycwS8NnfFMFVAdoHQNTYU6pyn
	k5xmxbUJOFTfLlUCFyGoSDKACLl57cRl85JmNg3/pxxJCcuc2iKl0kRQ1nUk50ir
	V42GS35z00Y5QQJv8ClpyP72fui1Fi2Gzy6TG/lbp4X89f1oNUvNql+wNduQRQjK
	mhEvDXlyxdQLZAcghSwqUC2hNuG9goA2kKSDrcLwzFP0/9gIS23HrtL8KOtPGS6B
	gOEfXw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0gv07mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21f71b174a5so53270795ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288675; x=1739893475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlL5jzWhI6M1DWypiuTqms2s6pTVuYe03e0nspNkVqM=;
        b=Z5opS0xRTVE92NdgdV7uEFiwYD/V9JBFSxdNQkCxHMbdp4JbcoFxOIYTosd3j+/de0
         d+jQuIdOBX+tJSGcQO/LgBuR6TX0CXGkacegnZDwBL6G14d6wB7vhJI3emM2VYGiNmDK
         UDiVjlMpsIHhdG0b2aG9RifO2RC93fsOeAWZpQzxMmZQQDtSP1ZGO79gWKI7uclStMqV
         jppBII/GFgpXUSDdUHkpY2Yk9oZ+uZLwYYOMyVSJlCYrASs7HZ8ECmhwYvwkQmRpx+DD
         2ReCWjw9bDM03tFhCVc06cvDpQqVQRQpvDWVIBiTF7XiBZK5Bv++E/gUxg/HG1I2oxza
         sPVw==
X-Gm-Message-State: AOJu0YynlywYAoVi1BxrMGyUjyk5Fmc/bnnaTURjjcsSRURR07VeACYl
	wJEVLzZtbb5PQ4TI8RhplXNuyH4oKF+hwFs4626suI1BOlQpQCumU2p0fevlxJawFtkpTweHHGC
	9tduUWQqfZSwzRDup9A+16y+41hwnHKTR0WnVMQwCWALfsbjvYntkKjXaaqnE7sYnlg==
X-Gm-Gg: ASbGncs0rtx/7nBM2FndF/hGqtbkGoaBd+139M2FmvnT0emAVldgAQPpS9qmkE6VL8j
	/ONu8G8T7O1eYwKq30b6lRTAmMBlQtz0SVRRlBlXdkQff+lypnal0ME2FvPl9VcNg41ALMBCwNH
	DzSdLSQtEJ7IzzTfF8ig6Yv/L36RiM4Pv19tdCFINPeYPnCyeVS6OtPYdVd7brRBBzlVvW2U+cE
	0VRY3iqy6a75Ekk8rL+J2/GxVDP2BNAty1q4CGp3gmFacI/fGzuYr7E7nmoZj1rt3YqyDAXtqbo
	V7R8yZppSli5MWY42YwmE2d2oQrQkXdC4vWDBKGykg==
X-Received: by 2002:a17:902:e54d:b0:21f:3823:482b with SMTP id d9443c01a7336-21fb6f54a29mr65682235ad.25.1739288674831;
        Tue, 11 Feb 2025 07:44:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTHP3BuxfPO3ra/69YVt4iP5Bp7MokO6wGbhU+W5xVl2c/0maHagbygDnfGfVhI2DQD1ByWQ==
X-Received: by 2002:a17:902:e54d:b0:21f:3823:482b with SMTP id d9443c01a7336-21fb6f54a29mr65681755ad.25.1739288674397;
        Tue, 11 Feb 2025 07:44:34 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36510e34sm98399365ad.28.2025.02.11.07.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:44:33 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/8] wifi: ath12k: handle change_vif_links()
 callback
Message-Id: <173928867318.1115150.2680608610563068978.b4-ty@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 07:44:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: oLaRSd2iFRPA1aVoN0eA2y6UsXuHxyle
X-Proofpoint-GUID: oLaRSd2iFRPA1aVoN0eA2y6UsXuHxyle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=996 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502110104


On Tue, 04 Feb 2025 22:35:06 +0530, Aditya Kumar Singh wrote:
> Currently, links in an interface are allocated during channel assignment
> via assign_vif_chanctx(). Conversely, links are deleted during channel
> unassignment via unassign_vif_chanctx(). However, deleting links during
> channel unassignment does not comply with mac80211 link handling.
> Therefore, this process should be managed within change_vif_links().
> 
> This series aims to add support to handle links in change_vif_links()
> callback.
> 
> [...]

Applied, thanks!

[1/8] wifi: ath12k: eliminate redundant debug mask check in ath12k_dbg()
      commit: cc5faf08aa3afc6f60d7df1a0edf041c4384fc95
[2/8] wifi: ath12k: introduce ath12k_generic_dbg()
      commit: 80f816d07ba0cf80a9b6aa90a30af2b2073c6cb7
[3/8] wifi: ath12k: remove redundant vif settings during link interface creation
      commit: ab6270c4dec3b1a506291c3b0050230b32464781
[4/8] wifi: ath12k: remove redundant logic for initializing arvif
      commit: 8acc7ec53ac43aea8f49573b5a173570f308b775
[5/8] wifi: ath12k: use arvif instead of link_conf in ath12k_mac_set_key()
      commit: 00e4dc11695d48322780812b503314682659e98b
[6/8] wifi: ath12k: relocate a few functions in mac.c
      commit: b81c39d67fbfcaccb33a1fc5494a87b29f2724ab
[7/8] wifi: ath12k: allocate new links in change_vif_links()
      commit: 315d80be304ac1d47da38c2b0c85286c9220c23a
[8/8] wifi: ath12k: handle link removal in change_vif_links()
      commit: 81e4be30544ee7e8da80e9aae7acd69d3be6d05a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


