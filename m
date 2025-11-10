Return-Path: <linux-wireless+bounces-28790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A5C4729E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C931885C33
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43FC3128CF;
	Mon, 10 Nov 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pb5mDbCk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B3303CB4;
	Mon, 10 Nov 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784788; cv=none; b=bitzClYmVCLW3KKbn1GzfysVLzNSj4wTD1aj5rKdPdjwMrqiKlI2UCqrcaEv9fjSI3Ahd3KFfov47vkk3FXz8qyOfwxL/KXTwHsHFDv5NOwWAJxtOyAWh8Ycv8WUyADrvkCp39q8tb9NJ1ns0z/XWh8Lzzahb7rHKgc2a6rEzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784788; c=relaxed/simple;
	bh=L3nGmc65cfsV6qiQ+LYogmLlv8XDTxddUlOLJY174z8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oXjJXsz5agJBoImMHFTtw71emXlGVvSght2CiiaRP44TQ4GrC31D2oUK1p8Utr6faSfcKyNvqx/SiZ53CrY0lBZ9BqMLssEocxdtm8kFrVfahHKtIigyvuRrOCpbnyAClCIXdi8yBZZefkIWQfDMdFch1Abk8LZF8oh55dF0ZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pb5mDbCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAF39C116B1;
	Mon, 10 Nov 2025 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762784788;
	bh=L3nGmc65cfsV6qiQ+LYogmLlv8XDTxddUlOLJY174z8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pb5mDbCkKZdH2m8BQACdqKZTCEu/n2DXSP7srbHxmdAfOHZJx570wJUD1kaBc9F5R
	 BDY/1DOm+chtaitlSvHxBhq61A0zZuh09dAOnWyOW1lpnBireJRGv9ro2SmzN4v0QL
	 iwPG/dSqO8kLVqkqoXszDEjG7lq0JctbcJFRWd6V0k836Th6vG/0pICswr6ggCS3Pp
	 U6k/cf7kx0bSB/QJr4UieU0PGZDwlYST0qrG5O3jQnheDVFTplpjsexhcO5KynNAIt
	 vFzUM1kx2OWgmb17zx7n1OjEpn+LHyN+SQCSodpUZ5Q024jb+79u65maN66FLiFP9I
	 RW7dE0h08629w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBD0CCFA1A;
	Mon, 10 Nov 2025 14:26:27 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v2 0/3] ath10k: Introduce a devicetree quirk to skip host
 cap QMI requests
Date: Mon, 10 Nov 2025 15:26:23 +0100
Message-Id: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/2EWkC/x3MQQ6CMBCF4auYrh3SqZaAK+9hXFQYYCJtYVqNC
 eHuNmxe8i3ev6lEwpTU7bQpoS8njqHAnE+qm1wYCbgvVkYbi4ga0psXmGLK0DkPq2cQWoHQ2to
 09OourSrfRWjg39F9PIsHiR7yJOSOGtYatW1sg4DttS4LI2dIFHog73gG5zlXyyf0LPeZg5NYR
 RnVvv8BHXRHebIAAAA=
X-Change-ID: 20251110-skip-host-cam-qmi-req-e155628ebc39
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, Amit Pundir <amit.pundir@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=L3nGmc65cfsV6qiQ+LYogmLlv8XDTxddUlOLJY174z8=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpEfYS7iCjxoLP0PYyTp6kzSTKLNz3Min/kJQM+
 +zutAUqZSOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaRH2EgAKCRBgAj/E00kg
 cmr0D/44yLirU8sAm10sSfdpjaByLaHLJ31fqEwiWiOfg1nSaysGs2tB9VxmWhkb7aBtP1IVBQ0
 lgZDpZQ9MbxExySnG4MRztMmXK0Fta/fA+Ng7VW754pQYzDxBWEUwjdOPsrfXOZ/PfbGdPVkN1W
 L2p3LEgCkB9zBQ0WddnxTRNFKwBrYgySEAk/qjHZeIX/aD25Jr8IpRrGtkMgOstpwkkwhXmxR1y
 ThsRwgeglDN4/PndoiIo01PO/YzUNCASLCgh/WWd4E8QSQuQ7+zPmVOHzjtXxVUKaeiiIzDK3Jh
 zzYIJAnG8m5bash9NwGW9MSpwudewo5lxV+9/wAbk/E9Ol+uHf14Q/jW0xb40yTWLHNJDbtwfEm
 ZXuyjVg2tlKVrZi+hmrI58OkD2VYjuIGm9OH+jdkCwZyAyoKxHE471m/qaZcZ27wB54J68IPr5n
 QuQ744n6lddLMMET0L/jFa82yWBV9vhCouk+WQFX+Wm/1SPedSEMz1NH4ax5Lxeel/I9jX26xnk
 PyCaaQWkAxg5qinGYs+LOLzGNjnfc8ElGRoSJQznPbVtSwZcb62l2U900GSUe7Rhvt+TNDami4j
 Qd79ebuzvzBzMCeylNo4sjsI1PuRrzzifjwYHtPklpa0d9iKG+qRMIHGVEYZWza+5cWDIIx7ZLh
 vvJdMvAfrCGgVAA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

This quirk is used so far for Xiaomi Poco F1.

I'm resending it after ~ 4 years since initial send due to Snapdragon
845 being one of best supported platform for mobile phones running
Linux, so it would be shame to not have shiny support.

I'm very much open to suggestions how to solve this in a different way,
as the original discussion thread got quiet, see
  https://lore.kernel.org/all/b796bfee-b753-479a-a8d6-ba1fe3ee6222@ixit.cz/

There could be other devices in need of this quirk, but if they're not,
we could make it compatible specific quirk.

Until merged, available also at:
  https://gitlab.com/dhxx/linux/-/commits/b4/skip-host-cam-qmi-req

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Amit Pundir (3):
      dt-bindings: wireless: ath10k: Introduce quirk to skip host cap QMI requests
      ath10k: Introduce a devicetree quirk to skip host cap QMI requests
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable ath10k host-cap skip quirk

 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml       |  6 ++++++
 .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi |  2 ++
 drivers/net/wireless/ath/ath10k/qmi.c                       | 13 ++++++++++---
 drivers/net/wireless/ath/ath10k/snoc.c                      |  3 +++
 drivers/net/wireless/ath/ath10k/snoc.h                      |  1 +
 5 files changed, 22 insertions(+), 3 deletions(-)
---
base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
change-id: 20251110-skip-host-cam-qmi-req-e155628ebc39

Best regards,
-- 
David Heidelberg <david@ixit.cz>



