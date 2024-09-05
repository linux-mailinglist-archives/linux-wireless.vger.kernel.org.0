Return-Path: <linux-wireless+bounces-12551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A087D96E1C6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567111F21A00
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459517ADF7;
	Thu,  5 Sep 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="C8Bh7oqr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C998063C
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560390; cv=none; b=SQ0k6K4aPC67UuCwFi3Kifrpoh+pfRuzLtb/+fsJ8PngzgxaCKvk7R36+bOdePqvUWuRjtC3HSLcH2FfiQkTacxkW/a9V5E60XAaGksDININbyObK5L6KO0JmjiLCRxFWL/pxYGzt2/r0NIRq4sr2yDg8YzNofoDi1obYMXBOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560390; c=relaxed/simple;
	bh=DEcRTH4Ksx3HqcRZk39EA6SSP0yZhl3amYb4gGAKjSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEBDjF609zWu82XQ9rtqPhSOQPUGH2ypB8ysiVZSRhriVQ+Q0WjLpZskx1ECQKiQFhmA3dtzppCTtPvtssjU0DvJiBeLIHP8MVMaI6vUEHoYs9hG6lT/xlFBxOf5JRNRn4YAVWWPGWT9WOJzrQ8XKirrDVg3OwiK8ydiG1xJpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=C8Bh7oqr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-536562739baso336591e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725560387; x=1726165187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtLGB7A2P30eTe38aKz83I8MagUAeBQdY4kLOW9iG00=;
        b=C8Bh7oqrWIgMZ2zoZq5olIW051cgItRHSx32mybhIXDB737qIPuJ3gyn/E2dVGN/TO
         AZNGhMxITOUkQLLlmPNm7FW/x9MrbNeY8vYOuAzXYQCCRyVScgfcAdlbl868erkDgmuD
         CCvfdsPh8KeJtwHqn25cP2NSqyjKyptCWZ2RRsN7QWDKyOLV74sr5cxw0sfc+WuSvRun
         fH0L8WRw8wLPOJNiN96vKq3PcgFEU1CkMIZSVScFiTnJlBzK0o9qqO/IIfCG6KBVUYgj
         Qp62S6meXhu/LQgcOFAJz5wWvWbbGN+/7KeSCKPoHCYOxATR4BsxiJcDAAMnivqZv0nm
         mmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725560387; x=1726165187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtLGB7A2P30eTe38aKz83I8MagUAeBQdY4kLOW9iG00=;
        b=dDWJG0TXGoUGzBwf4XSr+4gfCuxV1Sta3T/TSIRd760wtTikTU+rdy+uhl/sgDw2U2
         SyaUr63w2i86oJK+4Jj+CjjeyJ0Tn5X1hu02JW7rbwImWE7JHGgbAmEk6LrYsApmSUrL
         +iuqwl64z1lIHmM4YqobSEwrDpOoLO8S1p/tNA9IeVKPzD04AZaOsvVIAE6rQMBJc3Ie
         JVWJI4X52EkzlqUQvpodkcwzbDRW+VUsCR1ESJ8yjIkqHYaqrgLgPIqmkEOWLe0oXbGa
         BnYOi+5pRv/UnFOIY5DzigYM2+fe85FEVWOGJ44sKJrtHqQ3biawPyLJKwI+g2Av1743
         I6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWMBwSM11/h7DoDKFXGPrNKH/HpwtGPXPSpfuN3zgPbS3abOGFwbBgKVb/YFoFGYkaq9mu0lSlH+wayG7s+Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpdz7EZfHvN93LnOzhjj+c73S7IzJoneJA1SAkJNXr7I51rzBE
	RYv5xQNXTnWh/8TNK61s6+Q50qhhjInhfMDc5JHsIP3qnix576FgWSOwY/uTHntCUZ60K6h/zn4
	m6FNrT4wDa9mmMIHqm6QG0Ng1GvGEnJlWTJ0x5g==
X-Google-Smtp-Source: AGHT+IGO7FS+EJM8t1Z0R7LnnK3tpz34UapBrYrk0FGwJ34Y7Hp9Wg/QTQV1SbaJDUTpykBxZNv37DoXB5odh9EO2F4=
X-Received: by 2002:a05:6512:104f:b0:536:54d6:e6d6 with SMTP id
 2adb3069b0e04-53654d6e81bmr1544176e87.17.1725560386293; Thu, 05 Sep 2024
 11:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814082301.8091-1-brgl@bgdev.pl> <87a5hcyite.fsf@kernel.org>
 <CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com> <87y146ayrm.fsf@kernel.org>
In-Reply-To: <87y146ayrm.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Sep 2024 20:19:34 +0200
Message-ID: <CAMRc=Mfes+=59WP8dcMsiUApqjsFrY9iVFEdKU6FbTKAFP1k_A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:47=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> >> > +  - if:
> >> > +      properties:
> >> > +        compatible:
> >> > +          contains:
> >> > +            const: pci17cb,1103
> >> > +    then:
> >> > +      required:
> >> > +        - vddrfacmn-supply
> >> > +        - vddaon-supply
> >> > +        - vddwlcx-supply
> >> > +        - vddwlmx-supply
> >> > +        - vddrfa0p8-supply
> >> > +        - vddrfa1p2-supply
> >> > +        - vddrfa1p8-supply
> >> > +        - vddpcie0p9-supply
> >> > +        - vddpcie1p8-supply
> >>
> >> Like we discussed before, shouldn't these supplies be optional as not
> >> all modules need them?
> >>
> >
> > The answer is still the same: the ATH11K inside a WCN6855 does - in
> > fact - always need them. The fact that the X13s doesn't define them is
> > bad representation of HW and I'm fixing it in a subsequent DTS patch.
>
> But, like we discussed earlier, M.2 boards don't need these so I think
> this should be optional.
>

If they are truly dynamic, plug-and-play M.2 boards then they
shouldn't need any description in device-tree. If they are M.2 sockets
that use custom, vendor-specific pins (like what is the case on
sc8280xp-crd and X13s) then the HW they carry needs to be described
correctly. We've discussed that before.

Bart

