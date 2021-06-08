Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2C039F0F2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 10:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFHIbi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 04:31:38 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:33537 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhFHIbi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 04:31:38 -0400
Received: by mail-pf1-f171.google.com with SMTP id p13so5592464pfw.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jun 2021 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jj5f2gvIADDwGqqk4CkC+CrbL7NcUmlIgcNJ3sTAYeo=;
        b=h++7QPspdw/hwT1HeBu2IdcNSoGyuy4Idv/7x64CB1g4ArZkMFXjTXQWEkhkC2s6yP
         PsX+w/FfPfAYm7/xcf32v4/XA/gCTuqr/Q0ln6p4G6/35abHAFHeXcIxwIgpov8lc3+o
         in8hfmaKOJ/BlO8iVZA7W8VWxwpDHHEDblSsUumFhl19yA0ox9d0VJsSRtcLRBO5OFlz
         kAJ5r/TBcRX/UH/pWP3IaVhuB/B3UkNj24gPxbW4MQKUbe27pJy1LlEDPCYP2U5xnGTC
         PhwEovJJcwNo59lCfF5a6WQCsVJdKmxxlp3CXGk0lGDNoVsIJJ6F8qHsO68GqwYK3Frl
         pcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jj5f2gvIADDwGqqk4CkC+CrbL7NcUmlIgcNJ3sTAYeo=;
        b=RYhkU6blrBMFkiMWhsM+r26m/pGNgvt39Wcs3tjusvG/RhsXTsASjjyHkJYjNw2r2x
         R9tvJsH5H8pbNz8muDOvkrg7zuWNtjVI+xYQyazaeV3NnXhB+7LqoTgo+9NfFw3HS77P
         TNGrGhRA/6X9PrcAzm68MMg6H32rXy5VhpmwE5my1p9gQiaH9EMDTXxnzZ2el7YuK8m1
         +PY2u3zoVls6MuawqqzJSBLBs/2CR3jfVRYwFB3jNXKSnAbJ+piOv1IvbP3E2rMEsMR1
         V8JT4KnaNwuQEgMD4sP31wqU34gO/Mn4yR9hLbSiGK6z5RRC0Uxe+FkfDox51n1WI1VH
         GEYg==
X-Gm-Message-State: AOAM531nU5QmoPSXhRWh3NmmHQHdEJk6tJ2B8sZUOjP8vqTnWKPDQgp5
        BRqnYUQUL/T3ACpm5U9tYStaAORXBha2grlCS8o5qg==
X-Google-Smtp-Source: ABdhPJwsp1BOBs+GjpkaTFZMN4u6Pzc1LPJ40KRWbKMgoK4uC3/m0j/wGzPT9KDUgDcXtDJKLHrk5+WuPU2I3NFZ2Dk=
X-Received: by 2002:a62:d447:0:b029:291:19f7:ddcd with SMTP id
 u7-20020a62d4470000b029029119f7ddcdmr21182371pfl.54.1623140912313; Tue, 08
 Jun 2021 01:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210608040241.10658-1-ryazanov.s.a@gmail.com> <20210608040241.10658-6-ryazanov.s.a@gmail.com>
In-Reply-To: <20210608040241.10658-6-ryazanov.s.a@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 8 Jun 2021 10:37:43 +0200
Message-ID: <CAMZdPi8dHp1MBtgpA16AHVdY=Wxpb4dWmhgwDW+xOEx=vExQwA@mail.gmail.com>
Subject: Re: [PATCH 05/10] net: wwan: core: spell port device name in lowercase
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
> Usually a device name is spelled in lowercase, let us follow this
> practice in the WWAN subsystem as well. The bottom line is that such
> name is easier to type.
>
> To keep the device type attribute contents more natural (i.e., spell
> abbreviations in uppercase), while making the device name lowercase,
> turn the port type strings array to an array of structure that contains
> both the port type name and the device name suffix.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
