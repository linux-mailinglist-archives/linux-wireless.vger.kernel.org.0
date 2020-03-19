Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893B318BE10
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgCSRcY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 13:32:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36198 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCSRcY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 13:32:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id b18so3767020edu.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2020 10:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOb6B28amuBDk0DRY53ngvva0njG0JvSZoG7dpiTgPY=;
        b=c3Bju27PQNdtsrtg0fwmoiDFXcg0do1jnK79C2eCudjcME3qPsetyqnYlOXQQD9Xny
         c1pv2XOmaoMvH8KR9DLfvjR9QJno8bOJFFIeGZE/xTFe70bmtuBWUK4YwHR0hiT/D8a4
         Rv1AKF8E6aCbgr2182LTf+l9fozwH7PcttLtoexp5LyzlFCrFS/Irc5bzkBqxhINnWBW
         Opk5dwMp0hDvov/22YyYXR3YsYY6Det3XCwLsSX0SyKJHxhgSrrh4Ius0Tr8V2r2ZGzv
         9zyV1lKLE1J+nM8Idp+BuQyGUcWt4dLKTyvtNyRWjk2fQgtuD5wJF2aqrlnInN/rdJ5j
         rspA==
X-Gm-Message-State: ANhLgQ2YUuoVUrgU17IyhMop8mOvbuCqyT0RyDOq7i+ZyZCiToIXSDFG
        XQM1UcDyZJHE8wmF/HN/Ik9nrQYsCfPfk0KNg9U=
X-Google-Smtp-Source: ADFU+vt/m51u4bXD8mEBg06kD6ib3mhh2a7ebjoO0pSTbIm9xrQafTo2vRb4IYIwOQX9Fv7lb3rgs4UqijNpsvsdFi0=
X-Received: by 2002:a50:ed0f:: with SMTP id j15mr3873833eds.311.1584639141916;
 Thu, 19 Mar 2020 10:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <iwlwifi.20200318081237.46db40617cc6.Id5cf852ec8c5dbf20ba86bad7b165a0c828f8b2e@changeid>
 <20200318213440.GO311@earth.li>
In-Reply-To: <20200318213440.GO311@earth.li>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 19 Mar 2020 13:32:10 -0400
Message-ID: <CAJvTdKmrKJQee-WrG4UCo0FYrr++Er=mftrdLKjcCuy23N+HPw@mail.gmail.com>
Subject: Re: [PATCH v5.6] iwlwifi: don't send GEO_TX_POWER_LIMIT if no wgds table
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Luca Coelho <luca@coelho.fi>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tested-by: Len Brown <len.brown@intel.com>

on Linux-5.6-rc6 WITH this patch:

[    2.923632] iwlwifi 0000:3a:00.0: enabling device (0000 -> 0002)
[    2.933367] iwlwifi 0000:3a:00.0: loaded firmware version
17.3216344376.0 3160-17.ucode op_mode iwlmvm
[    3.407034] iwlwifi 0000:3a:00.0: Detected Intel(R) Dual Band
Wireless AC 3160, REV=0x164
[    3.428304] iwlwifi 0000:3a:00.0: base HW address: e4:02:9b:c0:4d:f1
[    3.546341] iwlwifi 0000:3a:00.0 wlp58s0: renamed from wlan0


Linux 5.6-rc6 WITHOUT this patch:

[    2.773544] iwlwifi 0000:3a:00.0: enabling device (0000 -> 0002)
[    2.829310] iwlwifi 0000:3a:00.0: loaded firmware version
17.3216344376.0 3160-17.ucode op_mode iwlmvm
[    3.348050] iwlwifi 0000:3a:00.0: Detected Intel(R) Dual Band
Wireless AC 3160, REV=0x164
[    3.721261] iwlwifi 0000:3a:00.0: base HW address: e4:02:9b:c0:4d:f1
[    4.431592] iwlwifi 0000:3a:00.0 wlp58s0: renamed from wlan0
[    5.581857] iwlwifi 0000:3a:00.0: Microcode SW error detected.
Restarting 0x2000000.
[    5.583340] iwlwifi 0000:3a:00.0: Start IWL Error Log Dump:
[    5.584693] iwlwifi 0000:3a:00.0: Status: 0x00000040, count: 6
[    5.586150] iwlwifi 0000:3a:00.0: Loaded firmware version:
17.3216344376.0 3160-17.ucode
[    5.587194] iwlwifi 0000:3a:00.0: 0x00000038 | BAD_COMMAND
...
and wifi is permanently dead...

thanks!
-Len


On Wed, Mar 18, 2020 at 5:57 PM Jonathan McDowell <noodles@earth.li> wrote:
>
> On Wed, Mar 18, 2020 at 08:12:54AM +0200, Luca Coelho wrote:
> > From: Golan Ben Ami <golan.ben.ami@intel.com>
> >
> > The GEO_TX_POWER_LIMIT command was sent although
> > there is no wgds table, so the fw got wrong SAR values
> > from the driver.
> >
> > Fix this by avoiding sending the command if no wgds
> > tables are available.
> >
> > Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
> > Fixes: 39c1a9728f93 ("iwlwifi: refactor the SAR tables from mvm to acpi")
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>
> Thanks Luca.
>
> Works for me on an AC 3168 with firmware 29.1044073957.0
>
> Tested-By: Jonathan McDowell <noodles@earth.li>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206395
> Cc: stable@vger.kernel.org # 5.5.10+
>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 14 ++++++++------
> >  drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 14 ++++++++------
> >  drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |  9 ++++++++-
> >  3 files changed, 24 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> > index 48d375a86d86..ba2aff3af0fe 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> > @@ -6,7 +6,7 @@
> >   * GPL LICENSE SUMMARY
> >   *
> >   * Copyright(c) 2017        Intel Deutschland GmbH
> > - * Copyright (C) 2019 Intel Corporation
> > + * Copyright (C) 2019 - 2020 Intel Corporation
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of version 2 of the GNU General Public License as
> > @@ -27,7 +27,7 @@
> >   * BSD LICENSE
> >   *
> >   * Copyright(c) 2017        Intel Deutschland GmbH
> > - * Copyright (C) 2019 Intel Corporation
> > + * Copyright (C) 2019 - 2020 Intel Corporation
> >   * All rights reserved.
> >   *
> >   * Redistribution and use in source and binary forms, with or without
> > @@ -491,13 +491,13 @@ int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
> >  }
> >  IWL_EXPORT_SYMBOL(iwl_validate_sar_geo_profile);
> >
> > -void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> > -                   struct iwl_per_chain_offset_group *table)
> > +int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> > +                  struct iwl_per_chain_offset_group *table)
> >  {
> >       int ret, i, j;
> >
> >       if (!iwl_sar_geo_support(fwrt))
> > -             return;
> > +             return -EOPNOTSUPP;
> >
> >       ret = iwl_sar_get_wgds_table(fwrt);
> >       if (ret < 0) {
> > @@ -505,7 +505,7 @@ void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> >                               "Geo SAR BIOS table invalid or unavailable. (%d)\n",
> >                               ret);
> >               /* we don't fail if the table is not available */
> > -             return;
> > +             return -ENOENT;
> >       }
> >
> >       BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES * ACPI_WGDS_NUM_BANDS *
> > @@ -530,5 +530,7 @@ void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> >                                       i, j, value[1], value[2], value[0]);
> >               }
> >       }
> > +
> > +     return 0;
> >  }
> >  IWL_EXPORT_SYMBOL(iwl_sar_geo_init);
> > diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
> > index 4a6e8262974b..5590e5cc8fbb 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
> > +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
> > @@ -6,7 +6,7 @@
> >   * GPL LICENSE SUMMARY
> >   *
> >   * Copyright(c) 2017        Intel Deutschland GmbH
> > - * Copyright(c) 2018 - 2019        Intel Corporation
> > + * Copyright(c) 2018 - 2020        Intel Corporation
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of version 2 of the GNU General Public License as
> > @@ -27,7 +27,7 @@
> >   * BSD LICENSE
> >   *
> >   * Copyright(c) 2017        Intel Deutschland GmbH
> > - * Copyright(c) 2018 - 2019       Intel Corporation
> > + * Copyright(c) 2018 - 2020       Intel Corporation
> >   * All rights reserved.
> >   *
> >   * Redistribution and use in source and binary forms, with or without
> > @@ -171,8 +171,9 @@ bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
> >  int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
> >                                struct iwl_host_cmd *cmd);
> >
> > -void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> > -                   struct iwl_per_chain_offset_group *table);
> > +int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> > +                  struct iwl_per_chain_offset_group *table);
> > +
> >  #else /* CONFIG_ACPI */
> >
> >  static inline void *iwl_acpi_get_object(struct device *dev, acpi_string method)
> > @@ -243,9 +244,10 @@ static inline int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
> >       return -ENOENT;
> >  }
> >
> > -static inline void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> > -                                 struct iwl_per_chain_offset_group *table)
> > +static inline int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> > +                                struct iwl_per_chain_offset_group *table)
> >  {
> > +     return -ENOENT;
> >  }
> >
> >  #endif /* CONFIG_ACPI */
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > index 54c094e88474..98263cd37944 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > @@ -762,10 +762,17 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
> >       u16 cmd_wide_id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
> >       union geo_tx_power_profiles_cmd cmd;
> >       u16 len;
> > +     int ret;
> >
> >       cmd.geo_cmd.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
> >
> > -     iwl_sar_geo_init(&mvm->fwrt, cmd.geo_cmd.table);
> > +     ret = iwl_sar_geo_init(&mvm->fwrt, cmd.geo_cmd.table);
> > +     /*
> > +      * It is a valid scenario to not support SAR, or miss wgds table,
> > +      * but in that case there is no need to send the command.
> > +      */
> > +     if (ret)
> > +             return 0;
> >
> >       cmd.geo_cmd.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
> >
> > --
> > 2.25.1
> >
>
> J.
>
> --
>      I don't know. I'm a dog.      |  .''`.  Debian GNU/Linux Developer
>                                    | : :' :  Happy to accept PGP signed
>                                    | `. `'   or encrypted mail - RSA
>                                    |   `-    key on the keyservers.



-- 
Len Brown, Intel Open Source Technology Center
