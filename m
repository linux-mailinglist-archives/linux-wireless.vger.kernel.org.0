Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8538F21296D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 18:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGBQ3z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 12:29:55 -0400
Received: from muru.com ([72.249.23.125]:60382 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgGBQ3z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 12:29:55 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 63CA98062;
        Thu,  2 Jul 2020 16:30:48 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCHv2 0/4] Improvments for wlcore irq and resume for v5.9
Date:   Thu,  2 Jul 2020 09:29:47 -0700
Message-Id: <20200702162951.45392-1-tony@atomide.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Here are few improvments for wlcore resume ELP handling and interrupt
handling for v5.9.

Regards,

Tony

Changes since v1:

- Update patch descriptions for simplifying the complicated locking
  between interrupt handler and tx

- Change patch order for the ELP handling to be the first change
  as the others are mostly clean-up type improvments

Tony Lindgren (4):
  wlcore: Simplify runtime resume ELP path
  wlcore: Use spin_trylock in wlcore_irq_locked() for running the queue
  wlcore: Use spin_trylock in wlcore_irq() to see if we need to queue tx
  wlcore: Remove pointless spinlock

 drivers/net/wireless/ti/wlcore/main.c | 84 +++++++++++++--------------
 1 file changed, 39 insertions(+), 45 deletions(-)

-- 
2.27.0
