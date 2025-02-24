Return-Path: <linux-wireless+bounces-19376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD6A4275A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658DC188FDF1
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB1026138F;
	Mon, 24 Feb 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J63qAXq0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF218191484
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413033; cv=none; b=oJ3i15RbtxLcwnGrO3W8An2cN+xPVGigw6AgMggTyKQirfOlxqetDoDM+2XUIwQNf7F/dNSv8tihvcqJm+ZckqFmnTmVXJ0YZyye55C1Equqcu0MGG3v0B5lEe30rlu8QwO9tktYCw3icjxeRbJkiMO8SjBXw4lEvY3XaAH5sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413033; c=relaxed/simple;
	bh=A4CX+0klVMAICEJyIyrIjhZS4y8aE1UdHjBGou04K80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kY1WI9uTwWghHMQ74gpX4GT8B/k/N5zJjuL3R7azoOOY6zmhAf+oOzYbfQzRcXvjzWoNDZsDn3MfnvSue34aIItD/1Tt+WCuoQJ7DvndLr22v5iLN2XFNwEPwTqJB/zSeabwe8Guy7MLOKAEmuXojK/2bF915qR9OmwmtISF5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J63qAXq0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9SNai013750
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 16:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eynNTv2kSQLvrbRGLtm4NlRxri0pSZCgwjP4utbEpcQ=; b=J63qAXq0KWbKm+mn
	wpkL0g89XPukY4Tiv/mitwM1Ks0FVBozSbS3SESNXhbNMt7R9VQUI3VIsuuKiDeH
	3H3+1VhANJ/V34hHmbsctEAVwC6eCAGBcsbe4QbJkY9uxt1W3LJdgzK46bXfgMnd
	ww/h6rwws2hxDzykx0TCy0T4+4Hs37wzmO+pLxkKXWXR6ZVs4O1Ljb2yep+ZBI66
	KQ4L4GkBWxnKHFcxwxvIB6wNMDoJ+f3QI0+bJpbryjSWQQpOtTTI58ZAmKHEJGyX
	n2/HqguXcXbHb/MCK4tMgCxaMvRnyiYlzeX3QqTvjIt9XGFwb3seha0VmsagUrxY
	KcM8cg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7v9dmdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 16:03:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fbfa786a1aso14785025a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 08:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413030; x=1741017830;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eynNTv2kSQLvrbRGLtm4NlRxri0pSZCgwjP4utbEpcQ=;
        b=ZSMdIHl4dYLYNK/Ju2MLwahGH4SGkHwsGyIv88/EUtraiH+ovPEp5JyqUYwE2J6x5v
         YRwTCT3kkt4Nqo5zK3FYVirwEFgcZZIHAGrFio7i0/DzRE/rNa1gYlaevHrBaF9/dZzn
         aQVV052DQphxVUAjhrBrIceL1fir/QqCUuFMQRN6Ay42dkU+xZkJY64zwXwkIqMOuWD4
         BhAf8rAO/kcGBd5WI/MLL/gim1k1xdmXyde28M8QtGfgzavVL3qlaiKKVNEC6IbqeO4j
         56zn6hOW91ZBDiNu0/2yooTJsTSvCs8/cXgStV4HLuavRMi82eZcZWlE6urGwxPYGd7k
         4QFg==
X-Gm-Message-State: AOJu0YyCtCyszoLr5uhdpdXTPB1KNuT++ioIGwNRqcV2t1Ji38daAYpP
	KAOpjGEU1Yj/LQBEU8Zg6W9KhjrbueG1eb1eEhNLwGY1aVFIxGinO+GodqvOV3LHlJUpS9tufLY
	+Kj6gSWmjRbUqUaOU0BxbPhNzS7C095rmozLFRTP15SPccJQqX6cfcVHPCk9L6F/UFA==
X-Gm-Gg: ASbGncsP3Jvl+Tt46JqmVHdgtPlHuK3PP2YIl6X96GYtBm0JD5Ebqa6Habt0QfmnFMD
	aBFDjXxxPrG79f5Tk+mQlsaNGwUoiq1CgOotdR8sCxUPmsD9d4ojZE2j9tWukhlGcbgWil9vjdA
	/k0LI73ZBGC1qVV60Av5GTQ1I0jG2Vagt2aZS8D1Pq9L9Xdcd6BGHK9//E9zAxTpqLEZq5poEnS
	lEgnStY0RERBXq/sNw/Q8TZn/TfnpcLTMsWhLaHYsjzEoaOHKtowpPwOz2xhdw5lpjNWazgVkuT
	NAHaZvdq8r/YZjZn4Cv64e7JY323RPFas29v+1JwJtjHuSBJsocd
X-Received: by 2002:a05:6a21:3949:b0:1ee:c7c8:cad with SMTP id adf61e73a8af0-1eef3dc67c0mr25988136637.28.1740413029866;
        Mon, 24 Feb 2025 08:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnsEg74MD5qB7ynWgwL7w0k0hcOFX75F1wbbBIKHXR2yGnkdSpsNpO5bmnxb0aQ2hTXZtqAA==
X-Received: by 2002:a05:6a21:3949:b0:1ee:c7c8:cad with SMTP id adf61e73a8af0-1eef3dc67c0mr25988088637.28.1740413029420;
        Mon, 24 Feb 2025 08:03:49 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7328371e36esm14470744b3a.61.2025.02.24.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:03:49 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241209024146.3282-1-quic_bqiang@quicinc.com>
References: <20241209024146.3282-1-quic_bqiang@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: use link specific bss_conf as well in
 ath12k_mac_vif_cache_flush()
Message-Id: <174041302874.2901106.7386807697655031327.b4-ty@oss.qualcomm.com>
Date: Mon, 24 Feb 2025 08:03:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: gWj6Vcw00S6FZJ-Obk0GI0vKvJwlNvrI
X-Proofpoint-ORIG-GUID: gWj6Vcw00S6FZJ-Obk0GI0vKvJwlNvrI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=732 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240112


On Mon, 09 Dec 2024 10:41:46 +0800, Baochen Qiang wrote:
> Commit 3952657848c0 ("wifi: ath12k: Use mac80211 vif's link_conf instead of
> bss_conf") aims at, where applicable, replacing all usage of vif's bss_conf
> with link specific bss_conff, but missed one instance in
> ath12k_mac_vif_cache_flush(). This results in wrong configurations passed
> to ath12k_mac_bss_info_changed() when the link in question is not the default
> link.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: use link specific bss_conf as well in ath12k_mac_vif_cache_flush()
      commit: 11d963d44c77261d6a948f3745bbd678eef4b83b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


