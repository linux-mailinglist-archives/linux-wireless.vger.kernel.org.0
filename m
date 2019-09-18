Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3925DB637B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 14:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfIRMno (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 08:43:44 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:48092 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIRMno (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 08:43:44 -0400
Received: from sven-desktop.home.narfation.org (p200300C5971113F0000000000000063E.dip0.t-ipconnect.de [IPv6:2003:c5:9711:13f0::63e])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 638981FEDA;
        Wed, 18 Sep 2019 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1568808857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U4tU03srKrA9+G7L8pLjlWRfYtpiLgB1ZSiQhRlxFpc=;
        b=qiHjqG3Z6Gpdx38f6T7Y2LBw6q+BN80NNoWwZcvT0GudYONbPwHPGk+C7g80fcNV2koWv1
        NS/pBEylmAtb802JdjMXnbu2UH6sm+DzVCvvtigD4Hno4tO1JOTeZ5dCfNFH61dvFswKBt
        5j5LojxS9VUHy+fulbPS262xfp4+FPE=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath10k@lists.infradead.org
Cc:     vnaralas@codeaurora.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
Subject: [RFC PATCH 0/2] ath10k: provide survey info as accumulated data
Date:   Wed, 18 Sep 2019 14:42:57 +0200
Message-Id: <20190918124259.17804-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1568808857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U4tU03srKrA9+G7L8pLjlWRfYtpiLgB1ZSiQhRlxFpc=;
        b=fb9LpbdU+XBsWMxt2sl1gzr6zA4DSPFVAmHmDDPUJMHCzFyfRW6Ytkn5JEQqf58flQWlrL
        /Cwx1UOAj4hliZn789gmq+sbKF5veuKyJRxTfxYMzcgPzTDzkEymItmCJu99Bawe/7bAA8
        06fNQAK6wPjkQN36GepmTZ/VT833GeM=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1568808857; a=rsa-sha256;
        cv=none;
        b=DausyOTSzNPhzI77Ofdh1AusnpUprJBXA8mh0IoGFdMrT0Pgs9VvPbEKyyGy3zgjPVA3lw
        DBjs21XfFgWqKDB4RGgr4GYsOBO8l4WPgQPfJ2uNPGlbIz9k73VeILUGSNxM2+xouiNf9A
        KdmMfOO5wQPjkdbOiujXAjK2qscwb5k=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sven Eckelmann <seckelmann@datto.com>

Hi,

it was observed that ath9k provides accumulated survey counters but ath10k
neither provides deltas nor accumulated counters. Instead it returns
some value which was returned at some point from the firmware.

But as it turns out, this data is not reliable. To make it more useful,
ath10k has to:

* retrieve counters rather frequently for hardware which is known to use
  firmware versions with low number counter bits (for only 14-30s)
* clean up received counter values 
* accumulate counters from firmware

A comparison of the resulting output with these fixes can be seen under
https://stats.freifunk-vogtland.net/d/ffv_node/nodeinfo?orgId=1&var-node=ac86749f4d60&fullscreen&panelId=5&from=1568782046974&to=1568807068706

The left side of the graph shows the output before the patches were applied
and the right side the output with the patches applied. Just as reference, an
ath9k device in the same building is
https://stats.freifunk-vogtland.net/d/ffv_node/nodeinfo?orgId=1&var-node=ac86740037e0&fullscreen&panelId=5&from=1568782046974&to=1568807068706

Kind regards,
	Sven

Sven Eckelmann (2):
  ath10k: report survey info as accumulated values
  ath10k: regularly fetch survey counters

 drivers/net/wireless/ath/ath10k/core.c |  8 ++++
 drivers/net/wireless/ath/ath10k/core.h |  3 ++
 drivers/net/wireless/ath/ath10k/hw.c   | 13 +++--
 drivers/net/wireless/ath/ath10k/mac.c  | 52 ++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/mac.h  |  3 ++
 drivers/net/wireless/ath/ath10k/wmi.c  | 66 ++++++++++++++++++++++----
 6 files changed, 130 insertions(+), 15 deletions(-)

-- 
2.20.1

