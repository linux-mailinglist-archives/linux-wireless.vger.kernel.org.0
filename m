Return-Path: <linux-wireless+bounces-33972-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB1uDH4pxWkU7QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33972-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:41:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 932943355B3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DB583104941
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602623F8810;
	Thu, 26 Mar 2026 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V83+EjKA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B93F8814
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528428; cv=pass; b=GKaikWuafkRZO9+PDZuO7MBA/M/bScbUpFrThFg8d11h8HSCORHPqZfLfq5mbBKGD39jlvkf5HrjUXpNYLbUYIdrA+9SWxlnc7xINLBS8dLo0BUgu436b1ms06/5vD0g+26w9wGKwt/Pe9j+ryJbrMjNck2oKp9Y++pGkDOVXVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528428; c=relaxed/simple;
	bh=LSGyBAMlrdeT9CMKolaA6GRSIsAXGM6kyoJfnzUtsyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZN4fU9JEvmGmZBf0IF5dESod/90l62k18db7LpZUzCMxe7TVQA0XirrpFJSX9znmNX+DxKfvRKjwMwakjRelKyj/YIcsqAIc8iPN2QeOhM1henYlTVr/qB/zul6PFUYQ6QtP/vIwAd9+R2vFyBfD64Q24crsoQyBOv8k0teISUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V83+EjKA; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38c551f2497so7086461fa.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528422; cv=none;
        d=google.com; s=arc-20240605;
        b=R61Cmy5WDOvoAJ+cgdKWjGoothXDPI4H1FXTEOaFMJZ+oJRYTNLHjR9OKsLYkJzZrY
         o6iGBJMndbgsQ20rL3tlzRlQZZnTGIZ2Cz5jju1/B78Rlba+TFlxMhoMpNtlQbpt6b8m
         TjJ/Ttp+OcAiTFm0xRJrkZrtTy8XlXPBACPC/h9g12gW+dWXashp2pVLSkAm63TtG8iu
         W2tD5NykQOe9IuK5ohe6RWxR0+d+xPmFl+gjhdO57ACyjpOUmGYl8zRevRouslNG9nxi
         SpZkT6J8opifnb30LaI7nJsshSxTomykykbcHE2nzv0yxd/Rn1quVzLPDlbUZ8TNRJaz
         mi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4NdPYgPAlCNYmYAY44z3R1vgWi5y6H5hfActLsqe8b8=;
        fh=qinZP+Yl8YptX2KYgeJVj6fLcbbKJ7aLfkgQfP0rP5I=;
        b=WDiAdhU+4qZuGZpLOohcOAvMOWtNzL3BEfd6FZ+1nxEi6CWPI8EYp8WaaU+tHZZeDo
         knCKS+pVqlsh53CuIW2r2Yd5053FturdX+K4wb6JJXj507cieEn8U3FTuQMWUC/j/RQt
         u66nqfPEaPvvtywkJGBuU9F5p2WViQ4jYqiMiZc9BHnZfyiPC8wb+2JHRpuzBzZP95zt
         ndeCt6pqq6Kj0xVBtZFZc7RMRhYV6J7Nb/CLH8aJStv58mki+f614jX5qp65FxyYRQkM
         KhZJy9CU1EjkXcUkyfPqiUHV4NQtm6N0bZfGQMo9IRQ06Ed/4y2gJrvIQ460WrtKMUG5
         Xqzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774528422; x=1775133222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4NdPYgPAlCNYmYAY44z3R1vgWi5y6H5hfActLsqe8b8=;
        b=V83+EjKAyLT7nPjvvuCupte8+OkhAc6BgKcTXS4xc4hPIdm2LlWf5/I5nLLMOKBxVK
         sMJnNjVFLEMn36hpI2O0TkdIkkbElOwORyd2mvntgYKQ2H6wOuYjW6WZynKvorHPZAfz
         LGrkvGOsc51FitNBbkK1drocgkS1o9CqXL9Lh8vdY9+wt6QiOKVDe8lUqCcjwca100nL
         AB4dkgrRFlcFqniLcOFCxa4vy6vpE0AfyaHi1XtFfiKrH2KVCWhte8GSLp1AEdcJogk4
         InHrQSlxwbW6Ec2e69j39XkLTPk2VeRb31lWbNt1yf0qASNtYJtR8rgakOIaL7gY9k1c
         hD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528422; x=1775133222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NdPYgPAlCNYmYAY44z3R1vgWi5y6H5hfActLsqe8b8=;
        b=kyZWf8NXMs0IkM1p5+ejhGCJ05UlebpI/Pnh2Z5kvjisviUEvnqzRZNTk9xJuOetpR
         kYQ3BlCg0/MixHjNXc3ptLmTnfBkEXwyc+KnuPG4iHbs6yiyvosHeNRY6bjuSKudgRPc
         V74Pmaptoi4QYdu4dMLrNfJHUCn05m4Zqg1nC6D0n1yizh0upMxtcXvqLTavt7gdQ4W7
         8kx8R3ro/GO3OMMBl2dmwJlTii7IoRm6iBZqkDzPpkGvdgKt64aLuXnP1bSEIsMqLYQw
         vZWHzKt+jCWfdVqxh2bWxNECZPT5+U+7wX4aPcAoy2QpoNjlwcHbNXiF4KvsDAPQyT+0
         246A==
X-Forwarded-Encrypted: i=1; AJvYcCWWzM9gdsYgJYQ8qkpWLuDB5c7dIyBSZdcd5dKxlGNodXxJDOJYNjSkrhKNBmK5M8bBWDH665P54admrbQ1Og==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHi2UgG3C+KRUL52z91wR9Xvaz573JKm10vhC2cIJZLmiAiro7
	gaO1lctuPm6/nr0sakKmYKDp6guDv/dfqOXh+ZJb168HSrlNZsE4QfSiJK7CwE3C4v5+IA3vEac
	YgKD19cEvx4tcYydfeWd8JS24b5BfRQ7vlmU9b9KQKQ==
X-Gm-Gg: ATEYQzwDlvC2Z23x2l6rRIalgQtxSvw6nqFYLKRSxWdwwV3kfMGuE13cGo1y036NQtv
	9CLB0tzSvfdGh73x9ENWDFQqKSRzO+U932gDFBFXpQsoY0/jDwGD/WSssKfKVdWJW2N+V6TaxFs
	pMhtuIzQoWlBJCFO/J/1atoQoBpRWVSwDlC7OJKxdw7MT63n5SgY2iCB0aDDBUuzdeYVlvnFlx+
	HnGBPxvoAuZq+jJXCYfRbGa3O5CdQPVhuDkWNKQzrr6MlFKeL40lPEbhsxmtPAas9F7d+CCKqRC
	BOEe7I0=
X-Received: by 2002:a05:6512:48a:b0:5a2:9cb6:ef4e with SMTP id
 2adb3069b0e04-5a29cb6ef5emr1889782e87.21.1774528421913; Thu, 26 Mar 2026
 05:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr> <20260326-add-emmc-t7-vim4-v5-2-d3f182b48e9d@aliel.fr>
In-Reply-To: <20260326-add-emmc-t7-vim4-v5-2-d3f182b48e9d@aliel.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Mar 2026 13:33:04 +0100
X-Gm-Features: AQROBzB17m2aMMak7aWoPUlujOd0n_VyTP6ICjVn8RwU1l2ZGeIzCfBikAgvSj8
Message-ID: <CAPDyKFpacFOs_T-Q5ETAEd+bjqtx3J2mZBioztCSM8Li0KgR1w@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] dt-bindings: mmc: amlogic: Add compatible for T7 mmc
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33972-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[linaro.org,baylibre.com,googlemail.com,kernel.org,sipsolutions.net,broadcom.com,lists.infradead.org,vger.kernel.org,microchip.com,amlogic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:dkim,aliel.fr:email]
X-Rspamd-Queue-Id: 932943355B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 at 11:01, Ronald Claveau <linux-kernel-dev@aliel.fr> wrote:
>
> Add amlogic,t7-mmc compatible string, falling back to amlogic,meson-axg-mmc
> as the T7 MMC controller is compatible with the AXG implementation.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> index 57646575a13f8..976f36de2091c 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -19,6 +19,10 @@ allOf:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,t7-mmc
> +          - const: amlogic,meson-axg-mmc
>        - const: amlogic,meson-axg-mmc
>        - items:
>            - const: amlogic,meson-gx-mmc
>
> --
> 2.49.0
>

