Return-Path: <linux-wireless+bounces-27195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F35B50925
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 01:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 083294E12F9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 23:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B4926D4C3;
	Tue,  9 Sep 2025 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEind0MD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998EF257858
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460011; cv=none; b=bX8HYY18nL4RM4C8cF15Qx0df710dDs7ld86ymzbWKwTIuuzqavq3Z+3qHYq5ZUvZFNT4wpWZ/RC1VvUQSeLnU5y89Pq4FhdZ9ymR4D11uHuTzqf4IbPkdVS13Byth8qGk+9EZ2x2SWwFQkjnfg09aY8kFGferzqd7b4IWDE0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460011; c=relaxed/simple;
	bh=DUCwg/Yil3WGhQ9dwgdsol7pMjoTgxDoiglFXQNxeGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ap4q+BGu1yAmoMnrZNLoVuEHoPEhYjwEnVqxNSrUgyPvF4k4G+ZkySP+Cj9uewl1QxIsNCes4V8yYyj3pWpt7Gm2VcwKmn0i/CDz8dJobWiq/dO0YbrRDdCEtteFTgHAc+VYR7LZcWlqzyJSqIX0VzpYxo4C1yiOZup703ONhto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEind0MD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so799155e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757460008; x=1758064808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUCwg/Yil3WGhQ9dwgdsol7pMjoTgxDoiglFXQNxeGA=;
        b=cEind0MDdQPq2JEpp/8voeUN7Ryb5gaev5LRONALo0wGe2LlwYrG+Q54wxVBxnRSRk
         J4RhWdXD08Rrn9ycRcAIwttylTy7FTGD3H+oGAiZ6CfvB5eWRtyxrky3w8ZKa4ohqbLY
         edQexUZz//4E+mDjCgqToui2Afsp7EUV1fDf80X6sNeSeipOivwd9DDU2ECijdi481iT
         fzSVJjz0okKJkfUKdwWIC8PwPGSVSzsQsQSA/AxuxKSDgUnmzrbqRkuIYOs4xeHE2ZfZ
         65z/iKCYNJ2hWRPlN4n3ApxkqkUU/d9iK4WhHp7E9vQEysxFlTf0QB7nSwToMgjcf80K
         Zc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460008; x=1758064808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUCwg/Yil3WGhQ9dwgdsol7pMjoTgxDoiglFXQNxeGA=;
        b=d/JuT1505tuwdgZc25GXo2ABnBt6tUnQZnrYL4hhLCIcdfm3S4j3RKotXBTVW2qxi6
         SGKff+WiFKfnukwPbEvnSgdkESqcJ3R0ukw0fH7tJZehh73YwJ30Y0A7ixpHeJiorDot
         Hm5yvOBtbkvuspBfHc5z3ZqGPODzTtVqJ4eaVSJUEMY9eivWT4JbioXc049N6JIrGqUS
         mb05FJet03GsfuZPqvv9+NfXD06Pp/r4SNSKiUxTywhhpMfKxXV+KurRHtXxsodN50Sw
         zW0BUVxfHHUlsOiwj47gJqt3FFSbJDGwxykrirIOShfdmycA8diE47byY3+BoQj0SdZa
         v19w==
X-Gm-Message-State: AOJu0YwLgngvcOkuoKmadaANJXekDoR7Fog02lRKZ+fU+QxRKkaF/sGh
	w8jRPMaFC2ccjCzTXNThf3XIR7qVdoMSrecDLSabxJCNXsj+M6LC9y9zxDZJlPKLoeTRLb0HUmU
	sBdk9THSKALtRmn1BwwqpKghr/tfJeaKdMJx2vxo=
X-Gm-Gg: ASbGncvzNn01fl6K52zOgIHI5hs59bcf9ESNgdCmFf2q2uYSk5KeMjGzGdHr2g0DEP2
	KBCbdx6DKJ/loEHjMfCJbaV+KlwvjmA9XAWrlZNijJgvRBAWw5iRnvSMJBRZ1dSxgBFBJoZzLUT
	Oy4sxDsJ0xIgTr+e2c6TJM3aQfHfQe1BYo2nnCh1/FNsJCAwuULlD573VGNi6krsjqTvK2pqcae
	dmKjBkX7KM+yshNJYdKE6kKcqGME8ZdBWr/yNG+QV7rCibc9pU=
X-Google-Smtp-Source: AGHT+IEur1a5d0wT+eXYzML1QrDSJwGuhIqCgQIyqY2U5khoCQ8fsuPJOJkoTjIAyXn+4QoQuJ5J2fvwXkPZdgrNMqI=
X-Received: by 2002:a05:600c:c0c5:b0:45d:e531:99df with SMTP id
 5b1f17b1804b1-45de64869d9mr66199105e9.3.1757460007513; Tue, 09 Sep 2025
 16:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909135510.757750-1-scaasiffej@gmail.com> <8d5d8339f1dd568f43d97c4ed60817df1838fc13.camel@sipsolutions.net>
In-Reply-To: <8d5d8339f1dd568f43d97c4ed60817df1838fc13.camel@sipsolutions.net>
From: Jeff Isaacs <scaasiffej@gmail.com>
Date: Tue, 9 Sep 2025 19:19:56 -0400
X-Gm-Features: AS18NWDDDMesKVZz2rb9nmoJPPHpKyX9VFD0MXDdgogdEgee25XCbp3sARAe-lk
Message-ID: <CAOYMkPqAt-ETcwL7ZzUUB=0YO-ML+Mh60cB_-8MZj6zcp_-Cxg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: always mark 6 GHz BSS as QoS/EDCA capable
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok yeah I should have included a bit more info to begin with. First, I will
defend my assertion, then I will give more details on the motivation behind
this patch.

802.11ax-2021 =C2=A726.17.2.1 -
"A STA that supports operation in the 6 GHz band sets
dot11HE6GOptionImplemented to true."
"A STA 6G shall not transmit an HT Capabilities element, VHT Capabilities
element, HT Operation element, VHT Operation element, or an HE Operation
element that contains a VHT Operation Information field."
"A STA 6G shall not transmit an HT PPDU."
"A STA 6G shall not transmit a VHT PPDU."

In other words, 6GHz is for HE and EHT operation only. Legacy operation is
not permitted.

802.11ax-2021 =C2=A726.17.1 -
"An HE STA operating in the 6 GHz band is a VHT STA, except that it is
exempt from following VHT and HT functionalities and/or requirements that
are not applicable or that are superseded by equivalent HE functionalities
and/or requirements (see Clause 26 and Clause 27) and except that it shall
use the HE format instead of the VHT, HT_GF, or HT_MF format for PPDUs
transmitted in the 6 GHz band. Additional HE functionalities and/or
requirements for the 6 GHz band are defined in 26.17.2."

Likewise, a VHT STA is an HT STA, and an HT STA is a QoS STA.
In 2.4 / 5 GHz, WiFi is fully backward compatible with legacy standards.
When a beacon frame is captured in the lower spectrum that is missing the
WMM IE, authentication / association can still proceed, but communication
will be limited to non-HT rates.

In 6 GHz, the chain of backwards compatibility is broken. WiFi devices
operating in 6 GHz must at minimum support HE. And all HE STA must
support WMM/QoS.

So the current logic in mac80211 to downgrade to legacy in absence of
the WMM IE is flawed when the beacon is captured on 6 GHz, because
any STA operating in 6 GHz must be at least implement HE and all of its
required features.

One more supporting item from the spec.

802.11-2020 =C2=A710.2.3.2 -
"The QoS AP shall announce the EDCA parameters in selected Beacon
frames and in all Probe Response and (Re)Association Response frames
by the inclusion of the EDCA Parameter Set element using the information
from the MIB entries in dot11EDCATable. If no such element has been
received (e.g., prior to association in an infrastructure BSS), a non-AP
QoS STA shall use the default values for the parameters."

So it is explicitly stated that it is possible that a beacon frame can be
received from a QoS AP without the EDCA parameters included. And
since a non-AP STA cannot initiate a probe request with a wildcard for
the SSID in 6 GHz, it has no choice but to use the default parameter
values outlined in the spec until the QoS AP instructs otherwise.

Now for my motivation for introducing this patch. I have observed that the
WMM element is not present in beacon frames in the 6 GHz spectrum on
the Ruckus R770 when multiple BSSs are packed together using the
MBSSID feature. The WMM IE is included in the top-level profile, but not
in the non-Tx profiles defined within the MBSSID element. I am in contact
with support, but the initial response I got from Ruckus is that this is
intentional.

And well it makes sense I guess. If the spec defines default values, and
the whole point behind MBSSID is to save airtime for data transmission,
then why repeat the same unchanged default QoS values for every BSS.
I also figured that they had to go through a lot to get the WiFi 7
certification. If this is truly an error, I would be surprised if I'm
the first to
notice it, given that the R770 shipped out beginning in 2023 :)

So I dug through the spec, and ended up with this chain of reasoning for
why the WMM IE is not required in 6 GHz.

Jeff

On Tue, Sep 9, 2025 at 9:57=E2=80=AFAM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Tue, 2025-09-09 at 09:55 -0400, Jeff Isaacs wrote:
> > In 6 GHz, QoS/EDCA operation is mandatory as per IEEE 802.11ax/802.11be=
.
> > APs are not required to include a WMM Information or WMM Parameter
> > element in Beacon or Probe Response frames, unlike in 2.4/5 GHz.
> > Instead, stations must assume that QoS is always enabled and use EDCA
> > (default EDCA parameters apply if no explicit EDCA Parameter Set is
> > present).
>
> What? You really need to back up that assertion.
>
> johannes

