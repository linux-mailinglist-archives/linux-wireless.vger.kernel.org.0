Return-Path: <linux-wireless+bounces-21370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C701A838B7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 07:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6C58A658D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 05:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24775201269;
	Thu, 10 Apr 2025 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eu8ExL0Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3F1C3BEB;
	Thu, 10 Apr 2025 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744264469; cv=none; b=bPM5LgLrr2sPhl+dInGZcaAKjGjUGnnY++hPVmCD7uqtr7uHR1HLYOKRtAHes9UgKQuQMxLinl2QBABFaPywYXtJi35yFbWTeESdlFEoUpM+3uVWPeMAM8odCdlBsg3kVoohmxnLxMMUAqXPRlGuMIvxpVx/4Cq5fmnV8Dj8/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744264469; c=relaxed/simple;
	bh=+zk/vb7LqJygYMh9o3BBarazok//uVQvYWo+lFHVCYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUz5wik8lv8y1CqYvs8gAqY0RktMt0j5OuSbTi5Cosmqcd/GwWCpqgzaLr+0CN7IEOlqxS3uLxXKCq7H3fR9qeWkgmjYCdlMvGng9XmvEC/BSJla9wp+Dc0Y2mfmIm7s58qyWAQf7/08N+Kg94eeyqfpFMmFjkaJA/Nk9AQGmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eu8ExL0Y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22435603572so3622535ad.1;
        Wed, 09 Apr 2025 22:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744264467; x=1744869267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=463n+8Z8m1ousZcKBeIZRKu3SnJdxQ83ReQHqAlLzl0=;
        b=eu8ExL0YoB1pPs6MwXooJChGvQovU1/u0Nhn7pTwEgfebMEwlWnPkd2knVEolAx9yL
         Le3aV2oTxkpgiHThGMCcA0IKeUZBRsLAyIW86/l0UDCiBlwsyfHVb4bb5xHw2HtvoiFt
         zLKxPdgdLmHBzd17UKhb+U2n01rXRa6RuXxGdk9mAze4OiLfPBMaZB2/9fDZX3K3G7lg
         03koSIBWd38emBojfbijwC+8HzyWlR/QLkVddPO6J8u/eTq2utWtdixq1+vQnJpU3F5+
         RAldNINynK+pUiLvJTfZMrUqSC5JlRRHwwaiCzq7qrnvUOfojT7hWreSlKr7xdkSJJE4
         VoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744264467; x=1744869267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=463n+8Z8m1ousZcKBeIZRKu3SnJdxQ83ReQHqAlLzl0=;
        b=f8PU0f6omdeZWAddyQg64TqrEqR9ufUxcHBotXAhMnpsJWe1SB92BQnt9oRdgw70Tt
         91IdUfPR8CEs6AYWT6CmWc2M6irQ6pZQORLx/tbi9NdgG22wnBUP0WVwB59V5NVhDBdh
         +I6WSdVVkF7GGaOORTmk3PMij8ncBlb5nW/bO7nzGtKMxS2Ud1jjjDDVRcQihe1iHYye
         t8Kh9HOZGNpmlzABAKGUXnQXmXxVx7O4cEqc9cJt7zgFA6lvbJwG34uDOuum8AHcyAdS
         Gxgmkfn96wVZjLScaqWEb/vdbfqecVO9Oa2XZKzZKPGmuR8kzs1OBlZsxf1jrOhAzYGm
         WlJg==
X-Forwarded-Encrypted: i=1; AJvYcCW6L03GtS8Kd/oCnZzX4995udnufP7gEHxMTybCEXmuspndRtnrO0TTqLrZBzFv2Nztyj6cBsp4PkW8pc1LwCc=@vger.kernel.org, AJvYcCXGhdI+yC2v7NGZqjxOSbFW7fRDQekCpudmjlUQLt8Gxi55xQYe13O4OmBSoFvu1hjfQFWk0i6N8KsFG3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0IvoIx2Y2++d63dUuXHURF5Xz5MDP6myV7PDmP6aBKhaSHDy
	8iwJGJmPao1SL3PqdCF8GRshQJUCbPQ4zxv+gXfK03ol3CE1SfydhBg2GkFiSs8tXYzObbwKQBz
	KdSQD1VkOzRAYVc3zpBVHk5yRvuPcwnzH
X-Gm-Gg: ASbGncuaV3eyj71ZIzLxEhZsUKSOXm3vOcqfz0VEtv9+1W0M2OOdbJ7RJH6Pbw5fzlf
	xwDOjfuT6DRH/rTnJCf7mUTVhOUebiYxuzWW89aQqZP0kAF3kOpWNTF+4qjCZycHQ3dI8PEvBpu
	Yp0JkiIk649Nh1s4UudI363OVDjLPbkpL8tWls
X-Google-Smtp-Source: AGHT+IFz5R80eJG2xRRtf6JVZ1SAcmTrdICbksOxDM6RYcWBikj/w3atr987io4Ta2xNWtYfowJvMisdGslfq6yWiHM=
X-Received: by 2002:a17:902:cf0f:b0:224:216e:3342 with SMTP id
 d9443c01a7336-22be03cf8c8mr17462865ad.43.1744264466668; Wed, 09 Apr 2025
 22:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409034910.1637422-1-zhen.xin@nokia-sbell.com> <7f96b6ee57b44626996b70da969219b5@realtek.com>
In-Reply-To: <7f96b6ee57b44626996b70da969219b5@realtek.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 10 Apr 2025 07:54:15 +0200
X-Gm-Features: ATxdqUF-j9p3a3o9yCH1r6BBhIJKDDq-IFpmbriY0EITpZNDEWtnxLRyUBRSDhc
Message-ID: <CAFBinCBHqwhtSAqE8xCoxsgRgHZ1n-zGC6wXo+emAaX6BBkR1A@mail.gmail.com>
Subject: Re: [RFC -v2] wifi: rtw88: sdio: Tx status for management frames
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zhen XIN <zhen.xin@nokia-sbell.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ping-Ke,

On Thu, Apr 10, 2025 at 6:30=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
[...]
> > @@ -718,10 +718,7 @@ static u8 rtw_sdio_get_tx_qsel(struct rtw_dev *rtw=
dev, struct sk_buff *skb,
> >         case RTW_TX_QUEUE_H2C:
> >                 return TX_DESC_QSEL_H2C;
> >         case RTW_TX_QUEUE_MGMT:
> > -               if (rtw_chip_wcpu_11n(rtwdev))
> > -                       return TX_DESC_QSEL_HIGH;
> > -               else
> > -                       return TX_DESC_QSEL_MGMT;
> > +               return TX_DESC_QSEL_MGMT;
>
> Do you remember why you did the special deal with 11n chips?
> And this RFC looks good to me. (except to commit message, but this is RFC=
)
I don't remember - and Jernej said the same thing.
However, since we got the first 802.11n hardware for testing long
after this part was written my suggestion is: let's roll this into a
proper patch, Cc Fiona Klute <fiona.klute@gmx.de> (author of RTL8723CS
support) on the resulting patch(es) and then apply the patches
(assuming nobody observes any problems).

To make this a non-RFC patch the following steps are needed (in my opinion)=
:
- split the change into two patches (one which unconditionally calls
rtw_sdio_indicate_tx_status())
- another one for the TX_DESC_QSEL_MGMT mapping
- each of the patches should include their own description
- I checked the history and it seems that both problems were
introduced with the original commit, meaning both patches should get
the following line (above the Signed-off-by): Fixes: 65371a3f14e7
("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
- (plus anything Ping-Ke has to add :-) )


Best regards,
Martin

