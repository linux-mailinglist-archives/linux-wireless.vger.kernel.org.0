Return-Path: <linux-wireless+bounces-25549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00946B07BC9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BE93A4B67
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED33D2F5499;
	Wed, 16 Jul 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcrgpN0R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F12F547C
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685893; cv=none; b=lXZ2CJ0zQLuGkeh7r+RoybBTONKkzKLeY24zIOPA41ddv3xIrwRjUeqLb8hiqkusXNj0n56bQSNnvhxqxDFQX5qowmkJP0eMTHIMVpQl1LO5zo9ka6X8za0mwwL8J4NkHyiHud9QVSrkb+5UIW6MPhOtNUFGdb5nPc1lG9Le0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685893; c=relaxed/simple;
	bh=teMc9fjwUgbak3TeVa32zmM1K7Kuh41Gi+pH8Ju0/BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oChQFtadAebNlx9kVbweVL/5WeoUCg/2Y574FJa3P3lc2pDMx2ksyTzcpfXNIcZRLnWE5lBtIJ8bOuFYbnLqisQ9k8WP+Hxq4l3zl801Bj5jzuNXZoyCXKSm/dvZWkrBpjhLkUG77xyzGBr79QFL8DHlqE+DfkkOODI6+SGuj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcrgpN0R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGDgbK016545
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 17:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AvZu+s6FPUG3iM8B2iDP144HoBABMQMyB2lUuofN4v8=; b=lcrgpN0RS21s/wFj
	BA3V9E2v1JVAb0Jubcya9oPGT/MF+0yYlDwuJymmhDfnmwOBvvSZbbRcJCBu1TOY
	8NLV+BAE+cMui13Nej2B0JwpSsfbb4p+XU1HEM8aFm6g/eSVLKdLXMhUan+Wo37U
	LyaF8coJAdDXauV/J+qOph7zsKyDCWH2iAWQGHe/M6upStdCLSQNHLxJHs2xdLyA
	3EyrsJuzQ5fqObKx9gfBbbjcyyVvdCO4R/aO/aN3jLhSi+KVjnO5pgQcPhEFwVp/
	8OZdVTpXIZiVJPZLCb1QIh2yqciql6cFRNZ8xSj9ykqhbeAsK6/K1AvK9BPDslu2
	Z0w+Ag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyqqxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 17:11:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2369dd58602so346705ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 10:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752685890; x=1753290690;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvZu+s6FPUG3iM8B2iDP144HoBABMQMyB2lUuofN4v8=;
        b=a6+g3l1KyYMOC669Q4ZONenf7zA3MtINe1cd9VPvLbj3wQ0VjoVdQr3sAwjsnWUxUE
         uOEMBFdhTBaOUHo6tt9WDNbVbjLRhY8V3uKgDfC2homE2NGc44fe3oDW565tm/kZj4LY
         EvhbAubKTS8GmdE6nxXO32tBTDgG32gbA4Je4GHIn30wEkaYqJft54Y+V7mDhLIGP98k
         5+sQJWj+q5MKnUWQsc5Xvv4I//58n2wqUHqSMMqlMklzJE+vhTsk2+nXuggOf8YyWNP8
         s1ALDM8S2Xgwm2Zed2K5Fb8YBz72QqH3oPhRsrj/jk0y3BEOZbNnHPB06uKpQQu7aF0Y
         FvYg==
X-Gm-Message-State: AOJu0Yx+vNh5COi89YpKwuO9rlGhXzn+uZX6tiWVrF/hdUIMcQrCXxVS
	Z4TpsTcUAYihZUeWL/TYODl0wUtp9OyvoRJtQcUKFtrZiyTxgYyIRjQ8FSVSmfDifLtPRU4/rMg
	NEOYghMh9YBHtFYb3gKYCsoRMuCWrI572aW9a9jmptIxCxYX13Jrge5P2Dj+gxTYSEDlvY1xzN4
	b/Cw==
X-Gm-Gg: ASbGnctptlS2FD3QR40JH1ZUxczkL1ut2ca86NqiBYlMWcpI0HMmluVYmL8T++a7FhD
	R0ZINK+vPA3ZpCZs9s0zHEAEAok7FmoS3zKO/TnQxyNXgiH1shvNBuRIsjxXFH3BsG87dvAmOyI
	9eFlth5DnceGP85J5Lm6BisvOGGzNK2ga4hm11s2Gksz2G/q4+m941W0o9XKnrLhoSe4xkWeyE8
	alULSo6otyucP2lK13PTh37IUF24bZGAnuDWU+4a96zff4Y/JvAJN6c1ycNvvfC2N37Afr+lSXh
	Eh5lPgEYzXg/UbihqJF5YjDQroUr4DLROjV5xuNE/oUSM0lMy/dBG6ohwSbj5zYuEI1+f2jd/MZ
	W7GLepeApUJr8DpUWdj0=
X-Received: by 2002:a17:903:1cf:b0:235:efbb:9539 with SMTP id d9443c01a7336-23e256b6e94mr60970165ad.17.1752685890508;
        Wed, 16 Jul 2025 10:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCaXQ8h/tJKVUb7+n8ZsAIn5RASnIJXRAkFzeIQw6HcoivPyubiz6hlD2vF/imJdL6JmfECw==
X-Received: by 2002:a17:903:1cf:b0:235:efbb:9539 with SMTP id d9443c01a7336-23e256b6e94mr60969775ad.17.1752685890010;
        Wed, 16 Jul 2025 10:11:30 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42abd8esm128205355ad.54.2025.07.16.10.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 10:11:29 -0700 (PDT)
Message-ID: <f3374104-684d-48c7-9e2d-e97dd48700e9@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 10:11:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PCI/ASPM: Fix pci_enable_link_state*() APIs behavior
To: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Twio3VQQjp9ky53tSbyqarj7bN1LrL1B
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6877dd43 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=rhYh_zIkBfzxVmIspk8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1NSBTYWx0ZWRfXwsPS5Lm7muvH
 iJ3n0Xtj1xvRizo6EaGKVmovYcmlgCAgNUi1ThGyDC5o3FzraUxOdVx83w+2n3cupHnbaIaW3El
 pECYEJh2DtJZGg9TqztJr/q88/G+3vo/0A4k942mMhclvdQPS8WPVIYenLEnyy2JnO9WmTNL59U
 jNKyhuov6EpG4VyllgUkTt8ulZhGm9Yqj8zwX9WMS13TRQ6cm86xBjvZaIdmb4dKOBX9pzw3zQe
 MxlDcv6UMaCiimWRMMSNhGLEO/Cidsb9ZgeZrnBeTktqlv6hD8tX3+s/1nb1CZ9yOjM2XPXgBfS
 jC4C+2eOv/MndVTlhmP5V+6trJhPXOG9WScVkhemAtjZuKdtbu4MFVmCXKDjVeXsjYJqnRTbxLe
 Sfi75ifDA3JqFIcud0RMQ49edEkqXpujlYAkUt2mzWgO9q3j3WhfnpYUPTP/f4bfkpaRM85R
X-Proofpoint-GUID: Twio3VQQjp9ky53tSbyqarj7bN1LrL1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=405
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160155

On 7/16/2025 5:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
> Merging Strategy
> ================
> 
> Even though there is no build dependency between PCI core and atheros patches,
> there is a functional dependency. So I'd recommend creating an immutable branch
> with PCI patches and merging that branch into both PCI and linux-wireless trees
> and finally merging the atheros patches into linux-wireless tree.
> 
> If immutable branch seems like a hassle, then PCI core patches could get merged
> for 6.17 and atheros patches can wait for 6.18.

I'm fine with either strategy. In the first case I'd merge the immutable
branch into the ath tree. Note I plan to issue my final PR to linux-wireless
for the 6.17 merge window on Monday, so we should close on this decision soon.

/jeff

