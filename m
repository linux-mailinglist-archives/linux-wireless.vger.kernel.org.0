Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915B5366FC7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbhDUQRF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 12:17:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60092 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbhDUQRF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 12:17:05 -0400
Received: from mail-oi1-f199.google.com ([209.85.167.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1lZFWg-0002NI-KT
        for linux-wireless@vger.kernel.org; Wed, 21 Apr 2021 16:16:30 +0000
Received: by mail-oi1-f199.google.com with SMTP id h139-20020aca53910000b029018683516e74so4934889oib.0
        for <linux-wireless@vger.kernel.org>; Wed, 21 Apr 2021 09:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NmgIzF+TdTto4V1xcKQTFBB+DXxgoKnXwHwB6ybu5P4=;
        b=M1Cp2Ga7HBOwBe7Whvx7eNDoIjxCoirU3KF9iUVcBPL3hcqoT1FMP2x/oKWAtSDmeZ
         7LIVacqSINkUimHw/XexiOZY1QM61Hpd62RBDpG7wZt7TKB7ELaTxzpjVEcuBt5CcPVe
         v8K3FJT9fxRIO+ipOJ1Hlix3Qijh3M3wsTL34iXxwcJho8Oh+UrrzItFu6ntGso8qGn5
         umIJKcvBL18p3fl3FGPTL+x/nWcwAfNoP0CoJwvCbmK4cNrsWU/1Yk1n114PqTV/IwFH
         MJ0foGy2deFr0QHJ/LKZUXOMUZI7FvGfhbpBP+ckPPmalk3H86857ZFG1wyoVmCcKayM
         f2Mg==
X-Gm-Message-State: AOAM533hmy8WLgd65M7fO/SC1kuL6r4XdoqCecKlVIGVvxjjdGck4HyK
        1kNxTZKsOn4gvR74tzhue59hD3UZ+C3PGjU+12BQDU7D+2Q1mmmlszskSEFnaA8Os4tFHRUdDQe
        /CrkI9TWP7tYt6xmbAV5FWLNgQjD+INA23/Ag7nhG5cOm
X-Received: by 2002:aca:db41:: with SMTP id s62mr7307049oig.54.1619021789672;
        Wed, 21 Apr 2021 09:16:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy21eVIGxYPfIS8Y5IO80RrZ9DR488NNLWjRt4iiyK2L0czvJKgi57UJCH//IgqgHrSEWsStQ==
X-Received: by 2002:aca:db41:: with SMTP id s62mr7307043oig.54.1619021789479;
        Wed, 21 Apr 2021 09:16:29 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:c9e3:db4e:41b9:a83e])
        by smtp.gmail.com with ESMTPSA id r17sm2428oos.39.2021.04.21.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 09:16:29 -0700 (PDT)
Date:   Wed, 21 Apr 2021 11:16:28 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2021-04-21
Message-ID: <YIBP3GZr4MoVRFWo@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new release of wireless-regdb (master-2021-04-21) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2021.04.21.tar.xz

The short log of changes since the master-2020-11-20 release is below.

Thanks,
Seth

---

Illia Volochii (1):
      wireless-regdb: Update regulatory rules for Ukraine (UA)

Jose Daniel Rodriguez (1):
      wireless-regdb: Update regulatory rules for Cuba (CU) on 5GHz

Nicolas Cavallari (1):
      wireless-regdb: Do not hardcode 'sforshee' in the certificate commonName

Seth Forshee (1):
      wireless-regdb: update regulatory database based on preceding changes

Xose Vazquez Perez (2):
      wireless-regdb: update CNAF regulation url for ES
      wireless-regdb: re-add source url and info for CU

