Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9361A37515D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhEFJSK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhEFJSK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 05:18:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF32C061574
        for <linux-wireless@vger.kernel.org>; Thu,  6 May 2021 02:17:12 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t22so4369470pgu.0
        for <linux-wireless@vger.kernel.org>; Thu, 06 May 2021 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQw5jthS2ZQ6I6BWVowsPzS49MCUe1xz1/T90GLuSTo=;
        b=dRqWEAePiQJZjDnPObObwpCKO27OTwPngxBu2WVzWnfoAgWTXkfcsnn6EXtpqZ3ive
         Ku2dNvYsK2L/szsfT0Y5nUBXmjXrRO6bU8cZb9gEdRozjkPezgE6tSm+cOhvev9jk6El
         yKrYvkWMBBjkofCbx+6mLmQSSRKw7hPD6VagRhc/JWMMahENxUxYhQSAI0KurR6ynn/1
         kvoLuXbnrnlq6b0bFh3LJexyiqQM5Oced+yCuhqR5Tnosw+ucU6BJwBCo7uqFr6XXKup
         HSkV2O2NUXRiI1gQNfxTGpP2G8+QEbZwTIsbYzGBMna926aPnJLq/xDcZK+UlpIrjBmT
         hEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQw5jthS2ZQ6I6BWVowsPzS49MCUe1xz1/T90GLuSTo=;
        b=TgDemcjg7l8Gtf62EJv4s4mm3y+tlL7HgmYtLI0Snbt0/R2L0PA7C7w/8YS3LUzon5
         Re0WpYmtzBOfZihpg9XZyUw0RoDc2XHwxSUYVrJr27Bz9I+cwUrVkhqfCH+rKCVibV/8
         pMWP00DDX0WGbW2qv6DhiAJiV2wMyJlCPpR5MlUHpJAmp0clPsP+8kj7ZpgwuWLwo+/1
         XCNhIXGGBDIMXyLYTiQJeeH36DfUhn9vNv0P9kLyihfV5qnBLzBaQqlDPr++lLTL7h5Y
         HVhmCRZuYW5KuVk8z76aT5ZAJSA3EVxIFbgcyF6aoPRqoYeZqc40c4Psug6EWCkwbvr9
         OR1Q==
X-Gm-Message-State: AOAM533ksW7kdM9eJwu8xyyX8AeIa4il7O8P3TMqF4gqrRE3fpc4dDgA
        g3d2ns/MbbiQ4uE2JoluetVrtbjjJm/tLuMwnEooXQ==
X-Google-Smtp-Source: ABdhPJyZQ+x5V0C/Io7xe62f9KkHNwUDn8j1cEHE2C45NP7RgLLL5gxs+BNfjzf7lR2tYYuF8hFAHVqA4X596lHMoIw=
X-Received: by 2002:a63:5b20:: with SMTP id p32mr3233144pgb.173.1620292632214;
 Thu, 06 May 2021 02:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210420161310.16189-1-m.chetan.kumar@intel.com> <20210420161310.16189-8-m.chetan.kumar@intel.com>
In-Reply-To: <20210420161310.16189-8-m.chetan.kumar@intel.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 6 May 2021 11:25:45 +0200
Message-ID: <CAMZdPi8h7ubOvUBaF2wh87UBwzJz3GpQ3gZwSXy0miV7Aw2NXw@mail.gmail.com>
Subject: Re: [PATCH V2 07/16] net: iosm: mbim control device
To:     M Chetan Kumar <m.chetan.kumar@intel.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        krishna.c.sudi@intel.com, linuxwwan@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Chetan,

On Tue, 20 Apr 2021 at 18:14, M Chetan Kumar <m.chetan.kumar@intel.com> wrote:
>
> Implements a char device for MBIM protocol communication &
> provides a simple IOCTL for max transfer buffer size
> configuration.
>
> Signed-off-by: M Chetan Kumar <m.chetan.kumar@intel.com>

Now that the initial wwan framework support landed, could you migrate
to it for creating the MBIM 'WWAN port' instead of creating yet
another char driver? I see you introduced an IOCTL for packet size, I
see no objection to add that in the wwan core.

Regards,
Loic
