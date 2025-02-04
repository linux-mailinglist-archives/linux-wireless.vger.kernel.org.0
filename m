Return-Path: <linux-wireless+bounces-18471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922E9A27C4F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 20:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F9A1886332
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99A2158558;
	Tue,  4 Feb 2025 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="0frWUCgt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24C205E0A
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699178; cv=none; b=FC1iKpVW0GYGn4bJ+qhNyRZ6YSgos5FvD1BGflXPldZnoA5TDE3VLaKqJUx066b0bbVuUUi0zs/K8G12goUTPU7GxMWh6iZKykM5p3o+Po8nAbiGctHck4OV0sQXpYbFIk2WjjXbb3TAbosrK4zrThAEiQs7CR3i8QJXFE8MXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699178; c=relaxed/simple;
	bh=6AkxMhcyx/M33sKxSS2CQ9S+OcThgcIiXeGJNW2nyeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Acw6AaDS5ufjN5oO+3KS4wOxaqPRjzBoB54TsPWUSJqTRG5GqEEVSs0I9EIContnAnXoBrz3TAibUHo795f1ZKrwriDVZogp8x+u0wLKwFV8HW8N8knkTjepCcIu0TqNCHDnaaNO6dssZkzVN3Qym4B4knJG8IxRDr2msa1LdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=0frWUCgt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401c52000fso5760193e87.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 11:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1738699173; x=1739303973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56xY2nv2mj5z5oXzPhzA55OjzYbKlg1gKzjHUfLi2kc=;
        b=0frWUCgtF9ns9YxIOG8obzGGUtKlPus3OEtGRfPzc+tG/WIeIBUSqyvG1Xx3ymN++9
         pHU/WLC+hB9cllAx53S70+6twpE3CfIUG71agfCgVOVTZ3x8zVq+9KWaG4UEtnIiKylJ
         kTr2/83BT3rayIvREFBtLhB5waWJMYDntCtyBO9iwOMtG8KQ5AscZvslrN1wZnlzRAPK
         yWF3uWQJaV1qEjh+5NF9Nl025A3V2VCh1eTXawjPpd2a29X33GJ4DysX1wYkRSq2p2mL
         iMQAltPf6Q8+yTy1OJYynyc+6p4xINSy32ELWwVx6d8dahYOMgdTkdH1q2DWV4j1HB4f
         ixTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738699173; x=1739303973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56xY2nv2mj5z5oXzPhzA55OjzYbKlg1gKzjHUfLi2kc=;
        b=k4uzBBWmPyqpz61jSK+UHFhtHZQZTPawLUOqt55T72rB83LLTfzSA8rXdk1XA4WOTX
         AebH2vNj9L+msHQFPU/RlfBhSePCBJbFBR5h235U+ZGinTiE5AEJmg2cCY0HCsazfb5x
         RqT4lBkZH+ElQi+KKufGqL8NJfh1nUAQGE5Hlztra4vw0AsLS9CGOJ6dv4SbtFalII0Y
         xuovRhKBF3Yuay/XADZwESZh6b8TV03rOA7iZxbPlXufE4H6ZIA6V13CKeWieThOV3N5
         AknVl3t5ynNyXwJ8v468VyBEIw0mewRCm5WYfWYmNAvnJjtWfy57hTxw3ENXuHbz4hHe
         NWkg==
X-Forwarded-Encrypted: i=1; AJvYcCWus5anBh4Wcd5+IDayx74+lYXU9f6dOi4V+iOrhVZheDPytFm+yW8usZ40AUjI2Btvir3mxhHpYGjOJ15ttA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJGU5M6aH6AFp6mtVXlmuJES/l0r312WlOqknSXaXGK0twLcTk
	/OtTNcGNcumtPkffs+rxzrtwACp0c0IOp0J8WcZep/sOxXW9xkbdDHCMoSooJHzgkejZ0Rseu39
	PIONPhcTcEtSNMGPwKFTQuXmiUZaZtM0R0n0SQA==
X-Gm-Gg: ASbGncvzT+ZZp2SAtv3gX8LMKTLTWBvj+/H9xHsyHwoJLn3ZTKI9UFCkQ2YQp6MJNZF
	aezDPK9mfniWchMZO/kTVPDXeASYbE9/66tWLYgGL/D4X9o8vkesvHKIsEAarynrdxae/b2ykbA
	==
X-Google-Smtp-Source: AGHT+IH4c5rQfaATU5TOrcfnPOafpBo3K++dxM6gG9dCO+3jFfqX06cRBtOwLK7zTdaPrKM9oHe0IGnmM5301ipMEPU=
X-Received: by 2002:a05:6512:3195:b0:542:2a8b:d577 with SMTP id
 2adb3069b0e04-54405a0c528mr24487e87.8.1738699172911; Tue, 04 Feb 2025
 11:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122071512.10165-1-ezra@easyb.ch> <393aa422-3ac8-40e7-aa2f-62956a844005@RTEXMBS04.realtek.com.tw>
 <19b8059a-c5f6-4467-8b42-31e70b9fe1f3@linutronix.de> <93fe56295aba4bf0bc1af603bd992f47@realtek.com>
In-Reply-To: <93fe56295aba4bf0bc1af603bd992f47@realtek.com>
From: Ezra Buehler <ezra@easyb.ch>
Date: Tue, 4 Feb 2025 20:59:22 +0100
X-Gm-Features: AWEUYZmEzRAjkOah7OQbosEi-bZYGRBjVkzzLahEn4Bh8gG3FoMKoL2taG3TKtY
Message-ID: <CAM1KZSkPNQ=6VzuoiF7qALq=UVjoT_SF2YgO5oRwuraQACqeQA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Martin Kaistra <martin.kaistra@linutronix.de>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Jes Sorensen <Jes.Sorensen@gmail.com>, 
	Kalle Valo <kvalo@kernel.org>, Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	Johannes Berg <johannes.berg@intel.com>, 
	Reto Schneider <reto.schneider@husqvarnagroup.com>, 
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:51=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Martin Kaistra <martin.kaistra@linutronix.de> wrote:
> >
> > Is there a reason for not setting macid in rtl8xxxu_fill_txdesc_v1() an=
d
> > rtl8xxxu_update_rate_mask() like it was done for the gen2 case?
>
> rtl8xxxu_fill_txdesc_v3() doesn't fill macid neither. Quickly search for
> the code filling tx desc [1]. I think we can have a
>    #define TXDESC32_MACID_MASK GENMASK(4, 0)
>
> The h2c command format of rtl8xxxu_update_rate_mask() seemingly should be
> equal to rtl8192c_set_raid_cmd() [2], but not.
>
> Can anyone help to spin patches and test if it works?

The suggested changes seem to help. A quick test shows TX rates of
around 20 Mbits/sec. I will prepare the patches soon.

>
> [1] https://github.com/lwfinger/rtl8192cu/blob/master/hal/rtl8192cu_xmit.=
c#L257
> [2] https://github.com/lwfinger/rtl8192cu/blob/master/hal/rtl8192c_cmd.c#=
L201
>

I've also noticed that the TX rate is not reported correctly. "iw
station dump" shows "tx bitrate: (unknown)" and "hostapd_cli all_sta"
displays "tx_rate_info=3D0".

Any ideas why that could be?

Cheers,
Ezra.

