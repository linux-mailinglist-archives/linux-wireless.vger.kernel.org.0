Return-Path: <linux-wireless+bounces-19295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D68A3FD6D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 18:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7D43A49CC
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8770E24E4CF;
	Fri, 21 Feb 2025 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fFjjFPlp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE341DC9B0
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158577; cv=none; b=jeWP1MwDHouHazVcEzfqRjkRPjlLuiRmtw0nmElY2N7pfGy1mNF2nOhY5wpx10IvJkJLMlyyVMnUoYhtXUhJn6YTg5bwcv9Xn5F9sLykWfvkffdH/l3SKzOVVDJ5+hgl3APkDN4UHwHXZqNuELonTylRG7/7JFyhBZwzXvTe8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158577; c=relaxed/simple;
	bh=qZbdMly4Ho+zVgVxpzNrnV5EpRsS2r+fOJBW0OW8xcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naB7JOyBoyHNDTKOW6pR0G/hrkd7PMI/3KtbuQlUZ9bMGut7X8es4Uco9NGH23VID+7On3NbiefcmQTlHFlOgvQzOcSrvfBPeD/8FqmIU6ZvvWm6hZJ1zEANNxUXEYwfQ1tsvBxN8g02GG4rm+E4w84LG44bXdz+JOurYH1HNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fFjjFPlp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LDHFME012007
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 17:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GNdBoEHvxBFzNO6vpQe4gdIHhXk5m04IrO8nlwRBJRk=; b=fFjjFPlpOQ85UMMM
	j2dphzdgeULeHZXDlC3iedXqjex05uF5D9Hph0mevXdTLN4DJXXxep9AUp0NFSe1
	A11sz1DLNGilJdhLWqj7nIDO3jaR8P3jY1Lwv13OlVjcTOINY/Y6x1jjyAMjj4Xj
	OGfOng6lG26urhJqIqtrGYbeNtzRW+hAtC5ToqOP/L8XxS49PdDMNWDL09Yq4ssw
	g7zeb11+nY4UF8oby4dnec7NS3jzHfXGJmPagW0ErJMy7+dkf2ZrRZy0JFHhA4Ry
	rMZbzZs/BbGkxlN1yj5G/loRTxfbRJdZwr0YxxRh+YIr0LsLiE+hNfROZP2iybjm
	o891UQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3tpj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 17:22:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220ec5c16e9so50537475ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 09:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158573; x=1740763373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNdBoEHvxBFzNO6vpQe4gdIHhXk5m04IrO8nlwRBJRk=;
        b=Dyptp+AV78lKw4gusl6Nx7xfSe6lrTc3dCTxImbeZYtvIeW/1EyTL6blS+4gfiGE2Y
         souq6dR2XeeG5PIgmKrxCXJ/h9rIyQAMQe4UVOT07JNAztxqEs/dR/xKHd6pd0g4K2BH
         JQ8uMPbCEZPAcLryo2nno0X+ezfds89V8PIkoJ8aBrVrj3kAcy3VNU+JBOYnQL6HdL9P
         7RZpyGQkXX1um8NwQ23RX+GQ8ScQNNdJKN7w8GWAOUGepuAEKMZwRHMZMA589R+lHHwL
         QTyyDmYM7IczZXqjnsEU7rpJyARwyby0qZs8fKWg4VwLQ0eUfm6chzau03lwXoX7ITvh
         J2ug==
X-Gm-Message-State: AOJu0Yx8fhB76yS2iK2Phh/GruKVS92etDHhBp/qOf9VaAB5DaQl/lUa
	ol6yL3IYFibFRoP0plGqAhntf/BNizDa8v0Tbq898mEBxg58CKauKLOWvgfqGcAIr1r0qFemkaS
	o7WZSkiTLqswokOpb+BJkHxmOQkZ2BblooVCKgMB05W4RJq7sjYMBRZMyEqB7Gbxhjw==
X-Gm-Gg: ASbGncsvAGyUYNyAerxX+3z35UiH+W7nPBVMFfNACPZUyamAiJrIS8UHLWLPngXzsCv
	RLt9gXaz3ur+WtB6sG9YdSIsyxlu0esnztEtjCfjGxHAETVmRSA5pfK5Wqvc76YKiV6LTi/S2DN
	tq7LyleogmvYeG+i/V129tfthMVaYRlhkFxaEiIf/PrQAC1TsgTdZ/YSur/8luxEXk9w9/Aett6
	/CNq+2KOpRUPuFVMoJY3iW0VazE60JSrEglFqVFD2vDnZTMSH5A2MHSigUISmujP5DDqClxTpB2
	kx/7NmecAmwdW44bxup5kc4L+XrrhktdX6Ijw/pWBUe+q3jyF+IHNTYPcVTp
X-Received: by 2002:a17:903:234b:b0:220:bf1d:41e9 with SMTP id d9443c01a7336-221a10eca80mr61061155ad.23.1740158572302;
        Fri, 21 Feb 2025 09:22:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwPI7LayseX+6iIIqLKHSdYu/noBsqY6us9RNj9QmJWtYnVluVQPiWnITlZi2Mfv0sLclRJQ==
X-Received: by 2002:a17:903:234b:b0:220:bf1d:41e9 with SMTP id d9443c01a7336-221a10eca80mr61060795ad.23.1740158571929;
        Fri, 21 Feb 2025 09:22:51 -0800 (PST)
Received: from [192.168.225.142] ([157.46.94.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491f7sm138809515ad.38.2025.02.21.09.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 09:22:51 -0800 (PST)
Message-ID: <a2874f49-6725-be71-7428-a2e910c2001d@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 22:52:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 7/8] wifi: ath12k: fix NULL access in assign channel
 context handler
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250221164110.3277222-1-quic_periyasa@quicinc.com>
 <20250221164110.3277222-8-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250221164110.3277222-8-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CMmum-AbIx5EunN_j8xl9d-oTVYqwViQ
X-Proofpoint-GUID: CMmum-AbIx5EunN_j8xl9d-oTVYqwViQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=832 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502210122



On 2/21/2025 10:11 PM, Karthikeyan Periyasamy wrote:
> Currently, when ath12k_mac_assign_vif_to_vdev() fails, the radio handle
> (ar) gets accessed fom the link VIF handle (arvif) for debug logging, This
> is incorrect. In the fail scenario, radio handle is NULL. Fix the NULL
> access, avoid radio handle access by moving to the hardware debug logging
> helper function (ath12k_hw_warn).
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

fixes tag?

Vasanth

