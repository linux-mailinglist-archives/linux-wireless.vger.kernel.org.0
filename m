Return-Path: <linux-wireless+bounces-17829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3221DA18F8A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 11:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DFA18817A6
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A7618CBFE;
	Wed, 22 Jan 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gfex6TOj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32406145FE0
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541052; cv=none; b=ec6JaoSIdZ1lbfEVGOlfrqCYyY4epNg5Ay61q7QLGoaNiVFWlM666pZX7D29hJMJvSMQ94f377fpdskwiBs8XdvQkD0MzRd8E89sHipf8I2t88YU508tZzs2R8fs8egFeO1waUvleQRtMvODRmsbu/P/vuryTOmuy4rDi3pzYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541052; c=relaxed/simple;
	bh=pRf1oWBSH+BeUs4cjxzcaoonU9tc/qWJ03nETRAvw8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ee2bbedV4gqkU/nPJ5KN3siMWs64ssZiiegoyY/9JwoyvKt578QTBnCEPNnttLbg7P1xq1HMdO6+MasEB9EGHDgOzkUF+Douhj0pYBbfd2KKPYgvd6jlg+hZlvlcx9RfC3plMMCF3mAMN0gwRnnlUVrSViZZx+g1/LVTNMCOpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gfex6TOj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M9odsl002864
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	29dlzNT95wwzkWGs8yh9/Nui22y01PiBArjf9t8ZTKs=; b=Gfex6TOjmHdhd1Bc
	xpdgH7lM49SAD9GO5gX/ZSJcGB1eGonPmA+8TqC7+IXmAH1oT1Nc0Jk82plcsHaG
	zPpTT8TusdMjnSnq13r22Bse8qJAxH9suMoZcuWu5kdJ2y5QxqENBNEDbQZiQ1Hy
	wt0mnLmbbDez9sNkKvVte0DSqlvr2KOrvFrQ/z2bM40LaVFORuUOw7w/4wha4fKt
	+ecxZ2eHqf+BdKcjPWHqYMDwXK/2l5tNMzMkxxLf3gq7w1ZH8wYG0G+xoQxs9ELc
	mYnRNkKCVuZHtLUoGX27zNj5W/pcVghr6Oqg98Rgd+XG1wNCCGxKRVXO4ZPKhZ7x
	ev6/FA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44axd8g2hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:17:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso12447254a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 02:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737541049; x=1738145849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29dlzNT95wwzkWGs8yh9/Nui22y01PiBArjf9t8ZTKs=;
        b=YkztSrRAcORPmEuSo5JwCOP7IGFi+GBhtHGJftB4dwhEbHBDxwGG/TC08RGYcQH4AL
         IpAh123gDCzrvAjrvQRkyGbvWjUWYkS/bZscqXZxzjehESTgqQw/SlQkhy6i0nYAQde5
         jRsrxhQk/FBWNtXZF8k8KLFf5LT3iIMYfWe4s67/wfUs1RDr9dbKDzq5L4FbvCUo3Tjs
         TQZTXgslk8E1T+uloG/Qb66RGX2ECkGl14CMmu8NlfzvjtMQP+RyG8glgezxUWxauxU7
         mBMNrUzmnt+JgaF4Auqk7vjrc3ucLrruULtI/lrrANalaR8Po9AWeLVK/Ai8sFrHBTip
         cVZQ==
X-Gm-Message-State: AOJu0YyytKPw/KzcuwTR9oWxmIUbdRo7+fJ6nMSnXEv7q75fif6cjkIJ
	dJu6/ki3M5TmjLft5QyxxT3oh1eECY0jHB2UFl4/Jy7WKW9FLeV8VFwm5l/6qVJztrU6OmY004c
	UMSwRkAknmICI1QCLAcxgggcJq1hGgsUpGSQC5E3IeHLN6x97hwtv5mk/j/WEboVSzLzP5KIDKA
	==
X-Gm-Gg: ASbGncvM7r+xYwL1LkTnCafeAeduZ5QpChaLnsHg2Wnc5ixmC9Nx3xZlkhJN1EN3fNq
	yI3MKf4Ss+TBjZCBTcVZtvicKeild/rORo2dRMy0hcIJtKd3imRHLmfP7RH9vXoR3UR12lZHsOP
	YzfM1TZMZsEsaoYssnMlNg4FXqC7TJR8LFs4tsJbe7n1wKEDp8CzPGNl3h0mDqTYWryAZiXjeH5
	xXm3oCBth4n9tb131KPdJFgDj+yDIe/DoDUqpTLxehT1WDwLktdgbDn6E8bZk0HY2mYuBXsxvpW
	WNA0fa4zj/vHQUcdtL3zA/C2WUpH
X-Received: by 2002:a17:90b:2b87:b0:2ee:a127:ba96 with SMTP id 98e67ed59e1d1-2f782d36030mr26332258a91.23.1737541049204;
        Wed, 22 Jan 2025 02:17:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrehCCwxqUjvfCI+Nu9dMOmWY6RxzQsqOG7Td7OY8XZRx2UCbAeYNU2aAEs8DJzW7OB1weNQ==
X-Received: by 2002:a17:90b:2b87:b0:2ee:a127:ba96 with SMTP id 98e67ed59e1d1-2f782d36030mr26332236a91.23.1737541048890;
        Wed, 22 Jan 2025 02:17:28 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a5e30csm1204993a91.7.2025.01.22.02.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 02:17:28 -0800 (PST)
Message-ID: <b111e01c-f375-43ef-af22-a5de6a6f5ea1@oss.qualcomm.com>
Date: Wed, 22 Jan 2025 15:47:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] wifi: ath12k: store and send country code to
 firmware after recovery
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250121104543.2053-1-quic_kangyang@quicinc.com>
 <20250121104543.2053-5-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250121104543.2053-5-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VbQKuMUI-xVckXnV0E92_48yqEyp1tus
X-Proofpoint-GUID: VbQKuMUI-xVckXnV0E92_48yqEyp1tus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=936 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501220075

On 1/21/25 16:15, Kang Yang wrote:
> From: Wen Gong<quic_wgong@quicinc.com>
> 
> Currently ath12k does not send the country code to firmware after device
> recovery. As a result the country code will be the default one which
> is reported from firmware. Country code is important, so ath12k also
> need to restore it to the value which was used before recovery.
> 
> This is only needed for platforms which support the current_cc_support
> hardware parameter.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Wen Gong<quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang<quic_kangyang@quicinc.com>

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya


