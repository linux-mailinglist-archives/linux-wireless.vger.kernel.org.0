Return-Path: <linux-wireless+bounces-21796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F219A9561C
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 20:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625FC3A8E2D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A43F1A304A;
	Mon, 21 Apr 2025 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZDIniHKn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737E1E9B2F
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261093; cv=none; b=r2SXwI0/PJOyKeUemujNZ6+8Wv+TyV/qeze0itWeV5aLjXzNxXRTSx211IGclhVkqbdd6toHupi+dhRe19FNLAfUkqIY1GgcSzAjg4yGOYjIUTXanwKqHSZg9HVyRhPRCAOUmof49AJS+PlPxxJVEz2eEDsB3LLhusISuBTTA14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261093; c=relaxed/simple;
	bh=4NTNZ7kRwuNfDxpSzwP4LyO5D/370ZD8+egSjrKvECI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrXDXVMfSR0apvk17BYuOGVKwgAlbUy9tXO0f16mu4nMUhzN7WG56sIO7a13ip6V03EE1eR37uCTwlW8FXcc/XsVfzCkigHfdWCwF51zLmk5QFoFGylhTxxtARtE7sV2Sap3KhdA6ZD39rtG6Ya0f5bCcj6qBstT+79Ofrlw0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZDIniHKn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LIgLui024690
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 18:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UtRScXxIHm6oxt6nV96BNJpPBcZBVBaxFiOva74/L34=; b=ZDIniHKnxVIunbVG
	SQU2BDP1upbXg5y+6qmUDGhoPvYsYbSdpoeYBV0dZ07C/NMfWzXNCK1LJUHuMBUN
	aQAdI/IL4fh8MEveL39+rQ2mC+g6o6VlQusA7cbBuWZReJM2EcYPOfiMrOdbwq9n
	4KLk+UChODRUsMlvoWo27Z44d863pjWxzH4JcqsFhszglTbu5i0AF45HofFzYlGt
	7ec0aV/gIIFuERCmuGLjtdSGIO8YKHT4QJomDuqNyiQVJXMNZdVQjAViIQpFcZtS
	7TL4iz0jxbEkdpV77SAhT7nTS2+aSgKYIWCKwZYLVQmcsOCz5reGRmCwZnCSOwd6
	a/ATQA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4642u9d39d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 18:44:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b073ef14fa7so2440745a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 11:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745261089; x=1745865889;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtRScXxIHm6oxt6nV96BNJpPBcZBVBaxFiOva74/L34=;
        b=SKic7ZaatcK4GzPecdDSUvannIMomBSkIoMghULyIFT8s+fFqtfLwTNijkDEBRb1qT
         6QnC4f9Zjbd307k3t+sFOrAViCDJ4kumOMGDloXSiVkkBfbeEEbU0HgEQSnpPeLwJSKf
         uSyQO9zeSCWQw6fSYEbzW9g5wmTTZTBImNL3ldpCNXRiSKi74rg2sDwUwjLo5raqSI2x
         D02A2YXyaPY7AXAYsdUCvQTwiFUGHzbVvxW3Sn5S+vKQFKKh7R7gGfTDP9GUetJnjmxc
         bQ7jlQBY4nfTtGlCi5eJlbu9DbS46PNgkQDj28HfkkXdLx0rSkzG6itxRXjHXS2Jacrn
         7Fcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpG8ovoDcGuWoXOL/IUsr7WtkOsABPGl0XL2he1w1Mdwd3av+pcE1mwfRCU4NU6mW1/DEqet1YFzE7Ug/83Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdFRe4p5MINfEEeS/m6VMyUwtbH6UjIWqV3ONbS9GE3fwkZ/Im
	tJ7wLII739mkjf9wHciG7/LYEy3HwgpfUTlJp7t3dyaQILx1zyFAe30hLbK28xOvPSznVtfj3NW
	Pb4mp/fZiDwQA3qds/yxnlg7fE8ObaeqEoCD4NSNHmHnWKVhFoySXcy511M8I7o3vSUduqQxgaA
	==
X-Gm-Gg: ASbGncsV/bcNfAhPQ+ZNRqk8fCmBZ4hY/s40K2IUUKaqC52SG9fRI/qPg7BDsjdj+a+
	rfrQznQho50oiAslqeEJjsaq9fhcF0c1OdyQlbmTVKaMC/lCDQJVZuLXg0JwU0TEPia5NydRB+y
	/vHPib7hitlvK7Ir1hqYAyZpOH0Xe3RZlXlBdMd+cxOGoonqj8SdAuOU4STkjHEAPXhlnfZK4RW
	3pmXKUL+mE6Zg38rZ9P7ozRdDFaiAMpUDwPO/HSqZC3bJHOvyd4hY71zGY8X6DEW99BZSoLVrpD
	LW7CL8cCN8KE8f8wz0izy3YmAB3hfMmrzaQkBBVL21nJTioxOF8nO+ljshMa7+AmMpJ3j++WeMi
	4Ib67
X-Received: by 2002:a05:6a20:9f09:b0:1ee:e655:97ea with SMTP id adf61e73a8af0-203cbd60a89mr19672752637.41.1745261088713;
        Mon, 21 Apr 2025 11:44:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA0pK6tF2JhEK8ouZupmBtQFU+yOMOxYbB5tNIrlUqNDVEr9iX1u+Kx1ALJ2l8+cvsKSayMw==
X-Received: by 2002:a05:6a20:9f09:b0:1ee:e655:97ea with SMTP id adf61e73a8af0-203cbd60a89mr19672724637.41.1745261088351;
        Mon, 21 Apr 2025 11:44:48 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0fd23599cesm2989744a12.59.2025.04.21.11.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 11:44:48 -0700 (PDT)
Message-ID: <47ea4e64-cd87-4c42-a20d-f663f197e44c@oss.qualcomm.com>
Date: Mon, 21 Apr 2025 11:44:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to be
 installed in hardware
To: kernel test robot <lkp@intel.com>,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-wireless@vger.kernel.org
References: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <202504220128.2KvxCzaG-lkp@intel.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <202504220128.2KvxCzaG-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TYaWtQQh c=1 sm=1 tr=0 ts=68069222 cx=c_pps a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=p4PaQEVxqj5bAbq44HAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: iE8Ts23I54uo5EhX54t4KQfYUKX7ctB2
X-Proofpoint-GUID: iE8Ts23I54uo5EhX54t4KQfYUKX7ctB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_09,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=510 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210146

On 4/21/2025 10:16 AM, kernel test robot wrote:
> Hi Karthikeyan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on d33705bb41ff786b537f8ed50a187a474db111c1]

lkp@intel.com folks:
This patch contains the following footer:

base-commit: d33705bb41ff786b537f8ed50a187a474db111c1
Depends-on: <20250421111505.3633992-1-karthikeyan.kathirvel@oss.qualcomm.com>

Is there a different mechanism needed to tell the robot about the dependency?


