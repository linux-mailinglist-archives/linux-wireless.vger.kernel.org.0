Return-Path: <linux-wireless+bounces-35174-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPm0H6yC52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35174-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:59:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B8743BAA4
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D398630E7E7E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4D3D9046;
	Tue, 21 Apr 2026 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGOgPisA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F93D9DC2
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779435; cv=none; b=q0P1jWy6x9mFhksogJ++KcHyAq+S2lMA3/4gPPuSmjMWM8q6OEca5k6j0Pkn2uxjIwoTcMKgsVSvIQIF+4S25OaX5tH13A+0SDbzjhjroQhLQXz+zi07p+R+mzi9VDi9BTkhSE19xAJrv5Gr3d4ZTVBrbFm7kkTur6kubqA9pUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779435; c=relaxed/simple;
	bh=wwRqjCT3vM0hLPJ4W9LbRUcZpC0+h9E3dwiQbd1BC9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUBKlLRLYmTSAkjoKBbC+w1I/0z42LuCyMP9CkgK8i0yCQyUvsPiSnGnVB1MoeWH5qbABn0pQCE+6xjCpm+UR86nf+5ooCfpbRKdAyFCIDtaILo9x6s+qL36PCBVmXkUsgZ3XufJvPulTdltCFoR4X11I0RcuWj9cObaux2y+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGOgPisA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so30061075e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779431; x=1777384231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRXRJvmT9sMQD+e3sjZZz7QmmGQlQrsNUMzelhv+lDM=;
        b=aGOgPisArSVczMcaAjxyiGwX1cnmSmqUgSUaCmbrI3Iq1gtar+FBiKGMP3WQjABisV
         TRa4hpy2Ai+4u/CcYcGohUSX39f7FkmrtTHcTXetXweP7Oc1yJ/pM5Fe+i+BmhfkMDfH
         NsHtznIWSBMh98hw57qKB0dvqlOUpGLIcvOBppA9Ka7x+DawvMzGMDzewoXupb21nNN4
         obj8z7alDvqu37Em2Ibd2I3Tid6riQn5GNjJ+3FSQTqD3eav+4v9oGnMKmgIQ01XhbOf
         IExn8m9+c/5D8O4WOUWDXZz9tNmiKSjc6eU17wJF29Ell4GbYbcAQc+Uv6chxMCNEQrw
         SBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779431; x=1777384231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lRXRJvmT9sMQD+e3sjZZz7QmmGQlQrsNUMzelhv+lDM=;
        b=LIXjQnNl40oyBrfIKZE/c3jmoA22FMDlAPWYjd2YUgzcgfTstsANCAVPsTJJaOc3wB
         7w4SUdCIzcyIsD+F463eiIMm4zzQakPxtq68E7bbEvzhenj3/855cNwVXQWYUm0bteze
         Uvv3Bo3s2ngOqhIQyT1C78ueqbzYqDTJfUN2tNPVZboTVFY/BdGbrtngmFopBBUo53Iq
         7XaqalN4rfjSFoBLaf/cJPBEzu1K2AQJtjbGdlynG9w2t+wBih41kVc7JUGju/8yFb3O
         AEqjIUSB1fEJiUNq6YRc1/Thm7uF4SrXixmiZdLAzTLGlkU1mpLsZ52ZGt/EtwbuikRe
         Yzgw==
X-Forwarded-Encrypted: i=1; AFNElJ8M/GMvJbWdk/JNCRbpnY0gjcjmiMeUBISbwiqzWnXmjxgvVGQlzfdpr6DwlvU6yNJh+csoxPvsiQukBI0Bsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtVzrPVg/+EO70RqUBA7x+QHVsh/x5tTEZ1LjhttQ6wFccC4G
	iyo3XuxHGbAzwSNjDimQo7CQFmCjAdNJhBAqWVVkZSzm/IldfypyUf/Sbn8a
X-Gm-Gg: AeBDieuv4Kcmxy5+ezbZ963NBH6rTPsieeET6q4c0KOBHP0xRM+6p5/yX14k3aHOd6a
	4WZJmfLywtSWImbZvFfk8T4Xm9cAnwfXy8zvyL/3rlZctl1tcFA4sFz722efB1isNsRB/1Ft9NY
	C3E/iOPdjfCl9VUapu6B/SCNjTw1ioUaJp8AJnFVJZN6ZtwTGkLGa7G638bi5QFuiZf5XN9dd6c
	IjbK548hjEV8Qr51WSSTlKRk5NaVo0R+wJep/6l8sqs6euwQ1UwT++Pt0q3pYVfPZ2Jg5MkI0Bx
	QZ6wnEg7M/rsHD8F/E/ARFd5BLNcIg3GBLlyQZzbJN5godlJJyLvAyzaazF9Mr2QkwRjYtz2nkR
	Y6JvrXoEFcNLd51JE3clR4efZjyyum9TzGMp0uj6VXQ1t8gEPfbnOaa9gwF7ehJ7WrR59xu7rcN
	QMnkc=
X-Received: by 2002:a05:600c:820d:b0:48a:569c:abab with SMTP id 5b1f17b1804b1-48a569cadacmr34033605e9.14.1776779430554;
        Tue, 21 Apr 2026 06:50:30 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm394031315e9.5.2026.04.21.06.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:30 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/2] wifi: libertas: fix OOB read from firmware bssdescriptsize in scan response
Date: Tue, 21 Apr 2026 13:50:27 +0000
Message-ID: <20260421135027.357622-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421135027.357622-1-tristmd@gmail.com>
References: <20260421135027.357622-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35174-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00B8743BAA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled bssdescriptsize field in lbs_ret_scan() is used
to compute the TSF descriptor position without validation against the
response buffer size. An inflated value causes out-of-bounds reads from
the 2312-byte response buffer into adjacent struct lbs_private members.

Add a check that bssdescriptsize fits within the response data.

Fixes: ff9fc791940f ("libertas: first stab at cfg80211 support")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/marvell/libertas/cfg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 72c92f72469de..41dee6e0ca9fa 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -554,6 +554,14 @@ static int lbs_ret_scan(struct lbs_private *priv, unsigned long dummy,
 
 	bsssize = get_unaligned_le16(&scanresp->bssdescriptsize);
 
+	if (bsssize > le16_to_cpu(resp->size) -
+	    sizeof(struct cmd_ds_802_11_scan_rsp)) {
+		lbs_deb_scan(
+			"scan response: bssdescriptsize %d exceeds response\n",
+			bsssize);
+		goto done;
+	}
+
 	lbs_deb_scan("scan response: %d BSSs (%d bytes); resp size %d bytes\n",
 			scanresp->nr_sets, bsssize, le16_to_cpu(resp->size));
 
-- 
2.47.3


