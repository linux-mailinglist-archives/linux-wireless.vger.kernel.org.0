Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2EA7A62FC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 14:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjISMbd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 08:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISMbc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 08:31:32 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE016F4
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 05:31:26 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c0c675cb03so3924317a34.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695126686; x=1695731486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mzxRe4ddIChTt1Pkh7gP6Z3M3cc1YUTNoEMJ6jpC8lg=;
        b=TsdIn6snEH++U82oM/8TLSD/gWhjz2HZNxv70511TtQ3uyujLNLtVFuxA1jdiymyOW
         a4EXWBVNuhh5QKVkARaEJM43i8IzETq0gtTvYewqyJ1crn4/goWPn7YK/8cDXa9rXFRV
         NJd46lCTMhbu8HvylzNBb9rPnNVK0bWUbQRRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126686; x=1695731486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzxRe4ddIChTt1Pkh7gP6Z3M3cc1YUTNoEMJ6jpC8lg=;
        b=uqs0ni/ojB6D9GeHAf0eBzmztvETy8nFzxxSGAhHlI/4l8aX5KPTPsXmFNfhKuetmp
         LU1doIroFmm2E/N9WSFvor5X9RqFf7+yLUlYapJBsPwbXh5C49xc9LAQzcftbOx2+IMx
         EP3XQz4bBPrwi/UO+kMriYslgKKqpr3l0jxjR2RksoF5iy8JBbfd5ClBFDncdOH+dwYR
         LbQGCJxpVddo8okEZMgt9TrZvCcNxlDyYTrD/t+VE7DaRrE+ur6ui5AJku+/JWG28Rj3
         IIfcP6DfrHB4WZS6k8uBdtlqRUxeBDBWb12xBKLzI9/HKuTPX1D/JWnrvdDvZNnT7EBk
         kU9A==
X-Gm-Message-State: AOJu0Yzuhn3RlhHmw0lqWjqVIfIwR5huVYDn4lDDlmLD+Y6MCaNC2HAw
        PqT//M1zmRS9Pfbfzr0BJ1Ar6Jxu6pYJzK89DSFI7g==
X-Google-Smtp-Source: AGHT+IFhzR4yaizcV2SGxVqQtHNxts0kTOB0pDEuZXWa0DdZF1YoACVbLs29DNJ3sO0u1g7k5QY55ONDq5ZG+qDDdrQ=
X-Received: by 2002:a9d:69d7:0:b0:6be:fdab:dc59 with SMTP id
 v23-20020a9d69d7000000b006befdabdc59mr10806957oto.20.1695126686121; Tue, 19
 Sep 2023 05:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230908104308.1546501-1-treapking@chromium.org> <169504317624.617522.1000616001928521648.kvalo@kernel.org>
In-Reply-To: <169504317624.617522.1000616001928521648.kvalo@kernel.org>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Tue, 19 Sep 2023 14:31:15 +0200
Message-ID: <CABRiz0o9a54+Vq=MKCxu3kXQyKw8jEPjixz14AU6jkY6tcmAig@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry, my mistake, I was unaware.
