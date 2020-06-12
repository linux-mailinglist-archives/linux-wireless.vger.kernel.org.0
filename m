Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92F51F7B37
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2020 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgFLP6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jun 2020 11:58:46 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51230 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFLP6q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jun 2020 11:58:46 -0400
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 909FB580060;
        Fri, 12 Jun 2020 17:58:44 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v2 0/2] Fixes for 802.1X in mesh mode
Date:   Fri, 12 Jun 2020 17:58:34 +0200
Message-Id: <20200612155836.1207234-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to support 802.1X in mesh mode, userspace should be able
to rx and tx eapol frames, after an initial MPM, before a second AMPE.

Some checks regarding mesh forwarding were conflicting with this.
Therefore this little series adds some checks for control port frames
and disables mesh path lookups on the tx side or drop of unencrypted
frames on the rx side.

Markus Theil (2):
  mac80211: skip mpath lookup also for control port tx
  mac80211: allow rx of mesh eapol frames with default rx key

 net/mac80211/rx.c | 27 +++++++++++++++++++++++++++
 net/mac80211/tx.c | 13 ++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.27.0

