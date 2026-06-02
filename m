Return-Path: <linux-wireless+bounces-37294-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH3UBliNHmoNlAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37294-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 09:59:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B47F562A026
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 09:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88187300908C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB8E3B83F8;
	Tue,  2 Jun 2026 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU56cKix"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ECF3B83E0
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387156; cv=none; b=fzBRV8m9eU0R+LPnXcPGz8l/zfUzYZxN+cGLkd9jkG2qdAAz2wnu0e49Ek8/cPVpl8zoQWWwJMC++ZHU5uULMgz7JIUDCYRbDYBZpC8/vtKIc/KUNW8YaKBBeHzbxJh1XKjpXZKKdSHkDGepIAMlG0AkC5c/29ajUdMjmiQs7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387156; c=relaxed/simple;
	bh=G/HpCIqlG2HxGomUFcoIVzuyzpu9MWocyL926EjXgmk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcGy5bXTWxjAw5v6CsrgOTdmvozeh6C1WSJ3yIJHD+OKcV6vD8+Afq4za94n4f2Uqnv5ry35HTt9ODb7NKal45cUiVkPsGbeS47Az7NEXP1w8V8oRxJnk8UMlrdPnw2mU/JINLxI5LMh7Nw0r/aEKZsuIhupgupkuOZvwtb9WnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU56cKix; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84481F00898
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 07:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780387155;
	bh=G/HpCIqlG2HxGomUFcoIVzuyzpu9MWocyL926EjXgmk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=VU56cKixBIDeC2J/S3kuGNTkdWzTND796sQiRbvRjPsWIIxdR5AQTls/gapJ2Kpz4
	 CP7v+v/I6a+Hb66HaYbyE4LUTpx3UPrkYmtHQy/d4PAVJyNxz4nPgaPzgBiYcthFNI
	 D3hPSHH+PDZXPAofn1wbxBiY1Cn0Hq25kS8/spmGAMHUaxlXt9EZNLrS2LwTdzogUp
	 TtOT1oTZXVGf6vLEJC7NzyJYEapDmkadUxV1BscXVTw6VZJJht4ikMmgLXDm1sLN9d
	 HIpFP9J+wzk58cp+Z7ZDpVcbtBflzOZZBVQaiXNTs7//x5FCI9dSkIyMRegbC41DdW
	 zdd8ZwBNJtLJA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3967717c951so29238451fa.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 00:59:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+o2gXz6yzXbXzpDRwglxPp3B38DbOk6bX1iV+u/+hfHqa3EWs0a0etSBGmUFWmvxyyCUSDhe4JTq2Y0ATv5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zlJo/sx58/3se1qKcs3aZ3kiAGnTEVVX116zQCB3t8ajU0kc
	/o8XCqJlePN1WLat9oW4qDF275GrN0lmU5GpbKtVDbl91bN2hlKQZdjPRD9Ct+YX162RKAAoMTL
	9Hh9PYnxFh2od4Jm1tcvXX/5ASCKh3x+TFjsO2Gow7Q==
X-Received: by 2002:a2e:bea6:0:b0:396:9897:4cc5 with SMTP id
 38308e7fff4ca-3969a852edamr10861651fa.5.1780387154481; Tue, 02 Jun 2026
 00:59:14 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 07:59:12 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 07:59:12 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260601-sm8350-wifi-v1-6-242917d88031@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com> <20260601-sm8350-wifi-v1-6-242917d88031@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 07:59:12 +0000
X-Gmail-Original-Message-ID: <CAMRc=Me1OFX9YO9bqBKFffaCS8FH7-_bSS4BsVgW+qoYQmDjVg@mail.gmail.com>
X-Gm-Features: AVHnY4Jj6PQ-4DZSgjCutJzrmJiIfEI2Eoc9MefyrTPUsszRaLc0Op3HHJ1m_C8
Message-ID: <CAMRc=Me1OFX9YO9bqBKFffaCS8FH7-_bSS4BsVgW+qoYQmDjVg@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8350: modernize PCIe entries
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, devicetree@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37294-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,bgdev.pl,kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B47F562A026
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 11:46:54 +0200, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> said:
> The recent suggestion is to have PERST# / WAKE pins and PHYs in the PCIe
> port rather than RC device. The kernel recently started warning about
> the older style of DT. Modernize DT for SM8350 platform by moving the
> entries under the root port device node.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

