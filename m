Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D78F8ED5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 12:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKLLpy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 06:45:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40890 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLLpx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 06:45:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 79D8260C8E; Tue, 12 Nov 2019 11:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573559153;
        bh=wz3oG8OpGyjsewLjRaLui0r/tB4QR1IRQFE2q5GQ81I=;
        h=From:To:Cc:Subject:Date:From;
        b=KBVhJYOk5BbC6Jb0hystNVEH7nyvSTs08sijpc6dysTx1EbA2Ikn/ZP8baEmnvKVR
         kLWPa2Ou1pF4Y0zd8hGREtUXPQp8QJNuJoaz5udYahsUxyuVhg8htkQ+QP6Ix4NSkY
         FPGOtmUfYXoLvqGvz0U0QDWkbEN6lq8Ky3WJEpT0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from rex-laptop.wy-b52.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yyuwang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F249A602EF;
        Tue, 12 Nov 2019 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573559153;
        bh=wz3oG8OpGyjsewLjRaLui0r/tB4QR1IRQFE2q5GQ81I=;
        h=From:To:Cc:Subject:Date:From;
        b=KBVhJYOk5BbC6Jb0hystNVEH7nyvSTs08sijpc6dysTx1EbA2Ikn/ZP8baEmnvKVR
         kLWPa2Ou1pF4Y0zd8hGREtUXPQp8QJNuJoaz5udYahsUxyuVhg8htkQ+QP6Ix4NSkY
         FPGOtmUfYXoLvqGvz0U0QDWkbEN6lq8Ky3WJEpT0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F249A602EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yyuwang@codeaurora.org
From:   Yu Wang <yyuwang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] ath10k: correct tx bitrate for QCA6174/QCA9377/QCA9888
Date:   Tue, 12 Nov 2019 19:45:46 +0800
Message-Id: <1573559148-4844-1-git-send-email-yyuwang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tx bitrate got by command 'iw wlan0 link' is incorrect.
These 2 patches will fix the issue.

Yu Wang (2):
  ath10k: add ppdu stats support for QCA6174/QCA9377
  ath10k: correct legacy rate in tx stats

 drivers/net/wireless/ath/ath10k/htt.c     |   2 +
 drivers/net/wireless/ath/ath10k/htt.h     |  30 ++++++++
 drivers/net/wireless/ath/ath10k/htt_rx.c  | 113 ++++++++++++++++++++++--------
 drivers/net/wireless/ath/ath10k/mac.c     |  13 ----
 drivers/net/wireless/ath/ath10k/mac.h     |  11 +++
 drivers/net/wireless/ath/ath10k/wmi-ops.h |  15 +++-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |  42 +++++++++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h |   3 +
 drivers/net/wireless/ath/ath10k/wmi.c     |  46 ++++++++++++
 9 files changed, 232 insertions(+), 43 deletions(-)

-- 
2.7.4

