Return-Path: <linux-wireless+bounces-17435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB94A0C0F4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005D23A2C32
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5AE1C3C17;
	Mon, 13 Jan 2025 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bCOZDHhR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7F1C245C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795177; cv=none; b=s5QOLp9zf0R2ckqmzyrawkLfUc4IMwlrL/l6tkG2TK41JACF/XU9FFvkWoaRr8CJ0d/fgvXi+Uf04Ezgj4r5o0qm0gtfI++iHKc2Y2RUqHQY7Hb9YprSF1fzq8K7g5XPWbYMHW/dKrf4zTp7OriSB1qq3rbIc3ZLbeyQ6tR+/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795177; c=relaxed/simple;
	bh=VuTi0i8w/336nHSerV1QPi7WHrJZu8tjcb3Edf18Uc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuWroxoyNTuLIrupbUE2z36+zb3NVx436BxsNNSVc3LxMskLmNhxwDwoSBaNYg5NB0y7TDrrEZMp/xlWZ9sCySOlV5C65gGKK1myipzK5sfQ+zQTra74yscpgl+PnJSibEreqNynaZzxn1t/QkQHD7W43lEDErTPRzcULlaKRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bCOZDHhR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DFS4i2023230
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NLTcoE+VMXCCGxqPcej9L/vrCBnQDEflE4ZGobqOCPk=; b=bCOZDHhRZQGEaByk
	qes3l+6TUZWtrYvmBxrYPDVT+Bh6SBl05WvwaCXxu3Yt2vwOAyyT/IOKLQpddryk
	Sb8ubU97evsx+/48fVvXeEOaagkBv4xgIVEpLMs70pe2IuyP9QRrtGXxWpWgmfsT
	t4zh6R9ZF3Uovhj7HhOhWqAl6EhSIMF5m53a4R28hqRNybRvur+aDEfd5paM15kh
	j96IEN4t53iN5UiWimn6AliiWXwGEIoGq4YYtvAc4PbjMuJC3DY51qco+BmjG7lX
	PPq8w9u20Ng20bqYBwPYWJ6ZdM9YJjo695nZKCwDyQe+iKYM5njUbODSWg8PfCKs
	1ibcQQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4455gfrhmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:06:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21661949f23so136061165ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736795174; x=1737399974;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLTcoE+VMXCCGxqPcej9L/vrCBnQDEflE4ZGobqOCPk=;
        b=wHJwAp+U8xKQ1egpHzXmwYsc6YL41WcHM3xoz765+LKkcuNp3+jYt/7yeZXrHe8m4f
         EW7Y2Yzd8a/c+3r8EXotO8q+yCBxz+AACilnpty5LsR46bESInAnpdtpUrY8YFCfoKQY
         B6EqWCNJWSmgYZKjbbbaXJp5HHKa+Lf1tmIg5CHt5ubX7dQ9rtQkGluVZy0H1HZDuN9t
         62Ce3hoRmNl0vFmk2d/fk+wEDqPE1kX3SLzm6gngstOaJWKtZz4z0L+2ijVookxLpfLZ
         PRbMt5AQmZHmmnaY5RpowxGX9ywnocTe2K0FQRwhg/xIrKYTyoDWx4UmIJ/lE/wTXcKs
         M5OA==
X-Forwarded-Encrypted: i=1; AJvYcCVI2UterVWn2bFmuGNsbwWGuSKOb50RQTHq88vlQ4rAlR3pWRyJuc6tRiMxLvzn3IGeaKs4ck2NCjtYDK74kA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw58WY/m0iLwcwTLrDj8KkZR31F/zpxxiYHj62hmxWLalzBTwSZ
	lJ4Vkx8kbOTDdYPfAZUCgWiCM5RvwEYboZ4Y6Q9d/oyTmH3OPJ5aLzMgkjCtE6ftJeIiAFy05hq
	QjD6HV+QOkLQtT3rMtNuNG5GZXclVuVYwVOQG3Nua6SOx0ffAsMDyI84YZf3xSQESWA==
X-Gm-Gg: ASbGncsUTCa8hZ/AfHJZkTucYfTYbu3tuL48VwvAS7F/gHp4rBDLphIAJtBuxflTMYr
	ec5EZ5+dgOOMmac3gSYQqrKgBW7VXZkzTY5x7ctGsoidiGDIRw8BcW4m+6uOcCxQX/7yiZVT+rk
	tQ/t4Dq5MwqzW9TJmWxRDV1DSTGrEytJ6E6qcRp3UZlUsQJK2JiLSS9MbVCVzkQfIrBN+UI9Czv
	4j0kv/YwNYWA9CtdVyA5W/5L2SXHLlrbl8mtc+kkvNR5q508waE+Al47a7IdeO5hN9TohFqxPVa
	bStFa8NjDr/wqDiKQbStb7aF74xb/3WW6g4HhbQdLIQ/ASS5oQ==
X-Received: by 2002:a17:902:da8d:b0:215:6816:6345 with SMTP id d9443c01a7336-21a83f52430mr342206635ad.16.1736795174373;
        Mon, 13 Jan 2025 11:06:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeMax9I6qKpzBQRg5CFiWdhyJkcJ6xzUNwIWCsJGltsh1GaKBMXyzu3MAx1PZ9GVZ97CZBqg==
X-Received: by 2002:a17:902:da8d:b0:215:6816:6345 with SMTP id d9443c01a7336-21a83f52430mr342206095ad.16.1736795173831;
        Mon, 13 Jan 2025 11:06:13 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f234977sm56568955ad.204.2025.01.13.11.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:06:13 -0800 (PST)
Message-ID: <305d7cde-adb6-430c-bf6a-e0034771ad9a@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:06:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] wifi: ath12k: prevent race condition in
 ath12k_core_hw_group_destroy()
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-1-fb39ec03451e@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-1-fb39ec03451e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CxN8IsaTRD0K0vE8Rw-a4Fv40dKBC6qR
X-Proofpoint-GUID: CxN8IsaTRD0K0vE8Rw-a4Fv40dKBC6qR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=914 mlxscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130153

On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
> Currently, ath12k_core_hw_group_destroy() accesses its members without any
> locking mechanism. This could lead to potential issues if these members are
> modified by another thread concurrently.
> 
> Hence to mitigate this, use the available mutex lock.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


