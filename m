Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D84399545
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 23:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhFBVPi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 17:15:38 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:46934 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBVPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 17:15:37 -0400
Received: by mail-oo1-f50.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso892477ooc.13
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jun 2021 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuaPVMlBEIohsrUF8vDQmI5hGYCXS2qbehZHi55t3us=;
        b=TytJcgjwjblg2cCGGT8JiDD2ybyDEtpha+3cOSTG9af87dvgmThAuHzrsMtXE1BkPS
         jAoxUfwM9UqndpvAvwfOfjWwW1hBctTv2EMyojEUZyBuT5X50dmQtMyIbLbuWYtR/wwo
         DLx6jfwlRnkhfv2e3xs7SQSioy3z0h1//Nous=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuaPVMlBEIohsrUF8vDQmI5hGYCXS2qbehZHi55t3us=;
        b=axQ5COZ9NNhz7z8JxC9eccHa9/LUhJvYwAQZgTHm3TGR6FRT96UhuXto6xmMfdY1ja
         3FQvt7RLCS8cOvy8n9w8cw3kHCj9M6aBMa7JRE0ZU95FU196i4pn9eVJAtkpgxiwPm2A
         OX1qvuW5Uuu2USNV9l7lDKIA1CHNKWfM2I3IrkWf59KBsiFm9rW3iV7rDzaXQIs2HgF6
         +BvtBWPS/wqLHG4Xn87QJPEnw6H3UcqiDYG1shSJEuO23ryZiHlf+H1GwXjqJ9kFWAVa
         ulY1x9m94GIq4mTp5BZuB1mAZu7tG4WWY54KuhSjQTUfPtjmbrs0/fpLG9Xwxaf4fF65
         Aefw==
X-Gm-Message-State: AOAM532qTA+SbOy7Ngtv2DTCgdPK5yO6EnxBJVGCCA/owQclBlzBEboQ
        Kn3ceViY4dY5llBdOLv20GhsJlKc3/umcA==
X-Google-Smtp-Source: ABdhPJyLOgD035C37GItWsy4qvF8g1Ng5e2m0fIh3AfXnUU4bCEvlqAIU4lAydI3jzB879VOKY2K4w==
X-Received: by 2002:a4a:94ef:: with SMTP id l44mr25917656ooi.84.1622668363293;
        Wed, 02 Jun 2021 14:12:43 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id l1sm215946oos.37.2021.06.02.14.12.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 14:12:42 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so3723437otp.11
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jun 2021 14:12:42 -0700 (PDT)
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr27597173oth.229.1622668362044;
 Wed, 02 Jun 2021 14:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <X8irC3FP0QDE9QFe@mwanda>
In-Reply-To: <X8irC3FP0QDE9QFe@mwanda>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 2 Jun 2021 14:12:31 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMS-qR2tgFzE7_cqtxLj9-TavbmghqGo0jDtHkbUB59Ow@mail.gmail.com>
Message-ID: <CA+ASDXMS-qR2tgFzE7_cqtxLj9-TavbmghqGo0jDtHkbUB59Ow@mail.gmail.com>
Subject: Re: [bug report] iwlwifi: support REDUCE_TX_POWER_CMD version 6
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signal boost:
I've seen issues in this code in the past, as this is a custom format,
the docs are non-public, it interacts with ACPI tables that Intel
doesn't always get to review, and the parsing is all written in C...
...I also think Dan's static checker warning below is correct.

Luca, has this been addressed yet?

On Thu, Dec 3, 2020 at 1:10 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Luca Coelho,
>
> The patch fbb7957d28ac: "iwlwifi: support REDUCE_TX_POWER_CMD version
> 6" from Sep 28, 2020, leads to the following static checker warning:
>
>         drivers/net/wireless/intel/iwlwifi/fw/acpi.c:462 iwl_sar_fill_table()
>         error: buffer overflow 'prof->table' 10 <= 15
>
> drivers/net/wireless/intel/iwlwifi/fw/acpi.c
>    422  static int iwl_sar_fill_table(struct iwl_fw_runtime *fwrt,
>    423                                __le16 *per_chain, u32 n_subbands,
>    424                                int prof_a, int prof_b)
>
> Original n_subbands was ACPI_SAR_NUM_SUB_BANDS (5) but now it can be
> IWL_NUM_SUB_BANDS_V2 (11) as well.
>
>    425  {
>    426          int profs[ACPI_SAR_NUM_CHAIN_LIMITS] = { prof_a, prof_b };
>    427          int i, j, idx;
>    428
>    429          for (i = 0; i < ACPI_SAR_NUM_CHAIN_LIMITS; i++) {
>    430                  struct iwl_sar_profile *prof;
>    431
>    432                  /* don't allow SAR to be disabled (profile 0 means disable) */
>    433                  if (profs[i] == 0)
>    434                          return -EPERM;
>    435
>    436                  /* we are off by one, so allow up to ACPI_SAR_PROFILE_NUM */
>    437                  if (profs[i] > ACPI_SAR_PROFILE_NUM)

Side note: stuff like this would be more readable and hopefully less
error prone if we used ARRAY_SIZE() instead of memorizing the array's
size here. Similar up at line 429, but at least that array is defined
~3 lines away.

>    438                          return -EINVAL;
>    439
>    440                  /* profiles go from 1 to 4, so decrement to access the array */
>    441                  prof = &fwrt->sar_profiles[profs[i] - 1];
>    442
>    443                  /* if the profile is disabled, do nothing */
>    444                  if (!prof->enabled) {
>    445                          IWL_DEBUG_RADIO(fwrt, "SAR profile %d is disabled.\n",
>    446                                          profs[i]);
>    447                          /*
>    448                           * if one of the profiles is disabled, we
>    449                           * ignore all of them and return 1 to
>    450                           * differentiate disabled from other failures.
>    451                           */
>    452                          return 1;
>    453                  }
>    454
>    455                  IWL_DEBUG_INFO(fwrt,
>    456                                 "SAR EWRD: chain %d profile index %d\n",
>    457                                 i, profs[i]);
>    458                  IWL_DEBUG_RADIO(fwrt, "  Chain[%d]:\n", i);
>    459                  for (j = 0; j < n_subbands; j++) {
>    460                          idx = i * ACPI_SAR_NUM_SUB_BANDS + j;
>    461                          per_chain[i * n_subbands + j] =
>    462                                  cpu_to_le16(prof->table[idx]);
>                                                     ^^^^^^^^^^^^^^^^
> But this table size wasn't increased so potentially we're reading beyond
> the end of the array?

I believe your warning is pointing out a real issue, and I think (?)
it's safe to just bump the table size, but given all the
not-quite-explicit relationships between various bits of the ACPI
table, the IWL command definition, and the various macros, it's not
obvious that this is the only necessary change.

Brian

>    463                          IWL_DEBUG_RADIO(fwrt, "    Band[%d] = %d * .125dBm\n",
>    464                                          j, prof->table[idx]);
>                                                    ^^^^^^^^^^^^^^^^
>    465                  }
>    466          }
>    468          return 0;
>    469  }
>
> regards,
> dan carpenter
