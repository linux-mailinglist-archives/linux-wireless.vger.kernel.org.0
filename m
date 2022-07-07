Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7E956AE02
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jul 2022 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiGGVzx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Jul 2022 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiGGVzo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Jul 2022 17:55:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C88237C8
        for <linux-wireless@vger.kernel.org>; Thu,  7 Jul 2022 14:55:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu42so13528216lfb.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Jul 2022 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjkruDOfgtNG2P/JMcjrgptBtGqklTPONWmMneNgjdQ=;
        b=e3OSeiKAf4U5yFmmwkZ2dAxTav20lD5wJSygHmb3mnxTpWLPRf52/0elcJ8FeLFhmi
         gQFBr+IzK1Mh4zYLL2TsMa4jJAoMTtzJEp/Djbh46Q2DUOgg6acWK/9ARh3VRLaWdk0n
         wdaqkoWOkrMuvyG9exWEh+M2dhFWvl9O3Vt9rB0RWAfVQADTWrJQkW1zfuuJimBh6oxO
         2F/drv67/O28bGQDl7glDEo6GEq11cNnbCenXJASchGcJUhdioC17tAc6LL7eaLvCf9W
         BmKuwNJb13KBzv3QZf0dC+R5kn9KL1DMRtUCbKdOTWQmE6fyLBBFuzPPapvHyUn8nAsO
         wrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjkruDOfgtNG2P/JMcjrgptBtGqklTPONWmMneNgjdQ=;
        b=gkcnk6rv8OWFzTwGLOVrzBI1PfmuU4IOKFMdZYNsFlYMltISEqAYPr+P3jJeBLJH7E
         UVavZT2hoAYZpu21NI9LIpWsFpdUXeOezHdsqbuYvvBAZCNURY1AunMKNj+oFEfvVGp/
         H5tbfwm4ouXlTfVwhQ9w7p+VdnhDWURdrWjevbKYN+ZIoUV7JrXr6ZZJ2vgoQ8p9e0IZ
         BUJjAxsTEiy245WOyH8X3kP/6XpqeL2Bfe6alcrRZXpw3jYVj/uUl3fhCrgpFXOWdA+t
         fXge86LX/QDR065yd+7pjOIgJLSEp5aevzCnqFrIkaUC/XQM0w6K07VCn2LYriQWbQjs
         e8IQ==
X-Gm-Message-State: AJIora8btsQl71cDLN5316TRfhkRq7svMYTR1B3VysL5UXPBqwIIOzx5
        XdovZf4/GW5Dz3MpUWw9Qdg9dZOtQx81lzNaLeJUQw==
X-Google-Smtp-Source: AGRyM1ulUqkyJL4RyJoqEjTlne97SVueY82GDwdi25+K4J351aeav1qr4l9IpBkvU0Q3fMqjGn/UQn1tge7LHhB3t4o=
X-Received: by 2002:a05:6512:3c97:b0:481:1a82:9d6b with SMTP id
 h23-20020a0565123c9700b004811a829d6bmr191230lfv.626.1657230941216; Thu, 07
 Jul 2022 14:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220702151020.2524220-1-trix@redhat.com>
In-Reply-To: <20220702151020.2524220-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Jul 2022 14:55:29 -0700
Message-ID: <CAKwvOdkeo75+BNrbH+6VHjHB_Md4VFdxy+Pgd3icxsTPCMka4g@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: mvm: return an error if setting tbl_rev fails
To:     Tom Rix <trix@redhat.com>
Cc:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, luciano.coelho@intel.com,
        ayala.barazani@intel.com, miriam.rachel.korenblit@intel.com,
        johannes.berg@intel.com, matt.chen@intel.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Jul 2, 2022 at 8:10 AM Tom Rix <trix@redhat.com> wrote:
>
> clang static analysis reports
> drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1048:17: warning: Assigned value is garbage or undefined [core.uninitialized.Assign]
>         fwrt->ppag_ver = tbl_rev;
>                        ^ ~~~~~~~
> tbl_rev is optionaly set by a series of calls to iwl_acpi_get_wifi_pkg()
> and then jumping to the read_table when a call is successful.  The
> error case when all the call fails is not handled.  On all failed,
> the code flow falls through to the read_table label.  Add an error
> handler for the all fail case.
>
> Fixes: e8e10a37c51c ("iwlwifi: acpi: move ppag code from mvm to fw/acpi")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> index e6d64152c81a..1ef1e26c3206 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> @@ -1044,6 +1044,9 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
>                 goto read_table;

Thanks for the patch!

I wonder why the pre-existing code had a goto to a label that was the
subsequent statement? That's strange; maybe something was in between
them before, was removed, and that wasn't cleaned up?

I think the whole `if (!IS_ERR(wifi_pkg))` block would be clearer if this was:

...
wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
    ACPI_PPAG_WIFI_DATA_SIZE_V1, &tbl_rev);
if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
    ret = -EINVAL;
    goto out_free;
}
num_sub_bands = IWL_NUM_SUB_BANDS_V1;
IWL_DEBUG_RADIO(fwrt, "Reading PPAG table v1 (tbl_rev=0)\n");
read_table:
...

rather than the existing spaghetti. Apologies for my formatting.

>         }
>
> +       ret = -EINVAL;
> +       goto out_free;
> +
>  read_table:
>         fwrt->ppag_ver = tbl_rev;
>         flags = &wifi_pkg->package.elements[1];
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
