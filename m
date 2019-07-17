Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7661E6C18F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2019 21:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfGQTfj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jul 2019 15:35:39 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:45687 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQTfj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jul 2019 15:35:39 -0400
Received: by mail-pf1-f180.google.com with SMTP id r1so11321965pfq.12
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2019 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:mime-version:message-id
         :content-transfer-encoding;
        bh=1QT9kN4bsH9rk5w9LTPpsn3BYIOXjoxSSNLc4rUIQPI=;
        b=NXJW/zEFfftcckuXnd4iHpYfDhZTNXHaPo1VsbA6JFEJWRhE2jHYLumdxd2UNajlAi
         ZS+LbBWaz2kdBePO1w9ciVQKU46CX2cpCq9R0UXnoGD4c0JTWNqpcVTBB1nUS+SOKHiV
         ijhngDDV170q944+dS86d+q5+XEUMfbEz2ESU26RfLSJaSf/qO2kyFWf1yJoC3C6N0cT
         p1DagezRgu0AIDlQtUNzHaQb2vF3dE0W8neajPciYE1c9ZSm3KCzVMe6ZyB9IkVJo7rT
         X8NzrOcujoaDX9J3HnE+0EaIcUgJKnE+0ifvKmeIwYqsx93HwznuQr9dbmPqv1wO0PS0
         R+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:mime-version:message-id
         :content-transfer-encoding;
        bh=1QT9kN4bsH9rk5w9LTPpsn3BYIOXjoxSSNLc4rUIQPI=;
        b=omnXQgTgB8zm8SMseNjdJKRiBF89ZGKP+0xrLyopJ90TpuuRNo2DUoQdcRg5i9hPbs
         cvypJF5PHiUy32LZBHMP2eDwHYCWWywRM6OP2BneWw2UHvGtvRYUaosyjjBQTqJ1aYrI
         mNhF6MMyf9NdavapdqVBosd47kbXQsaroKF9Tn4urQnhjTjIaiFyOk1eBlFwJVXDCRaK
         1MNozWBoHzziUE9Q5dB2s/DHHt9fUENG2GAfs5BbTT19DodjQx1KIoFXNfXsMG0T4Rbb
         fQyaVA1l3HoF+oFSV3RW+8Kw6PZ1AERFrbTulPcyfbWbkgJKN4pqrlHKHLpDKxAKLkw9
         dGog==
X-Gm-Message-State: APjAAAWtA4QM0uJCUUo7NPbAfJcZTIv4iOojrdwjCoXivUKKH5dSxXoj
        JN7W/i4YZLdl4zKILwDqBbGalMXSMHI=
X-Google-Smtp-Source: APXvYqzK0IMGDRzEIvVZl18yfAwEpNvRUmUQW5NcaNTmcjcsfWxuirglfOQN1drZYRjZ2Q3MPj8mww==
X-Received: by 2002:a65:6904:: with SMTP id s4mr38672491pgq.33.1563392137713;
        Wed, 17 Jul 2019 12:35:37 -0700 (PDT)
Received: from ZERO ([43.245.198.158])
        by smtp.gmail.com with ESMTPSA id u134sm23488552pfc.19.2019.07.17.12.35.35
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 12:35:37 -0700 (PDT)
Date:   Thu, 18 Jul 2019 03:35:37 +0800
From:   "mysecrct@gmail.com" <mysecrct@gmail.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RTL8191Su don't switch monitor!
X-Priority: 3
X-GUID: CBB1BECF-070B-425D-B9BB-B1AB6FCB038C
X-Has-Attach: no
X-Mailer: Foxmail 7.2.11.303[cn]
Mime-Version: 1.0
Message-ID: <2019071803353417290810@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wqAgwqAgRGVhciAhCgoKCsKgIMKgwqDCoCDCoCBSVEw4MTkxU3Ugd29ya2VkIG9uIEFyY2hMaW51
eCwgbGludXggNS4yLjAKCgoKwqAgwqDCoMKgIMKgwqBOb3JtYWwgdXNlIG9mIGNvbm5lY3Rpbmcg
d2lmaSBpcyBubyBwcm9ibGVtLiBCdXQgSSB3YW50IHRvIHN3aXRjaCBpdCB0byBwcm9taXNjdW91
cyBtb2RlLCBjYW4ndCBzd2l0Y2guCkkgd2FudCB0byBhc2sgaWYgdGhlcmUgd2lsbCBiZSBhbiB1
cGRhdGUgdG8gc29sdmUgdGhpcyBwcm9ibGVtPwoKCsKgIMKgIMKgIMKgwqBNeSBFbmdsaXNoIGlz
IG5vdCBnb29kLCBzbyBwbGVhc2UgYmUgc29ycnkgZm9yIHRoZSBpbXBvbGl0ZW5lc3MuCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqAKCgrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFRoYW5rIHlvdSE=

