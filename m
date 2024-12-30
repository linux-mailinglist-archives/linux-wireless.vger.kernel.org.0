Return-Path: <linux-wireless+bounces-16922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72C49FEA9F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 21:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71993A28A1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811BB1946DA;
	Mon, 30 Dec 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="A4CPRPa8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86818784A;
	Mon, 30 Dec 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735590968; cv=none; b=rTEQEFEST1EE+tDwWtqc4Hvn72ln6VefgXGD9inYr7cqXwpc1kxowZlbPlZAhYdeColpR+KBWOm1cgS7tyax9nS/7DdjOrV/EJM35rBlw3NCX/PjEcczUCmLaCZJLI9kJlPTLrpq0BrNyRPeRbU+PrQWYHboJn9AIblufpHKLAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735590968; c=relaxed/simple;
	bh=IL5iWyTw1wyDKDKs5S1lESchTJaUrFP29Ebm6Q/UuAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+eNVxpo7zLtvHAwVchx6onq+8x+WWvzRN62jQGAIRuzQQRmo0vWi8x4jm+WJWPjT8i5v41+qlvSjfOMcIW2ImqSjXomIeM5QKTnNkqbFpSN/DpnwPJy0ey3hqTuiHu9/cXkBmOpeaH8pmMdNzrFVWgN/rUFyCsjsXpsWGnrWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=A4CPRPa8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216395e151bso90563485ad.0;
        Mon, 30 Dec 2024 12:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735590965; x=1736195765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbDtPVzPX6eiKblHAjusJQ2bBQDBb/Khlrlq648Wi1Y=;
        b=A4CPRPa8ZeQklVlUL8RaRr1qLn1b8oDEooc6PRTUClI28prDgxZSZv4wqaBfyDIWaw
         bfNFdJuXsNBUNsQR5bmwy5jW8T7x7XuGyLe3ELYBBuTBQKqzQEqz80uUMj8kgpFA2x1t
         SyEql4DVFirNLjyUNUzVpSdW7fWoHWbYgn3sJN+GUiFpupCcM98RHaJe7fZZtehlm0mp
         CLJGaAyKghVMLb9MMzKWOC54ehWmJDG0upW6PQ04jwKb1VwwV4pdQO8BZodKpqi0F7Gu
         uG7RwvLIXvXadJP/CC6ORJ0C6MJ2XYZ5lnMJNRIjZirmUwr9cgON4bF6uxuJNCVDEpMT
         Bd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735590965; x=1736195765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbDtPVzPX6eiKblHAjusJQ2bBQDBb/Khlrlq648Wi1Y=;
        b=rVjJsDj597QWLd3f8Zjd/mlF54WlxCGh3fneZiw+WALDMk4/WrUePYCi28uUxspych
         hs5gf/V1CLZAEtRtZRyUt8tu36SZC0Dw8Qs6FfnJUN6s/tVtJ/suRGDf6MTk70AF6Til
         cCR1bbM0GaembDdkDj1AucirQBi853EQn5FUWoHIASEnauVMOBIH6bFXUJKFBTirv3lA
         mDROBoRiMFwKr9GwRBFJmgG6JMbp2vSzDywaKwgAGzsMuES3va7tNgVSEgAAW/wvdtqY
         tPBZwGxw6DwVa5177weCjNa/diPsH5yoveeQ7La5aDSteuttzR1rESCbZFSC62xOZl/w
         dq0A==
X-Forwarded-Encrypted: i=1; AJvYcCVajYPIlGWMr5zJ2po9ZVbPNPY+rsvxkwC/mCDa8OzVb2KrRwlrqngNmIlZcbEWW0n96Uox0emOLL5rNO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPR/CWxPjDf0uxbV0Sa8Alor4u09XnvAFKY69zLoM/CAZlZsX
	zngQ5f29kX7Ch7e4vWu5JBzdvBKf4U3lPXFWb2JVVG64fcVVDS8peBC4i2nberAS0s+2a3fxcVb
	Lt8Qml9Hle40MM6w+V2GAukoQfWWncQ==
X-Gm-Gg: ASbGncu6Hibv4ThYQN3uR9iHZrxzRmb4eazwfznl3jmcKlPgRv2kVOs1i69KL3+yeZZ
	zD1D3X4SLBm9y6UE6IivWTbIm/vQMm1ZE1pREJBoez5zst7xpJCu/s9fwNuoGSekmgvNwr7Q=
X-Google-Smtp-Source: AGHT+IHdzTHppoiX/E0G0stg064WvodVEKEVfkFdQifJmYk87zDsR5nGzmBTi5aLnOfnP8Og00X4YesmXuJRbPLi4Rw=
X-Received: by 2002:a17:902:f54e:b0:215:a808:61cf with SMTP id
 d9443c01a7336-219e6d6ac7fmr469366685ad.25.1735590965055; Mon, 30 Dec 2024
 12:36:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013111920.679188-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20241013111920.679188-1-martin.blumenstingl@googlemail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 30 Dec 2024 21:35:54 +0100
Message-ID: <CAFBinCCgiJAimacWtTS-5JRMKbpKg8XN0Si3tvBjT+tJmCg0xA@mail.gmail.com>
Subject: Re: wifi: mt76: mt7921 Survey is missing noise floor
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Oct 13, 2024 at 1:19=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello,
>
> I'm using an MT7921 PCIe card in AP mode on the 5GHz band.
> It works well when I manually set a channel in hostapd.conf.
>
> Setting channel=3D0 or channel=3Dacs_survey (both have the same meaning)
> should make hostapd check for a suitable channel and pick that
> automatically.
> Unfortunately this does not work as hostapd reports the following (for
> all frequencies/channels):
>     ACS: Survey for freq 5180 is missing noise floor
>     ACS: Survey for freq 5180 is missing noise floor
>     ACS: Survey for freq 5180 is missing noise floor
>     ACS: Survey for freq 5180 is missing noise floor
>     ACS: Survey for freq 5180 is missing noise floor
>     ACS: Channel 36 has insufficient survey data
>
> I suspect that this is due to mt792x_phy_update_channel() (from
> drivers/net/wireless/mediatek/mt76/mt792x_mac.c) which calls
> mt792x_phy_get_nf(). The latter just returns zero - so it seems
> reading the noise floor from the hardware/firmware is not
> supported yet.
>
> What is needed to implement this? I can test patches or - if
> someone describes which registers to program - I can also write
> a patch and submit it upstream.
It's been a while so I'd like to ping the mt76 maintainers.

Also I want to point out again that I can submit a patch if someone
can provide me with the info on how to get the noise floor from the
hardware/firmware.


Best regards,
Martin

