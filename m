Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF086AF9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 21:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390261AbfHHT6O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Aug 2019 15:58:14 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:35408 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbfHHT6O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Aug 2019 15:58:14 -0400
Received: by mail-pf1-f170.google.com with SMTP id u14so44706714pfn.2
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2019 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dm5zx5TLTIy9C+xLEJSP6nCb7Vxzhj9HfOZyoQg34tw=;
        b=H7/QBOsZU/ZM67oGOenanIrFcHzWmMbSSUI5pcls/uNnuYJHJYnenu5LG0dTOEO3aP
         wyXCN1MgZ9G65KJyHQ5L84IX6WkLFTfQCHD5lPe2LigpMUsB4HfhXrqQVwVbC856zYsf
         LHZWbh8hBO9fgNRb+56asT03OzhJTS+b77V8S8+/UqTkK/QQgdaoYmDTMM1NZXoSKdUJ
         N3TrtNokt/446KQlQUGo6l9UHGTNbqxXqHoXeGN0b7Jsd8fPfhQnk4tpIA32lSFUOhxd
         +6zO7m9Bsbom9hOL2Un6VSMSY4/ndLYJ427i6I0Q8BV11uknMnHqoaJyVreGtbdqXbD/
         V/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=dm5zx5TLTIy9C+xLEJSP6nCb7Vxzhj9HfOZyoQg34tw=;
        b=nWVI+xwKvWarENhuaE/6R9Gc7Dcc8fpVpHLw/hVHo9XMdskOLE5RxG5cS8indaF3JI
         PSLHjgjfH2pv3P60VrbIU071K57gtdrGSX+XXuXnTIoNMVodyWi6QITuqbGuTuZZwlsZ
         TwoX+Q0eB/uKDYcW1c62YaUCgi9Jb2ACMfEDoZdaGYj0wj3Iz6iOdIodWgjMDAWKRAfh
         Du8McCQDZBqHNP7ThzXb4Mq8q97XhHmF+QJybV/uCDGysX5S80QyxrAnvJJZXFkAT+7n
         LpRYDWxKf4FH7wQyVRN5Vtj2CyMf/iCxgmwl70aCkSwnimykVm0TQYUPu4D6nB2wZpez
         6ArA==
X-Gm-Message-State: APjAAAXe8n+QO5iaEIstQkZ5gY6z6ABg3HkDWoLpyIwq88FBPQN9DwHQ
        WLln3bwX0sICczMkreko6x136wSOwwThfwQhCGz4lqr4pj0=
X-Google-Smtp-Source: APXvYqw6JQH0BPlLeCI0DSVSeETSbVLTDZ2Kk70hA+ngUzi2R4VCgUfH/cvxUwG9lwMZ3rVcx42CPgGZJMlYD6YhEBI=
X-Received: by 2002:a62:483:: with SMTP id 125mr17773104pfe.245.1565294293475;
 Thu, 08 Aug 2019 12:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAG6aBkWDyGDtWX7X0t-FjynkYxpdhpZsAv4Ysw3dKf+iEu+mig@mail.gmail.com>
 CAG6aBkWDyGDtWX7X0t-FjynkYxpdhpZsAv4Ysw3dKf+iEu+mig@mail.gmail.com <5d4c34ea.1c69fb81.a7a36.5f7f.GMR@mx.google.com>
In-Reply-To: <5d4c34ea.1c69fb81.a7a36.5f7f.GMR@mx.google.com>
From:   Nigel Sollars <nsollars@gmail.com>
Date:   Thu, 8 Aug 2019 15:58:03 -0400
Message-ID: <CAG6aBkXG50t-KgkLPpkGjcF313hJiic6k1sqOVDCbWN3zPAsGg@mail.gmail.com>
Subject: Fwd: Delivery Status Notification (Failure)
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

So I have been trying to reach out in aim to get this driver fixed as
its regressed now to a total non working state.

The card can see access points, but thats about as good as it gets as
trying to connect to any networks ( either 2.4 ot 5 Ghz ) results in
the following,

  wlp3s0: CTRL-EVENT-SCAN-FAILED ret=3D-22 retry=3D1

( alot of these ) which then resets connection status with a failed timeout=
.

I am currently running FedoraCore 30 with the 5.2.5-200 kernel updated
from 5.1.x yesterday. The firmware loaded is,

loaded firmware version 9.221.4.1 build 25532 op_mode iwldvm

Now with all that said, using a Linux Mint live boot from a usb device
yeilds the card working fine at both 2.4 and 5ghz speeds, it connects
within seconds. The kernal in this live boot is 4.15.x and uses the
same firmware build as my FC install.

I did see strange behavior with this card from around 4.18 to 20,
thinking the card might have developed a fault and obtained a new one.
This proved that this was not the case as I get the exact same
behavior from both cards.

Hope this information is helpful to solve quickly, please reach out
for more information if required

Thanks
Nige

--=20
=E2=80=9CScience is a differential equation. Religion is a boundary conditi=
on.=E2=80=9D

                           Alan Turing
