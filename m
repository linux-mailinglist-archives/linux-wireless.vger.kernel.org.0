Return-Path: <linux-wireless+bounces-27706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B851BA92F5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 14:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71634189EEDB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C653301482;
	Mon, 29 Sep 2025 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmPInS+j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B532EB5AF
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148348; cv=none; b=O9PLHV2L6YqufeeUbfLhFxsMUOAT7h7dqxay9pWiRjgELQPzEwYa0RKsle/4WOxyVEjXs/d7ydJvWc2WO84KolWX2lu8Ds3eeCb0kZl8nzGnLKcuC++NxU8GkMzpykwGLsvUQysHQNniKkJuoWbRKPzetBpfQ8MLWpnXsbVsdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148348; c=relaxed/simple;
	bh=aT/DCjXCwhUv0XXBSmUnUzpw3KWocFMoT3s7DAQA7VI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=c6RLqXlPgncU8sYgA2FoKFyAyPcEipi0NwNbI4LJhQP5oHYqAyuGLds7+JDzxJLcJcu98AqnWSc3r7eUaVS+hJx9DvL17ugA7z/mSiSN3aErrZuYE4PdzL9S6oQR639rLYIEG/emNJP+R6XvMcuYguOoKn9u0oavitfTQ2LXp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmPInS+j; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso28338605e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759148345; x=1759753145; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT/DCjXCwhUv0XXBSmUnUzpw3KWocFMoT3s7DAQA7VI=;
        b=QmPInS+jwjsO/HGVVkULk5YviHAgmcQlFr0rLj/KFftJJOdevQ1HFhSmtJRSn1Kkdf
         2Z8qfy5j6grC1Sgdzo1e5Y9sYfZeYj0/WciI66TJu+d47z97EMWjMwik/Dib2K5uA+21
         8f+SmQZQR8WTG395qu5k8a/mblSfbAz7goY6dp1YG198OrV+8rfpEPhp1Nri3mFEzoxf
         euVjf+j1+lb7TajRhpkVUudYocGVKXWOgpf1cj/tzloGlpHMJkfRDYOpEqs8ONCkrPyN
         yyhY9u15IKolTexkPLb+WGAN4Niz7i/SkRNBHJ65hnj37GY4LYr6vVttG+gJVL85UqF0
         MaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759148345; x=1759753145;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aT/DCjXCwhUv0XXBSmUnUzpw3KWocFMoT3s7DAQA7VI=;
        b=Gv93yrEgjvc5BWD652LZUhK7ZGGJrIl2OMHxB2Jc8hMZaHKRNRvEZrDtDz/cvRXEmy
         GBHwC/Y6B7e+GYhUAU18X4luWTTjBDBSSxsgNqbRFpBdPOSU5gs6C0xZwmPUib83TsNo
         ekxvf+BFCMwegljf7QUD/mgFG7iAvZrczY1NHcg2SSHv49oeyya2TiIW69yDvWxXNlgw
         QoQoRAlN/jbN+l4h0tsdeamKdYfypZOPp/0BiIX8Nhq4iPa3ktE+TjXvktdVT+LBmXz6
         HPvQL7DWA6ZBNqMSaykfQRp/3txh4DNGFEk34QOVvv5YceSfMFocP2mFf4YWdN0f4h0k
         nvOQ==
X-Gm-Message-State: AOJu0YyCSTQ9TwoONqdAs4evQzqHPkLQ1RX106IYLcJWBXwaXyrGRAND
	6sFXK2faZnRVtX6IJPmVZj6p27FB8e0zsZU00BifTFcg+M9hFWy9ip5vaMTTTA==
X-Gm-Gg: ASbGnctZ0oVuNdjx2FGA59tRkdc0UAwRsyogwnVfLhTd1Z3tdv2X3ndBpDiKFwR1x6D
	BnJJ2R27t6yz+PoyMqaIa+nYDs8reQ94rSXvYmrg8e0aRi0nw+liR63CafjfAFXD6dJpxcvkmqH
	LVPBgCt5pRBPZJNqZRQBhKj/tAfFipPnATy5AKsK02I+R1tMc77JBsbw69A/eVX+nT0H7hroyJu
	W8fyloNMS/4OmkchAfEUiuv/c2weZdpY6it9ojqkL+UB+s94uOUsw62XejQCaXFVSCTNKCHAbs2
	6i5Rk47cwlZkQkUVyO0dFOvLLwb6YFQ+GjoJ5j6GGY0cfZmCuDF7rDop99WvC0aqUyQwyDBSR1N
	Zc0Xvnf9zY/q54JJMDx9brxvPbv7jAnj+AISumaKLf0H2iDEEAMMbNS97331fmM8=
X-Google-Smtp-Source: AGHT+IHBb08XFrh9vxYgcnIxlVs0+rX5j9ohWU54l76f6T3cELMRiuHTRW0h+WyLv2eggDY/UZF5Gw==
X-Received: by 2002:a05:600c:1d07:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-46e329eb016mr143107405e9.20.1759148344276;
        Mon, 29 Sep 2025 05:19:04 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f3dcacsm12050635e9.2.2025.09.29.05.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 05:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Sep 2025 14:19:03 +0200
Message-Id: <DD5A1KBRHCWZ.RXDUFTTTZU4J@gmail.com>
Cc: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, "Ryder Lee" <ryder.lee@mediatek.com>
Subject: Re: [DESIGN RFC] Critical Update handling in the kernel
From: "Nicolas Escande" <nico.escande@gmail.com>
To: <linux-wireless@vger.kernel.org>, "Ping-Ke Shih" <pkshih@realtek.com>,
 "Johannes Berg" <johannes@sipsolutions.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
 <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
 <fce447412112421887a1a81f5ada850e@realtek.com>
 <e79d3239-d536-45c9-b081-09ea7ba5bb00@oss.qualcomm.com>
In-Reply-To: <e79d3239-d536-45c9-b081-09ea7ba5bb00@oss.qualcomm.com>

On Thu Sep 4, 2025 at 4:24 PM CEST, Jeff Johnson wrote:
> On 7/24/2025 1:48 AM, Ping-Ke Shih wrote:
>> Johannes Berg <johannes@sipsolutions.net> wrote:
>>>> Before we move forward with implementation, we'd like to confirm wheth=
er
>>>> the proposed design looks sound. Are there any concerns or potential i=
ssues
>>>> we should be aware of?
>>>>
>>>> Out of curiosity, we're also interested in understanding how other ven=
dors
>>>> are currently handling this feature in their downstream drivers. Is it
>>>> typically offloaded to firmware, or is the logic implemented in the ke=
rnel?
>>>> Just want to confirm whether all this will be used only by mac80211_hw=
sim
>>>> or will there be any actual users?
>>>
>>> I think Ping-Ke previously indicated that they were planning to do
>>> things host side? I'm not super familiar with the timing constraints
>>> though, so I'm not sure what that might imply.
>>=20
>> Yes, Realtek vendor driver handles the feature in host driver. Having no=
t
>> tested CSA and ML procedure mentioned in this discussion thread, we
>> are also not sure how timing constraint to evaluate if we have to implem=
ent
>> the feature in firmware. =20
>
> Ping-Ke (and Johannes),
> Have you had a chance to review Aditya's August 21 follow-up?
>
> We'd like to move forward with our firmware-based approach (since that lo=
gic
> is already shipping in our OpenWrt-based systems). Perhaps Realtek can pr=
opose
> alternative host-based logic, and there can be a flag to select either
> host-based or firmware-based Critical Update handling?
>
> Thanks,
> /jeff

Hey guys, any news on this one ? Seeing the ieee802.11 bn preliminary work =
done
by Johannes, reminded me that there are still some usefull parts of 802.11 =
be
that are not completely finished yet ...

Thanks,

