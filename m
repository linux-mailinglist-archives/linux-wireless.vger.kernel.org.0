Return-Path: <linux-wireless+bounces-30306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5127CCEF76F
	for <lists+linux-wireless@lfdr.de>; Sat, 03 Jan 2026 00:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D165D3010AA4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 23:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039552D4B66;
	Fri,  2 Jan 2026 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pA+VyAur";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FWFEjQc7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD62C235E
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396268; cv=none; b=jUQnGZpvdjK7bskZigmCXVS11k5GDkt7p4bhUgccAk1A6JgpWJ1tOt+OqH11URxpPDNWClqDt0aXMHJNig73fo01v4jVFgVItWFTJlS4zO71+x2/LoIBIwJFoSmy5RRzZA/hnHof1fEGvyX5yCPmAct6XP2iO2VaB/hHsUx/3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396268; c=relaxed/simple;
	bh=ISZjvX6y5MMyPtGKT+WtnBq+hiWnMNABmNpydnT9t1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlcMks71/ViT1Q9ay6dJYsBv6J7ueeNGNwsYacgXYiItKU7QTeY/DeOCciF0zyf/Y4bnWGQb5nt0ZcXBZZxqj9vsMkyKMfe9dEg/FlTteoU//nCAivteQ5PSaU6Rg7ml0phARM/VX2+tCWJ5iQH55bTxP2lcpP+m1fhtpsB9tlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pA+VyAur; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FWFEjQc7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029VvL7426589
	for <linux-wireless@vger.kernel.org>; Fri, 2 Jan 2026 23:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T1GYY8vrtnmd/Fz+orMbcn6ybyOpEE1SHFFFCXiCQQs=; b=pA+VyAurGpIRBT0T
	9ZvKhauE2ySokqZuRMqwYad7L7h/R0YE3D8Yd/5R2+JB4ovWl1gxeHSJiorTO3/7
	wkAMF25Tp8eyo6lCOTqs31CAJ6cwDRhiNbstVHvLNzIPv7+N4It/dVLht02cXh6d
	bIKoSMHZ2M656N03wNiawMths25ASABLwexazKVSh9h+BZ/MJiFpSaDsITDcwWiJ
	dBUIbxF8wi7rUDo1vk8SIR36lUY5qTpMZ1ybCTAoR2pnKbXbY2ADM0LWPUNzzgIn
	kQ93SuYdJlP1GxuSmcgcp3ncvWnqYqVsYkkMGgciBQct3VY5dKnEnv1Q60vwKo9e
	h3dxpg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4be6fjt1uw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 23:24:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8887c0d3074so318071396d6.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 15:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767396265; x=1768001065; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T1GYY8vrtnmd/Fz+orMbcn6ybyOpEE1SHFFFCXiCQQs=;
        b=FWFEjQc74bHWTi6D4kOsu5x46+dUckxIBf1yn4oNT9KpnLuT4VYv84vNcNPOoeqqSC
         WjDILsh5OQNcI92goceLhk4gWj9p3LS8GChdhkhj3kx25A+Qe6gP5Y1YRMOOlOH/v+kA
         DpziuevprvNrUbSLkoy3iYzyk5bJSgJt5Cj8AWThXnV/MwwXW0Bbl9+1Djrd4KbhVhAB
         8vYlV7oItM8DE8nLbcb1MeWrBe5i73We2zJtQdl9OY5KS26J9nTOQKLRHPyoq4/XjZ39
         7YxAmnb3YL1s8hdkA+E7KxOowtL3LikWcTR5zv3rdqfLM8bp8YTtFn+iiIPC7Wmuxo8T
         8qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767396265; x=1768001065;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1GYY8vrtnmd/Fz+orMbcn6ybyOpEE1SHFFFCXiCQQs=;
        b=CbG2szzT/nDE0fxz2pT+tmaHwerO6/ip6x9qWDkMewJQLQfXAupgFfigFvdZV2dRrt
         t9vhIL8z90IQrgnBy+imEXtpGvQfhV1O+q3sdWGlfgQml1AygMnO79Yk7LogwzTfttvV
         d7g+A4dIy4N/aS1ErUhhw5btff1U9GMtD0X2rMI+cnKXJIf0Xj3hHh2lzEkMVHM0YFQW
         RN07X/4cM0lH4vSjY8o8yf7C8NgTflxKoiWAC9ezmqLr8PRcoWUdslyu4xelLF8yZW7p
         k/MCt66pn8ajAYyHgl1UJGO+qVkxeCHfO/iqXbKg9N4mK/GgM4zfdyOzXklTY5w0HfXz
         y/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUTZWqZ8V+VUmohHj1vmfYJIriqSmNYLxb0jkWovMXkpllmHCi+FS5bOObBliUgFmqZJh8pkF0qDX9dI/x5Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0LofTb/nGxOIp1pS9cnQ8LA3YGfex8l0WjQWSI0n4Nll7ld4
	sBp1jJRFa8kPUIOLOxCcPOu+bzvmIwt98A9VGI6c/m2AVyWobndqtoCQHEz847n2umvdFNapind
	mU3F12ChENi2nGKzNJV7eFUp5Wq7/kwt7YRItSGk321tlZnNwiIHYkMPOMeBN+1tA5heUbg==
X-Gm-Gg: AY/fxX5EhIj979R0Z0MyIxWp9Jbxi8pFxXo1E8+aBfzON0sQGf8Xc6ij/vAig9lG0SC
	RywVUXtjgaDTEr5SmKCHZbKhXMqkR3yZ4O5mqQ6LZH3Q+GWIHN+utIgHQ+ElzO+XPBuNfELhlOu
	jJzblqQqEbFBJmUxQ/n/Wc7yfUtYV4PCdc1ags+IdlX5CDkMElKOwMtp1V4p/yLiD/4pwDVXLqK
	TADs8QMQRg23NNv2Yr6JSiUOwzMAwolDXZomxKOsT+3e8LWNr6AoTOI1mcbavPD2zfMlB1PQtro
	b7iOxDdNWMsRGtSbybSF/5bI3FTEGmTOkEr1ngT6z/QNO9kgyy0l+ziG82+NVCGc3oh37Bsj/JF
	1KyqYMUAZ/EzQjnpmTlWgnXWE15l/DRrcLWUqBG9HY3m1zF/+4UZvMlGzdXO2Ix9ANKfoXaEmuB
	WbmvRmtqKlAzXw7PfuTNIAHcg=
X-Received: by 2002:a05:6214:1ccf:b0:786:8f81:42f with SMTP id 6a1803df08f44-88d8369eac6mr675360106d6.39.1767396265427;
        Fri, 02 Jan 2026 15:24:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVK/WKrTkslH7Y0vfCHTFCAvovEzvlC0OyEeJ2yOG+2XWavrDxprlpJsUYJLZtTg1a4LzJzg==
X-Received: by 2002:a05:6214:1ccf:b0:786:8f81:42f with SMTP id 6a1803df08f44-88d8369eac6mr675359666d6.39.1767396264962;
        Fri, 02 Jan 2026 15:24:24 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a186287e3sm12691524e87.97.2026.01.02.15.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 15:24:22 -0800 (PST)
Date: Sat, 3 Jan 2026 01:24:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 04/14] wifi: ath10k: snoc: support powering on the device
 via pwrseq
Message-ID: <trdxottcptxd5uvgn63oaphemnsk6s2ujc3533abh6pm65iqpi@5ahtn56pff67>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-4-1ff4d6028ad5@oss.qualcomm.com>
 <CAMRc=Mey1ScNmosipLFg6mmABjeG2SO2L-pyjwTuOpOYOHZjqg@mail.gmail.com>
 <CAO9ioeU2JjzDwkGQzxc963kakNyZCtaSRAmLu=1kOAMGQeuZRQ@mail.gmail.com>
 <CAMRc=MdCxXg6Hbn_qPVsux2aAfN8cqpG946rS2Sb9J_Cjy0ZQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdCxXg6Hbn_qPVsux2aAfN8cqpG946rS2Sb9J_Cjy0ZQg@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=Av7jHe9P c=1 sm=1 tr=0 ts=695853aa cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=S1boB9Fu75youA7A4nsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: UkGeDPKpHwvySGMXZDJv7H0__5euxABf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDIxMSBTYWx0ZWRfX3CDmg5oDPrv5
 kCAiEL1KCDQWmVA+CePDnzgkV70Y9TtEjH1hxZ43A4i6lRsw6y3M09DaDorogQRgeVYp2NIJvRZ
 e2sMQ1z/aRNXxbNHA4LgnNcdNhXSIIMlnzZ4uEVO0/3JaoZgXJxtTEa7RlQCwx21rMg3yK3NhfV
 f11pIPQVdFqGycLkxE53guE08h6RRsEAEAyCZoDY0pyM64fMvkIy0rgu5jCa0brvdBEpuqw2AUS
 pSbkWmTA1SqlxGxG684s+P5iHlfa39zx4/n5pRyC/mfRXj0J6mfXWv8Yb0c0cQWa/jhdVnCGDtG
 P5bmCv2mUZrrWZkQ4eO8DZC5e1RJtlerAYmYGi+iSbPblthMbn+x3pLyHriAlz2i47dT9eQ3O1j
 ps6wGolB4cmZ+JOhaKwBJUjDOi0JoEfPr8IIjqP4Eh8dlqrOJdNoS4F3nYKZ/v8+aYmWDnCaYvI
 Fu/nqCJkhfyvgiJNG7g==
X-Proofpoint-GUID: UkGeDPKpHwvySGMXZDJv7H0__5euxABf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020211

On Fri, Jan 02, 2026 at 06:06:51PM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 2, 2026 at 4:10 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Fri, 2 Jan 2026 at 13:07, Bartosz Golaszewski <brgl@kernel.org> wrote:
> > >
> > > On Wed, Dec 31, 2025 at 12:36 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > >
> > > > The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> > > > voltages over internal rails. Implement support for using powersequencer
> > > > for this family of ATH10k devices in addition to using regulators.
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > ---
> > >
> > > [snip]
> > >
> > > >
> > > >  static void ath10k_snoc_wlan_disable(struct ath10k *ar)
> > > > @@ -1762,7 +1779,27 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
> > > >                 goto err_release_resource;
> > > >         }
> > > >
> > > > -       ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
> > > > +       /*
> > > > +        * Backwards compatibility, ignore the defer error from pwrseq, if it
> > > > +        * should be used, we will get an error from regulator get.
> > > > +        */
> > >
> > > Can you elaborate on this? I'm not exactly following. I suppose you
> > > mean the regulator_get() will return -EPROBE_DEFER? One of the
> > > supplies exposed by the PMU?
> >
> > Yes. devm_pwrseq_get() can return -EPROBE_DEFER in two cases:
> > - it is not supposed to be used
> > - it is supposed to be used, but the driver hasn't probed yet.
> >
> 
> Yes but normally driver core would still create a devlink between the
> device binding to the PMU node and the consumer of its regulators -

fw_devlink, which are not mandatory, time out, etc. So, no, it is not
granted that the PMU is always available during the probe.

> this device - so we can expect that it will always be the first one,
> no? Unless we need this driver to be firmware-agnostic.
> 
> > There is no simple way to distinguish between these two cases, but:
> > - if it is not supposed to be used, then regulator_bulk_get() will
> > return all regulators as expected, continuing the probe
> > - if it is supposed to be used, but wasn't probed yet, we will get
> > -EPROBE_DEFER from regulator_bulk_get() too.
> >
> > I can write that in a comment, if you think that it makes the code more obvious.
> >
> 
> Yes, please make it more descriptive. Ideally I'd like to improve the
> API to avoid such confusion in the future.

The prolem is that we can't (or I don't see a way to). Power sequencing
core has no way to distinguish these two cases.

-- 
With best wishes
Dmitry

