Return-Path: <linux-wireless+bounces-27727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C9BAB816
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 07:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2B11895E31
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 05:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393A27605C;
	Tue, 30 Sep 2025 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j3xoW1RL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F831547F2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 05:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759210845; cv=none; b=BmbASKcOQYnTE5xvP1IZW69JDmObhuZFdAk5y/qQ7BwLOSajQt0hqn1Mfb1TkT2/+izGyPaHq5H3BXpyacRh8/ib23su5LN+Uo55G4AVr5RVNA9DoqNQlyK51vH+i43RQVf+6NGg+UzPnHTp88PvsYbuId1wIeggtP9g8qO7t6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759210845; c=relaxed/simple;
	bh=pi9ggdIueqWAZX9NkQOHMBKKVdGW4r+LwWfI6ICPVAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSNZ2iP/Id/4WGDD17vORSNJtOkkzwOUGFwdboy18EYGLXrFNztqYJ9q0+gwb+fd+z5kFO04wyY2p61CyJM0hkLY3bJ/7QDItBdZPnwXV63l7OybswgKUwXUvEa8YJ2OKcCzLK39H6XJNFIjJ3wBrFLHroSrVhxsVBmnVx8Y/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j3xoW1RL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HS40020349
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 05:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r1EPOK+3bFP/HMQmgol3DnPm/OIDlHf1/L95rTswwE4=; b=j3xoW1RLc8IUOJz2
	TS1eGY/XDWeNdoTohAGiHPBxf1jwntvP4rnEmWpNy/orutBZS1vJAk/nkOlE3Kve
	xPy4y0+H68HjOHYv+YJaWvMNlhjkdRf7sY7aSx8Mw5ISTxr6P7GxKsHIP6r/lQw7
	x7+pm8IQua4TUfI2ph8CDAbUHKiP6ra4QoprJIdYLoxwlvff6+VKf7lxgR0Pulgx
	odOYlQJWrNNIQH6ADD9ybip28U8pAAmv9jtxuNryk6fprQNoUfovYlVCwbjdgJrk
	5I0xuqUbWUQaVlXXBXuQiYR9KFY1AunajgBG+P7+LMcnkvlnLzOaaUuXvvvFAtuT
	y0d9Jg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5qtv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 05:40:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32df881dce2so5806499a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 22:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759210841; x=1759815641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1EPOK+3bFP/HMQmgol3DnPm/OIDlHf1/L95rTswwE4=;
        b=XniBbLQtdgwKXH5F3lzvrbjcPfrnYAJDIAkjvJD8mpQJZ6oZ4QY21J63vSvF1a5ZOG
         3U0WHWrmdHMJWfbKyDypkULHZo11Y29xnmMghbHhh/6+fhLc6BcFmw8QDRPkGJuaLeWX
         HHK1Oe6JIq1T4v4nHv4jklp1eYNZ2JQZ4NIYlbNzzQB0yS4maPF714lwhaueEryFwdX0
         qrZDMScgLVRpQ5pOADIZenXWjcZvbZWIxpdscVdIG90Uhxz5A5d7FuTBcDAtZ1cdq76k
         /gwI2PjBrds35KmOgZmHdUK0XQcM1zFTFnBq6jETBOYvw3dUDZTPPWjx6zPBmDlQLd4x
         Ybyw==
X-Gm-Message-State: AOJu0Yy8CpKsvOGck6/Qan1QDKYlntEavm+zjnz1MwiPCuzs8cw/w/ET
	EJdOjoQug9AYtDETZrp4Vo+uTj9Hq2lVGUawcQCu90v+mV5xH6d7X5uE0M1WoKtUzKmxF7MAJuj
	XBzbXie/uhMxY52y6yyldCeQrGdO3KvAYHUcJzTYHlJhtzl4LV5s2gV8QpO/aZfShhi5aJw==
X-Gm-Gg: ASbGnctMwWAypUDlXy3vqM6RVYudOzYaF8fqgu/EShxDIEtKCYk8tdAFEw+iCPgGKKl
	Wj2wJbtmRV+0UAb4wJ73/WVSvka9N8Htw4psuS5hZg5ib3utx8ULkiyGSIWHRFZ0gZELbSfj52L
	TgxiuUs0oCxPDDIQVSNRaKCRG4SRhDNTGg0+FkAsOKfwWA+U7vj3J10HeWWomvf4I76F0j35CIp
	5fFVfWHqvaQiG2b7so5yQ2dHPSZ7UcsYAR9x0qeUPrUi4V9m3fwXk4fJ1EmNshiop+HiUfC78nH
	ZA0AFlRxlrjtFBGCAReveJkKqhfPlH57qUATGRytlcwQBNQZb3dX1T/xvPWaGXiMLFaimNa//Zq
	XAWV2qxqNI2mgKi59hbTftutSGLzyVqV4aiJZmi4mMqk/FmQj+GYb3jek
X-Received: by 2002:a17:90b:2251:b0:336:bfcf:c50b with SMTP id 98e67ed59e1d1-336bfcfc8ffmr10828735a91.20.1759210841344;
        Mon, 29 Sep 2025 22:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWxFBfTEKrIu8D1dS8faGAi2Yui2Vgj7TW2JiI96lhPN3TSBio9xS5GJ/b/yp9t81jQPbqvw==
X-Received: by 2002:a17:90b:2251:b0:336:bfcf:c50b with SMTP id 98e67ed59e1d1-336bfcfc8ffmr10828705a91.20.1759210840886;
        Mon, 29 Sep 2025 22:40:40 -0700 (PDT)
Received: from ?IPV6:2409:4072:aeb9:bda4:e475:f0c2:aa83:529e? ([2409:4072:aeb9:bda4:e475:f0c2:aa83:529e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53bb255sm12995938a12.5.2025.09.29.22.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 22:40:40 -0700 (PDT)
Message-ID: <7ba48dd1-5570-275d-a360-ed3231fcac6d@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:10:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: free skb during idr cleanup
 callback
Content-Language: en-US
To: Muna Sinada <muna.sinada@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>
References: <20250923220316.1595758-1-muna.sinada@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250923220316.1595758-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4Idm9dBzgmVOL6cssc6hTGL3jSybWWy_
X-Proofpoint-ORIG-GUID: 4Idm9dBzgmVOL6cssc6hTGL3jSybWWy_
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68db6d5a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=c0CFwetPJ_w4sTF4psgA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX+g9bm+66EuEV
 lKpcQArkWEgD0pS8FUO+KooljKXWD7e8v06Cyio2WPYSULkM2J3EtfEm6eCd4OShQABXmMHyjL3
 gCLsg9AWNwKFbw4UxfxyIYQiWsLqA2UXCZVaZ3WQmDblZ3fgX1ZHGHkS67hXz37sL2PjfaW9pC/
 f8zlgoimiZfQWQ12/8sJ7qRBugJFvupTSFzfTsbwO+g7+OyIHxZVq2SDbC9lsBW/3TlPgav7HnZ
 4Pm+oIGuUSIxlIQHqcUOqQSfSoVnxAGb8wpnDQzRkbFsTkAEQMrI0sDgY8/HCHWCoAF4cVTiVov
 B1CupQkILYsaPm0xWM+agppTbjbVv4YN0MSxXGPvDgK+fpYrlMG93oTvpIjBjv9UihU0OBdepSz
 0ZkVFo1t0j57kJexLM1HNbXFnBOfbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018



On 9/24/2025 3:33 AM, Muna Sinada wrote:
> From: Karthik M <quic_karm@quicinc.com>
> 
> ath12k just like ath11k [1] did not handle skb cleanup during idr
> cleanup callback. Both ath12k_mac_vif_txmgmt_idr_remove() and
> ath12k_mac_tx_mgmt_pending_free() performed idr cleanup and DMA
> unmapping for skb but only ath12k_mac_tx_mgmt_pending_free() freed
> skb. As a result, during vdev deletion a memory leak occurs.
> 
> Refactor all clean up steps into a new function. New function
> ath12k_mac_tx_mgmt_free() creates a centralized area where idr
> cleanup, DMA unmapping for skb and freeing skb is performed. Utilize
> skb pointer given by idr_remove(), instead of passed as a function
> argument because IDR will be protected by locking. This will prevent
> concurrent modification of the same IDR.
> 
> Now ath12k_mac_tx_mgmt_pending_free() and
> ath12k_mac_vif_txmgmt_idr_remove() call ath12k_mac_tx_mgmt_free().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Link: https://lore.kernel.org/r/1637832614-13831-1-git-send-email-quic_srirrama@quicinc.com > # [1]
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Karthik M <quic_karm@quicinc.com>
> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

