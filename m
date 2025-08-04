Return-Path: <linux-wireless+bounces-26126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 974F7B1A3F6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381B37A065B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89F226D4E3;
	Mon,  4 Aug 2025 13:58:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6861DD9AC
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315932; cv=none; b=iEVH0tlAEfpxfKLNmtFuJwmWS4fWNLqjvJUTXNTVTNorHDccMjalVDnsz6znDIFm8UZGspbEW3Mbj2chYbvi1fr7yrAMXOKkmxU5dMNIf8aFgj5HbK0XN+X2RomEC1feCtZl+brp/x4wOka53SccTvlw+XA6kxGVLmR56vKYmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315932; c=relaxed/simple;
	bh=cqE4qV1GmW4DOOyMdYzmu3J+NlBGbASTIgWS1j46NDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iwwrH2e4e/JX6Yd4FaO+7zxDWwwwgn697oRxSfM10KnmVw/vCbwEvbmCvX2Lfr8cXE79VcR02lf0D/jIRiee6EJ7egUa4MiFOhroe01SmcNbyVHbM7pKZggitJW16d7TLUpL8n+Sfwy1PY7fUjMObixCeM3ZdaeSdf6HvNzQSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uivi2-0004TF-A7; Mon, 04 Aug 2025 15:58:38 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uivi1-00BsoR-2S;
	Mon, 04 Aug 2025 15:58:37 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uivi1-008cZX-2E;
	Mon, 04 Aug 2025 15:58:37 +0200
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Date: Mon, 04 Aug 2025 15:58:27 +0200
Subject: [PATCH] wifi: mwifiex: add rgpower table loading support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-feature-mwifiex-rgpower-table-loading-v1-1-358e70a4d45e@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAIO8kGgC/x3NQQrCMBBG4auUWTsQayPBq4iLmP6JAzUpk2oLp
 Xc3uPw27+1UoYJKt24nxVeqlNxwPnUUXj4nsIzN1JveGmcGjvDLR8HvVaJgY01zWaG8+OcEnoo
 fJSe+OhcufYC1fqDWmhVRtv/n/jiOH1rxWCN3AAAA
X-Change-ID: 20250804-feature-mwifiex-rgpower-table-loading-688c32ce55a4
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, s.hauer@pengutronix.de, 
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Marvell/NXP Wi-Fi adapters allow fine-grained adjustment of the transmit
power levels and various other internal parameters. This is done by
sending command streams to the adapter. One storage format of these
command streams are the rgpower tables, which consist of multiple
command blocks in the following format:

command_block_1 = {
XX XX LL LL XX XX ..
}
command_block_n = {
XX XX LL LL XX XX XX ..
}

XX = raw byte as hex chars
LL = total length of the "raw" command block

These command blocks are parsed into their binary representation and
then send to the adapter. The parsing logic was adapted from NXP's
mwifiex driver[1].

The rgpower tables matching the currently set regulatory domain are
automatically requested and applied. If not found the existing device
tree provided power tables are tried as well.

[1]:
https://github.com/nxp-imx/mwifiex/blob/7a8beaa1605cb0870dc7ba3312c76df91cb0d6cf/mlan/mlan_cmdevt.c#L812

Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/main.c      |   5 +
 drivers/net/wireless/marvell/mwifiex/main.h      |   3 +
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c   | 115 +++++++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c |  58 +++++++++++-
 4 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 7b50a88a18e57328a714cb3d31f6a71b7b9ec322..36c931fe5322e63a5467c645ba16e67b9b1885e7 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -494,6 +494,11 @@ static void mwifiex_free_adapter(struct mwifiex_adapter *adapter)
 		return;
 	}
 
+	if (adapter->rgpower_data) {
+		release_firmware(adapter->rgpower_data);
+		adapter->rgpower_data = NULL;
+	}
+
 	mwifiex_unregister(adapter);
 	pr_debug("info: %s: free adapter\n", __func__);
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 9ac36bef980eb632dc4c0f67b9c5927b7336a6d3..27559e2ddc31757f4575071a7eb827f26cdfb1e0 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -982,6 +982,7 @@ struct mwifiex_adapter {
 	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
 	u16 max_mgmt_ie_index;
 	const struct firmware *cal_data;
+	const struct firmware *rgpower_data;
 	struct device_node *dt_node;
 
 	/* 11AC */
@@ -1579,6 +1580,8 @@ int mwifiex_11h_handle_event_chanswann(struct mwifiex_private *priv);
 int mwifiex_dnld_dt_cfgdata(struct mwifiex_private *priv,
 			    struct device_node *node, const char *prefix);
 void mwifiex_dnld_txpwr_table(struct mwifiex_private *priv);
+int mwifiex_send_rgpower_table(struct mwifiex_private *priv, const u8 *data,
+			       const size_t size);
 
 extern const struct ethtool_ops mwifiex_ethtool_ops;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index c93281f5a47c0ef50a66bb5f46e08a2858c261e3..6d9e2af29a69da3f6b1d9386788b4d92273380b1 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1483,6 +1483,121 @@ int mwifiex_dnld_dt_cfgdata(struct mwifiex_private *priv,
 	return 0;
 }
 
+static int mwifiex_rgpower_table_advance_to_content(u8 **pos, const u8 *data,
+						    const size_t size)
+{
+	while (*pos - data < size) {
+		/* skip spaces, tabs and empty lines */
+		if (**pos == '\r' || **pos == '\n' || **pos == '\0' ||
+		    isspace(**pos)) {
+			(*pos)++;
+			continue;
+		}
+		/* skip line comments */
+		if (**pos == '#') {
+			*pos = strchr(*pos, '\n');
+			if (!*pos)
+				return -EINVAL;
+			(*pos)++;
+			continue;
+		}
+		return 0;
+	}
+	return 0;
+}
+
+int mwifiex_send_rgpower_table(struct mwifiex_private *priv, const u8 *data,
+				const size_t size)
+{
+	int ret = 0;
+	bool start_raw = false;
+	u8 *ptr, *token, *pos = NULL;
+	u8 *_data __free(kfree) = NULL;
+	struct mwifiex_adapter *adapter = priv->adapter;
+	struct mwifiex_ds_misc_cmd *hostcmd __free(kfree) = NULL;
+
+	hostcmd = kzalloc(sizeof(*hostcmd), GFP_KERNEL);
+	if (!hostcmd)
+		return -ENOMEM;
+
+	_data = kmemdup(data, size, GFP_KERNEL);
+	if (!_data) {
+		kfree(hostcmd);
+		return -ENOMEM;
+	}
+
+	pos = _data;
+	ptr = hostcmd->cmd;
+	while ((pos - _data) < size) {
+		ret = mwifiex_rgpower_table_advance_to_content(&pos, _data, size);
+		if (ret) {
+			mwifiex_dbg(
+				adapter, ERROR,
+				"%s: failed to advance to content in rgpower table\n",
+				__func__);
+			return ret;
+		}
+
+		if (*pos == '}' && start_raw) {
+			memcpy(&hostcmd->len, &hostcmd->cmd[2], sizeof(u16));
+			ret = mwifiex_send_cmd(priv, 0, 0, 0, hostcmd, false);
+			if (ret) {
+				mwifiex_dbg(adapter, ERROR,
+					    "%s: failed to send hostcmd %d\n",
+					    __func__, ret);
+				return ret;
+			}
+
+			memset(hostcmd->cmd, 0, MWIFIEX_SIZE_OF_CMD_BUFFER);
+			ptr = hostcmd->cmd;
+			start_raw = false;
+			pos++;
+			continue;
+		}
+
+		if (!start_raw) {
+			pos = strchr(pos, '=');
+			if (pos) {
+				pos = strchr(pos, '{');
+				if (pos) {
+					start_raw = true;
+					pos++;
+					continue;
+				}
+			}
+			mwifiex_dbg(adapter, ERROR,
+				    "%s: syntax error in hostcmd\n", __func__);
+			return -EINVAL;
+		}
+
+		if (start_raw) {
+			while ((*pos != '\r' && *pos != '\n') &&
+			       (token = strsep((char **)&pos, " "))) {
+				if (ptr - hostcmd->cmd >=
+				    MWIFIEX_SIZE_OF_CMD_BUFFER) {
+					mwifiex_dbg(
+						adapter, ERROR,
+						"%s: hostcmd is larger than %d, aborting\n",
+						__func__, MWIFIEX_SIZE_OF_CMD_BUFFER);
+					return -ENOMEM;
+				}
+
+				ret = kstrtou8(token, 16, ptr);
+				if (ret < 0) {
+					mwifiex_dbg(
+						adapter, ERROR,
+						"%s: failed to parse hostcmd %d token: %s\n",
+						__func__, ret, token);
+					return ret;
+				}
+				ptr++;
+			}
+		}
+	}
+
+	return ret;
+}
+
 /* This function prepares command of set_cfg_data. */
 static int mwifiex_cmd_cfg_data(struct mwifiex_private *priv,
 				struct host_cmd_ds_command *cmd, void *data_buf)
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index f79589cafe5725f0300573337ba8bbfb471a6d31..ef6722ffdc74d8cb69091e0a171f4059980b75d3 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -180,7 +180,7 @@ int mwifiex_fill_new_bss_desc(struct mwifiex_private *priv,
 	return mwifiex_update_bss_desc_with_ie(priv->adapter, bss_desc);
 }
 
-void mwifiex_dnld_txpwr_table(struct mwifiex_private *priv)
+static void mwifiex_dnld_dt_txpwr_table(struct mwifiex_private *priv)
 {
 	if (priv->adapter->dt_node) {
 		char txpwr[] = {"marvell,00_txpwrlimit"};
@@ -190,6 +190,62 @@ void mwifiex_dnld_txpwr_table(struct mwifiex_private *priv)
 	}
 }
 
+static int mwifiex_request_rgpower_table(struct mwifiex_private *priv)
+{
+	struct mwifiex_802_11d_domain_reg *domain_info = &priv->adapter->domain_reg;
+	struct mwifiex_adapter *adapter = priv->adapter;
+	char rgpower_table_name[30];
+	char country_code[3];
+
+	strscpy(country_code, domain_info->country_code, sizeof(country_code));
+
+	/* World regulatory domain "00" has WW as country code */
+	if (strncmp(country_code, "00", 2) == 0)
+		strscpy(country_code, "WW", sizeof(country_code));
+
+	snprintf(rgpower_table_name, sizeof(rgpower_table_name),
+		 "nxp/rgpower_%s.bin", country_code);
+
+	mwifiex_dbg(adapter, INFO, "info: %s: requesting regulatory power table %s\n",
+		    __func__, rgpower_table_name);
+
+	if (adapter->rgpower_data) {
+		release_firmware(adapter->rgpower_data);
+		adapter->rgpower_data = NULL;
+	}
+
+	if ((request_firmware(&adapter->rgpower_data, rgpower_table_name,
+			      adapter->dev))) {
+		mwifiex_dbg(
+			adapter, INFO,
+			"info: %s: failed to request regulatory power table\n",
+			__func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mwifiex_dnld_rgpower_table(struct mwifiex_private *priv)
+{
+	int ret;
+
+	ret = mwifiex_request_rgpower_table(priv);
+	if (ret)
+		return ret;
+
+	return mwifiex_send_rgpower_table(priv, priv->adapter->rgpower_data->data,
+					  priv->adapter->rgpower_data->size);
+}
+
+void mwifiex_dnld_txpwr_table(struct mwifiex_private *priv)
+{
+	if (mwifiex_dnld_rgpower_table(priv) == 0)
+		return;
+
+	mwifiex_dnld_dt_txpwr_table(priv);
+}
+
 static int mwifiex_process_country_ie(struct mwifiex_private *priv,
 				      struct cfg80211_bss *bss)
 {

---
base-commit: d2eedaa3909be9102d648a4a0a50ccf64f96c54f
change-id: 20250804-feature-mwifiex-rgpower-table-loading-688c32ce55a4

Best regards,
-- 
Stefan Kerkmann <s.kerkmann@pengutronix.de>


