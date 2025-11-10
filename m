Return-Path: <linux-wireless+bounces-28717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19426C45338
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974283A612B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 07:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00762EB86D;
	Mon, 10 Nov 2025 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d91yox7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F62E92AB
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759510; cv=none; b=DX89miS7iPe4HbRLcv49L0s1jv4HEBxD2KjYXgDeAt5D3IGp8nWixsJHVphhK8+DMRnLxpBDTKVhMnpfbosZHudraZcnCbrVWKAeBV6GAkmtALyCBGQ4ybO34kLYYaNWOCzoFD3hLUWB/h0nxJ40wgGtjKbfgfivAdmKwJ+MSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759510; c=relaxed/simple;
	bh=C3gGqZ5U8ux1aPUbNSsW0BzmedeousX0iTp7nghe9FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g53Gu6+14tLhsClz+efOZoU4BA0+50JxRVd4kyn28UWLJFVDkIdHyXF61SzSlmkc1OLgHdzGqxxLgQJPdZkCCCZ8IGqsb7Bxa7itVHSGkFNJEUi35gDwyiN0XZDawJLMwnVVQ2+aTYGFSzcxGDLj64abLR+UlDDkCQ/t56LEVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d91yox7F; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso4662782a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 09 Nov 2025 23:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762759507; x=1763364307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhkptmGE1DDJk6/2xm0aT+Urj2GqEr04ECiE4Pa6iDs=;
        b=d91yox7FlBABYWhvrwtlc9OqcQUiM911ldnJ3qKldyAjeI+MQdNCDs6kdnVdnoWjEy
         Xyf+LutP2R2IdmizueYhbKzYWHnGZRbf6Xkm0LO8Kb//fb27adhbQX3EOsG8OctNyjzm
         vMOhVnisyRu5SXKDuYdDVNRmaltyBacUyRYrZUYxpEaO6fMLG/7OZr2hG9TgyhmZ2sbH
         zjBvMQFpgSBh8w2UEOMbt8sHuF8j7OsDG3UANNgwHy6m67zgAQnIu/+EXctsiM7G9kDw
         fUcw0joFzRq4GOX38cwLVWVwb/LB4RwgVoqXZRkp/7C2x+Jtm/EONoy/xJfwAi9sc4aH
         /zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762759507; x=1763364307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhkptmGE1DDJk6/2xm0aT+Urj2GqEr04ECiE4Pa6iDs=;
        b=IwZmnG1pdATuRFZBGH1E++KjaIreN1wYLBoXDnWvWqwvx8WgFD8cfs8J2VzAtlIQuG
         PeE6Q0k//IxuDBBq9Srm3df1tBz2q7LZ6/KzLnZ2UDxqvT2omThC0wBLmkzppHcFYYo4
         2g/poLhgCO5yUEUBfXy3+BsjxCfn9KiL4lEKyBJ2nfTGiaVNZ7/CrvlKO06+8AKstOxy
         GXvxFCPAG7GmnAEx03qeAMkUoYjgIKBSGhNkDmw+D/vUu8Wk46emepDgSC3KbW43OYje
         zpt5HZOa5AmR/y98bRu/XdtVI2B6B/9iOcbiV2Ys7/sEqbOy5GIxu1xjB3PVQCMMew6l
         mSCQ==
X-Gm-Message-State: AOJu0YyBM72UBOamhgIJHHyfRR7cPKHypQ+4tCPj8CG/pRCnXuhk1jyu
	luCKC6JQJtCXIQCBZsoJNDmFyQyQ0XLmCdYmHxVUqN/pU5hOM/8cAzQVNJpSZg==
X-Gm-Gg: ASbGncsZ98McQgk5b6XYcDap9lqYASyONIMqCkKzE3kWptAsa6FFQpPQ7PMpRWaROE3
	t/Eo2yPO3BukNqSOchMsxiZjZDAhXcaN98VtLNDgb6nV85bhW1xbfLGijRnezv1ioGcYA7h2mFt
	qZ1FblOTut9P1wWnP/JTcfIPU1EZG0g0ud2DjGobgshdRfyfegcmG4SlthYnY3/hy6MYjREurlB
	hmBJnJ3t8rqWQNKMyuupW1YnxIBfAyuBVjepXmRbpueZOgeplVjyWlmOzn1272i7jObYvSQY0e9
	H6MqhEV9Q1jBDMNW7u5+vzzmlUTWZz/pJGmY9+HYRD/X39MeKgon3aWuI3T78u6wldCLdZusNCB
	ZkMj2mHLBvJAjobee7P7etzsI0h9VCzyfh37MfNGanEujZcp9DzM898VwwfKghIDKyZObsGMwhm
	lH97L1I7ApkadDRpI2bh84dNpPYZ4=
X-Google-Smtp-Source: AGHT+IFXvPsBl9JXtCQHnVgKHRgjg/ljhd7h8KWm++ej2k9gFajvgXLbFcMylGufmwQk56PV5RfbcA==
X-Received: by 2002:a05:6402:438a:b0:640:c394:5a4 with SMTP id 4fb4d7f45d1cf-6415dc1aea7mr6419131a12.16.1762759506794;
        Sun, 09 Nov 2025 23:25:06 -0800 (PST)
Received: from tempest2.wbe.local (xt27d7.stansat.pl. [83.243.39.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415d91f486sm6047907a12.22.2025.11.09.23.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 23:25:06 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Antony Kolitsos <zeusomighty@hotmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mwl8k: inject DS Params IE into beacons if missing
Date: Mon, 10 Nov 2025 08:23:49 +0100
Message-ID: <20251110072359.2295615-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Marvell AP firmware used with mwl8k misbehaves when beacon frames
do not contain a WLAN_EID_DS_PARAMS information element with the current
channel. It was reported on OpenWrt Github issues [0].

When hostapd/mac80211 omits DS Params from the beacon (which is valid on
some bands), the firmware stops transmitting sane frames and RX status
starts reporting bogus channel information. This makes AP mode unusable.

Newer Marvell drivers (mwlwifi [1]) hard-code DS Params IE into AP beacons
for all chips, which suggests this is a firmware requirement rather than
a mwl8k-specific quirk.

Mirror that behaviour in mwl8k: when setting the beacon, check if
WLAN_EID_DS_PARAMS is present, and if not, extend the beacon and inject
a DS Params IE at the beginning of the IE list, using the current
channel from hw->conf.chandef.chan.

Tested on Linksys EA4500 (88W8366).

[0] https://github.com/openwrt/openwrt/issues/19088
[1] https://github.com/kaloz/mwlwifi/blob/db97edf20fadea2617805006f5230665fadc6a8c/hif/fwcmd.c#L675

Tested-by: Antony Kolitsos <zeusomighty@hotmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/wireless/marvell/mwl8k.c | 61 +++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 891e125ad30b..97462d05c9ab 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -2966,6 +2966,42 @@ mwl8k_cmd_rf_antenna(struct ieee80211_hw *hw, int antenna, int mask)
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
+	const u8 *ies;
+	int hdr_len, left;
+
+	ies = mgmt->u.beacon.variable;
+	hdr_len = ies - buf_src;
+	left = src_len - hdr_len;
+
+	memcpy(buf_dst, buf_src, hdr_len);
+
+	/* Inject a DS Params IE at the beginning of the IE list */
+	buf_dst[hdr_len + 0] = WLAN_EID_DS_PARAMS;
+	buf_dst[hdr_len + 1] = 1;
+	buf_dst[hdr_len + 2] = hw->conf.chandef.chan->hw_value;
+
+	memcpy(buf_dst + hdr_len + 3, buf_src + hdr_len, left);
+}
 struct mwl8k_cmd_set_beacon {
 	struct mwl8k_cmd_pkt_hdr header;
 	__le16 beacon_len;
@@ -2975,17 +3011,32 @@ struct mwl8k_cmd_set_beacon {
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


