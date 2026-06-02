Return-Path: <linux-wireless+bounces-37290-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFHTOPmMHmr0kgkAu9opvQ
	(envelope-from <linux-wireless+bounces-37290-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 09:57:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E881629FE0
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 09:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46824303C664
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 07:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F410D3AD534;
	Tue,  2 Jun 2026 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5CPkARY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E947521ABB1
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386842; cv=none; b=l6VlKfcvFdiK35uFTSvBgU22dMWHr/x0RoVVQan0k4LbzFPICpg6r/X1ZxxsKwKeE0nQPuu8zjO0d3ywXxRlBSxnwR/7F1PiuZTgNE3nPJh9aH911GnnAEJ7AWe/kyIQib2LcFKUV0pSPT/3VEPF5dJ4x7HYpNPDb1n90wiIAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386842; c=relaxed/simple;
	bh=/ChsxAwgsClBDNPIth6BezLESO98dSLBlGagkpxSxxU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWq8EDS60K5LtB4TgQEn14iVWDikhK9dtV/00QKpni7VDwWl1qR2RZ/sbVSGQvUKlX7sOCermzLx1WM1EPLEh0hXZxAP/I5BHWIE91x70cnECY95ZnE5YDUbC/OeGLClLK9ARGE2V72fupKHWLUSMS7dNt6HR097MQtbKH6KPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5CPkARY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBA41F0089B
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 07:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386841;
	bh=/ChsxAwgsClBDNPIth6BezLESO98dSLBlGagkpxSxxU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=X5CPkARYWkA4k19BezdQ17m0KwkkTG35hhXE3fTOC1whAt/xUUCYkpYNPejA6TNo1
	 03l14hqNxkBTyGQDJakUZLQPCbwf1KtfzZIk8GXLgOxHDL8V7uOQ4qFREZc60nbdDs
	 Y5ahmashf9rDULNbgQcfEmx9htr9PVPsZ13g0uFgQUm/XOlY8D3f9v4AQqx74Fdjsy
	 EnDcG83F+AogZaVAdsk/MNuDZ0YHw4NtAgvIOR6D7ZGoV4Qo1DuzEf5+TZhBDnAsmb
	 J37Kkt2aE/fQsp6VC0FlJ6LNmHXaRcfDhs54otkJAKX1CKJaQLi9lng6cXYoA1twc4
	 Vb44KGxbvDk4A==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39666ac91a2so25176171fa.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 00:54:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Gcc01NKbFsbCiNEaJMtwGIH/08eL0Gipc+7Mq4+uQezp6GjifYR9U2Q/RnpAzsZY5ASZlJOCUTYOeYCHgdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mzqx0Fu7i22Z2zCrHCsRTXe8JVxZRUX9YAar2SSw+zEJlF3I
	stvgLiCl1wmyXPES7xD2/FO5rCpXE2ygnpG7lm41pK0IViZ1fhU0JyK9W5pZ9TDTCFCALwThMAZ
	LcJq+Uo1+ej1/a573I0lryWXf/jwzBOUiww/5IV9RrQ==
X-Received: by 2002:a05:651c:2357:20b0:38e:94c6:b706 with SMTP id
 38308e7fff4ca-3969b958f28mr5892121fa.7.1780386840351; Tue, 02 Jun 2026
 00:54:00 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 07:53:58 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 07:53:58 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260601-sm8350-wifi-v1-2-242917d88031@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com> <20260601-sm8350-wifi-v1-2-242917d88031@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 07:53:58 +0000
X-Gmail-Original-Message-ID: <CAMRc=MdmjW60qnyaFMYjGHVLaxxqVH2ZyRUV3YObOVXSw6V3Dw@mail.gmail.com>
X-Gm-Features: AVHnY4L1ltQa8oqTnx4DLvt4170BIuS_6mAm3-M2qQKtchkaVsjqTQPH2N9Sz0g
Message-ID: <CAMRc=MdmjW60qnyaFMYjGHVLaxxqVH2ZyRUV3YObOVXSw6V3Dw@mail.gmail.com>
Subject: Re: [PATCH 2/7] wifi: ath11k: enable support for WCN6851
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37290-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,bgdev.pl,kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7E881629FE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 11:46:50 +0200, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> said:
> The WCN6851, found e.g. on SM8350 platforms, is an earlier version of
> WCN6855 platform. It identifies itself as hw1.1. Copy WCN6855 hw 2.0
> configuration to support hw1.1 version.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

