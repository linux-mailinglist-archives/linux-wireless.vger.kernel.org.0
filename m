Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F921116B02
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 11:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLIK2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 05:28:54 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:33129 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfLIK2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 05:28:53 -0500
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1MTREY-1iAbuP1ZSW-00TjfQ; Mon, 09 Dec 2019 11:28:49 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: [RFC PATCH v1 4/4] nl80211: Allow deleting stations in ibss mode to reset their state.
Date:   Mon,  9 Dec 2019 11:28:09 +0100
Message-Id: <20191209102808.12014-5-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <m34l02mh71.fsf@t19.piap.pl>
References: <m34l02mh71.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T8maCSyhvPavolayW/MJ+YJXm/7c1Rgd+tqDj6pc/ZbOyoROH2M
 E/DrYCxw7iglert2qOBBznvHIglky8X1LhlWULY0fMI9h3xXzzJOjczb9WQZgk231nvY9CV
 lq5olqMZswydtj541VoflDlffHw7fcwwTGolj/huETHo+LLSZTneFsrrF5U53HSw9UhqiEo
 2vFSG/nFdJ0fi2T3Fr+IA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PYck0YGAtRw=:JoM4AP/D0aRlMIqrMqSUTh
 ds2Q726hzVtnbF8CcBaDg0JmuhcBUF1E268bJCsiT6DSzmCXGAU8CNdlJskE1JCUFcQlq0/kg
 /1t9NqfHTXOLJsG9yg/jnQYz5qTclM1f8KznT+s/BAo7Nve2q/qYwbyupmYJyymYfN1zFJMlq
 kAxfd163AMhtK9jW0OJ9G7l8qCkZWAbQiJ/J42Qi9/2T0RwemKjkQtzoxPgKeASlDM+/11OJd
 YBKWzm1rd5iH6p9f/NCTfZVsxeiE2SSo3xacVrC/D4LH0jTJbTEi2apA3LnqMGENjC79fj2q4
 SQhgw6+TYTeXC7Pe08L87oQ/5UxHSTgiNsoW7LYwQHpZmpq6HEWTDM8WD3pacLjPeta5GPuRb
 sp9D+JcNdlXDWLmYLHMbhmvyoP534TMa3xlR8RXQyhnC0YU0BJF7nRcBKr1qGWOre5pAKBX6Z
 /p6ThpHppUsVinAu4gS0IAywlDnYgNfLY8g4Ao3oSMhwLEtqZ3ZqbpSGnfdyqVhJyjmfLHlAf
 prCvrvD8C5AAjiJ8k14Bw5AaH8VLZnn1j3r2IDWS0YhVzjzsoc7NKQDljNLSpH32+r3mIn+pJ
 mE3yjzAE+Sr9wdmFrbXG+Gk7bxrXRBISMcQ2sSlbfTXm7Q5SdG1dg3f960XuK5M9JZRQDyli2
 +ovMZ4iFmG6D3qHcaoRQ5S/7CYd3TlL4XxEJyPYXPwK79VJuNcAyOuP0PRxgz/bofJf8RUf9n
 /mooS3WBnqujfHLwP0EoMjuwtCpPQ8nDHiMvwzUB5Oo9jZiwyoArRf4wZKsxNDw4NvrTGbf6H
 Bhr4zS3OR7XHgOOCdQRaGXqza1enmschdDdLUaFTLTFP1DaBx9X7rho3Kcl8yagiwSHzIqkGQ
 MTU9669akelYTY66Gvl0RSRpi7dI8NFzNYomye0mqDN8SKdVDWr6gqR29QGWer
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sometimes, userspace is able to detect that a peer silently lost its
state (like, if the peer reboots). wpa_supplicant does this for IBSS-RSN
and currently only resets the key of the peer so that it can attempt
another handshake.

However, the kernel also hold state about the station, such as BA
sessions, probe response parameters and the like.  They also need to be
resetted correctly.

This patch allow userspace to use NL80211_CMD_DEL_STATION in IBSS mode,
which should send a deauth and reset the state of the station, just
like in mesh point mode.

This has successfully been tested with mac80211/ath9k. Drivers that do
not support it should just return an error, so that userspace can fall
back to the old methods.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 net/wireless/nl80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index da5262b2298b..82046c990a2a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6073,7 +6073,8 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP_VLAN &&
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_MESH_POINT &&
-	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
+	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO &&
+	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_ADHOC)
 		return -EINVAL;
 
 	if (!rdev->ops->del_station)
-- 
2.24.0

