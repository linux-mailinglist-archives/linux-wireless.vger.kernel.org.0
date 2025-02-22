Return-Path: <linux-wireless+bounces-19320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25105A405E2
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 07:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111CA170E7F
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404601FCD03;
	Sat, 22 Feb 2025 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UmMvoP/I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62A1FAC37
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740205420; cv=none; b=PLyHylqejwRb9UEDKXGOaFou2Ppsu5c4nzmHq/q+GxICjUIrY+H4ze6mSDMkNLyXQb6Ftz3WXA/tUvnfmleIF3yyVQx53Qy9ZBJClBwOnM2kyrCpVQhu6vnHcdbi0yIFp9bJuqDmyt8Y0djo8DOkclVivOcHrds86X+ZWQLMtNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740205420; c=relaxed/simple;
	bh=W/2Ug5yPQWoqX2uSMClXt1luxjT0elF8IY5cuW28oZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiCr4LmWdJEuQxMWyKTh+AMNT5SoCJC3H35Gm8i92otoGAPCy2X0Nv9e9BRW9sHWPutPpIIgOv98QPuWdcgoy0Rd9DTtRE9IPJ1GjXtMXFlQwdosYQ6MdsTEaSbp3qdBZ8lH+KWlZvRcwfy+bRGTFkPFeVi7CnvGt6xiwvZhs3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UmMvoP/I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M4neoc030688
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 06:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lpl5ZoF02efgeSliCrYre98MXqIsYsG4xatxHEt7Vr8=; b=UmMvoP/IJjp8u7a2
	Kt3dIQvFg/OCEVTxN68QvqhX+odHV2YV5ObxPqshpnuRxTsnqsvDuGdaC8e8+2Kv
	DDXp0no7Dq0usfPKWlL+uoo/C84VUZuUIdVGMLg95vHg3ag700xJTUeD3JLogQ2M
	5TCT7fjO9238iy2iYTdlfpWID+zJheJDvgKhCDdlLPiWXEU9nlWD1R3X642WJrdX
	WLsxh4NzBkV09J4FYnovB4XqORfPSG3yCNXxZRRSRiEdtxaADcr3Pggf2tS6dlHh
	VVmwD4WHxmBUQN0HKJKlY8IumYO0zrLHfFOVlPNjVVTBwdc3j3LjOrSn9YkKnYML
	Jq5FJg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7v983m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 06:23:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc2f22f959so7709739a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 22:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740205417; x=1740810217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpl5ZoF02efgeSliCrYre98MXqIsYsG4xatxHEt7Vr8=;
        b=Nm/4OCSERHnFObM185TWtG3wEn5QMgtCbgjVxnlD8Y8UhdFcRL93H3Ee/FWOpncxmA
         /ZOxNuAjk1iIXPumFDonkQkxTyibBQpY8e+8wlPYvJKWpfNnzywTBEa/0bsNuXVDgscY
         FtaKdKhzlDIyV8cfGZkhlpwmM2POMpJmFqGmgQ4dxE9YqK2b/8u1geJ46ioKB41LIuq9
         DOt3K1MZHKt5peyjhpOMGzLCxPxN+DYsgIrZZUFtdqFkQd3WcgqFvAOPoGO8PiGrGRzY
         6KpHKnwVhvkcYeiunQhF4qieuPD2leQOtL029Ym2jH46TwmlvoBBCoEnRVHs7nZnnCcj
         u+uw==
X-Gm-Message-State: AOJu0YyKNx18Nc3GwZ46Pvrgg0SJtFxjkPWehMu+XjkpkUCeP67Scg/V
	gouG5cJxfqOnhWvBIgRLKOWPKb8fEh6eI6jgtr0cS1pn/lWlUFZLlObOFAnGd8EyU2lzwGpIMNf
	+vMHqeDXL37YZUITQAXtfvwN8mLj3dRkKs5e6imFqDI6jFV5tX0ZqKWDFa4RzyTrmVPNN7mI9ng
	==
X-Gm-Gg: ASbGncvrGisZ02qe55ZvFInYgyFj6zgDikQG4RCc7qafgTo5EmILKW3QuyXWa44hvjD
	lkN+DIPtQBr7Sz2zzt3exZvoexV2DFp5YmiTHfIsy85exvBgaPS9mnlswFQhz1ZjBVLc4MurCRX
	h82Dkcjepad0BPL+vfoLyOTwXXMujoz39+/Ahelxas+AZjPCIbld7wdPOQF0gHlZZqlmzGpt1+K
	kwHRq9htbWktVpf0tAktqHf/w/335oQvHiitMyoaiYJYNVyuuQ7WSInCM8dLw8QJFrD29G53kCV
	HUSutzcn0HU5jpxtL4VxnfblF4pExb6KYs96v0Ty5zDCTGpi3zSRadgsvBRB
X-Received: by 2002:a05:6a00:8a17:b0:732:6a48:22f6 with SMTP id d2e1a72fcca58-7341410bb54mr13760448b3a.9.1740205416692;
        Fri, 21 Feb 2025 22:23:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1LLr0yF54wR1AauJhnBWfC2bAYzXb0vOq4XHTPwhsjI8+jN7Pit9xBCrL9RD/j3syf/+zPQ==
X-Received: by 2002:a05:6a00:8a17:b0:732:6a48:22f6 with SMTP id d2e1a72fcca58-7341410bb54mr13760428b3a.9.1740205416287;
        Fri, 21 Feb 2025 22:23:36 -0800 (PST)
Received: from [192.168.225.142] ([157.46.94.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73255f4c0d1sm15087024b3a.62.2025.02.21.22.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 22:23:36 -0800 (PST)
Message-ID: <ab394d15-d4b2-3dbf-53f3-174a6ed4e70b@oss.qualcomm.com>
Date: Sat, 22 Feb 2025 11:53:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 8/9] wifi: ath12k: Refactor the monitor channel context
 procedure
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250222033002.3886215-1-quic_periyasa@quicinc.com>
 <20250222033002.3886215-9-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250222033002.3886215-9-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KkSRsV-Wk2vGYNnNsXHw0G25ebAA9mTm
X-Proofpoint-ORIG-GUID: KkSRsV-Wk2vGYNnNsXHw0G25ebAA9mTm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_02,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=845 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502220048



On 2/22/2025 9:00 AM, Karthikeyan Periyasamy wrote:
> Currently, the monitor start procedure use the iteration callback to pick
> the last available channel definition in the mac80211 hardware. This
> approach is incorrect for the single wiphy model, as it holds multiple
> radio/link channel contexts within the same mac80211 hardware. To fix this,
> change the iteration callback to pick the specific channel context for the
> given radio/link. This approach makes the monitor start procedure
> compatible with both multi wiphy and single wiphy models.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

