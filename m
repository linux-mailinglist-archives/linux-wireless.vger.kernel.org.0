Return-Path: <linux-wireless+bounces-17172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CEDA04E22
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 01:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EF9165495
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 00:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACEC1CD0C;
	Wed,  8 Jan 2025 00:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TecTXHUF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC14DF5C
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736296350; cv=none; b=Q9DRgwBHeaE+KGsrpz/hAMYeagT+BLnw0xOgH+cP7oH5FmfRxBQvo+G5w/ytzPSRJYGl/RdDOImewH7quwZv6ut3S/DucCoXZemnh/tM2Q2LLFvv++4x5IMkQQtOEUEpPZC+VyBFp79U2C8FznJZPxrSPtHl62ISqVQcUpqQD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736296350; c=relaxed/simple;
	bh=qGinmpshxzpyk2bd3TLM0BUL9yVd4oPvf/GXl4rTtDE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m1Bdz5pt4pUNJSbsqhvwmgi+IWZGx8Ho+HiXErcjUIUs+lQsgnLDkXkwb7ddwvOnGtSOTmoxJIpVF1BB4YU0t6sLiXxhBVHs9+30cPldvXCmuEPAZqaaz8Z9DV4D80jNONf3qSeWFSOzWm9J4us1TSCpgobWsKcOxfDl3hmMuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TecTXHUF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507KPmXQ002831
	for <linux-wireless@vger.kernel.org>; Wed, 8 Jan 2025 00:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SHZC506u+hUh7w0J0fibA9G0IOLoYOIzEU1XTx2nqU8=; b=TecTXHUFbUEbiI3i
	RiMZLN6Yy0GsVP+yAYfOrnfLzwpNDu0rAHKewes8tO+iwwd0JWdnyUNems/hsYSn
	+r/82Dav1S3WJjTmwtj7WO82uzLfZXMkNX7AeWaAUvzsMFZpuF3lfvLC/IqXUgzG
	ioGRtr7b+8ne7zNkLzJX8QXsvT3Skf78BLl6OnK5kDlp0jkgRJ755c09RnFHp94a
	FkJrhxALkLGc2sG6he04uSPC2clSdFvw4qiU5dBWfczITJrlE73kTL4UTPTXaSU8
	uPXYtYu7lys+qZf9uhTvblaIbBNTUhyG60R4jjDQ7aF1CBdjEtkSBgr25ldnCI72
	0C1Jjg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441ba00d97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 00:32:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so24231546a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 16:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736296346; x=1736901146;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHZC506u+hUh7w0J0fibA9G0IOLoYOIzEU1XTx2nqU8=;
        b=dIX6PUiOdgrdq3gymYUbtZw2GtWOOD4iK3SzBDjrOiBTMKIRqSu5ljohuLVvX21Z+4
         VrYmaeQBAQbj/LW3GsYLmlwluz3t+6FQ6V9lzI5EgqTArHdifbpD06B6iujT+mgimkSM
         9xTkfdC1Nh2Sg7AEG17U+E4LW9I4N4wQqZlx6+psBj+MbT1eesERWLHSV05nyc6mGYYL
         MEUP8two3hjG+stw3gRwepgQdA5i3tAhOOji2Af0c1aQLQ42MtIS/hT+4pNzT8ziEH70
         qXa2zDpm4qEnxaRlAPN2ADNJCKWdlx7hFp3p9Pu9uh9I67RkIhRh+JNQHJEf02aJeyWz
         YVHA==
X-Gm-Message-State: AOJu0Yx6k+jJG0dL5Y0hg/ASnZw1lFXAK0RqWgqUhmOoNifn0jazp1n8
	FxH9rc6BvTOrQ+0Pg7w1EnnUDmBvQ0sumtFNCbcgtUMXPbD1R0kHzWUIszFOZ8SsVnh9yKEuU+I
	fdULWC+AKzDXtsiu7dSBN2JNLJ5OCeRnjl3cmt/0vAwhLQzN5Di2RO0gjKPwWSana1BNTsGZJEQ
	==
X-Gm-Gg: ASbGnculpbYx06d0m+5tZQLl6wUIjs/SsT2opmB1UNr7MLGP7b/7ZmASukDInPLLhJk
	X5GS8WwmXci3gbdnpDNZVtf2m2LG5xkzammP6uaacTuijro/IdhTX2dNpCucnSIh4rHa9Y90eyA
	JHUE+U5jKSgo1YXZXFocgVk+Vp3NGkIsvNbvE0NxatmY0nV0QY3BaHnPy6E9FCDa3Q28WkD8G6c
	jpnKT5NhWY11QtfqKAOe2OUY5QyD5UIny/Rc8pwOQ0U3HMOIw/o/igUSs/YOItSEwQ5fi5XStQg
	3C35jxzSRq69f/2svQ==
X-Received: by 2002:a05:6a21:2d85:b0:1e1:bd5b:b82a with SMTP id adf61e73a8af0-1e88d0ddc13mr1904484637.40.1736296346328;
        Tue, 07 Jan 2025 16:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPOTCX/byWQDkHCv+jtV4uadXvSKxjOr4UID52duVqTs8KLnoWGJghI0xdeNRzWDdVMiPDPw==
X-Received: by 2002:a05:6a21:2d85:b0:1e1:bd5b:b82a with SMTP id adf61e73a8af0-1e88d0ddc13mr1904454637.40.1736296345889;
        Tue, 07 Jan 2025 16:32:25 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dba83sm34041162b3a.116.2025.01.07.16.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 16:32:25 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241218040149.4041728-1-quic_rajkbhag@quicinc.com>
References: <20241218040149.4041728-1-quic_rajkbhag@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Include MLO memory in firmware coredump
 collection
Message-Id: <173629634521.3079396.5486696104815389604.b4-ty@oss.qualcomm.com>
Date: Tue, 07 Jan 2025 16:32:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 3Kek3E2PQ0YOtlwCbgYZSNa_Pwj3OJWj
X-Proofpoint-GUID: 3Kek3E2PQ0YOtlwCbgYZSNa_Pwj3OJWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=922
 mlxscore=0 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080002


On Wed, 18 Dec 2024 09:31:49 +0530, Raj Kumar Bhagat wrote:
> The current firmware coredump collection in ath12k does not include
> the MLO_GLOBAL_MEM_REGION_TYPE memory. This memory region is essential
> for debugging issues related to Multi-Link Operation (MLO).
> 
> Hence, add support to include MLO_GLOBAL_MEM_REGION_TYPE memory in
> firmware coredump collection.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Include MLO memory in firmware coredump collection
      commit: 9035756c18852cf39eeb11b625db094a2c9a4bb9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


