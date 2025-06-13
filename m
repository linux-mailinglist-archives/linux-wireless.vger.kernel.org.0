Return-Path: <linux-wireless+bounces-24092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11758AD8CA8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 15:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393267ADA98
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E62AD21;
	Fri, 13 Jun 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="boyWahHn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79660F4FA
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819615; cv=none; b=BmjodAG5fpSUgDwHgaHVEHaNmrMN4c9HX/X0FUXNs5i3BnbLKMAfqoVOo9hJLX0i82swgVhIvvIc2ONf6yYu0zGkO6+9k/+ukypdePSuak7VbdBejUBeRGXN50bJEPQdzOKtM28Wip40PRwccY9wTrxp0V0ATOyMn9IKNXtiD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819615; c=relaxed/simple;
	bh=DqSlNDVwqrMMqPQdPfHObgryc6GqTjt9vVn0izUEAzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA2w3wIeh4V2EmEj6gdpJfCfs0r9w6cIEdysEp8BWB6egt5KeCtZkBQln8jcWvUaxQHxu59CAYaoC4rNFuRyKlOL+kTHmxxdzWZGVSKtO7Rs/DscCrUKBrWNqwSz4Qb9ZzKnbvl2/t+wMqyrR4o15h9BGxH8HFiftOsN5caOKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=boyWahHn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D9AqUg027161
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 13:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6eKtgM9vr74wvYivbQKkfWU15SlC67xuKSLL1mDKqTU=; b=boyWahHnWr06MmQj
	Tp3Qgwtd2Aa8rgamMBWFVB9MXwXuz2m+8qAB/ZnD44Lva8s+SjFomrXe1P59St9z
	8Shm7j9xK0eave+vRMvm6G51hrIq4r92xw4u39MblxbdQ+g4crVbswtt/1yKH4AZ
	OSQyF2KNi7X3b/FaF28JsryyNLkSKXXLj0oTVgcT1BAKsnS4/4r3pKgg8VI63n2P
	wZBUYNLrFbdk3oPHfp5a0zdSwVoBVL7pd9pvvPwrH2hVc1wGpbdLZDm/fVTE+dj8
	xsYI0r/i8kaPGQt4mJrX7ELW8ukMe7yNRDSJWdq1Rj+WXOk5NYZFP6Tgn3ZYHpL9
	xwDPvQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ccvkg7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 13:00:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a589edc51aso52980211cf.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 06:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749819611; x=1750424411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eKtgM9vr74wvYivbQKkfWU15SlC67xuKSLL1mDKqTU=;
        b=iVliYMlRPW62SuKPBr4P22tGRj/wTfxbVcGELiJry3rC7joaxF8TApi71IlGbB+HQ1
         nKrkUh44g07bRsFLRLaDYSWbPTqVf1fENYHscSatuYOH9K+6eWo9sKtepKz2pXFtbvsj
         ClD5g8hOeASGu/QVGsZxRTxu9Jw6Tg+t0J2Hpm/HAvSWi9duec94TZX3JVDeazW41ivO
         vw0yX3PUZq4SzXzqWRga9roYia5KKZDnq5SCA/OvxvPPoSxaxRT4lO0hwFw7Se2JKlLG
         KCgpecoRRw41skMU6T9bl6wRuPWLVStMGYi+IjmuGXKoGE2qVHBuOmeqzsDUC9WyrkX0
         Toag==
X-Forwarded-Encrypted: i=1; AJvYcCXyOfUtJzuW75a9971KHBwy9u5SAV7sjCTOhb96AWoiEIuUvxZ8I0rHcT78Fef1rBR6aSpNjT1on2FQrMauUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Qws8A+YV/QhsJuT7kSyuVGPM5wOUl16JMPR7coDH9e2JEmLb
	q9ZIh+ZIc4470YOWd4BQUZwtcCk2Wx1iPt6qOJJ4jsRC6LlmKOHC6fmB3YIT40yL36Y7/596Pav
	gr5IeJAtOKxWszqWHz5HzPdm53ycG/mXBFsRHJbHt+q6bAfdeS9Q2zchEKXToGt89Y1+/gRDIhm
	JZjC8fwUHnEpMp9NP+tfY5A7FSoqYzwomMNAzWnZHWJVJdJOegZEa2uXA=
X-Gm-Gg: ASbGncu9mHchCod/H9v8DZe78KhsiNrnis6vnVsaD6moB0D8MfiGQPJurCmyS24hQDn
	f97gSQpXimoNG1wztsk1lxWSIlDOvtUzaTt4KusWn8dXtmE9lM/COe7Ft9oRwKxiKHvjDpXUEdc
	CPxthY
X-Received: by 2002:a05:622a:191c:b0:4a6:f81a:4443 with SMTP id d75a77b69052e-4a72febff3emr46131471cf.5.1749819610684;
        Fri, 13 Jun 2025 06:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXhNG6pAdisKV7R1YfNX3Tz29W+wdEkFARPRWMHpVrGeJOR7PMTBJg1AXBwf9frl/H7mWHUApAgcQdcqI1ZPA=
X-Received: by 2002:a05:622a:191c:b0:4a6:f81a:4443 with SMTP id
 d75a77b69052e-4a72febff3emr46130171cf.5.1749819609968; Fri, 13 Jun 2025
 06:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610095455.1443-1-kang.yang@oss.qualcomm.com>
In-Reply-To: <20250610095455.1443-1-kang.yang@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 13 Jun 2025 14:59:58 +0200
X-Gm-Features: AX0GCFuLIWwZKM6UXeyyTu0fXzTOnTClBNkqGI5RIWNfgcxN0MiSPe6rLnnSSvQ
Message-ID: <CAFEp6-2VOQRdYCzW1gjr71L0LZrYK5DFocUGnNoSuvAiQ32CDg@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: shutdown driver when hardware is unreliable
To: Kang Yang <kang.yang@oss.qualcomm.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -g8nYi_A96G0I58zrQeDRa3bLSKXqNec
X-Authority-Analysis: v=2.4 cv=TsLmhCXh c=1 sm=1 tr=0 ts=684c20dc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=EUspDBNiAAAA:8 a=PHlRw_kzcNOPMu9nZAsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: -g8nYi_A96G0I58zrQeDRa3bLSKXqNec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA5NCBTYWx0ZWRfX4T7F7Om/tMib
 RYPuaVHYvH37/5Oqlw/CnFb1AxYJeKlLbv3AKr6385vdtSMIz7hLfy3kVs/Vjrb+CJVHHnjejC9
 JeCNqe7jwyvZLbuKcY/mFDKuNVYnL1UJF0Y329s1OTBniCZduM5rpNf642DN7k4AYpjQ0D45CnL
 +sOzTCGIePsf6yauhbJLbtbK3VwprowA62nK7cgydrFikIaOPipN0OSYSYaFw+uHgWZdQ40LyQ+
 nAdajPsNCVHmgQ1N4e2beuHp/TE+sPupLPQ9wRTpVchj6FiL8ub6MqqZo+ow/PEwuCz4j/jH4kW
 vHqGEhCg2Uo1mAm8YJ1uLG+M+Cf3+fg9I2I1vbnCwWuyzkszmgGvZ8xOwc9wVTh4ympcXJcyv7O
 2G5OPCjp2Cd6WRaCjTDee7cWmPokvP+PF8lD2YxnqWTWb9Aa2OUBjAIp8CXqWmRY0n999DkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506130094

Hi Kang,


On Tue, Jun 10, 2025 at 11:55=E2=80=AFAM Kang Yang <kang.yang@oss.qualcomm.=
com> wrote:
>
> In rare cases, ath10k may lose connection with the PCIe bus due to
> some unknown reasons, which could further lead to system crashes during
> resuming due to watchdog timeout:
>
> ath10k_pci 0000:01:00.0: wmi command 20486 timeout, restarting hardware
> ath10k_pci 0000:01:00.0: already restarting
> ath10k_pci 0000:01:00.0: failed to stop WMI vdev 0: -11
> ath10k_pci 0000:01:00.0: failed to stop vdev 0: -11
> ieee80211 phy0: PM: **** DPM device timeout ****
> Call Trace:
>  panic+0x125/0x315
>  dpm_watchdog_set+0x54/0x54
>  dpm_watchdog_handler+0x57/0x57
>  call_timer_fn+0x31/0x13c
>
> At this point, all WMI commands will timeout and attempt to restart
> device. So set a threshold for consecutive restart failures. If the
> threshold is exceeded, consider the hardware is unreliable and all
> ath10k operations should be skipped to avoid system crash.
>
> fail_cont_count and pending_recovery are atomic variables, and
> do not involve complex conditional logic. Therefore, even if recovery
> check and reconfig complete are executed concurrently, the recovery
> mechanism will not be broken.
>
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
>
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 50 +++++++++++++++++++++++---
>  drivers/net/wireless/ath/ath10k/core.h | 11 ++++--
>  drivers/net/wireless/ath/ath10k/mac.c  |  7 +++-
>  drivers/net/wireless/ath/ath10k/wmi.c  |  6 ++++
>  4 files changed, 65 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireles=
s/ath/ath10k/core.c
> index fe3a8f4a1cc1..f925a3cf9ebd 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>   * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>   * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights r=
eserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>
>  #include <linux/module.h>
> @@ -2491,12 +2492,51 @@ static int ath10k_init_hw_params(struct ath10k *a=
r)
>         return 0;
>  }
>
> +static bool ath10k_core_needs_recovery(struct ath10k *ar)
> +{
> +       long time_left;
> +
> +       /* Sometimes the recovery will fail and then the next all recover=
y fail,
> +        * so avoid infinite recovery.
> +        */
> +       if (atomic_read(&ar->fail_cont_count) >=3D ATH10K_RECOVERY_MAX_FA=
IL_COUNT) {
> +               ath10k_err(ar, "consecutive fail %d times, will shutdown =
driver!",
> +                          atomic_read(&ar->fail_cont_count));
> +               ar->state =3D ATH10K_STATE_WEDGED;
> +               return false;
> +       }
> +
> +       ath10k_dbg(ar, ATH10K_DBG_BOOT, "total recovery count: %d",

You don't need a newline.

> +                  ++ar->recovery_count);
> +
> +       if (atomic_read(&ar->pending_recovery)) {
> +               /* Sometimes it happened another recovery work before the=
 previous one
> +                * completed, then the second recovery work will destroy =
the previous
> +                * one, thus below is to avoid that.
> +                */
> +               time_left =3D wait_for_completion_timeout(&ar->driver_rec=
overy,
> +                                                       ATH10K_RECOVERY_T=
IMEOUT_HZ);
> +               if (time_left) {
> +                       ath10k_warn(ar, "previous recovery succeeded, ski=
p this!\n");
> +                       return false;
> +               }
> +
> +               /* Record the continuous recovery fail count when recover=
y failed. */
> +               atomic_inc(&ar->fail_cont_count);
> +
> +               /* Avoid having multiple recoveries at the same time. */
> +               return false;
> +       }
> +
> +       atomic_inc(&ar->pending_recovery);
> +
> +       return true;
> +}
> +
>  void ath10k_core_start_recovery(struct ath10k *ar)
>  {
> -       if (test_and_set_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags)) {
> -               ath10k_warn(ar, "already restarting\n");
> +       if (!ath10k_core_needs_recovery(ar))
>                 return;
> -       }
>
>         queue_work(ar->workqueue, &ar->restart_work);
>  }
> @@ -2532,6 +2572,8 @@ static void ath10k_core_restart(struct work_struct =
*work)
>         struct ath10k *ar =3D container_of(work, struct ath10k, restart_w=
ork);
>         int ret;
>
> +       reinit_completion(&ar->driver_recovery);
> +
>         set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);
>
>         /* Place a barrier to make sure the compiler doesn't reorder
> @@ -2596,8 +2638,6 @@ static void ath10k_core_restart(struct work_struct =
*work)
>         if (ret)
>                 ath10k_warn(ar, "failed to send firmware crash dump via d=
evcoredump: %d",
>                             ret);
> -
> -       complete(&ar->driver_recovery);
>  }
>
>  static void ath10k_core_set_coverage_class_work(struct work_struct *work=
)
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireles=
s/ath/ath10k/core.h
> index 446dca74f06a..06ac95707531 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>   * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>   * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserv=
ed.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>
>  #ifndef _CORE_H_
> @@ -87,6 +88,8 @@
>                                   IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVE=
R)
>  #define ATH10K_ITER_RESUME_FLAGS (IEEE80211_IFACE_ITER_RESUME_ALL |\
>                                   IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVE=
R)
> +#define ATH10K_RECOVERY_TIMEOUT_HZ                     (5 * HZ)
> +#define ATH10K_RECOVERY_MAX_FAIL_COUNT                 4
>
>  struct ath10k;
>
> @@ -865,9 +868,6 @@ enum ath10k_dev_flags {
>         /* Per Station statistics service */
>         ATH10K_FLAG_PEER_STATS,
>
> -       /* Indicates that ath10k device is during recovery process and no=
t complete */
> -       ATH10K_FLAG_RESTARTING,
> -
>         /* protected by conf_mutex */
>         ATH10K_FLAG_NAPI_ENABLED,
>  };
> @@ -1211,6 +1211,11 @@ struct ath10k {
>         struct work_struct bundle_tx_work;
>         struct work_struct tx_complete_work;
>
> +       atomic_t pending_recovery;
> +       u8 recovery_count;

No reason to be a u8 IMO, use unsigned int.

> +       /* continuous recovery fail count */
> +       atomic_t fail_cont_count;
> +

