Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41433810F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Mar 2021 00:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCKXGJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Mar 2021 18:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhCKXFj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Mar 2021 18:05:39 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DB6C061574
        for <linux-wireless@vger.kernel.org>; Thu, 11 Mar 2021 15:05:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o38so14620939pgm.9
        for <linux-wireless@vger.kernel.org>; Thu, 11 Mar 2021 15:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Da9GxoSQk57Tcb2hfIvd8QjmzuEWMdAsPWOiEuCWZOo=;
        b=Dk9yRwmD88lN0V+KrzYrKTGgaLw/9C2IlSrEk1zk91FlZ6f35dQOObEpBMTxFmz8TS
         x26TPlGBRkHsQw9k0GDBSAfK045UQVOL3993okO8sWapd4KP1rWl/3gmap0oSm33/ZTU
         d/UdOt2ZNIZs0SAAmF1Pz7iXbuG+L2SAcqTyjl219laPVkmOpIXOK4nYgyuBaMnug16P
         vM/6ZGIdIuehf8vkLLYR0ITNv6frTn7oiUrS1lCAScZxxCRWdTdjd+JRDTD83wqvNAxM
         +CEhfScvjvXP32jSTDZiMNm3NPHLuIKflCAx5CoenQ1HONC/l5yol95V130cRPvjuQ4m
         FmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Da9GxoSQk57Tcb2hfIvd8QjmzuEWMdAsPWOiEuCWZOo=;
        b=sjIbLPFUsSJq/gtAXXYJJeCeQ7nlbeUv7A+UDZpcetWKM6fSI6q4XAJoB4qLZ+DEgs
         SLT+hQ38rNNDQ9S77b/E1XCxqfAkrpZ78fp6p8yc7TDsFGFbscRKrOE+d1m+nwpE0QUK
         yoDSF8Uy89CIeFvbk+LI+SRAC3vg6i4H55qb+Yfw7oMVae/X2cN6iRHu5LiEs8jrBVGe
         q4x+6fpOeDSG0T6RrUmUAPK2vTQgItu8d2zBwhjozo5gzBWe+1NiXCSzQBaiZLv644R3
         zKUHinVvmkVETSNl6PbrET1nKCkG0iauXPEA/nisGq/oxkBhdXQH/pkVEZuMAYaj7Dxf
         gnnw==
X-Gm-Message-State: AOAM530Rwc5sSwHa+UzCJr1eBQWuE42DrFK5UCqqYWb+IFJ1QFcZlTJq
        bIxUOEwKrjoye2Yu5Zf6/AVcKvbyZxA=
X-Google-Smtp-Source: ABdhPJy2e6b646GignpEzQWnNEDbaoUPmHpKlsUrWq96cljs1bWcgMLUY9d3w+gIMoPWVPiusadu1g==
X-Received: by 2002:aa7:9521:0:b029:1f1:b27f:1a43 with SMTP id c1-20020aa795210000b02901f1b27f1a43mr9516256pfp.4.1615503938093;
        Thu, 11 Mar 2021 15:05:38 -0800 (PST)
Received: from localhost.localdomain ([50.39.173.103])
        by smtp.gmail.com with ESMTPSA id a7sm3336061pfo.105.2021.03.11.15.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:05:37 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] include: nl80211: better document CMD_ROAM behavior
Date:   Thu, 11 Mar 2021 15:03:33 -0800
Message-Id: <20210311230333.103934-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The docs were very sparse with how exactly CMD_ROAM should be
used. Specifically related to BSS information normally obtained
through a user space scan.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 include/uapi/linux/nl80211.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ac78da99fccd..5e30c7f6c484 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -655,6 +655,9 @@
  *	When a security association was established on an 802.1X network using
  *	fast transition, this event should be followed by an
  *	%NL80211_CMD_PORT_AUTHORIZED event.
+ *	Following a %NL80211_CMD_ROAM event userspace can issue
+ *	%NL80211_CMD_GET_SCAN in order to obtain the scan information for the
+ *	new BSS the card/driver roamed to.
  * @NL80211_CMD_DISCONNECT: drop a given connection; also used to notify
  *	userspace that a connection was dropped by the AP or due to other
  *	reasons, for this the %NL80211_ATTR_DISCONNECTED_BY_AP and
-- 
2.26.2

