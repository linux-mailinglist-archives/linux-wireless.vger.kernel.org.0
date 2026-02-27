Return-Path: <linux-wireless+bounces-32304-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOkOH1XeoWlcwgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32304-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 19:11:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D50861BBD09
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 19:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BCC031C3F20
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184036D4EF;
	Fri, 27 Feb 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5VlLQah";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c00NRHfn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE8136A00B
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215045; cv=none; b=Yd4369WuoeCTjAcX0NNHq2oZ6l4t1NTNZ4cQqHKNP2h7KvtFYUap5L4iSJujN44L5/jbwexDhZN9xDBAYB9cN5K64qsKuCkrrACI1x5lpiJ4Go9mISmmMw08KigsgXITMf1wYSKyt7u+x2hldF7wcJ/zFolWAry6sDKLhUPUQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215045; c=relaxed/simple;
	bh=wrGRAF77WNsq+Pr3+saUmH4BPaBHLQoLZnbWDj8y6eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzQB/RjBNsIEKyI+7ge12Mcx0k5Yi4mLHrWxj5Fa483ySCg7qLex/h6L8KpPV76i8BFAPrXBY0v0YLtwCg2TyQ+5fCEjIMGGFbYE0L7sMt/yAtUT8pVm7a6jG9IU6pxjAlxTpxEHYZ1ZMeslcuetRhD/PkCcH4lFjApx4QBVXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U5VlLQah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c00NRHfn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RH0MwE065415
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 17:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5sCMFWHlvz+lbH0QqSntyyBEL8DzwJyz9HtkNf8tZ3Q=; b=U5VlLQahF79zpRqi
	C6Jrv9zI43Tgvi/+lomLn4qV2drVHlbrai20z8clYwc4Kj6gFGDQgHS/TH7a2gQV
	IgmqRi1v5QEsldz3cGT4LFLR4a+89knJIWB2NG8KGB+uNMfaeku2sN8Lx2eHCe1W
	IgkY9cf4X3xJ0zPFHnoH03XeMjYreK+zO4ePmlW5eHaL1Z90gjDGrZhYxCxBcU5P
	uGsQRxwp8qq9+v1gZMWQ10r2f83mAcRs2v+5yQgCIybCvC7Ino/wKkbQ+yQ7hFLD
	AZV/5YjR/PFtMQdcpyuFPmv+bO2bpT9AYhdr49xChtAqp3ThGL4y1e0CMGjGP8iV
	tafI/Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cka2xh8bp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 17:57:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6fd07933aaso1314479a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772215041; x=1772819841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sCMFWHlvz+lbH0QqSntyyBEL8DzwJyz9HtkNf8tZ3Q=;
        b=c00NRHfnDKKs8h1Gep5zrhpyA2qMUF2qh03DjUlwb69Cz8q01Pd8MN6PIFbhNoG5Up
         h1dwfUXpEjYZDKNLl5lQ0++8BwNGg/xUX2VzjU1TphilLsioWXvMWCJxI7MAd0rSR/xB
         o0bkgTQY4H850XQ9Du+g27rFVyc3Xv8FKwqAQpwzVbOVfDjiqRZ8xTWSs/KjhvzUqLB3
         RA6SNmMFBvSuCOAN2StSSMcsvOLSvXOj1D07u8PbNz96wFEeHQ6Q0PdeclN3YvknB86N
         +gWzyJKPkIkHX6VxgU2X2rCZNQZoD16N1TzZryuUqyTBDAJYQFqSuuslJ3XZg4XKrXgM
         YA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772215041; x=1772819841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sCMFWHlvz+lbH0QqSntyyBEL8DzwJyz9HtkNf8tZ3Q=;
        b=L6FRQtyx3R3MIlT3SbxWaRQFSvQcPuLVIfh5EsjxFwj42ygbJ1Az8Jkh2Yh84PCldB
         deKK6+E1Cu8Hh0hKhguSbmSmcoc/MDUV4/fYuxELx02z+ed0tYSmtRILtV4tj6umTfmE
         FluvbXo8OojVhOEji6WINRCsVadbdCCakpFXD6HOWs7lZv+EgBQpEAofR1HfWOXIH57Y
         d92ghkMqJ21kDspTAoKEYaYskPBJqrHmhcCvpoe5ipJW5ZiXXN+pcAw4uRxDYSzj71sZ
         u/bAEaQ6K2oJ7OB+Y7JV5wQGjb5v3c3gGa6gN4T5D0gr/Uo4CYSr11lekm2jxauxIL6P
         QQog==
X-Gm-Message-State: AOJu0YyhrNyvhlXmRo+HFrcLO5y7GQjR3Xrf1gNeC/MObxkdFUQ3XSHS
	8MzGRtALqNUExwJFUgTxzy9hP/Xcncp6acPhkAS8bssy2vX7J2Cee6yFFUfZSS6W4xCsvMQ8YJM
	9HWvaE31MAdWoepPrwHASYb6K6AFyX2sW28lYLCjC4lTuObyDrHdCcmJAF+PQ83TkXYqHRMJQ62
	EUBg==
X-Gm-Gg: ATEYQzy3qgZOq9K3+GHwLDWBlsiUQrZKqLSPHE2ee2a4klnUc7lNvU+Yt+rPd8lYa9O
	ICL/LJFn17pSFu0zTGebMfLvOTM8vysmm9EFccvjksiIDzjTb1YtPZSc39r/Qjw7gT7GV3wsbJb
	hufik7fcQ/2cjv91BJrXGixDt7IP7RD33mFCn52zH9TM9AVGljyHsEhA0jx1p45k/ZENi+NJpj+
	s7lA9HpweuAEZLlq8ygTGqykVl5DZuFY+GGOq/lP+z1TPVQ8Pw0QSRJDV3K0wLdYtxhdNj58MhC
	MwYlgEEl+11DTzxHwLFFGrPOCrpLmqIRbjP/IVIEzkh2BV5YJLXEn5LysJFYAho5ol1bxGeq1II
	vMV1QuCAerPlVG+V31KgTNuiYQPP5Y3BxkJC0E7T6MHjlbR2UrY9I4cI+O2/B0DLgj+lJhYX7JQ
	==
X-Received: by 2002:a05:6a21:514:b0:38d:ef23:12cf with SMTP id adf61e73a8af0-395c3b4d467mr4418712637.61.1772215041339;
        Fri, 27 Feb 2026 09:57:21 -0800 (PST)
X-Received: by 2002:a05:6a21:514:b0:38d:ef23:12cf with SMTP id adf61e73a8af0-395c3b4d467mr4418683637.61.1772215040780;
        Fri, 27 Feb 2026 09:57:20 -0800 (PST)
Received: from [192.168.225.142] ([157.49.228.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ef857sm4892615a12.7.2026.02.27.09.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 09:57:20 -0800 (PST)
Message-ID: <b8626b5b-7f2d-4f00-aa0d-27daeb5f971b@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 23:27:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Pass the correct value of each
 TID during a stop AMPDU session
To: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260227110123.3726354-1-reshma.rajkumar@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260227110123.3726354-1-reshma.rajkumar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BOC+bVQG c=1 sm=1 tr=0 ts=69a1db02 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=PtQaxW6Z2JPlFy30ps15hQ==:17
 a=vkfXM0Oplov9zySb:21 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bfulyJ3BcDXNzwfwHewA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: HtMkj0hJoNTRLVicnbFHSMVo1rwAioLg
X-Proofpoint-ORIG-GUID: HtMkj0hJoNTRLVicnbFHSMVo1rwAioLg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE1OCBTYWx0ZWRfX1epOAm1E/OLX
 qmuEHPXwK5LMOIsrVUGGdJ9i0m1Vm2KO619fz6aavXtALVv93wIZXt9TUZqRmV4tbYNIkOcOpE8
 9NWgckrxOECx53cU8//nAob0SflfiCI4QBopaqi5K6l9DCuCgnuLo1JNYNLw2dQIB+lc8py9ndo
 2JpN1yw/I6J2ME3I6BUmNX7VAL8rG5WoBE7RNOrKJuklfBTrnbitWvBO1lXjzN98V6wD6DScX3p
 +jSWZlKStD3HXEYlGVlp2yqL271VrTl9Wwdau4xI/CXbhtlBxkwxT+0MWzlAH+O3DINQBEh+Xj2
 UfEq7YuCrayac+CBvOxuYBDRMyv+yzlJba8BhwBjme2Yzvc0OCKy3Ezmu+1f5zmP4FsLWZt3EFE
 jpjd9Zc5FxggGQCPyfbP0exggfbp/tMjPk4g0omo+9uE+IAppeYbhRnkWNj4Di3WfyKb03Myw4g
 v68HnC+/uw8i0SI32Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270158
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32304-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D50861BBD09
X-Rspamd-Action: no action



On 2/27/2026 4:31 PM, Reshma Immaculate Rajkumar wrote:
> With traffic ongoing for data TID [TID 0], an DELBA request to
> stop AMPDU for the BA session was received on management TID [TID 4].
> The corresponding TID number was incorrectly passed to stop the BA session,
> resulting in the BA session for data TIDs being stopped and the BA size
> being reduced to 1, causing an overall dip in TCP throughput.
> 
> Fix this issue by passing the correct argument from
> ath12k_dp_rx_ampdu_stop() to ath12k_dp_arch_peer_rx_tid_reo_update()
> during an AMPDU stop session. Instead of passing peer->dp_peer->rx_tid,
> which is the base address of the array, corresponding to TID 0, pass
> the value of &peer->dp_peer->rx_tid[params->tid]. With this, the
> different TID numbers are accounted for.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

