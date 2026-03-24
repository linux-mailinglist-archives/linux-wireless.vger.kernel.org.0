Return-Path: <linux-wireless+bounces-33779-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDJsBgiowmkyggQAu9opvQ
	(envelope-from <linux-wireless+bounces-33779-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 16:04:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0C4317A77
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 16:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61D98301947F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B7E402BA9;
	Tue, 24 Mar 2026 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hr+xyrz3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB1402B99
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364669; cv=pass; b=U7H9L5VocNcVN4zlZmAqrljYEsJywv36Lj02/5urq/84YrgJgw3D7Fz8mPHrrdEtV06+O9NxnZbEHjKbiIolPR4h83JzCSDzmWDDFJRqUFrfs/2HFr1V3ldm/ba5ijAUfb2883LM3YjwkbG54CL6WhW1EU12rLRhFR1OhoapaG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364669; c=relaxed/simple;
	bh=FQxDntrL8YL3mWkzhweOtwxoobY3Z+tpgmDJR8tTXUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cypkmBfMgWouUW/BIySlAAJooZ66wAwjKScj3LQV2w9d2FQey1VvIJKVTJ95/7v+rp70ADNst2dYYwNq+7eqjWD9YC77FXcEcUoCbG8nu7IPEtNjPLLsQSNwynZB7Y9IJnzN+h3YVVTP5SJc3G9zl3cbgUUsPiMnK3+X0Maa4T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hr+xyrz3; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a133b686f7so1544480e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 08:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364666; cv=none;
        d=google.com; s=arc-20240605;
        b=BnjER9RmW0qXulPfDBcAE5JbTHHTvIWFS3R7BMgJwSiEvTLr0/3k6yj/y2ts2YyfNk
         H/f/ICrU2DTnKP1I0R2SYa0MR3BnADiUtRS70DJQWCtrBF3V0Lp2iyYlrG5AIPlEGxjp
         5CVnw6R2sNEKufSfz+kkL0xAtmH1z1l5NO8t94beV+WWJWEdG9rUS4C0Go7to+f96liJ
         Qen8Pg0GCWN3oqIM/x/RFWCNxSK4Upi+fatgl4vzNPyciBg75fNt3aE4kXLQltV0EIw6
         jhpqSwbBNOPi2IDM4Od7BOlMq2KF/fXk616zrW62lFgGxvBGZoL2cjjtizMDxWr+LfF2
         qT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AjCxn1Cse5cZLsfMqwS6O3xXKU9LhII7wm0gPZuu+cg=;
        fh=yDkRvmrulJK0xLMKcaeOQRSCSNLEJEjQ8Zt0+HKv9p8=;
        b=RJdw/oab+NMwc3b3x8U1WRM7KGaeI0jq6TvPxGu84nWpEiyd9WYzwsgw4Uc4J3zhN+
         aX+pY1sb/QRoxXc5tzYjvpmJhQjznZG+gkPR5FGopCBfhCAiJhdZtpWuUZGtSYA76yMn
         w48j4mKum5Bf6A+23TexEPMSloH63JBkB8Sj2Iq1bHha0Y2WIVHJtuArjY/HYwKQbrEf
         5iQzJudCE5TtcPrejE8ESrhzP2HdEsnAGYczjGKdvo1KXhYXcYEKfdFbC3LtJ7ndhvd6
         EA2ECUb+Bmo7fbGI8THnIIyY8PUsrymdxiqTx5aXPApATh+K9/WCPTCSgnu2U9TZax42
         NKjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774364666; x=1774969466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AjCxn1Cse5cZLsfMqwS6O3xXKU9LhII7wm0gPZuu+cg=;
        b=Hr+xyrz33JU+GHmpkTgLxd1MbuxOVh4x8JGcWSjXeR1sI+a7E04ruOrO5HRkGDwNUx
         kMIC3kkIBjjzGBKXVXT+Qo0I3y+ZUsm7jtWy5iWVA/oM6flB1WMJOIWaxvFo/RJaVE1Y
         l8OUxpxV4A1nCNFnYqD2gFgA/358LcIlrPv7tH1GRm8GaZcKggXYBnZBAYtvgvSfhj7J
         hJXLCJFr5tOynWcmKomXKGVDJUuvLesOk9tGThN7vmNu1SmadoaaJiCrsLK41HbJdx3G
         /fjeVWLBPGfcsXjVzLo/P4vcHHrLRXkRSJCWOyfj+ur6Ilhph1rb/Q35RA3aeGnXgH4N
         oo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364666; x=1774969466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjCxn1Cse5cZLsfMqwS6O3xXKU9LhII7wm0gPZuu+cg=;
        b=MX+W+JvDr1wprzRX7IVBWZ3EEBfNF7gqRP3qYYLtAFjjQH12Wl7GSVlfFy4h0qBAyl
         Cs6Mkg5xfNpGlwofbURFRgt1AfRsTC4RCFqbnYKHFZ9y1Yj2B0No/QYpSyGtDXmRyxfN
         Twz2KVR8jEgVpR240xiK3VlBXLWWRizBUhpyTJu0IcCUUQDeRqmUqp+hWg2dNkRUhiQC
         BZC7zlipI3wLLnJUHTobSW5UNOnkkAzfmxpp7tpx3t2srgJOeFLU9hmetnijrhxX5Aji
         K58CliPjAGF0dWrP4KLnlCQ7xYOgP5yglMZlpYPmy9uQibtPCCNn8Pq0kI1uag79fcjL
         JaRw==
X-Forwarded-Encrypted: i=1; AJvYcCVhV0v3yxmAXbecPhFWLn1H30nBhOP7s8dZ/63XGkX6nZnKvXDGTASu9L1fo0f3Iu9KqQGnt8AoN/G6SUE8PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjmsjj/FQhetiRts5Qp9lENFvBMww13xRJx6dXPafMj660SStw
	dDgvnJ3KojjWbRecksEO4+1FccbEQt4Eyr3L1KPWCeTYP/KP1a+KALkvoLBROGb9vb8H/ZTGKIA
	/Dfmo6pqZI/JlbvBUbprsBUbf7W2crSb8TDJbG7Re0A==
X-Gm-Gg: ATEYQzz5zmxvYVpAKZD/wFd/LCy7XaWA+TS18hEb7V83RnL4rA5x126wSfO1piDf3+U
	ypI+xYg7zaCGMCJsy/kAbNeHcA+NiOW2mk5WvMjW6sYcazossdc6W0JqDpeHbjy64jFlPFqewRw
	EtWBN5eSBbyeOH2NQ2YhuBpcvDWaTdoLcVrWJhIOE13J9xP2H5xHzFInMaMm7SGVkj9GqJADsGI
	H4oDLu4hngZ59p5M9/una/QTVa0/SyT6h3nO8v1/e/xqn4AcCdIoE33IWDvRbNFTTmnZ/BAMnJE
	ckfCAVp2
X-Received: by 2002:a05:6512:318b:b0:5a1:27b1:1e0b with SMTP id
 2adb3069b0e04-5a285b5879dmr5609526e87.38.1774364665808; Tue, 24 Mar 2026
 08:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-add-emmc-t7-vim4-v3-0-5159d90a984c@aliel.fr> <20260323-add-emmc-t7-vim4-v3-2-5159d90a984c@aliel.fr>
In-Reply-To: <20260323-add-emmc-t7-vim4-v3-2-5159d90a984c@aliel.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 16:03:49 +0100
X-Gm-Features: AQROBzCPIbxWE8u1Ho5blhjIXaA43rjAdkegBcTuKwhyIBqFQ-RWFD1-u62lLKw
Message-ID: <CAPDyKFr5VHukeBE4Z1kVe-hUCFUCrw5roP=hT5jQC5b2X2fENA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: mmc: amlogic: Add compatible for T7 mmc
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33779-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[linaro.org,baylibre.com,googlemail.com,kernel.org,sipsolutions.net,broadcom.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:dkim,mail.gmail.com:mid,aliel.fr:email]
X-Rspamd-Queue-Id: AA0C4317A77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 at 10:58, Ronald Claveau <linux-kernel-dev@aliel.fr> wrote:
>
> Add amlogic,t7-mmc compatible string, falling back to amlogic,meson-axg-mmc
> as the T7 MMC controller is compatible with the AXG implementation.
>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> index 57646575a13f8..40dccf9715781 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -19,7 +19,10 @@ allOf:
>  properties:
>    compatible:
>      oneOf:
> -      - const: amlogic,meson-axg-mmc
> +      - items:
> +          - enum:
> +              - amlogic,t7-mmc
> +          - const: amlogic,meson-axg-mmc
>        - items:
>            - const: amlogic,meson-gx-mmc
>            - const: amlogic,meson-gxbb-mmc
>
> --
> 2.49.0
>

