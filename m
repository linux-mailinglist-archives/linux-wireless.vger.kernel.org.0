Return-Path: <linux-wireless+bounces-28828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B04C4C1E7
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 08:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCC7D4E0355
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721829DB6A;
	Tue, 11 Nov 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSR3Fvtj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B51DE4CE
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846406; cv=none; b=uZauOTrmwHk7C5jBumlKRhIPOVUdLoDATMr6f4Tr8dZgh2RPcnc0B6PXKHkUEQ2rgPKz3giy9ERbxrqxdaNp9QYhqBQDBp4NskxOo3Sk63akwfvF9xxlz/nUfDqGwQB8PtHA45lXL2j1e01swCCGBOVutY6Lw43fEvZUUA4GSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846406; c=relaxed/simple;
	bh=uZalZPFf4jKIPWqXzV7tu+QzbWPg0yTTEsdMmEW6Ybo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDH0xS+ivacDyYeaf1KU6Pnwsydl9c4IV8WLjWdQX4r64KhqQG4I2m02TrUidVwh8gYQ8qygg/cOjbHMx6y2ByYZwKAldCcrn/n1LtWtAD6Oyx5hLn4EcKoeGlB+2MXxOkcv8++sydOQUjPMXIJxp8ee+IQo6ruZd7oauwIVcsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSR3Fvtj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso6617085a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 23:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762846403; x=1763451203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EW/edEVU0KV0TxqzuoUgBBiWmv1nZ1ujjQOOdZz8lu4=;
        b=ZSR3FvtjaMsc2rJ/BOm5GenpSu165JBSirzTUos8ktjq1CW0umWuhqYr5XbLFxCbV7
         2/Wk0IPwJyyvNoz/Fd7xezolkhEs9dqfkc3teWEJlbFddD4vgvobA+VWUoYhbLL1YDr1
         pEnAcvAjf3zVFkWWjIw0YZEgos3gN3wZfggY2ycLmQ2TETRqO6RTMQX22h/rXkRNbj1R
         UfPkq0G6a7PU59WMLWkV4ZEOFb6x8P6Rc/Z0n8P+AEf6CdxQypVFe/oQujOhGG+93p9n
         2DWIh+9C6O01YmiweHWyGckgVEO9fq7Xh7Aw3sPs3FdBtkjvosCoMKWkgQtk+pl2hAxe
         pDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846403; x=1763451203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW/edEVU0KV0TxqzuoUgBBiWmv1nZ1ujjQOOdZz8lu4=;
        b=LflyraXYEqD7sBLAW8obIQv8guiN3xpBBT3MZTMbulyKNIMkOjQ3NNWhgSlniZx795
         2xfFTNo0HnFkogENizievanhbx5u8jFwuGcA0mjXN+JVCz4IjkwUZav2yKHsoTnQhJ6W
         xjKYY6PL49roMDIzkyE4obSqArU75ntEsyLvhbfysMxTejWtkca4mci5vwo+8c0W1YJD
         DUTeBLWzI4vXoZxB8a9Dup4KTq94oSMMUhsKreWDGYW3dl/Qa7Z6m1LaSeji+FyejECQ
         BIw3tL9xUQfHB2AHNTp9jeHctuLJ4duhRmNurBb0Vow3ldZmdUf1/hzO54v/PNjKNBvt
         1DMA==
X-Gm-Message-State: AOJu0YxCEnswcow8udYlrVVpsrlQkVGcsxPapj/u3kCjIy0Itf92fRg5
	Ukn/tN41fmV3cq2shl+Pr3CtOU6QpWeuF98oo4u566lRRxtiU+xC4TYiVNm+yA==
X-Gm-Gg: ASbGncugR28+pOblL8tZF0kS7jp8qs12Fz47aPmQ/5vMxQxbgfxAxuPJrxLC6yQ51Fl
	qS1lcUAVOz//LxHqSAeA2YklVR7JWI2bQVo4YzGSemYHhrHYDIPZwANiREJ+228bb/oHuo/vzvY
	y8pPBHKTdBAG9xCPUfGhAlb3M5PrCvv0GEfkk2YDxpl68fnXbOGjW3oDwj0LhBBs6C/KC+y7oDG
	OwkNR3ZRH25zhZfpf2yJdbCUWbdgIBB6mSo+/LfGbUpx8u8XkbnRm2tdWHICQQnWpAJl3BR/QIX
	mqqqgDqqi4Ld+6aL+RrFzGXn5skys+ozqSP9QiaopJnh1Rsg911dIX0D8X4DMCQzJdIXkxtIvBj
	+A7BibVsbaJlpNKdLUJhmgTxWJ1D/km4rQmI9wpsdK9o6rN0g5WuIRgW4j9Lm80GLhlcmBEvhUO
	F4NmcoSehlMNDz3N3y3ycLPmmafCYJ+k4V+8amHw==
X-Google-Smtp-Source: AGHT+IH5UdRGX9vHEpYaWlX4gzbeYljFwAVzWxu+8ZPZ6DiGRR+OVPwGcszNxy/8+pt2DPBl/RIPvg==
X-Received: by 2002:a05:6402:21c2:b0:640:b044:d9bd with SMTP id 4fb4d7f45d1cf-6415e7fd427mr8009190a12.29.1762846402832;
        Mon, 10 Nov 2025 23:33:22 -0800 (PST)
Received: from tempest2.wbe.local (xt27d7.stansat.pl. [83.243.39.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6416001a4a8sm8122499a12.15.2025.11.10.23.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:33:22 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Antony Kolitsos <zeusomighty@hotmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: mwl8k: inject DSSS Parameter Set element into beacons if missing
Date: Tue, 11 Nov 2025 08:31:16 +0100
Message-ID: <20251111073134.2774120-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Marvell AP firmware used with mwl8k misbehaves when beacon frames
do not contain a WLAN_EID_DS_PARAMS element with the current channel.
It was reported on OpenWrt Github issues [0].

When hostapd/mac80211 omits DSSS Parameter Set from the beacon (which is
valid on some bands), the firmware stops transmitting sane frames and RX
status starts reporting bogus channel information. This makes AP mode
unusable.

Newer Marvell drivers (mwlwifi [1]) hard-code DSSS Parameter Set into
AP beacons for all chips, which suggests this is a firmware requirement
rather than a mwl8k-specific quirk.

Mirror that behaviour in mwl8k: when setting the beacon, check if
WLAN_EID_DS_PARAMS is present, and if not, extend the beacon and inject
a DSSS Parameter Set element, using the current channel from
hw->conf.chandef.chan.

Tested on Linksys EA4500 (88W8366).

[0] https://github.com/openwrt/openwrt/issues/19088
[1] https://github.com/kaloz/mwlwifi/blob/db97edf20fadea2617805006f5230665fadc6a8c/hif/fwcmd.c#L675

Tested-by: Antony Kolitsos <zeusomighty@hotmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
V2:
  - added "wifi:" prefix to commit title
  - renamed "DS Params" -> "DSSS Parameter Set"
  - Insert WLAN_EID_DS_PARAMS after WLAN_EID_SSID, WLAN_EID_SUPP_RATES
    and WLAN_EID_EXT_SUPP_RATES
---
 drivers/net/wireless/marvell/mwl8k.c | 71 ++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 891e125ad30b..914a566d700a 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -2966,6 +2966,52 @@ mwl8k_cmd_rf_antenna(struct ieee80211_hw *hw, int antenna, int mask)
 /*
  * CMD_SET_BEACON.
  */
+
+static bool mwl8k_beacon_has_ds_params(const u8 *buf, int len)
+{
+	const struct ieee80211_mgmt *mgmt = (const void *)buf;
+	int ies_len;
+
+	if (len <= offsetof(struct ieee80211_mgmt, u.beacon.variable))
+		return false;
+
+	ies_len = len - offsetof(struct ieee80211_mgmt, u.beacon.variable);
+
+	return cfg80211_find_ie(WLAN_EID_DS_PARAMS, mgmt->u.beacon.variable,
+				ies_len) != NULL;
+}
+
+static void mwl8k_beacon_copy_inject_ds_params(struct ieee80211_hw *hw,
+					       u8 *buf_dst, const u8 *buf_src,
+					       int src_len)
+{
+	const struct ieee80211_mgmt *mgmt = (const void *)buf_src;
+	static const u8 before_ds_params[] = {
+			WLAN_EID_SSID,
+			WLAN_EID_SUPP_RATES,
+			WLAN_EID_EXT_SUPP_RATES,
+	};
+	const u8 *ies;
+	int hdr_len, left, offs, pos;
+
+	ies = mgmt->u.beacon.variable;
+	hdr_len = offsetof(struct ieee80211_mgmt, u.beacon.variable);
+
+	offs = ieee80211_ie_split(ies, src_len - hdr_len, before_ds_params,
+				  ARRAY_SIZE(before_ds_params), 0);
+
+	pos = hdr_len + offs;
+	left = src_len - pos;
+
+	memcpy(buf_dst, buf_src, pos);
+
+	/* Inject a DSSS Parameter Set after SSID + (Ext) Supp Rates */
+	buf_dst[pos + 0] = WLAN_EID_DS_PARAMS;
+	buf_dst[pos + 1] = 1;
+	buf_dst[pos + 2] = hw->conf.chandef.chan->hw_value;
+
+	memcpy(buf_dst + pos + 3, buf_src + pos, left);
+}
 struct mwl8k_cmd_set_beacon {
 	struct mwl8k_cmd_pkt_hdr header;
 	__le16 beacon_len;
@@ -2975,17 +3021,32 @@ struct mwl8k_cmd_set_beacon {
 static int mwl8k_cmd_set_beacon(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif, u8 *beacon, int len)
 {
+	bool ds_params_present = mwl8k_beacon_has_ds_params(beacon, len);
 	struct mwl8k_cmd_set_beacon *cmd;
-	int rc;
+	int rc, final_len = len;
 
-	cmd = kzalloc(sizeof(*cmd) + len, GFP_KERNEL);
+	if (!ds_params_present)
+		/*
+		 * mwl8k firmware requires a DS Params IE with the current
+		 * channel in AP beacons. If mac80211/hostapd does not
+		 * include it, inject one here. IE ID + length + channel
+		 * number = 3 bytes.
+		 */
+		final_len += 3;
+
+	cmd = kzalloc(sizeof(*cmd) + final_len, GFP_KERNEL);
 	if (cmd == NULL)
 		return -ENOMEM;
 
 	cmd->header.code = cpu_to_le16(MWL8K_CMD_SET_BEACON);
-	cmd->header.length = cpu_to_le16(sizeof(*cmd) + len);
-	cmd->beacon_len = cpu_to_le16(len);
-	memcpy(cmd->beacon, beacon, len);
+	cmd->header.length = cpu_to_le16(sizeof(*cmd) + final_len);
+	cmd->beacon_len = cpu_to_le16(final_len);
+
+	if (ds_params_present)
+		memcpy(cmd->beacon, beacon, len);
+	else
+		mwl8k_beacon_copy_inject_ds_params(hw, cmd->beacon, beacon,
+						   len);
 
 	rc = mwl8k_post_pervif_cmd(hw, vif, &cmd->header);
 	kfree(cmd);
-- 
2.34.1


