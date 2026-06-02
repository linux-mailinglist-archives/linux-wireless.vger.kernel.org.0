Return-Path: <linux-wireless+bounces-37292-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO3jKF+OHmodlAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37292-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 10:03:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CB762A123
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 10:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D65B2304CA6C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 07:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F711390226;
	Tue,  2 Jun 2026 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4//jXaC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269973B776E
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387017; cv=none; b=q2mpglG9BqUxVgbM/ZRKMc8y4m+6FT3NU9/LAo7j2PiJox47OXAKd0xaTBObHNumV+7ymYXuzqH4vhSTI7gYPz56gxRBIjNcfKNgXTmKlbsx/GmTXVu/JvybEaJBNBj3kZ/brf9OMCAl0qFxrNgsdBOYF/6UJtmFvYbOOM+Upts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387017; c=relaxed/simple;
	bh=i0fsA2ivhe11Y8u5gaIykHCgQXF8turnGuDsfusfryM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbXkGQCPY9ORJw+GXI4ikO6iXdH6Cumy0Q4b0KF4g5dSsBfhGWgKMP8GO2rL6F7BcVAt9aiYbA2fi0tm0YcGoLe7LR2d3rum6RhcFx/ELBBZCUJqWRK2hiEiidzzfTJEO3v/IAUVVEdhv7dgGzUf0hFACEuTX83xoxtpuVFdl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4//jXaC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1B11F00A03
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780387016;
	bh=IBxDHoejwDo5SnSlUDfdE/v8ud8psoV97bK5W9arbl0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=I4//jXaChHtEsAwXCmlkr80m7M4dYxDsHMuXgGPQQjV+bUQQUWcImdN+ike4TSNOc
	 yrDfSsJnrujPFDcBBa3xPL9dvkmhl4+ishyUdYtjWfL1Rt6XpmeyHF1WVxBbXaegep
	 KRbjCB8Sk1cdu9bbTqO3X/k4N0fkwXGjy0vh4mvtIAsvWSEJ8YmBt7fQaI84d1vkLq
	 Py7RQBfRySx30QcOVcfrKD4c2aINRlDYCFk9BuA6bM1CydpQe6E1dL5SdXs4Fl9+u1
	 pj8+dYOPZTE1vCBE86/Dg4WqoA9fXWQGXPHo4vjoPpp3QIvZp3pqudhQG3uup2JeMu
	 ALzO4V52uJlnA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3965bc493caso26375451fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 00:56:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9aK7/SlSI9MStLTm9cz2OU9MK5zwcwfeLp6VaRvITee5UGz6HTB27P1FmKMo/hH+Hvn3j7BZ8GTjF8VaMCHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLOV18ZrghT0TvYnYcni0BkSHflGEzU6FIdYAxLm1q3PTnD3US
	/osxt5jZaIffbtnjYZ7MVXAGMc8hn4Flx66JNq4TMX000cjNd8JUW3Hu8NY7CfZUaPrCSdG49Pe
	QNLnaZkoRUtfixJZj7ff2gs6sVyxnVbDpJwvOjDff/A==
X-Received: by 2002:a2e:bc83:0:b0:396:7927:2d14 with SMTP id
 38308e7fff4ca-39679272f2cmr33518171fa.8.1780387014648; Tue, 02 Jun 2026
 00:56:54 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 00:56:53 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 00:56:53 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260601-sm8350-wifi-v1-4-242917d88031@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com> <20260601-sm8350-wifi-v1-4-242917d88031@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 00:56:53 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mec4ZU4TswetjpWX+S8y9AmfAeu3mteDOx9zKLL_SB15A@mail.gmail.com>
X-Gm-Features: AVHnY4JD_Y8TgJ1t0LpA1dRA878Luk7CeT7uJ1XWJwhH04aYi2i6ZsE-lBCnpKc
Message-ID: <CAMRc=Mec4ZU4TswetjpWX+S8y9AmfAeu3mteDOx9zKLL_SB15A@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: bluetooth: qcom,wcn6855-bt: document WCN6851
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, devicetree@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37292-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com,vger.kernel.org,lists.infradead.org,bgdev.pl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 28CB762A123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 11:46:52 +0200, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> said:
> WCN6851 is an earlier version of WCN6855 WiFi/BT chip, compatible with
> it. Add a device-specific compat string with the fallback to WCN6855
> one.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml        | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
> index 0beda26ae8bb..ec766f40a042 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
> @@ -13,8 +13,12 @@ maintainers:
>
>  properties:
>    compatible:
> -    enum:
> -      - qcom,wcn6855-bt
> +    oneOf:
> +      - items:
> +          - const: qcom,wcn6851-bt
> +          - const: qcom,wcn6855-bt
> +      - enum:
> +          - qcom,wcn6855-bt
>
>    enable-gpios:
>      maxItems: 1
>
> --
> 2.47.3
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

