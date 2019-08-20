Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7963396599
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfHTPxQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:53:16 -0400
Received: from gesmail.globaledgesoft.com ([182.73.204.242]:54738 "EHLO
        gesmail.globaledgesoft.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbfHTPxQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:53:16 -0400
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 11:53:16 EDT
Received: from mail.globaledgesoft.com (mail.globaledgesoft.com [172.16.2.30])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gesmail.globaledgesoft.com (Postfix) with ESMTP id AD8517C884D;
        Tue, 20 Aug 2019 21:12:06 +0530 (IST)
Received: from mail.globaledgesoft.com (localhost [127.0.0.1])
        by mail.globaledgesoft.com (Postfix) with ESMTPS id 1118AB8089E;
        Tue, 20 Aug 2019 21:18:35 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.globaledgesoft.com (Postfix) with ESMTP id E23B1B80855;
        Tue, 20 Aug 2019 21:18:34 +0530 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mail.globaledgesoft.com
Received: from mail.globaledgesoft.com ([127.0.0.1])
        by localhost (mail.globaledgesoft.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YtwXZlCJ_6Au; Tue, 20 Aug 2019 21:18:34 +0530 (IST)
Received: from localhost.localdomain (unknown [172.16.2.250])
        by mail.globaledgesoft.com (Postfix) with ESMTPSA id A468DB8071C;
        Tue, 20 Aug 2019 21:18:34 +0530 (IST)
From:   Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
To:     lorenzo.bianconi83@gmail.com
Cc:     linux-wireless@vger.kernel.org,
        Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
Subject: [PATCH 1/1] [MT76x02] [STA interface]
Date:   Tue, 20 Aug 2019 21:12:31 +0530
Message-Id: <1566315751-7688-1-git-send-email-b.balakrishna@globaledgesoft.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT76-Station sends class 3 frames after deauthentication from 3rd party AP
(Sending BAR frame after deauth).

Fix to be, do not send BAR frame after deauth.

Signed-off-by: Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index ad53234..0126601 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -375,7 +375,6 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		ieee80211_send_bar(vif, sta->addr, tid, mtxq->agg_ssn);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(*ssn);
-- 
1.9.1

Disclaimer:- The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. The views expressed in this E-mail message (including the enclosure/(s) or attachment/(s) if any) are those of the individual sender, except where the sender expressly, and with authority, states them to be the views of GlobalEdge. Before opening any mail and attachments please check them for viruses .GlobalEdge does not accept any liability for virus infected mails.

