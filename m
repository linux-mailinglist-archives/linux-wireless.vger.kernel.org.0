Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF44739F
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfFPHcY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:32:24 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:58169 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbfFPHcY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:32:24 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jun 2019 03:32:22 EDT
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 16 Jun 2019 09:26:16 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9289"; a="8499841"
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg02-ams.qualcomm.com with ESMTP; 16 Jun 2019 09:26:16 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 11/11] wil6210: drop old event after wmi_call timeout
Date:   Sun, 16 Jun 2019 10:26:07 +0300
Message-Id: <1560669967-23706-12-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
References: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ahmad Masri <amasri@codeaurora.org>

This change fixes a rare race condition of handling WMI events after
wmi_call expires.

wmi_recv_cmd immediately handles an event when reply_buf is defined and
a wmi_call is waiting for the event.
However, in case the wmi_call has already timed-out, there will be no
waiting/running wmi_call and the event will be queued in WMI queue and
will be handled later in wmi_event_handle.
Meanwhile, a new similar wmi_call for the same command and event may
be issued. In this case, when handling the queued event we got WARN_ON
printed.

Fixing this case as a valid timeout and drop the unexpected event.

Signed-off-by: Ahmad Masri <amasri@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 542ef15..475b1a2 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -3303,7 +3303,18 @@ static void wmi_event_handle(struct wil6210_priv *wil,
 		/* check if someone waits for this event */
 		if (wil->reply_id && wil->reply_id == id &&
 		    wil->reply_mid == mid) {
-			WARN_ON(wil->reply_buf);
+			if (wil->reply_buf) {
+				/* event received while wmi_call is waiting
+				 * with a buffer. Such event should be handled
+				 * in wmi_recv_cmd function. Handling the event
+				 * here means a previous wmi_call was timeout.
+				 * Drop the event and do not handle it.
+				 */
+				wil_err(wil,
+					"Old event (%d, %s) while wmi_call is waiting. Drop it and Continue waiting\n",
+					id, eventid2name(id));
+				return;
+			}
 
 			wmi_evt_call_handler(vif, id, evt_data,
 					     len - sizeof(*wmi));
-- 
1.9.1

