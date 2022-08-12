Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4537F591389
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbiHLQKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiHLQKK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EFEAE9CE
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED42EB82469
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25200C433C1;
        Fri, 12 Aug 2022 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320606;
        bh=xkCqGsY9AFi7+B4euGtB2HvuO001jM8biMghSTYGygY=;
        h=From:To:Cc:Subject:Date:From;
        b=jxgQMS6h+mFTn7wjDXQoTwIEJfuYZajoN+pSXfKk0q9GoLg0wdCeGJwIPB9KX3ioZ
         WGu4Ct1WdaE6cb3jN9PE2XuzJ2Swijj9Lni71beTdYev/MKFmbkkQ57SCkwWKVw8s2
         nRKg8DidPfjz+gAkK2HKGOdYprVUYyLASeLcPexzuatvhcAgL3PVEPMbTWgNNaMxN8
         aFeyy01oczgKBjk3HWh/3/FPctwKhfBAJoLtbaMdFyAVbMhKzLux0NfqBzueKeBtdF
         WCAXB74QHcIwb99Du4hLhBpcnu3WOCnploxgjs+Wwilh9rnPCA4pM7KCvsXjyJmJgS
         kY0Ie7kgMX5gQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 00/50] wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices
Date:   Fri, 12 Aug 2022 19:09:13 +0300
Message-Id: <20220812161003.27279-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TRACKER_ID,T_SCC_BODY_TEXT_LINE autolearn=ham
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

I have split the driver into multiple patches for easier review, but
the final version will be one big commit.

For easier review I have split the driver into multiple patches (one
file per patch). But in the final version, which will be commited to
git, all these patches will be folded into one big patch. So in the
git archive the full driver be in a single commit to avoid any bisect
issues etc.

This version is based on commit 313fb8aacbba1eae831065d7cb5c68cb97fcace6
from ath12k-bringup branch on my ath.git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=ath12k-bringup

The patchset applies on top of wireless-next commit:

bafe9528b792f4a442aa1ea2b0297cd53a0351ab

The firmware images are not yet available but they will be soon, the
plan is to publish them before v2 is submitted.

Please review and comment.

Kalle


