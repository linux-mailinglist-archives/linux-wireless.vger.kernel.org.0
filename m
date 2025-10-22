Return-Path: <linux-wireless+bounces-28164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9308BF9DFF
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 05:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4146319C47F8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 03:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42848230BCC;
	Wed, 22 Oct 2025 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="er4xYD7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674A23958D
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105164; cv=none; b=EPx/Vl7sIez9KpMPeEdCPlp/RnGQhGICIHz+3jkJ0qp2tFCB0FoWKBw9bwACi3E3BTkYPueqxnQOqtP7b5pkc5Yiq5jIu5R6zoBO3XC0iPOstcl4ipeIQjZDkBJLatCg8BC5nXcq+PVY22skHRQ5sIqJ6DiMxmKaBMyDYYEzB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105164; c=relaxed/simple;
	bh=/MB/1AgfJ2nAI2UfvSMZDVVCLmWOM4snVWTPL/4iZPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3EA/oRdm+QLtrSNnUvBzGRuqWUwRsbJHz8dybImwBLLkRXvp5r/whmQ27yHOS9pYAsgxfL96FIA626zl2gZ99kgJTShTnfxcJNDDxgBxpMGzlBV55DVNzvMcV0tTTXaL7fpLvwGZIID/M/lMJQU04nj9IVbAUp/Adft5fsGYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=er4xYD7C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2WuRF002484
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y4lNQZxYTvh9O9n4SWl7qNzGH/So+jbEvJkWqptqjEU=; b=er4xYD7C4MA0tyqm
	S73ylOcsBNzHvDwPEYHGiN6iOo3GFUE9DjWEdZKSYsac2dhEu4K9Fs786KdwdziI
	BkZX/bFfTnKnkGHbZjn1gXpFTrUbBdIzJwPiN6pHbc5oapTbbagkT9Y+Zl7TCYtk
	QXUw6o8NMgeBaZXYIPYa7N1BorCxkWnUW+bKDdDf/ilWxYbp9hmia6E+8cUA2VUj
	nJc1gSCjQ8gekf4RgWqCOQ4mpVJgJWHKHeWRAdHY/DiTaQ3KOTP7q4lYVS33oG3P
	SGKrblPx/UbM22geYAQ8mkP7afSg3J0tE9YHT+cgnC1Wtyx5MPdbxsyZQjOBXYpT
	IO6cWg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w8qas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:52:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78108268ea3so480081b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 20:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105161; x=1761709961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4lNQZxYTvh9O9n4SWl7qNzGH/So+jbEvJkWqptqjEU=;
        b=XDDxWxD2ohniKQXYEHwb3m2DCxiM+oJsVoIg5eNVQGrRvRrc66Iu+rJymgf540VdrM
         1e4yFybhoPoRmTkzZi3OR0KOFwLoIZ/bII9y5mMy2SmXbr/Q1FMRQ8fNNS0ceySOaJ0E
         jenSZJl6xgxKTDxUGN0avzfOShDL7qm8jKlOEe0bNCaC0im9pU7RE3GIpYmsXIhhmgPI
         eBQaq+tK3hSs8PRa52pNUxTdfPhSuCz6eUVkLLW1hINLJSIkmyMdQmnAaqKJgbjw5yRB
         jhjTerpKtBvCOpUj0j+KviJVXBy6ije3gF56gQ6JchEFIXghuGzbyhaWZihQW6i0RD+2
         mj8Q==
X-Gm-Message-State: AOJu0YxKPq7HPCY/R++b3Evawz3BEme+U8S8PKYzAkKgQ037M3DmfP4X
	bnyLzP8lP8AvEs0RtbN9V3bRTGBdhvN8Xk1KEqwoYSSCcCx8mcYEVJBZ93JvovaVwQQXMa3Ow6C
	wbqAohx72DAkH6tEHmIz4AjfLA1dZDdFRecrdIUdHYgJ3FWvUv0RoAIT6Xp4Wl5y0VR4Vmw==
X-Gm-Gg: ASbGncv65UYr4UQrt0UCkw2MvrFAWPRPmz+4IEJbAAnqscuVatt7vS2CSpi1tIkzmK8
	7RxeJxe1ZHBbkMkd8bNt8FnhL+R/bxjMECVFn9c/wE+Mhvm0MsnGaT2olcriLx1kUs+VY5wFd0b
	ybB1ZoRXudcWBtmmSTXYfiu8Ki5VIQNJMDLuKgLc06TSM0OUb07h2KvPiAs37S62/S1QQzF/Io2
	JSRGQCNjDE3P1iL0b/vlSLweB1Xy7PhKHAiPMflX/R+Q4RpWex3B30twmFGvepTlEvtadBRmlwo
	yg2bIn5sSw94RVdGondohlDje+J6Yr5QS+XRuOeCUIsmflZtx2Kv7syMsB/9+3PH7K8w5uN43Yl
	mURw7Tvg1oeh/G3fGWDXy8p8NzMUUhk2wRay99sQcti/sc0U79Q==
X-Received: by 2002:a05:6300:83:b0:32d:a6c0:15bb with SMTP id adf61e73a8af0-33aa84d5528mr2511518637.31.1761105160731;
        Tue, 21 Oct 2025 20:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcaIk2TcrKaZPEOac0RHsq/qk84nj24Zjolr88lhyZR5q4OPREXggBrxHIXEqqlc+L6kwQzw==
X-Received: by 2002:a05:6300:83:b0:32d:a6c0:15bb with SMTP id adf61e73a8af0-33aa84d5528mr2511488637.31.1761105160232;
        Tue, 21 Oct 2025 20:52:40 -0700 (PDT)
Received: from [192.168.225.142] ([157.48.122.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3704f6sm1928087a91.2.2025.10.21.20.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 20:52:39 -0700 (PDT)
Message-ID: <ef3621a8-439b-4544-5fb4-4b46c411c526@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 09:22:35 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next] wifi: ath12k: restore register window after
 global reset
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20251017-ath12k-reset-window-cache-v1-1-29e0e751deed@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251017-ath12k-reset-window-cache-v1-1-29e0e751deed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eJv-JzJog0Pyw2N4dMjYgryBGbXaXYhQ
X-Proofpoint-GUID: eJv-JzJog0Pyw2N4dMjYgryBGbXaXYhQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX0RkiGrsAqZTm
 SmaDcJp5gsnAVCwPiojgOxo1pv6BKiSn8S8wbTiqQuO2cSBNWrOIfEoRm54uGLhjFbmJaEFH2n5
 rx8DgMCn5x8tRZow31qncwkN2QRzqzUXI2EODlfujhWhvQLmPEAmYIPpIhKKcUpt9E4AyeRP359
 2hDHmbFQ9Cp8HiKH/A249iy0lAH6Mp8ia58p8HdQ/hvhuNQ400zfDGElpJR1edcNKRThbOnRhb0
 ezJaPKtHUD9eS9UGwdSNmHQuLIStAKraT97rBQOr4xUg8OscjIojHAVCNFw/PTStjhyBMrFXd7c
 E9RRFRUDmvo+jJwl4X/LSBBrI9dMouxFZe9Y83bMkU4T43Ke0DxY0Herjc1nJReRfmCHWzAr07F
 tMH16p3m6ODDnLKkklzdEaVbFS0kxw==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f85509 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=MVWiM3nRykcdLg9H6cDE8w==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=EdpZZhp6GymIZaHJM0AA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090



On 10/17/2025 8:06 AM, Baochen Qiang wrote:
> Hardware target implements an address space larger than that PCI BAR can
> map. In order to be able to access the whole target address space, the
> BAR space is split into 4 segments, of which the last 3, called windows,
> can be dynamically mapped to the desired area. This is achieved by
> updating WINDOW_REG_ADDRESS register with appropriate window value.
> Currently each time when accessing a register that beyond WINDOW_START,
> host calculates the window value and caches it after window update,
> this way next time when accessing a register falling in the same window,
> host knows that the window is already good hence no additional update
> needed.
> 
> However this mechanism breaks after global reset is triggered in
> ath12k_pci_soc_global_reset(), because with global reset hardware resets
> WINDOW_REG_ADDRESS register hence the window is not properly mapped any
> more. Current host does nothing about this, as a result a subsequent
> register access may not work as expected if it falls in a window same as
> before.
> 
> Although there is no obvious issue seen now, better to fix it to avoid
> future problem. The fix is done by restoring the window register after
> global reset.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

