Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B9E1A69BA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2020 18:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbgDMQVB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Apr 2020 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731410AbgDMQVA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Apr 2020 12:21:00 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E5BC0A3BDC
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2020 09:21:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l1so4681818pff.10
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2020 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZ87g3+hZwo3IPgpVTfaLkO2pQdeEeP4I4vsWs0xg6g=;
        b=PylV2TuuJeUD9qDYywfx4Lby2klZcP36TJi6QyMr7rWdEGszJQ9q8hfrXgf0+TetwA
         G+Pktbvvw+00PQtu2CH0U22y30MwSveXPEEK7zqUJI8BkrFeVC+eMhTEqIJJSuVGvo3r
         RUCK6xju8RBJ+qoDS+1L6JGvml4JZ946/txHK+zc6AmLYZx5+5nttwRFTVxkle+8uH39
         VUjpGlqa1oLNVbOjg2f6b1R3hQivJ0eCrYILvo2pyUvO695XeyIuRnUZbYvPnSknRvg9
         WyV18AuzEg3RIKjMDcLEN+1cGEs8ClrfUlUSfNF9JNR+o4TQXttSSHiFHQZSLnQb2I6t
         Ij1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZ87g3+hZwo3IPgpVTfaLkO2pQdeEeP4I4vsWs0xg6g=;
        b=rbqs7JxS5dv142Ae2z5c38kPMV2sZLdpe5Rhn1dReVNFiAFQBoS52TWk3t8fSgpXPi
         w+Qy8O2X5Xg7VJyEUNOxycLqaiQ6Y39Pgaddg3TF6LlKMLZ3uRVl0RbxPJvLUkDeEpVW
         TvFIMyc+Wa84HwbETxf/JhzG2wA8OyK2VKHKpu0Wkxkr10G3Nuw8FAkU0lMXCYBWZ9B3
         kAlNlrb+bBc2xFGuSple+ob3LlIkvs9VDwXtgNi0pUs8OrhjohPo+On0SHt71UtIUoVx
         PjhmH1qFmqVqgBF8Ll9/KIUfPiUUOZOsLh4vzYq5bRjBgFsgjxkkd8bEjYqwJn6nBwwF
         rjDA==
X-Gm-Message-State: AGi0PuYSLONNZFRipzFW1CPpKYariuTOtv89xvuCnq/q5EYJpqXaqOIf
        NDwZNLaBgm6mYBopdoixVV89/l3XUNA=
X-Google-Smtp-Source: APiQypJ9YuT+qBmjYDHnrWK8T0td4vE34LSli1R9PD9LzuD/osi5hiqVtp30nIR0rcYHg82/391t1w==
X-Received: by 2002:a62:2a8c:: with SMTP id q134mr19226249pfq.35.1586794859772;
        Mon, 13 Apr 2020 09:20:59 -0700 (PDT)
Received: from unknown7c7a912bd80b.home (50-39-169-98.bvtn.or.frontiernet.net. [50.39.169.98])
        by smtp.gmail.com with ESMTPSA id e4sm6308337pfn.199.2020.04.13.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:20:59 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] nl80211: fix PORT_AUTHORIZED wording to reflect behavior
Date:   Mon, 13 Apr 2020 09:20:53 -0700
Message-Id: <20200413162053.3711-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The CMD_PORT_AUTHORIZED event was described as an event which indicated
a successfully completed 4-way handshake. But the behavior was
not as advertized. The only driver which uses this is brcmfmac, and
this driver only sends the event after a successful 8021x-FT roam.

This prevents userspace applications from knowing if the 4-way completed
on:

1. Normal 8021x connects
2. Normal PSK connections
3. FT-PSK roams

wpa_supplicant handles this incorrect behavior by just completing
the connection after association, before the 4-way has completed.
If the 4-way ends up failing it disconnects at that point.

Since this behavior appears to be expected (wpa_s handles it this
way) I have changed the wording in the API description to reflect the
actual behavior.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 include/uapi/linux/nl80211.h | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 5eab191607f8..42161d985004 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -611,13 +611,9 @@
  *	authentication/association or not receiving a response from the AP.
  *	Non-zero %NL80211_ATTR_STATUS_CODE value is indicated in that case as
  *	well to remain backwards compatible.
- *	When establishing a security association, drivers that support 4 way
- *	handshake offload should send %NL80211_CMD_PORT_AUTHORIZED event when
- *	the 4 way handshake is completed successfully.
  * @NL80211_CMD_ROAM: Notification indicating the card/driver roamed by itself.
- *	When a security association was established with the new AP (e.g. if
- *	the FT protocol was used for roaming or the driver completed the 4 way
- *	handshake), this event should be followed by an
+ *	When a security association was established on an 8021x network using
+ *	fast transition, this event should be followed by an
  *	%NL80211_CMD_PORT_AUTHORIZED event.
  * @NL80211_CMD_DISCONNECT: drop a given connection; also used to notify
  *	userspace that a connection was dropped by the AP or due to other
@@ -1027,13 +1023,11 @@
  * @NL80211_CMD_DEL_PMK: For offloaded 4-Way handshake, delete the previously
  *	configured PMK for the authenticator address identified by
  *	%NL80211_ATTR_MAC.
- * @NL80211_CMD_PORT_AUTHORIZED: An event that indicates that the 4 way
- *	handshake was completed successfully by the driver. The BSSID is
- *	specified with %NL80211_ATTR_MAC. Drivers that support 4 way handshake
- *	offload should send this event after indicating 802.11 association with
- *	%NL80211_CMD_CONNECT or %NL80211_CMD_ROAM. If the 4 way handshake failed
- *	%NL80211_CMD_DISCONNECT should be indicated instead.
- *
+ * @NL80211_CMD_PORT_AUTHORIZED: An event that indicates an 8021x FT roam was
+ *	completed successfully. Drivers that support 4 way handshake offload
+ *	should send this event after indicating 8021x FT assocation with
+ *	%NL80211_CMD_ROAM. If the 4 way handshake failed %NL80211_CMD_DISCONNECT
+ *	should be indicated instead.
  * @NL80211_CMD_CONTROL_PORT_FRAME: Control Port (e.g. PAE) frame TX request
  *	and RX notification.  This command is used both as a request to transmit
  *	a control port frame and as a notification that a control port frame
-- 
2.21.1

