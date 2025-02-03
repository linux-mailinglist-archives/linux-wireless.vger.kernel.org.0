Return-Path: <linux-wireless+bounces-18329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6033A26721
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 23:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5212C7A2B69
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEAB211707;
	Mon,  3 Feb 2025 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iERl9I7t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDE21148B
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622956; cv=none; b=fuK4fPhrX0mfQWey4bNWFWvJC6tp2oqpskxcg0Jyk+/b7MmmjA98MpF89gBM+/iT7RfZ6n+7JCzIGQD9ZSXSBItr3kBTBXEu3H+3GbEa8n0pd3PLSSWpg+yPiY3Iq5gCqdnVEl4G8g2uWLyyGxKCBO/qDpbCEISU6Lf+aIf9G78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622956; c=relaxed/simple;
	bh=UR40eDZZfbS3hbWGxqmAY5ipCXv9NhG9r3dDTNP8BWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GbfnOgwIn7Gic2hMqfDIqtVae9TlFoddI5B8VzcX9o6k75yzHGCmrrJ8VFK4akbdexOJ8EGmD3HGS55kUw89GtWv4PJMWsnpe9dMF2oNFFfnAIwZSvap1DAJHXxoo3L9RlRTSXUorCju9njOuGdqewv32Gi9ONzyZ6b61nXN+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iERl9I7t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513E5RRj002342
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 22:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cC+kaSqb9z0xzblfws8rbMuSNRKdorYwo/RDOvwQwEk=; b=iERl9I7t3gKofhoJ
	O6KsY21MAxrk7KtEq36LQxqWJUF12uxeccnuSPoXFpbl+soJnpp1bOySSFVQOtw9
	pkkh8FkGw03SwMUeqTKeoEz1J8b00TR5HJJYGtSUzjXJKQCPBuTvxWl41KaaeiAz
	X4XB96TbaDepT92JHsHaxvJyJu/TwXUATdHqxsiDbb04FMDRr+yQTb70bnIVJeOc
	Gb3SpxTtB9qi9fJ0i/EhbjqgQqeIVPbZxft5jiHoOb39jThFWUakI4Z5nynEgYAZ
	PDZ3ikYsoVTadLJBKbgsXU2vGNEPvmHk88htQzhxdiwnD7Veer6oM3kHEWkvn2lF
	VTS/3A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jy8s9444-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 22:49:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f02d17cd0so1811885ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 14:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622953; x=1739227753;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cC+kaSqb9z0xzblfws8rbMuSNRKdorYwo/RDOvwQwEk=;
        b=b9vEyQU8NCBMsfWns3x0SOchRYfhOd1BSA/kmW5e2H/UuHOASi1i/qa/uHjX2RQecz
         f3vikNDFRVoKZQ8u/zHKFDXSO0gXqQKb8BvNpHn0uhvToQwk9ym6K5dGFeWPjyaOAAM9
         Vn662mRgogOi8rNK5TSVftDXJyayfNPr5Uv/UKJ+x+kLI6kFpUeqmiVwXR9oMNRd6ihb
         f0ng2uoJuHFyR2jirKvsGNA0porImu0fU5Lg7ZfgNs4lHnPfbMUweRuAZpgXhaX0OjjX
         UBBkJCNSDS0XTqlUXQfbUqH/EELhsSjlkagZMJ3XFocK+Kq4v4NjdBFjOjjoPCEDyOTH
         e3hg==
X-Gm-Message-State: AOJu0Yz2tT4AfwZib9cc4nlhW7qZgK0CjfukszjRRYolrCpURxUrDLj2
	BDzqNRidfsO+8dnQAB3JaDPBlDQhp+VWVb8ytQ6IEuL4EhG7c9ZQPtqK7yee6kK7lFF6iulbaGR
	YRssY3CxGIyz7CnS1dGNnZyHfet73Lmzibe2VQPziXfqhNKNSj2UQyAnJ18weYRsH1sXgiw8AHQ
	==
X-Gm-Gg: ASbGncs5mw6dpdGc3bZ+a59Ylaog5oD4abRIn+//i1CUmSO5s3Vy1G20l6r6atv8Egk
	ymtZgNtFMelghN3uVimieqvXQhPTW557yly28TryIPD3DF13VxwZnF3UdwtjMMnyVu8+scpYEGE
	vfZXexgKO/MRmf0dARLQ0L3f7qpMul0prHE23NnuUqhpdfRCTOLVQIA3Ox0zscLThiy8imWXYK5
	wVxBI3Oz91aElnaVyBb+/cv+D8DoI9jH4KXPinAiGC59BDnXqqtFYXH2NoiCWLrVoWrsHRDN80s
	vhgYnf1oN4XYqsJDvFUs9TyTmDsgIpRV7uXCpsmnRA==
X-Received: by 2002:a05:6a21:789b:b0:1eb:7da4:305d with SMTP id adf61e73a8af0-1ed7a5fb009mr39240592637.18.1738622953276;
        Mon, 03 Feb 2025 14:49:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO3Bx6bSrb5h3bYaTWAUX61ZGQeNKnpq+AiKFZIJxlCeznLlrxT34+upm1lidcaJQyMF1MfQ==
X-Received: by 2002:a05:6a21:789b:b0:1eb:7da4:305d with SMTP id adf61e73a8af0-1ed7a5fb009mr39240558637.18.1738622952905;
        Mon, 03 Feb 2025 14:49:12 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba353sm8887444b3a.112.2025.02.03.14.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:49:12 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250124061343.2263467-1-quic_yuzha@quicinc.com>
References: <20250124061343.2263467-1-quic_yuzha@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: add support for MU EDCA
Message-Id: <173862295228.3734728.3310219521875555203.b4-ty@oss.qualcomm.com>
Date: Mon, 03 Feb 2025 14:49:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: mCklDyhNazPLwbgC-FnYlBzQRgjsjy56
X-Proofpoint-ORIG-GUID: mCklDyhNazPLwbgC-FnYlBzQRgjsjy56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030166


On Fri, 24 Jan 2025 14:13:43 +0800, Yu Zhang(Yuriy) wrote:
> The current code does not have the MU EDCA feature, so it cannot support
> the use of EDCA by STA in specific UL MU HE TB PPDU transmissions. Refer
> to IEEE Std 802.11ax-2021 "9.4.2.251 MU EDCA Parameter Set element",
> "26.2.7 EDCA operation using MU EDCA parameters".
> 
> Add ath11k_mac_op_conf_tx_mu_edca() to construct the MU EDCA parameters
> received from mac80211 into WMI WMM parameters，and send to the firmware
> according to the different WMM type flags.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: add support for MU EDCA
      commit: b78c02f7c7104f1e77ade12ebde267e6fb388ca9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


