Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622047CFD77
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 17:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345790AbjJSPAq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 11:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjJSPAq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 11:00:46 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7912D115
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 08:00:44 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49d6bd3610cso3480746e0c.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697727643; x=1698332443; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nYLBdz0GRtxsyybjreIVkRbd/gaejxiHGK/KJ7qsITE=;
        b=jskIygu/H8P+iIpCmqWfchQnZSfpQR1+53dRt16AZIzOsDXY4Sz4IvErzjfZ1Hq4Pm
         2cSXvcylSWkwyEub1gIh3VtsdbuNzyeJzzMfXTtwf+yErWqAaONRBIBuJV09WAVN4v5R
         Hq512QZKbWPxEa/ms/p/1i7cQl6uIP/qUe0lGd6rY8vfsdIHA5rCsnWCvU/Tdap7wG9b
         o+0WY/toOL6wjGA2IETM1+v2/tMR3Al7RCneuIylsEY9lxmsAcwk6+1Ln3Fiiw65Aq40
         r8/WV9kIxqtqDdWnFLT3m4ZPawaXEaXNOC6yHKfCSpoDA2UD/SWQvGHFbukuXzUEnZoj
         tFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727643; x=1698332443;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYLBdz0GRtxsyybjreIVkRbd/gaejxiHGK/KJ7qsITE=;
        b=eM/j1aJm5H1P6ukhBhAMRvCntPP88MmTxRHrCP12bp0AKS7WV1L9xUQEXNRufq3jE1
         iCKXIqdc6VC8hwvdoKSrOaIoGHl75AJDq6IIxUV9SclXt2MKuEv/ATHD25LhAEFnEwbR
         wEiUb0s5SOAPvsHzC4W+OQ4nIr1TSsykITNW6SMKcZFeF5TkvlExo5ZBXnHohM8VZs04
         hnAHqmp8DQETaesXrZc9BEoKUKQbDtt+blzqg6zImUz0LvLfyIe5wCKyNao6aeBUOsDE
         /5dvoAardjK3bfk9QiuT63GKOJe7SZEBnII1FTY1HjMbGU69O3KyrUF3H7g+5O85e+LH
         lZ1Q==
X-Gm-Message-State: AOJu0Yy0tbX2RroSwrNh71opxYpjn+nhUQa2kQYYtsX1TV4rT8g2GYQj
        OMM55TxpiQ8Gig3fAybqNCWm/1wO4iEQJdH7cOHsgDygl9E=
X-Google-Smtp-Source: AGHT+IHsZ/Q8PSsYdypvJXn8lGyzGqHJwdd0fsDNpVgdDPEQCnj2vdtzfJTx1zw1OxKNaMqDYNvUegXZ1ANw/3KcaDE=
X-Received: by 2002:a05:6122:458d:b0:49a:56d2:562d with SMTP id
 de13-20020a056122458d00b0049a56d2562dmr2376820vkb.4.1697727643225; Thu, 19
 Oct 2023 08:00:43 -0700 (PDT)
MIME-Version: 1.0
From:   Jon Doe <tuksgig@gmail.com>
Date:   Thu, 19 Oct 2023 17:00:32 +0200
Message-ID: <CAMes48--xvNjYZdO1DKjfkXRv7AJcqJaWYzJ9fYSPPxQ_M7muw@mail.gmail.com>
Subject: rtw88 usb adapter can't authenticate
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have a Cudy AC1300 model WU1400 USB Wifi adapter that fails to
authenticate properly. Driver for this device is rtw88_8822bu.
Reported this previously at
https://bugzilla.redhat.com/show_bug.cgi?id=2188243 with logs of the
error messages.

Scanning works but authentication fails after 3 attempts. Any ideas?
