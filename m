Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BDA41EEF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 10:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404384AbfFLIWH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 04:22:07 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39642 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbfFLIWH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 04:22:07 -0400
Received: by mail-wm1-f44.google.com with SMTP id z23so5524327wma.4
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 01:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1+zB9SSmFh0ZRp+m/jxFT1q7nXRM99Y+CuV6+121TM8=;
        b=HmM0i7VkeXKOfPHuHE9nVl4onl12HsbWDkkgKze5IE9Y+a08aR/4FBZQa+GYPPBM0w
         w1qK6l/xSarlAhYVyAgsb6F3zB0kO3fRNvXrO0KrlmIq9yG/kuyuXtu+Tx32oxAtmW39
         hGLw5IxG42G2P2tOaBXwY5RF0eWz9Wduvg6SIiEiqKf0F5Wthent4w8R/dP6rFajwQ+D
         JVPv6a/X9GKul6n+HMJZixIKLAvxFKglARuwFOduaQp4fB/IdHlBjJXP1RRZLfuO5TR1
         EkOonr4TiogMkvpGEUYQbJd2ppFkFiXvrg/0aKl+NEsxJ5XPOFGbB6uCmHP98ccymTVC
         RVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1+zB9SSmFh0ZRp+m/jxFT1q7nXRM99Y+CuV6+121TM8=;
        b=nERbOXPTHpcAxgJSQrF5HoRPvkkeUzjg9Q+Apnb0t4KXLgQuAUVn1/YKk02CGBk+p4
         9w2VJPcKbvQD1BiZRfrAqXdNADodMsbvTIICOyH/9IPqXlHaXqnODvGkVtMO2Xcbd5oh
         ipDt+sGp4Iko+mqpJ/8uFk+OH56ScUAtY7VJK4K2ZIYRIj5DlhcOYdCTDsp80q/Id3NJ
         TZJhh7v/CO4NIzFrqHFbALq5fls5DY1InCPmzT0Fy/HO+4JsbNqIro4Gvp6MPIpjYLns
         OUVUH5zIC0e9SSvACyiN3+p5yz1BqrFll4Lf6TIYlcPblrBfvSqzK4M1qisR2y9Jq1N0
         sGtg==
X-Gm-Message-State: APjAAAUsCKO4UNizcYrfxYOsJvvhi+TDep2BY107mi3OI0k9FE/eh/up
        HlaAWkEcX8I3gEEbbi+qi68=
X-Google-Smtp-Source: APXvYqy7W1SY8q9hH3R5oo3JnB2WBOien+c/I4BugnXNfG9EM782SPR8iPfHcHpJPy2cT8UAbhLZqg==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr21843227wme.93.1560327724953;
        Wed, 12 Jun 2019 01:22:04 -0700 (PDT)
Received: from [127.0.0.1] ([138.68.75.163])
        by smtp.gmail.com with ESMTPSA id t140sm1628875wmt.0.2019.06.12.01.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 01:22:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RESEND] brcmfmac support for BCM4359 sdio on arm64 ??
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <37d2964d-1c2b-51bd-ac98-2cc171aa0c9c@broadcom.com>
Date:   Wed, 12 Jun 2019 12:22:00 +0400
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <65388464-5328-4BF3-8C9A-7C59E3D361E1@gmail.com>
References: <F5C2858A-498E-4AD3-859D-FA9D14BF6B37@gmail.com>
 <37d2964d-1c2b-51bd-ac98-2cc171aa0c9c@broadcom.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 11 Jun 2019, at 1:45 pm, Arend Van Spriel =
<arend.vanspriel@broadcom.com> wrote:

[snip]

> The splat could be relevant. Maybe try the patch below to get actual =
values that are checked in the WARN_ON.

Hi Arend,

I think the patch got mangled in transit - it wouldn=E2=80=99t compile. =
Can you please resend, perhaps share via a paste site?

Christian

