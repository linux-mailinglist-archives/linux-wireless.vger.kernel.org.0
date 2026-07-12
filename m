Return-Path: <linux-wireless+bounces-38918-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HHBGAxAUVGomhwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38918-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 00:24:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBDB7462A6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 00:24:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V4dhiOek;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38918-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38918-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED4AB300231F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 22:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D764;
	Sun, 12 Jul 2026 22:24:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1437F741
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 22:24:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895052; cv=none; b=cmKpSvd0t8Jz7PyL9sUyUbXaMoLJkKSaIQcWM12k2IOBJpze+loqGIYRqzwj4BYGA+Ul0gdgdndNvSGvNeGuTlv+cNqCrVy3vQOdSkoJe3EAa4zrxnWvoiNZ6SndNmHlACPGvhYm3o2AGz1V5Hecr/PLzb33A5KmPo7x8mTBvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895052; c=relaxed/simple;
	bh=7vHkeEwYxucEIgmyQy00aWQukDErKU3yT9Ag9fkOYSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JcRt8c+WMKp8duAE8OZ3T+cp6FM5Jt+4kphdCguxloLgeqhCCnva+dWIIKn5HhC4ULeLybMFEPeQycpI/xv+W4YXmrkNwr+DWyUOkkPMXxqMZUknEbqGdHBi9n88ST9yqWO0tHUrBZvbhN8CZP+NFDQ065rk1z1MUZHFgLCOy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4dhiOek; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1684035f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783895049; x=1784499849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZM+QV8HJI9EP6A7ONMZAuvqyRmJ/MKzzRc2CMD8iOn0=;
        b=V4dhiOekIQnYAbtkf2d3WN3LjrKH+1jlysga5LtYupfoQta06qaC4zVLvoH+Nson3V
         ZSuw53CJiux26ysbU1+AiF8lNa96Dp3C8vl3vk29eFBx3AScEq1SHBeCWif04lfL4H15
         iq8r5q5KkiEZXu7mI6M0IUoLl19MlT1Go/Ybss/dlvnowd3DkO7u5Br6hYh30Sb38N3l
         rVAPf55ql6ll22m3oG2a5B5qG76o8PVOdw4bon2uLZPXFWG4cRdMYxlLt1DB0aqchCfV
         NQ0ZEOtzMdlBBQGmREA4W4mhnzJ2Uiid8xGEJuUGxK73j8J3IkErjD5dO9eoEyAje31V
         tvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783895049; x=1784499849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZM+QV8HJI9EP6A7ONMZAuvqyRmJ/MKzzRc2CMD8iOn0=;
        b=Af/rCbd3VmYUnlYy4W/uf7fOsYGqJYgnh28elPrDKd5aH3mVnq6z/hlynaOsn8UEoP
         4u8AzVvWXvLbIrVtyWyr4FLxIOUlsY2Ilc4WbYbvQo4s6qLgyouTwmaM+GbanjIgPEzZ
         U2LwczSl8954L/NrHTTHqTpq3kRnlH7UaZEV+NFWI0d2q0fSsSr0H3PcHk8otNAqrrJH
         dgT3WhGf0tNS84+Ptt1K6hnVyqxxVZrR3ckNXVaIabsyZMwNYkimzjaISAau9RCB/aOG
         rC225iI7IHpIPD2i8wfe1NVBxfr8iJ8z39upJsOmnwYhLqNIBbqwflv6DKUWBS+Wz6zW
         BxQA==
X-Forwarded-Encrypted: i=1; AHgh+RpDPd7zF/+WLGXla+V6a3bk2wWBfVceFJfpjX5KZxZh/ItB+NgS3rjjp4MJaL40Ch+B7zZObw9hx7FWrb3Yug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02jSKCjl3QCCwtvirgBYh4vW26E85xYsg2qP9+XXG5ZYIuuoU
	UsaaT2ZB4IyZp9u7Fh/9XbDUhTKnpFJiIsd5OkeVcmAGxd9EULWLzZov
X-Gm-Gg: AfdE7cnzA8bvehn0s+FyfsoEOY6viQyizhXyqKlNs0Wepk6e1pjG3uf3WFM17uBrqn3
	Ovj9zUttCm6CPzyw2DRzplnvFrABt3L98wg3tJ/Cp1rb4RLo9NNj1TqGZdLfnkxpjo18q/ydveJ
	Ud/vUm+c/qDlxGYpSpbr+p0pB4XMGcZWKR5FwK+7i56b1xvVm+5K14ENM98bWCS7GDHnWbDJmFf
	hu0basWt4onj56vj0Q8bbvdCCnKiMtht2+c2e7swm0IIbgPYAzPrfHIaU1ycVz0rNVSVWyebjEh
	W561EstRSn5o251omF9clxkpHvs0rg/K3q/6sTAG0v2om+JGmPooMTrK8WqmE4SpZDy4LVLyEL2
	K2mZXfLhbBrQHm2tvwYuRuQoF8EkL9R7JBsdxX4agG5q7XuhXqCvt+D/cYz3YGeBzhjvLPLAklI
	2bjXDnW8lhFuwZTZhplTDHXEN6aWGjscgqsXpOV5lET1Z+ypGmKahe1203D6AkzNjd8IXKkoHsN
	KFa3Jyz5IUH2jrbSA==
X-Received: by 2002:a05:6000:27d2:b0:47f:3e80:7c56 with SMTP id ffacd0b85a97d-47f3e80872dmr1926370f8f.14.1783895049317;
        Sun, 12 Jul 2026 15:24:09 -0700 (PDT)
Received: from localhost.localdomain ([176.222.15.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm89912909f8f.17.2026.07.12.15.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:24:08 -0700 (PDT)
From: Georgi Valkov <gvalkov@gmail.com>
To: briannorris@chromium.org
Cc: francesco@dolcini.it,
	johannes.berg@intel.com,
	bhelgaas@google.com,
	error27@gmail.com,
	s.kerkmann@pengutronix.de,
	kees@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gvalkov@gmail.com
Subject: [PATCH] wifi: mwifiex: replace one-element arrays with flexible array members
Date: Mon, 13 Jul 2026 01:23:34 +0300
Message-ID: <20260712222334.7134-1-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38918-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[dolcini.it,intel.com,google.com,gmail.com,pengutronix.de,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[gvalkov@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:briannorris@chromium.org,m:francesco@dolcini.it,m:johannes.berg@intel.com,m:bhelgaas@google.com,m:error27@gmail.com,m:s.kerkmann@pengutronix.de,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gvalkov@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gvalkov@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BBDB7462A6

Replace deprecated one-element arrays with flexible array members.
CONFIG_FORTIFY_SOURCE reports the following warning when
one-element arrays are used as variable-length buffers:

sta_cmd.c:1033 mwifiex_sta_prepare_cmd
memcpy: detected field-spanning write (size 84) of single field
"domain->triplet" at .../marvell/mwifiex/sta_cmd.c:1033 (size 3)

Convert affected structs to use flexible array members.
- Preserve existing wire layouts.
- Replace affected uses of sizeof(member) with sizeof(type).
- Replace unions containing one-element arrays with
  u8 flexible arrays, and document the stored parameter-set type.

Tested-on: WRT3200ACM, OpenWrt
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/fw.h     | 20 +++++++------------
 drivers/net/wireless/marvell/mwifiex/join.c   |  8 ++++----
 .../net/wireless/marvell/mwifiex/sta_cmd.c    |  2 +-
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index e9e896606912..ec3e3f806134 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -823,7 +823,7 @@ struct chan_band_param_set {
 
 struct mwifiex_ie_types_chan_band_list_param_set {
 	struct mwifiex_ie_types_header header;
-	struct chan_band_param_set chan_band_param[1];
+	struct chan_band_param_set chan_band_param[];
 } __packed;
 
 struct mwifiex_ie_types_rates_param_set {
@@ -886,7 +886,7 @@ struct mwifiex_ie_types_wildcard_ssid_params {
 #define TSF_DATA_SIZE            8
 struct mwifiex_ie_types_tsf_timestamp {
 	struct mwifiex_ie_types_header header;
-	u8 tsf_data[1];
+	u8 tsf_data[];
 } __packed;
 
 struct mwifiex_cf_param_set {
@@ -902,10 +902,7 @@ struct mwifiex_ibss_param_set {
 
 struct mwifiex_ie_types_ss_param_set {
 	struct mwifiex_ie_types_header header;
-	union {
-		struct mwifiex_cf_param_set cf_param_set[1];
-		struct mwifiex_ibss_param_set ibss_param_set[1];
-	} cf_ibss;
+	u8 cf_ibss[];	/* CF and IBSS param sets are stored here */
 } __packed;
 
 struct mwifiex_fh_param_set {
@@ -921,10 +918,7 @@ struct mwifiex_ds_param_set {
 
 struct mwifiex_ie_types_phy_param_set {
 	struct mwifiex_ie_types_header header;
-	union {
-		struct mwifiex_fh_param_set fh_param_set[1];
-		struct mwifiex_ds_param_set ds_param_set[1];
-	} fh_ds;
+	u8 fh_ds[];	/* FH and DS param sets are stored here */
 } __packed;
 
 struct mwifiex_ie_types_auth_type {
@@ -1383,7 +1377,7 @@ struct host_cmd_ds_802_11_snmp_mib {
 	__le16 query_type;
 	__le16 oid;
 	__le16 buf_size;
-	u8 value[1];
+	u8 value[];
 } __packed;
 
 struct mwifiex_rate_scope {
@@ -1551,7 +1545,7 @@ struct mwifiex_scan_cmd_config {
 	 *  TLV_TYPE_CHANLIST, mwifiex_ie_types_chan_list_param_set
 	 *  WLAN_EID_SSID, mwifiex_ie_types_ssid_param_set
 	 */
-	u8 tlv_buf[1];	/* SSID TLV(s) and ChanList TLVs are stored
+	u8 tlv_buf[];	/* SSID TLV(s) and ChanList TLVs are stored
 				   here */
 } __packed;
 
@@ -1683,7 +1677,7 @@ struct host_cmd_ds_802_11_bg_scan_query_rsp {
 struct mwifiex_ietypes_domain_param_set {
 	struct mwifiex_ie_types_header header;
 	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
-	struct ieee80211_country_ie_triplet triplet[1];
+	struct ieee80211_country_ie_triplet triplet[];
 } __packed;
 
 struct host_cmd_ds_802_11d_domain_info {
diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index 5a1a0287c1d5..a2c427e6af3f 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -421,15 +421,15 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
 
 	phy_tlv = (struct mwifiex_ie_types_phy_param_set *) pos;
 	phy_tlv->header.type = cpu_to_le16(WLAN_EID_DS_PARAMS);
-	phy_tlv->header.len = cpu_to_le16(sizeof(phy_tlv->fh_ds.ds_param_set));
-	memcpy(&phy_tlv->fh_ds.ds_param_set,
+	phy_tlv->header.len = cpu_to_le16(sizeof(struct mwifiex_ds_param_set));
+	memcpy(phy_tlv->fh_ds,
 	       &bss_desc->phy_param_set.ds_param_set.current_chan,
-	       sizeof(phy_tlv->fh_ds.ds_param_set));
+	       sizeof(struct mwifiex_ds_param_set));
 	pos += sizeof(phy_tlv->header) + le16_to_cpu(phy_tlv->header.len);
 
 	ss_tlv = (struct mwifiex_ie_types_ss_param_set *) pos;
 	ss_tlv->header.type = cpu_to_le16(WLAN_EID_CF_PARAMS);
-	ss_tlv->header.len = cpu_to_le16(sizeof(ss_tlv->cf_ibss.cf_param_set));
+	ss_tlv->header.len = cpu_to_le16(sizeof(struct mwifiex_cf_param_set));
 	pos += sizeof(ss_tlv->header) + le16_to_cpu(ss_tlv->header.len);
 
 	/* Get the common rates supported between the driver and the BSS Desc */
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 623ddde8c8e5..071f7cb305e1 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -108,7 +108,7 @@ static int mwifiex_cmd_802_11_snmp_mib(struct mwifiex_private *priv,
 		    "cmd: SNMP_CMD: cmd_oid = 0x%x\n", cmd_oid);
 	cmd->command = cpu_to_le16(HostCmd_CMD_802_11_SNMP_MIB);
 	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_802_11_snmp_mib)
-				- 1 + S_DS_GEN);
+				+ S_DS_GEN);
 
 	snmp_mib->oid = cpu_to_le16((u16)cmd_oid);
 	if (cmd_action == HostCmd_ACT_GEN_GET) {
-- 
2.55.0


