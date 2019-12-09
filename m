Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99114116AFF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 11:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLIK2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 05:28:53 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:34405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfLIK2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 05:28:53 -0500
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1N95qT-1hhsrn3N2t-0167Lz; Mon, 09 Dec 2019 11:28:48 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: [RFC PATCH v1 1/4] ath6kl: Do not allow deleting station in IBSS mode.
Date:   Mon,  9 Dec 2019 11:28:06 +0100
Message-Id: <20191209102808.12014-2-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <m34l02mh71.fsf@t19.piap.pl>
References: <m34l02mh71.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:44MY0Sp46rDjtXOtTpT3qFrHig2wcJD4BT0LJ73tWT6AP+ZUG+e
 Mt3UFMd5VTUqCZWbUg/uuazV/b7FksrEktqB+oK7AIKgf268JONcVLHeSaxQ2t+aZq3T1QO
 cIrlNpWxLBb3diiEYw19E4Ue877mhTemgTfMFP40VDQPJkH7BNQpVSsSL4q8NTgXralc4lM
 E+gAFhILdiKOFUdIfN0eQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2V0qm49HZUM=:YkZtfDARt7pzAVYngAd1Wo
 jM/XTXaNYTLUSAQspTqDOQCVz+jLCX4Qhh3OT4uKgLYstchCCwRIvxMgOxYtANzaxPfmXZbRU
 s6O/qL9K8tlkObHF+vHyBb0q4wJ0q83UoCdOWskpP1rQV1NvZaL0t9XZ43fognhw7Tg5nlIgJ
 1Dpw6LKi5MAuwA3IDHLXAfkW6+BPQRVBoWwfjY/412bKMuS9SOBeaDBNZcQWti9j/jsOApsN9
 +67iUhM1vqkcUDpCsxCqL1HojysA7lRbuXnmasgITF9ZaOE4/POYtV8U+Ksb4FErCqCe0AoAC
 AK65OeMhdEpD0i6GFoosxf7mLbwrAGAEvyT/fBiG8XduKSVG3Ovl7VMhzf5UHXUI5l9QGydIV
 m8AUkJ/2zMKI98hPIgzizT1uElqVJQ6Uas/AHh1wTmWYiwMUTPqz88lrjGCAs1uKysNcKPgBk
 JwahQadqo6Fijv7F6c8gCV03oKSGOwimQNDjIOLkZ3QKNnumV8DaD/e0dMGlb17waDYIVLaFC
 Cuxe3NHjoqI5vQqwQSx1TAC/JbQazk13l8TMir834VHr8WZv3Ly3Tootqzyg/m8Y2kdHbNXeZ
 PmRKazNr1u2az85VnWTu+DkDKB9NJ4su/tzzep7NW7UgPkdRxhsbSFiT/MPOr8p2qAdnEJbAJ
 e5b1I+1ojoKjYQ8hxVFwK9d/i0a6xJZwU7ZhAeXYFfBniCtYQvNinq00rCIHytFqZBVjY1Hkv
 1hsBATn1jIUcByESxe+kPM/Xv+P2udHY2514qy5stbFFvmfwsr4MOlYMMl3vlGff3TXrnlusp
 ohmn8ZPV9N69vZK+ZEs564LnNEJaURJ1Yt2AKDaV/AOviz2RFpsdTYopxjgdg83h9MlOet8N0
 k3Hmryq87+1eD/LTJZzXOKbhTrIuM6Z8UTFXBw7vgafVduzti9u3fmR1XX34Cl
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation of allowing userspace to explicitly reset station state
in IBSS mode, reject attempts to delete stations in IBSS mode with error
ENOTSUPP.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
--
I do not know if the driver could possibly support this, so take the
safe route and reject it.
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 37cf602d8adf..c894b9756605 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -2993,6 +2993,9 @@ static int ath6kl_del_station(struct wiphy *wiphy, struct net_device *dev,
 	struct ath6kl *ar = ath6kl_priv(dev);
 	struct ath6kl_vif *vif = netdev_priv(dev);
 	const u8 *addr = params->mac ? params->mac : bcast_addr;
+	if (vif->wdev.iftype != NL80211_IFTYPE_AP &&
+	    vif->wdev.iftype != NL80211_IFTYPE_P2P_GO)
+		return -ENOTSUPP;
 
 	return ath6kl_wmi_ap_set_mlme(ar->wmi, vif->fw_vif_idx, WMI_AP_DEAUTH,
 				      addr, WLAN_REASON_PREV_AUTH_NOT_VALID);
-- 
2.24.0

