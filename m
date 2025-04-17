Return-Path: <linux-wireless+bounces-21614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DE5A91261
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05AE5A07B6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96997E1;
	Thu, 17 Apr 2025 04:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iYxAngUi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D01DD526
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865465; cv=none; b=VWPVZAwOgvDj9HnjCunfWdt+Guvo1j8UF4owsqc6N/BnC1qy8hFsF075mjW1VvgwNJpKrx2MVf7JnRKvodmt0PjUcDuWfX+caJJH3DR/cgcOunh553UZ/RnBrq48ypSJF7uncu7Nc+7qq0jAscecAC4sDIOK93CKn22Z9oR/cwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865465; c=relaxed/simple;
	bh=SlUopwwVgorT4aX5rQXjxlMU3Wz457hC/S9QJKYdk7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghEbHCICyw6mDbdGXWGghh1qVq9RgbsQr6ciPT/5IhTlCx7Qyc8Jo6GfceBX9poQ+4jR5R29/lCp6WL8cmPCxaOAtrbAhjNMcl3Oyc+xyu+LAnKrkBWtyJ5QISCRQ5fA/mkEKaO0J+zijg+CbD5we0j7CCZ+HxTbrIk9Kb0PFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iYxAngUi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GM0vuN006162
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Be6m2HqIEihUmnVtYiPM/ZbG65KieSdUP57uv1iI/OU=; b=iYxAngUiVCQbNxES
	NnKypiG2+NvqsoPtwZ7IFm78PXTo2mqEakIe7WpiH6g5biMUyUWovmJ+z+KaF7nN
	ld7vUSqlhtVYUv1Ue/gc4hSFmNf21fAztYRlDBR6WROhXuF2MsR9iiOWpZ+pwKU+
	EeaCAWmUeOQT+i6qfUKA++agRdIFx4BhHNAGmLdz2lBWSiEWtsjZCeghxPZYlfJ0
	CH/9N6J1B0ZhA+hyiEpz86ZDptdjAaaFJ8DsAaJHjPQ1t2XiAH+fB7hDTj8Li4Xr
	Xx1Xw7Mdnba7Q+iiavyX3GnbCuOMpV0y92zZWUc0GaTWQiT+zWo5BSPNqTR0qwvV
	EpXS+w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhqdvsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:51:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736c1ea954fso195026b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 21:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744865461; x=1745470261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Be6m2HqIEihUmnVtYiPM/ZbG65KieSdUP57uv1iI/OU=;
        b=gcTklee35zNNqnEkkl4ckrGeAmt6SGE019r9lKiaUfZNuDb2YyffwVPLw37E7GEdmB
         oxRrhXHBY0JnTPAXaykDQkTPe9q0I1w8RFepVp+tfX36N7P837yNIcNhN6Vsur8IqeJ9
         LuyO1OfgJntSYr4e6tnEoBFaXtLuuGl0nsu/qb/ZEdarGuu0KBgFPWN8tu4cCQU6z45Q
         5bQ1rmLc6BAaxhrxJFIvHuiEltiO28G5b555/OCi/ldMpvFnti3Lj5NL55PnjgmIG0L7
         bKR4w95PD/KaHSeeb2rK06hheBErZaU4W9al/SqT5FlMuzx2unitSdjOTeVtIyhlUk5y
         J59w==
X-Gm-Message-State: AOJu0Yy6KvhZpe7i24AHGtybWZpyqxHUU8RUl817v0C1PUfR4sipjpsV
	CyjuphB9H+C679pGmceAwdDiviYOHNbZhitSAg5b080FJrbY+rLDNRvGyhOBC0M7jU04SZPaCqI
	IyjJm+NxPila4TgghczxFdaJLvpnjh/ygKLogLfI1OzbAo2G57Nj6HJ9Go0ClyoA7JRcTN8wPqw
	==
X-Gm-Gg: ASbGnctJi72OisMnyUzbibuhFSru+QS+Q2GpRDdObSpNc+maWjsjhdHBoPX61hSORBv
	L4LIYcFub2uw6nx28jyOILEO03RKpJrZvHu70X5YpF0VbZaBZtvoPESRx6PcGh/68DsKi5yHmy5
	qs9ZcwTNLwzjIusv2ITj6tP7T4hnHz9GN3O0h2rQp7592hSt/b3CzZVwps4lqdrbXus5JbfRhhh
	bw5jn1BRNNH/tJeTFv3iGvuTvHSO4YORJJxw7G7hB4/fcwIrtbqO7U+2MjywsynOwzfy3STM0LE
	fIRdY+erJG7tqCEIjuIOGRBNoAv7iW3dUKYBzZ3N6Nq4nVezzPgaCg==
X-Received: by 2002:aa7:9313:0:b0:736:a6e0:e66d with SMTP id d2e1a72fcca58-73c266e1782mr6112046b3a.6.1744865461143;
        Wed, 16 Apr 2025 21:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzihpiHHaq8nx3XfS23uRKBU/YcXwR5Y0HWffmYYmDvrY9BXNyFYep7Pv/t1Wqu0PdOQLEww==
X-Received: by 2002:aa7:9313:0:b0:736:a6e0:e66d with SMTP id d2e1a72fcca58-73c266e1782mr6112030b3a.6.1744865460720;
        Wed, 16 Apr 2025 21:51:00 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73d90750bb7sm406364b3a.126.2025.04.16.21.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 21:51:00 -0700 (PDT)
Message-ID: <08e7af61-411e-2db4-e731-fc1adb180afc@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 10:20:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: fix node corruption in ar->arvifs
 list
Content-Language: en-US
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250416021724.2162519-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250416021724.2162519-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LNlijtD6h8nEYg8EWyOOStt5h_ba3b19
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=680088b6 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=boy3l9ICv52KCTrOtmEA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LNlijtD6h8nEYg8EWyOOStt5h_ba3b19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=731
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170036



On 4/16/2025 7:47 AM, Maharaja Kennadyrajan wrote:
> In current WLAN recovery code flow, ath12k_core_halt() only reinitializes
> the "arvifs" list head. This will cause the list node immediately following
> the list head to become an invalid list node. Because the prev of that node
> still points to the list head "arvifs", but the next of the list head
> "arvifs" no longer points to that list node.
> 
> When a WLAN recovery occurs during the execution of a vif removal, and it
> happens before the spin_lock_bh(&ar->data_lock) in
> ath12k_mac_vdev_delete(), list_del() will detect the previously mentioned
> situation, thereby triggering a kernel panic.
> 
> The fix is to remove and reinitialize all vif list nodes from the list head
> "arvifs" during WLAN halt. The reinitialization is to make the list nodes
> valid, ensuring that the list_del() in ath12k_mac_vdev_delete() can execute
> normally.
> 
> Call trace:
> __list_del_entry_valid_or_report+0xd4/0x100 (P)
> ath12k_mac_remove_link_interface.isra.0+0xf8/0x2e4 [ath12k]
> ath12k_scan_vdev_clean_work+0x40/0x164 [ath12k]
> cfg80211_wiphy_work+0xfc/0x100
> process_one_work+0x164/0x2d0
> worker_thread+0x254/0x380
> kthread+0xfc/0x100
> ret_from_fork+0x10/0x20
> 
> The change is mostly copied from the ath11k patch:
> https://lore.kernel.org/all/20250320053145.3445187-1-quic_stonez@quicinc.com/
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

