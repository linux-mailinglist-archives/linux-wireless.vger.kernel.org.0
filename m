Return-Path: <linux-wireless+bounces-17871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6055CA1AA5A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 20:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4D2188CF70
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 19:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A48F14831C;
	Thu, 23 Jan 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IWPsbmAx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BD145B26
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660733; cv=none; b=gfn/8M1S/zwchXM1Vwd6fQoMDwL8gUY0yUA+NpOTRX3SK5dN9KwsCya9VymVWWeH7jUPxJIWHW4Hrw9jqNW9GzcFP5yHSfJIM0XRca9pKQGzbbGb+9wV5eENZ10+GfJhvNuYTBVfxsLAasA3jWxQaQI9T7KjwDdiIZYYrIXt9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660733; c=relaxed/simple;
	bh=yffEDL9TmpzYwhNrFq60P9Hm64DYtiGWQ87oi37tmSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i179Km2BCjVo6FvWjY2q9tF+UJWChfRlsWVu5n/avWoOTx42L9T1/cVqiFxMhLKOtQGYSz1qJM2MnCcY++jQcI/tfns/TrRuMD22+JRXaLro9E8j0prc9lfuK1vdsfeHaAiMAPDT0VSDiHTt7Mq+ss9Nly8ouLO+hMiPdSK5pGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IWPsbmAx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDs8fN029555
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 19:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dhwQZhuNxct8agZBJ+sWQ+qndGIZosftMXna/I0oIwQ=; b=IWPsbmAxHfjnYSsu
	a1IC5L4RANl8kaGRmVNbC3ecFFHqk7iQ+SK+e4+2HLbsHomwY1ydKLMTyX4MFVvu
	16Mg+n35tj37XgkzLpLh98IOXZ3unz34GJsOXhFNMV2LaPbGL5VrYXAiFX1hF0Mm
	Z1IH/1Lv+aCjqVWXIaoxhcqhjgR3DEJ0CDbVU2g0y+YwrMYyarUq73LjZ54Mq0tI
	VeEIkH5TXCBIA9SxzukxGsrOOGggx5iIIumGYjTGYlgTdXALxuuxUfCnVfL9opbK
	qCxmj8emExP1rd8gbkZpzIPerLIiV8lJ1/zkFU+pYz7BR4JzGR8wBfBE0qngyuJF
	w6FeAg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bq2crsat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 19:32:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21640607349so30349945ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 11:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660730; x=1738265530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhwQZhuNxct8agZBJ+sWQ+qndGIZosftMXna/I0oIwQ=;
        b=pLn0OOKTmNPrSPEAgn6TWNHj0RvRoQTB7Lv73bAAJhB+jkPtCLARMUUOHXT+Jc6ehy
         svTw2OUYDWecNreHCh05iekhFaLn51EIfBK83hmo43dEqA/iW96FKAE3Oofucypq6UF+
         FUWw03hSBYArkjpb/d2H9D/oAPWIF9oS8RjYTHlkheg74X4Uok9Gv5CLIYYGJSHrqDo0
         TwNhzF9bMFIM3szE+joSLJEFeq1GIH8B2jMA3jIAl0BvG7vQuHDslawthC85ZvngZmie
         pmuc166MCRZVlDr5bpYN9ecYYInGn+/c/rlc56tRcLYQf9NnyO0w51ih+PN9XVWtNz++
         1vYw==
X-Gm-Message-State: AOJu0YyEJVbNYPmYLP6DmzjAJnFvM7qEdeBrf6ui7Y/r+sFKLr+ZXPbP
	Ae7cVXyeYaEWQmW8TWkQ9LHsY3De99WtB/rlExCU7P6utAH3zZjDqBfJyDJVdOVI9IoBayCfLdm
	K+juTf/Nrc8I10LymDq0gJ7pEsrLBxLx1SOgRSsDUY3Trcg7Q40d+1mfRV1BU/Tj4gg==
X-Gm-Gg: ASbGncsBGCXr1Kkm0MmOt9tzzHraJj0hMp9VWkUDc8TIZ9wJfAqZecaSMc123QgbLGX
	brJ3VBLPYdK5XHBNOnprgJnQMBwVkZisypsrfu+aBwpXqRbMJVUCOt9/ZdFl562D2+a2CfiXtDU
	a/1wnZ5YGwKbz8P3LodqvQsRtrsCXQvEcutapmnZoxvONm9qGZcOeJfmsvC7h2UYNDpttPCbGKI
	xxdxLiUEQZtmSkHf596yj+QANSFQUY2C3aiLAq0P7Dx0yV5y1v7vhRWe44O0mFYt135EXDJu6qr
	dna27doF9wHU+U/c/TYDOoxMxEYBoxT+UkETqT1w4uLUsxcOruC3d+03kNpo2Xk=
X-Received: by 2002:a17:902:f544:b0:215:e98c:c5bc with SMTP id d9443c01a7336-21c3563a33cmr473933375ad.48.1737660730230;
        Thu, 23 Jan 2025 11:32:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoqbRrk67Rnq31E/8jBfP52B+N3zukLWB98wiiiTJUez6ALjkoGuUcBpBcpYhe695wix7+2w==
X-Received: by 2002:a17:902:f544:b0:215:e98c:c5bc with SMTP id d9443c01a7336-21c3563a33cmr473933005ad.48.1737660729826;
        Thu, 23 Jan 2025 11:32:09 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea3027sm2736995ad.56.2025.01.23.11.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 11:32:09 -0800 (PST)
Message-ID: <91c2b0c2-0b6f-4bac-a49b-743ae8f70d1f@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 11:32:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] wifi: ath12k: report station mode receive rate
 for IEEE 802.11be
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250115063537.35797-1-quic_lingbok@quicinc.com>
 <20250115063537.35797-3-quic_lingbok@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20250115063537.35797-3-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: j1TDT1EfUOdhiBuicCzv8ETD5jclH5BR
X-Proofpoint-ORIG-GUID: j1TDT1EfUOdhiBuicCzv8ETD5jclH5BR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501230142

On 1/14/2025 10:35 PM, Lingbo Kong wrote:
> Currently, the receive rate of EHT of "iw dev xxx station dump" command
> always show an invalid value.
> 
> This is because ath12k does not pass information about the rx_status of EHT
> to mac80211. So, mac80211 not calculate the receive rate.
> 
> To address this issue, add logic for handling rx_status of EHT to the
> ath12k_dp_rx_h_rate() function.
> 
> After that, "iw dev xxx station dump" show the correct receive rate.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  48 ms
>         rx bytes:       59226
>         rx packets:     320
>         tx bytes:       26556
>         tx packets:     191
>         tx retries:     99
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      79
>         rx drop misc:   68
>         signal:         -95 dBm
>         beacon signal avg:      -20 dBm
>         tx bitrate:     688.2 MBit/s 40MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>         tx duration:    0 us
>         rx bitrate:     619.5 MBit/s 40MHz EHT-MCS 8 EHT-NSS 3 EHT-GI 0
> 
> This patch affects the station mode of WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219715


