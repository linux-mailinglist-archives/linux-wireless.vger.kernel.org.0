Return-Path: <linux-wireless+bounces-28791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715AC472AA
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43BF94E439D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98AC31327D;
	Mon, 10 Nov 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrM9LKHK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E252307AEA;
	Mon, 10 Nov 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784788; cv=none; b=VMyB3HG/J+NO0v7iUobZyyRwdllAmRWTZhaZMfP8+Mwrm6iT7X5lKJybsJ8t/bMAohgxunGPF3sjjXuscVNTbjAAiAiSNl/84peMJm0GU3IrvwBWLAdVv+vQwU4XmYQdXDFGlBgo+mNSzaP95kigYtbqNTkDXfrW2aMhnxb5U3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784788; c=relaxed/simple;
	bh=ol4yxR65KYgqJh69E3ODmJnCY2Jhd60J7DsO/peauHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIoUj7oAY3GOmQ2+IMTNwxU0bKCGguXfHTY9I+0yyoVlZKfjbByDVr9GeJ+5rA5FE97Ltytr+9fZdB9cqp1JbvuVyk9nSgQ+On7pRHhpI7P5qMolnWMtdcLfx1Phj5OlsBDWoLX5r64TRRTN7OHmtO0dtQeGdFkHdXRi4PSbsEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrM9LKHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0468EC116D0;
	Mon, 10 Nov 2025 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762784788;
	bh=ol4yxR65KYgqJh69E3ODmJnCY2Jhd60J7DsO/peauHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FrM9LKHKnuBj+i3aUkAyAEYuBtc89JcY0jAvgHHOq9LI1u5IFFztidxtc/2DPryRc
	 0X3brVrnZFjuJ9I+8HCXR7zr/7l5lwMJ1xC+LbjJiNJQFy/ZZFyJtZ3adQAA4wqf5Y
	 ePWguUwDGJvXKIsUFtO/gploXoQ/utyqUlBQlmXta0pPQ71FYl9e3eClm+FN34u4Gw
	 vXGWkM8QpwAceaT2oz42rdppnpLoVXYg+qOKiiviyCB2AOugaBE3zhsqx5jC4Zx+wT
	 WuXka+PsgL1WkUrJubyXA5nhxnWikVePgUBHhZ+t3SlRM1uijtr/CrsO9WkRnmcfR6
	 YsDlwrBIsBQIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED67DCCFA13;
	Mon, 10 Nov 2025 14:26:27 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 10 Nov 2025 15:26:24 +0100
Subject: [PATCH v2 1/3] dt-bindings: wireless: ath10k: Introduce quirk to
 skip host cap QMI requests
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-skip-host-cam-qmi-req-v2-1-0daf485a987a@ixit.cz>
References: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
In-Reply-To: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, Amit Pundir <amit.pundir@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=eDK/4tDlTIOnXZQxvVBLLpr0TJmEnv0tcxiF4I9sY4E=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpEfYSfLM7kuds/BZ5AbbeeHF6crfp64r5Gw046
 zUV8PnwV9KJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaRH2EgAKCRBgAj/E00kg
 cjTfD/9EshPGakS5iAT+22AYaa3mUXdiTUXN8PKvCgc3+hZCwvKI4Zijj0/VN2vhn3ZJhmaU4Tq
 7mzRv9Z5VAP2p4+LImDkyXb5H6jGqU/0SlyqwAIA9kNqrFn03CG3sdC8pnPj0KHs+u1S+dFJdOS
 KB4hffPdH98RYUtp7vhDwAQtiFZQt2CoSGrscADWqlAGFQ3bgfOWbha4iQD/PjACPbn1MheIVLn
 CkMZG7Ve9nD9oDJbqFVwTlxQqwne/D7yk9skToP6XafkpGCIdyqCK0hMjpimhZb944MXGkJOKyN
 L7XHGtDEz0LTntEwRe7pgJjMERFmJ2YOBgKPlVcqWBp1edtUlbgF6JdKZPWQ1vUGRZOaxOtU86j
 s6DJGJZInmX273a4Lnw6LCF1TBjgwm4fvOUctg+0m0ZcRomT9tNP8w3IWafmiI+LQ7p1m7uUKlM
 VEXMHv9XpFMTnZB7LhHHdhgZhrj0XfGNowKeczunS+sIlnArvXSuVUbTDx+hL6GjHTl75I7RQaK
 5oPRJZaR2zYi/z9fqfQNemJnqrdcf/gWanc11bdy79WG6OTdBwjcZpJ1sVMg5Zq7vGy3T5uOHz4
 PdG3E8eH94Su9ICXmvy9wK5Fl5jE/QHgOUYQ7u4XXm7ZZ0OXAPt0qe79FC2DwoAtk1SJlj7ro2v
 d6E+GbkHdDCDydw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Amit Pundir <amit.pundir@linaro.org>

Introducing this quirk to skip host capability QMI request for the firmware
versions which do not support this feature.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index f2440d39b7ebc..5120b3589ab57 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -171,6 +171,12 @@ properties:
       Quirk specifying that the firmware expects the 8bit version
       of the host capability QMI request
 
+  qcom,snoc-host-cap-skip-quirk:
+    type: boolean
+    description:
+      Quirk specifying that the firmware wants to skip the host
+      capability QMI request
+
   qcom,xo-cal-data:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:

-- 
2.51.0



