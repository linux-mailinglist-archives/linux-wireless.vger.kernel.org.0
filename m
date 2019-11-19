Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C73102906
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfKSQMg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 11:12:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39696 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfKSQMg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 11:12:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id l7so24534814wrp.6
        for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2019 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DSGIFE0ujniakGQvFQIVw/X3ubRy0aNj1a2BA5/1wk=;
        b=XE5w0LhmIXsobMZiaQwTpmv09VVlKigNPVHIcUl+cnWeNb8d+w6v7e1hobF7sk35XT
         23qGMJJByxaDk3dVpsMDAEpMDpFRmcpmZjXNeq1f1xamCXhI6B+maQmYt18FxlZtBSvU
         sbVUFVOg9yqP6tocYUP3e7Ub8uGjzplqltoW/l/HYvxwtbIVTrGgN6ENSKWZkbFEDhWy
         b4b6MvydLWeojLz70cmzFv2C7s6Lx83tZsmOXHtwtqhgCjFTK/l8DoenpnQyQ8kXlRcL
         O91tVTwzE/zFNTpwk+eF9HuCSx2sYMcu41Hb33DJmSgu3aMZHPX4VF/fJmv3B6Mrj107
         vnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DSGIFE0ujniakGQvFQIVw/X3ubRy0aNj1a2BA5/1wk=;
        b=lj+t3TCOHIeHUZ3u+7YFsgtYSFQq/wAvy7oTZQmZU4rKQDIKzxZddjleypaTmJSJ2X
         RcnAxzmldoPjtkMtQwkbdPnttTDN3jgiHiSe95hSTNYP+xK5RxyAZQd9Oy3vTj/4M2gU
         6OpGnVi52Mqc++c7NCm8QVE92mxA1q0SR+uyJGE1IoDSdLkD6xw0qSKFkHccjgCpmJ5t
         YjmICkK0+I01MsmK9Kw1DApo4wy4rGTOhhHnOjwBLLs3VbYUuoXzr57Gq3bb9fgdP4id
         7hA5Nl+VRtR1dojj4FwbUKMN/jaQ9j/Mql5jofZ4LURM9vZ7LQtscHYpnYF19eWqqIz7
         UwzQ==
X-Gm-Message-State: APjAAAVRENVuOnhQk7ckKz+SxQABKgJCGMlhve05g1o+bfdgpIig9+23
        luLYaItl4zb6+/97a7KG1aBdIaeAhto1n/Rb0FOJnw==
X-Google-Smtp-Source: APXvYqz0CQ12QwOXXJzZzcB1xKrdL8OlBS8QrQEeG8BPNfG9xJucYKvQqLhBI6ma74rQjlcJQQ78wmXGmC9QVej3Kbg=
X-Received: by 2002:adf:ea92:: with SMTP id s18mr23199690wrm.327.1574179954623;
 Tue, 19 Nov 2019 08:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20181016102349.26544-1-sergey.matyukevich.os@quantenna.com>
 <20181016102349.26544-3-sergey.matyukevich.os@quantenna.com>
 <CAOiHx=nBWr4GNh61WV+SAY-++Z6es-HX3_pd70DB_N33bVK1tw@mail.gmail.com> <41b4f41f-37ae-ef5f-476c-eb616d6a3da1@quantenna.com>
In-Reply-To: <41b4f41f-37ae-ef5f-476c-eb616d6a3da1@quantenna.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 19 Nov 2019 17:12:14 +0100
Message-ID: <CAOiHx=myYOAYPm0KwS3wP+sPLaQH9obUv0wbdteCx6REJPKQgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] qtnfmac: add support for Topaz chipsets
To:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Cc:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Andrey Shevchenko <ashevchenko@quantenna.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Igor,

On Thu, 23 May 2019 at 21:39, Igor Mitsyanko
<igor.mitsyanko.os@quantenna.com> wrote:
>
>
> >
> > A bit late of a review/question, but how does one obtain one of these
> > files? There's nothing in linux-firmware, and I see only one aborted
> > attempt for adding fmac_qsr10g.img from 2016, but none for the others.
> > Searching for these filenames also didn't reveal any external
> > locations.
> >
> >
> > Regards
> > Jonas
> >
>
> Hi Jonas, we're working towards a second attempt to get those accepted
> to linux-firmware (fmac_qsr1000.img binary first) admittedly it takes us
> a long time to do that. The main obstacle for us as developers is that
> the binary contains 3-d party GPL code so we have to work with other
> departments to satisfy all submission requirements (provide sources,
> proper licensing/attribution etc). From a failed fmac_qsr10g.img attempt
> it was clear that simply providing an contact email is not enough.
>
> We're planning a second attempt to submit firmware binary patch
> relatively soon, for now we expect device will boot from flash.

Any update on this? The support now had its first anniversary, and
still no firmware available for it.

Maybe you could put it up in a (temporary) download location at
Quantenna until you get around to the second attempt?


Regards
Jonas
