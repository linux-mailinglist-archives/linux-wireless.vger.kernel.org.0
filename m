Return-Path: <linux-wireless+bounces-13332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DEE98ABA2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 20:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F881B20FB1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 18:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EDD192D82;
	Mon, 30 Sep 2024 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="App6xxHH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933221990D1
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719643; cv=none; b=tgbbnRQ1ku5wZ6ppbBZY/CuEf76aZI/DQEMcCOr+QEgVfkspyRlQA1Y6P1FeBA5UXzH1uJb9HGEfbB6xSz6atXb24nwvB/5ioTbbAjYGk0F7qG9KXhtc+meHKUccorgDrtVCLCyMJBgzaBwVTrJ/83IocaPcaJN/4lozFauyl7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719643; c=relaxed/simple;
	bh=TmWA5XOLEyN6IMyNFp7UuE+LCAG4dub2rErLLKcgVCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCMGUGHxvFOsYIR5v5KiU7vS+JE4eTlgmGOT/9TyvsPblPYIRIFm09IrfQd2ZQukP3bNMGJeFna1EX6m1t6rp/jNMrfAO9Ow3RsksrIMxsJ0qqQmUyCzOYSW6lpbBzR8u7xP7gVhC/dY9ct52pCOyq/jTIzLMrchpC7tS0ooyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=App6xxHH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b7463dd89so18329225ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719642; x=1728324442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+Qmv3lRc1xRWRMu/c8FxIebEpdcEiaSGlSOh7PCesQ=;
        b=App6xxHHcm3q8FpHStMh9pWr4PajEBwurGSZ+1+/37eDbHVB5CFLAqjSQEbKeS6RjM
         5v47TBbvMb6gF5mnAtvrW2ydIpoqeoDWHI5u5EtPBABU4u70YqJ9LbeVelgEZHAXp8yY
         8oZuHOiMO6+MUF86mD2oNWbeZObzOk7Kefn0BFVnUoa9U4ghBTG/W8p324LAARFMS7lI
         o7yEYBdHkudVmOpSQF8wQbMRdMVhMCe3PQEnqRnfH5ivbCmmGPbqPov1xlfmRmyTcIEH
         jFDc3B6CTUrZJebJ3T5NMcRYRFBnzRsc9nJLSGFQnpUD0oXD/npcTCTTGmhllepqWBIy
         3ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719642; x=1728324442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+Qmv3lRc1xRWRMu/c8FxIebEpdcEiaSGlSOh7PCesQ=;
        b=AZRRtmCTkevpMAZVMYXgvo+61UQS0Kt4085AeYSxZakPmYkbvllbDZRyFFmJ2Lmu5Q
         UkKAnYfzsAy1g4wJUg50OCpUnrYOnrOgV09qLX9kywY08M1z1yT1sf2AO2Aciwws91ZC
         lQGY1jO6Pn50CDNR8LGSI78Z5azPfGXvWqrW1BKwWFM33eAnkj5thAV4XUO/+nZGvvoJ
         PfLd0hOjgRvthwZ+7wQVdj7PzATPAlyQWUwDO5+LS95dMXBn/MCwIyZorN87EMV9cHsj
         TjxjLytaJNFPJ3tdeyJ/Cs4R8rJVy1EsGtzHVIlXgo4T0/zPgu/pYtgvLaZ09/U072xR
         cIMA==
X-Gm-Message-State: AOJu0YxAfSIz/1BD/K86Vnn8bZ0dffK1NuErs3wFc7G5R7h9VDk4n25a
	5C7nVwtFB1Kn1lIA7T8WCUs/sS9/1rbRa/qjVueXSh/oBLJhW/j7bIc425Bx
X-Google-Smtp-Source: AGHT+IH1x2mqnw5viifSEjQEQMhx633LhogmakDTj7I5f8jqdG9yHSTYIpqle9QUIAMpCob29DDCag==
X-Received: by 2002:a17:902:c941:b0:20b:5aff:dd50 with SMTP id d9443c01a7336-20b5affde4amr101073045ad.31.1727719641753;
        Mon, 30 Sep 2024 11:07:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d9fe05sm57439295ad.93.2024.09.30.11.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:07:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com,
	hauke@hauke-m.de,
	jirislaby@kernel.org,
	mickflemm@gmail.com,
	mcgrof@kernel.org
Subject: [PATCH 2/2] wifi: ath5k: add PCI ID for Arcadyan devices
Date: Mon, 30 Sep 2024 11:07:16 -0700
Message-ID: <20240930180716.139894-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930180716.139894-1-rosenp@gmail.com>
References: <20240930180716.139894-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arcadyan made routers with this PCI ID containing an AR2417.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath5k/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath5k/pci.c b/drivers/net/wireless/ath/ath5k/pci.c
index b3137f60e879..f5ca2fe0d074 100644
--- a/drivers/net/wireless/ath/ath5k/pci.c
+++ b/drivers/net/wireless/ath/ath5k/pci.c
@@ -47,6 +47,7 @@ static const struct pci_device_id ath5k_pci_id_table[] = {
 	{ PCI_VDEVICE(ATHEROS, 0x001c) }, /* PCI-E cards */
 	{ PCI_VDEVICE(ATHEROS, 0x001d) }, /* 2417 Nala */
 	{ PCI_VDEVICE(ATHEROS, 0xff16) }, /* Gigaset SX76[23] AR241[34]A */
+	{ PCI_VDEVICE(ATHEROS, 0xff1a) }, /* Arcadyan ARV45XX AR2417 */
 	{ PCI_VDEVICE(ATHEROS, 0xff1b) }, /* AR5BXB63 */
 	{ 0 }
 };
-- 
2.46.2


