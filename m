Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6D46E6D9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 11:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhLIKrc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 05:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLIKrb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 05:47:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843E4C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 02:43:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3482CB82438
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 10:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6BAC004DD;
        Thu,  9 Dec 2021 10:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046635;
        bh=4r+gF70dZYkhhS2mQGiZAQ/oImRo1KGJtpl5JDzvarg=;
        h=From:To:Cc:Subject:Date:From;
        b=j5FuP0Zhpcm6Z0CFxwYDScVEeOVn0SJnpo4oes92EIhiG9w/bqI/mTrwEQKzZ9YsM
         ciSDnRBmHygX5aF5Be+tUwf4eMjS3cE5GNYUlRO5UyDBj/YUeKTtpMtrH7agD2ATri
         RjUhZpnH8oDhWZqdGyoY5Uc1HVH1NDUjzGx0zU4Gk8RMKzBIJ590gRbSF23PzrnUQj
         AY34eQ/XoVhzR5xQVLJnIReldPVcGC+o0KF4jZQMXoMIDch4Vxpj5ec1gBcNFfhRT7
         WfhaDD+zLwFS2l2fImT/xs6eX7u6uMLP+i7q+tvsaAxSKYgANr2u8H+J43AJAX+qh/
         Vd15ENnYlCw6w==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v3 0/2] ath11k: Change qcn9074 fw to operate in mode-2
Date:   Thu,  9 Dec 2021 12:43:49 +0200
Message-Id: <20211209104351.9811-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Use firmware mode 2 with QCN9074 to reduce host memory usage. Please review.

Kalle

v3:

* new patch: ath11k: add ab to TARGET_NUM_VDEVS & co

* remove now unused ATH11K_QMI_TARGET_MEM_MODE_DEFAULT

Kalle Valo (1):
  ath11k: add ab to TARGET_NUM_VDEVS & co

Seevalamuthu Mariappan (1):
  ath11k: Change qcn9074 fw to operate in mode-2

 drivers/net/wireless/ath/ath11k/core.c | 20 +++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/hw.c   | 14 +++++++-------
 drivers/net/wireless/ath/ath11k/hw.h   | 21 ++++++++++++---------
 drivers/net/wireless/ath/ath11k/mac.c  | 10 +++++-----
 drivers/net/wireless/ath/ath11k/qmi.c  |  2 +-
 drivers/net/wireless/ath/ath11k/qmi.h  |  1 -
 6 files changed, 44 insertions(+), 24 deletions(-)


base-commit: a3d88d337890f66f594ae06cedc1adeb5d5f8f31
-- 
2.20.1

