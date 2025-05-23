Return-Path: <linux-wireless+bounces-23345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFDCAC1D07
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 08:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590E616D5BA
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 06:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAB122A1CF;
	Fri, 23 May 2025 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6mC2PUV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405B226CF7;
	Fri, 23 May 2025 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981936; cv=none; b=mlf0tNFTKufNwQwRFiq95qGGsOwpVtalv68xYoPUzX4PB0xLlDY0fkVnBC87mu/noBLBO9/6hIKQk7yFAfZgkQESfnF3s0q9injt8H2XSJYa1sDORVxi+l2hFCgsmQtvAvgpQep3q/6V9ik35KViAxqxgv7pIuQiA30HUOhUTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981936; c=relaxed/simple;
	bh=5agChSLWffbqs33WDoMaqhmfHYvTXM/2r2hwYJKT6m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGw6iDOJVVhcZEAyYkO51cK3d197/UJmo/J7L7+H1GeDtPam0d/mNFswKKaxHcIyC7wQAvknnuiMNxmYTmtekbTPKKhAh9nJJhNzjiItityUQcRkY87ZZKHppRHMP0mHIAGgKYwSDBptjkm3+gxF2SJZgACjFFIKfxb0dumTHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6mC2PUV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742caef5896so4921127b3a.3;
        Thu, 22 May 2025 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747981934; x=1748586734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0ePufbu7VIypLe6FsBkdsoRiKLNMLaOUhktP7GEIZU=;
        b=X6mC2PUVAEJA4fxiBnqjHHqq3papB1TbK6+36IzpMHJFxcXkyFTLrOW0KovEujeqsy
         YnsZ9s45QH0AIkCErfnPlIxgQbLe9yw2VIHxFwghAsfoGRMy1WchNUYkVV+esaxCnFa7
         G/XcozlLJ62KX8FfVmjOJ9cBuioUiWa57YMfWMWKiNZa5nClw7Huyu+4Rl8OmjNRi/Za
         VHVS1Rv43rWAGHp4Nuv2kUl3h90pie5fnR7D7b5ruotDQEb39E69B8jjp/vErORPAZv8
         iLED3jzjml4kI6+WQq/8C9tNrjXkh74+dfaDscWCyXvB1UdbI1z3JW1UVWIOgKjtxq50
         0s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747981934; x=1748586734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0ePufbu7VIypLe6FsBkdsoRiKLNMLaOUhktP7GEIZU=;
        b=ZEJQ5VQjrVcABIGUCaIfadyCAn3wro8Liz5i4iIKps6w36vHTBUkEp0pT8HGL5T1QC
         PtBVT4XfgUVjMIWtJ7WOUF6f4kH61xDbGd0G1B6pjMkX0cWdFiewwCpVNqnzIP1qeLoI
         St+il0xTRSRzv0I/8OMEwQrIcsVluCKmWz/HlMBRF4rMIkGiioJ0xSW77x+DJMdQW4jx
         twhFDXAgnGQV0nZvmxeVVlbho3gVUMzzmBN0l5o5e07ZBgocmMRqGcpqMm3GGccza5ds
         A57WDZrYFh/fAOZPM7VZhXUKx2ioKTL91WcAX4GNbN9cYN6hr5+h32CQKFUEzfwjkF5H
         FjcA==
X-Forwarded-Encrypted: i=1; AJvYcCUHij0Pkwz8RLES/gRbPnu7wAMbd6r5/9nIdu44In4rTEzYa5ZHKP2zxoEk0/auClcaTuxNQYAngQBjPDUl@vger.kernel.org, AJvYcCW0/kdJk+t9hucieCWDQRKbI+nz9QUc0GZXOP0MUS4I6tZE/RXjVD51x170SUKFYMd/OgTq1WMRhZFYAg==@vger.kernel.org, AJvYcCWdsE7s7nS7FN7NlS0281e6IGVVl4m9vmVDAkiC2GRr3eVlxscGeFLQlSVp/IoN8EaxDd+o3COxgmfV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9X71IFIctnzWuTssKuAvuP7unaWwEA0czrx+mbqbyroz/TK9W
	LLfWQlcGzuShaIuu8PjE4mKcAfhKQnJfbnIyLKlhuM0VxfH5UZrBH34zM/+MVQ==
X-Gm-Gg: ASbGncvE2fxWhw7zQ96k4ZSddEDhB5G7Ua+ja88qhn5G95WtD4G9bKaev75GGY2L/dI
	12z20jlH1YXzcQkfsESZv2XTMagI8eGiGxqUBaQvOLGB1ctWksTir8tPFRJKYAJUVBUxlY/h3sT
	BtK+3SNtgRCyF+dGop4Ec8jQhoUbIqv3mDD6NFOa5/RmG3AsLfTOBk9/ijf7pSFfZNiRJHwwnmx
	MqQXuL0ccGwVVHyXbwCDH+z6JExGeoRIag7ZCHC7ErET0kui9luXszttrBzJCzeQiKmjhYLz0Jh
	ed01QOakf5QjQl+TNo4wh9kpLOg=
X-Google-Smtp-Source: AGHT+IGliA7GuFfJ93SR0jkZ0HTWRDg9t523aM4AFI6PdgzF+p69/FoTSFcnTxzKPmxszquv8QCZkA==
X-Received: by 2002:a05:6a20:4313:b0:206:a9bd:a3a3 with SMTP id adf61e73a8af0-216218f7a8amr44852546637.24.1747981934007;
        Thu, 22 May 2025 23:32:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm12177783b3a.78.2025.05.22.23.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 23:32:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@ndb.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv3 3/5] dt-bindings: net: wireless: ath9k: add WIFI bindings
Date: Thu, 22 May 2025 23:32:05 -0700
Message-ID: <20250523063207.10040-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523063207.10040-1-rosenp@gmail.com>
References: <20250523063207.10040-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are for the wireless chips that come built in with various
Atheros/QCA SoCs. dts wise, the difference between pcie and the wmac is

AHB > PCIE > WIFI
AHB > WIFI

These will be used to replace the platform_device code with OF in the
following patch.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../bindings/net/wireless/qca,ath9k.yaml      | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index 0e5412cff2bc..af2d01d3df23 100644
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -12,7 +12,7 @@ maintainers:
 description: |
   This node provides properties for configuring the ath9k wireless device.
   The node is expected to be specified as a child node of the PCI controller
-  to which the wireless chip is connected.
+  or AHB bus to which the wireless chip is connected.
 
 allOf:
   - $ref: ieee80211.yaml#
@@ -35,6 +35,12 @@ properties:
       - pci168c,0034  # AR9462
       - pci168c,0036  # AR9565
       - pci168c,0037  # AR1111 and AR9485
+      - qcom,ar9130-wifi
+      - qcom,ar9330-wifi
+      - qcom,ar9340-wifi
+      - qcom,qca9530-wifi
+      - qcom,qca9550-wifi
+      - qcom,qca9560-wifi
 
   reg:
     maxItems: 1
@@ -88,3 +94,15 @@ examples:
         nvmem-cell-names = "mac-address", "calibration";
       };
     };
+  - |
+    ahb {
+      compatible = "simple-bus";
+      ranges;
+
+      wifi@180c0000 {
+        compatible = "qca,ar9130-wifi";
+        reg = <0x180c0000 0x230000>;
+
+        interrupts = <2>;
+      };
+    };
-- 
2.49.0


