Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295961CB42
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 17:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfENPAH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 11:00:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36363 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENPAG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 11:00:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so3138395wru.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2pvT3lAALltVAXbytV/5gIoc1DBX2+lwiggdED4PDbo=;
        b=GSM0Qbva+99HW5NBSoYk8ao4yhvh9C/BTgXoeTpMeuiUe99/6+krl3DX5Y5uqT1Rh3
         gKUmKgEerOoc+6C+VZxe6xBBblt1P3ntKj3/XSwcTnL/t7GnpVi4xFUEghwRCDWWl+Fl
         JUg3WQ8pdZkEOO7MWrE+28zwbepHiI/xXhGpJ5sUOVjgrud0GIOD9Sk/1CR+xlDHD+pF
         9v3jzXMy6gO5LBeJnmh7y3XxNg7jrRWjNLRxYR7lFYZrZAaa9ROk9Xg3DBV2PhZfNMor
         mkldh5ugeqQ/GiJS4L8p+ZouqBJIeQjR47fgLW2YSFkzix4ZOV93ccJoblgtLnDNR3lg
         UMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2pvT3lAALltVAXbytV/5gIoc1DBX2+lwiggdED4PDbo=;
        b=FrvT7acsP6tYT5CxvwIYPEctlxUa/9sYNgNwPQKs03ecuvPqlJtuSK27M7Cpw2J1cu
         MDhJRBNghjW+C5WqLACFjCkHGIJt8S789RcpbolsnIAc9BBAcnwVwvAe6SBFoq1x6SW/
         dPjWiNSXWVOTn3mzharKwdB2R0Den8MxVG4xSaxr6i+tNl1xvJ7YdEoOter+A1+vlwnn
         wlUsv66U0nBp92dhTu22FagREqG4iYDAs1KNYH/Ico5hm7jSXxnZgl9fjhY5LYNDy9un
         NykjY2Vvq5/Ud3VASHU4pBuzrMztEIxWSSx8P9iMe0xSWr7PBn5QWHUSWdlVLmuCySHe
         x9Hg==
X-Gm-Message-State: APjAAAU1DfzGqzr3h07nINTf2ONrhRjBhij4FNjKh3CNI4MOce5IziF9
        4FJDV60qfq+75i7qRLhtUGcS6gKVXl+nbx0tH6Y=
X-Google-Smtp-Source: APXvYqzjnTeAKyvQ4GiU3X0L6I/He+CyTRcBHA5BmPBca9IKOaNAkqLuRGotYr8+0aQP+QVPDdTslxfFoi+2M/acSBM=
X-Received: by 2002:a5d:430f:: with SMTP id h15mr4128742wrq.132.1557846004796;
 Tue, 14 May 2019 08:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
 <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org> <CA+icZUXDLQKyTH-_pPi7A2=Bu5ratwab930Fcecrdr4NtMnFcw@mail.gmail.com>
 <27f2ce02-8deb-384f-af10-7737b703770a@linaro.org>
In-Reply-To: <27f2ce02-8deb-384f-af10-7737b703770a@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 May 2019 16:59:53 +0200
Message-ID: <CA+icZUVaBdswfmRfbRtdVJY8ymeDOwDSFEf7G6jneqEmpW84bg@mail.gmail.com>
Subject: Re: NXP NFC version and ACPI
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        oleg.zhurakivskyy@intel.com, clement.perrochaud@effinnov.com,
        charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 14, 2019 at 10:17 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
[...]

Just for the records:

root@iniza:~# rfkill --output ID,TYPE
ID TYPE
 0 bluetooth
 1 nfc
 2 wlan
 3 bluetooth

root@iniza:~# rfkill list nfc
1: nfc0: NFC
        Soft blocked: no
        Hard blocked: no

- Sedat -
