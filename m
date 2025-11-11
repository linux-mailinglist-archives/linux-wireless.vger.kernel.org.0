Return-Path: <linux-wireless+bounces-28836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1128BC4CFE0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 11:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 557834E7484
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4712E32BF32;
	Tue, 11 Nov 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNjWiB8D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B826461F
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855822; cv=none; b=X7rI1xns9XnS601TH0pp/j6N+1UsHTzb+7Z5i7CvBtGs+Qn18QtTF+fIyBVEsEodjKePkdQjbQpUeWozy5LjqRO2/EUfre1icY+jMr3oDfsJL/Kz77f43gKAluvufgDwcjvv6nqRc29KWvfo6VujnPK+axNH4Edg1jkNpbQJoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855822; c=relaxed/simple;
	bh=uTZPPC0MqaGD5cazC/+J4yCXLFiW8fnVzZfjil7OOFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJgWGfIcRTjn6FQKDUf5ZrR1vFYaP5IQmQktPBE5CZqLd3yzNnz4iMAXMOwIWs5ttI0/kx0oEITmCjGjnaHawZvw/ZhVT9UEY+AJRagRRPeXX9S4BxJzV7iqliQV0A3+xvtKvgfhqk0sfJK6IYeZYJdakVdyPLScMAIGWu2PaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNjWiB8D; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso2617131a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762855819; x=1763460619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUwW7NcY3A0Nnt9i7cSR6DPTQgR8J//w2MhqorK480s=;
        b=eNjWiB8D/jigPLwiGnY8jdBs9+2ywMRKzCRuzGaWDUSOIXcUPHzHKeqNVw3mUkFl4t
         zeUcO1hDUo/6aIARX1nNeasLQt1bBfMyRfAvemHoLYtFgxToblsZaIldC0/hybrpTAdJ
         OU6nkTNegrw50r75GmEYf1sVBFgf8g8KXKfY0Jo2Dd4Pv+0Ojl0XxCCFsJR0rcc3S7pb
         BqrUBAiYhA1wTjtq5sX0j9UpPKtfJNY+Txreug2+M10faSZBs79ceJWV9ecd7cBFn8Iq
         ZoOyKuaBVMIC7xdQmtDEaxxWl19hyPnQ9f6aaccnYj9qpl/a2pWte8egbM9nV1w+M5/q
         pF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855819; x=1763460619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUwW7NcY3A0Nnt9i7cSR6DPTQgR8J//w2MhqorK480s=;
        b=SLFV3xn6kiYiONtUHklxlz5DFzI+VU1HJk/trhc0TkwTybnZzLdR5o3FJmAHjITZqQ
         TG0eC9OuXiSPa80KySEM6faa0upk7UqWjwKiDW3xSi/0ZVTbq1BNc/CA11wughci4Y+Q
         l2PhksLuHyyMrZDKzkneaEwAaNRacp4oHQ7Y0dxVoPj2vlVuYylym+bO1LKnkQQbwQw6
         MbISQhv2/Rszou+cq0Une++BdMUTzBvIkilKU+9cP0HA+1rNFv20gpehb8fihlhM0zGy
         xr9tbHtkARU1y4HriguCOzqN1HRtzvTjEeeb84NjnPAFmb77KUeQ5lHMIQL32hJd9vid
         XQVA==
X-Gm-Message-State: AOJu0YyXTYCagIQwRdDMM1nd7VZiy8hcRWlt4i8yS6SeLOWMSF4oQkB3
	vtFb6zzwOdAs3SK0tMCDDnMCKPraQPzbUWfJZbSIV+Z6sM/qHrt/Vj6JZ8FJz8q1
X-Gm-Gg: ASbGncsYoy4o5yP3M63CUAt+SfEkJ2EByOJxmTbx2dqa/TCtuU0T87kQEkBFi+NYNps
	2W6IQLmpDktpux/bdd4pBfxYSKS1m60FalebJHdJvShxybUKeF03DNKG0ghB3pJvAR3UqhH52yL
	nznhv+XAbu3Vemkpnz4E8sksPLKNq4LSlHTrEAlh9fCm5LdI9RLfYnKUFimQLW4ACYo9xDEUulv
	mEdZ+xDh+KzshiCCsJ16i2uUxBkWA+wEYoE4/iQEiyy+SaWRwxbvA+kcS6kplc0QypyTWEYogkj
	efdem/bH19UJykSWNVZWfeOnWx0EKuiUBEoUt/+sO1cgKJr7AkSVVUbNSflvSqa35VSbuU7ETT4
	3OR6Wrf1zSTpvYQrpnHhiAnm6/sEijNtVyrc7r4VUe20dPe7LgpGmB6i2ILximfDIcq+dmWhZ3A
	LTzUfIrtdYx4ky5gOKWIVIsTXbeaA=
X-Google-Smtp-Source: AGHT+IFoEtEeYMeGJO6FSQdA3zyfJuoVvv8Fxl9E6UqSytTtpd7ggFbIe5eET0jzR74Qxq0gurNs+w==
X-Received: by 2002:a05:6402:2554:b0:63b:ef0e:dfa7 with SMTP id 4fb4d7f45d1cf-6415dc044d2mr9942388a12.6.1762855818179;
        Tue, 11 Nov 2025 02:10:18 -0800 (PST)
Received: from tempest2.wbe.local (xt27d7.stansat.pl. [83.243.39.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e0cesm13413859a12.33.2025.11.11.02.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:10:17 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Antony Kolitsos <zeusomighty@hotmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] wifi: mwl8k: inject DSSS Parameter Set element into beacons if missing
Date: Tue, 11 Nov 2025 11:07:29 +0100
Message-ID: <20251111100733.2825970-3-paweldembicki@gmail.com>
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

Fixes: b64fe619e371 ("mwl8k: basic AP interface support")
Tested-by: Antony Kolitsos <zeusomighty@hotmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
V2:
  - added "wifi:" prefix to commit title
  - renamed "DS Params" -> "DSSS Parameter Set"
  - Insert WLAN_EID_DS_PARAMS after WLAN_EID_SSID, WLAN_EID_SUPP_RATES
    and WLAN_EID_EXT_SUPP_RATES
V3:
  - Insert WLAN_EID_DS_PARAMS after WLAN_EID_SSID and WLAN_EID_SUPP_RATES
    only
  - Style issues fixes
V4:
  - Style issues fixes
  - Added "Fixes"
---
 drivers/net/wireless/marvell/mwl8k.c | 71 ++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 891e125ad30b..54d6d00ecdf1 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -2966,6 +2966,51 @@ mwl8k_cmd_rf_antenna(struct ieee80211_hw *hw, int antenna, int mask)
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
+		WLAN_EID_SSID,
+		WLAN_EID_SUPP_RATES,
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
+	/* Inject a DSSS Parameter Set after SSID + Supp Rates */
+	buf_dst[pos + 0] = WLAN_EID_DS_PARAMS;
+	buf_dst[pos + 1] = 1;
+	buf_dst[pos + 2] = hw->conf.chandef.chan->hw_value;
+
+	memcpy(buf_dst + pos + 3, buf_src + pos, left);
+}
 struct mwl8k_cmd_set_beacon {
 	struct mwl8k_cmd_pkt_hdr header;
 	__le16 beacon_len;
@@ -2975,17 +3020,33 @@ struct mwl8k_cmd_set_beacon {
 static int mwl8k_cmd_set_beacon(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif, u8 *beacon, int len)
 {
+	bool ds_params_present = mwl8k_beacon_has_ds_params(beacon, len);
 	struct mwl8k_cmd_set_beacon *cmd;
-	int rc;
+	int rc, final_len = len;
 
-	cmd = kzalloc(sizeof(*cmd) + len, GFP_KERNEL);
+	if (!ds_params_present) {
+		/*
+		 * mwl8k firmware requires a DS Params IE with the current
+		 * channel in AP beacons. If mac80211/hostapd does not
+		 * include it, inject one here. IE ID + length + channel
+		 * number = 3 bytes.
+		 */
+		final_len += 3;
+	}
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


