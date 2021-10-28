Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4116943DAA5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 07:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhJ1FHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 01:07:35 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:41562 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhJ1FHe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 01:07:34 -0400
Received: by mail-yb1-f171.google.com with SMTP id v138so6637686ybb.8
        for <linux-wireless@vger.kernel.org>; Wed, 27 Oct 2021 22:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/UZlPQV303sNxnldgMiDx9Y0AQuyFMIMXOXKHmfeNB0=;
        b=Pb2XH0LcUx3nGAzL8q941Rcv+yXtNttkpLwYxE0xZ+jj5/0VrKgQfBSW2CMJwrMyqd
         6evF/SkW3CXIUVknNfoK3c4ixtaUuAYTIyZB8/4EFfqkvSeSlbV6j4tgtnd7erBuyapI
         k8mjBkAMEd5C3u9zEh7j3Ayd60AEGDZ7E3eWUGmy10VUeAzDQZgh2ztMkLyxRfybKze6
         umwufT2s7LZByN9x1wbiF0knlgzOqVeUicwbV4tJouBH3TkoTprrUdWQ0ZgkHwJl8fHM
         oEJUhSHkRN61nkVCeF1k6Yuaq68IGXHcHjB0kaU5TGPCApFteR99Kat9JnizbBNV1v7C
         eGdg==
X-Gm-Message-State: AOAM533GeGhMVCFVoTpnsA7xA6UTrLIJksnuRGPMb7btqNRPGfK1jPA1
        EpBrox1QfMxEAdxlBw/+WII3mqNDMFu6LlEwCu9oCx6a7NY=
X-Google-Smtp-Source: ABdhPJxmpv4cClNjDB3/pXY/kS3eUn/zLzd0f+JwaiIkN7egUa1hRN7fTgpRscPTtL/XwROxulE/QvNvOzzH4HA7ia4=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr2082871ybj.320.1635397507661;
 Wed, 27 Oct 2021 22:05:07 -0700 (PDT)
MIME-Version: 1.0
From:   Bogdan Nicolae <bogdan.nicolae@acm.org>
Date:   Thu, 28 Oct 2021 00:04:43 -0500
Message-ID: <CA+ORkNR97EvqPzHu-CoJXwKGH-HQ4B++57RE88MEF-mG=D=Jeg@mail.gmail.com>
Subject: No support for Realtek 8821CE RFE Type 6
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All,

The chipset in question is Realtek Wifi 8821CE RFE Type 6. Support is
only available up to Type 4 (Kernel 5.14.14). Are there any plans to
provide support for Type 6? If so, when?

Best regards,
Bogdan Nicolae
