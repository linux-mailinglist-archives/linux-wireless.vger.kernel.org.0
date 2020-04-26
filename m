Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E491B8AD8
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2020 03:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDZBaE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 21:30:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:22555 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgDZBaE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 21:30:04 -0400
IronPort-SDR: 4dHBwjhCu/nn2W/sZvWaG3QpaBAjhX9VEDcKBTCSLX9NmPiBASCG7iFzUx8lMZGv/Uj0Mka7bP
 CTLzVrUF0WCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2020 18:29:32 -0700
IronPort-SDR: DiHpsJQxT3Q51vlnr14TW6q07qpI4L610EcCMsOgHW/RxVq5JHCle5STDcwJ56+YX4rESwufib
 ES8Z6aL325CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,318,1583222400"; 
   d="scan'208";a="248474533"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Apr 2020 18:29:31 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jSW6s-000E3o-KE; Sun, 26 Apr 2020 09:29:30 +0800
Date:   Sun, 26 Apr 2020 09:28:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD REGRESSION
 b6b5c42e3bab939d357d800fd313e3c995164065
Message-ID: <5ea4e3b3.4UQW8y6WlFP0hjS+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
branch HEAD: b6b5c42e3bab939d357d800fd313e3c995164065  mac80211: fix two missing documentation entries

Error/Warning in current branch:

drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:3400:25: error: initialization of 'int (*)(struct wiphy *, struct wireless_dev *, u64)' {aka 'int (*)(struct wiphy *, struct wireless_dev *, long long unsigned int)'} from incompatible pointer type 'void (*)(struct wiphy *, struct wireless_dev *, u16,  bool)' {aka 'void (*)(struct wiphy *, struct wireless_dev *, short unsigned int,  _Bool)'} [-Werror=incompatible-pointer-types]
drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:3400:25: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:3400:3: error: 'struct cfg80211_ops' has no member named 'mgmt_frame_register'
drivers/staging/wilc1000/cfg80211.c:1668:25: error: initialization of 'int (*)(struct wiphy *, struct wireless_dev *, u64)' {aka 'int (*)(struct wiphy *, struct wireless_dev *, long long unsigned int)'} from incompatible pointer type 'void (*)(struct wiphy *, struct wireless_dev *, u16,  bool)' {aka 'void (*)(struct wiphy *, struct wireless_dev *, short unsigned int,  _Bool)'} [-Werror=incompatible-pointer-types]
drivers/staging/wilc1000/cfg80211.c:1668:25: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
drivers/staging/wilc1000/cfg80211.c:1668:2: error: unknown field 'mgmt_frame_register' specified in initializer
drivers/staging/wilc1000/cfg80211.c:1668:2: warning: initialization from incompatible pointer type
drivers/staging/wilc1000/cfg80211.c:1668:3: error: 'const struct cfg80211_ops' has no member named 'mgmt_frame_register'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- arm-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|   `-- drivers-staging-wilc1000-cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|-- arm-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|-- arm64-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|-- arm64-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|-- c6x-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- i386-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|-- i386-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|-- i386-randconfig-a002-20200425
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:unknown-field-mgmt_frame_register-specified-in-initializer
|   `-- drivers-staging-wilc1000-cfg80211.c:warning:initialization-from-incompatible-pointer-type
|-- ia64-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- ia64-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- ia64-randconfig-a001-20200425
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- m68k-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- m68k-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- microblaze-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- mips-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|   `-- drivers-staging-wilc1000-cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|-- mips-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:positional-initialization-of-field-in-struct-declared-with-designated_init-attribute
|-- nds32-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- nios2-randconfig-a001-20200424
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- openrisc-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- parisc-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- parisc-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- riscv-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- riscv-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- sh-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- sparc-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- sparc64-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- sparc64-allyesconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incomp
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- sparc64-randconfig-a001-20200424
|   |-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:initialization-of-int-(-)(struct-wiphy-struct-wireless_dev-u64)-aka-int-(-)(struct-wiphy-struct-wireless_dev-long-long-unsigned-int)-from-incompatible-pointer
|-- x86_64-allmodconfig
|   |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
|   `-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
`-- x86_64-allyesconfig
    |-- drivers-staging-rtl8723bs-os_dep-ioctl_cfg80211.c:error:struct-cfg80211_ops-has-no-member-named-mgmt_frame_register
    `-- drivers-staging-wilc1000-cfg80211.c:error:const-struct-cfg80211_ops-has-no-member-named-mgmt_frame_register

elapsed time: 2181m

configs tested: 183
configs skipped: 0

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm64                               defconfig
arm                           sunxi_defconfig
sparc                            allyesconfig
m68k                          multi_defconfig
arc                              allyesconfig
m68k                       m5475evb_defconfig
sh                  sh7785lcr_32bit_defconfig
um                           x86_64_defconfig
mips                           ip32_defconfig
h8300                       h8s-sim_defconfig
riscv                    nommu_virt_defconfig
ia64                              allnoconfig
c6x                              allyesconfig
mips                         tb0287_defconfig
c6x                        evmc6678_defconfig
mips                              allnoconfig
s390                              allnoconfig
ia64                          tiger_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
xtensa                       common_defconfig
powerpc                             defconfig
ia64                                defconfig
nds32                             allnoconfig
mips                malta_kvm_guest_defconfig
sparc64                             defconfig
nios2                         10m50_defconfig
powerpc                       ppc64_defconfig
parisc                           allyesconfig
ia64                             allyesconfig
parisc                            allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                        generic_defconfig
ia64                         bigsur_defconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                             allmodconfig
mips                       capcella_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                          ath79_defconfig
mips                        bcm63xx_defconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allmodconfig
parisc               randconfig-a001-20200426
mips                 randconfig-a001-20200426
alpha                randconfig-a001-20200426
m68k                 randconfig-a001-20200426
nds32                randconfig-a001-20200426
parisc               randconfig-a001-20200424
alpha                randconfig-a001-20200424
m68k                 randconfig-a001-20200424
riscv                randconfig-a001-20200424
nds32                randconfig-a001-20200424
nios2                randconfig-a001-20200424
c6x                  randconfig-a001-20200424
h8300                randconfig-a001-20200424
sparc64              randconfig-a001-20200424
microblaze           randconfig-a001-20200424
nios2                randconfig-a001-20200426
c6x                  randconfig-a001-20200426
h8300                randconfig-a001-20200426
sparc64              randconfig-a001-20200426
microblaze           randconfig-a001-20200426
nios2                randconfig-a001-20200425
c6x                  randconfig-a001-20200425
h8300                randconfig-a001-20200425
sparc64              randconfig-a001-20200425
microblaze           randconfig-a001-20200425
sh                   randconfig-a001-20200426
csky                 randconfig-a001-20200426
s390                 randconfig-a001-20200426
xtensa               randconfig-a001-20200426
openrisc             randconfig-a001-20200426
sh                   randconfig-a001-20200424
csky                 randconfig-a001-20200424
s390                 randconfig-a001-20200424
xtensa               randconfig-a001-20200424
openrisc             randconfig-a001-20200424
x86_64               randconfig-a001-20200426
i386                 randconfig-a003-20200426
x86_64               randconfig-a003-20200426
i386                 randconfig-a002-20200426
i386                 randconfig-a001-20200426
x86_64               randconfig-a002-20200426
x86_64               randconfig-d001-20200424
i386                 randconfig-d002-20200424
i386                 randconfig-d001-20200424
x86_64               randconfig-d003-20200424
i386                 randconfig-d003-20200424
x86_64               randconfig-a001-20200424
i386                 randconfig-a003-20200424
x86_64               randconfig-a003-20200424
i386                 randconfig-a002-20200424
i386                 randconfig-a001-20200424
x86_64               randconfig-a002-20200424
i386                 randconfig-g003-20200424
i386                 randconfig-g001-20200424
x86_64               randconfig-g001-20200424
x86_64               randconfig-g002-20200424
i386                 randconfig-g002-20200424
x86_64               randconfig-g003-20200424
sparc                randconfig-a001-20200426
ia64                 randconfig-a001-20200426
powerpc              randconfig-a001-20200426
arm                  randconfig-a001-20200426
arm64                randconfig-a001-20200426
arc                  randconfig-a001-20200426
sparc                randconfig-a001-20200425
ia64                 randconfig-a001-20200425
powerpc              randconfig-a001-20200425
arm                  randconfig-a001-20200425
arc                  randconfig-a001-20200425
sparc                randconfig-a001-20200424
ia64                 randconfig-a001-20200424
powerpc              randconfig-a001-20200424
arm64                randconfig-a001-20200424
arc                  randconfig-a001-20200424
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
