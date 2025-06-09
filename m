Return-Path: <linux-wireless+bounces-23839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E520EAD174E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 05:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424D43AA124
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 03:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6731C2472AD;
	Mon,  9 Jun 2025 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcZ+Rhfw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECF24728F;
	Mon,  9 Jun 2025 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438544; cv=none; b=DSo1dTqVT4Ya++Ry4pgMhR2UrpH7oXbOZ5rx/hCYjJ2ZMt8HOwygwk/KavTuuca6oDRsljVWwIHnJD3w2IYXZKlXQKVcf4j4AzHV9VFIgvnrYBFN335qfYuMPOctDmgyMehNErb7SCertlAmjAsEj8aeWaXNVGySK/jdB6z6/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438544; c=relaxed/simple;
	bh=BOVfDJPoCfFFtY+XodlIWmpn3idqQljzMhAS6uW6lpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FenRRaw276/DLxaT90BvSky28J0lE1UpElMqsDONo0iuJcYoeT2m1bYMLg/DxFo4GorO9rssNhVm9rqdi92JNkUCFrhSVInuBbPklvKonJGVnjKAqkDqZqvekf9ZbH6EbXkcnMdFzD6ScKsyR20zO0MaAfLSQvUC1Tg3bfgnqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcZ+Rhfw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23508d30142so51124825ad.0;
        Sun, 08 Jun 2025 20:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749438542; x=1750043342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzSU8nsATIo9zu1PVccgBXCtIIymE8GQqXt996enmbg=;
        b=ZcZ+RhfwyxLogDF6dakibOKm8uraa9b1W9j7PqerxV1iga8okZwIBlp4+WV6/nJ/Iw
         CUvm7EIzwUzPvc7AZK6N0Brx+sb9Hbn82/gNO5Faxoc9uVu/Y6xebDmf7TQNpon3TcqQ
         mXsf7dxH7ZAJIXJcCstyuGZc2AjdbW5eczM56znmKx5WoRRHP4+32evZHFHPo6sNK1gs
         4RZWXvYDToXALeICBJqEtguHfizW6gC7smMQLrudX4uEqFku/dCPCL+p2stMTMsHTlyx
         zzujT0XGuYon3+XJ80Efjrda12b2YTeGhHRrb9Tn9+J8EYMx8tFeReLkX0AQALveuUa/
         QAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749438542; x=1750043342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzSU8nsATIo9zu1PVccgBXCtIIymE8GQqXt996enmbg=;
        b=DuLEYU/wUkFtc/oQZjylWmT6z2pOr1sWrxkB31xnOQqOsXK+Y2v+Ijf8kdraPBdEpr
         8U7FsA0ncoi4vxljr7SzN//ZVM+gKLXtgJSJr+09iXN8wPCFWno7sgMsLt+uyZ6zv2ya
         EV9cJyq8B8ltuvOFYBQfFjKoS5wufBZQ1VRqTPSOBqcf3oHHImyMIot+cDgvsOxJLjPd
         5qFcBh5EBGLurT2bf3t4+aWW8Im+7Y0swajvxGA2IDgIGgji7PwsjKEagmN/WRcGGQmi
         xy4/qeWeP2t0804RskN7b5W/IBxUd60qSLYxe4XjmCVC6HR4sUEDifHFDBn5WnyJrAQN
         B9vw==
X-Forwarded-Encrypted: i=1; AJvYcCWyG7aeAf4UqH4TrYClLM4x1R4IE8nROlVfU+T7iisctTNF9K9w98lsJEp1b+MqXOqCqr/kjbE4fjR8a7GG@vger.kernel.org, AJvYcCX2OA6ehrCawO27P6/0Q2mJ1I7G/EPVoP/HS/jfkekFZkayib5fd2csPqceEvVZc8/W+AIHEmjRYi5q@vger.kernel.org, AJvYcCXg1urTUM4IpPuISQL/Vz5b6PslQM+ZfBbQp4ASnNc2NCTzvwTU5idDbZcuyIuKWh8FGwOY0Dqk7OSe9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPiUratYwuDJo4bKqGJz2hMsiY/C8Djkaa+10iS5J76MIw3S3O
	dPgIatlk8d6D0dcfaz+p1335nLoQesmdrM6uKirIP3mY6BvP6t8fCoZ6iNoTcg==
X-Gm-Gg: ASbGnctISmT0e4BkWZK4se7GGV+eWPjPQgaJSS81nmYtCxsvCDEKa6AK9d88Ijt3GqJ
	epjxcX65R9QWfVOA7lZPfQh8WvzPQ6PwqLVagmaqU/lnoVdPXD0YZFjymLdC6574Mf73JRp9ONX
	630VNihAUJYd+MbCSyDGUqgKeIWbajZeUoAndWOn/F8Tsbs8+JQ1vnqNPDtJE/yBbCPseHDGkqX
	NTyfO1VAMoBd4wbfW6jQOw0EfGzowgDaZGn6au4YdjM41KtOS3zPwMAyv115Ms0HDQ5KMpAH0O/
	ILngP4v4djJmaj4ol0PwnRTw0hmp17fhZ4TOHiNodMssJNr0
X-Google-Smtp-Source: AGHT+IGHL5aLMq8WMEThtj+mFhhQMR1hxx1t6f+c9SokKwf0WduO1eynoUgZEr31jrm5I3oukdtciA==
X-Received: by 2002:a17:903:22c7:b0:234:bfcb:5c1d with SMTP id d9443c01a7336-23601d71207mr171637415ad.40.1749438541938;
        Sun, 08 Jun 2025 20:09:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fccd6sm45310125ad.134.2025.06.08.20.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 20:09:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv5 5/5] mips: dts: qca: add wmac support
Date: Sun,  8 Jun 2025 20:08:51 -0700
Message-ID: <20250609030851.17739-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609030851.17739-1-rosenp@gmail.com>
References: <20250609030851.17739-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that OF ahb support was added to the ath9k driver, we can use it to
enable and use the SoC wireless found in these chipsets.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/mips/boot/dts/qca/ar9132.dtsi                       | 9 +++++++++
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts         | 4 ++++
 arch/mips/boot/dts/qca/ar9331.dtsi                       | 9 +++++++++
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts             | 4 ++++
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts           | 4 ++++
 arch/mips/boot/dts/qca/ar9331_omega.dts                  | 4 ++++
 .../mips/boot/dts/qca/ar9331_openembed_som9331_board.dts | 4 ++++
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts              | 4 ++++
 8 files changed, 42 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index aa148d51ab68..682072371bd3 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -155,6 +155,15 @@ spi: spi@1f000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		wifi: wifi@180c0000 {
+			compatible = "qca,ar9130-wifi";
+			reg = <0x180c0000 0x230000>;
+
+			interrupts = <2>;
+
+			status = "disabled";
+		};
 	};
 
 	usb_phy: usb-phy {
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index f894fe17816b..a7901bb040ce 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -108,3 +108,7 @@ partition@2 {
 		};
 	};
 };
+
+&wifi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
index 768ac0f869b1..6eb84a26a20f 100644
--- a/arch/mips/boot/dts/qca/ar9331.dtsi
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -285,6 +285,15 @@ spi: spi@1f000000 {
 
 			status = "disabled";
 		};
+
+		wifi: wifi@18100000 {
+			compatible = "qca,ar9330-wifi";
+			reg = <0x18100000 0x20000>;
+
+			interrupts = <2>;
+
+			status = "disabled";
+		};
 	};
 
 	usb_phy: usb-phy {
diff --git a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
index c857cd22f7db..08e728b8ced8 100644
--- a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
@@ -97,3 +97,7 @@ &phy_port0 {
 &phy_port4 {
 	status = "okay";
 };
+
+&wifi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
index 7affa58d4fa6..37a74aabe4b4 100644
--- a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
@@ -98,3 +98,7 @@ spiflash: w25q128@0 {
 		reg = <0>;
 	};
 };
+
+&wifi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_omega.dts b/arch/mips/boot/dts/qca/ar9331_omega.dts
index 8904aa917a6e..1450419024cb 100644
--- a/arch/mips/boot/dts/qca/ar9331_omega.dts
+++ b/arch/mips/boot/dts/qca/ar9331_omega.dts
@@ -74,3 +74,7 @@ spiflash: w25q128@0 {
 		reg = <0>;
 	};
 };
+
+&wifi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts b/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
index dc65ebd60bbc..5786a827c000 100644
--- a/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
+++ b/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
@@ -106,3 +106,7 @@ &phy_port2 {
 &phy_port4 {
 	status = "okay";
 };
+
+&wifi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
index 10b9759228b7..a7108c803eb3 100644
--- a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
+++ b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
@@ -114,3 +114,7 @@ spiflash: s25sl032p@0 {
 		reg = <0>;
 	};
 };
+
+&wifi {
+	status = "okay";
+};
-- 
2.49.0


