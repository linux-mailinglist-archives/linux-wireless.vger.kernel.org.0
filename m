Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE8521DF34
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2020 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgGMRzt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jul 2020 13:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbgGMRzt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jul 2020 13:55:49 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EACC061755
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2020 10:55:48 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so14501558edy.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2020 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K/ddZoCsCwB2wwV0UgCmlCLZKzfFvd1nmRbZaPYXWkc=;
        b=snkqD9nyX5aZSQcBv4/1/37+vMl2JADF9f0a0bEsrSxfoni2DWkg7dygA2ePUiY79A
         HuMeQbTroW6bc7V7zujoUXBXH6LegoEgLDwLgrF6grDW0awEqR02qB+FqfGBpylTxYPV
         Acj48pdcAgi6Xs7CwsWiPLd4qdfaBMWWqowfUu1MvkyVVM57UVKO2EVxiYpv5L5Z6wmx
         Qjy6gyl8Qj/yQGxBZaP+kcRIziU14V1Zfff+GVQWo1tyRidgRMvZ6aPCk7+xYPYWU26O
         XtDdnjKsCQdW1iIFEIhPXQcf7KbQUxnol3D3MZeDoOvcMdh4ygaPuHWh2nOGZdWLINwX
         Ccog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K/ddZoCsCwB2wwV0UgCmlCLZKzfFvd1nmRbZaPYXWkc=;
        b=gpDwq6xELh9Q1DQ3WdR/jr9S0YNER5idDOGuZw70RK59shOKJoxhjAwQKCvEX7eT8m
         yOSx7UcFKmZfSw5+wQBHDg7QdyRqoBmoiYOU5gswQ6xDVBoUZW2d6xw/Wci4XIlbTibw
         /kYHmpY4FkcwLuvJC4ejfM++L4SJ2H4d5lEFqAqJMragZ66/gg1epg5rHwLgI2vj4bK5
         GXDoa+v2cu6X+QKx2EwRaGlANktx81zuijtKevFZjGDqEnVuBez4NPBKfBGQE/HvZOPN
         OqN9Vu7LaCr/UR66bZDKrP3qs1GOnAubXq20CgstQGtJ8QzC8tir0GTSpIveFut6/rNp
         NWpA==
X-Gm-Message-State: AOAM5329R0Gt2LUzTeuF/yrjO78+mpeMUlW8fxc9Aq+77Sb/Fj7ihUsT
        Te90OdvMtT0EKUaa7AV7WKH3Stg1Wol3rw==
X-Google-Smtp-Source: ABdhPJz9t7FP9rAhGHfOeSYSLc/ECVrMdLaLGNUF5EM1HQqq77GV62SivKpe/M3n4tNdf12CP9MHVQ==
X-Received: by 2002:aa7:d58c:: with SMTP id r12mr612223edq.160.1594662946795;
        Mon, 13 Jul 2020 10:55:46 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id a25sm11908762eds.77.2020.07.13.10.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:55:46 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Date:   Mon, 13 Jul 2020 20:55:59 +0200
Message-Id: <20200713185559.31967-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This goal of these series is to move the definition of *all* PCIBIOS* from
include/linux/pci.h to arch/x86 and limit their use within there.
All other tree specific definition will be left for intact. Maybe they can
be renamed.

PCIBIOS* is an x86 concept as defined by the PCI spec. The returned error
codes of PCIBIOS* are positive values and this introduces some complexities
which other archs need not incur.

PLAN:

1.   [PATCH v0 1-36] Replace all PCIBIOS_SUCCESSFUL with 0

2a.  Audit all functions returning PCIBIOS_* error values directly or
     indirectly and prevent possible bug coming in (2b)

2b.  Make all functions returning PCIBIOS_* error values call 
     pcibios_err_to_errno(). *This will change their behaviour, for good.*

3.   Clone a pcibios_err_to_errno() into arch/x86/pci/pcbios.c as _v2.
     This handles the positive error codes directly and will not use any
     PCIBIOS* definitions. So calls to it have no outside dependence.

4.   Make all x86 codes that needs to convert to -E* values call the 
     cloned version - pcibios_err_to_errno_v2()

5.   Assign PCIBIOS_* errors values directly to generic -E* errors

6.   Refactor pcibios_err_to_errno() and mark it deprecated

7.   Replace all calls to pcibios_err_to_errno() with the proper -E* value
     or 0.

8.   Remove all PCIBIOS* definitions in include/linux/pci.h and 
     pcibios_err_to_errno() too.

9.   Redefine all PCIBIOS* definitions with original values inside 
     arch/x86/pci/pcbios.c

10.  Redefine pcibios_err_to_errno() inside arch/x86/pci/pcbios.c

11.  Replace pcibios_err_to_errno_v2() calls with pcibios_err_to_errno()

12.  Remove pcibios_err_to_errno_v2()

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Suggested-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>


Bolarinwa Olayemi Saheed (35):
  Change PCIBIOS_SUCCESSFUL to 0
  Change PCIBIOS_SUCCESSFUL to 0
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Fix Style ERROR: assignment in if condition
  Change PCIBIOS_SUCCESSFUL to 0
  Change PCIBIOS_SUCCESSFUL to 0
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Change PCIBIOS_SUCCESSFUL to 0
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks
  Change PCIBIOS_SUCCESSFUL to 0
  Tidy Success/Failure checks

 arch/alpha/kernel/core_apecs.c                |  4 +--
 arch/alpha/kernel/core_cia.c                  |  4 +--
 arch/alpha/kernel/core_irongate.c             |  4 +--
 arch/alpha/kernel/core_lca.c                  |  4 +--
 arch/alpha/kernel/core_marvel.c               |  4 +--
 arch/alpha/kernel/core_mcpcia.c               |  4 +--
 arch/alpha/kernel/core_polaris.c              |  4 +--
 arch/alpha/kernel/core_t2.c                   |  4 +--
 arch/alpha/kernel/core_titan.c                |  4 +--
 arch/alpha/kernel/core_tsunami.c              |  4 +--
 arch/alpha/kernel/core_wildfire.c             |  4 +--
 arch/alpha/kernel/sys_miata.c                 |  2 +-
 arch/arm/common/it8152.c                      |  4 +--
 arch/arm/mach-cns3xxx/pcie.c                  |  2 +-
 arch/arm/mach-footbridge/dc21285.c            |  4 +--
 arch/arm/mach-iop32x/pci.c                    |  6 ++--
 arch/arm/mach-ixp4xx/common-pci.c             |  8 ++---
 arch/arm/mach-orion5x/pci.c                   |  4 +--
 arch/arm/plat-orion/pcie.c                    |  8 ++---
 arch/m68k/coldfire/pci.c                      |  8 ++---
 arch/microblaze/pci/indirect_pci.c            |  4 +--
 arch/mips/pci/fixup-ath79.c                   |  2 +-
 arch/mips/pci/ops-bcm63xx.c                   | 14 ++++----
 arch/mips/pci/ops-bonito64.c                  |  4 +--
 arch/mips/pci/ops-gt64xxx_pci0.c              |  4 +--
 arch/mips/pci/ops-lantiq.c                    |  4 +--
 arch/mips/pci/ops-loongson2.c                 |  4 +--
 arch/mips/pci/ops-mace.c                      |  4 +--
 arch/mips/pci/ops-msc.c                       |  4 +--
 arch/mips/pci/ops-rc32434.c                   |  6 ++--
 arch/mips/pci/ops-sni.c                       |  4 +--
 arch/mips/pci/ops-tx3927.c                    |  2 +-
 arch/mips/pci/ops-tx4927.c                    |  2 +-
 arch/mips/pci/ops-vr41xx.c                    |  4 +--
 arch/mips/pci/pci-alchemy.c                   |  6 ++--
 arch/mips/pci/pci-ar2315.c                    |  5 ++-
 arch/mips/pci/pci-ar71xx.c                    |  4 +--
 arch/mips/pci/pci-ar724x.c                    |  6 ++--
 arch/mips/pci/pci-bcm1480.c                   |  4 +--
 arch/mips/pci/pci-bcm1480ht.c                 |  4 +--
 arch/mips/pci/pci-mt7620.c                    |  4 +--
 arch/mips/pci/pci-octeon.c                    | 12 +++----
 arch/mips/pci/pci-rt2880.c                    |  4 +--
 arch/mips/pci/pci-rt3883.c                    |  4 +--
 arch/mips/pci/pci-sb1250.c                    |  4 +--
 arch/mips/pci/pci-virtio-guest.c              |  4 +--
 arch/mips/pci/pci-xlp.c                       |  4 +--
 arch/mips/pci/pci-xlr.c                       |  4 +--
 arch/mips/pci/pci-xtalk-bridge.c              | 14 ++++----
 arch/mips/pci/pcie-octeon.c                   |  4 +--
 arch/mips/txx9/generic/pci.c                  |  5 ++-
 arch/powerpc/kernel/rtas_pci.c                |  4 +--
 arch/powerpc/platforms/4xx/pci.c              |  4 +--
 arch/powerpc/platforms/52xx/efika.c           |  4 +--
 arch/powerpc/platforms/52xx/mpc52xx_pci.c     |  4 +--
 arch/powerpc/platforms/82xx/pq2.c             |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c     |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c      |  2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c    |  2 +-
 arch/powerpc/platforms/chrp/pci.c             |  8 ++---
 arch/powerpc/platforms/embedded6xx/holly.c    |  2 +-
 .../platforms/embedded6xx/mpc7448_hpc2.c      |  2 +-
 arch/powerpc/platforms/fsl_uli1575.c          |  2 +-
 arch/powerpc/platforms/maple/pci.c            | 18 +++++-----
 arch/powerpc/platforms/pasemi/pci.c           |  6 ++--
 arch/powerpc/platforms/powermac/pci.c         |  8 ++---
 arch/powerpc/platforms/powernv/eeh-powernv.c  |  4 +--
 arch/powerpc/platforms/powernv/pci.c          |  4 +--
 arch/powerpc/platforms/pseries/eeh_pseries.c  |  4 +--
 arch/powerpc/sysdev/fsl_pci.c                 |  2 +-
 arch/powerpc/sysdev/indirect_pci.c            |  4 +--
 arch/powerpc/sysdev/tsi108_pci.c              |  4 +--
 arch/sh/drivers/pci/common.c                  |  3 +-
 arch/sh/drivers/pci/ops-dreamcast.c           |  4 +--
 arch/sh/drivers/pci/ops-sh4.c                 |  4 +--
 arch/sh/drivers/pci/ops-sh7786.c              |  8 ++---
 arch/sh/drivers/pci/pci.c                     |  2 +-
 arch/sparc/kernel/pci_common.c                | 28 +++++++--------
 arch/unicore32/kernel/pci.c                   |  4 +--
 drivers/atm/iphase.c                          | 20 ++++++-----
 drivers/atm/lanai.c                           |  8 ++---
 drivers/bcma/driver_pci_host.c                |  4 +--
 drivers/hwmon/sis5595.c                       | 13 +++----
 drivers/hwmon/via686a.c                       | 13 +++----
 drivers/hwmon/vt8231.c                        | 13 +++----
 drivers/i2c/busses/i2c-ali15x3.c              |  5 ++-
 drivers/i2c/busses/i2c-nforce2.c              |  3 +-
 drivers/i2c/busses/i2c-sis5595.c              | 15 +++-----
 drivers/misc/cxl/vphb.c                       |  4 +--
 drivers/net/ethernet/realtek/r8169_main.c     |  2 +-
 drivers/nvme/host/pci.c                       |  2 +-
 drivers/pci/access.c                          | 14 ++++----
 drivers/pci/controller/dwc/pci-meson.c        |  4 +--
 .../pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  4 +--
 drivers/pci/controller/dwc/pcie-hisi.c        |  4 +--
 drivers/pci/controller/dwc/pcie-tegra194.c    |  4 +--
 .../pci/controller/mobiveil/pcie-mobiveil.c   |  4 +--
 drivers/pci/controller/pci-aardvark.c         |  4 +--
 drivers/pci/controller/pci-ftpci100.c         |  4 +--
 drivers/pci/controller/pci-hyperv.c           |  8 ++---
 drivers/pci/controller/pci-mvebu.c            |  4 +--
 drivers/pci/controller/pci-thunder-ecam.c     | 36 +++++++++----------
 drivers/pci/controller/pci-thunder-pem.c      |  4 +--
 drivers/pci/controller/pci-xgene.c            |  5 ++-
 drivers/pci/controller/pcie-altera.c          | 16 ++++-----
 drivers/pci/controller/pcie-iproc.c           | 10 +++---
 drivers/pci/controller/pcie-mediatek.c        |  4 +--
 drivers/pci/controller/pcie-rcar-host.c       |  8 ++---
 drivers/pci/controller/pcie-rockchip-host.c   | 10 +++---
 drivers/pci/pci-bridge-emul.c                 | 14 ++++----
 drivers/pci/pci.c                             |  8 ++---
 drivers/pci/pcie/bw_notification.c            |  4 +--
 drivers/pci/probe.c                           |  4 +--
 drivers/pci/quirks.c                          |  4 +--
 drivers/pci/syscall.c                         |  8 ++---
 drivers/pci/xen-pcifront.c                    |  2 +-
 drivers/scsi/ipr.c                            | 16 ++++-----
 drivers/scsi/pmcraid.c                        |  6 ++--
 drivers/ssb/driver_gige.c                     |  4 +--
 drivers/ssb/driver_pcicore.c                  |  4 +--
 drivers/xen/xen-pciback/conf_space.c          |  2 +-
 122 files changed, 347 insertions(+), 369 deletions(-)

-- 
2.18.2

