Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B151BE978
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 23:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD2VCh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 17:02:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47285 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2VCg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 17:02:36 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jTtqk-0007Aw-GL
        for linux-wireless@vger.kernel.org; Wed, 29 Apr 2020 21:02:34 +0000
Received: by mail-qt1-f198.google.com with SMTP id g55so4315312qtk.14
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 14:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7oPQ9scrGXXGykacyzkITecwN5KdSuAdBqeFgJorjy0=;
        b=gHzcaAsXnY695VPW6NWjiEgxsjDEgVsj+29ya4XuYXMsNjPOB//96y7fQ2RcCPsdbX
         lITgS8tVwSecB+6Wy3jbtAJXxGSsru/AzpoBiEDSCegaegRaY0InIx0z4FHmn8GhuHeE
         /plmew9mvBFLC5qI7UkZIyhGyBx4rUKqqCoW2vpntTAdILxvY5d4zR7dEQ9MrNRhmCyb
         sONPuYR9twUkBXecJog42LZSOxahr7hi8aIbY10j73LF0FpcWkE/MdXsO+jX6AqUSfJ9
         aEKdsAjJU2rFjwiPvkAvI7GJHuMeHakdJtNCPn+nZGDc/s/Vjpu5WmVATX/M4aeLg1Nz
         kk9Q==
X-Gm-Message-State: AGi0PuaWrDBzp10Xwtc45byTAIlIFSGoiv8BgePNPlKCZGNKutGhMvmA
        E1piGdCHkJAynBDIlzcE3TPpz6nLLOzfGQgSPYUZLn587sl/xnpJ8tLYb7Rq8GYm+RybMy/cHFk
        fzGWJdzS1QeEEuBONazo6LZGpFnUyv1swcG0v//4snc9D
X-Received: by 2002:a0c:9aea:: with SMTP id k42mr35070329qvf.91.1588194153196;
        Wed, 29 Apr 2020 14:02:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypIKWn5awc7m46u06oStV9MPuT9rwNaegrOAIOwKsGwNApquqZMbIxiB3WElt8+7n16lcwY7kQ==
X-Received: by 2002:a0c:9aea:: with SMTP id k42mr35070298qvf.91.1588194152872;
        Wed, 29 Apr 2020 14:02:32 -0700 (PDT)
Received: from localhost ([2605:a601:af9b:a120:186b:951e:b8b7:3863])
        by smtp.gmail.com with ESMTPSA id x7sm252425qkx.36.2020.04.29.14.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:02:32 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2020-04-29
Date:   Wed, 29 Apr 2020 16:02:31 -0500
Message-Id: <20200429210231.212762-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new release of wireless-regdb (master-2020-04-29) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2020.04.29.tar.xz

The short log of changes since the master-2019-06-03 release is below.

Thanks,
Seth

---

Andrew Yong (1):
      wireless-regdb: Update regulatory rules for Singapore (SG)

Chaitanya Tata (1):
      GB: Extend to cover DMG channels 5 & 6

Chen-Yu Tsai (1):
      wireless-regdb: Extend 5470-5725 MHz range to 5730 MHz for Taiwan (TW)

Dmitry Tunin (1):
      wireless-regdb: Update regulatory rules for Russia (RU)

Emil Petersky (2):
      wireless-regdb: Fix ranges of EU countries as they are harmonized since 2014
      wireless-regdb: Harmonize ranges of CEPT countries (stand of July 2019)

Johannes Berg (1):
      regdb: fix compatibility with python2

Martin Willi (1):
      wireless-regdb: Fix overlapping ranges for Switzerland and Liechtenstein

Seth Forshee (2):
      wireless-regdb: Update regulatory rules for Indonesia (ID)
      wireless-regdb: update regulatory database based on preceding changes

bkil (1):
      wireless-regdb: update rules for US on 2.4/5G

