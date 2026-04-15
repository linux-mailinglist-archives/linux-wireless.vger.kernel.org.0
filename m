Return-Path: <linux-wireless+bounces-34837-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJy2B1IQ4GkycQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34837-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:25:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE307408989
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A90F307BA34
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1472394799;
	Wed, 15 Apr 2026 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VegaS/Bm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500DC393DF5
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291833; cv=none; b=q0fU9KOQLfZv9es+/cDq6YYWic6pBmVNVVpy8TU3Z4ATlOCY3Coxln5B4Ea035WK89lXdlfJ5BdszJr7Wml4OEeCl4w24f8CcmbS1EkD70fS0MQdLiGoa6skKACNc5ks2vC6LY+QG49C1/1EWSuxS0v3kftmGbwfVtifwG9l+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291833; c=relaxed/simple;
	bh=68H+fNnG0gcLOqga1PRGZ8NQbqGCc8/Fcn1opdI2EH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBV3+tzB9RvtXoRV6Ct20FntXXZyEvsOvILMNoWl0K2Mo8Ge8vDNo33R2yxQILu1ITniLtJFjc6ij/e0SiIfreEtjFQeGbVHVWbkdFg0UatQzi4Jf1MnPJyQVCIFgh2cMMvjGfzezjqI6rY/+vfqOgL4EekGQMLiV2c68r7kNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VegaS/Bm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so71327875e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291831; x=1776896631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68H+fNnG0gcLOqga1PRGZ8NQbqGCc8/Fcn1opdI2EH8=;
        b=VegaS/BmKZwxmPdAe6VyiWqOcWK2TCvbt2EwJwyf+TdapSq4shgL4N/34Qp4o6RJd6
         lfg06a2vc4OZDVREGcX0s+IO9n5CjVC8Z0SX+97h4dBa0aI0JqNNF9uv9js9p6AZnngh
         0o3ou6qf1nEKVidD9PiPI0gxO551mf/qFkoA6ciR2PnDb23MUFw+iOy1OPwES1fslpEv
         se55dX9e5gJkOyjEOJv3pADFUAUM4pkACwtlQA6n4s+Ey3KDqHCXv2T56eMIpQORWidW
         063TIhczTKR2ED5zcW41LcGbm9mZ9UlppUwa2XQSlcilIIvFMmdh1ftL26D5POLcBLAb
         S/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291831; x=1776896631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68H+fNnG0gcLOqga1PRGZ8NQbqGCc8/Fcn1opdI2EH8=;
        b=ibksXT+t6dEgfu0MPV9W+GOZOTX5KtpPbeKlhA3K7+6zQ/QVQv8rAhdipJ2XK5te2T
         XISQlICOxxrxd8l51plFJjLH8DfByk6YSlAfFXz4aLU7BJJTQfHUNDLiXHpax+guG5vA
         klVBepImkPmX3NHLQzHus67zFh5in8TMdQrGvIYMfexlw+XmMqbi0MKPlFFqW668Uekn
         zQ1r80DINMygcIhezcR+5DkF7jmbJAfPS9uGgWa6Jn9u/0d6+Q2ciZCCdnh8agGeHQyh
         CxxyATFpRDFG+nhC2LDAfG3fRHhdEU1tNe/Ui11A3SLUJZW5ueKUw2D/3Ed6qQueiwSb
         FNuQ==
X-Gm-Message-State: AOJu0YxJmmKOSSfLjrME98UmfMRzISKLN0gWHnFlBRCqQ2eyZfvzUkRc
	IxqZAHUB+Jtq4NS68IIGXN6TQOKE8++55xMquG0SvyqEDUFEQCmHPZk=
X-Gm-Gg: AeBDiev98EaJHlJu/3bbAVspKeOXwX/DIdeawIzL8Hvc5/cXVpFDqxQZOvuxZxHkpDt
	RYD902TWTKh6jJkCFQ8OXSeZV+K4UEiUvhaGE9AxEgqFQKsDUkoyXzyh+f/ZrNU+FDg6aDTX5QR
	F+ikLjukur37ebrqcYeS8xvBQXLx7SNMx3umUv4zcEBKkBZ8awuKzxZC9+U+1TlmGheQV8vXG3z
	YUGG2n+anzkxQQZl7Ndn7ZtiBRrpHGSg6sXVkUIvaEsNElVVISz64qjlSaKvmOBDdfGcy9TmQ2i
	3fq5CdvxKWUJj2woteW2wKpOovN+Ah3OjQoNrleGeWyyWpFwc62JuB+R6kYWkrCUYzpOQifqfzy
	aO/aW72JL2rry3D9RbIKys67qxAipEpQCGFFnkxme6QPwJKae4nywMXKNBN3agd1AouGTamMhSc
	UZPEY=
X-Received: by 2002:a05:6000:25c4:b0:439:c299:4d8f with SMTP id ffacd0b85a97d-43d64271215mr37959241f8f.17.1776291830722;
        Wed, 15 Apr 2026 15:23:50 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead402ee8sm8339591f8f.37.2026.04.15.15.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:50 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] wifi: ath6kl: fix OOB accesses from firmware-controlled fields
Date: Wed, 15 Apr 2026 22:23:46 +0000
Message-ID: <20260415222349.1541181-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34837-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: BE307408989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Hi Johannes,

Note: this is a v2 resubmission. The original was sent via Gmail which
caused HTML rendering issues. This version uses git send-email for
proper plain-text formatting.

Three issues in ath6kl where firmware-controlled fields are used without
bounds checking:

Proposed fixes in the following patches.

Thanks,
Tristan


