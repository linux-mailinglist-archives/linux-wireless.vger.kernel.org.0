Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AEB2B26DA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 22:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKMVb5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 16:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKMVbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 16:31:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E1C061A4D
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 13:23:15 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605302594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGFBovw44il0juIYB3LHxttk4G9Z5FVoSfOWTqq+G1c=;
        b=3FYFZ3FCscLSIGT+we8T0vMgIdO/C/oB736anToHdtOkBNclj7aYJb3PDzZ5gge4JYoQP5
        WcIjqc8TXjT3sQ/nCa9FwzpOU6GpkM/lTzKlpatQuoNTzOXS4kB0b7ev4+H/1Vi41BK79F
        dJuJJdVKSlQQfwBKnla9w/8CSF31kKFfgEq5Y3DJav8M+3NyiXLfpTkPWEeuxZHyBGeW25
        lst/DKJNRWvDIwZ3hpjHwQ/V+KMAgzCOtAl6xMtE28q2qfhO3gfFSiCmXLFfmGI9sqWnr7
        Xe1uNS8Q99bz2+yjMp9eJKgqUGZ34joC7ay/3kdUcGuE7cYlAwzx6ucXNzAx1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605302594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGFBovw44il0juIYB3LHxttk4G9Z5FVoSfOWTqq+G1c=;
        b=Ps+Tp4STJ7nw6iuT6L6pGZxR/7brWxmar+mEF/BzdjT2LgUHRLISvc9AP9rNjclfBuh84r
        3Io8DDh+xOoNihDg==
To:     linux-wireless@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Williams <dcbw@redhat.com>,
        Jes Sorensen <jes.sorensen@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/10] orinoco: Annotate ezusb_read_ltv()
Date:   Fri, 13 Nov 2020 22:22:52 +0100
Message-Id: <20201113212252.2243570-11-bigeasy@linutronix.de>
In-Reply-To: <20201113212252.2243570-1-bigeasy@linutronix.de>
References: <20201113212252.2243570-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ezusb_read_ltv() is always invoked via the ->read_ltv() callback. This
callback is mostly invoked under orinoco_lock() which disables BH.

There are a few invocations during probe which occur in preemptible
context via:
   ezusb_probe() -> orinoco_init() -> determine_fw_capabilities()

Extend `hermes_ops' with the ->read_ltv_pr callback which is implemented
with the same callback like ->read_ltv on `hermes_ops_local'.
On `ezusb_ops' ->read_ltv is used for callbacks under the lock which
need to poll.
The new ->read_ltv_pr() is used in the preemptible context in which it
is possible to wait for the completion. Provide HERMES_READ_RECORD_PR()
and hermes_read_wordrec_pr() which behave like their non _pr equivalents
and invoke ->read_ltv_pr().

This removes the last user of ezusb_req_ctx_wait() and can now be
removed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../net/wireless/intersil/orinoco/hermes.c    |  1 +
 .../net/wireless/intersil/orinoco/hermes.h    | 15 ++++++
 drivers/net/wireless/intersil/orinoco/hw.c    | 32 ++++++------
 .../wireless/intersil/orinoco/orinoco_usb.c   | 49 ++++++++-----------
 4 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/hermes.c b/drivers/net/w=
ireless/intersil/orinoco/hermes.c
index 43790fbea0e00..6d4b7f64efcf5 100644
--- a/drivers/net/wireless/intersil/orinoco/hermes.c
+++ b/drivers/net/wireless/intersil/orinoco/hermes.c
@@ -763,6 +763,7 @@ static const struct hermes_ops hermes_ops_local =3D {
 	.init_cmd_wait =3D hermes_doicmd_wait,
 	.allocate =3D hermes_allocate,
 	.read_ltv =3D hermes_read_ltv,
+	.read_ltv_pr =3D hermes_read_ltv,
 	.write_ltv =3D hermes_write_ltv,
 	.bap_pread =3D hermes_bap_pread,
 	.bap_pwrite =3D hermes_bap_pwrite,
diff --git a/drivers/net/wireless/intersil/orinoco/hermes.h b/drivers/net/w=
ireless/intersil/orinoco/hermes.h
index 9f668185b7d28..3dc561a5cb7ae 100644
--- a/drivers/net/wireless/intersil/orinoco/hermes.h
+++ b/drivers/net/wireless/intersil/orinoco/hermes.h
@@ -386,6 +386,8 @@ struct hermes_ops {
 	int (*allocate)(struct hermes *hw, u16 size, u16 *fid);
 	int (*read_ltv)(struct hermes *hw, int bap, u16 rid, unsigned buflen,
 			u16 *length, void *buf);
+	int (*read_ltv_pr)(struct hermes *hw, int bap, u16 rid,
+			      unsigned buflen, u16 *length, void *buf);
 	int (*write_ltv)(struct hermes *hw, int bap, u16 rid,
 			 u16 length, const void *value);
 	int (*bap_pread)(struct hermes *hw, int bap, void *buf, int len,
@@ -494,6 +496,8 @@ static inline void hermes_clear_words(struct hermes *hw=
, int off,
=20
 #define HERMES_READ_RECORD(hw, bap, rid, buf) \
 	(hw->ops->read_ltv((hw), (bap), (rid), sizeof(*buf), NULL, (buf)))
+#define HERMES_READ_RECORD_PR(hw, bap, rid, buf) \
+	(hw->ops->read_ltv_pr((hw), (bap), (rid), sizeof(*buf), NULL, (buf)))
 #define HERMES_WRITE_RECORD(hw, bap, rid, buf) \
 	(hw->ops->write_ltv((hw), (bap), (rid), \
 			    HERMES_BYTES_TO_RECLEN(sizeof(*buf)), (buf)))
@@ -509,6 +513,17 @@ static inline int hermes_read_wordrec(struct hermes *h=
w, int bap, u16 rid,
 	return err;
 }
=20
+static inline int hermes_read_wordrec_pr(struct hermes *hw, int bap, u16 r=
id,
+					 u16 *word)
+{
+	__le16 rec;
+	int err;
+
+	err =3D HERMES_READ_RECORD_PR(hw, bap, rid, &rec);
+	*word =3D le16_to_cpu(rec);
+	return err;
+}
+
 static inline int hermes_write_wordrec(struct hermes *hw, int bap, u16 rid,
 				       u16 word)
 {
diff --git a/drivers/net/wireless/intersil/orinoco/hw.c b/drivers/net/wirel=
ess/intersil/orinoco/hw.c
index 61af5a28f269f..2c7adb4be1003 100644
--- a/drivers/net/wireless/intersil/orinoco/hw.c
+++ b/drivers/net/wireless/intersil/orinoco/hw.c
@@ -78,7 +78,7 @@ int determine_fw_capabilities(struct orinoco_private *pri=
v,
 	char tmp[SYMBOL_MAX_VER_LEN + 1] __attribute__((aligned(2)));
=20
 	/* Get the hardware version */
-	err =3D HERMES_READ_RECORD(hw, USER_BAP, HERMES_RID_NICID, &nic_id);
+	err =3D HERMES_READ_RECORD_PR(hw, USER_BAP, HERMES_RID_NICID, &nic_id);
 	if (err) {
 		dev_err(dev, "Cannot read hardware identity: error %d\n",
 			err);
@@ -101,7 +101,7 @@ int determine_fw_capabilities(struct orinoco_private *p=
riv,
 	priv->firmware_type =3D determine_firmware_type(&nic_id);
=20
 	/* Get the firmware version */
-	err =3D HERMES_READ_RECORD(hw, USER_BAP, HERMES_RID_STAID, &sta_id);
+	err =3D HERMES_READ_RECORD_PR(hw, USER_BAP, HERMES_RID_STAID, &sta_id);
 	if (err) {
 		dev_err(dev, "Cannot read station identity: error %d\n",
 			err);
@@ -177,7 +177,7 @@ int determine_fw_capabilities(struct orinoco_private *p=
riv,
 		/* 3Com MAC : 00:50:DA:* */
 		memset(tmp, 0, sizeof(tmp));
 		/* Get the Symbol firmware version */
-		err =3D hw->ops->read_ltv(hw, USER_BAP,
+		err =3D hw->ops->read_ltv_pr(hw, USER_BAP,
 					HERMES_RID_SECONDARYVERSION_SYMBOL,
 					SYMBOL_MAX_VER_LEN, NULL, &tmp);
 		if (err) {
@@ -286,7 +286,7 @@ int orinoco_hw_read_card_settings(struct orinoco_privat=
e *priv, u8 *dev_addr)
 	u16 reclen;
=20
 	/* Get the MAC address */
-	err =3D hw->ops->read_ltv(hw, USER_BAP, HERMES_RID_CNFOWNMACADDR,
+	err =3D hw->ops->read_ltv_pr(hw, USER_BAP, HERMES_RID_CNFOWNMACADDR,
 				ETH_ALEN, NULL, dev_addr);
 	if (err) {
 		dev_warn(dev, "Failed to read MAC address!\n");
@@ -296,7 +296,7 @@ int orinoco_hw_read_card_settings(struct orinoco_privat=
e *priv, u8 *dev_addr)
 	dev_dbg(dev, "MAC address %pM\n", dev_addr);
=20
 	/* Get the station name */
-	err =3D hw->ops->read_ltv(hw, USER_BAP, HERMES_RID_CNFOWNNAME,
+	err =3D hw->ops->read_ltv_pr(hw, USER_BAP, HERMES_RID_CNFOWNNAME,
 				sizeof(nickbuf), &reclen, &nickbuf);
 	if (err) {
 		dev_err(dev, "failed to read station name\n");
@@ -312,7 +312,7 @@ int orinoco_hw_read_card_settings(struct orinoco_privat=
e *priv, u8 *dev_addr)
 	dev_dbg(dev, "Station name \"%s\"\n", priv->nick);
=20
 	/* Get allowed channels */
-	err =3D hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CHANNELLIST,
+	err =3D hermes_read_wordrec_pr(hw, USER_BAP, HERMES_RID_CHANNELLIST,
 				  &priv->channel_mask);
 	if (err) {
 		dev_err(dev, "Failed to read channel list!\n");
@@ -320,13 +320,13 @@ int orinoco_hw_read_card_settings(struct orinoco_priv=
ate *priv, u8 *dev_addr)
 	}
=20
 	/* Get initial AP density */
-	err =3D hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CNFSYSTEMSCALE,
+	err =3D hermes_read_wordrec_pr(hw, USER_BAP, HERMES_RID_CNFSYSTEMSCALE,
 				  &priv->ap_density);
 	if (err || priv->ap_density < 1 || priv->ap_density > 3)
 		priv->has_sensitivity =3D 0;
=20
 	/* Get initial RTS threshold */
-	err =3D hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CNFRTSTHRESHOLD,
+	err =3D hermes_read_wordrec_pr(hw, USER_BAP, HERMES_RID_CNFRTSTHRESHOLD,
 				  &priv->rts_thresh);
 	if (err) {
 		dev_err(dev, "Failed to read RTS threshold!\n");
@@ -335,11 +335,11 @@ int orinoco_hw_read_card_settings(struct orinoco_priv=
ate *priv, u8 *dev_addr)
=20
 	/* Get initial fragmentation settings */
 	if (priv->has_mwo)
-		err =3D hermes_read_wordrec(hw, USER_BAP,
+		err =3D hermes_read_wordrec_pr(hw, USER_BAP,
 					  HERMES_RID_CNFMWOROBUST_AGERE,
 					  &priv->mwo_robust);
 	else
-		err =3D hermes_read_wordrec(hw, USER_BAP,
+		err =3D hermes_read_wordrec_pr(hw, USER_BAP,
 					  HERMES_RID_CNFFRAGMENTATIONTHRESHOLD,
 					  &priv->frag_thresh);
 	if (err) {
@@ -351,7 +351,7 @@ int orinoco_hw_read_card_settings(struct orinoco_privat=
e *priv, u8 *dev_addr)
 	if (priv->has_pm) {
 		priv->pm_on =3D 0;
 		priv->pm_mcast =3D 1;
-		err =3D hermes_read_wordrec(hw, USER_BAP,
+		err =3D hermes_read_wordrec_pr(hw, USER_BAP,
 					  HERMES_RID_CNFMAXSLEEPDURATION,
 					  &priv->pm_period);
 		if (err) {
@@ -359,7 +359,7 @@ int orinoco_hw_read_card_settings(struct orinoco_privat=
e *priv, u8 *dev_addr)
 				"period!\n");
 			goto out;
 		}
-		err =3D hermes_read_wordrec(hw, USER_BAP,
+		err =3D hermes_read_wordrec_pr(hw, USER_BAP,
 					  HERMES_RID_CNFPMHOLDOVERDURATION,
 					  &priv->pm_timeout);
 		if (err) {
@@ -371,7 +371,7 @@ int orinoco_hw_read_card_settings(struct orinoco_privat=
e *priv, u8 *dev_addr)
=20
 	/* Preamble setup */
 	if (priv->has_preamble) {
-		err =3D hermes_read_wordrec(hw, USER_BAP,
+		err =3D hermes_read_wordrec_pr(hw, USER_BAP,
 					  HERMES_RID_CNFPREAMBLE_SYMBOL,
 					  &priv->preamble);
 		if (err) {
@@ -381,21 +381,21 @@ int orinoco_hw_read_card_settings(struct orinoco_priv=
ate *priv, u8 *dev_addr)
 	}
=20
 	/* Retry settings */
-	err =3D hermes_read_wordrec(hw, USER_BAP, HERMES_RID_SHORTRETRYLIMIT,
+	err =3D hermes_read_wordrec_pr(hw, USER_BAP, HERMES_RID_SHORTRETRYLIMIT,
 				  &priv->short_retry_limit);
 	if (err) {
 		dev_err(dev, "Failed to read short retry limit\n");
 		goto out;
 	}
=20
-	err =3D hermes_read_wordrec(hw, USER_BAP, HERMES_RID_LONGRETRYLIMIT,
+	err =3D hermes_read_wordrec_pr(hw, USER_BAP, HERMES_RID_LONGRETRYLIMIT,
 				  &priv->long_retry_limit);
 	if (err) {
 		dev_err(dev, "Failed to read long retry limit\n");
 		goto out;
 	}
=20
-	err =3D hermes_read_wordrec(hw, USER_BAP, HERMES_RID_MAXTRANSMITLIFETIME,
+	err =3D hermes_read_wordrec_pr(hw, USER_BAP, HERMES_RID_MAXTRANSMITLIFETI=
ME,
 				  &priv->retry_lifetime);
 	if (err) {
 		dev_err(dev, "Failed to read max retry lifetime\n");
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/=
net/wireless/intersil/orinoco/orinoco_usb.c
index 4c60b48214637..dd31929261ab9 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -667,32 +667,6 @@ static void ezusb_request_in_callback(struct ezusb_pri=
v *upriv,
=20
 typedef void (*ezusb_ctx_wait)(struct ezusb_priv *, struct request_context=
 *);
=20
-static void ezusb_req_ctx_wait(struct ezusb_priv *upriv,
-			       struct request_context *ctx)
-{
-	switch (ctx->state) {
-	case EZUSB_CTX_QUEUED:
-	case EZUSB_CTX_REQ_SUBMITTED:
-	case EZUSB_CTX_REQ_COMPLETE:
-	case EZUSB_CTX_RESP_RECEIVED:
-		if (in_softirq()) {
-			/* If we get called from a timer, timeout timers don't
-			 * get the chance to run themselves. So we make sure
-			 * that we don't sleep for ever */
-			int msecs =3D DEF_TIMEOUT * (1000 / HZ);
-
-			while (!try_wait_for_completion(&ctx->done) && msecs--)
-				udelay(1000);
-		} else {
-			wait_for_completion(&ctx->done);
-		}
-		break;
-	default:
-		/* Done or failed - nothing to wait for */
-		break;
-	}
-}
-
 static void ezusb_req_ctx_wait_compl(struct ezusb_priv *upriv,
 				     struct request_context *ctx)
 {
@@ -1032,8 +1006,10 @@ static int ezusb_write_ltv(struct hermes *hw, int ba=
p, u16 rid,
 				 ezusb_req_ctx_wait_poll);
 }
=20
-static int ezusb_read_ltv(struct hermes *hw, int bap, u16 rid,
-			  unsigned bufsize, u16 *length, void *buf)
+static int __ezusb_read_ltv(struct hermes *hw, int bap, u16 rid,
+			    unsigned bufsize, u16 *length, void *buf,
+			    ezusb_ctx_wait ezusb_ctx_wait_func)
+
 {
 	struct ezusb_priv *upriv =3D hw->priv;
 	struct request_context *ctx;
@@ -1046,7 +1022,21 @@ static int ezusb_read_ltv(struct hermes *hw, int bap=
, u16 rid,
 		return -ENOMEM;
=20
 	return ezusb_access_ltv(upriv, ctx, 0, NULL, EZUSB_FRAME_CONTROL,
-				buf, bufsize, length, ezusb_req_ctx_wait);
+				buf, bufsize, length, ezusb_req_ctx_wait_poll);
+}
+
+static int ezusb_read_ltv(struct hermes *hw, int bap, u16 rid,
+			    unsigned bufsize, u16 *length, void *buf)
+{
+	return __ezusb_read_ltv(hw, bap, rid, bufsize, length, buf,
+				ezusb_req_ctx_wait_poll);
+}
+
+static int ezusb_read_ltv_preempt(struct hermes *hw, int bap, u16 rid,
+				  unsigned bufsize, u16 *length, void *buf)
+{
+	return __ezusb_read_ltv(hw, bap, rid, bufsize, length, buf,
+				ezusb_req_ctx_wait_compl);
 }
=20
 static int ezusb_doicmd_wait(struct hermes *hw, u16 cmd, u16 parm0, u16 pa=
rm1,
@@ -1586,6 +1576,7 @@ static const struct hermes_ops ezusb_ops =3D {
 	.init_cmd_wait =3D ezusb_doicmd_wait,
 	.allocate =3D ezusb_allocate,
 	.read_ltv =3D ezusb_read_ltv,
+	.read_ltv_pr =3D ezusb_read_ltv_preempt,
 	.write_ltv =3D ezusb_write_ltv,
 	.bap_pread =3D ezusb_bap_pread,
 	.read_pda =3D ezusb_read_pda,
--=20
2.29.2

