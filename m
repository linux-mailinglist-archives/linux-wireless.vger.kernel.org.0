Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575BA5ED06E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 00:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiI0Wug (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 18:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiI0Wue (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 18:50:34 -0400
X-Greylist: delayed 971 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 15:50:32 PDT
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0272329CBA
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=25v4d3njgQmFUNX8yL5/Bp3Safnvcd3pkxov2ZeF2z4=; b=c+g4nfmVPO2gW0ZRnVvFeNWug4
        PR3X+hM/a4j4afc7XuJ7KJKQDkwrrQX0LOoWfe9m3edLmGlAfvbHPK4Gm/SxlqB5x6GJsr0CPlXuQ
        dXbEjnYrJ5sen/wB5r8aUazZ/6Udazb2kx6gvfudDGnzid5tjdqKAUYnxjw2eL+VqRaT/OBz5foh9
        4O4NdmR7ohvJqNtenQtE/K5FPSyx1UGbViYVC6Pv8lksoWupBabCkpw1haa6YWEo3VlTVFqxNvRYA
        Y1BY3zDWiMuE625YnW0XCHE3LtqGX3Kq6N7L/rlKWIkWj7m2UO2TFR1npx0eRb3Ejp6VggadQueTq
        gkPA5TRQ==;
Received: from p200300ccff151c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff15:1c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1odJ9e-0007pZ-Fu; Wed, 28 Sep 2022 00:34:18 +0200
Date:   Wed, 28 Sep 2022 00:34:17 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     linux-firmware@kernel.org, linux-wireless@vger.kernel.org
Subject: brcmfmac nvram files best practices
Message-ID: <20220928003417.0bc3e5f1@aktux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am working on mainlining stuff for several ebook readers (esp.
kobo/tolino ones). I often find a CyberTan WC121 (BCM43362) SDIO WiFi
chip there.
That one requires a nvram file. It can be found in the vendor system
(often an ancient 3.0.35 kernel with bcmdhd driver)

So now, it would be nice to have it installed via package management.
A source for that missing file is (besides of sdcard backups of the original
system):
https://download.pageplace.de/ereader/15.3.2/OS44/update.zip 
(linked from here: https://mytolino.de/software-updates-tolino-ereader/) 
path system/lib/firmware/wc121/nvram.txt needs to be present at
/lib/firmware/brcm/brcmfmac43362-sdio.kobo,tolino-shine2hd.txt

The only problem is that I do not see a distribution license there. So
I am hesitating to just submit that one to the linux-firmware.git

Are there any best practices to deal with that situation? find any
source which also includes a license (and which hopefully allows
distribution)? or is there any way to reverse-engineer that stuff.

How were things done for the nvram.txt files already present in
linux-firmware.git?

Regards,
Andreas Kemnade
