Return-Path: <linux-wireless+bounces-35154-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BPbFeKB52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35154-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:55:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9FA43B9A3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E6BB30914C8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F4A3DA5A6;
	Tue, 21 Apr 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcFV7ufZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E73D7D69
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779387; cv=none; b=kEBCmY7HBOCbd2mZBZsSKwloWfV7U1H/if6PNSPwZTc7WRyGgUTvH0KaQ3mvluL7DDqWXcJqiuW0GO9vnqlplgK9q0IcV6bOXb8otg6nupcGKe9kguNvk9CgVEluD326LBe3L6k/3srXAWAe0R4TLNXefTMPf9R/4aNTMV5i5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779387; c=relaxed/simple;
	bh=nolTxCBP9FHfSuvQ5EW7BS+a9LX6BS4H4Xj49Lp7QtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep1F4V8IKJpjk3U00UfSpwV8Rs/c2XQm7BQwqdVJkh+fUlLM/fIfkEt0p79dQW8DsxAo2EK1b0fICrEDY5pRPcTNHQDMX+o9A7UP1zvTqWlQGlX54PVsxkWvmVX50vhp92FDtoqI2iRjSSl0D2HY1QuHvCP4FNcYtcP9Wt/C/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcFV7ufZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so33115945e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779384; x=1777384184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmFFDwy/wNWvl65UK2Lm+vY44R4kAs7LOrPcVbInZDM=;
        b=LcFV7ufZb0Qujuvu3eoK0wwlJuWDjZU9vx67qeThkfAjBi1uL4hLNIRvKDBxtjnkgS
         OELAruPAlEqNlfgbtv21dNzwxixB4+nxIlVjARCiLOAZIR11JapqIz4Z6EXJu+uBUMwN
         Vy9pzeYWH+5uiKzro9XJPFKYfBdxkO08htSDSg6cy//gXUndR4JVjc8pYtbJtkmGZMDS
         d93Sg+RpCjOALZ5z+jpkBl0QrdSGbJsF3moC39cvwJibTKMTlmtgF8Te4eqbNi+6/BT3
         KuuashncCl+5KJ4nJfBZusuTVNvLg6PkGVc+DAzNhL9DY3cU/MCLvI/JalN0bENwnhxa
         uqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779384; x=1777384184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmFFDwy/wNWvl65UK2Lm+vY44R4kAs7LOrPcVbInZDM=;
        b=AcV2huk764/y5s1Hp/lWbvYxMW5M6TEE6ZQnhbZusBbwLDEe7/OWZEojduvIaUL3KN
         1oOv0VU6yO4/vGLg4hQKVShHIYdEjqYOLN9qKjhyDBQsiURlaJYScu2tgpvkKUbDdKyY
         pBiciBHqfl9NH0QSueLwYWUuIjHd4R+xx92uB9N/jyz7TVJ0lyg5v6Jg3H/sqJMbQtKc
         VFgUj8wygODaEPFdx+e+KJkp6r80uxs+BxcFG4KV4zNmW0U8tS5iEkkMCwfBF+iWdAcO
         Pumz9zGJZMPneGdsGqNHdhoGqpT6CQgZ7czAv9T6Ps/lEys6hCgjo09M2LooMsSEzxRs
         1lVw==
X-Forwarded-Encrypted: i=1; AFNElJ+8Wz9I7iNDKso4PF10FgIWKGUnJ5IqW8OdlxGp9ce0p1rnrXuC7ZZRzo4uukew5U6HkJwgI8e3/abf7wPf/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0I9KHfCs+xbJdch9MAP4M3N3VPx+lmKl+92XQWLV3Cawmo5jc
	5jh4SfBdZTM1flY4ARfNHkJcfc0v8fYY5u7lTDBaBpdvS6tTgKCojxs=
X-Gm-Gg: AeBDieshj5J/z4jfDMLuxtSox8lqJgkWHMiV8RPOYC44GHm16zuQ2MUw6HcW8QwTZSx
	m6MKJMhItqRW7y4Wngq4OCvK0cPcG68u1gv54kDuJICMCJ1qS+PcrZllYINGjk0humUtcdhmcRc
	Ez5AAOsE1K1HVkBy3XctMSm6aT7m2GndwB20h9j6ojeilU+sb69uM1UGjdXurT2fpeZFhn83kCp
	9NKUBMyTcrgZBjFnvDolSbPLs0qfu0Wv2J3rpYrPfmw9qBxFNoMWq1hOD41fpmdfBm3UDyvvXth
	MXrLENI3OLdMer1RaGYDjVQFvmMDc3X9K++gX7mQx3WSpTfp0mjTXx4R/LVcziml9qCz10LP8YY
	+XLUTiYpaRxAtWj+DlEKATJEJsvofiMTE1umKkQcaHj2pB15pLgOSIFsIPLjCltGITq6z3Sc1p4
	xYRrk=
X-Received: by 2002:a05:600c:8909:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-4891b10dd45mr124444525e9.0.1776779383993;
        Tue, 21 Apr 2026 06:49:43 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm176331185e9.5.2026.04.21.06.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:43 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 4/6] wifi: mwifiex: fix OOB read in scan response from mismatched TLV data sizes
Date: Tue, 21 Apr 2026 13:49:36 +0000
Message-ID: <20260421134938.331334-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134938.331334-1-tristmd@gmail.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35154-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B9FA43B9A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The TSF and ChanBand TLV arrays are indexed by the firmware-controlled
number_of_sets without cross-checking against the TLV header length
fields. When number_of_sets exceeds the TLV data, the loop reads past
the TLV data into adjacent command response memory.

Stop using the TLV data once the index exceeds its reported length.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/marvell/mwifiex/scan.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e7..059215c86dffd 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2187,10 +2187,13 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 		 * received.
 		 */
 		if (tsf_tlv)
-			memcpy(&fw_tsf, &tsf_tlv->tsf_data[idx * TSF_DATA_SIZE],
-			       sizeof(fw_tsf));
+			if ((idx + 1) * TSF_DATA_SIZE <=
+			    le16_to_cpu(tsf_tlv->header.len))
+				memcpy(&fw_tsf, &tsf_tlv->tsf_data[idx * TSF_DATA_SIZE],
+				       sizeof(fw_tsf));
 
-		if (chan_band_tlv) {
+		if (chan_band_tlv && (idx + 1) * sizeof(*chan_band) <=
+		    le16_to_cpu(chan_band_tlv->header.len)) {
 			chan_band = &chan_band_tlv->chan_band_param[idx];
 			radio_type = &chan_band->radio_type;
 		} else {
-- 
2.47.3


