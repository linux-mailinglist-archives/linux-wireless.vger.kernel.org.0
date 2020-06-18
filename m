Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54571FEE5C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 11:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgFRJMv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgFRJMu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 05:12:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB969C06174E
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2020 02:12:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so5195598wru.12
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2020 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=htZbEn2KdpU7eJSh8yuTo6kkxCsr60rcFS9ASpUroDc=;
        b=oAPKBxcEr26oMMyckNnQUIwAZx87dkFiPrebVQtN2jI08/jwvOran7V7Q6WG+GqJ2S
         V3I+Rzemd9LQtEkm9ajEpGumfW+RRnhaNCyO2KgDirPg8eq/SUcYoVpNWwvXFZvfLt9C
         e/YAe4+NJL7oDiJVWwMmgBYEOhyISHd3GAzgsYml1nSSKkiY1JE5pC5JVEiWkKkPhJHn
         Pgeiqo1vA1g4pV1o1jdwXBegy+RmqGZbpSwTcPahoOCZzXwm38/y0Yk+pj9sDpfL1pzW
         +miIxAaIcwWJRlJGuMuYHNAxxdT4pNus6O6KENrKqnra1Ap6YM8P31Nt1kucwPCQP3IH
         4Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=htZbEn2KdpU7eJSh8yuTo6kkxCsr60rcFS9ASpUroDc=;
        b=ctDMtEXZbkcUeMglB61qIAQAjzsHU2ZLYyuCkgbO8zXpP9ux6wf0Re9+fuUVvfU3YE
         88lyjDaCLEHjP15SUTO8kJ/udcw/GDeFZ0zaVwJdYzhrPLui7/IA1okmg2iene89s2Ke
         0+et0bBhnAOyrEu3+G+r3rwm79pwK4LILAA5XNqwTbVn/g9+G0wkz3lZhkXU9pe39OCm
         Yu4w5Z+8FkXPrIlbA0nobl0aIHnq3bhAeQamuo41IeFBTzMbEGnY1i9sFCqgIn/gRn6x
         5m++CJGthug8Ku3IWM0wRSujjJ5534Wm84293oTLMhbw2jWcld+L509YgAGCtcRmEjYf
         NUyw==
X-Gm-Message-State: AOAM531bw0/8cTiYme+SZlxGOADgpUDdJCDpcdNhH/avNyg68tQ8nO+c
        5b9n3UMJQS/nzpaOrlMktPPXGQ==
X-Google-Smtp-Source: ABdhPJx/lNknKhNijdO2ZmhuKAzPw/kLw9qAnqH+i+nziTBKUN2q9yAFd263yAYdYUqGAUd6WLeOJw==
X-Received: by 2002:adf:80e6:: with SMTP id 93mr3407450wrl.17.1592471568684;
        Thu, 18 Jun 2020 02:12:48 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id x13sm2733702wre.83.2020.06.18.02.12.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 02:12:48 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org, johannes@sipsolutions.net
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 1/2] mac80211: Do not report beacon loss if beacon filtering enabled
Date:   Thu, 18 Jun 2020 11:17:42 +0200
Message-Id: <1592471863-31402-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mac80211.h says: Beacon filter support is advertised with the
IEEE80211_VIF_BEACON_FILTER interface capability. The driver needs to
enable beacon filter support whenever power save is enabled, that is
IEEE80211_CONF_PS is set. When power save is enabled, the stack will
not check for beacon loss and the driver needs to notify about loss
of beacons with ieee80211_beacon_loss().

Some controllers may want to dynamically enable the beacon filter
capabilities on power save entry (CONF_PS) and disable it on exit.
This is the case for the wcn36xx driver which only supports beacon
filtering in PS mode (no CONNECTION_MONITOR support).

When the mac80211 beacon monitor timer expires, the beacon filter
flag must be checked again in case it as been changed in between
(e.g. vif moved to PS mode).

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 net/mac80211/mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 16d75da..1f7dfaa 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4494,6 +4494,9 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 	if (sdata->vif.csa_active && !ifmgd->csa_waiting_bcn)
 		return;
 
+	if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)
+		return;
+
 	sdata->u.mgd.connection_loss = false;
 	ieee80211_queue_work(&sdata->local->hw,
 			     &sdata->u.mgd.beacon_connection_loss_work);
-- 
2.7.4

