Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF4139F0E5
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 10:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhFHI2p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 04:28:45 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:41736 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhFHI2o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 04:28:44 -0400
Received: by mail-pf1-f175.google.com with SMTP id x73so15153873pfc.8
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jun 2021 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00PfNRcZcqMBfYq8HarCC1wcOInvFG5JKiJ94/fmwE4=;
        b=khshN8CeOIcR9fydB9VBOieeel753hRUU5Z1lxzC65HJwwqUCzOSCeEw/MP7xanU0c
         Rex/PGIE+Opf52At/T/L11iFMU4NZ8cv/OsL5RNhVe0v+5VYjowkjVJvQdCsM4XzdWSQ
         5S08lmKrfGRWeV2JsBDJtlYW5P34WHWpJrOrUvsHy9TH1dtU6lgWq2ZNajiHFiW6+EQ9
         U3Llp+ECgx/Qhdg+v8JQzD/UrPiVpueUFuKQn6EAjvxaoV3B+jVZH72qbwiXxfVJgz08
         /yhj8Vn8mWu9NE417tspWHN1iluQayEVikUhbcdHhM+1p0yPpTz5qZuiXvD7Y8Q59KO1
         jSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00PfNRcZcqMBfYq8HarCC1wcOInvFG5JKiJ94/fmwE4=;
        b=pDV31BNqro1a+ZX5I5x7BU5QCoVjlPWmjMpQHdJfz9mIrTClpOVmG2Gvk+zftdD6fs
         oPDzNHAqkid6E7S7F3x+zyKyvJmML0kg8DkKQ9WT7QrLgUYbNEWQ70cj1rVHiKbqK80c
         pLegwVeMPmGTd2iyRt6VwyoWYG4tTToc1OVClb0AyIDBHJj+KuLKI3jDu4ReTWbRJY+9
         KgMH/4ruJeGoTzHU+hMAnMm15kStRZ5wYezC94qAjCFflX1ib/V9PTezOfof7OsjR3vo
         KOnVdquGGA7TCM+FLZjADlLAO4+2QVB2RbP3bBw+zRf0KhNy/M1mSHNn+sOzEVX3Ge2z
         QF3g==
X-Gm-Message-State: AOAM532eedibdrKRfBV4wxIgdQCnqAockKmdV3vJ+C1VsQ6Nl0UeGwiR
        AVpwUg+Kr+t4vaNCIt4ZR7/W7VYTZeqvwZ6wHLqZsA==
X-Google-Smtp-Source: ABdhPJwrN6I54ad7/gEccK2yJkwCbDOypZowDEBHw7TqVb8ydJoZjeDKK/L0RP4RGL5oDnwgCS9FZCR67Gm2/unxOXc=
X-Received: by 2002:a63:1906:: with SMTP id z6mr21306328pgl.173.1623140752278;
 Tue, 08 Jun 2021 01:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210608040241.10658-1-ryazanov.s.a@gmail.com> <20210608040241.10658-4-ryazanov.s.a@gmail.com>
In-Reply-To: <20210608040241.10658-4-ryazanov.s.a@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 8 Jun 2021 10:35:02 +0200
Message-ID: <CAMZdPi9y=LXp0XVFR_+Wfnxt83tXfMcdR9MjQkcaXpZb7=Le5w@mail.gmail.com>
Subject: Re: [PATCH 03/10] net: wwan: make WWAN_PORT_MAX meaning less surprised
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 8 Jun 2021 at 06:02, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>
> It is quite unusual when some value can not be equal to a defined range
> max value. Also most subsystems defines FOO_TYPE_MAX as a maximum valid
> value. So turn the WAN_PORT_MAX meaning from the number of supported
> port types to the maximum valid port type.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
