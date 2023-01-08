Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407A7661990
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 21:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjAHUxg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 15:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjAHUxY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 15:53:24 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AD910566
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 12:53:23 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 400B52400C9
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 21:53:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1673211202; bh=8P4jxVRyRghy+zxN9wdqX++y8PNo7wZwifoPhUEa4SU=;
        h=From:To:Cc:Subject:Date:From;
        b=a5euSEBxMVPKCyLoMyT417CfkJOw/m1laDHxv91NwxQkvfcPN6IEwCuYYbE6JjQhM
         hxKYm4xR8PnnYAiEn4bQV5SivI3PIoh4HTr4sUEyDFvmkEiEQKc4LD0norBfEBKFFM
         XGjBtdj/LqOBPn5P7994dliiN9qI/YY9p4onPOijIqGDfbPZZEVqVleWGsuw8Rzzch
         7HOI2e5nIn+NV/mQo531gvFEQXeaxYB1yoT7ZRBIj6CvssWdeWZfI/kYaey0ySaICx
         rfMyyMVwcC52HU6kr4wHtTGIQmssPrlzyHf2W7qCXjekLxFh+muJXxNTjltdiaCuxg
         zF7NuI//VY+ew==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Nqq6T17wBz6tmJ;
        Sun,  8 Jan 2023 21:53:21 +0100 (CET)
From:   chainofflowers <chainofflowers@posteo.net>
To:     ian.lin@infineon.com
Cc:     Double.Lo@infineon.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/3] brcmfmac: return error when getting invalid max_flowrings
 from dongle
Date:   Sun, 08 Jan 2023 20:53:20 +0000
Message-ID: <4781984.GXAFRqVoOG@luna>
In-Reply-To: <20220929031001.9962-3-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi! This patch:
https://lore.kernel.org/all/20220929031001.9962-3-ian.lin@infineon.com/

causes my Asus PCE-AC88 (1043:86fb) to stop working, because when modprobe 
loads brcmfmac it throws this error:
---
[ 2740.647600] brcmfmac 0000:0d:00.0: brcmf_pcie_init_ringbuffers: invalid 
max_flowrings(264).
---

This is also being reported on reddit:
https://www.reddit.com/r/archlinux/comments/104pqv9/
no_wifi_since_kernel_update_yesterday/

(also, see https://forum.manjaro.org/t/brcmfmac-fails-to-load/131128)

I think that the check on value > 256 is used as a kind of red herring to 
indirectly spot an inconsistent properties report from the PCI bus (?) about 
the network card.
Before that patch, the driver was correctly working for me and I could not 
observe any kernel panic. Maybe, at least in my case, the wrong value was 
still reported but could be safely ignored, as at a later point in time, when 
the card is initialised, everything worked fine.

I am now stuck at kernel 6.1.1, if I upgrade I cannot use the card.
Is there anything I can do to circumvent this issue? May I help somehow with 
debugging & testing? Please let me know...

Thanks,


(c)





