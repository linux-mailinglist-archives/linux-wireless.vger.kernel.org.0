Return-Path: <linux-wireless+bounces-17770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D1A175CB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 02:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B017A1C68
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 01:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A23987D;
	Tue, 21 Jan 2025 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="JgaXl73f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE59188006;
	Tue, 21 Jan 2025 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423204; cv=none; b=LS5nKtpx57r/wB/0qKQBsuJWny0XTJfiGWokpT5D4VTOEjbbshu0TxX46L7U+3uoI28Iur9WeDt17B9FVwX3w8ZM/15silY+teL+6714BKESDRT8U+ckNWqehhGjO4yCQJ0PxtfcOztmm1BOpU6BDJMFax09OQY7qNeQOlzEgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423204; c=relaxed/simple;
	bh=CRXk7XMa0DMM/R41q7VZUzVo85QJLovxKxX3D4dGsPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2LPrqeJeFr+O6Pd+S0ozCCvY+cgA1EADF+mrAsP9gbDb/KOBngQR0vg2rT8srRj+22++n13JDnO/sdS1GkVZ5q4F+NHH4MU4pCjVYImtqs7m3H/orpD9JHCIT4CdHkMKsHJYqQWhmX5A0KT9q56+TnSFYcL2D5DPB9MFRk377g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=JgaXl73f; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=vyjyO37Ga6Gx8qYJ0PsYqbzurBUaw5cOYROc+FVJCFA=; b=JgaXl73flt2ljOVl
	RXhN0K8JszqUNYjxo++gzd6NqllkY8DiNIfgqCEO/nNRAT6EtASF/37RAeCVAO7QTFuuoHv0RRbGL
	l810z7Gi12fNQ47oz+9EfL5hEM/o44iRFTtVneZelgNgoSm5JPYg/M3YI3dxYaNk4MVb3C3H0kZaA
	QaMKXRpe9hY3fKW+ug+qDyLRkHRPA2F6p3VfCpcdKgv9/N8IJflTWpweDhG1RrX45l8nXIuzBjKx7
	7oNz6moW2+9LWTZMqp/OQQA3X/dLp4lhgSus+wn1RQPJjjyIV925N0wb/8NdCWMNbcMzisku+lrgW
	e9XytQV/dpTTEhN5lQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ta38Y-00BEI2-06;
	Tue, 21 Jan 2025 01:33:02 +0000
From: linux@treblig.org
To: kvalo@kernel.org,
	libertas-dev@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] wifi: libertas: Remove unused cmd functions
Date: Tue, 21 Jan 2025 01:32:59 +0000
Message-ID: <20250121013300.433538-3-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121013300.433538-1-linux@treblig.org>
References: <20250121013300.433538-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

lbs_get_snmp_mib(), lbs_set_power_adapt_cfg(), lbs_set_tpc_cfg()
and lbs_set_tx_power() have been unused since 2010's
commit e86dc1ca4676 ("Libertas: cfg80211 support")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/marvell/libertas/cmd.c | 129 --------------------
 drivers/net/wireless/marvell/libertas/cmd.h |  10 --
 2 files changed, 139 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cmd.c b/drivers/net/wireless/marvell/libertas/cmd.c
index 5a525da434c2..4032bbd28acd 100644
--- a/drivers/net/wireless/marvell/libertas/cmd.c
+++ b/drivers/net/wireless/marvell/libertas/cmd.c
@@ -452,46 +452,6 @@ int lbs_set_snmp_mib(struct lbs_private *priv, u32 oid, u16 val)
 	return ret;
 }
 
-/**
- *  lbs_get_snmp_mib - Get an SNMP MIB value
- *
- *  @priv:	A pointer to &struct lbs_private structure
- *  @oid:	The OID to retrieve from the firmware
- *  @out_val:	Location for the returned value
- *
- *  returns:	0 on success, error on failure
- */
-int lbs_get_snmp_mib(struct lbs_private *priv, u32 oid, u16 *out_val)
-{
-	struct cmd_ds_802_11_snmp_mib cmd;
-	int ret;
-
-	memset(&cmd, 0, sizeof (cmd));
-	cmd.hdr.size = cpu_to_le16(sizeof(cmd));
-	cmd.action = cpu_to_le16(CMD_ACT_GET);
-	cmd.oid = cpu_to_le16(oid);
-
-	ret = lbs_cmd_with_response(priv, CMD_802_11_SNMP_MIB, &cmd);
-	if (ret)
-		goto out;
-
-	switch (le16_to_cpu(cmd.bufsize)) {
-	case sizeof(u8):
-		*out_val = cmd.value[0];
-		break;
-	case sizeof(u16):
-		*out_val = le16_to_cpu(*((__le16 *)(&cmd.value)));
-		break;
-	default:
-		lbs_deb_cmd("SNMP_CMD: (get) unhandled OID 0x%x size %d\n",
-		            oid, le16_to_cpu(cmd.bufsize));
-		break;
-	}
-
-out:
-	return ret;
-}
-
 /**
  *  lbs_get_tx_power - Get the min, max, and current TX power
  *
@@ -524,31 +484,6 @@ int lbs_get_tx_power(struct lbs_private *priv, s16 *curlevel, s16 *minlevel,
 	return ret;
 }
 
-/**
- *  lbs_set_tx_power - Set the TX power
- *
- *  @priv:	A pointer to &struct lbs_private structure
- *  @dbm:	The desired power level in dBm
- *
- *  returns: 	   	0 on success, error on failure
- */
-int lbs_set_tx_power(struct lbs_private *priv, s16 dbm)
-{
-	struct cmd_ds_802_11_rf_tx_power cmd;
-	int ret;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.hdr.size = cpu_to_le16(sizeof(cmd));
-	cmd.action = cpu_to_le16(CMD_ACT_SET);
-	cmd.curlevel = cpu_to_le16(dbm);
-
-	lbs_deb_cmd("SET_RF_TX_POWER: %d dBm\n", dbm);
-
-	ret = lbs_cmd_with_response(priv, CMD_802_11_RF_TX_POWER, &cmd);
-
-	return ret;
-}
-
 /**
  *  lbs_set_monitor_mode - Enable or disable monitor mode
  *  (only implemented on OLPC usb8388 FW)
@@ -1440,70 +1375,6 @@ void lbs_ps_confirm_sleep(struct lbs_private *priv)
 }
 
 
-/**
- * lbs_set_tpc_cfg - Configures the transmission power control functionality
- *
- * @priv:	A pointer to &struct lbs_private structure
- * @enable:	Transmission power control enable
- * @p0:		Power level when link quality is good (dBm).
- * @p1:		Power level when link quality is fair (dBm).
- * @p2:		Power level when link quality is poor (dBm).
- * @usesnr:	Use Signal to Noise Ratio in TPC
- *
- * returns:	0 on success
- */
-int lbs_set_tpc_cfg(struct lbs_private *priv, int enable, int8_t p0, int8_t p1,
-		int8_t p2, int usesnr)
-{
-	struct cmd_ds_802_11_tpc_cfg cmd;
-	int ret;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.hdr.size = cpu_to_le16(sizeof(cmd));
-	cmd.action = cpu_to_le16(CMD_ACT_SET);
-	cmd.enable = !!enable;
-	cmd.usesnr = !!usesnr;
-	cmd.P0 = p0;
-	cmd.P1 = p1;
-	cmd.P2 = p2;
-
-	ret = lbs_cmd_with_response(priv, CMD_802_11_TPC_CFG, &cmd);
-
-	return ret;
-}
-
-/**
- * lbs_set_power_adapt_cfg - Configures the power adaptation settings
- *
- * @priv:	A pointer to &struct lbs_private structure
- * @enable:	Power adaptation enable
- * @p0:		Power level for 1, 2, 5.5 and 11 Mbps (dBm).
- * @p1:		Power level for 6, 9, 12, 18, 22, 24 and 36 Mbps (dBm).
- * @p2:		Power level for 48 and 54 Mbps (dBm).
- *
- * returns:	0 on Success
- */
-
-int lbs_set_power_adapt_cfg(struct lbs_private *priv, int enable, int8_t p0,
-		int8_t p1, int8_t p2)
-{
-	struct cmd_ds_802_11_pa_cfg cmd;
-	int ret;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.hdr.size = cpu_to_le16(sizeof(cmd));
-	cmd.action = cpu_to_le16(CMD_ACT_SET);
-	cmd.enable = !!enable;
-	cmd.P0 = p0;
-	cmd.P1 = p1;
-	cmd.P2 = p2;
-
-	ret = lbs_cmd_with_response(priv, CMD_802_11_PA_CFG , &cmd);
-
-	return ret;
-}
-
-
 struct cmd_ctrl_node *__lbs_cmd_async(struct lbs_private *priv,
 	uint16_t command, struct cmd_header *in_cmd, int in_cmd_size,
 	int (*callback)(struct lbs_private *, unsigned long, struct cmd_header *),
diff --git a/drivers/net/wireless/marvell/libertas/cmd.h b/drivers/net/wireless/marvell/libertas/cmd.h
index d7be232f5739..a95c2651e67f 100644
--- a/drivers/net/wireless/marvell/libertas/cmd.h
+++ b/drivers/net/wireless/marvell/libertas/cmd.h
@@ -105,19 +105,9 @@ int lbs_get_tx_power(struct lbs_private *priv, s16 *curlevel, s16 *minlevel,
 
 int lbs_set_snmp_mib(struct lbs_private *priv, u32 oid, u16 val);
 
-int lbs_get_snmp_mib(struct lbs_private *priv, u32 oid, u16 *out_val);
-
 
 /* Commands only used in wext.c, assoc. and scan.c */
 
-int lbs_set_power_adapt_cfg(struct lbs_private *priv, int enable, int8_t p0,
-		int8_t p1, int8_t p2);
-
-int lbs_set_tpc_cfg(struct lbs_private *priv, int enable, int8_t p0, int8_t p1,
-		int8_t p2, int usesnr);
-
-int lbs_set_tx_power(struct lbs_private *priv, s16 dbm);
-
 int lbs_set_deep_sleep(struct lbs_private *priv, int deep_sleep);
 
 int lbs_set_host_sleep(struct lbs_private *priv, int host_sleep);
-- 
2.48.1


