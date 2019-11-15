Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80A3FD8E6
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKOJ3T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:29:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOJ3T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:29:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 752DF611A0; Fri, 15 Nov 2019 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810158;
        bh=X7R7K3nn8a1h8zFooYO+s283VI3WWKxDBVpp6C8kBaQ=;
        h=From:To:Cc:Subject:Date:From;
        b=X7MpvLcST/uT7XwxqmjRdfOog6AKiZEfDxJkktqY2yyGBGrmQJ43nCPXGRzCjViHj
         hgreDP72BebeHQx+7nPtfg5tOUzKYj+qvivYPKpFIWnFj/7eI3zqCHHEFsykTrbNeq
         dlmUdKZnGJGWoJm3UJgjFFwQTHrXzsQ0YR/wfwrE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A48EE6119B;
        Fri, 15 Nov 2019 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810157;
        bh=X7R7K3nn8a1h8zFooYO+s283VI3WWKxDBVpp6C8kBaQ=;
        h=From:To:Cc:Subject:Date:From;
        b=S2YHC3tM8niwG4aXS52NAzg3ODbg5mgVtgsmtrXpI2AakkVg66NPjmPuwq/IAB361
         Bwkw/SfRajBBmnwS1+BH8DuTQ1tR47B4eRH8843EVj06gUrpef7Fa1Jx9ryZsPLDuu
         60wPLXeM6haIms4LFSn6km0eW2PD8yDyEhgoM3h0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A48EE6119B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 00/49] ath11k: driver for Qualcomm IEEE 802.11ax devices
Date:   Fri, 15 Nov 2019 11:28:24 +0200
Message-Id: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k is a new driver for Qualcomm IEEE 802.11ax devices, first
supporting only IPQ8074 SoC using the shared memory AHB bus. ath11k
uses mac80211 and supports AP, Station and Mesh modes.

Even though ath11k has some similar code as with ath10k (especially
the WMI layer) it was concluded to be simpler to have a "clean start"
for ath11k code base and not try to share the code with ath10k. This
makes maintenance easier and avoids major changes in ath10k, which
would have significantly increased the risk of regressions in existing
setups.

Even though the driver is very similar with ath10k but there are major
differences as well. The datapath is completely different. ath11k
supports multiple MACs, called "soc" in the firmware interface. And
there's only one WMI interface to support.

Currently ath11k supports only IEEE 802.11ac mode, but patches for
802.11ax are available and they will be submitted after ath11k is
accepted to upstream.

The firmware images are available from ath11k-firmware repository but
they will be also submitted to linux-firmware:

https://github.com/kvalo/ath11k-firmware

The driver has had multiple authors who are listed in alphabetical
order below.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Bhagavathi Perumal S <bperumal@codeaurora.org>
Signed-off-by: Ganesh Sesetti <gseset@codeaurora.org>
Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Muna Sinada <msinada@codeaurora.org>
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>

--------------[cut]-------------------[cut]-----------------

I have split the driver into multiple patches for easier review, but
the final version will be split into three commits:

1. adding Documentatio/devicetree/bindings/net/wireless/qcom,ath11k.yaml

2. adding drivers/net/wireless/ath/ath11k/ with the commit log being the
   text before the cut line above.

3. adding ath11k entry to MAINTAINERS file

This version is based on commit ad10d2ff619f0797cb102b2ff488429d3f8e4a8a
from ath11k-bringup branch on my ath.git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=ath11k-bringup

This patchset applies to wireless-drivers-next but needs
CONFIG_COMPILE_TEST, CONFIG_REMOTEPROC AND CONFIG_QCOM_QMI_HELPERS to
be able to compile on x86.

Please review and comment.

Kalle

v3:

* Fixes and license change to Device Tree bindings document

* git log --oneline --reverse ath11k-review-v2..ath11k-review-v3:

51dcdfd7a2bf ath11k: fix ATH11K_TRACING kconfig help text
b6b50cbae8a1 dt: bindings: net: ath11k: fix whitespace
2120332777dd dt: bindings: net: ath11k: fixes from review
93804d04c6d6 dt: bindings: net: ath11k: change license

v2:

* There are three final patches to commit, not just one.

* Write commit log for the device tree bindings patch.

* License changed to BSD 3-clause "Clear".

* git log --oneline --reverse ath11k-review-v1..ath11k-review-v2:

f6153fa78616 ath11k: fix Kconfig, replace spaces with tabs
b6b140aa1739 ath11k: Use C99 structure initialization for target_service_to_ce_map_wlan[]
d054355585aa ath11k: Remove ring mask macros defined for 0
4c980dcca60a ath11k: Move ath11k_ahb_read32() and ath11k_ahb_write32() to ahb.h
be7eb8bbca02 ath11k: Avoid code duplication in set/clear of a register bit values
11978c109885 ath11k: Few clean ups in comments
8cc72b480777 ath11k: Clean ups in ath11k_ce_rx_buf_enqueue_pipe() error path
9f55e5658237 ath11k: Clean up parameter list in ath11k_ce_completed_send_next()
3dcb3e76a260 ath11k: Use struct_size() to get the structure size with trailing array
a1329c05a4e0 ath11k: change license to BSD 3-clause "Clear"
bcd3f5043856 ath11k: fix multicast rate parameter size
e4386fb86f51 ath11k: assigning values to enum
78b6da0fb67c ath11k: Add debugfs per chip
e44597a02dad ath11k: fix tkip mic error reporting to cfg80211
ea1107a93b4a dt-bindings: net: add qcom,ath11k.yaml
ab4d2bd0f217 ath11k: whitespace cleanup in core.c


