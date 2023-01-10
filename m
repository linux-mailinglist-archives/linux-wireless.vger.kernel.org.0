Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5561664CE1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 20:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjAJT5k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 14:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjAJT5j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 14:57:39 -0500
X-Greylist: delayed 995 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 11:57:36 PST
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E18D56
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 11:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Type:Message-ID:Subject:Cc:To:From:Date
        :Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        In-Reply-To:References; bh=UVE4zfkA3qmQHDLZ5T/urzcdkQ22ivqIjkk4IKD9X/g=; b=h1
        gIJFLbT+8rMNNGzX0plPxlBj0bsQv7o389xk28acN7EfpK24SiROt4ZseThQn/Em2SKAiMfRlNOnp
        YDoftY4Rwg3qQXmQ5gSdpCF7L4CXEMgTaC47osLkTXHP2JFROABD2h6Pz4rfCJlME5SGfhRi5sQ1u
        IbxqYc4uFmQL6jvXYP1+pGAC0nF0XPPCx3ivQe8iD9Di2bcf5WqNI4hbUgIz60xivH+R8Qq/3W0ne
        p17WEglIxdXb7wM6iXpcpB3bqsJxI5d+1f2z3tLxRTNx9ilmI1GO2rPI+ZWY+LcUp13xU1fXnlI5a
        krqRWlhMzXh496gduD9Do35bJHCMp8aA==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pFKUV-0001aS-17;
        Tue, 10 Jan 2023 19:40:59 +0000
Date:   Tue, 10 Jan 2023 19:40:57 +0000
From:   John Keeping <john@metanate.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-firmware@kernel.org
Subject: brcm: brcmfmac4339 firmware in linux-firmware
Message-ID: <Y72/Sd/8mMOx13lk@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend & all,

In linux-firmware, commit 0707b2f ("brcm: add/update firmware files for
brcmfmac driver") adds brcm/brcmfmac4339-sdio.bin with version:

	Firmware: BCM4339/2 wl0: Feb 17 2016 18:29:33 version 6.37.32.RC23.34.42 (r608406)

This restores the version previously removed by commit 0f0aefd ("brcm:
remove old brcm firmwares that have newer cypress variants").

That was a follow-up to commit 04f71fe ("cypress: add Cypress firmware
and clm_blob files") which provides cypress/cyfmac4339-sdio.bin and
links it (via WHENCE) to brcm/brcmfmac4339-sdio.bin and has version:

	Firmware: BCM4339/2 wl0: Sep  5 2019 11:05:52 version 6.37.39.113 (r722271 CY)


It looks like the same also applies to a few other firmware, although I
don't have the hardware to check the relevant versions there.

Should part of 0707b2f ("brcm: add/update firmware files for brcmfmac
driver") be reverted in favour of the files in cypress/?  (It looks like
these will already be used due to the order of the file so the symlinks
to cypress/... will overwrite files installed from brcm/...)


Thanks,
John
