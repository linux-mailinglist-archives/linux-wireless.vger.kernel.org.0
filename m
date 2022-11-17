Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B878262E554
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 20:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiKQTeE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 14:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiKQTeC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 14:34:02 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994C120187
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 11:34:01 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bj12so7575915ejb.13
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 11:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W2KBbIqicAD4XrotZUgkdwY26/S3qeOJM3Z+9kg5un8=;
        b=dEkpLMS9l0n1TPgOC898b6SlaEYQoomM4pIa447PabIpDYZ5VZrkpgONhIjA1pATXw
         sobtGOzCmYvfy5DqpGVujUwq9SxH755lKRt3zzaCL/qx9OXarr8+LYXa0Ipub1jWW0th
         Imor2qYfvqBw0fkVoJRKxpM7eeKTwt+sHPGf4AmdPGy1+GrofJxdCOca12wxeHJTE3tF
         hIZhZFjYXHMDxUtHX00mYxVrKMnVeVszIeNltG3YCwRC0fLM9EUw51TA7bTNYm3unPyK
         vIQj0KLr0xt7fvylmZmJOG+h7JC51JBxAikJ+t58xsnj7t32JFr/drheCl8dzanKoU2T
         zZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2KBbIqicAD4XrotZUgkdwY26/S3qeOJM3Z+9kg5un8=;
        b=IAXtpcA1v2sLskLk7IolceDqdKHXbWl7/WAbi+6+fSRwFlq5wKNVyuxFMnhd1zTa4y
         WOREsdQfmXtKF0G4AXSVMKWzoINneGn5eCyFxO6KD+Nt0D+Esp1JIaO4L0bTOQnBrZCs
         Cwzkrf9SZxRnI+Qhwxz8mFtkzXge1HJknutw3myl/LagMxLi+2owJ1+0tqp+/JRio3by
         fywTEpVJ1qC8ZAlfAyf6Oq58E6Z6VziYls1c2QmRTRby5xp4MfsYAEeaAI6aPHoe7yFp
         0kzLYJlt7Qx/O8qAarFUnA1VJEEh8DA9iivV6rXDycngJk3C8HT4ocezxB9HCGX14Nx7
         TDJQ==
X-Gm-Message-State: ANoB5plbMxQNxMJmQNluAqRSKFZa70QxabpATRAgMdLt+nYqA2cYITAF
        YMnbTasxrkfSrv3T5ivfq2IWZuBmYIx6aej4ACQiD0pNJ6g=
X-Google-Smtp-Source: AA0mqf7YEVXDas8VD/UZ2vK4pn5kyPf2l6+WW2QY1pk9LhA6M3szfQOUuwmc80Jdh0PVfDR3dEgTHC8skW+DCIXugsA=
X-Received: by 2002:a17:906:65c4:b0:7ad:d250:b907 with SMTP id
 z4-20020a17090665c400b007add250b907mr3216012ejn.737.1668713639349; Thu, 17
 Nov 2022 11:33:59 -0800 (PST)
MIME-Version: 1.0
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 17 Nov 2022 14:33:47 -0500
Message-ID: <CAKf6xpuJgj2TPGZsUw7JXvMkpv-wzgPq13ySzMaz0R2Ti9WQ4A@mail.gmail.com>
Subject: iwlwifi write to PCI_CFG_RETRY_TIMEOUT
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

I was looking at iwlwifi under Xen PCI passthrough and I noticed a
curious PCI config space write:

https://github.com/torvalds/linux/blob/master/drivers/net/wireless/intel/iwlwifi/pcie/drv.c#L1721
/*
* We disable the RETRY_TIMEOUT register (0x41) to keep
* PCI Tx retries from interfering with C3 CPU state.
*/
pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);

With 00:14.3 Network controller: Intel Corporation Cannon Point-LP
CNVi [Wireless-AC] (rev 30)
register 0x41 in the PCI config space is the next cap pointer for
"Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00".

On baremetal, the write seems to be dropped since `hexdump -C
/sys/bus/pci/devices/0000\:00\:14.3/config` still shows 0x80 (in my
case).  Though I suppose the device could be acting on it even if the
value doesn't change.

With Xen PCI passthrough, QEMU seems to honor emulating the write and
it breaks lspci traversing the capabilities so MSI-X is no longer
shown.

Is the write to RETRY_TIMEOUT at 0x41 correct?  It seems to be really
old.  Here it references being copied from ipw2100:

commit b572b24c578ab1be9d1fcb11d2d8244878757a66
Author: Luis R. Rodriguez <lrodriguez@atheros.com>
Date:   Thu Mar 12 18:18:51 2009 -0400

    ath9k: remove dummy PCI "retry timeout" fix

    Remove the PCI retry timeout code as that was just taken from ipw2100
    due to historical reasons but in reality its a no-op, additionally its
    simply incorrect as each PCI devices has its own custom PCI configuration
    space on PCI config space >= 0x40. Not to mention we were trying to write
    0 to a place that already has 0 on it.

That was applied, but then reverted in:

commit f0214843ba23d9bf6dc6b8ad2c6ee27b60f0322e
Author: Jouni Malinen <jouni.malinen@atheros.com>
Date:   Tue Jun 16 11:59:23 2009 +0300

    ath9k: Fix PCI FATAL interrupts by restoring RETRY_TIMEOUT disabling

    An earlier commit, 'ath9k: remove dummy PCI "retry timeout" fix', removed
    code that was documented to disable RETRY_TIMEOUT register (PCI reg
    0x41) since it was claimed to be a no-op. However, it turns out that
    there are some combinations of hosts and ath9k-supported cards for
    which this is not a no-op (reg 0x41 has value 0x80, not 0) and this
    code (or something similar) is needed. In such cases, the driver may
    be next to unusable due to very frequent PCI FATAL interrupts from the
    card.

    Reverting the earlier commit, i.e., restoring the RETRY_TIMEOUT
    disabling, seems to resolve the issue. Since the removal of this code
    was not based on any known issue and was purely a cleanup change, the
    safest option here is to just revert that commit. Should there be
    desire to clean this up in the future, the change will need to be
    tested with a more complete coverage of cards and host systems.

At least with newer devices, it seems incorrect since it is writing to
the next capability pointer.

Thanks,
Jason
