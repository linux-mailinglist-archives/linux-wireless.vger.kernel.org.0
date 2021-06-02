Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E03399615
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 00:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFBWyj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 18:54:39 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:46746 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFBWyi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 18:54:38 -0400
Received: by mail-lj1-f182.google.com with SMTP id e11so4610146ljn.13
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jun 2021 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ij3SXWTCN+9dB7mTVvay4q49mzvCUt7VB9xa4OQCn4U=;
        b=HUunR1qKj7DKAaLYSHc2CTq5DBlpV3tP1n9bK+HxFnIcWRw9iDRh0sjIVWtD/2AUE0
         aiMbBjTcHLDCj+1H9CoHWbAEtO7KmEnpoHfl+JqmRm6TogSPABnm84vWHVj9ylDVXRwR
         Ua5ZDhyhLqSNXy3K1Ql7Nz8wEFcMT/N3VTqf1WsQGNbczISPwanDCz9R5wi0WKw9bH54
         uYAkn+RGya50NNZm8heKbLCkzQZ5ChigL0U13LKyeqPMlmC2p3FX+7cacNfVbe2552dq
         eYSdRb7ZhHEshb+CF8AES+S3S4m4eGwPoQ72LuCPdwe57ohNUK7I7SjPUk3/r3iVb7N9
         38eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ij3SXWTCN+9dB7mTVvay4q49mzvCUt7VB9xa4OQCn4U=;
        b=hXFNpLh4lXj5UXDHABCeJ3XbZfnbxSusuJ4otLVLQVBvqX534eSsV2oKvzdrPTnUTD
         fdcSoAuTMSdn1OJ5JXY+ckA3hVeTO1Xyj4zXfq3Ehx0juezErD5XoyJP/YUC/kNlmHPt
         7BGcTLtW4n44ZnZxDzsWuI2rsxzOD01qGp1r6wTKCSj+TmwmztWGtOiuZqIheoKKBsNz
         /ZBovrXU+FuNT7Em8kObaFl70GUpyL/ttgZdWmu6GnfIUX7X7w/M6Pp3cB0yv5eJAxB5
         2+ns/EfBdQqRGMAArfANxPH59UKFT0AWwAZlVucGK6NmWPT7Mj9waR/J8BQGm7qf1B7l
         99tA==
X-Gm-Message-State: AOAM5313/+gR//JPhNzXYWNVYr2uO5/F0NDl0MonFOSYYpC7i4i3oeW/
        rFmDIFuL/0YgQ4k3spApJGKtVB/2K6fsn39JFkg=
X-Google-Smtp-Source: ABdhPJx+9LZ9gMGy1HdEnT3q9aKDob4ubLjOVJO44vl1JLyua7cTBc+RLzpZusJQi9dsBnwoRttLA3R5MADijg1LksA=
X-Received: by 2002:a2e:824c:: with SMTP id j12mr26962032ljh.490.1622674300938;
 Wed, 02 Jun 2021 15:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DPAr0XPHefewjF2fx7UL+7RvycAYLZdfosOUT6bwWHBA@mail.gmail.com>
In-Reply-To: <CAOMZO5DPAr0XPHefewjF2fx7UL+7RvycAYLZdfosOUT6bwWHBA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 2 Jun 2021 19:51:29 -0300
Message-ID: <CAOMZO5A3csY5GkczjXWeec188vUr08kWDnY-miv=9OU8pDToBw@mail.gmail.com>
Subject: Re: ath10k_sdio: Long time for loading firmware and RCU errors
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>, gerg@kernel.org,
        erik.stromdahl@gmail.com, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 25, 2021 at 9:40 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi,
>
> I am using the QCA9377 chip on an imx6dl-pico-pi board running kernel
> 5.10.37 and I noticed that the firmware takes a long time to load
> (more than 3 minutes after boot):

Ok, I replaced eudev with mdev in Buildroot and now it loads the
QCA9377 firmware quickly.

> # wpa_supplicant  -iwlan0 -c /etc/wpa.conf &
> # Successfully initialized wpa_supplicant
> [  234.360447] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> [  234.390478] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!

These NOHZ messages still pop up.

Cheers
