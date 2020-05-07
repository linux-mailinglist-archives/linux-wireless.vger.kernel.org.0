Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4616D1C9B65
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 21:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGTvJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 15:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgEGTvJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 15:51:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65BEC05BD43
        for <linux-wireless@vger.kernel.org>; Thu,  7 May 2020 12:51:08 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x73so5537017lfa.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2020 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AV2vFPjG6tmv7k34SurwqCA71K+2Dp9VcMKySZL5GeU=;
        b=jffKVgg5T36h6xRConhsM4qWQ6O7O/m3mB7v54LSdkVnvwp5eTkzNPIHQ2sCfVZSeK
         K0Ni8Z6JEKabqtI6qu40fsRj/eEgSUlZcmEfDh8g6xsQoojEArgEa4rM79lGnDF3X3CT
         QaeOzLFhweGwpM1YJdfbTjqoELvXSy5BbJ0FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AV2vFPjG6tmv7k34SurwqCA71K+2Dp9VcMKySZL5GeU=;
        b=sO3hiyPbT/0wNMpllwkCNuy6TUBaG/iHJ+g6dXIWtegP/RF9cbE/VlVZmKd6QBb7eu
         a00HNpEkimj+9nDRAMfeJNnxMQVgHd85RYSnI8QLIeUuzd+/91MMsMxnZkLHSQbk7mI6
         JJ1JKoRV08vYTH6PVB2f+ZggWGo/5pKwpMbOjr/fZ9KlEQOu1EWh8peXdXj6ZK9Rfmma
         Jvvf21ixIeYf2+kJK7IdvFNn/rI6FQr5ju1ES8VZ2be8uiDekYjpGD3i8Ng6I19YRpYv
         k6bZaL2pCNmxK2v9SxvUB5kvbjAI1gYlVYjAHnndxv/mplujvpdiocL/x74mRAwJQGK+
         1CQA==
X-Gm-Message-State: AGi0PuYGR5/Bh27kD1NSeQHlvaeYbAmsc7h5OV7dGjSVy8DspPHWoCiF
        RsE7wbbmFavT/g6750ZUkEeGiuR/uBw=
X-Google-Smtp-Source: APiQypKq6SNyB7f6p/AjcvjOVSyrgWMPRZ5EUhCd/FSjxwdyzTm08G0QTHT1w4tcdF4O5vQcwjBkiQ==
X-Received: by 2002:a19:cbcf:: with SMTP id b198mr10147530lfg.36.1588881066821;
        Thu, 07 May 2020 12:51:06 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id q27sm4338828lfn.58.2020.05.07.12.51.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 12:51:05 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 188so5521879lfa.10
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2020 12:51:05 -0700 (PDT)
X-Received: by 2002:a19:c514:: with SMTP id w20mr10019548lfe.59.1588881065416;
 Thu, 07 May 2020 12:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200507041945.15491-1-yhchuang@realtek.com>
In-Reply-To: <20200507041945.15491-1-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 7 May 2020 12:50:54 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOn03T6LJ9vH=rmiVxHfyPpM6KMWgt1oTB+rXNYUZy-YA@mail.gmail.com>
Message-ID: <CA+ASDXOn03T6LJ9vH=rmiVxHfyPpM6KMWgt1oTB+rXNYUZy-YA@mail.gmail.com>
Subject: Re: [PATCH] rtw88: update firmware information and README
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     jwboyer@kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-firmware@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 6, 2020 at 9:19 PM <yhchuang@realtek.com> wrote:
> +    And note that the rtw88 driver is able to support wake-on-wireless LAN
> +    for RTL8822C devices, after kernel v5.6+. So, make sure the firmware
> +    rtw88/rtw8822c_wow_fw.bin is also packed, otherwise the firmware load
> +    fail could be a problem.

For the record, I think it's a bug that your driver will refuse to
work now, when not provided the optional WoW firmware:

https://bugzilla.kernel.org/show_bug.cgi?id=207607

It's fine to hint to packagers that they should include both, but it's
not very kind to kill WiFi entirely just because this features won't
work.

Brian
