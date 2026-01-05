Return-Path: <linux-wireless+bounces-30360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B55CF4248
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 15:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C3EA306580F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D619C3469FF;
	Mon,  5 Jan 2026 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APCoVxSL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD33469F0
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617214; cv=none; b=jSpeqeSxzWJWtH3iBnu9u/mCWYuNdCpp82emDkrrU0+oNh4urSY6DBfhphc8FHDAbzTt0VeA1z+8GKzA2oV/YjUrfNOUId/BMJczbqmouSCwnOHfyvRiGZv+GtkD31pE15oHFZEz1bu+yi8jmPmYIB1YlLpucmVffp+v2STB31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617214; c=relaxed/simple;
	bh=O9yYPx9fhepEWV38D3wDxCo2mcWuQM4sfdGpxfSSBv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrJQeEHPXCbhD7ovmXD65JKC3ZfCYURRqYq4YZJnXyDlAigb/BT3LF5LzWTGJEXKSAkEhSbqkK+ejHO5Ndtpb6ggaUASZiJJ2xxeHMN0xIt4AT+A8MuChXqd+3o2ERVlJc7c0hB/12GrU2BSy1pW/nATPyrgUPbB+qvZ+P+tykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APCoVxSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBACC2BCB6
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767617214;
	bh=O9yYPx9fhepEWV38D3wDxCo2mcWuQM4sfdGpxfSSBv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=APCoVxSL8loQ3A4Rtm17gr4rZaFws8fcuj9FoAIVThldVe1ljB74VQ0EQ6b82jzvU
	 HdaoXUaBshkQlpCGWdpvEapF85k8bbrOPumkfiOpejZlo/+PGxWYxEMIIp4OpSG5TR
	 b4yDRzIpVxRswvKFfrt1kY1na5mob58miG8D4Y8X2p8v0bBJayUzBpONXxEsKVgHwR
	 KTZou4f1LhBsmTCQi3trzxBrpPq23X2o8yCoZX5KxKpmwVfsfgD7i8KqLuY0bj/z+i
	 XVLhXD/HkJPbpYB+OCWEq4mOpe47It7AEGR/tKxh9ooPTRRChiJ0izATE/QyeyM24q
	 d3hH1nS0gCqeQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37b99da107cso132656461fa.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 04:46:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUt/ORN/r5lt+Ma7iGZppl15K1mSj5GMr66dYaPgl3Dr+/EMgHMJKYBdj3liCXdltYPZ692MjZkf/O5hqlVeg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5z0HzJVZAgbJPhJOdFXWUpQFlAnUzLdnxcMVvru0LVUTIHpzf
	JYBMRPMvtZkkPiHG0VBLiTZOkoHbAFACVhAgsu7OICBPBObwZzTlwwmm9mrZKdgx0Ao2VcnwyIN
	OaQWf9mWNJmbvV4CFc6QB3oiDHVAS5ibOh437Pw60bw==
X-Google-Smtp-Source: AGHT+IHhSO4SbYWVc4ny+e082u5A2vt8h7HBHJ419HibXnBd8pf/hT+MPi0IBRnNqK32oCQspxtxsaJkeH9xGMEBuik=
X-Received: by 2002:a2e:a54e:0:b0:372:945c:cdbd with SMTP id
 38308e7fff4ca-381216421a8mr135654281fa.20.1767617212836; Mon, 05 Jan 2026
 04:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-4-1ff4d6028ad5@oss.qualcomm.com>
 <CAMRc=Mey1ScNmosipLFg6mmABjeG2SO2L-pyjwTuOpOYOHZjqg@mail.gmail.com>
 <CAO9ioeU2JjzDwkGQzxc963kakNyZCtaSRAmLu=1kOAMGQeuZRQ@mail.gmail.com>
 <CAMRc=MdCxXg6Hbn_qPVsux2aAfN8cqpG946rS2Sb9J_Cjy0ZQg@mail.gmail.com> <trdxottcptxd5uvgn63oaphemnsk6s2ujc3533abh6pm65iqpi@5ahtn56pff67>
In-Reply-To: <trdxottcptxd5uvgn63oaphemnsk6s2ujc3533abh6pm65iqpi@5ahtn56pff67>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 5 Jan 2026 13:46:40 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfSbzFOYOupbHqxgzzkB9QQWZes9Zwo9tekpgU7XSGNRQ@mail.gmail.com>
X-Gm-Features: AQt7F2q2v_tlBIEqNfDAv4Ihln_deVVE-LJynihU6la9J7DM_qGKBiZSK5K5xSk
Message-ID: <CAMRc=MfSbzFOYOupbHqxgzzkB9QQWZes9Zwo9tekpgU7XSGNRQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] wifi: ath10k: snoc: support powering on the device
 via pwrseq
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 12:24=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
rite that in a comment, if you think that it makes the code more obvious.
> > >
> >
> > Yes, please make it more descriptive. Ideally I'd like to improve the
> > API to avoid such confusion in the future.
>
> The prolem is that we can't (or I don't see a way to). Power sequencing
> core has no way to distinguish these two cases.
>

I know, it's by design, but if we ever make fw_devlink mandatory for
all types of drivers (there was a discussion about this during LPC),
we may be able to improve this.

And with this comment improved:

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Bart

