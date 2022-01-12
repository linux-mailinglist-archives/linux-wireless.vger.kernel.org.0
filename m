Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3D48CB42
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 19:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356464AbiALSuA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 13:50:00 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:44020 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356514AbiALStm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 13:49:42 -0500
Received: by mail-lf1-f47.google.com with SMTP id x22so11301385lfd.10
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 10:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nye0DiCqjNr3aFUpaJZ/kaqZMmnDI1WKX5tmwjOLIg=;
        b=yF37zVhilTx4saT7dA852DMD3Qf0GDleKCuKAjzjdPFfJCls7tVwcLFzG9U7D7TG8t
         WxXhw3PCXtFvVdqor4V0SNL842D29leui2v+4WuoeyPR2Zd4aynKTSZR8YDCEPBVu5z+
         Tv7vv4ojwW2TvseAKw7W2NrjXmTCtOOxGTa8oPM2pOq5oq5XwoiTKavPBoY/SLsU3UBz
         OpPE06CxhwlxhRFtKe+KOtWc7eae0T9gMI4XPHTM687nXC5xuF1NI/VkCWkRp365bWGs
         q+tELzWntFhHHOmV8OG5X5RcXqeqDTsBEZ/FLS1w5aXp3mzONAsB0oiTurTUWtRV9tEV
         LJJA==
X-Gm-Message-State: AOAM533K8TM1dPuHYeUwAQCP9Urq35tyjgVWzfGyFqNuXrj8tbaXlFn5
        1Zvg29B1/yMHtafVJ5j3kaPKxjckYjyNjxmYj9eIsxnfV7DvOg==
X-Google-Smtp-Source: ABdhPJxUifUudRt3yS0/wTj3Va/C4AZirQQBfQtrXSRlmPOPBtqn+VabOmW2wO6e80D7sFDI/pN/o87mLk80SqgAsAs=
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr586312ljp.50.1642013381547;
 Wed, 12 Jan 2022 10:49:41 -0800 (PST)
MIME-Version: 1.0
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
 <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
In-Reply-To: <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 12 Jan 2022 13:49:30 -0500
Message-ID: <CAJvTdKmKPA_W_tXVjFOQEb5nX+sE+PmBeyVcf35=8WbLXuZapA@mail.gmail.com>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting 0x2000000.
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jan 12, 2022 at 3:34 AM Johannes Berg <johannes@sipsolutions.net> wrote:

> Something like this might help?

Yes!
I have confirmed that this patch allows wifi to work, when applied to
Linux-5.16.

Let me know when you'd like me to test a production patch.

thanks!
Len Brown, Intel Open Source Technology Center

> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> index 7ee4802a5ef1..56b9363a9111 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -1026,7 +1026,9 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
>         /* the ops field is at the same spot for all versions, so set in v1 */
>         cmd.v1.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
>
> -       if (cmd_ver == 5) {
> +       if (cmd_ver == IWL_FW_CMD_VER_UNKNOWN) {
> +               return 0;
> +       } else if (cmd_ver == 5) {
>                 len = sizeof(cmd.v5);
>                 n_bands = ARRAY_SIZE(cmd.v5.table[0]);
>                 n_profiles = ACPI_NUM_GEO_PROFILES_REV3;
