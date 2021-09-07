Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE124027C4
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbhIGLbn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 07:31:43 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:35608
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244596AbhIGLbm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 07:31:42 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3AF773F229
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 11:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631014235;
        bh=P2bfunZepWm9+WvxkBIjeIexMDJikor2nKCNpG8+xQk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=JQPu+3t4Kvu7YkMgY8/E/tKt0ibrSlmsqfFpdanmSlv4SvVnhhbi51L/UI8+YUHh1
         yfIRFCc2k/LEGaxKam/+RKjhMtt916uIJf4DjgzEnxgrY2oVTYEt+bAQru3WGitwb7
         8RApsWlpJbw8QunwMRPKhQ7JH0Cluc4A92SEUf3kC/QcNYOoVYlB9OEG4Ac77Nwz74
         /pZY6J62SCkjMzQd6OJZyJEMXAyz9NdRYkcffBK5uxOF2xM6kSk77IP1VYmcGU1Vul
         3kGpSjRWQHkzgY9RNzwLptIFCdbqF3yb+fYU5pekg24DuYLDc0SVfMevOl4VBn9Qqs
         ilM1BQbxbENKA==
Received: by mail-oo1-f70.google.com with SMTP id x7-20020a4aea07000000b0028b880a3cd3so5549701ood.15
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 04:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2bfunZepWm9+WvxkBIjeIexMDJikor2nKCNpG8+xQk=;
        b=ZWzPQJ/qeYOPqExqjaM/7RixHlhpIkCPB/7nV1IKkypbdZe/++3nGXcK7lVqrn4Gmm
         pe2d7avYP15V2xvc2pMo6oOn5AOzSWdVLdmpXRTcM5oI6slwvIpAI5vRkqCnPYgxgNcw
         4t79pBqdAgo273aXwgMgshioCOOqR2ln9gbM7UyB3r/Uryo6IPHSTKhmgD/kgAo43zWa
         4zqHNWhfKXnMuLbzGasivwQDJldB7O6gJbdyEbFAKrNKbGmtzVK2MjhuVO77/1uKtacF
         Cg71ke75OZ5ccXuGV/GAwfCyfBZomQacJoJEUks5S1hhXPSSH5qpX7HPw5xFune/d3pd
         dC8g==
X-Gm-Message-State: AOAM531TbcQLYHB5Yfcwmz9yXmFL4CdLuP4rCaoFBnsiYXa4/GRiqoSd
        1Q4K8A6A1Qvy8hq8LrQUlr8Ln3gmH1Owb1K+DpXJoAKQ428rCi4RN2EPtTutgo76IHN9sp98bNg
        DR3yscpt6p6DErdpepkSjACxM1gHUkO3vWSqErFUX61iE18L51U4Oo3Rl6DhD
X-Received: by 2002:a05:6830:1355:: with SMTP id r21mr14255429otq.11.1631014233792;
        Tue, 07 Sep 2021 04:30:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynb1o8YNFQEU4qHUaPsLNjsSt1W89En7PI6nQ4cSPeBIY1Yh18rMRCKsI0RJPbOcr1/pUsnJOPbqtlYmSXriA=
X-Received: by 2002:a05:6830:1355:: with SMTP id r21mr14255399otq.11.1631014233433;
 Tue, 07 Sep 2021 04:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210210115637.276676-1-luca@coelho.fi> <iwlwifi.20210210135352.889862e6d393.I8b894c1b2b3fe0ad2fb39bf438273ea47eb5afa4@changeid>
In-Reply-To: <iwlwifi.20210210135352.889862e6d393.I8b894c1b2b3fe0ad2fb39bf438273ea47eb5afa4@changeid>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 7 Sep 2021 19:30:21 +0800
Message-ID: <CAAd53p5udakjRZeFLyrzwtfoq5Vr937CNRghS6_YnCet9yhB1Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] iwlwifi: mvm: store PPAG enabled/disabled flag properly
To:     Luca Coelho <luca@coelho.fi>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Luca,

On Wed, Feb 10, 2021 at 8:00 PM Luca Coelho <luca@coelho.fi> wrote:
>
> From: Luca Coelho <luciano.coelho@intel.com>
>
> When reading the PPAG table from ACPI, we should store everything in
> our fwrt structure, so it can be accessed later.  But we had a local
> ppag_table variable in the function and were erroneously storing the
> enabled/disabled flag in it instead of storing it in the fwrt.  Fix
> this by removing the local variable and storing everything directly in
> fwrt.

This patch enables PPAG, but it breaks one of HP laptop with Intel 9560.

dmesg with iwlwifi.debug=0x80 attached in the bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=214343

>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> Fixes: f2134f66f40e ("iwlwifi: acpi: support ppag table command v2")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> index 3bfb80dd17cf..57471ab2f5ef 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -895,7 +895,6 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
>  static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
>  {
>         union acpi_object *wifi_pkg, *data, *enabled;
> -       union iwl_ppag_table_cmd ppag_table;
>         int i, j, ret, tbl_rev, num_sub_bands;
>         int idx = 2;
>         s8 *gain;
> @@ -949,8 +948,8 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
>                 goto out_free;
>         }
>
> -       ppag_table.v1.enabled = cpu_to_le32(enabled->integer.value);
> -       if (!ppag_table.v1.enabled) {
> +       mvm->fwrt.ppag_table.v1.enabled = cpu_to_le32(enabled->integer.value);
> +       if (!mvm->fwrt.ppag_table.v1.enabled) {
>                 ret = 0;
>                 goto out_free;
>         }
> @@ -978,7 +977,7 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
>                             (j != 0 &&
>                              (gain[i * num_sub_bands + j] > ACPI_PPAG_MAX_HB ||
>                               gain[i * num_sub_bands + j] < ACPI_PPAG_MIN_HB))) {
> -                               ppag_table.v1.enabled = cpu_to_le32(0);
> +                               mvm->fwrt.ppag_table.v1.enabled = cpu_to_le32(0);
>                                 ret = -EINVAL;
>                                 goto out_free;
>                         }
> --
> 2.30.0
>
