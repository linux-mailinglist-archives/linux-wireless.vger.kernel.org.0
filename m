Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E582C12BC
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390594AbgKWR7l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 12:59:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:43852 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgKWR7k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 12:59:40 -0500
IronPort-SDR: fe1XNTtQkMvsb8qg+nelZKEWRq/MIBjSFwLY9okkNXU2TENPUlaLrTF9ALG842SflPzxfAe1Lx
 kIXbFhA0gjUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="233424243"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="233424243"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:59:39 -0800
IronPort-SDR: Q2doGdMBBD/o9VKKKs0arlrEN93GyRQTmyoSg6Jwlob60iTvAgTDZCKOrkG4SEAru6Wn69QAWg
 kGXqHNBGNr7g==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="546504782"
Received: from suygunge-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.108])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:59:35 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        ath11k@lists.infradead.org, ath10k@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: [PATCH 0/9] relay: cleanup and const callbacks, take 2
Date:   Mon, 23 Nov 2020 19:59:20 +0200
Message-Id: <cover.1606153547.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is v2 of [1], with a number of cleanups added first based on
Christoph's feedback, making the actual constness patch much smaller and
cleaner.

I don't know who actually maintains relay, it's not in MAINTAINERS -
Cc'd Andrew just in case.

I'd think it would be simplest to queue patches 5-9 via whichever tree
the relay patches get merged. They're all one-liners so neglible
conflict potential.

BR,
Jani.


[1] http://lore.kernel.org/r/20201118165320.26829-1-jani.nikula@intel.com


Cc: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: ath11k@lists.infradead.org
Cc: ath10k@lists.infradead.org
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>


Jani Nikula (9):
  relay: remove unused buf_mapped and buf_unmapped callbacks
  relay: require non-NULL callbacks in relay_open()
  relay: make create_buf_file and remove_buf_file callbacks mandatory
  relay: allow the use of const callback structs
  drm/i915: make relay callbacks const
  ath10k: make relay callbacks const
  ath11k: make relay callbacks const
  ath9k: make relay callbacks const
  blktrace: make relay callbacks const

 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c    |   2 +-
 drivers/net/wireless/ath/ath10k/spectral.c    |   2 +-
 drivers/net/wireless/ath/ath11k/spectral.c    |   2 +-
 .../net/wireless/ath/ath9k/common-spectral.c  |   2 +-
 include/linux/relay.h                         |  29 ++---
 kernel/relay.c                                | 107 +++---------------
 kernel/trace/blktrace.c                       |   2 +-
 7 files changed, 26 insertions(+), 120 deletions(-)

-- 
2.20.1

