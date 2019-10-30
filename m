Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1116BEA564
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 22:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfJ3VcR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 17:32:17 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36759 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfJ3VcR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 17:32:17 -0400
Received: by mail-wm1-f49.google.com with SMTP id c22so3788309wmd.1
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2019 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kQcGM/AFNhj07R9Hx5bfDtCArlOgMmvHZZYlbVQDVRs=;
        b=cKYc43k/hrBvgUVd5YDSgXLVeIG2kV/iMstZsZkK6v/vwoxKFyj7fda+bNptM01O0L
         SRpmFFRRars2CfqgGdsHjlIpxhdTVZsR3i4AS68eC1hiPRCmFPYJb6rrd79zyAT8hSkE
         vOOlMUTUKwKSikuLDYbN/cyh1BAtOLqYAAPOePgsqAROqykW44m4mKsd+lZMJWW4sRLj
         9704mOYJrMmPH1UiJC3LuZZChnv07kRa5+VZNsmYqK97g42HRFvYnnMhtzZQan9ydlTA
         FxYvIxBYpbEF0oF4st7Kw7NqV4eQxUwAcf3XlyHbl1oV83nI4WnZphNplFdkWEaR196X
         PkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kQcGM/AFNhj07R9Hx5bfDtCArlOgMmvHZZYlbVQDVRs=;
        b=U36IPbRD71+UBRC9IN6l8ssUzORoDsmBUAiYFdV7py4fXrGY5TEfEOcEdzHABDC/Kj
         VWoParXfi6dIV8MYr38ANaSuV8USxsxzwkQ/GDYV7SO6sxbWK5sgVl4cYHOsSaqd/m7c
         bSzYzMD/c69SMJMvpGR7inupmiEXR67gSU+HD6iQXWNzbDZELmbnFYcS5TJ70Eq53jkb
         S3nXcXT03yeVMLRypekMKp4hRFzrcHAc5B3CYAPWvfiGun57yzgPAVB8MNCxycfPwi4q
         wKl8ILbWCgv42pCvBMQyDp5lrDbmsqkCYYJ2Q+dFdaPouXpGtR26C02SFL4KXMLLJu+A
         ddqg==
X-Gm-Message-State: APjAAAUJE/bys58SlqdQE293k7Rx+dMF7NueRZBSYAEVlnLbjtLIfqzM
        ky/fykwgiULSwWsN/u/c7DxmRlZW
X-Google-Smtp-Source: APXvYqyHpvHC48rG/rOhRsgM3jmLgBlgp9kKS5Fdu9h8grvYGX/mNg5O9ATmTDGnVvYuCci8d8fvvQ==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr1431376wmi.4.1572471134536;
        Wed, 30 Oct 2019 14:32:14 -0700 (PDT)
Received: from localhost.localdomain ([156.197.16.66])
        by smtp.googlemail.com with ESMTPSA id z189sm1560542wmc.25.2019.10.30.14.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:32:13 -0700 (PDT)
From:   Ahmed Zaki <anzaki@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     anzaki@gmail.com
Subject: [PATCH 0/1] sta_info: fix insane values in iw sta dump "inactive time"
Date:   Wed, 30 Oct 2019 15:31:52 -0600
Message-Id: <20191030213153.3196-1-anzaki@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While working on an IBSS network with ath10k-ct, the iw station dump
shows insanly high values in the "inactive time". The values are
clearly the initial jiifies of the system.

Debugging showed that this happens when the ieee80211_sta_last_active
is called while last_ack == 0. In this case, it returns zero and the
inactive time shows the system jiffies. This continues until the
jiffies wrap back to zero (about 5 minutes).

Ahmed Zaki (1):
  sta_info: fix insane values in iw sta dump "inactive time"

 net/mac80211/sta_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.17.1

