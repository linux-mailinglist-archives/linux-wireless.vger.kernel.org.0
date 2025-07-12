Return-Path: <linux-wireless+bounces-25327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27208B02D21
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 23:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBDF4E4FFB
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37017235355;
	Sat, 12 Jul 2025 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUaS+roU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E2233149;
	Sat, 12 Jul 2025 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354300; cv=none; b=l3OyDGtVSRYl4rUnIQP7wB1Go2D4pqrPgKz8Cm4oXDKP4zZqaFa8LsVAzBqZeB2VsOUhaGl1AL7M6CwjwbR4SrprbuElUzc0oAJznzKvCMIMk+L/F72+PVCXzWq/QnrbkSnjPKcqPPEcC23pWlLJpXlWrN7jgqb1AeVAkWdWZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354300; c=relaxed/simple;
	bh=oso3s84HHIL4dE7V1UAH+9yd50ezAj1vpkwyK51jz3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILHZVCcZQO5ezIib0Iul3qHMtCz22LHbzPeVZX5ookFGMhrcsvZxCB7BSbaqTrV0/aDhueAsvcK47H1RBa95lzPHauOeB7tEd4xK93wVUM6f85FryP5ZI5LQQMz4LRvoLDiq4+ypuT6qUQ385dTNrxdbEFX5NgAvj690KZTtXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUaS+roU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2810240b3a.0;
        Sat, 12 Jul 2025 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752354298; x=1752959098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvZgwDhd8R+31/oVgTrgK7V+PUBtSsqxq+ciLntuUVw=;
        b=RUaS+roUCGB6kAy9f24WT9ty3BM3PhCvYhVW4D4FIH3a08o3mAeFuYO22XQQ6cm0Y/
         3WbfUXwjOUj0cKG7a0+NMVWIypsarTSOr6P0NOiO+wiumOs+n4Mpd3hj/Fj/I1MSbh/Z
         /QYf+AeoRPlGSPTyHd5T6TiuxJjQUeQcZASa3+8Uo9XmpgWH6jWnZNaQJIwIB9u7z9IE
         3YHzepGjG6is1hic7THt5m68YOVGO1ahgP/RFPKpC4DsGsqFbaCzfV/uWES6NPp/0XAM
         TD8OeuDYi/CWmU4AXPSEEJcNOae76nxyZyjpt8YATCJJMGhC/5z+PRRwYcgctaco0aEK
         gIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354298; x=1752959098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvZgwDhd8R+31/oVgTrgK7V+PUBtSsqxq+ciLntuUVw=;
        b=FbNUozPyMH7f6w0nC090+YrN8/JA+RoXLRBrjul18I6kvctNdKu80s7ti09Pvrf9po
         lNZVrtZlNB7nMEl+DbbtAZ9u+aW4UHi7l3d9pOMxTLrubrjgdHbpKUdKFm5uWOM0DB43
         OdHHe55UC03gx0fjM7yzUvL05YZ7x56gr7jSJBrarUFJRoaUycmwzIwub1GRZ8bbGeW6
         2d0n/k3hTsxSSDWLW3L8qsfhjhr5HLIiNExfNATJuB2dzE8f/fJmRpMKQdLDFg63MRwd
         cGEVrXeAtXgNszlX2nwWwk21HYBPGbSEqV++Y6fsfxUrVlC+yK5uCYdEiAHloHvvxGOl
         nJeg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0uIfTq0Wv/8eqEm1wxfamVWS/GIvwpdLTLhQOLQekyO0nIYXJ7kk76gWPERNUlG96m1uZLXQFv69Yg==@vger.kernel.org, AJvYcCVAqxJ99uIo3Os4nppNWvNRlapo/NGmDkzbqCwQbece6dGWQ1NlpXFBk0bn4Nay/czidlqqu4wiWe4+@vger.kernel.org, AJvYcCVVyc3kmOK+BO8ZJmqCEtr7edCPj3JHGQiRJyD70AMEOXjCfBOzJNTY1RyIJa7VST7hVYCQmpEvpgalPXA9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7VrY1M9GaB7POWbjXuPnFUYrOzdvRWN7ne4dxOe7f+RFu0sh
	+GOUCcTCMigzGg7DhzrsUcgFZI0bTHNTPFm5fqxI4hFe2nxr0d/4+MJnJ04RDHQs
X-Gm-Gg: ASbGncvLoJHpyzJzTnSLLkpLV8/vq13pUuy7hkREVBjQ50r/H2pC5k8inVCP2eMyOAW
	Pdts79hsZ2V9ZsrJbFq6S3AQoRZczxpQYT9GWOmub8vXde7QZg2Ff9TCTxsXJbpWMlbmlby9RQW
	/pWlB+FiofGlVioyDAQ6loM7nxYbA/ay5cByjMiK/Bzs/hISH/60Tm6BrfmY2FMxFnaj6SJPY4d
	EVMM9yGDJ37DdLd29Kvk+0m0jjcr2iCvMJC/DdQAIV5VzHW0rUz6kOm2dm5qmm+0AVAdYDCd7Uj
	AS4XGuKRF7kcogg5YnKy/o25LNzAfFWAjRgXJllW5LHylOj7TTuutzswi2hCspGuJsLVpo/sTMP
	FPwI=
X-Google-Smtp-Source: AGHT+IH05LGizbK3GZZZX/dFXVZD4uKLCLM5CZELt23GFHFB/4CwZk3LskZFmMki9iqIUXWnuhX5uQ==
X-Received: by 2002:a05:6a20:c709:b0:215:efed:acfc with SMTP id adf61e73a8af0-2311dd59489mr17727867637.7.1752354297699;
        Sat, 12 Jul 2025 14:04:57 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5d30sm7988645b3a.5.2025.07.12.14.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:04:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv4 wireless-next 6/7] MIPS: dts: ralink: mt7620a: add wifi
Date: Sat, 12 Jul 2025 14:04:47 -0700
Message-ID: <20250712210448.429318-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250712210448.429318-1-rosenp@gmail.com>
References: <20250712210448.429318-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT7620A devices all contain a wifi device as part of the SOC. Add it
here to get it working.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7620a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/mt7620a.dtsi b/arch/mips/boot/dts/ralink/mt7620a.dtsi
index d66045948a83..460164bdd430 100644
--- a/arch/mips/boot/dts/ralink/mt7620a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7620a.dtsi
@@ -62,4 +62,14 @@ uartlite@c00 {
 			reg-shift = <2>;
 		};
 	};
+
+	wmac: wifi@10180000 {
+		compatible = "ralink,rt2880-wifi";
+		reg = <0x10180000 0x40000>;
+
+		clocks = <&sysc 16>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <6>;
+	};
 };
-- 
2.50.0


