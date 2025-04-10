Return-Path: <linux-wireless+bounces-21367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253C9A8376E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 05:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B79D7AA9DC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 03:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C51F1505;
	Thu, 10 Apr 2025 03:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q59NCJSL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1E1E9B3C
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 03:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257236; cv=none; b=qZ0FdUNi+iGbR/yZ2a/PAZgIulY6LPdb47g6idwMQwgXFrx5c8EpVcaq/E4afCUaIZb6jQ15ga6adT6kzu7pF8w5EV9SMcxerEcqzgT0ETc5loSlJR8Hvd86vWK8h9i5y/6GrtRbWvQ9JZxYgsZQ0rT/QqwuNSTfp3W0RBveOj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257236; c=relaxed/simple;
	bh=hjSHDWseOoxoCb/08Y5qlcYdbETyh/sB6mBiW9bMxd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwsyvk/jfTdrjap9/B501X6d877TPklHBNF6r4d4i9k8ieWc0dGElyzBnvZSO0/LA5tOOFvg3nGgGuwzaciTRRImArNHVkzZx27F8JKFxmksY3H/hYet5VvgI8nNg8vF38x+hwUcQwx5Q/uA/HEQBtns8g5i0dYkC4K97yu7uL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q59NCJSL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539HG0pl015017
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 03:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+BwQN8ZLX0shRUjYzjaBWJRw7RViiPb1RmqW9J1Fr9E=; b=Q59NCJSLtoSx75zj
	7nmDa/5K9t2O5AGc3ZK6eoioWB8ep+jcbG7adAHF1NggGL491myVWxjGtf0bPfZH
	ETIdOdHR6nda4N9DsU7zFxuFbJEnWT2rROmOuK2FmM+IkpGDkyiY1uDN7vRoMZXd
	yvZsQ6DHkbX3T+L1YAU51zYuUJxZdtpnSy2NcQwvlWHAhVRfT4U9dD/zIbQdtaYp
	LFLcaw2wBiAjS+NmRUuVIiLrsfavSgNb0ltkGEyFS2kVqvY7OPJVTF0hhHW3tSB4
	iFvbNNiLSdJYcXbmM2TVQzBD96xZIfTSwQVTU2/Fe1TB7Xygq5vFjobpdYKAUCJl
	3VrJrg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbunhtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 03:53:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af59547f55bso239949a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 20:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744257233; x=1744862033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BwQN8ZLX0shRUjYzjaBWJRw7RViiPb1RmqW9J1Fr9E=;
        b=vdo3wjEev5LA/3o4CaX2ejepEbQnvijY1OpkU3K20/rWL9QhX6cUpSDpKK1k5kwPBJ
         OMpRRQBOkosuUdR4pGEzkCbgcav1hKx49Ld58VwiF2NXn3BXJu9ZP24/iaieQdYm196P
         +CxBDEydA/G6Ls0a520oyI0TSNh0CIhQ82oYANHyUV7Ab0/8b154XoRGtuj+RzdLvjEd
         mlnOWRi9kxSOAmrvbW0VksltTDSoq7RY4f2syrnyr4QQFF2/yiTCTlN+MtaIufTIJCo3
         92sQq0IcsJQtxc0XJiB6k74YEc14PDB1OK4cuzu5U0Ec9EjkWgnq1zPwiDBH+aC8krHX
         z8+A==
X-Gm-Message-State: AOJu0YzMNIMwT60NGQ2drWKCZ+us7IP8N6i8csNNLcq+13+siWG2FgSv
	nbVmarAzpyU8vzGrpPaXi4E/7pIqQoUYQ5QmqTTjdqtv4TWRlPi+X6pfEwehHlBB5CX4HqH49WY
	FNvB3Vqk721ocP/MbcLZCxuMV7mMgvr/MjeIxrJ7n73QlSoqxEWr3r78iFyRMeJ9CPJmAnBwxUw
	==
X-Gm-Gg: ASbGncvQSlclid6CMSoTEC740WyPCJPKo6eEmeHPW4J9rJr+b9WBGf7LSsFrXYKfkI9
	NSg9MkFAp4qBLumc6HkeB1WL2Nxe+bIfHWU/Q9qi8UOVmaJ4WTAz4/1Yw9mSZiVEw3Kr7bR3OQ/
	1280mCoHBaAAOdLXK2E6uTaGDiV0qwnsEohrCaTiyZJC6hf2bW+2WxVlrkhtZp9rjh5SgPNUK42
	9u9k5FGphhMDHZ2ZZUe3rGgGeO8FmyxkVjZQMrU9k+5NckfUrhYN6Ys2KXDkQBu8pLqMeTNeMsL
	LvxocDEVdnE3bgjqb+TAu2ov/+orI4vF6X1jx58VFhlXNlkKjNLK0Q==
X-Received: by 2002:a17:902:e809:b0:224:c7c:7146 with SMTP id d9443c01a7336-22b2eda991amr17034635ad.6.1744257232961;
        Wed, 09 Apr 2025 20:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEfEb18+Rhlpf1/RDPVJboc0X1xFVoSVuJ9QFYvxIDPyjZsh2JT67I8y6sbCyKc2QzX+5nMA==
X-Received: by 2002:a17:902:e809:b0:224:c7c:7146 with SMTP id d9443c01a7336-22b2eda991amr17034345ad.6.1744257232551;
        Wed, 09 Apr 2025 20:53:52 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb68c4sm20327145ad.202.2025.04.09.20.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 20:53:52 -0700 (PDT)
Message-ID: <64277184-9cbe-3ac6-5972-0b4b73f0bd21@oss.qualcomm.com>
Date: Thu, 10 Apr 2025 09:23:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Disable broadcast TWT feature
 in HE MAC capabilities
Content-Language: en-US
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Thomas Wu <quic_wthomas@quicinc.com>
References: <20250409053830.4039467-1-aaradhana.sahu@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250409053830.4039467-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gR12-CaYNxzuTw0e5zbnbaDEVbgKeDjp
X-Proofpoint-ORIG-GUID: gR12-CaYNxzuTw0e5zbnbaDEVbgKeDjp
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f740d2 cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=uXoGulTGKWFQ220xZdsA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=650 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100027



On 4/9/2025 11:08 AM, Aaradhana Sahu wrote:
> From: Thomas Wu <quic_wthomas@quicinc.com>
> 
> Currently, the AP does not support the broadcast target wake time (TWT)
> feature. Therefore, disable the broadcast TWT feature in the HE MAC
> capabilities element field.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thomas Wu <quic_wthomas@quicinc.com>
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

