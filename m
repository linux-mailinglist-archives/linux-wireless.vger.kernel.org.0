Return-Path: <linux-wireless+bounces-34921-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L1dOvDu4WmKzgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34921-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 10:27:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8AD418A0D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 10:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 347503035D5C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB33A9625;
	Fri, 17 Apr 2026 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zr9RsQcJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DjWHGq2v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0C382F25
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414295; cv=pass; b=GylNeYQ9EEsDPCp1rDIf8CudaE4tmOjReldAZn2eHCHbwi2E4C2Th3BRZJCl2Ht0wkYZp9v/iczuA7Xz1UWoAV509c88rc3eSaEpIdT9kZ66X3mMgyaLsAOLFPzWSnXh1e31QVWPUk84CbkXgA+rqEytMXJFxoBEtPCreTXin60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414295; c=relaxed/simple;
	bh=u6oOlggT5fsHXXtnd/+RL1Xx73OJG+c0MsYoEMZJ8MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXgBCLvTlxzMLWOLpG4n6ST/f8zpn4L1cw2zAYGLjGm45+u8iJWiHURjEgwz5IK/l7k0fjZ8jtWzagfFAF9WEGSkllUDwvUpTUuo1Z05VRwq6C4hpdjtT97XGzaF1QH0CiE/r6qdSrqfSqRnELQGx8r9EMQTc3IYo97NKivEW8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zr9RsQcJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DjWHGq2v; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H7AWPl3438199
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 08:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u6oOlggT5fsHXXtnd/+RL1Xx73OJG+c0MsYoEMZJ8MQ=; b=Zr9RsQcJCkeWFgzX
	P+IlDwuNpui23I0S7FlZB4WLq4mK2CiBVsFLzvi3WZPqebbEwJfC2d3EORC8/Dfx
	cVGCozjMoSMQd7TWRfLpO9sv5lsSges3EHYmsOQcEYg68Ih5IzP2vys4M2faH0l9
	32gbH6dPYftSDZSL3eB5clJOMjFkMCbw3tI4TcdtT2kr3FQd70MrsE1p9ZlE+4fw
	jRctE7xbRmy124deeC0WDBYNIaHIvXOYORyfDAO+UbaIKcldG/4adKR9tI8Eidze
	TJpIorCeV2lCL24cbey15Ld7+vNff0Gi4lJJrsEdmJH0gTrp7Md96RIPwZycvLjZ
	SjmX9A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkg88rcje-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 08:24:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ac566014e0so12512466d6.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 01:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776414291; cv=none;
        d=google.com; s=arc-20240605;
        b=WOCN4Qz6ZGrwMmyQd7VeC633lNZNNbXgxdcIUoO5YNNOomD30ZADnGQQc1SaSvO5o+
         NuakPXFKJkGoL8u6m2pDtc+SRZMiRCg95II96O4ic5xc6Dy+yaU6wak+2Z6fIu3BfmFO
         64XG1zD/RdYmbxd1F53T8YYW0WGJoFfKW3KidxPUeqrxUxCuOUutzrUY6+wDes1Wj3tg
         jHLOQEDs+qsIwy5PJdLlz0pz1b/be5fQS6sBrcc903xzU+uMswrcm79IRf+OD/hiSGSO
         mhcDgXj+jG9IJltgEspZiC+b9a8CBx+TI9lqeWzKyLBnDffECvF1SpWyWw459ibb2Dxv
         mS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u6oOlggT5fsHXXtnd/+RL1Xx73OJG+c0MsYoEMZJ8MQ=;
        fh=jglOtFP42PAmqyjnC+aLoTsjL1NiVfARF/yG+yAL6LQ=;
        b=XYe3pqyitB3AHJJ4xAEBGK3OmGPSzZZVr42UTt9MCrB4qE28B/bo+DoKSMo1twxOf3
         KAPrG+sfB1TOthM2Y4ZjCp/KkUi3+fBsPElcZ9jMhOx0sgbJdFfoWbRpt+N5k7F4kQZn
         rSOlnFbo+9kGSg5aD6LRlKj2PPMiyu1wPWfQHrorb9hqJ0B5Tj30kdhJVne4W2jblMD8
         YXP0/pnrZ4V++tl86UmSVS37qfEZ2R/ZfSQD4LvD52GCm8p5bjO/ieXCQOGgSc3lUNYt
         KSutIx2Mp0Gi0xp+Q0hC+lFvPJzfKm/kQhcua5G7v6fhpMOzNGLxFIIVuqjw7iyYc2Pq
         d7Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776414291; x=1777019091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6oOlggT5fsHXXtnd/+RL1Xx73OJG+c0MsYoEMZJ8MQ=;
        b=DjWHGq2vt4ypez6RE55T5O7j/HLolPmBqCLy4ay9hkoyYzeMe2rt4sJTVmEKbjMRzE
         BONCgj0TSl0YWHykYrAqgQZ72fWKCYXroIwEpkPGzDTi02rvaeMc+JzcQ+BW77OxdqWG
         Q3LPEaLc7lQXD42Na1YCqIRvIiIXFa+66SQ1cYp/5cu8ohip/NVHDuBATe7MLz26pbNV
         RvMmm75kPADyo985orxauiPSdYaCb4xpmbUatlAfLheK5Bd6de/Jvg+4uVdbdsY1vtOe
         12CScmAamUGJt0a/M6bGL5DA64+40VJ6orTRCYmlb0RA50GNzVOVr0BWh0Xh5snmD2AI
         o1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776414291; x=1777019091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u6oOlggT5fsHXXtnd/+RL1Xx73OJG+c0MsYoEMZJ8MQ=;
        b=ZgBxAuileOp/l8xo7Qo06fhiK0kzyZE919TWRnZBmxnALj9D+Dy+NrwkrhkjePqNth
         vbCXmmZsXY8HyG8Yn3FTG6auiO80g2UOJNlGDqE6k+I+oANbmNHLBFq7Q+ljwSulwHED
         w6R3sq51WcuYH2OoW+OnB1igkn1nBlgGA+DILR6vW8coSnok+liS7J4kZiGfX9ghYfcY
         aKZO++iqjtpk2EY8Y6Ape5bogVXE2sslqDxape9PiCR3LSOYysi2CfozCv4yYI3EuItN
         shA707/hZZ6HVXir7evs6fCXahYKx4Lk4IizM4NfVn7MDjaSbGfVqryWDSDroVFJkSs+
         Pqow==
X-Forwarded-Encrypted: i=1; AFNElJ+EjCUGQ+U92HDqUqSMfciUgKNmUQA+BT99RkCqmLa/3ZzONF8/5Q8AwSg/OdPCxyzcFJ3DndMaNI0qB0cJ1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqfKS/tuXw+cNSVZeUAUjqMkXpuLWg9XRa+JxIFH7L+YIDdkRY
	W6o8lXQ6gySyKskL9WeXXw9N+EQQRJ0dE4d9FZT482CmTdbFEd8RiXgJh/juHRGNWJ9FPxpn0kd
	/bED1kZqZ33u9KUw/wBjpXxbb3gsYSPRbTfQRjX5TRSFvB7zTi/ODW3wTVEnZ/w13iDCqgsPMOK
	aS10KUZprpbYarbX/molfAaTRuLnLuAI695Ve+DJM1F9lP
X-Gm-Gg: AeBDiev65qW6q9v99GoVZJZyUlqkPM9zdWmQoq/6iKYIjX7TEf07O+2k65CwNHSaRPH
	04dcFlNaNgmSaMC55LT83Pxm7BpecNXeLmRitivvey7SLC4cGtD4Fa+x68Gy7jFPpRLDmefN8Zm
	eqDTsmsu7m36VSVE6r8zd/tqJvUNE05wFpxLkRTEyViQe+KlSNgsyPxEukDyo0lPivxwxQ9n4Ts
	xtdDrdGOHfJP6uzhlgdAZnPJj+ZUTt+QHLE7rmMwYDpe8V1S8s=
X-Received: by 2002:a05:6214:202e:b0:8ac:732b:6cf1 with SMTP id 6a1803df08f44-8b02818ebbcmr30308946d6.24.1776414290661;
        Fri, 17 Apr 2026 01:24:50 -0700 (PDT)
X-Received: by 2002:a05:6214:202e:b0:8ac:732b:6cf1 with SMTP id
 6a1803df08f44-8b02818ebbcmr30308626d6.24.1776414290252; Fri, 17 Apr 2026
 01:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415223710.1616925-1-tristmd@gmail.com> <9fa651dd-6004-42c6-8c03-95247d5807fd@oss.qualcomm.com>
 <c29bf32b7f1195a69d86b4f728ab02523675b41b.camel@sipsolutions.net> <01831aaf-f6cc-4ea0-af73-83344698de63@oss.qualcomm.com>
In-Reply-To: <01831aaf-f6cc-4ea0-af73-83344698de63@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 10:24:39 +0200
X-Gm-Features: AQROBzDsQm-Nje0-tOvlv3k8UxdSC9HQZ1Kv-Eq-TJonSSJiWnCIToTgSeS999k
Message-ID: <CAFEp6-2jAe+-1xyZtMKzmrJ83yW+sZNMEjSCY1dYstn_=azqdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] wifi: wcn36xx: fix OOB reads and heap overflow
 from firmware responses
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Tristan Madani <tristmd@gmail.com>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Qzn1tRRYZ9liklwqxwq6Hp-leNX11fYU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA4MiBTYWx0ZWRfX4F2WZKShXr8C
 KAZX2mAwp0RGwm7lAmaYeLL7TNnRUuJRWl9TiL+eaK8MPgyUfWEl05+YY9qD9fkioLMVVPs5yXB
 RAAI5aSYQ+M/yFq16JAp5F7Bc+qAkiFNJy7EoByV5HQzP7jaUnqhV/l3CNvjIuvwett4uGG5z9R
 y3Xzd+vJUaBZKMdntNrO53JB2WyQkm05gD4l5gh1i45rXQZaYqajfie9FBjHSDaDDBEtKNo0byY
 Oz93bXDSzX2ZOPo6t69eRevfNwtnFE7V5scI6TaNoL9igVzQ6pikv7pkz08Njb6L/0Qd8Kluh5b
 fmFdARMO05Qp+j9M72KARicqAAqx5sItAELYiSyI4ozuI/181bbPAgYt5Z9Tu+OPqq7E37UjTVb
 m6HK25jCchiOmuiGWkmE8HNvnMtV/Scop6wCTQQqyVxhnIkWR3Tyvjwc2J0h/mATJrTjWeKCApV
 gpe4/uZctCmRjpKVOfw==
X-Authority-Analysis: v=2.4 cv=X+Fi7mTe c=1 sm=1 tr=0 ts=69e1ee55 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=J_-Nd1mkAAAA:8
 a=OJVdZ0SVwV8qFpGo044A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: Qzn1tRRYZ9liklwqxwq6Hp-leNX11fYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170082
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34921-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,mail.gmail.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 6F8AD418A0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jeff,

On Fri, Apr 17, 2026 at 2:01=E2=80=AFAM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 4/16/2026 11:39 AM, Johannes Berg wrote:
> > On Thu, 2026-04-16 at 09:25 -0700, Jeff Johnson wrote:
> >> On 4/15/2026 3:37 PM, Tristan Madani wrote:
> >>> From: Tristan Madani <tristan@talencesecurity.com>
> >>>
> >>> Hi Loic,
> >>>
> >>> Note: this is a v2 resubmission. The original was sent via Gmail whic=
h
> >>> caused HTML rendering issues. This version uses git send-email for
> >>> proper plain-text formatting.
> >>>
> >>> Three issues in wcn36xx HAL firmware response handling, including a h=
eap
> >>> overflow in the main response dispatcher:
> >>>
> >>> Proposed fixes in the following patches.
> >>>
> >>> Thanks,
> >>> Tristan
> >>
> >> Are you able to cause these issues to occur?
> >> My expectation is that this is testing things that firmware will never=
 do, and
> >> hence this adds code and processing with no actual benefit.
> >
> > We're not really supposed to completely trust firmware though, right? :=
)
>
> Like everything else in software there are tradeoffs. You have to mostly =
trust
> firmware since everything it it is doing is on behalf of the driver. So t=
hat
> is why I'm curious if these issues are actually exploitable, or if this i=
s
> just preventative for the sake of being preventative.

I agree that some degree of trust in vendor firmware is unavoidable,
as its internal behavior cannot be fully controlled or inspected.
Nevertheless, the kernel and its drivers are expected to strictly
validate and constrain all interactions with firmware, so that any
faulty or compromised behavior is contained within its intended scope
(network/wireless).

So, it is the driver=E2=80=99s responsibility to control the firmware
interface and ensure that firmware misbehavior, whether deliberate or
the result of an exploited firmware bug, cannot lead to such kernel
memory corruption, which could otherwise be exploited well beyond the
driver=E2=80=99s original functional domain.

While this issue may be largely theoretical, it has now been reported
and a fix is available. In this context, addressing it seems to be the
responsible course of action.

With the increasing use of AI, we may indeed see more fixes proposed
for issues that are theoretical or unlikely to occur in practice. I
understand the concern about avoiding an influx of low=E2=80=91value commit=
s
and the need for some level of filtering. That said, in this particular cas=
e,
I believe the fix is legitimate.

Regards,
Loic

