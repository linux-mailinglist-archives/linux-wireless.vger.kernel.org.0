Return-Path: <linux-wireless+bounces-30287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8DCEE383
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 11:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 787A230198F8
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21902D879F;
	Fri,  2 Jan 2026 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8RBRmGE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA022D3226
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351302; cv=none; b=SjyWFZ9kMxeYZ2F+sjCMrSIBjg1x5r1YLIfxFfmar3+2G0R3vMAq30ThkGFhy5+cbnf/wPs63idWuX1QzLdbUikX7OCbpdJvt1BjNMGCbwyFQxIk2jW11zWystclXE2s7b+WcAp301CNUx1AiaOKT0ouvG+nfW7yCAsgyY73gII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351302; c=relaxed/simple;
	bh=2MSWLmERer6P1TQXzvhyk6/QJFLaS0pEuKvejes0xqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmFBOZI9fmStP0hdFhU6aj/3MxfmisjnivnpEy7FvFO9UQ79t9x9hM4qkRiIfMBK1Uk5VdmWpG4+su8J8MfBwzLEtWXmCbNJqGogv5jaoFR/r1j1/pIf7zoy4p0y1Jb7jW8xIAeQYvZapt6wNAm8Ccuy+oKBaN8Cw5GOKvcubNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8RBRmGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB38C116B1
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 10:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767351302;
	bh=2MSWLmERer6P1TQXzvhyk6/QJFLaS0pEuKvejes0xqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d8RBRmGE8h9s72LUj+E1SQlz8IheKQQr4F9LnJskpfiKA40LSWagvn5p8kPaC0ogo
	 wrNLKwWwRziDJcpDzk7viILkkqvDszJsbXRxQv6xa5owPy58NhYbA1jBN4a5Hvivbm
	 xE1dY1JzauwXDag0KXo7kB9C1gdE3z8KStWkemMC4c6lc9ouMloB2w/wN9iLSQwxyo
	 JZWs5hRLEL9PXM4Q4yCwtlZNZegZPvvUSJf96FRAU5itcjyjqwQNkaB2aROTXGrcvu
	 DByAGoJ876oDVvxzq4ebjP7FoS9yut6pWqWIGeOix8l2rp4QdvHLIrp/vunl2uEyFV
	 q5psEkgFsUXYQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b30275e69so7116455e87.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 02:55:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUz5a6ZyYGSrTLnC1gRZ+omw9aCL09L3s8q4gx3pOb80BwvoKBA3cTqYuXpIE9y7Q8+eb2HKYIrNFDLSTIoaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzziy1kE4Egoz9HrVZQMC6H7N9oTSeRIQOY2V9UyF8zb9Xtmwu
	QoRfwCbagUFIr+hkL/rXT/tQeYlV/FbJenlPj3zYjqwXDMduusuVk4Xo3QT/q/tWSNJtFp91C6n
	/9j9hJkGJ2rydtyLjR0n9iGK5sgO6WUWSTKwSUByPsA==
X-Google-Smtp-Source: AGHT+IE3wuqwhhZBoW5XeciJahkVWmtDvaII43AmrTFI+5uo0TaQV8ir4NrgZCEOO0OAdXxh6N3P1CB6vFYdTkYD2Ug=
X-Received: by 2002:a05:6512:ba3:b0:594:55ab:57ff with SMTP id
 2adb3069b0e04-59a17ddb48amr12071035e87.33.1767351296119; Fri, 02 Jan 2026
 02:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com> <20251231-wcn3990-pwrctl-v1-1-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-1-1ff4d6028ad5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 11:54:43 +0100
X-Gmail-Original-Message-ID: <CAMRc=Md4pqhouCc0--Ew-cPDYp3wOj97=vfCPqELJjbqZCd5Ag@mail.gmail.com>
X-Gm-Features: AQt7F2qltvB2UU7GWk8z6M_fSp-9tAVaUHvoANn-Hv2ylsV5N-rqoTXZjvTtmcw
Message-ID: <CAMRc=Md4pqhouCc0--Ew-cPDYp3wOj97=vfCPqELJjbqZCd5Ag@mail.gmail.com>
Subject: Re: [PATCH 01/14] regulator: dt-bindings: qcom,qca6390-pmu: describe
 PMUs on WCN39xx
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

On Wed, Dec 31, 2025 at 12:36=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> WCN3990 and other similar WiFi/BT chips incorporate a simple on-chip PMU
> (clearly described as such in the documentation). Extend DT schema
> covering other Qualcomm WiFi/BT chips to cover these devices too.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

