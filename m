Return-Path: <linux-wireless+bounces-10881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084CF946B1B
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2024 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664A61F21AD3
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2024 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F4F33CF1;
	Sat,  3 Aug 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbO9Vzhe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B518E10;
	Sat,  3 Aug 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722714784; cv=none; b=d+FFtj9zlXP5KM+ISWraAW82btvrqKWbKN7qknOHOhOitDF9KziICMcb2efrsViQzmuUy4rAbQiRJoit7gzIoXiryNJ6Q5udVCcA8T3vLJqYVs+uQ59bRlW6czFt3AU3ipFhE5FvovzkUwflXdcvgA7LFNb/d97KPzrbVxl+RGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722714784; c=relaxed/simple;
	bh=cO1njgqj1MdIys3zEUAKB60pjD++czAPnaJB2qZeMjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hOEFQe0pF17ExVY9b6OXM/ACt9buFG8GejcuJiFFHAPeN0t/6StEBvUdRXvCoJ5520YWbGYHzRub8eBIuxN8nltxYDYd1qhWPeVQARkjEQVgVH1T1N4hMrWRL+Qqfv7K95ESDY6xVLZ17XhDlgW6q/gmH6i7YuRwWSiBo9KyAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbO9Vzhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7D03C116B1;
	Sat,  3 Aug 2024 19:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722714783;
	bh=cO1njgqj1MdIys3zEUAKB60pjD++czAPnaJB2qZeMjI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=gbO9Vzhe4Q2t6M6Anaf72tuWGNoTztkRwaVXobXonM3K+z2Uzg3ROlaTF38HLekI/
	 PC0+IE5UB/JY/Hyut9ornpJY3yc7cy536OYVO95dYWk8OKt5nFhj+ZCPe9XNglS7WZ
	 DRZZ2wzrSAHQ2Yu3/igaATrLQjTL9m4s98x8GPcjHuVCvtkS5iHr3oS2nS5ptN1MTn
	 THUBG3Wid/0fwNNZb5ZR13OwKI3Vq7Rvr5E1ZIbt3l+w/InH6PIdeXYE80a4yCDJKt
	 dmp27AhhoAh4cMf4oyaxbtHECZTBRep8utKwn3n3MkGWZPvucV0TDoO2wXlFCE1eiX
	 lwVc/qkjMf35A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D901C3DA4A;
	Sat,  3 Aug 2024 19:53:03 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 03 Aug 2024 21:52:55 +0200
Subject: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240803-brcmfmac_pmksa_del_ssid-v1-1-4e85f19135e1@jannau.net>
X-B4-Tracking: v=1; b=H4sIAJaKrmYC/x3MQQqAIBBA0avErBOsKYiuEiGmYw1lhQMRRHdPW
 r7F/w8IJSaBvngg0cXCx55RlQW4xe4zKfbZUOu60Z1GNSUXQ7TOnHEVazxtRoS9QoctBcIWUUO
 uz0SB7/88jO/7AZiy8PppAAAA
To: Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Kalle Valo <kvalo@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, stable@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950; i=j@jannau.net;
 h=from:subject:message-id;
 bh=kwa63Uu8k2lWu1jh8mzzIZRococdlt5kl/m4MUAUTEw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhrR1XfMEpu1b+fuSsfFsHu0AC7n/HqLvPkyYsUf8qoPE2
 WVB35WOd5SyMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZjI3HmMDPcyXdbdTkgSbX8v
 +P1v2493CbJP93htlxD64/Ku96rAllBGhnYeTsmJeakhXxj4GP6WHDzR8etU5P9NPK1xZpKlydc
 6mQE=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Janne Grunau <j@jannau.net>

wpa_supplicant 2.11 sends since 1efdba5fdc2c ("Handle PMKSA flush in the
driver for SAE/OWE offload cases") SSID based PMKSA del commands.
brcmfmac is not prepared and tries to dereference the NULL bssid and
pmkid pointers in cfg80211_pmksa. PMKID_V3 operations support SSID based
updates so copy the SSID.

Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 operations")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5fe0e671ecb3..826b768196e2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4320,9 +4320,16 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
 		/* Single PMK operation */
 		pmk_op->count = cpu_to_le16(1);
 		length += sizeof(struct brcmf_pmksa_v3);
-		memcpy(pmk_op->pmk[0].bssid, pmksa->bssid, ETH_ALEN);
-		memcpy(pmk_op->pmk[0].pmkid, pmksa->pmkid, WLAN_PMKID_LEN);
-		pmk_op->pmk[0].pmkid_len = WLAN_PMKID_LEN;
+		if (pmksa->bssid)
+			memcpy(pmk_op->pmk[0].bssid, pmksa->bssid, ETH_ALEN);
+		if (pmksa->pmkid) {
+			memcpy(pmk_op->pmk[0].pmkid, pmksa->pmkid, WLAN_PMKID_LEN);
+			pmk_op->pmk[0].pmkid_len = WLAN_PMKID_LEN;
+		}
+		if (pmksa->ssid && pmksa->ssid_len) {
+			memcpy(pmk_op->pmk[0].ssid.SSID, pmksa->ssid, pmksa->ssid_len);
+			pmk_op->pmk[0].ssid.SSID_len = pmksa->ssid_len;
+		}
 		pmk_op->pmk[0].time_left = cpu_to_le32(alive ? BRCMF_PMKSA_NO_EXPIRY : 0);
 	}
 

---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240803-brcmfmac_pmksa_del_ssid-3c35efe35330

Best regards,
-- 
Janne Grunau <j@jannau.net>



