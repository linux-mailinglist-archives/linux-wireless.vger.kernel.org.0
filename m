Return-Path: <linux-wireless+bounces-32131-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB0hEl/gnGnCLwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32131-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 00:18:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6635F17F262
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 00:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A0D0302C146
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 23:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E34337F73E;
	Mon, 23 Feb 2026 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbhre8IR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2037D10B
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888639; cv=none; b=L7n81RCSdMD2EsFw3TfVyaX9oIyOD01UAvhRohSLX4VpNWxq5RHIZW8pncPSa0JrLPz+2MaiWujQJOCsZ0A11ff7dB5yrl2boOrBsS71qbhuge9DXDLsAH78hdI6PGHQvlpK76JiDAlz4YEg6IINJqDsQyMkz1P4YlwxrujIjQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888639; c=relaxed/simple;
	bh=5JuzvkdZ+fCWCL/51W1HKD/vNBKYgiS0gQvQiaEM/SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYDii+9f5QRZ4GVlIkKXSteHXr+40CE9dTHV4afWJbtFgTH2hccM9eO/9Irafjw3vgEn9r23HSnffy1/Bs26cyP2q+qk7CK/iiQm4H0NhmO38L8isQJEWfuDByEIYmO0CiGnfBV9QTlDxxJdqC2f8PULPpwA1DiUuLKwyJhMr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbhre8IR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07218C2BC87
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888639;
	bh=5JuzvkdZ+fCWCL/51W1HKD/vNBKYgiS0gQvQiaEM/SM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qbhre8IRs2gr3TwtmlhY30ubRiN97xfAFGqzCIdBU+3MgZL7+cKsV4LhkEeVNwhtz
	 u0wQytj5Fe8FLB6ar/GE8W1KmqRUT5lPKF4eFpoqmsUETGCJi7kdTc6vc2lAPP5Vfe
	 FN0YCUvAIYqFDzZnFwmRBZmdKhS/8MKl3A/fiVd8fH5dJtuHg84jlbSu8LiwBJNVW2
	 LWsHunNMBg0oyyaLBiQ0yHqA92fMbcvWJOjGppi5tukqH4tjNUbZ/cnvGTGpWAdDuz
	 SW9hxg8MwlRTqkNh9zRHYbadCLT1SWu60+fa9NcOo15Ujd7TLdrgUgsfJupCadYAli
	 AWLuYKFt+28Pw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-386b4c28ad6so42600461fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 15:17:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOX+cCWbOn7B/uUhMXr5xqbxpYQny8XHjkcHCCCaqnNzya81onjyAakUqTH6CHJ/m/2fthifEeWeR/jNpwgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8dWsraAD4s8chMT3RT8jZSg875cQqvjqvm7Y2RoiFOxEH6zK
	VKSPnxP2+QMsH/cY7JHOmTE43ZvJlbKZqtIccH7DSjeyJjX0W88YjSOXmbcl9gI7VRLreLifuC6
	Uem/4Q9fDOfBfQhrgIvupM5qAkUs+vyU=
X-Received: by 2002:a05:651c:1510:b0:387:a08:2775 with SMTP id
 38308e7fff4ca-389a5e07004mr40123091fa.28.1771888637417; Mon, 23 Feb 2026
 15:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223073854.2464232-1-jb.tsai@mediatek.com> <20260223073854.2464232-3-jb.tsai@mediatek.com>
In-Reply-To: <20260223073854.2464232-3-jb.tsai@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 23 Feb 2026 17:17:04 -0600
X-Gmail-Original-Message-ID: <CAGp9LzrOsrotdri+wSLKYTyPNZZkEy2uSRcm+ku75aKB=mWPNw@mail.gmail.com>
X-Gm-Features: AaiRm52cyLR720w3qgjA0NPE5WahHkkNj-g4t5En_hpk8M-dyNyFnLX8XpDugRU
Message-ID: <CAGp9LzrOsrotdri+wSLKYTyPNZZkEy2uSRcm+ku75aKB=mWPNw@mail.gmail.com>
Subject: Re: [PATCH 3/5] wifi: mt76: mt7921: refactor regulatory notifier flow
To: JB Tsai <jb.tsai@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Deren.Wu@mediatek.com, 
	Sean.Wang@mediatek.com, Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, 
	Leon.Yen@mediatek.com, litien.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32131-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6635F17F262
X-Rspamd-Action: no action

Hi, JB

On Mon, Feb 23, 2026 at 1:40=E2=80=AFAM JB Tsai <jb.tsai@mediatek.com> wrot=
e:
>
> Rename mt7921_regd_update() to mt7921_mcu_regd_update() to centralize
> regd updates with error handling.
>
> Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 +-
>  .../net/wireless/mediatek/mt76/mt7921/regd.c  | 45 +++++++++++++------
>  .../net/wireless/mediatek/mt76/mt7921/regd.h  |  3 +-
>  3 files changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index a173a61f2b49..3fdf55c056a6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -545,7 +545,7 @@ static int mt7921_pci_resume(struct device *device)
>         if (err < 0)
>                 goto failed;
>
> -       mt7921_regd_update(dev);
> +       mt7921_mcu_regd_update(dev, mdev->alpha2, dev->country_ie_env);
>         err =3D mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_ON_LED);
>  failed:
>         pm->suspended =3D false;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/regd.c
> index 70440ab8ba82..f795ee2eb446 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
> @@ -72,18 +72,43 @@ mt7921_regd_channel_update(struct wiphy *wiphy, struc=
t mt792x_dev *dev)
>         }
>  }
>
> -void mt7921_regd_update(struct mt792x_dev *dev)
> +int mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
> +                          enum environment_cap country_ie_env)

To keep naming consistent, how about renaming mt7921_mcu_regd_update
to mt7921_regd_mcu_update, matching the mt7921_regd_* prefix?

>  {
>         struct mt76_dev *mdev =3D &dev->mt76;
>         struct ieee80211_hw *hw =3D mdev->hw;
>         struct wiphy *wiphy =3D hw->wiphy;
> +       int ret =3D 0;
> +
> +       dev->regd_in_progress =3D true;
> +
> +       mt792x_mutex_acquire(dev);
> +       if (!dev->regd_change)
> +               goto err;
> +
> +       ret =3D mt7921_mcu_set_clc(dev, alpha2, country_ie_env);
> +       if (ret < 0)
> +               goto err;
>

I=E2=80=99d prefer to keep the refactor logic-preserving. The new error
handling and flag sequencing  the dev->regd_change handling looks like
a functional change, so it would be clearer as a follow-up patch where
the behavior change can be explained. For example, the
dev->regd_change handling could be moved to the =E2=80=9Cwifi: mt76: mt7921=
:
add auto regdomain switch support=E2=80=9D patch so the regd_change flow is
handled end-to-end there.

> -       mt7921_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
>         mt7921_regd_channel_update(wiphy, dev);
> -       mt76_connac_mcu_set_channel_domain(hw->priv);
> -       mt7921_set_tx_sar_pwr(hw, NULL);
> +
> +       ret =3D mt76_connac_mcu_set_channel_domain(hw->priv);
> +       if (ret < 0)
> +               goto err;
> +
> +       ret =3D mt7921_set_tx_sar_pwr(hw, NULL);
> +       if (ret < 0)
> +               goto err;
> +
> +err:
> +       mt792x_mutex_release(dev);
> +       dev->regd_change =3D false;
> +       dev->regd_in_progress =3D false;
> +       wake_up(&dev->wait);
> +
> +       return ret;
>  }
> -EXPORT_SYMBOL_GPL(mt7921_regd_update);
> +EXPORT_SYMBOL_GPL(mt7921_mcu_regd_update);
>
>  void mt7921_regd_notifier(struct wiphy *wiphy,
>                           struct regulatory_request *request)
> @@ -106,12 +131,6 @@ void mt7921_regd_notifier(struct wiphy *wiphy,
>         if (pm->suspended)
>                 return;
>
> -       dev->regd_in_progress =3D true;
> -
> -       mt792x_mutex_acquire(dev);
> -       mt7921_regd_update(dev);
> -       mt792x_mutex_release(dev);
> -
> -       dev->regd_in_progress =3D false;
> -       wake_up(&dev->wait);
> +       mt7921_mcu_regd_update(dev, request->alpha2,
> +                              request->country_ie_env);
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h b/drivers/n=
et/wireless/mediatek/mt76/mt7921/regd.h
> index 74bc2fdd532c..da5bd4450312 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
> @@ -6,7 +6,8 @@
>
>  #include "mt7921.h"
>
> -void mt7921_regd_update(struct mt792x_dev *dev);
> +int mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
> +                          enum environment_cap country_ie_env);
>  void mt7921_regd_notifier(struct wiphy *wiphy,
>                           struct regulatory_request *request);
>  bool mt7921_regd_clc_supported(struct mt792x_dev *dev);
> --
> 2.45.2
>
>

