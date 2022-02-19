Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E634BC433
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Feb 2022 02:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbiBSBFB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Feb 2022 20:05:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiBSBFA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Feb 2022 20:05:00 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D958340A0C
        for <linux-wireless@vger.kernel.org>; Fri, 18 Feb 2022 17:04:42 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so5620196ooi.7
        for <linux-wireless@vger.kernel.org>; Fri, 18 Feb 2022 17:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forshee.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hb9uPQRZFUvtjPZXgWgmnBACKAgTl63xKrKFVS6IXIg=;
        b=FlfzBv0phxL6+WOILIfpkjS7z/VYi9wS0grfY7i9rsU5+kSuUAttkqwqD4Yy99ttX2
         Ug/uU1OKMH6ZSSZrYv2zlxdLvCFkDlNX4Bl5GaNV5mdilw7zE0Yv4FTRilxn4DeQR15S
         YwMvbRUZ7VZeRNtikmvExMAZ/eIbauU929VjlDhbrkefDegAgSXJeFJnMSY+MFAk4B/3
         Hp6KDh+WUdtJPetZ6H7YXV0p+ffwMRvRNO6QBbPYrwT3pP/osj/4Pxb6av9MQPsmNG82
         ET5rDCeeIkbqb0DzsvcVZPwAp1mYRKo/wRBK0So8V6DDqQ6zJrVCBKJ6AqqIzC0Afbt7
         LF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hb9uPQRZFUvtjPZXgWgmnBACKAgTl63xKrKFVS6IXIg=;
        b=lCUv8WQh+NTxjeqlqBoEBL84QrTIMaGEaIWsz4x4NY6x7gxShs4OWohn3MrOVbVRGX
         fVoMioCTz8PuhMhxNUWxOpuH42gXjSKHjgmtNxycFBUNylhVzxGgD7l0PyHzM86GX8sn
         YamOff4Da0JjFF9VA9nRNgjNLQzfmhbSMaZbZPG1oPtSLCQYDWZwerxRVtWP+4wLWynU
         ePnjK9aVdtx6AuNqegdrTJiJTgKHu3Vqr0k3TSk/FzpFNnbf0AcyKtUD9IrUah291sgs
         a6jw5oGqMbGiAjB3rAE2Amo9t5szFkhmykPiYojNfmHH3cla0flidK/N6b/VNO6nq6me
         MQ3A==
X-Gm-Message-State: AOAM530LpEk1wDp+V9x/NKhte6OuD3G3qzrsHxIlyw5DFQNvRA199PMS
        6wTd6D3Am/R/p+wmIpjpqNa4eoBbIjoOmq1W
X-Google-Smtp-Source: ABdhPJyoLgb2G5jm6AmSLiXrS93Zrh/pX8QbI58sCzqUKPTbHadOJ8spmCzaPf4SPZ/7m1xXZa8kHg==
X-Received: by 2002:a05:6870:5d88:b0:d3:112c:3e2e with SMTP id fu8-20020a0568705d8800b000d3112c3e2emr3853813oab.230.1645232682237;
        Fri, 18 Feb 2022 17:04:42 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:7887:5219:b932:e578])
        by smtp.gmail.com with ESMTPSA id f38sm318766otf.22.2022.02.18.17.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 17:04:41 -0800 (PST)
Date:   Fri, 18 Feb 2022 19:04:41 -0600
From:   Seth Forshee <seth@forshee.me>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2022-02-18
Message-ID: <YhBCKWNw3IMfGs0L@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new release of wireless-regdb (master-2022-02-18) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2022.02.18.tar.xz

The short log of changes since the master-2021-08-28 release is below.

Thanks,
Seth

---

Jiaxun Yang (1):
      wireless-regdb: Update regulatory rules for China (CN)

Robert Marko (1):
      wireless-regdb: Update regulatory rules for Croatia (HR) on 6GHz

Romain Izard (1):
      wireless-regdb: Update regulatory rules for France (FR) on 6 and 60 GHz

Seth Forshee (2):
      Revert "wireless-regdb: Update regulatory rules for South Korea (KR)"
      wireless-regdb: update regulatory database based on preceding changes

Sultan Alsawaf (1):
      wireless-regdb: Raise DFS TX power limit to 250 mW (24 dBm) for the US

Sungbo Eo (2):
      wireless-regdb: Update regulatory rules for South Korea (KR)
      wireless-regdb: Update regulatory rules for South Korea (KR)

Thomas Pedersen (2):
      wireless-regdb: add support for US S1G channels
      wireless-regdb: add 802.11ah bands to world regulatory domain

Wilco Baan Hofman (1):
      wireless-regdb: Update regulatory rules for the Netherlands (NL) on 6GHz

Xose Vazquez Perez (1):
      wireless-regdb: Update regulatory rules for Spain (ES) on 6GHz
