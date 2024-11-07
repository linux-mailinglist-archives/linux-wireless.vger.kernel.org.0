Return-Path: <linux-wireless+bounces-15082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25909C071E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0141C21ACC
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C520EA49;
	Thu,  7 Nov 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBpCtart"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965C1E1048
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985643; cv=none; b=EvUDXfQ325mIRjZPNIcc9KbOJKsNlVBBct++EXwcUYxGX9i6b8CzLNBUcE7ok8QY5DD3m/7chI6O77a992H/VOBTwDkFSXNTkqEXILcAYcT9QCYl2OcNAhUIi1RahHxYHgS8a5db+FrkYE59brtYSZqL6CbzOXod3L4nYaGiuVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985643; c=relaxed/simple;
	bh=50XRUp+6v+8lIyPj82iw5ic/E9OGU7yi8wfNqwwZulQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhGCz4W1xjFf7cJNrOnllO+fJC5mIpBVmeK+eOja2RAr/KU/Td+4KrWWajL506gpCY4q5WPOjBD/s9hpb9pFz/Oa3/ysABP2t8eiDoO37uX+M3uRAtwHHKIMwdP17M9BJjQWixzTsIn32unJUnXju9YS6fS4QEV4fO3EELKE15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aBpCtart; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e690479cso825899e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 05:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730985640; x=1731590440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wTJTU1/WgMnMhMsHkYEBclEMuS9M1UtJvjgM/eI3K/8=;
        b=aBpCtartE+0TI7CzNPxwbnusU/tOiF7kK0HRiIYFvtgSUzN4FFPjcNHJW2dqMngeN6
         c/DN0Bgh+zOw/Gwpl23IQp2HFQjUZqHtxqwYI8/E2vIWVVVaotGSAktyXflhYFCokThA
         6F4d6nwx5Ar2SCSXF40u6tikBEERq3FLpkYZlB7bl4hQxG2SLyT3ZdSa8YG8RdxWcR18
         L/rd5rrboNG8QJTJV6S1O7eSnVosV529MaVk/T8EnraJiqpI5FozuViVbsRNB80aZAUe
         nsUrQBaYGybDdOlbI07aZ2epTvw/PbabSXRC+NGRBndCmKHY0N0UTmDv6ArsmQ76/mgF
         v5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985640; x=1731590440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTJTU1/WgMnMhMsHkYEBclEMuS9M1UtJvjgM/eI3K/8=;
        b=hvHZUKjNGJPndgzbGFZ36McVEF0gmGM+VgIHI9b3B/zuQnYda86U/ZzbkKuYHPt4OC
         snEY0aMzeJdxcAWrUnc8CQNINlEDwhsfzscdHvQHtrKTrvzycw5R+x6dPPX/AGbsvQpq
         ++rLw6/QWn9+2C3n+2Vghbkq3195vzV4F3FAP1k+XqifRBe40HGUXTbYOLzd7k6O210E
         jipdhtnrk1qt/ivCW8nC+ZoSc2Py2JheWUTQ4Y87x3hpNqjGASMlVjmVIB3HpxdDCCO1
         ZnUILrl4CXwvOO8KGIswu63k/4R1SJ57iuVCiJeIf8yHC7MQkjhHeZlRRwIc5W47JJaJ
         npOg==
X-Forwarded-Encrypted: i=1; AJvYcCXofvBZxhVZy30ji37+o6g1m9ag/m1bvNNSdZzlS9i9vKBiuIIJa9JlOZJuaSsC1S8TW+hpQdJdpGXZ2IZkOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsSgF2+zfRaHrCWHSDHzmGr1UxbLAJHeIwKpGuKZ0y2Acj/x5P
	hNVKMUtLIl1S7M7CQucA60tbQKGu8EI3EyuAJwseVlwy5TlAS3byGNG+rz3jAs0=
X-Google-Smtp-Source: AGHT+IFvkWpQMrorpEfz69D8hdyKknrpmvGBejcMWnvwqudlmWyULPvb4Uly1A/kUgo7+RzonjdO+w==
X-Received: by 2002:a05:6512:1282:b0:537:a855:7d6f with SMTP id 2adb3069b0e04-53d65df4b65mr11452598e87.34.1730985640002;
        Thu, 07 Nov 2024 05:20:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a739dsm212002e87.158.2024.11.07.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:20:38 -0800 (PST)
Date: Thu, 7 Nov 2024 15:20:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] wifi: ath12k: Add wifi device node with WSI
 for QCN9274 in RDP433
Message-ID: <x2ch5ahotd6kfqg7tjvaav5kaxi7mfij4nsakxegp6j5pecomd@rhzytgayfoek>
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
 <49a6ec0d-8a0b-49aa-a9eb-1174cff930f6@kernel.org>
 <cmvfpctliqggra33u6ituguoxh3jxcuxiyjpbtcjbcgpu6lhoi@4zdthfkc2ed3>
 <692503b8-cf39-4d6b-b70e-910fcc710d69@kernel.org>
 <CAA8EJpqMCbyK0dodMNyfs8dNjV2QoB2nyWm233eOS9xo8BaFJg@mail.gmail.com>
 <9d158c25-197a-49fd-b639-45287a46438f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d158c25-197a-49fd-b639-45287a46438f@kernel.org>

On Thu, Nov 07, 2024 at 01:16:56PM +0100, Krzysztof Kozlowski wrote:
> On 07/11/2024 13:03, Dmitry Baryshkov wrote:
> > On Thu, 7 Nov 2024 at 11:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 07/11/2024 12:06, Dmitry Baryshkov wrote:
> >>> On Thu, Nov 07, 2024 at 11:23:20AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 05/11/2024 19:04, Raj Kumar Bhagat wrote:
> >>>>> The RDP433 is a Qualcomm Reference Design Platform based on the
> >>>>> IPQ9574. It features three QCN9274 WiFi devices connected to PCIe1,
> >>>>> PCIe2, and PCIe3. These devices are also interconnected via a WLAN
> >>>>> Serial Interface (WSI) connection. This WSI connection is essential
> >>>>> for exchanging control information among these devices.
> >>>>>
> >>>>> This patch series describes the WSI interface found in QCN9274 in
> >>>>> device tree and uses this device tree node in the Ath12k driver to get the
> >>>>> details of WSI connection for Multi Link Operation (MLO) among multiple
> >>>>> QCN9274 devices.
> >>>>>
> >>>>> NOTES:
> >>>>> 1. As ath12k MLO patches are not ready yet, this patchset does not apply
> >>>>>    to the ath.git ath-next branch and that's why the patchset is marked
> >>>>>    as RFC. These are the work-in-progress patches we have at the moment.
> >>>>>    The full set of MLO patches is available at:
> >>>>>    https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=ath12k-mlo-qcn9274
> >>>>>
> >>>>> 2. The dependency marked below applies only to the DTS patch. The
> >>>>>    dt-bindings patches do not have this dependency.
> >>>>>
> >>>>> Depends-On: [PATCH V7 0/4] Add PCIe support for IPQ9574
> >>>>> Link: https://lore.kernel.org/linux-pci/20240801054803.3015572-1-quic_srichara@quicinc.com/
> >>>>>
> >>>>> v3:
> >>>>> - Created a separate binding "qcom,ath12k-wsi.yaml" to describe ath12k PCI
> >>>>>   devices with WSI interface.
> >>>>
> >>>> Thanks for the changes. When you finish with testing/RFC, please send
> >>>> proper version for review (just remember to keep numbering, next one is
> >>>> v4 regardless whether this is RFC or not).
> >>>
> >>> Isn't the 'RFC' being an invitation for review per the nature of the tag
> >>> itself?
> >>
> >> No, RFC means patch is not ready, might change. This was brought on the
> >> lists multiple times and some maintainers clearly ignore RFC. Including me.
> > 
> > Thanks, point noted. I'll stop marking my patches with RFC tag.
> 
> Wait, you can keep marking them RFC! It all depends what do you want to
> achieve. Get some comments on early work or actual review for something
> you believe is a finished work.
> 
> I looked here briefly, no comments from me and I assume that was the
> intention of RFC.

Okay

-- 
With best wishes
Dmitry

