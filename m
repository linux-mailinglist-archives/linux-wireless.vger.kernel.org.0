Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85355AF7CA
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 00:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIFWU6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 18:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIFWU4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 18:20:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F488E455
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 15:20:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 123so3377578pfy.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Sep 2022 15:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=kAmqUllddDgQbG3/eZBv/Jy8ck5QIIXD77tnUm6cpCM=;
        b=mfxUJELeHUROo7Qq3yAsLBqVp4+BZyEd0wGqtWzSfyX/4A1QNYDJv9RQ4MqLdG0nTm
         Jxk6zMNTJ2jL5Kl1gpff8tsiioHQqyMOoFYYLvIcEAL1SWIAuPi5JVe0L/x8vZsX8Uwd
         h8VFi0171Wxg0ryhAFTAxMYPBndZQvse+xd+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kAmqUllddDgQbG3/eZBv/Jy8ck5QIIXD77tnUm6cpCM=;
        b=p6yUEOTpq/M4HyrBar/JUA4+032ZfE34GyaTli6uAepoBtvqw7hoNnSa7ayCvdHH1T
         U3yM7dHYk3dNPMBCrTEzv8D/KAbpuoj6zsyb4Dg0WRfyvwobSARZW/0T7OJEszCtzCXG
         vOG2SxMslbTnORa/LKQr99NZrv2ynGamQedHLlMn1ZDNSVtZHn8COGf/mDxf+vxkCuUR
         DLmY49QR76xfA6qTuHlw+orKh6z9LgaoF8XKwcoheZLtqWy4hf50LhB3Y175dLvyD51N
         1b8kinNNRMYrzd29YsjkEH0/vaGSpEHZMLlVRjWdCnnnGxHLLsVEa1iTRT9se0i++rXB
         EZZw==
X-Gm-Message-State: ACgBeo1lrtlp3Qt1lrnyQ3TSSk1jsduKs1oDwaI/NHw2I0/58oNb0vjn
        9vMo8bz5eCzOEoRFx9W4t7vuBg==
X-Google-Smtp-Source: AA6agR6V7/kqXf/8L/Xvbm3d62j+WlFzi1dXmXFPqSZ+VFFXxwpHhsKCP6ElQIbfhsv4yBNPOeL4ng==
X-Received: by 2002:a05:6a00:9a5:b0:536:29e:c91d with SMTP id u37-20020a056a0009a500b00536029ec91dmr560492pfg.22.1662502854931;
        Tue, 06 Sep 2022 15:20:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:922a:25d3:a5a:7290])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902ce0900b001769e6d4fafsm6457309plg.57.2022.09.06.15.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 15:20:54 -0700 (PDT)
Date:   Tue, 6 Sep 2022 15:20:51 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 07/12] wifi: mwifiex: fix array of flexible structures
 warnings
Message-ID: <YxfHwxuwEP1rQoAU@google.com>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
 <20220904212910.2c885310ebee.If7177ea588b56c405eee6e6df595e9efccdfb99a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904212910.2c885310ebee.If7177ea588b56c405eee6e6df595e9efccdfb99a@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Sun, Sep 04, 2022 at 09:29:07PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are two, just change them to have a "u8 data[]" type
> member, and add casts where needed. No binary changes.

Hmm, what exact warning are you looking at? This one?
https://clang.llvm.org/docs/DiagnosticsReference.html#wflexible-array-extensions

It's a little hard to suggest alternatives (or understand why this is
the only/best way) if I don't know what the alleged bug/warning is.

> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/fw.h      | 4 ++--
>  drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> index 26a48d8f49be..b4f945a549f7 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -2104,7 +2104,7 @@ struct mwifiex_fw_mef_entry {
>  struct host_cmd_ds_mef_cfg {
>  	__le32 criteria;
>  	__le16 num_entries;
> -	struct mwifiex_fw_mef_entry mef_entry[];
> +	u8 mef_entry_data[];

Do you actually need this part of the change? The 'mef_entry' (or
'mef_entry_data') field is not actually used anywhere now, but I can't
tell what kind of warning is involved.

But also see the next comment:

>  } __packed;
>  
>  #define CONNECTION_TYPE_INFRA   0
> @@ -2254,7 +2254,7 @@ struct coalesce_receive_filt_rule {
>  struct host_cmd_ds_coalesce_cfg {
>  	__le16 action;
>  	__le16 num_of_rules;
> -	struct coalesce_receive_filt_rule rule[];
> +	u8 rule_data[];

These kinds of changes seem to be losing some valuable information. At a
minimum, it would be nice to leave a comment that points at the intended
struct; but ideally, we'd be able to still get the type safety from
actually using the struct, instead of relying on casts and/or u8/void.

But I don't know if that's possible, as I'm not familiar with the
compiler warning involved.

Brian
