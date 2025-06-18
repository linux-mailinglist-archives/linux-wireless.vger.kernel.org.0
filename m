Return-Path: <linux-wireless+bounces-24228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39647ADDFEC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 02:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA7317D146
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 00:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B441372;
	Wed, 18 Jun 2025 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUL+bzaG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B364A1D
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750205710; cv=none; b=iGqumYonTvrV558KPLQJSlX5zFFeXbVgraGJdp90zEEkYApqMamGxa/55i3VGKN9/wYKY5CtoDhWE9+r66nvWS1TAYm9241FT/6Oi4UNBVPSmhfGjFsmdDOOo8sTCVxZIpmKIv/7uIZccNrbElYVrJkhRMQQz8/uUSX8NOBFycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750205710; c=relaxed/simple;
	bh=Q0RhZnRKUawatbYlSPR9jxTUBAU2HptYtrwsxSngQVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxJqvzQuLDIfG8PjDcAfrrBENExmQf4PtcHGCOpIp5wRrTCVDmUC3sSQ7hrjSpDH4oZTYU8B+z0FtKNDp/2JxvHkgy5vNg0QDsaYkK4RdWY0/+C2zqyZziu73pgNYSmunV6Im2mKA0k5FECH+bJ2W/EhkZYt6wz4aXGhxL0DlFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DUL+bzaG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEe1du005078
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 00:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MgLNj6bkVSN/WMao3i5lLQfbulXqaWbEHyt9/MPlHok=; b=DUL+bzaG9d1WoYEE
	Ws1g4FvgfO+UtdJ6Cr833UZLVCUCFxm6hJ8bKaFnUkBEE8Vbo8d08lfAr2Q6b1gJ
	cy1yURbZratX8M2Md6AN8HCfWYD9MzPdw8a0lapB52qnD3/vg9fbwaJ78E3zOifV
	1+3YTYPvWtvZ8hoLhwor/QuHSsRnct1EesIri8PrVMCZ98/TlxBx2WHFQMpaYqha
	pWT5feVbhzc4vHn6Lx8NioIg3kMUaX4E4YJJYTRN6NjDG6wzlPxHD8dY5M2HRM+p
	KjrmhgCgKpW0426151woP55AW27s0HcdQnJ0Hg3NMENSrOxeSSZn4YoYfLp8sFaq
	XsHqkg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag2366c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 00:15:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a517ff0ebdso15525311cf.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 17:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750205707; x=1750810507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgLNj6bkVSN/WMao3i5lLQfbulXqaWbEHyt9/MPlHok=;
        b=RPtwPLTxCu7n17Y07JABWVSu6GJLg6UxFZ+GxCG3E/oEZPyxwQxcwyRKtStKLI5LD5
         8txqPOELrTVY4GJDtgaQkMsGwI1jV29mYgpfq99T+puUC7NHpke/QppiWwz0quaiTDOv
         CQALwIbQUpLkMq7MFdSI/ucDlcryJDEg8vWPoc3Of0SgMTpkWO3HD/bTCj3mhioGmS9c
         armzTLILWz3k77NQTSUDHSeJrF+wtA7c+2X5V6r/zDiKEdwJdFoRV3QfC99WGkKUEzhG
         QaT8JEJFOC3uFZhHjByaqtbcaEg4fIrOpQrLvVzagKe8JUEvTu1M/cJsfcjvU6S3Afox
         bjdw==
X-Gm-Message-State: AOJu0YyLKWNOuXvoj1Q/yFMmFKLl9Mlaq738FcMMdZbVALU20cxPHyNw
	dAvRITljgksGr4GnlKPtwhAlFEB5m7mMeS9yqLoYBcn/8qeuk4wtPhJ/B26oDzEFz/v9YeHgqzf
	uy+qTiaL3vglT13cdvGYwRR6qx5n1e6HQsn3aWxFpgGscBhzEKIIZGxtcoDA9fxHEEkq/Uw==
X-Gm-Gg: ASbGncuPWpX0LIOmD+YFURI51oRPnz0QtpqxWCCJDmsetZ+beuHBh6t7+Dx1XHBwe/y
	YFgmJujJRv3uGOzS7UHDdg4TpxBHuArl1AtqwhNDwEoP8CKh8IQLtCFHi+9hvPJE3ag/rIzzYGz
	GUYsq9L+LhAa0fgy3WtaKlkJ9G1CBz6VR7Bd76lv/Mg2b5NIB4kT3bStvjyyrj60qVUmX575GqP
	bOLmZGdfq7UXccN0FZOImStH5UE/L0/7lngd/n1xBN1H+psQicTPGqCFrkU/Crt9TMaG8A/bYj3
	/a8ut/2vT6kRIS+KTrCKfNZkutOSMRwY2o7wScjgKkeS5x8A4M2nMy+f9WAUHhYI2yy2zRJfSyx
	1XAQ=
X-Received: by 2002:a05:620a:240d:b0:7c0:cc94:46c4 with SMTP id af79cd13be357-7d3c6c0514dmr873630485a.2.1750205706558;
        Tue, 17 Jun 2025 17:15:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIK+CPXxzG82QX19gNTVqz5a33l0jThlIMCopWj3tmHTu3IVIZXQDnrc8rrTNDOgn4ICOgWg==
X-Received: by 2002:a05:620a:240d:b0:7c0:cc94:46c4 with SMTP id af79cd13be357-7d3c6c0514dmr873629285a.2.1750205706160;
        Tue, 17 Jun 2025 17:15:06 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159e54sm943350966b.12.2025.06.17.17.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 17:15:05 -0700 (PDT)
Message-ID: <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
Date: Wed, 18 Jun 2025 02:15:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3 5/6] wifi: ath11k: choose default PM policy
 for hibernation
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
 <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fkkVQeZ7MfT8wsjcJTdELG0fHsXGhVM-
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=6852050b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=5O6acbNQFgkbtOqiNj0A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAwMCBTYWx0ZWRfX3HGpHJ1f4Yro
 8JjnHdrrZMCzFdSMBIAhvyC3ZadXtoSkTnl8kw0Q34cfCxXoHt9xpx6NIWV0mRQCKM/NpU+B7ET
 TxuCiBbtgo1Xfh4TCKreXRvE1sXMqFhrdIAtPd0pRsMcW3E+5Kt1T7VMzQ7MYCC/x5pAYOGIxAD
 xUpOx1Rq9ykTxrmEIOqJsmaQn3sq7L4OjMibi36tKFSvSfG1jT2Z0jYHYizg4VUUC+xeUjca9jH
 tZm1pqckLOVEJF9OQPmEmNakvTnMSXF5lWOahbcAJd749gh1HdgSieHUNBkXuw+nNbW9uLAzxAl
 UhiGJYSE65/dwU+kcQSirX/KULF/2BQHgMyYYi1Mj6iviqOoHtrhtFSF5J4Aum+C54MgG07BZCs
 IkeQJaJnUest7qMjStu2+0e20eozyKKmccJmuCS1nO27a/pBt0rw/4DxLJ8M9GvOA+dTUXyu
X-Proofpoint-GUID: fkkVQeZ7MfT8wsjcJTdELG0fHsXGhVM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180000

On 3/28/25 6:32 AM, Baochen Qiang wrote:
> Now WoWLAN mode is chosen for those machines listed in the quirk table.
> This works for suspend (S3) but breaks for hibernation (S4), because
> WoWLAN mode requires WLAN power to be sustained, which is not the case
> during hibernation. For hibernation, the default mode should be used.
> 
> Register a PM notifier with which kernel can notify us of the actual PM
> operation: if system is going to suspend, the original PM policy is
> honored; while if it is hibernation, overwrite it with default policy.
> 
> To summarize: for suspend (S3), WoWLAN mode is chosen for machines listed
> in the quirk table, non-WoWLAN mode for others; for hibernation (S4),
> non-WoWLAN mode is chosen for all.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Tested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---

I've bisected the following splat to this patch, still happening on
linux-next/master, WCN6855 + SC8280XP CRD, 100% reproducibility 

[root@sc8280xp-crd ~]# echo mem > /sys/power/state 
[   20.267830] fb0: Framebuffer is not in virtual address space.
[   39.863070] PM: suspend entry (s2idle)
[   39.908067] Filesystems sync: 0.035 seconds
[   39.934453] ------------[ cut here ]------------
[   39.939259] Invalid notifier called!
[   39.939268] WARNING: CPU: 5 PID: 513 at kernel/notifier.c:79 notifier_call_chain+0x84/0x1a4
[   39.951566] Modules linked in:
[   39.954732] CPU: 5 UID: 0 PID: 513 Comm: bash Not tainted 6.14.0-rc4longbois-01215-g32d93b51bc7e #12177
[   39.964396] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023
[   39.973609] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   39.980777] pc : notifier_call_chain+0x84/0x1a4
[   39.985457] lr : notifier_call_chain+0x80/0x1a4
[   39.990135] sp : ffff800087e63b30
[   39.993559] x29: ffff800087e63b40 x28: ffffb17be1150da0 x27: 0000000000000000
[   40.000913] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb17be1723000
[   40.008261] x23: ffff529452a99ac0 x22: 0000000000000003 x21: 0000000000000000
[   40.015607] x20: 00000000fffffffa x19: ffff800087e63ba4 x18: ffff800083e7d088
[   40.022953] x17: 0000000000000000 x16: ffff529452a9a3d8 x15: ffffb17be1a81420
[   40.030296] x14: ffffffffffffffff x13: 0000000000000003 x12: 00000000ffffefff
[   40.037642] x11: 0000000000000001 x10: 0000000000000003 x9 : 88af25dfec9f7000
[   40.044988] x8 : 88af25dfec9f7000 x7 : 0000000000000000 x6 : 0000000000000000
[   40.052336] x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff800087e63818
[   40.059680] x2 : ffff800087e63820 x1 : 00000000ffffefff x0 : 0000000000000018
[   40.067033] Call trace:
[   40.069573]  notifier_call_chain+0x84/0x1a4 (P)
[   40.074250]  notifier_call_chain_robust+0x4c/0xa8
[   40.079108]  blocking_notifier_call_chain_robust+0x54/0x88
[   40.084761]  pm_notifier_call_chain_robust+0x2c/0x4c
[   40.089881]  pm_suspend+0x1f4/0x628
[   40.093495]  state_store+0x6c/0x9c
[   40.097010]  kobj_attr_store+0x20/0x38
[   40.100898]  sysfs_kf_write+0x58/0x78
[   40.104686]  kernfs_fop_write_iter+0xe8/0x184
[   40.109181]  vfs_write+0x2dc/0x308
[   40.112699]  ksys_write+0x80/0xe8
[   40.116135]  __arm64_sys_write+0x24/0x34
[   40.120195]  invoke_syscall+0x48/0x100
[   40.124071]  el0_svc_common+0xb4/0xe8
[   40.127853]  do_el0_svc+0x24/0x34
[   40.131286]  el0_svc+0x58/0xb4
[   40.134450]  el0t_64_sync_handler+0x114/0x130
[   40.138954]  el0t_64_sync+0x1a0/0x1a4
[   40.142747] irq event stamp: 17062
[   40.146269] hardirqs last  enabled at (17061): [<ffffb17bdd587204>] __console_unlock+0x5c/0x8c
[   40.155129] hardirqs last disabled at (17062): [<ffffb17bdeb6bd24>] el1_dbg+0x2c/0x80
[   40.163186] softirqs last  enabled at (15294): [<ffffb17bdd500a98>] handle_softirqs+0x38c/0x3dc
[   40.172137] softirqs last disabled at (15289): [<ffffb17bdd480204>] __do_softirq+0x1c/0x2c
[   40.180644] ---[ end trace 0000000000000000 ]---
[   40.186333] Freezing user space processes
[   40.192527] Freezing user space processes completed (elapsed 0.002 seconds)
[   40.199721] OOM killer disabled.
[   40.203083] Freezing remaining freezable tasks
[   40.209029] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)

Konrad

