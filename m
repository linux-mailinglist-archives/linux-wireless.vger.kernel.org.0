Return-Path: <linux-wireless+bounces-19338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CCCA4097C
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 16:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C361F19C45E1
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B577C1448E3;
	Sat, 22 Feb 2025 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fLqn5Iac"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4419AD93
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237741; cv=none; b=YUx6gzOFDgtspwl9uLCfkvETt7ENHz3sigwyp3nCCRsnXU7l2ChbK3EraIl4stqtpgKccBWod7cgVlcEdxHbnFAqT4Q3kAPtVavhiDf6WFRuN/SWWHEeA6P/Syfq05nMeMhnMA83A7HvXl7v+SGYDZpP7e0cODIqwkiWCggji2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237741; c=relaxed/simple;
	bh=SbzH09W4hr0BYgiOPz1IIc8DRlhg1D0vAf1dPpN/Q0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYbPtUS9HeGqTt8QnH+yrPvKfofK5Gre6aYyRw4yRmc1RYo2FfSzztRHSqNg6q9XNagKAvazOdYOHWiTZ4N0HaUgqm85nWNSVbiqFPnB29H+NpFE55lgB5AvW8Qyk68ctntZTQvd3T7fl5jZFvscYQPeUirSpwgFoSFibZbFZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fLqn5Iac; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MDCxcW022441
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 15:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oT9XRwAJCHisYTwSXvGtOwYMsPC96fEtxsNMuiirINw=; b=fLqn5IacHZV/TWO/
	5N2iVh7YsItNZyQQqmoNCyBjEZQpG6VNFgBgDqudk/qAoLGdN05hnos1vR9onrkD
	QOvzXpedi0S0FZXcaMQCd8kz0lkzACvD04a49ywTvJsr0Q4cdpv3EWihfBaA4Ev+
	hl9iIQA8Tk23hYSbj/u1tyrpUbMfKbv6TBXFqZ8fZtXXpMJf1lzBBmKXUCvkijNq
	SuxQ2mVjxtyUSF+cKon7fakdVM9nQi1cFUsbTd+H65oFuBoNQZu7mgAokUKoA0pb
	XfJD07XBfAhZgsgWGS/2DX9obGzI/UrsI9SCyY3qmJH7I7OugPCYxps9fJZtP+Pm
	qnywug==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5k60yc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 15:22:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22119b07d52so41142345ad.1
        for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 07:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740237737; x=1740842537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oT9XRwAJCHisYTwSXvGtOwYMsPC96fEtxsNMuiirINw=;
        b=dBhBWSyoON0weOUUerHSp4tWlgRtzy0zezrIByPrVxJ/KSBrDYKIS6Q18Hll+B1Unb
         GV2bS0xjM7go5cpF4N1iOMnfxHoXYF8U8i+UQQx+ooDakWwt5yPjhcARO6abDnBF9RI7
         3Lu/mc9/Bo32YoXdVR2XOHDjk1ASshmKcTxNZ+dp7RsQ7lJ0bf3g0/+qbElxXay983Ud
         QlcbtKGuzuTPiOxf4v/lylzRr6RPMX0Pjpks7QSt5x+tlotiijxEfIPORef6pNwiaLGu
         uacTuKr7iwijXF1JxiDPVHcPschVyS3sBGsHueRwAtLHC/a8BBWpfqg/zOEBKH7ICxWC
         2UMQ==
X-Gm-Message-State: AOJu0YzRwbk+H0Tfc4WkUbWYiQs3Jfc21WVEFD9qHLXoYbA2mPDbh85z
	0zwOtB2LsZD2sHYn9RlgRIjycmWjqd8P6/tw68UZ8VlqlE9Ww8HghilPTJnIl73I/BlZcm5Motu
	6ENMBtCJTzQgobGirVNorJbMrKDRCDvmSQ+nu47vNeBogWQBRrdDnoLKO6DVKZHqPpw==
X-Gm-Gg: ASbGnct7YSyuUojXd7awO6EWAn02BZUtTkVIKW9HSM2y/ScQ/WBxXRX+XPiLMbZ1spE
	cgPnBV+720eP3UpE9DoDppeGC889I9c2NWMBKb8sUXhdP+NJ0Hl4NWz67Oe98sSWOwmBIWHg0gw
	P8N1PpQWW37YeU10STOtZ89T112tSQ30sjwzWOnpVzKYJu1KL0A5UURlsRmKNRExaDyj6ryU1s1
	F86XP7kdXGvZLqtjHimScmL00Wb2k0XykpPv7JZ7PxbQXaWi6sPiAgAsgX8QZkcO5OtWoEBJJcr
	HmtMVVhIldHmeBF6XcRLpczolMWEV+WMBiHf03ulehdZ78GWoqLvwHg6sEEX
X-Received: by 2002:a05:6a00:1742:b0:734:9cc:a6db with SMTP id d2e1a72fcca58-73426d94622mr12623534b3a.21.1740237737162;
        Sat, 22 Feb 2025 07:22:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUZtKhyQEVT6oGyT8ghRvgKaJoODpot5iWUwuwqMIIrOI+eBgB+iGndiLjjkG6MPkSo3c1Sw==
X-Received: by 2002:a05:6a00:1742:b0:734:9cc:a6db with SMTP id d2e1a72fcca58-73426d94622mr12623503b3a.21.1740237736790;
        Sat, 22 Feb 2025 07:22:16 -0800 (PST)
Received: from [192.168.225.142] ([157.46.94.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7340751558dsm6703120b3a.162.2025.02.22.07.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 07:22:16 -0800 (PST)
Message-ID: <c4bcf428-55ca-ec64-6c77-23e482839aa7@oss.qualcomm.com>
Date: Sat, 22 Feb 2025 20:52:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 9/9] wifi: ath12k: add monitor interface support on
 QCN9274
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>
References: <20250222151926.379652-1-quic_periyasa@quicinc.com>
 <20250222151926.379652-10-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250222151926.379652-10-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dE-wSOHZwpSkrQ7exMxcVq_xaX8aTtX2
X-Proofpoint-GUID: dE-wSOHZwpSkrQ7exMxcVq_xaX8aTtX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502220122



On 2/22/2025 8:49 PM, Karthikeyan Periyasamy wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> Currently, the monitor interface is not supported. To support the monitor
> interface, configure the monitor vdev state identifier, configure the HTT
> filter setup, subscribe the mac80211 NO_VIRTUAL_MONITOR feature and
> prevent monitor interface to transmit packet. Therefore, add these
> procedures to add monitor interface support and enable the monitor
> interface support on the QCN9274 platform through the hardware parameter.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

