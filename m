Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A062C4F8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiKPQnf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbiKPQm4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:42:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9513FDC8
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33F6861ED5
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA030C433C1;
        Wed, 16 Nov 2022 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616747;
        bh=xAet6t7SMYSpYMId9rmJBrw/UKR2Kdu8vWYcdikEhtg=;
        h=From:To:Cc:Subject:Date:From;
        b=V/BddIf30KRgEcrIQCP5ouItziytq21n9K+6+nFoIfVMkFv0amL/PiPh66Y1xvooE
         Q4zwutDoRwrE8kmwnEdk1HETzGTxQ1/ODYbB+81hynRP1PXDcw6siIz9fVxin4D0LE
         Pvm0l37TGM/X8rRR/P9tRZqxnWNbzcLfZXHib9rj8O/L6fMXCnIBjKEPqclshhX7KA
         +tvGgtmKlXsLcFJQHB1QWVEBSla+t83vmWzTJh7q0+cMLBiSaOqtahXT1ODaP+dbYX
         xcpCSFhUSYdwrGDCBtZtNU+CigPGRWSY11bDB3iGPuKf8+EdBJUKLCFxoyyR30Gmun
         rI5EXO/gg/aNA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 00/50] wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices
Date:   Wed, 16 Nov 2022 18:38:12 +0200
Message-Id: <20221116163902.24996-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,TRACKER_ID autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

ath12k is a new mac80211 driver for Qualcomm Wi-Fi 7 devices, first
supporting QCN9274 and WCN7850 PCI devices.  QCN9274 supports both AP
and station; WCN7850 supports only station mode. Monitor mode is not
(yet) supported. Only PCI bus devices are supported.

ath12k is forked from an earlier version of ath11k. It was simpler to
have a "clean start" for the new generation and not try to share the
code with ath11k. This makes maintenance easier and avoids major
changes in ath11k, which would have significantly increased the risk
of regressions in existing setups.

ath12k uses le32 and cpu_to_le32() macros to handle endian
conversions, instead of using the firmware byte swap feature utilized
by ath11k. There is only one kernel module, named ath12k.ko.

Currently ath12k only supports HE mode (IEEE 802.11ax) or older, but
work is ongoing to add EHT mode (IEEE 802.11be) support.

The size of the driver is ~41 kLOC and 45 files. To make the review
easier, this initial version of ath12k does not support Device Tree,
debugfs or any other extra features. Those will be added later, after
ath12k is accepted to upstream.

The driver is build tested by Intel's kernel test robot with both GCC
and Clang. Sparse reports no warnings. The driver is mostly free of
checkpatch warnings, albeit few of the warnings are omitted on
purpose, list of them here:

https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath12k/ath12k-check#L52

The driver has had multiple authors who are listed in alphabetical
order below.

Co-developed-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: Balamurugan Selvarajan <quic_bselvara@quicinc.com>
Signed-off-by: Balamurugan Selvarajan <quic_bselvara@quicinc.com>
Co-developed-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Co-developed-by: Bhagavathi Perumal S <quic_bperumal@quicinc.com>
Signed-off-by: Bhagavathi Perumal S <quic_bperumal@quicinc.com>
Co-developed-by: Carl Huang <quic_cjhuang@quicinc.com>
Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
Co-developed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Co-developed-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Co-developed-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

--------------[cut]-------------------[cut]-----------------

For easier review I have split the driver into multiple patches (one
file per patch). But in the final version, which will be commited to
git, all these patches will be folded into one big patch. So in the
git archive the full driver be in a single commit to avoid any bisect
issues etc.

This version is based on commit 324dde0354ace6d793cd79a6654cd8e20872e082
from ath12k-bringup branch on my ath.git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=ath12k-bringup

The patchset applies on top of wireless-next commit:

a9501019f2de706eb43b59d66dcde70a23440cd3

Unfortunately the firmware images are not yet available but they will be soon, the
plan is to publish them any day now.

Please review and comment.

Kalle

v2:

* Lots of comments both from Jeff and Ping addressed.

* Support for QCN9274 hw2.0.

* git log --oneline --reverse ath12k-bringup-v1..ath12k-bringup-v2 drivers/net/wireless/ath/ath12k/:

c8bd8aa45f6a ath12k: fix ATH12K_DBG_DP_TX value in ath12k_debug_mask
1b4a11d871b4 wifi: ath12k: dp: remove unused structures
efc72b2aa34c wifi: ath12k: dp: convert htt cmd structs to __le32
f2226a858c6c wifi: ath12k: dp: add __packed to struct htt_tx_ring_selection_cfg_cmd
ded0b851ddb1 wifi: ath12k: mac: replace get_num_chains() with hweight32()
2bae125b29fd wifi: ath12k: dp: convert event structures to le32 and le16
dab2e1356301 wifi: ath12k: dp: fix long line warnings introduced in previous patch
e094a9ab1340 wifi: ath12k: dp: convert ath12k_dp_htt_tlv_iter() to a static function
c34c346fe9cc wifi: ath12k: Remove the redundant code in ce_send
c568d8bc26de ath12k: convert payload[0] to payload[], use ab variable and fix __ath12k_dbg() signature
b290b591dbdd ath12k: remove magic number offset in rx_user_status struct
1a458fd07d47 ath12k: remove __packed from the ath12k_skb_cb struct
7887e032942a wifi: ath12k: fix dp peer setup error handling
6b650b8d9fd3 wifi: ath12k: make bank_config as return value instead of an argument
d09d40c053b3 wifi: ath12k: fix dangling pointer during vdev bank profile cleanup
4a033426a7e2 wifi: ath12k: reverse the order of common srng cleanup
eaa2ce8b29bd wifi: ath12k: use enum for determining tx or rx monitor mode
8589ba1261da wifi: ath12k: cleanup monitor interrupt processing
45b3bcb37321 wifi: ath12k: fix tx descriptor cleanup
54ea2140eb0f wifi: ath12k: avoid using memset for initializing structure
3936b1ff26d1 wifi: ath12k: fix initializations in dp_tx.c
67ecf855bd48 wifi: ath12k: fix peer access in ath12k_peer_find_by_vdev_id
2f2e1a9c64b1 wifi: ath12k: Change mhi_config member to const in ath12k_hw_params structure
ef4638246b7f wifi: ath12k: Declare cosnt for mhi controller config and channel config
e7afb023979c wifi: ath12k: Initialize ab_pci->mhi_ctrl to NULL in mhi unregister
229acc4f9feb wifi: ath12k: Declare structure member as constant
454c8ff42ac5 wifi: ath12k: remove unnecessary debug print
10a5d161e3d1 wifi: ath12k: fix the iteration in ath12k_htc_get_credit_allocation
529d0f47ef90 wifi: ath12k: avoid unnecessary initializer
7d147446cf0b wifi: ath12k: fix ath12k_hw_ring_mask intializer
b528f968d261 wifi: ath12k: fix misspelled words
dc40c72b9831 wifi: ath12k: fix indentation in ath12k_hal_srng_update_hp_tp_addr
db88dec1cf82 wifi: ath12k: fix ath12k_he_ru_tones_to_nl80211_he_ru_alloc
9e24a0dab3f9 wifi: ath12k: fix zero element array in ath12k_htc_record
16fd0b13a04f wifi: ath12k: remove unused/draft structure
725d23f61ea3 wifi: ath12k: Fix hw mode setup error handling
fc27ae0c8ebe wifi: ath12k: remove packing for struct ppdu_user_delayba
795c1a99be86 wifi: ath12k: set tid vaddr to NULL after free
27a5dfb1af56 wifi: ath12k: fix typo in dp_rx.c
b0132b83649b wifi: ath12k: dp_rx: replace use of sizeof(struct ...) with sizeof(member)
7b3a801aad49 wifi: ath12k: dp_rx: avoid unnecessary function initializers
2d9db64a52fa wifi: ath12k: Declare 'drop' variable as bool in rx err processing
b6ef02504a91 wifi: ath12k: log peer mac in case of pn config failure
08c766f0e4d3 wifi: ath12k: Remove duplicate use of used buf count variable
faa8a0a89616 wifi: ath12k: dp_rx: avoid use of bitwise OR for the first assignment
3ca5427e7315 wifi: ath12k: move monitor reap timer init out of srng setup
2942a582a455 wifi: ath12k: dp_rx: unlock spinlock before logging
8dd0efa92787 wifi: ath12k: fix failure handling during buffer replenish
e4589bd5717e wifi: ath12k: avoid unnecessary typecast
9ae39e387a65 wifi: ath12k: remove backpressure event handler
b7359c7cbbd5 wifi: ath12k: fix a recently introduced long line warning in dp.h
8f0edd33f436 wifi: ath12k: Change consistency of logging in wmi.c
e7171c7f2ac2 wifi: ath12k: remove unnecessary initializer in mac.c
afb95e82a20e wifi: ath12k: Group related constants into enum
0808f3bbb335 wifi: ath12k: Update reference in comments
f2f15d0adf34 wifi: ath12k: fix uninitialized function return value
8069d95c4157 wifi: ath12k: fix srng configuration dangling pointer
4ec85908eb49 wifi: ath12k: refactor the DSCP TID map
bd676f340565 wifi: ath12k: refactor HTC connection flag
620b992fbdb3 wifi: ath12k: avoid unnecessary initialization of local variable
daddbf430f14 wifi: ath12k: add comments to justify spin unlock
42a0928f9b5b wifi: ath12k: fix svc_id in ath12k_htc_setup_target_buffer_assignments
a7acf32c70f4 wifi: ath12k: do empty initializer instead of memset
607f79b27b97 wifi: ath12k: update to shadow register v3 configuration
5a9ae823b2dd wifi: ath12k: remove qdss config download code
bfef46ffcc5e wifi: ath12k: trivial change in ath12k_dbring_buf_setup
640978f9fb1f wifi: ath12k: Fix typo and initializer in mac.c
c5444c60c642 wifi: ath12k: avoid unnecessary initialization of local variable
1ff52c83d54b wifi: ath12k: add QCN9274 hw2.0 register related changes
5a26aea56ae9 wifi: ath12k: add HAL changes to support QCN9274 hw2.0
90bfc0fe0f07 wifi: ath12k: add hardware params for QCN9274 hw2.0
0b7b165dd088 wifi: ath12k: pci: check TCSR_SOC_HW_VERSION
62cf12719696 wifi: ath12k: Endianness and bit ops changes in wmi.c
392fb0544176 wifi: ath12k: Fix invalid management rx frame length
b4e956acc25b wifi: ath12k: hal: use parenthesis with complex values
76ed1650d959 wifi: ath12k: hal: fix possible side affects
adf26aed2c11 wifi: ath12k: wmi: whitespace fixes
f9b3b6aa0317 Merge ath-next into ath12k-bringup
93f45aee4c5d wifi: ath12k: Remove conditional compilation for pm ops
a6d720a7ca6c wifi: ath12k: Move destroy_workqueue(xx) to ath12k_core_free()
73db655f7f75 wifi: ath12k: don't use zero-length element arrays
3a8a8251fde1 wifi: ath12k: dp: remove ath12k_htt_pktlog()
c826fbcfba79 wifi: ath12k: core: remove unused struct ath12k_vif::tx_seq_no
ac43b20e7d06 wifi: ath12k: mac: use u32_replace_bits() to set beamforming capabilities
ea6338c47150 wifi: ath12k: wmi: avoid copying invalid vdev key data


