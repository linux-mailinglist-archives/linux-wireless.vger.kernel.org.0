Return-Path: <linux-wireless+bounces-12804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB5975DBC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDAC2854D8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440413C9C7;
	Wed, 11 Sep 2024 23:41:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB84A29
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726098065; cv=none; b=hmrSqBg9+yE4jwegbccnAQsFXowpsdb46Og2/cp69jNVCvP6U95A/JCtTzLMcnnnXOPqvk2FeL2aCT9ojUIE0jnH9bQ8gLOKkelPw7FY59zizu9dBAoduHtv3bYvMGyJOQebDyGf151gPecC64fjPAsYfnmHcG7+PiMY71zTXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726098065; c=relaxed/simple;
	bh=IINvlDdeH2UeH/evLIPnTlMvOeuO1yFGh+rpThit8/M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mupp/17NzQpc4pyYaQ9qH3OQ011k3hVCS78aw0bnBGmYEFRc9fpaqi77IxX4T6hRcsW/l3ixnnmWVxgHTJo3RcDxqpgu6aXRXzoprhT2KjR9mhJNPvMDVY0hI1eaCDYMviDdeGFGI5cvGkEqPoOn72uajwgkMplZRW8oG15hkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:8400:7e:617b:6ee5:348:da94] (helo=shadbolt.i.decadent.org.uk)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1soWKx-008YYD-0l;
	Wed, 11 Sep 2024 23:01:23 +0000
Received: from ben by shadbolt.i.decadent.org.uk with local (Exim 4.94.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1soWKv-00BBom-UV; Thu, 12 Sep 2024 01:01:21 +0200
Date: Thu, 12 Sep 2024 01:01:21 +0200
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>
Cc: =?iso-8859-1?Q?Martin-=C9ric?= Racine <martin-eric.racine@iki.fi>,
	Brandon Nielsen <nielsenb@jetfuse.net>
Subject: [PATCH] wifi: iwlegacy: Fix "field-spanning write" warning in
 il_enqueue_hcmd()
Message-ID: <ZuIhQRi/791vlUhE@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b7z0ZwN0VZaNn3Np"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:8400:7e:617b:6ee5:348:da94
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--b7z0ZwN0VZaNn3Np
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

iwlegacy uses command buffers with a payload size of 320
bytes (default) or 4092 bytes (huge).  The struct il_device_cmd type
describes the default buffers and there is no separate type describing
the huge buffers.

The il_enqueue_hcmd() function works with both default and huge
buffers, and has a memcpy() to the buffer payload.  The size of
this copy may exceed 320 bytes when using a huge buffer, which
now results in a run-time warning:

    memcpy: detected field-spanning write (size 1014) of single field "&out=
_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3170 (si=
ze 320)

To fix this:

- Define a new struct type for huge buffers, with a correctly sized
  payload field
- When using a huge buffer in il_enqueue_hcmd(), cast the command
  buffer pointer to that type when looking up the payload field

Reported-by: Martin-=C9ric Racine <martin-eric.racine@iki.fi>
References: https://bugs.debian.org/1062421
References: https://bugzilla.kernel.org/show_bug.cgi?id=3D219124
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy()")
Tested-by: Martin-=C9ric Racine <martin-eric.racine@iki.fi>
Tested-by: Brandon Nielsen <nielsenb@jetfuse.net>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 13 ++++++++++++-
 drivers/net/wireless/intel/iwlegacy/common.h | 12 ++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wir=
eless/intel/iwlegacy/common.c
index 9d33a66a49b5..4616293ec0cf 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -3122,6 +3122,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cm=
d *cmd)
 	struct il_cmd_meta *out_meta;
 	dma_addr_t phys_addr;
 	unsigned long flags;
+	u8 *out_payload;
 	u32 idx;
 	u16 fix_size;
=20
@@ -3157,6 +3158,16 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_c=
md *cmd)
 	out_cmd =3D txq->cmd[idx];
 	out_meta =3D &txq->meta[idx];
=20
+	/* The payload is in the same place in regular and huge
+	 * command buffers, but we need to let the compiler know when
+	 * we're using a larger payload buffer to avoid "field-
+	 * spanning write" warnings at run-time for huge commands.
+	 */
+	if (cmd->flags & CMD_SIZE_HUGE)
+		out_payload =3D ((struct il_device_cmd_huge *)out_cmd)->cmd.payload;
+	else
+		out_payload =3D out_cmd->cmd.payload;
+
 	if (WARN_ON(out_meta->flags & CMD_MAPPED)) {
 		spin_unlock_irqrestore(&il->hcmd_lock, flags);
 		return -ENOSPC;
@@ -3170,7 +3181,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cm=
d *cmd)
 		out_meta->callback =3D cmd->callback;
=20
 	out_cmd->hdr.cmd =3D cmd->id;
-	memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
+	memcpy(out_payload, cmd->data, cmd->len);
=20
 	/* At this point, the out_cmd now has all of the incoming cmd
 	 * information */
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wir=
eless/intel/iwlegacy/common.h
index 69687fcf963f..027dae5619a3 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -560,6 +560,18 @@ struct il_device_cmd {
=20
 #define TFD_MAX_PAYLOAD_SIZE (sizeof(struct il_device_cmd))
=20
+/**
+ * struct il_device_cmd_huge
+ *
+ * For use when sending huge commands.
+ */
+struct il_device_cmd_huge {
+	struct il_cmd_header hdr;	/* uCode API */
+	union {
+		u8 payload[IL_MAX_CMD_SIZE - sizeof(struct il_cmd_header)];
+	} __packed cmd;
+} __packed;
+
 struct il_host_cmd {
 	const void *data;
 	unsigned long reply_page;

--b7z0ZwN0VZaNn3Np
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmbiITwACgkQ57/I7JWG
EQm8yA//bS6C/KPFvUImctAwyhhrtnDbyZCKYWRe/xQSbWH+fcGIq4dkrEqg+X+R
9RA5WpYoVkxtya5jbXCUwltmo/2Y7CwJmUFhoVkHeQ4NNNmn4H6eZkLnuO8TllEE
RFdvcU3h/jFzNqVCJ4gufBhGuFAlz6OQFKkrDPqe3lRk5mBX2lwHWR6r7hdy0J4q
J+N/YifdCYusnMWuf+b7M/xBuMyyN2+N2kCTOTMA+StK0nhdf/Mv/N32zYusEIVE
3W/6zEz+pxXfSfsMkAXfJ2tTkI+aceO5DoXsg93NK2bH/ilSpAs1ByC/89JxwZba
y3Cry21iKt4Ntalhj7jyjLdsb8fIVNt80p/MZlUzRjC1/M2WLaIpYmgr2uwUs7+w
0umgqFBQ+o4GuNWCgXl4BJR39VWdMDYXNtVgjNKdXpZN2GNqTrwBUSH3XgDPRc8H
UU8SVEW7mH1nruMU6CE2LzS15xvIb+cCTeEGVHWlD6/5PT+YA+C+koN0zyqXatBs
xwZVA1oNpNA0uNBXZ6IU/DmQF3RwST1ernGqBblYtn2QYQ41Sn/HZNW+A43hDwmR
gLLk361Ake1z6op6sMzTM7LzDu21An79HRdqVrlJDrMhNT5VHPk1t0MqA+WOc75Z
Rw6F1CcrE0KTmK5NS7CgnannOzMR5dvM9MlP0Jno3rI8ljwpCis=
=QJx+
-----END PGP SIGNATURE-----

--b7z0ZwN0VZaNn3Np--

