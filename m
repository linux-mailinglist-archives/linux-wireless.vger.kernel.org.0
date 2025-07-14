Return-Path: <linux-wireless+bounces-25399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B324B046B2
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 19:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E021A66DED
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765B26C383;
	Mon, 14 Jul 2025 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMIagtnL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985B26B750;
	Mon, 14 Jul 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514600; cv=none; b=HwYw3Z4cYoU11rCNE8EACM/0AsQuo68X4OXFhGFQL4HtcE0Ogyf2zCCCbtNKaAuJmX7Ferc1eSrjc3aeUBC7arVgzrU2IIPlfgim/LdMFJEzigcSfZHKo9xEDX0DSsNxuBmw1qEvK24PokJnhDXua99JP9TFnGv47JPmx3Mvm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514600; c=relaxed/simple;
	bh=xRbvSQSkVTQAN77iIf/pGHg5FiTyuUQT9pQ6/+VKzXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9D6B5KuzxyeWnE2oewg1mh1uIGIn9D/pok0cggh4T/2p6MfQ8RGeaYVo3rglQ1wCjvEcDaFFe4B6UGO78JdZUFu2NjpGyUukqr+/88eGB7CTgGmBqbMskqrUEEatGN5Bm7nPt7MNe0ZOQXOj6GIJNf8KEzNuWIWi9qkUIuHJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMIagtnL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so2660811f8f.3;
        Mon, 14 Jul 2025 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752514597; x=1753119397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/NHhBLuDbQC85igx5PNLL+bdPfiQETJROiq4RU4vuc=;
        b=KMIagtnLBI1M6UcM2NKZMYinLbhlwLHYnUBMf/pBuLLEJpFUFvCnfbeiHBhN+WKvI1
         FkUFDABEYQdnU6eq8dtWGzw4lqBosRDoh1t50GzOI1EQZbz3lL5HhOy7Vh4pfFIxll3g
         yu17nfs328+rs3o13BavJd72soNMDdJyrw/rI5wBYITX/WUZVzPGHA+E7T7i5z3l4iyZ
         cjd+LSpQtI6o+PrCj5EA8SXb6gd9npUK/japlXssfQx4FKeBwN/U3uxVs8e9i1iF+toL
         3CWcP+KzbIpf3KTL1CBgsh0N++4EmlJ3pO+aRPQp98MVs/fKV4WKre4v7sqj8lA6ONIf
         rpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752514597; x=1753119397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/NHhBLuDbQC85igx5PNLL+bdPfiQETJROiq4RU4vuc=;
        b=hyQvb4/Pqq+n1I6oORzKjPGzTvboC9o6uFRdyGuO7O/3rmu+6T5CFfiXVHNwA/jbSs
         u421hQ5VQ168Fz32Z/YSLXMDe02hksEU4cRAnabqPi3FIztIR4AFa0nbmUM8Ndo/d+J9
         nQZJ2toQRJZ2P5fa1SThge9NNIGNEG3UKtVJlKJe6H7B4yHE3MTA8ZmlRG08gradmbWh
         Samq+aY+CALvSmRsTtwOFdWTXcj9IbpyjWsvHjY0EJ+L9rIuTr9kxx/fl2MN0KjJVzkB
         +UXTiYzeNbwp0hAYrZ6uh0E69w7p74ABejyHxdqrr5Ix8wI6SCOXCWFOq/tZgAK2LdaO
         cCyw==
X-Forwarded-Encrypted: i=1; AJvYcCUpNu6DQUOE2N20WEx6yPSSbbKfuebs05C6dtXkMy168DC14EsO2fpACP37Rog2zYG/IAZfRflYE3K8XHQ=@vger.kernel.org, AJvYcCX6V2frHQXmWO3olJn2SJHn11g8nlfDeDMfhMNVoVPPJ+428dR7HbCJrmS+s6QZT/szIp42W8GxvdtvTaTvrh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySl65G/VO6zW26YG+xQUEfHoBM5mR5Y/e87nE6sGvhk96hE/V6
	qOSoVv2GqSHSpqnUmYijWucmBaOEoeeGZubQnCh9/jDFjfL7vc0nXc4S
X-Gm-Gg: ASbGncsiMbpJ21GS3lJKzLkkmEe2JCc9HEnTNn1D92iwjjASLfbGNTaYWIsc5D8V/9p
	m5FFhkOFCFgO1MBWpOQy5mqtrBxacLQptb0yNGi2YVYn7MOBq4ve23QkjjNkgUWEf/kU6oWOq42
	FwkP8qdRF3+CJFCzz1AusLzABrbxtiRBCWMacRqWC8ZfcS9OvnSqk8K0cnd+vRPj9j4qEf/g6Rf
	1lDZy7m6AJoXL7i760JZSXRgru1v59ThpNfzTVoKONI+vkGF9UPx5LfppOYOwdDauETigZnjt9z
	2nUbMnVWiDV9CZInlMp8Ee4qs1PkvkizlpghYF8fk6AOCe+SVbdsYT16/XFCvSTd3fCgBEUlGyS
	sW0S3qPPjmE+Azpbggp4cDpSc6R18HnxEp/eLySyzXX2fxQ==
X-Google-Smtp-Source: AGHT+IHuJn8kD3q+6JLMG915sldZVVMLWRV6lbHRgVZd2dkQuekCTh7DL4CuETxuZNDsUcz9P/VGZQ==
X-Received: by 2002:adf:9d8e:0:b0:3a4:dfc2:bb60 with SMTP id ffacd0b85a97d-3b5f189df70mr10700130f8f.26.1752514596667;
        Mon, 14 Jul 2025 10:36:36 -0700 (PDT)
Received: from alarm (92.40.201.95.threembb.co.uk. [92.40.201.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm13152531f8f.60.2025.07.14.10.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:36:36 -0700 (PDT)
From: Dale Whinham <daleyo@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= <jerome.debretagne@gmail.com>,
	Dale Whinham <daleyo@gmail.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9 RFC] wifi: ath12k: Add support for disabling rfkill via devicetree
Date: Mon, 14 Jul 2025 18:35:44 +0100
Message-ID: <20250714173554.14223-9-daleyo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714173554.14223-1-daleyo@gmail.com>
References: <20250714173554.14223-1-daleyo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some devices (e.g. Microsoft Surface Pro 11) indicate that the rfkill
feature should be disabled by means of an ACPI bitflag.

If ACPI is not being used (i.e. booting using a devicetree) then this
property will not be read and therefore rfkill may be enabled and
the ath12k will be hard-blocked with no way to disable it.

Add a devicetree property that allows us to disable the rfkill feature.

Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Dale Whinham <daleyo@gmail.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0b2dec081c6e..42a1d384457b 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -43,6 +43,9 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
 	if (ath12k_acpi_get_disable_rfkill(ab))
 		return 0;
 
+	if (of_property_read_bool(ab->dev->of_node, "disable-rfkill"))
+		return 0;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
 
-- 
2.50.1


