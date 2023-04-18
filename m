Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523F66E6857
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDRPfe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDRPfd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 11:35:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB1C146C1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 08:34:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a8097c1ccfso4764025ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681832011; x=1684424011;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7waQjn0dFezrtwoMkFB3dJImWqJFWoEG26r8Ijc3Lmg=;
        b=XiQHLjaFEJQ8oGa7gJBhPWRrNFz9c6apJkr3OKq+rf0LAQ1RGncDEnYgg2MeG9nL9H
         xnb3xjbKjMEdsXclOdjNRJYTl1RRtppEwj82Cz+Of7dw2G5MkNgXs1kLD418E3oSFk3D
         xgpDwYBH6rRSyOc2AMBQQxGlDFF/WnQjKiGMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832011; x=1684424011;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7waQjn0dFezrtwoMkFB3dJImWqJFWoEG26r8Ijc3Lmg=;
        b=foP/YRnCUBKHps52w78+Dr+bTKV28SvJOzf8ci7L3wBkFoJ1T+VQHvKjMrFv5SJ1uD
         0bm49lZud5+xqagU337AWC0iI/r4OLKW43Mf1TV2p3MZyfrKzKo+PKv4PtTJGJo+aJy1
         nRM0B1f91rBj0krUM008L9EWLYHMhFu1AFLaswiNkrdORsw7wXfGALVHLSGNQDex9vdd
         B2S+uW3AxQ3GsWPZg5TdXRlyUzbCcGT0+E0Nl3WAJpLOlEC/Egk6j+GvJd9aHeFn7x1b
         hVklvrUyORf6MROirwp/OWoI1Te2YMkjS/oLbOBVULe/QJxIvcqNjxzuzi9zdBS/kvPS
         6a3A==
X-Gm-Message-State: AAQBX9cZGI4PQL/dmqbWD26M7KbDvA+mHgcTH3sL87ZiTNllX/V4T4M9
        yZXZ7rfSTiAUK2BNsFoc/lVMlA==
X-Google-Smtp-Source: AKy350YYkDxy6Ul+K8ToP656n3fhS1UKjFR9fDLvzmTPo0m74chPrLwjWNmUXju1FndAsysQXa6RYA==
X-Received: by 2002:a17:902:db08:b0:1a6:8405:f709 with SMTP id m8-20020a170902db0800b001a68405f709mr3026652plx.20.1681832011468;
        Tue, 18 Apr 2023 08:33:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jd18-20020a170903261200b001a19f3a661esm9747507plb.138.2023.04.18.08.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:33:31 -0700 (PDT)
Message-ID: <643eb84b.170a0220.30557.565c@mx.google.com>
X-Google-Original-Message-ID: <202304180833.@keescook>
Date:   Tue, 18 Apr 2023 08:33:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning
 write backtrace
References: <20230418132546.45297-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418132546.45297-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 18, 2023 at 03:25:46PM +0200, Hans de Goede wrote:
> A received TKIP key may be up to 32 bytes because it may contain
> MIC rx/tx keys too. These are not used by iwl and copying these
> over overflows the iwl_keyinfo.key field.
> 
> Add a check to not copy more data to iwl_keyinfo.key then will fit.
> 
> This fixes backtraces like this one:
> 
>  memcpy: detected field-spanning write (size 32) of single field "sta_cmd.key.key" at drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1103 (size 16)
>  WARNING: CPU: 1 PID: 946 at drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1103 iwlagn_send_sta_key+0x375/0x390 [iwldvm]
>  <snip>
>  Hardware name: Dell Inc. Latitude E6430/0H3MT5, BIOS A21 05/08/2017
>  RIP: 0010:iwlagn_send_sta_key+0x375/0x390 [iwldvm]
>  <snip>
>  Call Trace:
>   <TASK>
>   iwl_set_dynamic_key+0x1f0/0x220 [iwldvm]
>   iwlagn_mac_set_key+0x1e4/0x280 [iwldvm]
>   drv_set_key+0xa4/0x1b0 [mac80211]
>   ieee80211_key_enable_hw_accel+0xa8/0x2d0 [mac80211]
>   ieee80211_key_replace+0x22d/0x8e0 [mac80211]
>  <snip>
> 
> Link: https://www.alionet.org/index.php?topic=1469.0
> Link: https://lore.kernel.org/linux-wireless/20230218191056.never.374-kees@kernel.org/
> Link: https://lore.kernel.org/linux-wireless/68760035-7f75-1b23-e355-bfb758a87d83@redhat.com/
> Cc: Kees Cook <keescook@chromium.org>
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks for chasing this down -- I hadn't had time to come back around to
it.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
