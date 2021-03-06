Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6691D32FCE6
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Mar 2021 20:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhCFTx5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Mar 2021 14:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhCFTxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Mar 2021 14:53:55 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278F6C06175F;
        Sat,  6 Mar 2021 11:53:55 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v14so5231771ilj.11;
        Sat, 06 Mar 2021 11:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=vlYF1Htq1UCj2PlrUUYbtgbjonQngGN1ifIxVwTgusM=;
        b=S6SLmaBoQtcqiEbPuYj0AoHHu4EHwxmwfGRsdlpr3GzRbHivO798NjIbebYHovK388
         PO2JNGDbTxFBswArVWxgyGtpuUp2q6nL+8tua0TKWqrt9vtQQKllkAwBO0zqANGc6Bx4
         5AA86/5Hu1+YYYgDZDOwnfLAPseh9K+c84nuxXFmrf18IwdndZ57GgGBD7hyQLJocI29
         GBKiZQ/XYa/kjE4S8Rb+LuUIax4Ht5tKGSwNTdRtzeDu7QnuqU1vmG3XGTJGi9OMcaIB
         mCu9p56iuyAJuwAhDCJXoLr/+q2oqJslKKfBuF0fQHdZ0k0eUCYqDoS3RVHvF9trVmhG
         SjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=vlYF1Htq1UCj2PlrUUYbtgbjonQngGN1ifIxVwTgusM=;
        b=qdaj8riRLsGm2IQdFgde7fyYfJl1zSVGQlRUBYTIKpkI/tR/naJ+QDL0u/R1mfJ5Hl
         AcwXHinfP+Pgv+0xi/qHfC3mLTgb2cOakBWIWqP0AWRp8trIOgX7AxD7y68T8fZqb5rG
         8W0acDhDbAG7m6AlbnIe0TmOlz4nnFn6MwDLa5e91MB7g6b2DnYFwAmWWB58+Ijko4xr
         YwHteGdrlkQfGf98jBxpqr7lTbL8braBuiidV0lEeQ7Yk5vZyEPiK04xT7SgKv+kspRd
         sdUUHgWxXkWKsSOs1NgyLzg5CVXu/42Uhi9rvpcifInUps0dqicCP580Vhfr8VoMzh3T
         wP4w==
X-Gm-Message-State: AOAM531htCPN7j3ZSrVrautLk8JTOIRQGwAQKBMgmPOj3QgkZbTX7aw6
        3yrCHKA5pZGcBpX1GhcYx14Qpw1xnSf+APTrAv0=
X-Google-Smtp-Source: ABdhPJwGI5zB4p+cU14S7UalxhtlLHcDQwnoRKhxceC+wuGYIcFlv7mFVCzCcLfHGZeG+5Ardg+xo4STgUtQQsBvCRk=
X-Received: by 2002:a92:ce84:: with SMTP id r4mr13811463ilo.112.1615060434707;
 Sat, 06 Mar 2021 11:53:54 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2103061139200.1285@eggly.anvils> <alpine.LSU.2.11.2103061147270.1285@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2103061147270.1285@eggly.anvils>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Mar 2021 20:53:18 +0100
Message-ID: <CA+icZUWwEAY5BvOGsvOY+VSxk=h6kd+twJ1okTGf4o2cuagPEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iwlwifi: fix DVM boot regression in 5.12-rc
To:     Hugh Dickins <hughd@google.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Jiri Kosina <jikos@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 6, 2021 at 8:50 PM Hugh Dickins <hughd@google.com> wrote:
>
> No time_point op has been provided for DVM: check for NULL before
> calling, to fix the oops (blank screen booting non-modular kernel).
>
> Fixes: d01293154c0a ("iwlwifi: dbg: add op_mode callback for collecting debug data.")
> Signed-off-by: Hugh Dickins <hughd@google.com>

See "iwlwifi: avoid crash on unsupported debug collection" in [1].

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=4538c5ed0f7e892f1b643472e48146757d1e60c5

> ---
>
>  drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- 5.12-rc2/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   2021-02-28 16:58:55.058425551 -0800
> +++ linux/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h      2021-03-05 20:59:14.156217412 -0800
> @@ -205,7 +205,8 @@ static inline void iwl_op_mode_time_poin
>                                           enum iwl_fw_ini_time_point tp_id,
>                                           union iwl_dbg_tlv_tp_data *tp_data)
>  {
> -       op_mode->ops->time_point(op_mode, tp_id, tp_data);
> +       if (op_mode->ops->time_point)
> +               op_mode->ops->time_point(op_mode, tp_id, tp_data);
>  }
>
>  #endif /* __iwl_op_mode_h__ */
