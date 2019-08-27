Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C58C9F658
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 00:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH0Wqn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 18:46:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40177 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfH0Wqn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 18:46:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id h21so568496oie.7
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 15:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25chdCYf0WLbaWJ1yIXHrz2KNV2ouPI+/8g6eWTkRUI=;
        b=LqwsHri3SSoNnYgDZb0EaU9XfJlUik2go+7NkZ+K3u5bpmktEX/VcMYgNOM5OZKJC3
         n1Zk3gQ2D57owbQ1HfnNsCmcwKx0KjWmfqAfYI5lPRG+v+4+AATyUzE+BDWWwIvMX59D
         23X+LRg1w0xZbSAOkDGEbf0NBl1Gh/FA06Vom9VUOPqDlSDcUvrfKqY9bdJp9AGrA679
         EmE6nsYgrZ5OdAlfY1ii2wjPMXLQnTJeS4gmhRx8F9cGTMy93AbcjZTyXS8ppBt3pl41
         TlKlbJj+uVCA6JI23RwfcN3bXGYeYPZG3PjCBLFhdUMfLLBIG4T7aJAybXTH2q/Q1wb+
         HP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25chdCYf0WLbaWJ1yIXHrz2KNV2ouPI+/8g6eWTkRUI=;
        b=nY9am3K91GHgfDitvHQO6XqFTRUhJM+6p7ruqdjswcNrexWYM7l6fbJl52EQjNTgcH
         JaB19FDCn/QLZIKehhPSPg11WOUj1yYhEnW4XYgihMvfMPvdpeam29WBjEeNuOTli2JP
         fERsTv1sSczwlQMAwNhnjquVZCqSKuvxMqw/KT5H5zJ8VznEpTf7homDR0/5dtXAOVyy
         hQYddkpGZTcCPBfYfZxhSUmjpWKxBo5ZEwzEmmmIYKSUHpR5W+ZA3WlmgdxY9YfMCPw7
         dXbVz3HR9HDSudoQmPGAfmSUvX1fI17n8QIfMUV2Zsqrqc3cRj2L+y/eE+mVVW+CZ+0A
         SBFw==
X-Gm-Message-State: APjAAAXG9ngOrm1VfJQMSiY4eEeNchyGVZoxOcQ/aZ56qZmjGJtPuHZX
        +B2gLfgQQJKRLENpg+Z4vTcO1bdN
X-Google-Smtp-Source: APXvYqwdV3PAgnTYkwWGSSDQSKDb8PFM+W4FSP7zH7131Tqa/JfmbfAcuwAZdHirrqGE+Vm0As30mg==
X-Received: by 2002:a54:4715:: with SMTP id k21mr752798oik.125.1566946002461;
        Tue, 27 Aug 2019 15:46:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a94sm289911otb.15.2019.08.27.15.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 15:46:41 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 0/2] mac80211: Control Port over nl80211 fixes
Date:   Tue, 27 Aug 2019 17:41:18 -0500
Message-Id: <20190827224120.14545-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Couple of small fixes for Control Port handling in mac80211.  The
original commit was working by some crazy luck in all testing, but
manifested itself on certain hardware that managed to drop PAE frames
with uncanny consistency.

Denis Kenzior (2):
  mac80211: Don't memset RXCB prior to PAE intercept
  mac80211: Correctly set noencrypt for PAE frames

 net/mac80211/rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.2

