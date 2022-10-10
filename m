Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60C05FA1B2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 18:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJJQQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJJQQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 12:16:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9805C17E04
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 09:16:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o21so25858751ejm.11
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhuRh/ONvzA6r7fnY5nYk3U9cotfhHaTKU7/9C1KW38=;
        b=FaiQ5FDDA+qS2sr9fe8Oypyn3SLwYZl9Pkc1vkIfRiSxXgBACXe5v3ndE/B61130t4
         NfToeFbEltKamOwvwlsZqfBOiT1TH0YQCelTqKkjUv/RemmFmEdC0EajN/0MGGmjKns2
         MBu9KxUGBpu42roMrEfWrKM9aWhYykOevHq1siIk5J0P3yv/bwOnh2GvRUKwfp+tjAxG
         WFjvOYLGgHkLqD44a+3oDLrDEBuO7NmPOpxKVfMzdAbRsj2xU27u8EP3+6zH3kIeQaLB
         Rsn7RhHoNhhkxc08JlFpQJyTEujavq8T2RL9RMY5CXWjJo7liPUT2jewt/Zw2nlwctpN
         Yp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhuRh/ONvzA6r7fnY5nYk3U9cotfhHaTKU7/9C1KW38=;
        b=DxYcrj2NA7l/cBV4marAGf7UmoDoROtpVoPUitpSBfYQw3AD3O7xZNZTlku8/8lf5c
         VnnyoVNpG6//mHusTS24vhuE4NOKJgmPMgfpnIpANLbufIZjRAAPDuSq35stePX6adA4
         Cx4ayNAIeLy6XJpUxNNCZ8Uf9Wjn4wSDSbmg1aoK73Xzl0f24+DuhkUNLSbF9vl4j9Wi
         zt8hUnCndmKWtayr2ezC6Dm8ncAaBNIFUJRqtJ/+WG/DQemDLbTPzXxtmaMXoKUOwBKx
         uGJ+4u9+G64FMiUXiV0r1G4c4zQJHvoDoeDISMOg564JdFgqWlxCGvaGMUYNiIffMB2o
         j1ag==
X-Gm-Message-State: ACrzQf30V4dw651X4S/aQpo8sQs4ACYEmVHZ7nQL0rGvF7ahGbs59No2
        fu18WHHY9vOpc8c22EGtNkGw0LB/eeA=
X-Google-Smtp-Source: AMsMyM47Er4rP+IFP3eJAc4/lz0AaVI4hvqufyWgJbq4+6rI61PDeZ2XYC04u/g9OoneyAfEX/Zqdw==
X-Received: by 2002:a17:907:3f90:b0:78d:afad:2a78 with SMTP id hr16-20020a1709073f9000b0078dafad2a78mr6068169ejc.68.1665418591144;
        Mon, 10 Oct 2022 09:16:31 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-002-063-205.77.2.pool.telefonica.de. [77.2.63.205])
        by smtp.googlemail.com with ESMTPSA id o29-20020a509b1d000000b00459c5c2138csm7479807edi.32.2022.10.10.09.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:16:30 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     alexander@wetzel-home.de
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: RE: [PATCH v2 2/3] wifi: mac80211: add wake_tx_queue callback to drivers
Date:   Mon, 10 Oct 2022 18:16:21 +0200
Message-Id: <20221010161621.1855515-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221009163040.25637-2-alexander@wetzel-home.de>
References: <20221009163040.25637-2-alexander@wetzel-home.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[...]
> diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
> index 07578ccc4bab..bf917ef20e3b 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac80211.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
> @@ -896,6 +896,7 @@ static void rtw_ops_sta_rc_update(struct ieee80211_hw *hw,
>  
>  const struct ieee80211_ops rtw_ops = {
>  	.tx			= rtw_ops_tx,
> +	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
>  	.wake_tx_queue		= rtw_ops_wake_tx_queue,
>  	.start			= rtw_ops_start,
>  	.stop			= rtw_ops_stop,
> diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
> index a296bfa8188f..91674c63b9f9 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac80211.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
> @@ -918,6 +918,7 @@ static int rtw89_ops_set_tid_config(struct ieee80211_hw *hw,
>  
>  const struct ieee80211_ops rtw89_ops = {
>  	.tx			= rtw89_ops_tx,
> +	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
>  	.wake_tx_queue		= rtw89_ops_wake_tx_queue,
>  	.start			= rtw89_ops_start,
>  	.stop			= rtw89_ops_stop,

For rtw88 and rtw89 the wake_tx_queue callback is now duplicated.
I'm not sure if other drivers are affected as well.


Best regards,
Martin
