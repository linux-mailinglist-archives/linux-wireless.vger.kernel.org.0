Return-Path: <linux-wireless+bounces-27236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A4B52865
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 07:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20506567985
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 05:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19D18FC97;
	Thu, 11 Sep 2025 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xh4Tvg/2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCA1547EE
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570310; cv=none; b=W+jVQVbtCMzdoYAgFnPfcvgnViEMTqMcz6JbPVv5fO4Ok+Orzme2SyfKwfVzJidGXuOii0DnSqweRCgQgLELEKQUToDdkXykESwtLkJD51FDtfo+ncxXn2FVA1+t9CdDyuxF2LAispiI0L158Jk0g3y8jwo1lGJOBkyKbNuwi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570310; c=relaxed/simple;
	bh=H8MfDJmCW9nc372hvzLM2g42tw5NkAF01AKAtWpMex4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyfozqCqRC5MPAYAqjKZvNCgnlpiE1ugu68A5mckC23hcYCmGwLTqLXoq/DkSEmHWqMLtItM6TA+LCEX5A8R+SkwlQZjA7ZfepnWAo82dqX+gQJnDfF/8JUrYiA9uW1S0OKhTpNw1QSFWyoZrTf+k4CwqW7TUDXwOgJsRiia/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xh4Tvg/2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IgBt002482
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 05:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qq/HctOkyUOkFAafBmZFjIX54nLQJ64hgO5H0BUZjPQ=; b=Xh4Tvg/2Ud5/u6ei
	6eKv+r0GF/1jneCVsYJLL2cIsdU2ik8kS/Mfm1qeckzU+sOiS7jYndqMy8K08n0I
	xG+9w6jcuQ/wiPl0/IXdOP9kEWQ05+xm2cZdsI1dom49DrL5zTexjzyM1Wf6FJ1N
	3DPDem7HJksa+7249tAnCHS2wMYB8GCOz1t9FkAUEvn3FycQo6bfuCg380CE8O/U
	pVPERt+Orw4/3PQsnIpQZQRv8t3chz+uAKeEexsanT3A9H3M61Nas70ni+Lt71Nt
	eSnDD1TUl7pVcAs7kpJU7UlkNA1Q0UIU2RvCaSNbND/pLJTdIzrRsIOF65n11bFT
	1omwvg==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsek5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 05:58:28 +0000 (GMT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-400bb989b1aso11376305ab.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 22:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757570307; x=1758175107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq/HctOkyUOkFAafBmZFjIX54nLQJ64hgO5H0BUZjPQ=;
        b=RmGHAvYHycxiG9ryAZztLzLEblWHCajPDFNPlMId0dM0nnC4dq+4k4qKOBMpXpfs/v
         Y7GOUJx0aXcq83TV77S3/09BM+DlhllxgS7Y4/9l65tplM43x7Emz6eKpt1YZPfDb8wt
         PFjkGjSZMewocuz0BdhqfYuLRvpV/fm6XrlZ6A5FyAY0sAs550y11o5tk9IjBoO97yfi
         PCx5mOhgA2xeM0sEdbJEaiUhBP5QTCk/fqg6vRfy39MDyu1giz4jVjTSZcnoCe14LHsp
         pLMQZjE3OT34Hl+muV2pSaXFw2g7KxnnGAHguyxUO7AW96wCDwTK7DwBOuCkoZiJhXOr
         vcZw==
X-Forwarded-Encrypted: i=1; AJvYcCW13wakhlk+3joJh2vV6V8BaiDIKS9d5RMRjJiLOaeqJI++OVlym9U5I6RpPYrrD9Poah3+9/IrSm4cKyuqew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbKAqLJa3z/hZmdHLoou/YWGLBhOPSiYfnChratwQ2kVS6fnL
	LAFlSr5xbm59ooAPSE/Igsb72gLBeLq2rpFx8bAwEt+NKnqmAch9k8yex+puzPVuhu58pwxiCuS
	3SNZnuOgJ/HHi0xegt5k161/3MqM6/xlC1BE/s2Oixjsmu0tPpXP0kk7+8WvFh4256+T1fSztqI
	GOU0sbkZM5WNxN7iEsX61EoWMXBIEoKUN2/Zmi1RrZd7Ov
X-Gm-Gg: ASbGncs5quCee5pMh6ukypXS9QYvVUKH+dOXXWsBZTaANeWDMaB6+6XFU2MSiLmdeaG
	VCjVEIK1BiCvhBpFb8mVhekGEl80fy/VqBZKXFZPNlu5joKHF13nsQn6wrW8qBFZXKmsoHV26ZJ
	iT9ckN/8/9n9m0zYuDPrgDm2o=
X-Received: by 2002:a92:ca4c:0:b0:413:9e81:7a99 with SMTP id e9e14a558f8ab-4139e817c77mr107988165ab.1.1757570307088;
        Wed, 10 Sep 2025 22:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFczCMiaPGcLaaGSwl0zn2pNemKYMNI0vEgQHodmNKJGzZOmkQkWOu7UD6ciNI6tC2c6J3ssX89EMqf/yuNWcA=
X-Received: by 2002:a92:ca4c:0:b0:413:9e81:7a99 with SMTP id
 e9e14a558f8ab-4139e817c77mr107987935ab.1.1757570306636; Wed, 10 Sep 2025
 22:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <DBVM2YZDTS15.1WAPW69YQ5XOA@gmail.com> <CAD1Z1J+jXWng4ma9_BPJh4N8b7AhTvRKtJ=tg1dTyk8E3wqupA@mail.gmail.com>
 <DBW8K6K30OQS.U5Z6UMSMEY7B@gmail.com>
In-Reply-To: <DBW8K6K30OQS.U5Z6UMSMEY7B@gmail.com>
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 11:28:15 +0530
X-Gm-Features: Ac12FXzeVCChHUAuNbTNYiazcoDlO2m_Sswse5H9jZ5hVl4SXkePBNDy_FHt8UI
Message-ID: <CAD1Z1JJfXqhTTaM5bqjN2MFXfAfzvu2AZKqfVkRn_VKvPckxnQ@mail.gmail.com>
Subject: Re: [PATCH ath-current 0/7] wifi: ath12k: Fix Issues in REO RX Queue Updates
To: Nicolas Escande <nico.escande@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: AUNrw35CUXJOAUKp-3y2wzEAD8dgwmZ1
X-Proofpoint-GUID: AUNrw35CUXJOAUKp-3y2wzEAD8dgwmZ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX6iZxP3BZven2
 yRd5Gcpk1EaShsW93a5uT5JMt7+SYPGIY/kE6M891hjai/Sc89V1CpE6OSTEoJnCGOVdqG2TYC6
 vYDfvXW3Dr81KZQqEx/VVwvKVaXcIoKhqbwL0FDTWWYfwPV4TbI7bEmiBX1KBfKp+pkw+TRO0JX
 LOuQ4pO/HCvpj4JWFBpAM45PkSKDoScoCX5H11cqvhrguGvoxJTry6pAbb3mW3rTSk7b8erMRx4
 GFwRh6ywKUCwLxk9EtFI9KxtKtTunibgVt0T/WRFFPX824VxOj9SEKf9MLO3xhA35rnNZSTBC6U
 gxqZ7hj+sNvT8Y0bFayGhBrPp/mENEgsJopy4I01V5i6G3t6yJKizESxC6erZ+g9aDi63gg34TC
 GcIU0huE
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c26504 cx=c_pps
 a=vy3nvQW9C2dqy/lMnN3IYg==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=pGLkceISAAAA:8 a=NIO-Sh5Dw3l_QA16ft0A:9 a=QEXdDO2ut3YA:10
 a=mHQ74H5e8mo-RpSg_uaF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Hi Nicolas,

Sorry for the delayed reply.

I agree with your suggestion - it=E2=80=99s a good direction, but it will
require extensive testing since it impacts all REO commands, not just
the RX queue update.

Given that the retry mechanism is a critical fix, I=E2=80=99d prefer to
proceed with that series first. I=E2=80=99ll follow up with an incremental
version that implements handling of REO commands using a workqueue.

Thanks again for your input.

Best regards,
Nithy



On Thu, Aug 7, 2025 at 7:09=E2=80=AFPM Nicolas Escande <nico.escande@gmail.=
com> wrote:
>
> On Thu Aug 7, 2025 at 2:31 PM CEST, Nithyanantham Paramasivam wrote:
> > On Thu, Aug 7, 2025 at 1:32=E2=80=AFAM Nicolas Escande <nico.escande@gm=
ail.com> wrote:
> >>
> >> On Wed Aug 6, 2025 at 1:17 PM CEST, Nithyanantham Paramasivam wrote:
> >> > During stress test scenarios, when the REO command ring becomes full=
,
> >> > the RX queue update command issued during peer deletion fails due to
> >> > insufficient space. In response, the host performs a dma_unmap and
> >> > frees the associated memory. However, the hardware still retains a
> >> > reference to the same memory address. If the kernel later reallocate=
s
> >> > this address, unaware that the hardware is still using it, it can
> >> > lead to memory corruption-since the host might access or modify
> >> > memory that is still actively referenced by the hardware.
> >> >
> >> > Implement a retry mechanism for the HAL_REO_CMD_UPDATE_RX_QUEUE
> >> > command during TID deletion to prevent memory corruption. Introduce
> >> > a new list, reo_cmd_update_rx_queue_list, in the dp structure to
> >> > track pending RX queue updates. Protect this list with
> >> > reo_rxq_flush_lock, which also ensures synchronized access to
> >> > reo_cmd_cache_flush_list. Defer memory release until hardware
> >> > confirms the virtual address is no longer in use, avoiding immediate
> >> > deallocation on command failure. Release memory for pending RX queue
> >> > updates via ath12k_dp_rx_reo_cmd_list_cleanup() on system reset
> >> > if hardware confirmation is not received.
> >> >
> >> > Additionally, increase DP_REO_CMD_RING_SIZE to 256 to reduce the
> >> > likelihood of ring exhaustion. Use a 1KB cache flush command for
> >> > QoS TID descriptors to improve efficiency.
> >> >
> >>
> >> Hello,
> >>
> >> I'm not sure I fully understand so please correct where I'm wrong but =
from what
> >> I got looking at the code:
> >>   - you increase the ring size for reo cmd
> >>   - you enable releasing multiple tid buffer at once
> >>   - as soon as you allocate the tid you create an entry in the list fl=
agging it
> >>     as active
> >>   - when you need to clean up a tid
> >>     - you mark it as inactive in the list, then
> >>     - try to process the whole list by
> >>       - sending the reo command to release it
> >>       - if it succeed you release it and remove the entry from the lis=
t
> >>   - on core exit, you re process the list
> >>
> >> What is bothering me with this is that when a vdev which has multiple =
sta goes
> >> down, you will have a lot of those entries to push to the firmware at =
once:
> >>
> >>   - So increasing the ring size / being able to release multiple entri=
es at once
> >>     in one reo cmd may or may not be enough to handle the burst. It se=
ems
> >>     that increasing those is just band aids on the underlying problem =
but I
> >>     understand it's just to be on the safe side.
> >>   - If entries do not get send/accepted by the firmware, we will need =
to wait
> >>     for another station removal before retrying, which could be a wile=
.
> >>   - Or in the worst case (one vdev going down and needing to release t=
id of
> >>     all its stations) the more entries we have in the list the less li=
kely we
> >>     will be to be able to push the delete of all stations + the ones s=
till in
> >>     queue
> >>
> >> So, on station removal, why not make just things completely async. Pus=
h the tid
> >> deletes in a list and wake a workqueue that tries to push those to the=
 firmware.
> >> If the ring is full, retry periodically.
> >>
> >> Thanks
> >
> > Hi Nicolas,
> Hi
> >
> > Thanks for the detailed observations and suggestions.
> >
> > You're right in your understanding of the flow. To clarify further:
> >
> > When the host fails to obtain a buffer from the hardware to send a
> > command=E2=80=94due to the REO command ring being full
> > (ath12k_hal_reo_cmd_send returning -ENOBUFS)=E2=80=94we treat it as a c=
ommand
> > send failure and avoid deleting the corresponding entry immediately.
> >
> > This situation typically arises in the flow:
> >
> > ath12k_dp_rx_process_reo_cmd_update_rx_queue_list =E2=86=92
> > ath12k_dp_rx_tid_delete_handler =E2=86=92 returns -ENOBUFS
> >
> > Given the command ring size is 256, and each peer generally has 16
> > TIDs, each TID sends 2 commands (RXQ update and cache flush). So,
> > deleting one peer involves up to 32 commands. This means we can delete
> > up to 8 peers (8 =C3=97 32 =3D 256 commands) before hitting the ring li=
mit.
> >
> > From the 9th peer onward, we may encounter ring exhaustion. However,
> > we handle retries in the REO command callback
> > (ath12k_dp_rx_tid_del_func). If commands fail to send, they remain in
> > the pending list and can be retried via the success callback of
> > earlier commands.
> That was the part I did not get, I thought it was just another peer remov=
al that
> would cause the whole list of pending entries to be reprocessed and pushe=
d to
> the ring.
> >
> > Do we foresee any issue with this ?
> >
> Nope, it should work.
> > Regarding your suggestion to make the deletion process fully
> > asynchronous via a workqueue, that=E2=80=99s a valid point. Workqueue-b=
ased
> > handling is a good idea, but we need to account for potential delays
> > if the worker thread isn=E2=80=99t scheduled promptly. We also need to
> > consider timeout-based rescheduling, especially during command
> > failures, to ensure retries happen in a timely manner. We=E2=80=99ll ev=
aluate
> > this suggestion further and get back to you.
> >
> IMHO it feels like it would simplify the code to just push + wake to a wq=
 on
> delete, and reschedule if no space is available in the ring. The timing s=
hould
> not be such a big deal right ? The important part is to eventually push a=
ll reo
> commands to the firmware but it should not have impact on the rest of the
> operation if it reaches the firmware later that sooner right ?
>
> > Thanks again for the insightful feedback!
> Thanks for all the explanations
> >
> > Best Regards,
> > Nithy
>

