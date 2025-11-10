Return-Path: <linux-wireless+bounces-28789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E6C472B0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13C03A2D43
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF0431283D;
	Mon, 10 Nov 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lceshMQI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E11E13C3F2;
	Mon, 10 Nov 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784788; cv=none; b=si1GPwB3z8To5E/sz7y8bbxFx44tv0D28w/+xNPaNi0pXujNy+F+35BIgmyMH+LhcwypgWgnxE9ANQVbblL10bZmRqWmqxT7bzHRNwr7dqz4Ty2ZfimbdQd3rvOZ4WiuFGBt6V+UWL9ffLtuBpeznUN6ymD+pIWQ4l5d1FonU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784788; c=relaxed/simple;
	bh=OzP+cnO1DQo6uc8qjiAg9VlJqhB1pOHopdiRtbozK7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIj2iRtXXrFyerpjOkxISjGgtea5wwj5p5iv+XMSDEJhTADemW0Sb73T7M/qJUyNOcRITUptztd7l5iTBN8ipj9V+6TDRnYiWJH3TIBVshHMfL6HPKmodJPBSjek0YkBQMmEt6mUk/wsX+8JYbqPnlrkwCkR89REqGjjz4sl20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lceshMQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 265EEC4AF0B;
	Mon, 10 Nov 2025 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762784788;
	bh=OzP+cnO1DQo6uc8qjiAg9VlJqhB1pOHopdiRtbozK7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lceshMQI28qNpBr02YLtSEeKB9gFo8ck0Rsj2aa3Bk5/Y+9zICWK8PaewT7i3IIkS
	 7AF7jU1OfphgeaJh1ZuQ2AC+Pfq4TC/SkbP1RHawnxoaF8UoxmaSd2xTZ8Ybs84ai+
	 69ZNS/QqfLai16I/HdffsFG4+dY2iFZWkbgiASaV5Es4mSxxecHL/eL+AwNr4IQRh1
	 bcsMO9XjMsXxZ//marMZvObRP/T69JliYo3DqRg7wq010lC80gOa2q1/ZsBBjun9Qy
	 2E7SeoLSd9MpQjnRKGlMA1pVJyYqd+amvYDeDFj7lngyVb0KqgOR9M0yRT0KapLw+t
	 GqBJsN527vi3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188A0CD13D2;
	Mon, 10 Nov 2025 14:26:28 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 10 Nov 2025 15:26:26 +0100
Subject: [PATCH v2 3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable
 ath10k host-cap skip quirk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-skip-host-cam-qmi-req-v2-3-0daf485a987a@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=qy5oPva7pVvXCU0lnaBR4INc65V2QzpyRC5geVzLuhk=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpEfYSEyRzkJmvfgAJpvXUzBxVbAyessE/n2pdK
 BpH66Qw9QKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaRH2EgAKCRBgAj/E00kg
 cuppD/9p2jsuLrWlZBehPEygW/swom728kSdtf3yvGUsD0T0LsJjNgjlZJcamWHr4Bq+LpDxGwL
 ERet9rdAVOH8F/8HBztFeOQz0FPcDcazFT2gru/awNWAJTgfCt/iR/lDGI+Tq59VfUTOzQFfWcj
 wn0ybPhxtjfggD/Rrx3Lb3cD+5G/ye+XXrox3BuhdrKozco5K0qqBIxthDsNb/dXHbRNBX8MMDl
 T7EeTMJKbMoWN3WEOrhUAnfgFAFsMNgXBp+LGmn68Pxft3d5822gIl0nYcawSgDHABfcmB1frGk
 LK21JVcx8cuC/Ap9vpxjx3U0+h9jea3utHU/mEE5+9ZUKc93I5SQ+9Qwi8TlIlV8WC7zSNTLeMs
 jKdVwjel7DJi4d3ppS9V3+cRPW6vaANpQHgnK5K27WzNEcMGyC731H4eat4+g/S4QqwhpRzVuCd
 EQxs9bnHztUmYLOvrahgnuvv7yii4tzb/hmmim2VEI3RteCq2DipwHRpVKkgBRHfZLktY8p3zv4
 aAqM4yhMRLtjmCMAGZLM1gQRZ1HdqEgVJk8DNqC5+DATVQpkJAaBcQDYhb1ezAAziBIrp4fWNvs
 9gQ8T3LgXsCNgWlQ+XshICR+/5/Xfr8RCOipx6fDIAKbit4tdvVqnc3/y2C8TlInlHh9wEhMLc8
 r8aH0c4r7KRkbrw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Amit Pundir <amit.pundir@linaro.org>

The WiFi firmware used on Xiaomi PocoPhone F1 (beryllium) phone
doesn't support the host-capability QMI request, hence enable
the skip quirk for this device.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 785006a15e979..a3bfcf56ad3c8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -636,4 +636,6 @@ &wifi {
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
+
+	qcom,snoc-host-cap-skip-quirk;
 };

-- 
2.51.0



