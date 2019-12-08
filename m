Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CC5116197
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2019 14:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLHNIM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Dec 2019 08:08:12 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:35598 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfLHNIM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Dec 2019 08:08:12 -0500
Received: by mail-oi1-f175.google.com with SMTP id k196so4015408oib.2
        for <linux-wireless@vger.kernel.org>; Sun, 08 Dec 2019 05:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tR/6ublMBio7uQfA+4JFH55Ovy54NhuFbK2PM8IYbG0=;
        b=QxEXwjqgxioYeqJprOSLAiLLD8NDXxRuOuNfYWdt2O2RzFniEYpubjIDjuugSmKrt2
         3iURpLx67RhhSXtYSR4V7evdyYsvSvDKcE3OlI4YVnkPjTV6Io0R2nRB4j5+nk/rPf9I
         Ri6OO+iZMp4CJs7fazngXiqGACHTjlLYD1xcpteovf3mKbv3S0IEFxrJ0cMJVu3yY1TJ
         xCb76fKwoioLWmAijfIdCoqJjx82U9fGAuDU2uhXwYk04p2siiOmT4IYjFipjGXFrKLJ
         uaWMxWsosEIYJw4VdABbqnlCTT9ASU5nAIdcaDuCy3v3e1KUauGfc3Lh52EHc1aQK3GG
         omwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tR/6ublMBio7uQfA+4JFH55Ovy54NhuFbK2PM8IYbG0=;
        b=DJbfREVWiNwk1//CtYs9f+U4ibo4WAQSC64O7uMTIHY3bNpvAOZ/6yMZtqtRxcS6oO
         aBMrSW6rRdrpvlmDnXJnb+p41aVi28vWMhyeis2mZ87i7sHEjQVLh3alZorkKYslm3gW
         PvMYTJRGqN1/5DFMjgS4+bZaR8k5Zp0oG24lURItqccF/D42qWcojPOcq+USnRs5IzqN
         QMQ6tNa6oByvdCCk+v/Lzit8u1pC0modKdPngaV5aK+O/eDl50Rnl5o1PGCcEW1K7Y4h
         3UnQx8tdSTYPp7TQUBdF369fxeOGg6KOFHsVbUmayy+O5DqDx3azn2YbogUGcXUeAplZ
         FP/g==
X-Gm-Message-State: APjAAAVH4+QSCphXza2xvllFHGxMN73E9ap1b38/I886I4ZW3Ts67csH
        B9jzCC5TptOmAw+N69U56fA=
X-Google-Smtp-Source: APXvYqyrw1Cerm68hBjabTeYpOzb/Ot+ENakfFIgTNEtL4LJivAwPp80wIvHGWMKOZpV0Ji6KlZllQ==
X-Received: by 2002:aca:3182:: with SMTP id x124mr20905747oix.170.1575810491561;
        Sun, 08 Dec 2019 05:08:11 -0800 (PST)
Received: from hari-Latitude-E6430.utdallas.edu (cpe-76-184-237-208.tx.res.rr.com. [76.184.237.208])
        by smtp.gmail.com with ESMTPSA id w12sm7030004otk.75.2019.12.08.05.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 05:08:10 -0800 (PST)
From:   Hari Nagalla <hnagalla@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, maitalm@ti.com, hnagalla@gmail.com
Subject: [[PATCH mac80211] 0/1] *** mesh: handle secured PREQ frames ***
Date:   Sun,  8 Dec 2019 07:07:50 -0600
Message-Id: <20191208130750.5402-2-hnagalla@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191208130750.5402-1-hnagalla@gmail.com>
References: <20191208130750.5402-1-hnagalla@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

*** BLURB HERE ***

Maital Hahn (1):
  ieee80211: mesh: handle secured PREQ frames

 include/linux/ieee80211.h | 19 +++++++++++++++++++
 net/mac80211/tx.c         | 13 ++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.17.1

