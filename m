Return-Path: <linux-wireless+bounces-20737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C93A6D4F0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 08:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AE516A7AF
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 07:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A11B250C19;
	Mon, 24 Mar 2025 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XQhiXis5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B4250BFC
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800881; cv=none; b=EVMtLHp8ZfeUY608VCq5EeZSGS5XEiKqDyFFKMkf/Vox6E+j+02oXjAjI7OlyxVNZW+IH1m0aFClvYURm+1AM4lcF5xankNyniPDGCBCjLB3TEnBDSla1Ozz1CgXyzEn6cnGlZ7PocIugm1brpH66xxmtdR3y49onabpd7lwcEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800881; c=relaxed/simple;
	bh=E9owmNnpaBQQCQAwyR1buIix4ekPhB+GNCnSVEh6Bd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ws0lFg46nKlkdp0GY2Z80c6ok5EikUMyvknxC5BEz4g2d34lBesthCB2/Olmq+CtzMk1GUF/NmIqgufnpJNMzYiDGmyTL4u9MK8lnq4Fs6sxgJqALMU8pHM71XBQuY8fo/dd76dNuhHzphGpDLs40hHLCcbk/xXfulkaUQ0ONxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XQhiXis5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6cMCf023049
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 07:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HJ8685mCmgsitSKIEUunf1oA3s66xel4PR1PeM1GFJ0=; b=XQhiXis5GKV6C16X
	JbS8qaaECp1gX+sun0SrsPD482pp8N4EsB89lAye1zoAPoe77E73fIKVGmZRDDF0
	s5+9+aj0qYkxjMaV8+0j7eTq6LxXNYImbYzB0TE0L8T+23MBYVonFoR3yAz1qVvK
	h7hmPj/gURjnu6/IeMX0RZBqHr5CtR1YVCZOFr9xFrhqkvoAvT1l+aMwJdtY7mbq
	D2ZCksdizJvVcErvJtm9Wkc+amJlLdeIseUW9M9ffb/hLdRmZ2iByySfNvwV9btU
	6IRQ++N/1yIWg4QTow8EDksFKWD6ndPmt2z634aP9pFmlxbiiYdoa9rNYAccNl3v
	uP7JIg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjwhkk9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 07:21:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2255ae39f8fso90845895ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 00:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800871; x=1743405671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ8685mCmgsitSKIEUunf1oA3s66xel4PR1PeM1GFJ0=;
        b=Jc7r/YDnoowCRd24LcrOt5R82OSontnW5kWSWd8AUCga0RLMYDNouSQIQINByRV8dz
         WjZVFqHCpsYf9P4SZoK+LjNshJcuj6KliYsEvMzT09Sk4K7Epu8MVfW+AfHnqyx2N/aM
         L6E4vYTpv5rRUfRAoT2oYUH/ZPXGuLdAXeiuO/w4MxphAomvYZa2r2PwsU2bSrJfReIK
         2Na0yogzo0jS0ZF8agBSiB2xy/l3ScjobInZoKKvNTmnwxSXVUf/1ljE9eU+5HUQZCP4
         UG39pz4j+ntB9PKJDh8PhJri36v8sbe2X1deC/83NjUki5MsYu0Vl3gACTo6axnWYr2d
         RsNg==
X-Gm-Message-State: AOJu0YyJtkbKoNxRgNXfGCxYVcoTr/Cv5pI6gWmIYhqXb9sMXV8uApb9
	8b3abJ7FAulbBcBqOj37miBEwmWxbDughideYBNLfsru5Tf/Znym+TYbad+9fsX1Tw11Ii4JQ6y
	WxUOasKjiTKNVWu1F2UUztarja5gCjTuf4+Ei9MhZpekyvAtI4oismMgggz3nhzP6iQ==
X-Gm-Gg: ASbGncskNOoRh+cluY0G1mqjZoibVHgVw2Bma9HXPr2RJskW1HYmrSbx34G/4tZBQ1j
	H84383Ow7nwH5vE+DckBUiyRUs8qrq7zCJUj/lyqAK85aoDZpO65s8jKecKk1aUCJqSviac18Lp
	n9xujhpKtLi/I8HqD9GOwE+miXyH9oAq2060PJuJM2vai53IaFZITYt4mm0Pu8mJR6SQ8c00Ndv
	me0zJd6nfpAaZtVXWQ/dEUrJoOurpx0qKH85qaVol7nzHAVfhCnTdenEjr90MM3Hr/Y6+rva+fl
	AmvvGR975eqpbId6c10eKniqfxEAqcTj7f/j2aFbwvF1+fgJJqfexantwX6p0kI=
X-Received: by 2002:aa7:9a8c:0:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-7377a1b1965mr26587288b3a.9.1742800871360;
        Mon, 24 Mar 2025 00:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqObw/iye2SAF7GUJa02kgdBGQNx+DF8iOEAXtzsMe81ACzu7mqqP9GDJu4G97SKez+5thFg==
X-Received: by 2002:aa7:9a8c:0:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-7377a1b1965mr26587250b3a.9.1742800870665;
        Mon, 24 Mar 2025 00:21:10 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.235.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a23dc8e4sm6457091a12.0.2025.03.24.00.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 00:21:10 -0700 (PDT)
Message-ID: <30351fd9-3fe5-359e-de71-22575c4f48cd@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 12:51:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v11 09/10] wifi: ath12k: Move to NO_VIRTUAL monitor
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250324062518.2752822-1-quic_periyasa@quicinc.com>
 <20250324062518.2752822-10-quic_periyasa@quicinc.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250324062518.2752822-10-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H+jbw/Yi c=1 sm=1 tr=0 ts=67e107e8 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=P3F+j+0UjHwaDtf4GQVMUw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=R3Fj9Vh-w1QtjPU8CJIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JbTC3IkW73FImFEAUH9jut0jwfDl4OLP
X-Proofpoint-ORIG-GUID: JbTC3IkW73FImFEAUH9jut0jwfDl4OLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=985 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240052



On 3/24/2025 11:55 AM, Karthikeyan Periyasamy wrote:
> Currently, VIRTUAL monitor handling is present. In multi radio model,
> VIRTUAL monitor is not suitable since each radio needs a separate VIF and
> channel context. Therefore, switch to NO_VIRTUAL_MONITOR feature. Remove
> the monitor_conf_enabled flag and mac_op_config() handler as they are not
> need for the NO_VIRTUAL_MONITOR feature. In NO_VIRTUAL_MONITOR handling,
> each interface creation/deletion triggers the mac_op_add_interface() /
> mac_op_remove_interface() callback. Consequently, remove the monitor vdev
> create/delete/start/stop from the other vdev type handlers.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

