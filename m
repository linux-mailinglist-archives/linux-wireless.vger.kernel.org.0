Return-Path: <linux-wireless+bounces-36323-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F1XOV0+A2qr2AEAu9opvQ
	(envelope-from <linux-wireless+bounces-36323-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 16:51:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD66B522F2F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE0B13249CAE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875A23A59BF;
	Tue, 12 May 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BhckIMOf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EI8B++sT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1F3A5984
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594559; cv=none; b=kTjhcgKvTXJtuY1iR4hGUOmRoWWHSEktdvHOTq8DS2x05vv8LjJRzX0J3qP+xi464klsISKe1v0YParxxDxPQeYqatJ+DaSBAA/ZRhu/qLjrhLAgZ7pzyKnmn/cSX63vymmkqTgGa6wyfVoJmd5I3Bb/3ZvJU0NUkzm6DVPh7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594559; c=relaxed/simple;
	bh=kJngOwxJlejmtt2Hmsfrwoju1mlMZzS6YP6HzDp7fFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aehFQt5uCtUKvwI2wDdsMbbETjP31CAlNxx79xhBNc8scOnctWy3QfiHfGqO6vyiDdIb9q0JXgLXidgu41iAe9K8S6NNzf/cYewO8rUpWiLw+a8mlTLmI9KYTzSj1u8Z5CNv/HKfn+zlNQ1i6IfkrWRLsSnN/FAaFHXx/Ifv140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BhckIMOf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EI8B++sT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CB6o4E2121537
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 14:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V3nb/GJON6V8wH50cv2OvL+b2XC/BfKRtqhaVBuS8x8=; b=BhckIMOf0Z0HM8R/
	AZ76YrhNFv4mc9fNru3NttTQSVDvth7WQp4tNLbpbYUUwd9v5ZpW4h73PcFWFprn
	P9Va+JxINgM79Uya2dkmvmf6G+8Q3jTBJkYwidXVITtZH5TqB5H8GvQ0NaEXjLWi
	PTFI5VMcnyQ7/X0Qq9y14o+9yeeYwoYjQrvyOywqftsHxwjH5Ps3tRMDrWYCM869
	OLPydj3cRvwdME8sbYNHroXkoz6rbvUVEb3cvwpdUpvShvx02m0+hxCUVkFYQrjg
	en98SAAsqSAFLU/n4rkByKtuWK8D/fkVIHjREPp7I3xYmk2amAL6AR9De4MBfBrf
	8vHyhQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv2b46j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 14:02:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f485961555so11318280eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778594555; x=1779199355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3nb/GJON6V8wH50cv2OvL+b2XC/BfKRtqhaVBuS8x8=;
        b=EI8B++sTIMnZpLwkD1/GLPdg7uGXW89xZ4O9EDPbpQQlPcL3PwhNp9dExnFV6h5tt6
         0/o8IID8lYbQDI4DYKmw1c8z5L1EimO2851j7WNIDDeX3irfMucw5ELAKVU0VqzZQNQR
         X3BcB4UbjCJhyxa8VYUBHdQMqqqBuGRBQY69XGYoW37JvLsWLGw304Kdhbn4cW50KMv0
         0VWwBEU/RQKPg9oK8Kb2jCoEbd+uK332OjZprce1sinJ04O93h58a1brPQVAbR+mRpxe
         KgCLngNgXIbLl1m0o2CRzW6hLYI3hKaLIC6b3c+EQMI3Yi1tCp/ERFqe9N5duWgHYS1N
         vagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594555; x=1779199355;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3nb/GJON6V8wH50cv2OvL+b2XC/BfKRtqhaVBuS8x8=;
        b=FLSOUQfbf08BVAtUVhBZCc7VFBZkWph17TBlICO7i8PaecF7ArHD3OTFf7hFqIFyHE
         z4JOO/go8otPPQoFApij1/vS92FobtEAOYTNfKlcGEZm3drE1UnOX5h2J8G/CD7RT6VU
         t0j7h+9OXtot/SlX+5KlV0MlsCV0O71IqL1wKFMcw829HqxvJeP480M5QrO3Q9/bSSjU
         v8edqDwigCAhaiBdKwAh1dGkzHlq5vwzrTtmNDitLvgb+J0Dmu42Lu1wjz2aeuyplvgS
         ijtPUbp6gCo/o5u70K8iGZIcz0MA9W6nqTUPw8PZcNCptGOjtzjkedHFaR+ypfNvflMu
         050w==
X-Gm-Message-State: AOJu0YzX6A4S2OVW/GcpU5UQ2iG7+e6bpiNHvgHWv3069IfKFMnQyoWh
	Mm2pCBAgXjycd8znSlm0qYGBsuQmMQ5foIB6B4rRp41nk6cmH/L17SYg2oY3GSm1ZlS70/2G+ey
	t3nxa7a2DUQev38KjgjNwHwXLs1Reo4xYnvtB8ILttKD7jnwiwNrUJ8mw16Uw8/sbAv9cIw==
X-Gm-Gg: Acq92OGMYGMXhBmk6LYGUBtKlB1GKVAuFtQh/EDYTziv9z9RITgGe4EsRq3yMm/CUZH
	4K0bD90RQFKSrc2X3/sfg6jXuShgeA2Tf+REgqPt4HnauiEzd+sknCURrE/P8LXf4OxIeT2qWOJ
	6dNLsQKVC8hpyQD4nqXMhkAan1EFhAm8o1vDcntv8S35O9E0ea3oA/aAR5yTvxgl1ZoMxKIXXtq
	bSBw/hw8yY2XHFoI+QYUMxOyCaHBDWP3Lidb3n6feY8YOSvfJRKcVGPPtwL/+uEADmOGKTt8hQ4
	49aisM0dwX2Gc9Pa1XTqk06r6rlxCWzHr1VmX/hVrCSuDZRSdn2TL3OqJaPw17qBMZf+xdh0P5O
	GEBEURwQ/kXOfm/tsPeekfCxTUKQnDzFA6L8uTFOu6gRq
X-Received: by 2002:a05:7300:478f:b0:2f2:6dde:df53 with SMTP id 5a478bee46e88-2fb4b733e84mr8180634eec.17.1778594555053;
        Tue, 12 May 2026 07:02:35 -0700 (PDT)
X-Received: by 2002:a05:7300:478f:b0:2f2:6dde:df53 with SMTP id 5a478bee46e88-2fb4b733e84mr8180341eec.17.1778594552791;
        Tue, 12 May 2026 07:02:32 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm17657298eec.13.2026.05.12.07.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:02:31 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260506134240.2284016-1-nico.escande@gmail.com>
References: <20260506134240.2284016-1-nico.escande@gmail.com>
Subject: Re: [PATCH v2 0/3] fix leaks in some WMI error path
Message-Id: <177859455169.3185911.14184991493607039564.b4-ty@oss.qualcomm.com>
Date: Tue, 12 May 2026 07:02:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: Oza-qCj12af7FIzxgepF6F_KGZC1zaod
X-Authority-Analysis: v=2.4 cv=Mv9iLWae c=1 sm=1 tr=0 ts=6a0332fc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FqyUr2HIOI8AG8dd71AA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: Oza-qCj12af7FIzxgepF6F_KGZC1zaod
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE0NyBTYWx0ZWRfX6qRfdLXqhtUe
 1fTI5vytgXXP+AFQx31uvyHfyc5cghMv+EsIPvX2CMdUwQC4iVBx5tv7sgEXnddAK0s38ax/dEE
 95QZHEK+GXbH29MZ9034+f85z2Z9a3oThylkU/DiKxa+epMyRzyX48bYRCw/KwKZaf2zu6ieglb
 Wl/UuiE28XaZmbA5djsA8NR/H7KSqxeGWaG17wdehv8l11D3RmXwaN2AOFIC3eMhNtbtf5RlxJB
 /gdztF9WjsxLWka8vukfwG7R5U6QfB+c+5nBEONo3t3Ce5sUV6nAuaTBcAEdpo3xbJVH8UqxXlO
 dtm0qSn8YNLeSfqY+yciCpJJYRCHQwCtWMOL4mSQX7PtrxvGNHCCOzGGfUZZNfPPpvdo9DVz7Ey
 M9Lf81MuhAgYZVvbcATVgTWeSPYxfNwv4mLmMYkI0i1SfXQxMBLGea9z8K+Ol9ik8hls7VmH+G5
 CUyCYGM7/mXJXif3MVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120147
X-Rspamd-Queue-Id: DD66B522F2F
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36323-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lists.infradead.org,gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Wed, 06 May 2026 15:42:37 +0200, Nicolas Escande wrote:
> So this is similar work to what has been posted here [0] for ath12k.
> 
> When we use the pattern 'return ath11k_wmi_cmd_send(...)' without
> explicitly checking the return value we fail to free the allocated skb.
> 
> This has been split into 2 patches per Jeff's guidance to hopefully
> ease the backporting process.
> 
> [...]

Applied, thanks!

[1/3] wifi: ath11k: fix error path leaks in some WMI WOW calls
      commit: 55dda532bbc261aef495e403c8900c5e2ab5fa34
[2/3] wifi: ath11k: fix error path leaks in some WMI calls
      commit: ebad0b48996fd4919c36bbcb07289d37d046de74
[3/3] wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()
      commit: 7320d6eb861e9913193a7801834c661381756a79

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


