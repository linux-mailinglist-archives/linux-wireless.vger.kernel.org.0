Return-Path: <linux-wireless+bounces-35803-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGH6F4Il+GmnqwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35803-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 06:50:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76844B8613
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 06:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3BDB300EF5E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 04:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6351F3BA2;
	Mon,  4 May 2026 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWApRrRq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241223ABA7
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777870116; cv=none; b=JCFW9Ci0g0cR0wGbVTZLWSHaV/eLkqX8FQzcP4RArkV6983SakLwrXh3Uju5te4+NQ0vbtiLnJEdRBTh5rTpfdinQeQ2RXu83oKu7E2SgGHyMXJsGqo2n+RovGQajKH7SFG7XkIiZBDeqG9ncAoPRPaCrNDFPe64dLINrpfOXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777870116; c=relaxed/simple;
	bh=UsN+5rdpiQklvNAPMN4WRO0p4xXhnZmnSuijx3xmqNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOB6WI8O9TH2meTiSy6zr18lckzuopI0mesj0dNgQTkVqxdfllU2Tzs7poHNioW+vCzDkpr3FzgA37GhyqDNwtt8fzTZTgA7k1aCwTPHan2pLsWfyBsjlFu1UphtucV2HeiYQ9vl28W97gS3Vp3sxmj9GyOwVQxQOW6GtAvnWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWApRrRq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so40814455e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 03 May 2026 21:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777870113; x=1778474913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHjB96/OxUK+voZiclEhSlCim+vwAL/oAMBbY7fJVPQ=;
        b=hWApRrRq3sTXBWFDST/47RLWS7Or5trEHMTNNaaKhN2IfV0X42dZlZKTJXJbJQJnjy
         Qa2sVO3nn+LA/FHG9xYuHd/OjOVxMZ/6dNKwFrzBXo8Fxh+2UV4eQmg4o/kW7R1b1wa6
         CN9GcN2PTGrC4hdIube5Cd7Y6fhGkqPHK2FjcJd9j8d4V/s7Zeu4oyizofeWMFerCitH
         03w1yN1izW8umhniKvf3pZTXeBpOChf+fiGdT8ToWk53A/++HqDxSkWps95J9hmgYV+3
         uUYYsZdQ0X2l3UbgQUKJDJGbq+OpVzoe5SBtmi27VAkKrsrXU2EnUCHU0Al+3kUN3olO
         hSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777870113; x=1778474913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cHjB96/OxUK+voZiclEhSlCim+vwAL/oAMBbY7fJVPQ=;
        b=gJWPe4mc/TFbeTdKI/EfLi79D7bZY4d+mxq7zDVpv6o1pQLnj1z9sGt9nvrBA19SNN
         ujbUmwheUXEnqrB2oAQfR56gorKMvhTyCdX/LqKUlTjd5XinbcZv1N3p3MjpLLs9Tf5E
         QJR+nOef//fUwOwRNr3nfTV5Z/yUALoWGe3LV4O9VNZXMktLFoA9kTuPbZABWmxphYcG
         owl2nkIBtAyRK/OXQChcjlkFFt1sU2WrZcaGsV6O2zI0NwknWQyF8908IEdIVqH9Ur3v
         IwQ5KWASl1Jq+r1M8Ounf77gvq8VBtEVNuiFoJrj2Na1/h1cvtw8y5qis3CKr7BeZyeG
         iFrg==
X-Gm-Message-State: AOJu0YzdmUXTbSbehH0HHgS26jB6GoeRbfXK4jlCT7RlEqbhHu2dwsRv
	HmC/lkEAXjVZhfzp9P5ieNQuBTg6m4wVGfsQkgmCUMwr5dcUe0sFNCp/
X-Gm-Gg: AeBDies/fiW/B1+A7FrElW8gF3MZHbHBn/P9Yxx3eKcCjEBNg4h53sqWlHpluaJUz08
	qBhHE8GjjziMLfxv5ogm+fZQK6Mjo37JD+Ng1Mbz6u66O0USl4LZj8MFq163JgrFD6rsx1QPP/Y
	OGnMTDEF2K6VmbXycaEhjmsou7n3rRyIlinJ0gOHrqZJ0NXKFE0ozCVisPX+QcF4A+HM8WqEbNn
	4cfM3VrLysA6dklLHxksoO+u8Noobxe8aI4uzEFppl+L7KubleJrKPAqOuSRADuLJAxZYJ9NUNO
	liVt/3wvxNUHLBlc0TqMw15lHiVzbWMwqAdODz4wFI7KVE49DMNfVveIv00gV8Hg1dgxBUzzX5Q
	AVCKKSpRAORuJVzLo2DzH9cj6bPPp7SfzGiYTNqMSzEVue+0odvTlKujisiS2ArfGx515kvDbGx
	9RMk0vELW7xRBlQWjuxI3LCKfJ/Pi4LNz/hzJl9SEXp4jia2QCjIvxb0Wi7Q==
X-Received: by 2002:a05:6000:2311:b0:449:fb9e:4b4e with SMTP id ffacd0b85a97d-44bb4722fcbmr12510408f8f.15.1777870113214;
        Sun, 03 May 2026 21:48:33 -0700 (PDT)
Received: from localhost ([102.128.173.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b768fdsm22144032f8f.33.2026.05.03.21.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 21:48:32 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH 3/4] wifi: rtw89: advertise MLD TID-to-link mapping and link reconfiguration
Date: Mon,  4 May 2026 06:48:16 +0200
Message-ID: <e53bb65233faeb67a5f26eb178b479fda0721e50.1777832019.git.loukot@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1777832019.git.loukot@gmail.com>
References: <cover.1777832019.git.loukot@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B76844B8613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35803-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wi-fi.org:url]

Wi-Fi Alliance Certificate WFA129313 (RTL8922AE 802.11be and Bluetooth
combo module, 2024-05-23, FW 6102.24.109.0) certifies both "Advertised
TID-to-link mapping" and "Multi-link reconfiguration (AP removal/restart)"
as Wi-Fi 7 features for this chip. The driver currently sets
mld_capa_and_ops = 0, so the STA negotiates neither capability with the
AP.

Use FIELD_PREP_CONST() (already used elsewhere in this driver, see
usb.c:784-787) to set IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME
in the TID-to-link-map-neg-supp field, plus
IEEE80211_MLD_CAP_OP_LINK_RECONF_SUPPORT. This matches the value used by
iwlwifi for its Wi-Fi 7 STA mode (see drivers/net/wireless/intel/iwlwifi/
mld/mac80211.c IWL_MLD_CAPA_OPS macro and mvm/mac80211.c
IWL_MVM_MLD_CAPA_OPS macro), which is the established in-tree precedent
for this exact bit pattern on a Wi-Fi 7 STA.

The IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS field is left at 0 (= 1 max
simultaneous link, matching the EMLSR-only operating mode the driver
implements per enum rtw89_mlo_mode {MLSR, EMLSR}).

These two capabilities are orthogonal to MLO operating mode (EMLSR
remains the negotiated mode per the previous patch in this series); they
let the AP perform online TID-to-link reassignments and remove or restart
links without a full assoc cycle on the STA side.

Tested on RTL8922AU (USB variant, same MAC + RF as cert'd PCIe AE)
against TP-Link Deco BE63 mesh; assoc remains stable, no regression in
EMLSR multi-link assoc behavior, all 11 wifi-health-check probes pass.

Link: https://api.cert.wi-fi.org/api/certificate/download/public?variantId=129706 [WFA cert WFA129313]
Signed-off-by: Louis Kotze <loukot@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 986deb2c1384..aedb2a284cd4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -221,7 +221,10 @@ static const struct wiphy_iftype_ext_capab rtw89_iftypes_ext_capa[] = {
 			IEEE80211_EML_CAP_EMLSR_SUPP |
 			(IEEE80211_EML_CAP_EML_PADDING_DELAY_256US << 1) |
 			(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US << 4),
-		.mld_capa_and_ops = 0,
+		.mld_capa_and_ops =
+			FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP,
+					 IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) |
+			IEEE80211_MLD_CAP_OP_LINK_RECONF_SUPPORT,
 	},
 };
 
-- 
2.54.0


