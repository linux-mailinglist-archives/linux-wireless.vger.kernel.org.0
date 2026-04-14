Return-Path: <linux-wireless+bounces-34717-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC/qAq2O3Wn5fQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34717-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 02:47:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F63F4A1A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 02:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33543301B046
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 00:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8721ABD7;
	Tue, 14 Apr 2026 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="s/qKECxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C252248861
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 00:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776127648; cv=pass; b=ahRsJqBLXkT6i/yvraXPpeFTgh1D5W4SId2WZOHX/fiMdX6DBFImdZK9tKFfKQ1e/wbMGUU1/vkWj2cf+IJZODvGxevklfyr3oDgCdM8GUEPULNeTWwCSArVenA5hgjXTY6HMcftAwIK1n3Zbjih17rPDSRPNDjaUpoiyCE6PdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776127648; c=relaxed/simple;
	bh=Ud3mtmsoftIgkmjV9a9u3lTqUE43P1+mj6ADly2pE5k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Nmcn8j6vaMkzyYe04PaJmyiuUei9PLdHRO5YipZ8p49L2SXYZiFhs8KKhsU/f0GeaOEVxd8ejpcd14Bc6qA9RfWqPRgqrF+Py8qL7XBWhN00664oOvnNuTEmZ1eq1XvzXf4t4BuEYM7iuGSenPWpaplzdgOGcm/UNkxo7OSI5Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=s/qKECxP; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50b2ebca625so44606771cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 17:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776127645; cv=none;
        d=google.com; s=arc-20240605;
        b=fyH29IiWHm/opoek78xsiX1MB6LJYhu5589f9yCPVZ7eAcOcrJSBD8TxlEjHbwiRyb
         +p2x0nPyAb+l7wS+Pvet8N8i/ThOvPjXGhIIbYQnC2UiXNfEJv2S4tVfUtAQggIdMZdW
         D4jp7Jr5VTEE8ZQf/+atFo6CocQ0NfBfLiDgBoG/vfMmR1WFjQiF4GiDKIX5AW/+CV7v
         hgyI9282QLe4hmzFKtbfIgnQJ4VnhnSHMvgkXHgnPoFvvY69ouuVayKJqrK18JKWGrpG
         GmqUACZtEObA/KqYkhRX2phWUKnZJTzidUX4RF5seyLNnlY1XkMMcE0PfsGjAdrrsTNJ
         /hqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DZthKiBBNfazaDb9Xs1lqHaz7Zn12D0w53dftCxHhcU=;
        fh=kwUmd9pLcs8Qf8gSw3VLuctaY1pYaFLWM7FR6VV8RRo=;
        b=NnQHYBW+LlnBEhS/912Mf9MynMastYG3LikAprtlIQbB9IT9y/nTm1zFm3yOR88cuK
         VA20q3f5ewqMBnW6UVyVSI8gWglTiAWoP5mAYnxCgEOxUWXbDDZgpGzu8sZwHW0rnhmK
         xbGglXHNbpKGN9/NjZR6jfBoRUcIQMO+cYqt/yJUz91U8Mc6I1DpSWFMm0Ivj1uJHzN5
         +EFSJPXNWnfKTyrcsiqZ6KpLh5RnZ9MFnvz57R2pRQT6NMr8tI/SxTnq1+yE0vbsb+jK
         LnQt6fL1RH2Zio7QGbtMofkRx7EjT897J6UqIE38K6/TTrnaqSCRnBUk8NYmXo/EJnKE
         bsgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1776127645; x=1776732445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DZthKiBBNfazaDb9Xs1lqHaz7Zn12D0w53dftCxHhcU=;
        b=s/qKECxP1SNlmi15qF50aCCscJCWoeifNzBvZ3AjE2cMNFl1JfU7Ht99GsnJIom0Wz
         16IpH6IXa6W/CJbdmshtbRUc03oUFvv3TALhCSipNylBj2jbpPijPNgI7i/flL69zvm5
         4K6wdwnMZmtLupYDP2SpsQhXi6vX6NJ+AIa2U0lsaO+q9DXQX25vYhDjubo1WKhZb+iv
         cSxau+SqIRM9qJNyNGy/pQ3drQsfQj3ZLlWxirBQJe9XO5GgTTFY979tO75ceMLH6cRX
         E5RBEy9/qGjPlatcTyZ+QqPfPPdSACPDdzH9hWxxYW4ncW5GfjAPYWLMmOGn0Uwfns82
         b86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776127645; x=1776732445;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZthKiBBNfazaDb9Xs1lqHaz7Zn12D0w53dftCxHhcU=;
        b=fuDZT0T2ahZePPI/El2wGkj2hwMHELjzEPuLb7qWyFcyMDd4PjRbFo4STZML4BTL+v
         yoDG2s9ArcQ1JuJSy27AzLebGToXTHDd/rbSrwTlh/QcNhEGvv9tJQo1TCWgP+QhEmLm
         eDFHbenOZGZ9auAex7rqOa/1NH1g64apjdUX9IikJuTN/b9qW6TQZ9Jj4xoegssMHMae
         Qqla1ypDU3sGZWTt8bRaVYDCjO5BMXzT0GOUYUTMtfu6BkcIHK9IHG/z0uPz9PVe/lc7
         xRqz8mh9vst3SIuaRrS8kgSoX2PpSaQ9D55cBEwdcEKSCGziiY8ZAzZWXfrSD5Ac5G0y
         BVVA==
X-Forwarded-Encrypted: i=1; AFNElJ81xCb5Y4TNgCuC/SBbsm0hXP11IlWjpxTT6u2kCX7SrSXsd3O9Y6VcZbAh8+amWnaOG72mgoGsKhQFm1HSoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52qS3eSBnKkqy8Ew7sC45qEE4/GJfmWYD8BpD9IKWqXcHdmcT
	cj7+UyBgbHitG6S7R2IZ9WwIYWxIVo9WMjwBAAmBGoDAiZhiBTadi2j7yZJC3jztuWrVwvnJOEu
	BsvQFxR8zFbVZ2BBITdYSMt+TTpInqViK4ZpIPOL0KA==
X-Gm-Gg: AeBDievGIiTkfTA8XoTI3WqSXArHof3bXt8i5WB8sZHUYdRHj6XGCu9eAK+EP1WSbRF
	oDdQqCykFb5lSbSm7YZuBVJvpH6K+84oGifP0zBexgpQvH/d9Sxy04kEKW1hnFK1CsEmRQP/L1j
	x3G9bdn1fPGeTJZ/6iHOc/Oatu3TrEnY7p8nL8i2FTuXNVKDL5fWHHRJ78dkdP08OrZCcoUlG6w
	xWXZOeF7UYIVouMLXYHX78OJV2Pg8hwjYSe+gnUwBYZxhDVc5zXa8eNqIwrfEeflDfoxGaUVbh/
	9d9UyAYNHV0+XfguQOQ9gRqqkg==
X-Received: by 2002:a05:622a:1c0c:b0:50d:8ed0:7f10 with SMTP id
 d75a77b69052e-50dd6abfc41mr197783761cf.13.1776127645412; Mon, 13 Apr 2026
 17:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Geramy Loveless <gloveless@jqluv.com>
Date: Mon, 13 Apr 2026 17:47:13 -0700
X-Gm-Features: AQROBzBqW-ojsb0u6FPA-ZqTzp-M3dGCgDcmDSGT-PWMOIZcL11AfWIsX9zzabM
Message-ID: <CAGpo2mcGfBL=ve1zyqJSdRSNzzd5MXX0NSBTs6HTZCjSkwmV1g@mail.gmail.com>
Subject: [Question] mt7925: CSI (Channel State Information) support in STA firmware?
To: deren.wu@mediatek.com
Cc: chank.chen@mediatek.com, Bo.Jiao@mediatek.com, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, mingyen.hsieh@mediatek.com, 
	nbd@nbd.name, lorenzo@kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[jqluv-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34717-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[jqluv.com];
	DKIM_TRACE(0.00)[jqluv-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gloveless@jqluv.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,jqluv-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 822F63F4A1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Deren, Chank,

I'm working on enabling CSI extraction on the MT7925 (Filogic 360,
PCIe) running as a station. I've built the full kernel-side
infrastructure (vendor netlink, ring buffer, debugfs, event handlers)
and have been testing against the stock firmware:

  WIFI_RAM_CODE_MT7925_1_1.bin
  Version: t-neptune-main-mt7925-2249 (build 2025-12-10)

I found the connac3 CSI patch for mt7996 in the MediaTek SDK feeds:

  0095-mtk-mt76-mt7996-Add-connac3-csi-feature.patch
  (by Chank Chen, Jan 2024)

which defines:

  MCU_UNI_CMD_CSI_CTRL  = 0x4A
  MCU_UNI_EVENT_CSI_REPORT = 0x4A

  Command tags:
    UNI_CMD_CSI_STOP          = 0
    UNI_CMD_CSI_START         = 1
    UNI_CMD_CSI_SET_FRAME_TYPE = 2
    ...

I've been sending MCU_WM_UNI_CMD(CSI_CTRL) with tag=1 (CSI_START) to
the MT7925 firmware. The command returns success (ret=0) but the
firmware never generates MCU_UNI_EVENT_CSI_REPORT (eid=0x4A) events.

All commands return success but none produce CSI I/Q data events.

My questions:

  1. Does the MT7925 STA firmware (CE variant) have the CSI reporting
     handler compiled in? Or is CSI only available in AP firmware
     builds (mt7996, mt7981)?

  2. If CSI is not in the current firmware, is there a firmware build
     or roadmap that would add MCU_UNI_CMD_CSI_CTRL support for the
     MT7925 in STA mode?

  3. Is there any alternative path to obtain per-subcarrier channel
     estimates on the MT7925? (e.g., via ICAP, WiFi Spectrum mode,
     or PHY register reads)

The kernel-side driver patches are ready and tested. The full
infrastructure (NL80211 vendor commands, TLV event parsing, ring
buffer) will work immediately once the firmware starts delivering
CSI events.

Hardware: ASUS ROG Strix Halo (Ryzen AI Max+ 395)
WiFi: MT7925 PCIe [14c3:7925]
Kernel: 7.0-rc7 with mt76 from mainline + CSI patches
Firmware: WIFI_RAM_CODE_MT7925_1_1.bin v2249

Thanks for any guidance.

Geramy Loveless

