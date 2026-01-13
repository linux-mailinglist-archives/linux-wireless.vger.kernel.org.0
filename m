Return-Path: <linux-wireless+bounces-30725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E5FD16AC9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 06:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EAF330142ED
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 05:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121DA30DD1E;
	Tue, 13 Jan 2026 05:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4lTJeAh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LbvpieaK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C325487C
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 05:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768281086; cv=none; b=JkppHxjuGv3i08m6rO1wySb30swwv9Pl3a0Lp8Fk0CMkbzJV0kgyFih0iVBGdxo680FTBpAcN6wo3juwvjnnylgBkcIDlmz+MxCMwdu+FQFxASyCOtI/aLkeRO5ewB156hsCeWnLCR87xv3iNe7UP9xSmnKJ1xZ0cMj8k8IJ6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768281086; c=relaxed/simple;
	bh=m0T7GW468wfCRQxDu4C6oQK5moztjEzuxYAU57RUrhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQFdBhwCvXM33RdxgfSgW8YWM37c3VFQJetqRqKoTl6bqwSp+7TfVIQeEilhLwVhZwSebRCT89BPFMPN117gnpqI5cYOzBzEsyZVOLNBLEh+8ieDSbEDIoeLF/7s32IrPt1BmsXn91xOYeIX15P0n5SRBtTGsYRnjRbbV6d5BmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4lTJeAh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbvpieaK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN5M5i177577
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 05:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zBtppCAveQ1Uid5JNlkzsUMEMnNmJzujCp5DJ2xvJuI=; b=K4lTJeAhR2/hxKMd
	z+tIBixE+ljSp/75RHCUB7vl4BmlcAhrDDSrY4JPeTZOsurIORQiepqkL516R0Qj
	4wZn/Zs/Fq4vNtiF3iOjvqvvJVddslm+bPMzDuSBxE+dfEXzxB13RgTo3846O9gm
	Mg4or7fqHa3DZr90H22TuLt7eY0blR95H2gRfOwPv354PCIz/XrGFB2izQ+PRh3S
	vaLeCAF2dOxVlvccpPm83d56tf42mAzzQy+fwXXbvKIppPjvEc/5cL+e3eBmkxuH
	67RLh28guP4cT+rXTeDr4coF6suAmEnlJcjNDgpZl57hu5UweM6xiS2EbX8qTHxP
	jU3nLg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn52f1uhr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 05:11:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81f53295ac2so3628599b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 21:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768281083; x=1768885883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBtppCAveQ1Uid5JNlkzsUMEMnNmJzujCp5DJ2xvJuI=;
        b=LbvpieaK9COJWyyPHjU8H24WqXIXVyZHthAAsI05AVSJioK/vy3I00qnut6NnyZu5E
         H8lHN+Te+XF4Rcrw2XbfMncXWw9VOdyna10rvuu9FMWiTAdrUbkgzsEBp8DyqWvIt0Su
         IkKKdiq2A5qR0Manqq+wBmqeJ3duS9stuLi3ZyLlW1Ijutw1Mk/uIT4UToqWA572fqgV
         M8nf5M4m84KMbLSFJYHkfyLKMbbiRnwAobtmiPY9AMgchlbbR/7v/YJGjlU7v2qZbm5j
         JccBLnMqXE4vPmDGN9s8ZKgS7iP/J8YO5tQSOUZ8NnZHlysmwyqMo49n4OrgAOifq+XP
         1Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768281083; x=1768885883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBtppCAveQ1Uid5JNlkzsUMEMnNmJzujCp5DJ2xvJuI=;
        b=kogaC4+r6YePwXVbn8gae3OcRnWTFTu8x9Sqgtzglf43ySr4KW98/mkcKAEm5rjCR+
         PaFJlspjDiGofxnFmQkVT5BnTwxg6+NcIFHUoFDODQTkC8V5SWANPVY84tkz0lGE41/e
         y2EWJrC4kir8/6L6tu1PYgKZAv701g1muLZsglpUyQZfYBNAcGQ2lFkKcpSHdLjXVzJ8
         7MkSeFZ+tZbu7uAVo75LeT4matqyTGIqeM51PtYTKBAVOqKK+Rxja8x97erQiSzA06G8
         KSD5YBD2PwEi7PB9KIFwA08prKtZW1R2RWfyoMZgsYGEVz8xbm9mAHAheCnF5ZftlBIS
         HZ6w==
X-Gm-Message-State: AOJu0YzTG9OFU27IBwfd+m1SJc5J2aPGuVuXHqtiuwmHa+xpqL30j6HD
	DMhzATIt8mppj/n/mAVF8eh80+axUQJ2gHvj1RnUVCqRFH4clcTicemjskHdQTZC8sxKkBQjYng
	qOx/8pReOJ56Uq5FMSxfTefhcpbNe2wi8cgTpNfQOVuSsVxeI8MP0ZZ0IsqwNQZ7futp2ug==
X-Gm-Gg: AY/fxX5/RQ9eyfw8clqHhZ7UeQaNIxy3rbdyQyHvhKfeiBS2V3bW9Ye+53Pt2MDpDHW
	k5JqbkQB3VbVUdzXKx7gtwWC8zEgWx/ni2498hvcfIMA7Wq2OZaf+KGkj9PQuQz2/tc/nZP0mat
	A/YrEA8a5tXKPlg74VOI7AUQcvJ6GD+TLWJoE0dgWgdqWTUIbadih22UOTaIH9end9h2awQFKe1
	FmQjSGcssxeNi2c9ckRq0euNfhIled2u42Z0N1pM/pTRpUfH8Vap/mJWDFvHmE23la9CeOK/f1E
	8L9G2FKLEJ2FuNzUWlXf7o1gSFBQuVcd3dyk5lp6lZQagMy0u2ga8eFrxwiiNfnuTdaxhQs5FGA
	14/jP/g1cOedf3MxHHaEd+F6ysK+GbC5kGfiwA1PuIuSoAwFVeq+9ca0=
X-Received: by 2002:a05:6a00:ab85:b0:81f:1a4b:bf55 with SMTP id d2e1a72fcca58-81f1a4bc2a9mr9778122b3a.39.1768281083027;
        Mon, 12 Jan 2026 21:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDHv7f0wrNtF1qGXIMOXDmX/R2MaOCjZgdxwURFTbtrFHzugEtGOQ7flYoG8agbbhXmc8CLQ==
X-Received: by 2002:a05:6a00:ab85:b0:81f:1a4b:bf55 with SMTP id d2e1a72fcca58-81f1a4bc2a9mr9778109b3a.39.1768281082514;
        Mon, 12 Jan 2026 21:11:22 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f90c0sm19106329b3a.41.2026.01.12.21.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 21:11:22 -0800 (PST)
Message-ID: <badf5d1e-0b11-4f8b-bc08-d035f139f7ab@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 10:41:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix dead lock while flushing
 management frames
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
References: <20260113-ath12k-fix-dead-lock-while-flushing-v1-1-9713621f3a0f@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260113-ath12k-fix-dead-lock-while-flushing-v1-1-9713621f3a0f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA0MCBTYWx0ZWRfXyZxnojNiXucJ
 v/kciIsnSgSfUkLoP2XnoH6S5DFAqfJr/GB3ibp6T05B+akKMpLYVV7g2OAdsMfhViaWfoyuT3c
 7E5HZCiiUVtfTO/qcxOWNO71m4rqwbF+Z3ilJiieWS1dFUtqrV+yBDvJ++3AzSvv32n4aGORFnK
 gEyx3XRlKynMD5utINR8IDWnS/6Cx3khVxVRXTSBC/VlRVEHHOIHoEEja5S6F+RN71wuNmd++KJ
 zxLNsip16mOmpHqHf8VbfATCQ3DswsNg4jWtEJxoDkq9r+qBzwR+rqwD0/GRFKrryb2eIu4Hzh9
 4g2BJ+7bdkDJA8fKIAduZEDpVN/Q3IsU910kYz+CXQzj3WnJLyIp79WtdEn25r0ZVQT7vAUWDXJ
 mL6hUX8lE1m51i3xwJ+7iGpw632A0yqECu+w2QBetDMzaOq+/MPG4OfXfV6e38GiUQ46iKKCz31
 JE0/tPf+4qY7qCRdheA==
X-Authority-Analysis: v=2.4 cv=TcCbdBQh c=1 sm=1 tr=0 ts=6965d3fb cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=P4Ze_JGZ0aiUAhR9NtAA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: dPdlgkotNFrCZYMnPPk_988O48IOG65u
X-Proofpoint-ORIG-GUID: dPdlgkotNFrCZYMnPPk_988O48IOG65u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130040



On 1/13/2026 7:18 AM, Baochen Qiang wrote:
> Commit [1] converted the management transmission work item into a
> wiphy work. Since a wiphy work can only run under wiphy lock
> protection, a race condition happens in below scenario:
> 
> 1. a management frame is queued for transmission.
> 2. ath12k_mac_op_flush() gets called to flush pending frames associated
>     with the hardware (i.e, vif being NULL). Then in ath12k_mac_flush()
>     the process waits for the transmission done.
> 3. Since wiphy lock has been taken by the flush process, the transmission
>     work item has no chance to run, hence the dead lock.
> 
>  From user view, this dead lock results in below issue:
> 
>   wlp8s0: authenticate with xxxxxx (local address=xxxxxx)
>   wlp8s0: send auth to xxxxxx (try 1/3)
>   wlp8s0: authenticate with xxxxxx (local address=xxxxxx)
>   wlp8s0: send auth to xxxxxx (try 1/3)
>   wlp8s0: authenticated
>   wlp8s0: associate with xxxxxx (try 1/3)
>   wlp8s0: aborting association with xxxxxx by local choice (Reason: 3=DEAUTH_LEAVING)
>   ath12k_pci 0000:08:00.0: failed to flush mgmt transmit queue, mgmt pkts pending 1
> 
> The dead lock can be avoided by invoking wiphy_work_flush() to proactively
> run the queued work item. Note actually it is already present in
> ath12k_mac_op_flush(), however it does not protect the case where vif
> being NULL. Hence move it ahead to cover this case as well.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 56dcbf0b5207 ("wifi: ath12k: convert struct ath12k::wmi_mgmt_tx_work to struct wiphy_work") # [1]
> Reported-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220959
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

