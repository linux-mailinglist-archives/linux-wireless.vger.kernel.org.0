Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BD8172E53
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2020 02:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgB1B1d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 20:27:33 -0500
Received: from mail-qv1-f45.google.com ([209.85.219.45]:38036 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbgB1B1d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 20:27:33 -0500
Received: by mail-qv1-f45.google.com with SMTP id g16so626351qvz.5
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2020 17:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OSZaxH/jK6+7ruzHdbEzJvwKD67ZrXy/AmwBYeAbs/s=;
        b=j7h1KNHy3zReo8lYOIzJD8wk2LVF+9wz0CqMUI3vpo4Jc/b+d671H9bwmeXE716oek
         vQMFb8rkFwayw7xyx+Dri6yrOH54D56JDo4AltOR+AUGmTmiHdJs15ZQs0IahI6uSRa2
         kM1U0zlXZQ7RpAOO/J0JOSrcl6PAikveKIddcKBrUJ5O9dgTFKDckM428DE6ZVPNVEV/
         WnujFqz7HqF/bF5p3/t4SIj1NsT5sai4AvbT26FMIOqvGUdBoYH3CGF4aRuJbwBsby6R
         7XXBvXaiXM1h4lgw1TsUmHIdJqXtkAyKOgJzNxNAwRC6pCzWCGcQCTD2taiy5Wn7FRtN
         Gg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSZaxH/jK6+7ruzHdbEzJvwKD67ZrXy/AmwBYeAbs/s=;
        b=I08aqLrt/FK4y7iVu3fQGcZQxc3cO5zGsUg1DAfF1nzXUvGwQHHRFzTlKs8mOtLAn0
         +10puQC77x18qmBFFpFatbGH1pU7uTVPGq0a6j1KJkMVxejX7ctCKVgN8JzzLn7hYWfb
         0KEXN8tBa36ekUFoPz4a4pXH5Z6Zj4fHV46/2FeOV+qmEtzUuJxy84RLcAhfjcHkpAGM
         GLzX65zuS5fRGuVlBK0Gi/I9F1LYRL/r6YIA0TAWG6KCqozL7gxXp6S9Ur/ok9lpxuDG
         PTpbIaiJztzEW2GG6Gn+Z/eWl1XUzEugqzWp4DPFo0q6svfNWh2+aUBNyeHXAVxeAAR8
         L2fQ==
X-Gm-Message-State: APjAAAVnjqGrmeZEpnuHBQrck6e1iJhgPiV6gfRoD4CzTuzKbmkPoiob
        MJAtyjZvYPBNS4z0KKp2UvQR7TNvLTyJeZ6SlP3i9Sx+3x4=
X-Google-Smtp-Source: APXvYqxM9SHhCn27SdU2ww5pzLaDB6BzG7anF11iARjJT//UMdlVvK3nzcUDlpn9ol+GZQbUbfp640m856tIVivLCHU=
X-Received: by 2002:a0c:fca2:: with SMTP id h2mr1864598qvq.146.1582853252364;
 Thu, 27 Feb 2020 17:27:32 -0800 (PST)
MIME-Version: 1.0
References: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
 <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
 <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
In-Reply-To: <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
From:   Steve deRosier <derosier@gmail.com>
Date:   Thu, 27 Feb 2020 17:26:49 -0800
Message-ID: <CALLGbRJYAfa=5t46UTj8GT6yhMVUZkCeD6pqF+XVhLSdmoJ5wg@mail.gmail.com>
Subject: Re: [mac80211]: wds link and Radius authentication issue
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 27, 2020 at 9:37 AM Cedric VONCKEN <cedric.voncken@acksys.fr> wrote:
>
> Where can I found some information on how the wds system should work? I looked in 802.11-2012 standard and I didn't found any informations.
>

I think Wikipedia says it best:
"WDS may be incompatible between different products (even occasionally
from the same vendor) since the IEEE 802.11-1999 standard does not
define how to construct any such implementations or how stations
interact to arrange for exchanging frames of this format. The IEEE
802.11-1999 standard merely defines the 4-address frame format that
makes it possible."

I wish you luck.

- Steve
