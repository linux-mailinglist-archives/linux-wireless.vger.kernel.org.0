Return-Path: <linux-wireless+bounces-13796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E519963AA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07E01C20FB2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADED18E759;
	Wed,  9 Oct 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk7mvsFe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B54191F6F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463522; cv=none; b=n15rxSL898wUnocWzxVO/qMvjLJxWO82bEhYyi+Q5mJy9r+QMXNBmBcvHSiv+//y4NGsCmH262/vko9ACghC7r1qUSPPUpp+WShJg55hBMv95SUzXIAUuJgnRmCccWZ/NgyeidV8Ao60pFZtyeN09BxjlwfVQ0V7Llr/zsEV25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463522; c=relaxed/simple;
	bh=xIazxdcYNWytXt4yP0J4f4h7AQknqp5oyRkMTwCojRw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Uf9iyGnd+ATPLdZqlS0/EFZgkvCxdzIobQM2ec6/87Ha0GF5c7pNC6SpD1hFeaFGjq9QtcHOz/dhLajryiC0Xnkx/a7/OGM8KI3KVwe4qhRtYGEjjIALeuPrIwogneA3LbTHQjV77/xzOj0rFRo7FAX2qRVfSo8G6bdt9X+FAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk7mvsFe; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398f3be400so7482057e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2024 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728463518; x=1729068318; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tH4PRsvJaHg6SXh8tH0Cpk14Nl/3edve3hiE7lRH0g=;
        b=Mk7mvsFeoUEA7dzqqyg2Xas4ci6Y2C5yZYPRO1sGbnKT+P1Q+ooaxVHAlUQtuewG38
         xUrC23N7Ias8uDhRk6gh6WmYe+gu3aBk1rTLhonj/Ve+Gx41lDnjsvMfg+aexrBxA5Lm
         jUVA5QsfZGafn7+0p6sIEF6q2g0HW/jcBlSJEwcgateWTs5wgsXFy6ObUA/XJmCWGsBB
         YLEqeS0woXzX+sqnNNirXLzC9AJl//90FcAjhal3qCLXxOLGBqvE3rE6I+aZP8L8umvy
         mn2aR2ejE2aHCXgPrS7PH7iQeUwzr3EGXsa55GeI4SHASvjl3mj8/QDVcvtbsiLOquas
         Ln2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463518; x=1729068318;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2tH4PRsvJaHg6SXh8tH0Cpk14Nl/3edve3hiE7lRH0g=;
        b=iWmka2CfhsUpweBFm4Mo83RcaxLDYWxjtQcKnhccJ0xbuG2k/giDlF+9oZY2gXr+sf
         pSiidaZId0yi2e/E9rLQjN2cVPC6EaFPaGlx4kTKfwhwY5aeizgoG9bDgr7aFHziPWAI
         6ESENfJRUlPkOymeRgw4sfwAZ0e+gk1IbIKQI56UOSAZ+l2FNpht2OH6BI9NmGFE/mww
         Va3v48NiRnrwQ8QZ5JAQwWJDDSDB46hLfI5QTKVcpJb8jZFHX3uR/Mt9bXWZw5jFhPy2
         3Npcjcsi93JIPLtE/jqxj7aEbFFGXbeNFNu1Qdi/uzRtUnTFP6cRch3inFWG8Ov9WbW4
         lO6A==
X-Gm-Message-State: AOJu0Yy071gezid+MnMDsL6mir5P1dQMExZBCfIdhqgvGv3HqqKVbO6h
	YqAmiY3u4xl+bDsWRjHcHuGegjnT8sXfjc2iW1KNYLm50EHssr0S
X-Google-Smtp-Source: AGHT+IEZzAuvgxedsOU+1T6K7D6fTNM/AqY31hE2IBYY5COd51BUbYjqHOaZY9tiQ/uC+I4m/Df1UQ==
X-Received: by 2002:a05:6512:3d10:b0:52c:dfa2:5ac1 with SMTP id 2adb3069b0e04-539c48c6d20mr835327e87.24.1728463518130;
        Wed, 09 Oct 2024 01:45:18 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691b505sm9846001f8f.43.2024.10.09.01.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 01:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Oct 2024 10:45:17 +0200
Message-Id: <D4R56HZ6VXK8.K9SXH6LDM5GD@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] wifi: ath12k: some fixes and clean up for
 monitor mode
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Kang Yang" <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241008073534.1195-1-quic_kangyang@quicinc.com>
 <D4R4RHZM9GWX.2V6MHL6HW9YG3@gmail.com>
 <fc004753-2e5d-4694-9c35-8a4c4ccab7ed@quicinc.com>
In-Reply-To: <fc004753-2e5d-4694-9c35-8a4c4ccab7ed@quicinc.com>

On Wed Oct 9, 2024 at 10:35 AM CEST, Kang Yang wrote:
>
>
> On 10/9/2024 4:25 PM, Nicolas Escande wrote:
> > On Tue Oct 8, 2024 at 9:35 AM CEST, Kang Yang wrote:
> >> This patch set does some fixes and clean up for monitor mode.
> >>
> >> v2: rebase on tag: ath-202410072115.
> >>
> >> Kang Yang (11):
> >>    wifi: ath12k: remove unused variable monitor_present
> >>    wifi: ath12k: optimize storage size for struct ath12k
> >>    wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
> >>    wifi: ath12k: fix struct hal_rx_ppdu_start
> >>    wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
> >>    wifi: ath12k: fix struct hal_rx_mpdu_start
> >>    wifi: ath12k: properly handling the state variables of monitor mode
> >>    wifi: ath12k: delete NSS and TX power setting for monitor vdev
> >>    wifi: ath12k: use tail MSDU to get MSDU information
> >>    wifi: ath12k: fix A-MSDU indication in monitor mode
> >>    wifi: ath12k: delete mon reap timer
> >>
> >>   drivers/net/wireless/ath/ath12k/core.c   |   5 ++
> >>   drivers/net/wireless/ath/ath12k/core.h   |  23 +++--
> >>   drivers/net/wireless/ath/ath12k/dp.c     |  25 ------
> >>   drivers/net/wireless/ath/ath12k/dp_mon.c | 108 ++++++++++++---------=
--
> >>   drivers/net/wireless/ath/ath12k/hal_rx.h |  53 ++++++-----
> >>   drivers/net/wireless/ath/ath12k/mac.c    |  24 +++--
> >>   6 files changed, 114 insertions(+), 124 deletions(-)
> >>
> >>
> >> base-commit: b9545f4570fcfebe982439de7c9106e55b4bf756
> >=20
> > Hello,
> >=20
> > Two quick questions there:
> >   - If monitor works for wcn7850 shouldn't you set supports_monitor=3Dt=
rue in hw.c
> >     Or does it still require more work for it work ?
>
> Yes, still have many monitor mode patches. Will set this hw parameter in=
=20
> those patches.
Got it.
>
>
> >   - This whole series seems to have been tested only with wcn7850 and n=
ot qcn9274
> >     Is it still not supported on qcn9274 ?
>
> Actually, this is classic monitor mode for wcn7850, not sure whether=20
> qcn9274 supports it(I think theoretically it is supported).
> As far as I know, they are using full monitor mode.
Ha ok, yes full monitor is what we really care about.
>
> >=20
> > Thanks

Thanks

