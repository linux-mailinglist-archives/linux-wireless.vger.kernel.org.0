Return-Path: <linux-wireless+bounces-34107-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JOVBnTfx2kfeAUAu9opvQ
	(envelope-from <linux-wireless+bounces-34107-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 15:02:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8920234E9DA
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 15:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 664AC300B47B
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C6E18BC3B;
	Sat, 28 Mar 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C4uS5Rg3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E321E505
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774706492; cv=none; b=kjVhkcZyCmDmMw6N6S1Tyvc3da9ilWkMtTbPKkS0Fr5DnfiwXoSi8+5UJIHGVOy/PX9mruy7WzqWcGEvX51dGynK4lVeZmbJGbf1/SuIejnaM39xWWloxBbfDj/88NvB3HtkYaCV6eeGDJdl0U6L5uLQLeRac8IpUJikPR//GCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774706492; c=relaxed/simple;
	bh=v27CgWKJduciAD30Cwhnf+g92Mqz1HiBHL3YqncTGg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGO8hFk109lTDqDhkqKDrBetqiiDqIBmZT7BImwT3a5bSw/zlTu29plE84xL7mbchjdVD9ZYjSbkMuZvuAKdkEmP3FsDdxcGqCBXjLmV7xCxcOjAvDd6JsZadJPZdlRtD3pV4kNoMTmCfo2YHq+LMEIYpfVauqsIioBgwRjzxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C4uS5Rg3; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-35d971fbcddso201282a91.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 07:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774706490; x=1775311290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54xQVob9wdFV/Y49RL8c+XQpBeMY6onRtC3s2HHzq5o=;
        b=bYTOwPrX8XzavergYSNb4+62DGXVj2D0upt5s9x16FlLLHGueMwUn5uc9XFXCXMtHL
         Cpi1Jpkflt9ZjtoXBsBGwgYfpnlE81sMt/BEu+YF+hO/qBIKaoh3ina8fvPqQ268PREa
         g/Sr18tJEE4XulG0cP0rM4cLabdhX73sWnNjB9ZIf6YACt0CCATvVaSU3AxLi/4OP1oE
         vMBgXvZF4Hh21YjHJvLCkpFNDk+bTDkz1wq1HzMfOHlIIVi3RSyF6xxRfb848lVvYoPA
         GmVSeH3wyd9nAsSRACiuBBLP2lSDX+UQB5CuJ9xYmNSMjiZ8Yg10g3fnFKzd4Q0onkhf
         Ywbg==
X-Gm-Message-State: AOJu0YwKIjz5dsFscMAfjJXxNp/Le74WtqUa9TMC/EWH2BcKKU78244e
	g7jojxwzcSeM+0SKhl7fVIZAQSRqQdwgTUudTPpMBqOfci6QbyqMkTO1fGet/TIonW6lC80ZgUj
	8dtFyt5s1QohUVK7jsgr9NfsD3a0o5nt5WIf24vWy+5sSsEJ3zSeBKfc4rpbQWjzYzDT6P/HGSY
	T/ko+L/uSMdls9zzEFKkDULyfbFLf+3yzZ+MNV7BDcqiRLnM5iAGCKHZF40Z+D3NfPfwwuvrUIE
	m0YN+M8liEi1h+AshNPZITTXvp+
X-Gm-Gg: ATEYQzxEeHwynNk29bcRmuD54cBkB6zGkvTw/eEAPvQtv7aSBMANZDoMRu25fKKqEak
	ZOkeWWMsoXx6a6Y55AZIM3SfVQvjV4fMxLDMybbEpaSnsVP0ZiWN8nUF9QJoXgPiR9yAuqV0RMo
	IrayNa8iVUdFv/Opc+JcJeTasUxGHRiW5u80FcO/byiW0rzJw9TJitjydvNi4eIBz2ImqJbMSFL
	VKmaRm/7SrSuRkA5AFc5gmo7PAdoByHc3jQ5tKgOGATtThIyWLqLf37qbIVby0HTCPXWYe9fcuK
	Xv0ArXEiaZvHPtexJUd18m9MS2avKvaWlzZz6WB8IQyckqjZASrSbOs+Qj0wurQhK6z4pe8tSci
	MTVNIxYAvrZFssDfuaUeg8Afk6nsZL1novv4nqF6HALBv3aWE+D9gqVKYV9cJqsXxzCjqJnNm0x
	O47YXoI3peEVViC1/+6p90NrgGUpQagLzmTzvBEypu78hPXFELcd3e0i3la75z
X-Received: by 2002:a17:90b:3f8d:b0:35b:cc8b:1124 with SMTP id 98e67ed59e1d1-35c228060b6mr8650003a91.5.1774706490289;
        Sat, 28 Mar 2026 07:01:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c76916e0329sm172323a12.4.2026.03.28.07.01.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 07:01:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bda35eab74so2118251eec.0
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774706488; x=1775311288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54xQVob9wdFV/Y49RL8c+XQpBeMY6onRtC3s2HHzq5o=;
        b=C4uS5Rg3kGhS5C+qSjQzO09OprsnDwsv2O2hMQlBbD5iq+LcVgsYi1igNic3PeADvB
         5WB1gaRLmqkd5QKEruAUkBupF7sTdqEY6nQN3+CtOtDFje+WaH2526zfh1ewhoYTrwo7
         SeESdBfkaH91Z8gL5jffJ7ZO4xzyWTVl5a6RA=
X-Received: by 2002:a05:693c:2c8d:b0:2be:b20a:9b69 with SMTP id 5a478bee46e88-2c17723bdb8mr4497403eec.12.1774706488103;
        Sat, 28 Mar 2026 07:01:28 -0700 (PDT)
X-Received: by 2002:a05:693c:2c8d:b0:2be:b20a:9b69 with SMTP id 5a478bee46e88-2c17723bdb8mr4497374eec.12.1774706487510;
        Sat, 28 Mar 2026 07:01:27 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm2135470eec.4.2026.03.28.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:01:26 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH -next] wifi: brcmfmac: silence warning for non-existent, optional firmware
Date: Sat, 28 Mar 2026 15:01:21 +0100
Message-ID: <20260328140121.2583606-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,ew.tq-group.com,gmail.com,broadcom.com];
	TAGGED_FROM(0.00)[bounces-34107-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8920234E9DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Stein <alexander.stein@ew.tq-group.com>

The driver tries to load optional firmware files, specific to
the actual board compatible. These might not exist resulting in a warning
like this:
brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac4373-sdio.tq,imx93-tqma9352-mba93xxla-mini.bin failed with error -2

Silence this by using firmware_request_nowait_nowarn() for all firmware
loads which use brcmf_fw_request_done_alt_path() as callback. This one
handles optional firmware files.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
[arend: use nowarn api for optional firmware files]
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/firmware.c    | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 4bacd83db052..358abdb126a4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -670,7 +670,12 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
 	}
 
 fallback:
-	return request_firmware(fw, cur->path, fwctx->dev);
+	if (cur->flags & BRCMF_FW_REQF_OPTIONAL) {
+		ret = firmware_request_nowarn(fw, cur->path, fwctx->dev);
+	} else {
+		ret = request_firmware(fw, cur->path, fwctx->dev);
+	}
+	return ret;
 }
 
 static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
@@ -714,9 +719,10 @@ static void brcmf_fw_request_done_alt_path(const struct firmware *fw, void *ctx)
 		if (!alt_path)
 			goto fallback;
 
-		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
-					      fwctx->dev, GFP_KERNEL, fwctx,
-					      brcmf_fw_request_done_alt_path);
+		ret = firmware_request_nowait_nowarn(THIS_MODULE,
+						     alt_path, fwctx->dev,
+						     GFP_KERNEL, fwctx,
+						     brcmf_fw_request_done_alt_path);
 		kfree(alt_path);
 
 		if (ret < 0)
@@ -779,9 +785,10 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 					    fwctx->req->board_types[0]);
 	if (alt_path) {
 		fwctx->board_index++;
-		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
-					      fwctx->dev, GFP_KERNEL, fwctx,
-					      brcmf_fw_request_done_alt_path);
+		ret = firmware_request_nowait_nowarn(THIS_MODULE,
+						     alt_path, fwctx->dev,
+						     GFP_KERNEL, fwctx,
+						     brcmf_fw_request_done_alt_path);
 		kfree(alt_path);
 	} else {
 		ret = request_firmware_nowait(THIS_MODULE, true, first->path,

base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
-- 
2.45.4


