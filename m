Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05D636EF40
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 20:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbhD2SA7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhD2SA6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 14:00:58 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E42C06138B
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 11:00:10 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id i11so5375167oig.8
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIV5xtwMVNcM0UQcM7R2523b1mxvJyIK6hUlRsLwvX8=;
        b=Ma//wsaRAtVI1f2QVe2ruJWMZwrQXqWXVYCQ+TY8XvhbrrzZOm44997AhKbVmUY/R2
         6ym5sAgpk6FBOBrlwl6fi18IdZkO+DZ7qtVfCeppJZclOjO39n9uXXTKeBhJco1YzYW7
         B2tRhhnb/aqruQC74qYxf38bBcQqczS0KgK2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIV5xtwMVNcM0UQcM7R2523b1mxvJyIK6hUlRsLwvX8=;
        b=seg7ZjxmZZx+WTRZ7iTSwCw95APJ63QriZnZSPDp7T4hSdbKQpEwCklLZfeXmraxLY
         9QSqGMLcf4DoMKGSJYvarXi6EEBYmL1GUaLQHmU2BkdTOZK9yAlGa5a4b/GJOX19yHNQ
         vv7bZhxOMBkWp4VCgOEtiznOxksVLL5eLys+OthVhU+SDl3DUHCiD76Jp4tHnlvkep94
         rH3xzPtZXx7KwBnx0aLML39GVbM8Uf9P352mYQRaydk4OCKTWDhgaJHTJj/C+FxanAH4
         U+op+yxH5GvOdgxS8Z2Xt8/xZ0xZksrAmcs2ru10UZkyD0YLta+veEFX8ZCxzH5FUx+V
         zQNQ==
X-Gm-Message-State: AOAM532G69OboB2kMqQ48n5hp33KQkIa1HziFreiH1mPxm+128kwogX0
        Bopdx0qPrlBwocPCQZVMgLMgoBFpfsbjOQ==
X-Google-Smtp-Source: ABdhPJwSpxdWhFYyOvwv86AhbjEcVv6Lqh2i5yAg2CEoe78uzG66vDqyDHyrFCvo/GcA3yEtG8yUGA==
X-Received: by 2002:a05:6808:2c1:: with SMTP id a1mr7743109oid.160.1619719208715;
        Thu, 29 Apr 2021 11:00:08 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id r18sm106932otp.74.2021.04.29.11.00.07
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 11:00:07 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id i81so67348659oif.6
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 11:00:07 -0700 (PDT)
X-Received: by 2002:aca:f144:: with SMTP id p65mr7915679oih.117.1619719207007;
 Thu, 29 Apr 2021 11:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210422182545.726897-1-manojgupta@google.com> <20210426163021.3594482-1-manojgupta@google.com>
In-Reply-To: <20210426163021.3594482-1-manojgupta@google.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 29 Apr 2021 10:59:56 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNBXdriymXk3U=NtbDkg1rsTC7y6=VYMeJrY-y+9L-Asw@mail.gmail.com>
Message-ID: <CA+ASDXNBXdriymXk3U=NtbDkg1rsTC7y6=VYMeJrY-y+9L-Asw@mail.gmail.com>
Subject: Re: [PATCH v2] iw: set retain atrribute on sections
To:     Manoj Gupta <manojgupta@google.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Luis Lozano <llozano@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(removing stable@vger.kernel.org from CC)

On Mon, Apr 26, 2021 at 9:30 AM Manoj Gupta <manojgupta@google.com> wrote:
>
> LLD 13 and GNU ld 2.37 support -z start-stop-gc which allows garbage
> collection of C identifier name sections despite the __start_/__stop_
> references.  Simply set the retain attribute so that GCC 11 (if
> configure-time binutils is 2.36 or newer)/Clang 13 will set the
> SHF_GNU_RETAIN section attribute to prevent garbage collection.
>
> Without the patch, there are linker errors like the following with -z
> start-stop-gc:
> ld.lld: error: undefined symbol: __stop___cmd
> >>> referenced by iw.c:418
> >>>               iw.o:(__handle_cmd)
>
> Suggested-by: Fangrui Song <maskray@google.com>
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Manoj Gupta <manojgupta@google.com>

This is not a kernel patch and so should not be sent to the
linux-stable list. I think Greg KH's bot already told you as much on
earlier versions.

See:
https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/tree/README

"Please send all patches to Johannes Berg <johannes@sipsolutions.net>
and CC linux-wireless@vger.kernel.org for community review."

You're ~close.

Brian
