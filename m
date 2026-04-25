Return-Path: <linux-wireless+bounces-35299-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJTvDREb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35299-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:50:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 291694678E7
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AB003002B65
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B408303A0D;
	Sat, 25 Apr 2026 19:50:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3418303C83
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146634; cv=none; b=LYsuGnNJSusxILXPA2MQjtdUThy7tlHhq7koTJ1ypCaQQM8Kt9bduWGMqv2SNWFi9O0ZXPRFnkM/dPWa508hQ86FVDMs0ALrmeWrp6k+A69Ih3R9vKHgIppN+ia2RbavW9r61jJk4LUiAKLcDPnTNpD8dVFWXESgmQ04d+pj9aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146634; c=relaxed/simple;
	bh=MKqoCsZkghbtchZexPSDVOF3wVjvdBWci+Bh0pEjIP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oiikd5W9v010vRMrjSNJ+ODXCmxL/l9Az+w23t3oZbFb/A8yPyo5QcfHLD7ZPhWzksa7sUC5pt3zYxeMTtDkUSmCmgvIZlSWYL5//j+GgWQ/XIDl6eadUv+uOHjgHFQGUOGBQum8TWozpyvSvWYcy5ya+YiguqzLHAb/QgHhwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d1872504cbso7659889a34.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146631; x=1777751431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byzvVsEsSYOVH5gPh5T7X/DmHAalyQEftbu3O8NQ380=;
        b=stltjQv7Az3JVo13tPG/LoDHvrBKnsVJjyFiPzmWHd8aeRhPx1+n7VdxpQB8PI4XQO
         fYD0hfXvak3bpja6+uDVlTieCbRdKBqivmRb3AcMsLGuHJbm707TZkoS1KafrSz9gBEU
         k5NNR6RoTx3zRRNZzvJdN1JWzI2cOtHAIHJvDtc+C41cDQwJgLoloYTc1Z949NAlj9uj
         2v3BRlfcMTK6PVTaQfx0kp+/qHnJ+rD0j0eArQXGksQH7zrkiJT9N9RUd2LSLh4hpVns
         ZtgVIrIx1SK5DHSOR6+lUXCt2FzdDoEu5AjWu6fkMhJXA4dFu/G2Ato2mtvv5cVfLquk
         RXVw==
X-Gm-Message-State: AOJu0YwlTC/vMt1L5af2L9wgLkwTnitT/dLYMbdLpgQMUqWzDqX9KYn1
	BTJ+JRwiR0qSLh/2Xjps0vImORDjy7zrED5enCvfNf3BQRJTHHz37wfW
X-Gm-Gg: AeBDiev/IAzEtQ4WJxviFokzDUpOT+3UPNIeeyS97YMXAgQHi27BCKZR/Zl1m4rgOlo
	LZX5Y+jfqBLMRtVAtDrT8kVUxziSo/BFMT4UKvD0HGIvUbdQ7m7F3HifLcTJUrJEknM5V8StAZ+
	yarZD1BdxauYmnWXj1caEVarpNFd389dvPMXOHMjGVcI43Cw5gSoOTSI8QQCy5zJjHrMtxADJ8m
	Ma7wKrTBYF8qFf8pU/O5LF08Tw3bpmkgjh/eQXvxsYHjIjgMtOOlecTUh9as0Vxw/gW+IYT1xdp
	L5FnB3kU5+maKxThHDk9RXKSZwcB5lUeHDFIBsBQZCvi4/cWFpRn7Yq8Ose7Z51Upa71yK7OXit
	N2RAMlepP0Nwx9o691lvUA/QCSvnrwbgW2CL8/gTyN7gpyMEqYmfho3PgMpgYsXWkC5VsjY+S2A
	Db2r2jx4EUSg6GW8OHm6yOfM0BCXTOv2gJFqY0xGTB5wfz+Rju18XWUinFROSWkdIPYI4E0cUeQ
	g==
X-Received: by 2002:a05:6830:2784:b0:7db:f286:18ee with SMTP id 46e09a7af769-7dc954ac645mr18252905a34.4.1777146631611;
        Sat, 25 Apr 2026 12:50:31 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:50:31 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Javier Tia <floss@jetm.me>,
	=?UTF-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>,
	Marcin FM <marcin@lgic.pl>,
	Cristian-Florin Radoi <radoi.chris@gmail.com>,
	George Salukvadze <giosal90@gmail.com>,
	Evgeny Kapusta <3193631@gmail.com>,
	Samu Toljamo <samu.toljamo@gmail.com>,
	Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
	Chapuis Dario <chapuisdario4@gmail.com>,
	=?UTF-8?q?Thibaut=20Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 02/21] wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv
Date: Sat, 25 Apr 2026 14:49:52 -0500
Message-ID: <20260425195011.790265-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 291694678E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,jetm.me,gmail.com,lgic.pl,humeurlibre.fr,mediatek.com];
	TAGGED_FROM(0.00)[bounces-35299-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

From: Javier Tia <floss@jetm.me>

bss_rlm_tlv() in mt7925_mcu_bss_rlm_tlv() has no case for
NL80211_CHAN_WIDTH_320. When associated to a 320MHz BSS, the switch
falls through to default and sends bw=0 (CMD_CBW_20MHZ) to firmware
via BSS_RLM TLV. Firmware then configures the RX radio for 20MHz
and cannot decode the AP's 320MHz frames, resulting in complete data
path failure at 320MHz.

Add the missing NL80211_CHAN_WIDTH_320 case with CMD_CBW_320MHZ and
center_chan2.

Tested on ASUS RT-BE92U: 320MHz throughput goes from 0 Mbps to
841 Mbps (iperf3 -t30 -P8), PHY 4803 Mbps EHT-MCS11.

Reported-by: 张旭涵 <Loong.0x00@gmail.com>
Closes: https://github.com/openwrt/mt76/issues/927
Tested-by: 张旭涵 <Loong.0x00@gmail.com>
Tested-by: Marcin FM <marcin@lgic.pl>
Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
Tested-by: George Salukvadze <giosal90@gmail.com>
Tested-by: Evgeny Kapusta <3193631@gmail.com>
Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
Tested-by: Thibaut François <tibo@humeurlibre.fr>
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 37cdf3e8a067..016c534f748c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2334,6 +2334,10 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
 	case NL80211_CHAN_WIDTH_160:
 		req->bw = CMD_CBW_160MHZ;
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		req->bw = CMD_CBW_320MHZ;
+		req->center_chan2 = ieee80211_frequency_to_channel(freq2);
+		break;
 	case NL80211_CHAN_WIDTH_5:
 		req->bw = CMD_CBW_5MHZ;
 		break;
-- 
2.43.0


