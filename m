Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68D0527C52
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 05:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiEPDZt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 May 2022 23:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbiEPDZk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 May 2022 23:25:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800251C91E
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 20:25:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o22so15688949ljp.8
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTb+0fH6xwh52af2Ognq9gCoUohS2TbZEntfebl88fk=;
        b=cyD9JFpY5Z3k6H03vJq6Mn9BORJdehXiCRCdmQNwV8xREPt4+33fT7l9OR/iop8i2/
         ToLqXPiiJQ0xQABZ1LvX8bCKqYd4eCZjVC0pLrccYgBfEzwH7un6sn5EXcmRKh3QpLuD
         ZEpg47ns5yXyKJwKkcrSLpgQCJQ1iM+Eo3kmHxDSwT4ge54xz3A3t87zlXMWeDIov2T1
         /AiqC4DaC6Nupy1k1DfOdhxLu1/cpbPxSuDhidBr+qaoHkDitZalXEPui03XFBnDYGxk
         FCZmAwmDWSFpMNoO0VIUPvNAumaHtsjTMVuFwOBNI+kEHwaPYT4tmkorQpOfZcCFniiT
         FyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTb+0fH6xwh52af2Ognq9gCoUohS2TbZEntfebl88fk=;
        b=CL/0GzIaT+z58gf9QkD7743AyUiF+BGV313XIoeDRFenecW84rtaKuz4LHX/ApyRSY
         y90wMAISDvjZOzMSLu2etVFS/WWvykSuQeq93WTNB/fBBt4TRLNZRXkr7KFV/6GIZy0l
         J5iHGKKAczkVVjO4fd5vIfA1tJBoC89FCW4L5t5vP6VH7WD4toi2AoVz0PoGwiXxr4uM
         sJJhDS5YeMsuQKiVgM0B69/KVYeETkNPe3s7AloFiVZxW9UqLFAJseSjYGnOeT49fmjL
         OsVGACKW068V8E5lsYsJ2OvEUtNb7WSU+WFi/W/NhQEaO3IsOpfFtG1ihv/8fRCfEIAR
         iH7A==
X-Gm-Message-State: AOAM530LI/e3ZHcoInrMcvOgN7vS2MwYDdJ5FU1Ij4B08wkwXlcRaL0X
        PFwIRBf+C2T1XDFhbDUqd78=
X-Google-Smtp-Source: ABdhPJxXGOycHqCQErj4YXorjs6Fj9NBYcnL8HljJN4ShAZGcVjI7LhAGsOs9gVbB5miDlchhjMcxQ==
X-Received: by 2002:a2e:9e43:0:b0:24b:3c6:3832 with SMTP id g3-20020a2e9e43000000b0024b03c63832mr9868446ljk.63.1652671536665;
        Sun, 15 May 2022 20:25:36 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id q18-20020a2e9152000000b0024f3d1daee5sm1337251ljg.109.2022.05.15.20.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 20:25:36 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Edward Matijevic <motolav@gmail.com>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?q?Old=C5=99ich=20Jedli=C4=8Dka?= <oldium.pro@gmail.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Zhijun You <hujy652@gmail.com>
Subject: [PATCH 0/4] ath10k: add encapsulation offloading support
Date:   Mon, 16 May 2022 06:25:15 +0300
Message-Id: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

this series introduces driver support for hardware encapsulation
offloading feature.

The main goal of the series is an overall improvement of system
performance. On a QCA9563+QCA9888-based access point in bridged mode,
encapsulation offloading increases TCP 16-streams DL throughput from
365 to 396 mbps (+8%) and UDP DL throughput from 436 to 483 mbps (+11%).

The series consist of four patches, the first three prepare the code,
and the last one introduces the offloading support itself. The first
patch reworks transmission status reporting to make it flexible enough
to support 802.11 and Ethernet encapsulated frames reporting. The second
patch reworks improves Ethernet encapsulated frames handling in the HTT
Tx layer. The third patch reworks the module parameter that configures
the main encapsulation format of frames that are passed from the driver
to the hardware. It makes it possible to configure more encapsulation
methods than just raw or not-raw. And, as stated before, the fourth
patch actually introduces offloading support. It changes a couple of
frame analysis places along the xmit path and starts reporting
offloading support to mac80211 via the corresponding hw attribute.

The new feature has been extensively tested with QCA9888. It works well
and introduces a measurable performance increase on platforms with not
so fast CPU (e.g. QCA9563). Tests with MT7621+QCA6174 show no
regression. I was unable to observe any measurable throughput increase
in tests with QCA6174 due to the poor perfomance the SISO client and OTA
testing. Only slight downlink rate stability increase with slight
reducing of the SIRQ load on the AP side.

Tests with QCA9880, QCA9980, QCA9984, QCA9377 revealed no regression
[1]. No specific throughput tests have been performed. In OTA tests with
a regular load, there is a slight increase in througput stability.

In tests of the QCA9377 in Sta mode, Edward Matijevic noticed a possible
regression in the Ethernet tx mode compared to the Native WiFi tx
mode:
> There might be a regression in download bandwidth under ETHERNET mode
> but I didn't do enough tests to see if was my PC or the adapter as the
> upload bandwidth was similar to other tests.
> NATIVE_WIFI performs the same as without the patch.

Credits: thanks to OpenWrt folks Oldřich Jedlička
<oldium.pro@gmail.com> and Edward Matijevic <motolav@gmail.com> who
helped me a lot to perform extensive testing with various chips after a
RFC/RFT post in the OpenWrt development mailing list [1]. Thanks to
Zhijun You <hujy652@gmail.com> who helped with the testing, pointed me
to the previous work (see below) and the missed parts in the HTT Tx
layer [1].

Prior work: similar patches were independently developed by QCA and then
submitted for inclusion by John Crispin <john@phrozen.org> [2] and
latter by Zhijun You <hujy652@gmail.com> [3]. The work was not merged
due to the lack of a part for 64-bits descriptors [4]. The idea of HTT
Tx layer change from this work was adopted for the series in patch #2.

1. https://www.mail-archive.com/openwrt-devel@lists.openwrt.org/msg62013.html
2. https://lore.kernel.org/all/20191216092207.31032-1-john@phrozen.org/
3. https://lore.kernel.org/all/20210524103130.66693-1-hujy652@gmail.com/
4. https://patchwork.kernel.org/project/linux-wireless/patch/20191216092207.31032-1-john@phrozen.org/

CC: Edward Matijevic <motolav@gmail.com>
CC: John Crispin <john@phrozen.org>
CC: Oldřich Jedlička <oldium.pro@gmail.com>
CC: Tom Psyborg <pozega.tomislav@gmail.com>
CC: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
CC: Zhijun You <hujy652@gmail.com>

Changes since RFC:
 * new Tested-on and Tested-by tags
 * new patch #2 for better Ethernet encapsulation support in the HTT Tx
   layer
 * rebased on top of latest ath-next

Sergey Ryazanov (3):
  ath10k: improve tx status reporting
  ath10k: htt_tx: do not interpret Eth frames as WiFi
  ath10k: turn rawmode into frame_mode
  ath10k: add encapsulation offloading support

 drivers/net/wireless/ath/ath10k/core.c   | 11 ++--
 drivers/net/wireless/ath/ath10k/core.h   |  1 +
 drivers/net/wireless/ath/ath10k/htt_tx.c | 61 ++++++++++++---------
 drivers/net/wireless/ath/ath10k/mac.c    | 67 +++++++++++++++++++-----
 drivers/net/wireless/ath/ath10k/txrx.c   | 12 ++++-
 5 files changed, 108 insertions(+), 44 deletions(-)

-- 
2.35.1

