Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38BB6534D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfGKIql (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 04:46:41 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:41222 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728027AbfGKIqj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 04:46:39 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 3183430C039;
        Thu, 11 Jul 2019 01:46:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 3183430C039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1562834798;
        bh=NOsPXG/D/+T/gNffik1hH2dKEY0l685dSw33GceaDiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6mdIbFjrmDd8RMd5IvTs2MFriO7/46fwcN+xsoWtfgwwzam+clcbjLmpJ9a3ZUxw
         D8q8Z8BZ/yMADW/h9y9zfjh2J/kFHSn2GT5mh657BiiQ2rbJR2E+L/iDa5ro65tQ8R
         0pkPlL6aVumk+tnHZzOfKO2pDD+gT8STfaJDZ6sc=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 024E260D1D;
        Thu, 11 Jul 2019 01:46:38 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 13A91B00668; Thu, 11 Jul 2019 10:46:35 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/3] brcmfmac: add 160MHz in chandef_to_chanspec()
Date:   Thu, 11 Jul 2019 10:45:30 +0200
Message-Id: <1562834732-31508-2-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562834732-31508-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1562834732-31508-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function chandef_to_chanspec() was not handling 160MHz bandwidth
resulting in wrong encoding of the channel. That resulting in firmware
rejecting the provided channel specification.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index b6d0df3..5168d42 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -276,8 +276,26 @@ static u16 chandef_to_chanspec(struct brcmu_d11inf *d11inf,
 		else
 			ch_inf.sb = BRCMU_CHAN_SB_UU;
 		break;
-	case NL80211_CHAN_WIDTH_80P80:
 	case NL80211_CHAN_WIDTH_160:
+		ch_inf.bw = BRCMU_CHAN_BW_160;
+		if (primary_offset == -70)
+			ch_inf.sb = BRCMU_CHAN_SB_LLL;
+		else if (primary_offset == -50)
+			ch_inf.sb = BRCMU_CHAN_SB_LLU;
+		else if (primary_offset == -30)
+			ch_inf.sb = BRCMU_CHAN_SB_LUL;
+		else if (primary_offset == -10)
+			ch_inf.sb = BRCMU_CHAN_SB_LUU;
+		else if (primary_offset == 10)
+			ch_inf.sb = BRCMU_CHAN_SB_ULL;
+		else if (primary_offset == 30)
+			ch_inf.sb = BRCMU_CHAN_SB_ULU;
+		else if (primary_offset == 50)
+			ch_inf.sb = BRCMU_CHAN_SB_UUL;
+		else
+			ch_inf.sb = BRCMU_CHAN_SB_UUU;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
 	case NL80211_CHAN_WIDTH_5:
 	case NL80211_CHAN_WIDTH_10:
 	default:
@@ -296,6 +314,7 @@ static u16 chandef_to_chanspec(struct brcmu_d11inf *d11inf,
 	}
 	d11inf->encchspec(&ch_inf);
 
+	brcmf_dbg(TRACE, "chanspec: 0x%x\n", ch_inf.chspec);
 	return ch_inf.chspec;
 }
 
-- 
1.9.1

