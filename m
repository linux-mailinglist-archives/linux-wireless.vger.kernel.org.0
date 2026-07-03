Return-Path: <linux-wireless+bounces-38601-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JH2bGyDaR2o7gQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38601-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:49:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ED2704010
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:49:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=YlVreCPX;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38601-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38601-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEFB83060768
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04FD2EB5B8;
	Fri,  3 Jul 2026 15:47:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BD2DE709
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 15:47:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093674; cv=none; b=HAt4EfpkN9dfGfAiINiPDy1XaVQtyDwO++tnGiW0cAdcGb1x84AxPDmmxyxhgXFexx5PB66yELG5LSGtUIvFJugVwp+29gVTtE20zVgLxV9IS4l7ZirUvPc5uh3GH0hvFEwFot61OK2R2z6T89HmcWinPjkksAZSZGLjtYAIkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093674; c=relaxed/simple;
	bh=2wV3hKj9vhnAodfbopd+iezREj9IBgRhvOKI8jHXilM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O25S/XRGff4B4SibrdSyMvBq29OUGs1lk95wyDGb1qcOWrAfzDGFDnvlDZCNZFqpgHwQw3WOV6qpBHNyL7WdhGlXnWUYp3KXL2vMQf+d905dg+OJc/ZaracIG7MN3x2OFOf+oOwdoXvN+4MSaj2qTNio5R4JNPm+XWoJwQ3aiZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YlVreCPX; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so7200475e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783093670; x=1783698470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nFRygkXlrzW2EnOOrdUvnj0OJKNC6C0PLgzWojPc/qs=;
        b=YlVreCPX3DYfwAvwL1T4q5qMAFk8imNFv/6RV14f97QLsIcco/qiV1Zz6WmWktfNDg
         1q7lA/7LsUZagWGUZIDoxROSa9z/indc2usfBUfl/gohQW5VKgnGjKSJRAZZdf8JQae7
         GVnB9qoTE1PivAx1JTMqpIRmYe9MOxhHxbXD70cQMbDZv7JdCJiyXkS4DM2Hz6CEV7M9
         nkaAP6wHyslpBPUOx6qTpRhtNVTG5LmQSW9rnGe7T5mdrSkgEprVcdazM6cTky3Xv/cx
         Twb0FGUlhzp1reT2w7JgTYQ3V2VIQR+oATK48QhZTBbnC8Tp0hQ3GbCG4v1ev03cwPvq
         IXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093670; x=1783698470;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFRygkXlrzW2EnOOrdUvnj0OJKNC6C0PLgzWojPc/qs=;
        b=iJ33eD4LiVcooN683SsAnkbZSTje1g8iL3CC5uWPCr+QdYKoMUlosTZWFwRA3VaMD7
         3MZK7uak1V3tJ7KSlKzDthrW300d3UOxYjKLWWFz37PTvcps/8zSovlQUzq/MqbPoHlY
         1xUfVf0Z98vMVfg1QKnBhAdxgPqPd9VK0GIj1eP4+bMma5/2afDpFUREdOQaazCTZxQ6
         TZbTXqKs0lKbUelN4ThveglcTqweD+FpYBGN9UUszHiRu6yZcGdsu+k4982pANzivbJD
         0JjeUk8O6Cr2dnaw3rWAtg3DaEz2ajSknZfHwy40IEC1YbQ87Tp4Soo4jSBXB4+2dnj6
         B8Pw==
X-Forwarded-Encrypted: i=1; AFNElJ/3HTNY2bF8hlgRmey7pKhsYihPIqZ/zQq+DDBJYaHskJ5gReLN5RMCzXIFgYEEwnFQ/iN/cd6furRKgYn4jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJE06WhRwHxAvpLOuFR3oS9IF4+7I246zYJvQP6/91zgTjctR/
	Biii4VHhk5WO1rDEFUVGFTJ8NBjpTmvWa3/BJA27y3cfK/aDqXuo3fcAfzNLnf4BmuY=
X-Gm-Gg: AfdE7cm8tsU9wlSlw0T7yISmF9tTTjpd78eWlhzj+vcO7ooi+ScTnVuXWiSMJz1XTcl
	lOYTehEPs1RqMpi2fdwdAeVNgA7CQjhhMQ8/YUA7ULtRL+yewR8B+E90RecRVoNVZG7Y4odXsNf
	/J1AckVkEHpeJXIdaN7sSkbxTkzKppotvmhLnWMFfdpK3EIk2FfAMzIr8hrIIAaVq2RgiFdf2KA
	okYaKEOIfGTuivIPXL08Y8YW+JasuuwXhW7OYG3E3chvs7qYcgclBnlar2/QVgdFlvxeZPRdRBW
	qXfTBlqcYKr2/7W4hXmPVr4m/2f18Jo+iqvhjA3GlDPRISOt//Zb2DstWmOsoLfpWU2eu+8gVrJ
	cC34xLqzKoaBoAhzIdbFtCUhTDFUOIC9ZLoHmDAIGtKgb7OKYwAU5PyjjRuR+q7A7PVE2raTg/L
	iTsHnAkpqBzEpe6TieQ5uJvngcMsAidwvXhYpnvLUJw/erEzJtHCT3QAomaqeDrsfrqCjj4Tfs2
	CmF
X-Received: by 2002:a05:600c:350a:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-493d0f08ac8mr4537355e9.2.1783093670501;
        Fri, 03 Jul 2026 08:47:50 -0700 (PDT)
Received: from localhost (p200300f65f47db0472e4f1e98703de96.dip0.t-ipconnect.de. [2003:f6:5f47:db04:72e4:f1e9:8703:de96])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493c63b6f28sm145328795e9.9.2026.07.03.08.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:47:50 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: David Heidelberg <david@ixit.cz>,
	Mark Greer <mgreer@animalcreek.com>
Cc: oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v1 10/12] nfc: Initialize spi_device_idarrays using member names
Date: Fri,  3 Jul 2026 17:46:24 +0200
Message-ID:  <308a0d43ef042566ca595f1afa803cac592a4643.1783091699.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1783091699.git.u.kleine-koenig@baylibre.com>
References: <cover.1783091699.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2wV3hKj9vhnAodfbopd+iezREj9IBgRhvOKI8jHXilM=; b=owGbwMvMwMXY3/A7olbonx/jabUkhiz3m1mmP5brfFv45vO6fdOCpyyueZU7o86B+82U5Zb8u Tubv1/K6mQ0ZmFg5GKQFVNksW9ck2lVJRfZufbfZZhBrEwgUxi4OAXgIizs//PNvRUbTjFfKlwU eFV3seCzqHsnP4RLzeT7VLhzg8jdq1KqrW+SJVoqpKOZlLpzxPxFE9YwyzxRL+lm92osWm77/2T g4gmPVlg84OhJvN/EIVzgcn7i/1sv7MXnzP2T/6VriUrn1iOpqwt6zdRuXLRZvX7j/PbI874BUd VpBoVzBUKZMlWOi8fZ/rn4sEDRdW7t1piria6+C89aCe9sPmJbkt8Q/qpmzSuBP3MPvXpmw8bgJ LbAOjVwhVCjuKTwruk+8merH1e+WZc1vdR+gsbGhStuPnicVeI4halOsiXi0oZZ76b89rY9Pd/V jSMp5/Sh010M5ft7e97s565JzbGzlrnQFsbcuovfz9kNAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:mgreer@animalcreek.com,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38601-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:from_mime,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0ED2704010

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
spi_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/nfc/nfcmrvl/spi.c | 2 +-
 drivers/nfc/st-nci/spi.c  | 4 ++--
 drivers/nfc/st95hf/core.c | 2 +-
 drivers/nfc/trf7970a.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index f873f5380017..bc5140c194b6 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -188,7 +188,7 @@ static const struct of_device_id of_nfcmrvl_spi_match[] = {
 MODULE_DEVICE_TABLE(of, of_nfcmrvl_spi_match);
 
 static const struct spi_device_id nfcmrvl_spi_id_table[] = {
-	{ "nfcmrvl_spi" },
+	{ .name = "nfcmrvl_spi" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, nfcmrvl_spi_id_table);
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 1bbda3d0a7dc..1b97b2f3f441 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -271,8 +271,8 @@ static void st_nci_spi_remove(struct spi_device *dev)
 }
 
 static struct spi_device_id st_nci_spi_id_table[] = {
-	{ ST_NCI_SPI_DRIVER_NAME },
-	{ "st21nfcb-spi" },
+	{ .name = ST_NCI_SPI_DRIVER_NAME },
+	{ .name = "st21nfcb-spi" },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, st_nci_spi_id_table);
diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 52fe81a557a0..d4e3049d138a 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1049,7 +1049,7 @@ static const struct nfc_digital_ops st95hf_nfc_digital_ops = {
 };
 
 static const struct spi_device_id st95hf_id[] = {
-	{ "st95hf" },
+	{ .name = "st95hf" },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, st95hf_id);
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 8f36ff82be8b..673989d5c927 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2310,7 +2310,7 @@ static const struct of_device_id trf7970a_of_match[] = {
 MODULE_DEVICE_TABLE(of, trf7970a_of_match);
 
 static const struct spi_device_id trf7970a_id_table[] = {
-	{ "trf7970a" },
+	{ .name = "trf7970a" },
 	{}
 };
 
-- 
2.55.0.11.g153666a7d9bb


