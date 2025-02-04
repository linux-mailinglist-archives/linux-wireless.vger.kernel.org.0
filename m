Return-Path: <linux-wireless+bounces-18474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F1A27DAE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 22:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E954618830A8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538F22206A5;
	Tue,  4 Feb 2025 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Dsh7OWyh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f102.google.com (mail-wr1-f102.google.com [209.85.221.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082C21C167
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738705314; cv=none; b=V7jLV1KN3FJZYIhUvGYQVDMYlNyUxetFdhMKM0pL04666cVGVBXkj0JQL77/+L4s3ak6uxByfkKvVYksdr4hb9FnG1WyiWc7CtC2u5mtfFF9iFxkYXaN2nkFGbqAjRExrpbJONh6jPOXmso7/wChiS68zsKmT8W+HxQ6wVASUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738705314; c=relaxed/simple;
	bh=FS08keFY1ozdicBUiUIN8Bu2H6mZ2iIkvJVfmRGOhvQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RIRc9noVf0Fgqy7DDT231MpdwL4AH/zkveJ9f/So54AmRkeIoXCLMgXwjYVBn5TEZyrNEF3ClRLqAf7SZFV1nQWm1nh8IAoRwPzJ3M1h5yGP58owIXf8GFjbYqQ2e9XWDKcLGhwIM7/VSwpcEKi4FwzL4h2M1fOZHFDDpk7Gl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Dsh7OWyh; arc=none smtp.client-ip=209.85.221.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f102.google.com with SMTP id ffacd0b85a97d-38db0146117so528655f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738705308; x=1739310108; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kSjAEc3JpgYH0pfJk9yrLxuH6CjSL5l4ipCiBf9QiU=;
        b=Dsh7OWyhJkjgy3jaI4YUiT+Vt4TXogtOSZuWqg2OUPefc8+8CwDgDgBk4khSn5l2vm
         ybZfCN7Uu2pJFcUm+RnJGcnDzHVnS/NRnoCN5r9w/NeGQBEvu5EKMkJ4EPXLToMoJvJR
         s/5Xn+WWRUQxRNazuzyZMWyoCF5YK36njkh+BEfGVeU8DRg1BUKMLELMWZPVXG3MSMcj
         TFRggSg9VS/jldoCUxZuf6ueYVgXzJwRfc+e9XweBZljC02RT9EPbP6V9lbjjRi7xjh2
         GJNqLbeb5JurmJ1raHNV9fGnTpVrhgBPbmRNccYGmNArT5FBnlT/J2hWk00d98bYskpA
         VlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738705308; x=1739310108;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kSjAEc3JpgYH0pfJk9yrLxuH6CjSL5l4ipCiBf9QiU=;
        b=p4Klg4dOMjXq5UVqkgh2q0kSMSzptOb5GejkuQxiUMamMLCJ2h8EB6DtoEfQBv+u+w
         3nURpX0huhPnedB+XhUdi7zk/6gf2ruHuRKiT8zaoBNb/Kk/38OsJDrwDZFQf1ZcOmH0
         z3pCM0zsqQLj+aFD1d3XGU6LzhMgyFH6sd3r0xQxpEKv3KEO5564VF19xWKp+8hFRLSv
         RwbsGrfx4GRu2vYA8RFNEoTruMe4C1PzirXrX9/Uk6CwuYgsx3Bs3/Fw0AGs5bqp86k2
         rBfqGuNhisSn1HcBN6WLOit7RT3M8JuDMBTorxecnkNKD891MwB7L6PAKDp+y/SRTMWh
         rj7A==
X-Forwarded-Encrypted: i=1; AJvYcCXj+hy3Ac+ZiEnGGz5NGyFgSNRxuT5NRNPj3lyo/tHh7EYKvrc9FXIk+DCDkKLWH2tN9ZlnFfibrBVN55ze4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzynIwN0QAORzwahZ/AC26wP2cbNJ4GqFv4f2EBEaonBXa0Y3yB
	899+hXPZMnXtvWYXEK+wIOJIlEDI/wTHa4FTiUP1ZJlD1C/g/bzIM1jlH7doNr3/o20jsR5Jkx/
	wbK7pO4hlI03xPcKW3mtv8t7snRmnsQR7
X-Gm-Gg: ASbGncux+N2bT1tt03ifFiuylBo5XO9lJGz1YG6Sse1HCFMNl4wg0Ny7p7LXXj1q9wl
	Ue74AphPvNCYihhsyDy0AvPoPq4IL0nXtS7SsMNWGuv1TAw5AyJV3T+0G/RDTDQKuzjXDRh1Rfa
	zKKjcM3Yhs3PRabRAPy2G4seiDt0N+ZkfxfSn8pai1v14OS2UjYsIgAeFVNBPLUQvD6zMdopOPq
	l0QHgqKya27LWBdRZXFT8zYYf39EXFcKyWHk+W44QgLt1RhuzUYXPdtT6qQoqh8oDELjRevLD19
	egF6wkwh7AXcSXjO3in0756vrTASk52pjbY+mdM=
X-Google-Smtp-Source: AGHT+IHnFwgWjv8YV945kq/kC9C35yctrGUfuiPjRcl9fbEU9yyG5D3XeVSkJedIdI9xuStQxGPZrW7XyNqF
X-Received: by 2002:a5d:5849:0:b0:38d:b0fe:8c99 with SMTP id ffacd0b85a97d-38db49101c1mr230256f8f.48.1738705307565;
        Tue, 04 Feb 2025 13:41:47 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-38c5c0d3560sm367622f8f.8.2025.02.04.13.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:41:47 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0FE6A3401AB;
	Tue,  4 Feb 2025 14:41:46 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id F2E4CE435A1; Tue,  4 Feb 2025 14:41:45 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v2 0/2] netconsole: allow selection of egress interface via
 MAC address
Date: Tue, 04 Feb 2025 14:41:43 -0700
Message-Id: <20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJeJomcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDIwMT3bzUkuT8vOL8nFRdk2QzQ4NUozQLc8NkJaCGgqLUtMwKsGHRsbW
 1AIZgPeRcAAAA
X-Change-ID: 20250204-netconsole-4c610e2f871c
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This series adds support for selecting a netconsole egress interface by
specifying the MAC address (in place of the interface name) in the
boot/module parameter.

Changes since v1 (https://lore.kernel.org/netdev/20241211021851.1442842-1-ushankar@purestorage.com/):
- Add a patch to define and use MAC_ADDR_LEN (Simon Horman)
- Remove ability to use MAC address to select egress interface via
  configfs (Breno Leitao)
- Misc style fixes (Simon Horman, Breno Leitao)

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (2):
      net, treewide: define and use MAC_ADDR_LEN
      netconsole: allow selection of egress interface via MAC address

 Documentation/networking/netconsole.rst |  6 +++-
 drivers/net/netconsole.c                |  2 +-
 drivers/nvmem/brcm_nvram.c              |  2 +-
 drivers/nvmem/layouts/u-boot-env.c      |  2 +-
 include/linux/if_ether.h                |  3 ++
 include/linux/netpoll.h                 |  6 ++++
 lib/net_utils.c                         |  4 +--
 net/core/netpoll.c                      | 51 +++++++++++++++++++++++++--------
 net/mac80211/debugfs_sta.c              |  5 ++--
 9 files changed, 60 insertions(+), 21 deletions(-)
---
base-commit: c2933b2befe25309f4c5cfbea0ca80909735fd76
change-id: 20250204-netconsole-4c610e2f871c

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


