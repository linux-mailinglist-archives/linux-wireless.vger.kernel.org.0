Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969346DFD09
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 19:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDLRwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLRwc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 13:52:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BEB5FD5;
        Wed, 12 Apr 2023 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681321949; x=1712857949;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TIYs4ZIk35TXWTPd2ztjdk8cMzBEHCggjBsOZcucAJ8=;
  b=W2atG3cjXrSKeDODk/4uos1JTwPw1WcvwYCEr7xlpmzynw8fJsYL+9TJ
   xe3vjxgMQPUi1nmoc447pbBnn7I0jSAfTubwbD1vFEzmt+4zQHy62kJf8
   godMVqypYXjgqd4pEmgZ6corB06iOZfumSQuyBL29l58ZEwx15wJ5S+5T
   e+OVpuAQe/SGUoUOEZGCZxnTwjuOZFSGP8Zh5R2EIAjzm2PZKN1lIxEnz
   XEI8ptuOKkXwyHmBIgxEgd6Xgp17gJ2CtDUMqhzBLJQF6U6ckFFmwl2Jw
   lHjeXNJU1Rr5QLLsn+bSgPM7ZtsjGqw+JdermrwCL1805Q1UA0VvCusoD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="345763361"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="345763361"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 10:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="682575524"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="682575524"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Apr 2023 10:52:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmedo-000Xxf-0F;
        Wed, 12 Apr 2023 17:52:20 +0000
Date:   Thu, 13 Apr 2023 01:51:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 7d8214bba44c1aa6a75921a09a691945d26a8d43
Message-ID: <6436efbb.08+e+yEDqvRxvHDP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        SUSPICIOUS_RECIPS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 7d8214bba44c1aa6a75921a09a691945d26a8d43  Add linux-next specific files for 20230412

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303161521.jbGbaFjJ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304061839.hi01VPl1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304102354.Q4VOXGTE-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304112044.8NzKpvxM-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304121606.ltRFyuij-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304121702.bav49HFN-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

Error: failed to load BTF from vmlinux: No data available
arch/arm/vfp/entry.S:27: undefined reference to `vfp_entry'
arch/csky/abiv2/cacheflush.c:15:9: error: implicit declaration of function 'flush_tlb_page'; did you mean 'flush_anon_page'? [-Werror=implicit-function-declaration]
diff: tools/arch/s390/include/uapi/asm/ptrace.h: No such file or directory
drivers/bluetooth/hci_qca.c:1894:37: warning: unused variable 'qca_soc_data_wcn6855' [-Wunused-const-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13: warning: variable 'bw_needed' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:352:25: warning: variable 'link' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h:62: warning: wrong kernel-doc identifier on line:
drivers/gpu/drm/i915/i915_pmu.h:41: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_request.h:176: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_vma.h:145: warning: expecting prototype for i915_vma_offset(). Prototype was for i915_vma_size() instead
drivers/net/wireless/legacy/ray_cs.c:628:17: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
drivers/tty/serial/samsung_tty.c:2034:10: error: implicit declaration of function 'of_device_get_match_data' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
drivers/tty/serial/samsung_tty.c:2034:10: warning: incompatible integer to pointer conversion returning 'int' from a function with result type 'const struct s3c24xx_serial_drv_data *' [-Wint-conversion]
drivers/tty/serial/samsung_tty.c:2034:24: error: implicit declaration of function 'of_device_get_match_data'; did you mean 'device_get_match_data'? [-Werror=implicit-function-declaration]
drivers/tty/serial/samsung_tty.c:2034:24: warning: returning 'int' from a function with return type 'const struct s3c24xx_serial_drv_data *' makes pointer from integer without a cast [-Wint-conversion]
make[3]: *** No rule to make target 'zip.h', needed by '/tools/build/libbpf/sharedobjs/libbpf.o'.
make[3]: *** No rule to make target 'zip.h', needed by '/tools/build/libbpf/staticobjs/libbpf.o'.
make[4]: *** No rule to make target 'zip.h', needed by 'kselftest/net/tools/build/libbpf/sharedobjs/libbpf.o'.
make[4]: *** No rule to make target 'zip.h', needed by 'kselftest/net/tools/build/libbpf/staticobjs/libbpf.o'.
membarrier_test_impl.h:27:30: error: 'MEMBARRIER_CMD_GET_REGISTRATIONS' undeclared (first use in this function)
mount_setattr_test.c:107:8: error: redefinition of 'struct mount_attr'
thermal_nl.h:6:10: fatal error: netlink/netlink.h: No such file or directory
thermometer.c:21:10: fatal error: libconfig.h: No such file or directory

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/acpi/property.c:985 acpi_data_prop_read_single() error: potentially dereferencing uninitialized 'obj'.
drivers/crypto/intel/qat/qat_common/adf_cfg.c:262 adf_cfg_add_key_value_param() warn: argument 4 to %lx specifier is cast from pointer
drivers/hwmon/pmbus/pmbus_core.c:3164:7-32: WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)
drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: incorrect type in argument 2 (different address spaces)
drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: incorrect type in argument 1 (different address spaces)

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
|-- alpha-randconfig-c023-20230409
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- alpha-randconfig-r016-20230409
|   |-- drivers-tty-serial-samsung_tty.c:error:implicit-declaration-of-function-of_device_get_match_data
|   `-- drivers-tty-serial-samsung_tty.c:warning:returning-int-from-a-function-with-return-type-const-struct-s3c24xx_serial_drv_data-makes-pointer-from-integer-without-a-cast
|-- alpha-randconfig-r023-20230410
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm-keystone_defconfig
|   `-- arch-arm-vfp-entry.S:undefined-reference-to-vfp_entry
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- csky-defconfig
|   `-- arch-csky-abiv2-cacheflush.c:error:implicit-declaration-of-function-flush_tlb_page
|-- csky-randconfig-r013-20230409
|   `-- arch-csky-abiv2-cacheflush.c:error:implicit-declaration-of-function-flush_tlb_page
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- i386-randconfig-m021
|   |-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
|   `-- drivers-crypto-intel-qat-qat_common-adf_cfg.c-adf_cfg_add_key_value_param()-warn:argument-to-lx-specifier-is-cast-from-pointer
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
|-- ia64-buildonly-randconfig-r005-20230409
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- ia64-randconfig-c44-20230409
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- ia64-randconfig-m031-20230410
|   `-- drivers-crypto-intel-qat-qat_common-adf_cfg.c-adf_cfg_add_key_value_param()-warn:argument-to-lx-specifier-is-cast-from-pointer
|-- ia64-randconfig-r002-20230410
|   |-- drivers-tty-serial-samsung_tty.c:error:implicit-declaration-of-function-of_device_get_match_data
|   `-- drivers-tty-serial-samsung_tty.c:warning:returning-int-from-a-function-with-return-type-const-struct-s3c24xx_serial_drv_data-makes-pointer-from-integer-without-a-cast
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-randconfig-r032-20230409
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- parisc-randconfig-r003-20230412
|   |-- drivers-tty-serial-samsung_tty.c:error:implicit-declaration-of-function-of_device_get_match_data
|   `-- drivers-tty-serial-samsung_tty.c:warning:returning-int-from-a-function-with-return-type-const-struct-s3c24xx_serial_drv_data-makes-pointer-from-integer-without-a-cast
|-- parisc-randconfig-r034-20230410
|   |-- drivers-tty-serial-samsung_tty.c:error:implicit-declaration-of-function-of_device_get_match_data
|   `-- drivers-tty-serial-samsung_tty.c:warning:returning-int-from-a-function-with-return-type-const-struct-s3c24xx_serial_drv_data-makes-pointer-from-integer-without-a-cast
|-- parisc-randconfig-s053-20230409
|   |-- drivers-tty-serial-samsung_tty.c:error:implicit-declaration-of-function-of_device_get_match_data
|   `-- drivers-tty-serial-samsung_tty.c:warning:returning-int-from-a-function-with-return-type-const-struct-s3c24xx_serial_drv_data-makes-pointer-from-integer-without-a-cast
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- powerpc-randconfig-s033-20230411
|   |-- drivers-soc-fsl-qe-tsa.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-noderef-__iomem-addr-got-void-noderef-__iomem-addr
|   `-- drivers-soc-fsl-qe-tsa.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-noderef-__iomem-addr-got-void-noderef-__iomem-addr
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- riscv-randconfig-r042-20230410
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
|-- sparc-randconfig-c041-20230409
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- x86_64-randconfig-c002
|   `-- drivers-hwmon-pmbus-pmbus_core.c:WARNING:Threaded-IRQ-with-no-primary-handler-requested-without-IRQF_ONESHOT-(unless-it-is-nested-IRQ)
`-- x86_64-randconfig-k001-20230410
    |-- Error:failed-to-load-BTF-from-vmlinux:No-data-available
    |-- diff:tools-arch-s390-include-uapi-asm-ptrace.h:No-such-file-or-directory
    |-- make:No-rule-to-make-target-zip.h-needed-by-kselftest-net-tools-build-libbpf-sharedobjs-libbpf.o-.
    |-- make:No-rule-to-make-target-zip.h-needed-by-kselftest-net-tools-build-libbpf-staticobjs-libbpf.o-.
    |-- make:No-rule-to-make-target-zip.h-needed-by-tools-build-libbpf-sharedobjs-libbpf.o-.
    |-- make:No-rule-to-make-target-zip.h-needed-by-tools-build-libbpf-staticobjs-libbpf.o-.
    |-- membarrier_test_impl.h:error:MEMBARRIER_CMD_GET_REGISTRATIONS-undeclared-(first-use-in-this-function)
    |-- mount_setattr_test.c:error:redefinition-of-struct-mount_attr
    |-- thermal_nl.h:fatal-error:netlink-netlink.h:No-such-file-or-directory
    `-- thermometer.c:fatal-error:libconfig.h:No-such-file-or-directory
clang_recent_errors
|-- hexagon-randconfig-r005-20230410
|   `-- drivers-bluetooth-hci_qca.c:warning:unused-variable-qca_soc_data_wcn6855
|-- i386-buildonly-randconfig-r004-20230410
|   |-- drivers-tty-serial-samsung_tty.c:error:implicit-declaration-of-function-of_device_get_match_data-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|   `-- drivers-tty-serial-samsung_tty.c:warning:incompatible-integer-to-pointer-conversion-returning-int-from-a-function-with-result-type-const-struct-s3c24xx_serial_drv_data
|-- x86_64-randconfig-a003-20230410
|   `-- drivers-bluetooth-hci_qca.c:warning:unused-variable-qca_soc_data_wcn6855
|-- x86_64-randconfig-a005-20230410
|   |-- drivers-gpu-drm-i915-gt-uc-guc_capture_fwif.h:warning:wrong-kernel-doc-identifier-on-line:
|   |-- drivers-gpu-drm-i915-i915_pmu.h:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- drivers-gpu-drm-i915-i915_request.h:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-gpu-drm-i915-i915_vma.h:warning:expecting-prototype-for-i915_vma_offset().-Prototype-was-for-i915_vma_size()-instead
`-- x86_64-randconfig-r033-20230410
    `-- drivers-bluetooth-hci_qca.c:warning:unused-variable-qca_soc_data_wcn6855

elapsed time: 722m

configs tested: 145
configs skipped: 9

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230409   gcc  
alpha                randconfig-r016-20230409   gcc  
alpha                randconfig-r023-20230410   gcc  
alpha                randconfig-r026-20230410   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230411   gcc  
arc                  randconfig-r005-20230412   gcc  
arc                  randconfig-r033-20230409   gcc  
arc                  randconfig-r036-20230410   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230409   clang
arm          buildonly-randconfig-r005-20230410   clang
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230409   clang
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230410   clang
arm64                randconfig-r004-20230411   gcc  
arm64                randconfig-r016-20230410   gcc  
arm64                randconfig-r022-20230410   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230409   gcc  
hexagon      buildonly-randconfig-r003-20230409   clang
hexagon              randconfig-r005-20230410   clang
hexagon              randconfig-r011-20230409   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r003-20230410   clang
i386         buildonly-randconfig-r004-20230410   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230409   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230410   gcc  
ia64                 randconfig-r022-20230409   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230410   gcc  
loongarch            randconfig-r024-20230409   gcc  
loongarch            randconfig-r032-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230412   gcc  
m68k                 randconfig-r004-20230412   gcc  
m68k                 randconfig-r031-20230410   gcc  
m68k                 randconfig-r035-20230409   gcc  
m68k                 randconfig-r035-20230410   gcc  
microblaze           randconfig-r001-20230411   gcc  
microblaze           randconfig-r002-20230412   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230410   clang
mips                 randconfig-r021-20230409   clang
mips                 randconfig-r032-20230410   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230411   gcc  
nios2                randconfig-r003-20230411   gcc  
nios2                randconfig-r014-20230409   gcc  
openrisc     buildonly-randconfig-r004-20230409   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230412   gcc  
parisc               randconfig-r006-20230412   gcc  
parisc               randconfig-r015-20230409   gcc  
parisc               randconfig-r023-20230409   gcc  
parisc               randconfig-r034-20230410   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230410   gcc  
powerpc      buildonly-randconfig-r006-20230409   gcc  
powerpc              randconfig-r006-20230409   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230409   clang
riscv                randconfig-r003-20230410   clang
riscv                randconfig-r004-20230409   clang
riscv                randconfig-r006-20230411   gcc  
riscv                randconfig-r024-20230410   gcc  
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230409   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230409   gcc  
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230410   gcc  
sh                   randconfig-r012-20230410   gcc  
sh                   randconfig-r013-20230410   gcc  
sh                   randconfig-r025-20230409   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230409   gcc  
sparc64              randconfig-r025-20230410   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64               randconfig-r006-20230410   clang
x86_64               randconfig-r021-20230410   gcc  
x86_64               randconfig-r033-20230410   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230409   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
