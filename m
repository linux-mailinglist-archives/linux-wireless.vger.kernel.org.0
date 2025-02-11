Return-Path: <linux-wireless+bounces-18772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 595F1A31004
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 16:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69A118893CF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC81FAC37;
	Tue, 11 Feb 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MiTDLtZE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3B25334D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288675; cv=none; b=kZkhToy7waBATs2GA5W9cZb7oot3H2ZPFemLGstFP5zWCbpwzlbrQsmwiq0JFkPnJFPYO+xqX0S5IvMw1DwV+Q7JdqkDu+SljaY6Cg4K8hJqGTNUJ6TcRFUuRClW+0viSL8CJtP2aNZo3pPYNO44GzNeVsCCaum35h33br/nni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288675; c=relaxed/simple;
	bh=c30yMjm4lcEtm5IorOjlfP0dFViQq9cxHsDN+oNwG8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Aw3T3hkOJW4sU563HUinbhOMoTMqSYOOckbYclumb2e5OqPAzq3x7L2CagzmuWP3ufLQGBoh6K+Kw+hdKEfmkh+hchIT48wQDCetPBdeoM0yoBU1j/CqfIO+kzE/E43OAJp0i6J7Wl7n/+ZgyXnhjS/ounxAgmd5LjfiFNEy0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MiTDLtZE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B8wcQa008240
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8DzeVdd8SF7qpz7tNPDYXF9vs5orS9avpQ/i2+8qUWA=; b=MiTDLtZECIkzvuaj
	IY2uM6Ozbq/6rayw/7V0urJdxNP7tQPQ+ZdLwgoxudUxGBbr6zTorwcIvyeoFnlw
	yLMfBT87BjCn/8TntvBFm0af2G+z8LayMHCpCFin1jcVOlgGAOvdZAEnvQ3lg0pe
	GSuQDjrPB7M6p+uFCYsS9jYZD3azACxAXz0cAONkaamK5bCEBzn0Iw721bXOChzw
	65jKTA49jN4Pj79fH+TDGBSiGs/XYtNUizf5ggjAvzr5vqvIAgiZ9o2ts2fnGdxk
	JWVGD1EEkwkMwO8OHO8H1c6AoJf/u8x9nypiKjLWRzZdXcGHYCp9QFY8920HtpYY
	R9G4dA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qewh4jj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f6c90a8ddso99324545ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288672; x=1739893472;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DzeVdd8SF7qpz7tNPDYXF9vs5orS9avpQ/i2+8qUWA=;
        b=No4r9jgCrFAk/VQGxDQZUvxHodWcYCfbRpgtPILMHryTapafVoE8Lw4IVV3ppAAAIL
         BOdlDijs+GlppKcDApJs6WwYMKa8PAL96xILgb4ovWenuqiwnT+DylvWuQGWffkOY0LZ
         GQ7ZVBGWX52gzkTRylQyYCD4b4YJzKJk9X3kabQjY2sq8ky2aRS64zptr05CZnAHmrlk
         HxsGMk0dg8YQ3AP1vg/5R6xyo56dTlFW4+g0LyNu6rngR5+0w9flL9rkjqxkjQxx0LnF
         +VID03l6/IRra7DkTh/+gY7enqCxHWPKvDCfdsnnzJkH5d2q9a26cASn4v47duGKczKj
         jCIg==
X-Gm-Message-State: AOJu0YwRfMymTTIm7yS9Y6sWFaVE31zVC4AHt6y62ZDfwawuQ/JN/Mhp
	QwYEpiq6mcys3W2nHogdljupAgdQm+ffu0Fkcolg0Eik7PmqE++ngPa8eLMO3ini7zMu1CaBzIf
	z68H4urz/hmn4ajFSsjrOhiTbMUGn7HhMWjTbvP+7qcixrDsXVMsOV/7rG/1jYfAPJCUPp+/ktg
	==
X-Gm-Gg: ASbGncuQXtvvl1KjeMOEwpnu81u2xVRYBteRxxs0dZ4z0kFfHPJkUDgo+YHMg9dhHot
	1ajFh9p+XzLbX33tLgSwCeUoawc4yvGEPED0gEFyRArshBSndNpeEa8EzY6kSxUsuHvI7UrcBQ/
	IH0Lcfjy2uWTRzbxAVe67OkiT91X2FRG8dP1D6Rg58REvSF6RJ8Vj6uM2pIlUzmw+BVC/dmAPfW
	6YUiqOOblO2DDRm0oIlZvGnbDv6kHqozwIy2Q7Yi5ku3yS3kcR3B2i7EcIAjdkfephC9gGXKneL
	wwx8sAhbm8U/w6AjYpGgwdhqoUEHc7CesxEriKWxrg==
X-Received: by 2002:a17:903:32cd:b0:21e:ff3a:7593 with SMTP id d9443c01a7336-21f4e6ce751mr213191025ad.6.1739288672196;
        Tue, 11 Feb 2025 07:44:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhXfdgSN1N+xai/wCFwf8W+v4OhBNN5yiWqW9rRXxcEBRo+A1d/Oc8cj1YkynjHO2uz8c5dA==
X-Received: by 2002:a17:903:32cd:b0:21e:ff3a:7593 with SMTP id d9443c01a7336-21f4e6ce751mr213190705ad.6.1739288671797;
        Tue, 11 Feb 2025 07:44:31 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36510e34sm98399365ad.28.2025.02.11.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:44:31 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250201211301.357985-1-nico.escande@gmail.com>
References: <20250201211301.357985-1-nico.escande@gmail.com>
Subject: Re: [PATCH v3] wifi: ath12k: add support of station average signal
 strength
Message-Id: <173928867093.1115150.16269929738374915560.b4-ty@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 07:44:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: qQZGFYDHmyWSb9UCLsSR-mBclqE23Nxa
X-Proofpoint-GUID: qQZGFYDHmyWSb9UCLsSR-mBclqE23Nxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=766 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110104


On Sat, 01 Feb 2025 22:13:01 +0100, Nicolas Escande wrote:
> This adds support for reporting to the kernel the average rssi. This is
> done the same way as it was done in ath11k. A simple ewma (with the same
> parameters) is updated with each rssi update.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: add support of station average signal strength
      commit: cb53a6785ea5b0a14e7e5af4322bee3df266e949

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


