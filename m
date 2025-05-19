Return-Path: <linux-wireless+bounces-23162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F9ABC5D8
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 19:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F6B17A9EB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5221288CB1;
	Mon, 19 May 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMrcCWiW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E617286416
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676893; cv=none; b=f8dVEejX2kS2P4uUo8uVJ1hhN1oJOJgDS6I2ix5HsW1ighkh3DuUlk10UkhpVXm8+dnS2fkP2Mhp4D70v48HcWN7SQKCHr0AqluC5Gf37LrUC2RoVDFTcZ6PRUhOeBOnRDt8w3OCOtyJoA1xKklBKyNGGdRpxb+IjSBZU/OwXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676893; c=relaxed/simple;
	bh=yTLBi2JfjilFHuvzH0mtehz5/98aqUg+Xjww+lLuHsY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bbyZK8OpVsNIDtYqy6x1HUGWBMtUN6uwMiSsMM5+IH+MVKkgEKXGzdDcfPwC1589yg9sghI5xQawlxxvJrzkcgkDN6N3pDuZ06TiQhrX9rIfFTKsuycEu2j1g6vANVH+4QHw9vF8AWN+LrhWQUa4VDbsGk6JlhsZIjWRKYs8JH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMrcCWiW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JDhfl7028704
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4EvE717nSURiHJFlzxR4FQmeEPs6Iqvr2ySq5HbVy9s=; b=DMrcCWiWYpRTnJ5Y
	Nii4FXwK1pg1FaUeVsVgOk3OQu7e8sFyb0MmVfarOci+9hKrBklYLOrAeL0SAKdt
	2/r+8h5NFXGfa3daU1smsxXXQSY4XJwXffkx9FpR6/COnB+MfoPernVkpTEl5FKQ
	06JZqZB06iYXMUwdNriht8WUVTz/S6rM/7LOebSOb/GFQxzlNUHxo5iWtDdamvAK
	qBrB5qRozCwThnQskWrFPyF1vb8kSczmJlE1oh4d181xkYlRxM7/AZIItSVU6QoH
	ipVC4SIGOeJ+CxV2+QK4Pd2Rzk8uY0FRmBtnFWYDTH+UsPWDMQixtmoOokxtgPa3
	XA4GNw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pju7d5uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-232340ba283so12083415ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 10:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676890; x=1748281690;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EvE717nSURiHJFlzxR4FQmeEPs6Iqvr2ySq5HbVy9s=;
        b=dWRg9TpUR5IFKREydA3RdwJB5M9j9js04jm75NqpvaZctoHEvfkmNIYzJ75PRcqNdQ
         4OhYfdxTguYELIwzC9XDvdLsqaZ98Kc0KgCsU8SWcjrQeZl0cr4pT9+EntFDpw187azk
         JqlU8WzmjZcSNXU2E2LmLFSPt9BeYNpTxCLjA+0vybgotRqf0xhqwFk698Zr1ztDV5Fy
         ShHIimwBBs4zlXrSBDbs4pYZ0avMBfodreENHNyKQRBQyZMa9LJgFPaTq449JZ+D/msr
         KpS1q784UCwC+DjwtnF0xDm1v6pKTd1ahL33smJ+8CSFjS7ViC9O8lhhGjiNzaRpSlXK
         qETQ==
X-Gm-Message-State: AOJu0YwQDNh1J6dkGXTJYz+6ddaYn9ZwaWfXadPkni6HNk2mwBQ2htJs
	1vMfG9YBQ7SsCmjWhX6m14TRDWHMOY6Nzx82LwFslWfm8W99maeP+DfQjgxBW/qbP1VfItcRYN3
	WCoEOnq9M/U4LUtqgZVuTUcLJH06mOjs3ak0jPnr08Ztxihjx0yB2ikDU1FJIpsrXRn6qbA==
X-Gm-Gg: ASbGncs2VLKmo3xEp6RngMt8Hvd64oomR0Xhk/wsTLx0sGmBJB3eHc9bZp17IvsX8Ib
	yZZ/ol7VQdsM+b4hEbEA3yIlb6OChorRZp6qnjz/dktfwv5zDPqIFmNHNuaiLsK7IMkOgCP3IjO
	2aOceMG/6QNi+h19csjTSbosUW5hlNVnbJlsN559d8c/7+3HbKMJr1weoLXRk+TrzmHIBjpf5lL
	+p6Qu6qLzlcF2s6E33Pbtsraw60s9zbjRyPBMLMzP8zMSWAIzJEaukgyZhYD/36yR/PDo2xllFX
	hpmjazxrtw+/H7lo8iBo+7+jCedPfoBheWnVXyD3boHCjr/z
X-Received: by 2002:a17:902:e84e:b0:231:c9bb:6106 with SMTP id d9443c01a7336-231d4d057camr192248285ad.9.1747676889867;
        Mon, 19 May 2025 10:48:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNW2vCmCXCEGgZCIscf+26785zhmH3GyWS4omLFzEgXb2bZGYtEkjCKGC/tS8DJuBz5Qr+LA==
X-Received: by 2002:a17:902:e84e:b0:231:c9bb:6106 with SMTP id d9443c01a7336-231d4d057camr192247985ad.9.1747676889486;
        Mon, 19 May 2025 10:48:09 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe8b0sm62651425ad.89.2025.05.19.10.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:48:08 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajat Soni <quic_rajson@quicinc.com>
In-Reply-To: <20250430-wmi-mem-leak-v1-1-fcc9b49c2ddc@quicinc.com>
References: <20250430-wmi-mem-leak-v1-1-fcc9b49c2ddc@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix memory leak in
 ath12k_service_ready_ext_event
Message-Id: <174767688852.2567051.14152574284720219609.b4-ty@oss.qualcomm.com>
Date: Mon, 19 May 2025 10:48:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=XKEwSRhE c=1 sm=1 tr=0 ts=682b6edb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=FhvEbofts4Y-0ieg6voA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: cAxXVW2cBVoXIC_9xcb1PnPBtUSzP3m8
X-Proofpoint-GUID: cAxXVW2cBVoXIC_9xcb1PnPBtUSzP3m8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE2NSBTYWx0ZWRfX+/G5f7NhOHQ/
 XQv1dXw/JiE8f40hHnTMWx0WKyb9fDBy8XDKevKFkpz8ZinUzQiTrsofNfIybKa0vssG1g7J99g
 SDZZ/KBPp9gX4/Fw5dL/jI6DeFbscVJrHPvuySoR6rQQjgAQ2IIkAjeuRIAwRLIjJChYBO+OTL/
 JMACP8w+P5Zwl9H4ppJpB9I669EHSYHNv5GQGEpdMpEFkIpD5pii7M/YlkobMICNqiyulQ91tIY
 C+/TSvrpcYOJL9PpdI96ysSfHeq3ZhI+CO5CWz7FOAyd8XdzbQAspmPox9E4B15fkjDBdnzfjj2
 H0cZpQnFwfOkLZ1FeGgVoajeFIKSBsLGvkiGLbXbJQVBE4N9so/oqBphjEjfRbqwn3b3f0Dglxp
 m+vppwxGeAq/ZUk5Km/B1s7BkRdxCLIKoh3oxe7exq9kNMXkW9oUn4zs4AT/xsc/toMOIHJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190165


On Wed, 30 Apr 2025 10:25:38 +0530, Raj Kumar Bhagat wrote:
> Currently, in ath12k_service_ready_ext_event(), svc_rdy_ext.mac_phy_caps
> is not freed in the failure case, causing a memory leak. The following
> trace is observed in kmemleak:
> 
> unreferenced object 0xffff8b3eb5789c00 (size 1024):
>  comm "softirq", pid 0, jiffies 4294942577
>  hex dump (first 32 bytes):
>    00 00 00 00 01 00 00 00 00 00 00 00 7b 00 00 10  ............{...
>    01 00 00 00 00 00 00 00 01 00 00 00 1f 38 00 00  .............8..
>  backtrace (crc 44e1c357):
>    __kmalloc_noprof+0x30b/0x410
>    ath12k_wmi_mac_phy_caps_parse+0x84/0x100 [ath12k]
>    ath12k_wmi_tlv_iter+0x5e/0x140 [ath12k]
>    ath12k_wmi_svc_rdy_ext_parse+0x308/0x4c0 [ath12k]
>    ath12k_wmi_tlv_iter+0x5e/0x140 [ath12k]
>    ath12k_service_ready_ext_event.isra.0+0x44/0xd0 [ath12k]
>    ath12k_wmi_op_rx+0x2eb/0xd70 [ath12k]
>    ath12k_htc_rx_completion_handler+0x1f4/0x330 [ath12k]
>    ath12k_ce_recv_process_cb+0x218/0x300 [ath12k]
>    ath12k_pci_ce_workqueue+0x1b/0x30 [ath12k]
>    process_one_work+0x219/0x680
>    bh_worker+0x198/0x1f0
>    tasklet_action+0x13/0x30
>    handle_softirqs+0xca/0x460
>    __irq_exit_rcu+0xbe/0x110
>    irq_exit_rcu+0x9/0x30
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix memory leak in ath12k_service_ready_ext_event
      commit: 89142d34d5602c7447827beb181fa06eb08b9d5c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


